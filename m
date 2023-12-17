Return-Path: <bpf+bounces-18138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8738162AE
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 22:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED9B1F2163D
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117CD495D6;
	Sun, 17 Dec 2023 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNsvqtbN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F049F73
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 21:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A4DC433C7;
	Sun, 17 Dec 2023 21:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702850155;
	bh=nLoZTrMFhnEmFCuLJQgiDs0mLMqm7rS3uh1oojJjvmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aNsvqtbN6kAwnYRlT77Jmuv26iQZgkzg3iDfyOTnfMVcKXGkQfWgZ++dQngDR3Skc
	 q7Q2OAsSwxoez8K9xWY9U4STDKEYWXk+xe+ambQ2EwEDaP2ysAf1ZrLT9tpEk4FQTe
	 8reYSIYn14YmiZj0Uo4UcMzNlDMR5F3ZT8hkfKK4nM0xoddSU2ZGNBnnm+tItAZrmd
	 e44a957U5aMt0+fPg9l65jQx/KxiRVd8DlsRBLw3xDPbXscXKQaNNKvWUgfTSgD5Md
	 sTcEuF9xDcQUMA6WoxHTw1/Fm9y4Ezy2yQE39IoVdWJJDx6sydoHp5TYY7j6ibTQoQ
	 WVNeTzhirKdrA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv2 bpf-next 1/2] bpf: Fail uprobe multi link with negative offset
Date: Sun, 17 Dec 2023 22:55:37 +0100
Message-ID: <20231217215538.3361991-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217215538.3361991-1-jolsa@kernel.org>
References: <20231217215538.3361991-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the __uprobe_register will return 0 (success) when called with
negative offset. The reason is that the call to register_for_each_vma and
then build_map_info won't return error for negative offset. They just won't
do anything - no matching vma is found so there's no registered breakpoint
for the uprobe.

I don't think we can change the behaviour of __uprobe_register and fail
for negative uprobe offset, because apps might depend on that already.

But I think we can still make the change and check for it on bpf multi
link syscall level.

Also moving the __get_user call and check for the offsets to the top of
loop, to fail early without extra __get_user calls for ref_ctr_offset
and cookie arrays.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 97c0c49c40a0..492d60e9c480 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3391,15 +3391,19 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		goto error_free;
 
 	for (i = 0; i < cnt; i++) {
-		if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
+		if (__get_user(uprobes[i].offset, uoffsets + i)) {
 			err = -EFAULT;
 			goto error_free;
 		}
+		if (uprobes[i].offset < 0) {
+			err = -EINVAL;
+			goto error_free;
+		}
 		if (uref_ctr_offsets && __get_user(uprobes[i].ref_ctr_offset, uref_ctr_offsets + i)) {
 			err = -EFAULT;
 			goto error_free;
 		}
-		if (__get_user(uprobes[i].offset, uoffsets + i)) {
+		if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
 			err = -EFAULT;
 			goto error_free;
 		}
-- 
2.43.0


