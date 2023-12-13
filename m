Return-Path: <bpf+bounces-17672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 124BF81145C
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 15:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F911F21433
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEEA2E838;
	Wed, 13 Dec 2023 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9lpHijB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1F2E631
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 14:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F8EC433C7;
	Wed, 13 Dec 2023 14:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702476760;
	bh=ecipoyNjahWNdMuCOVl84PSVApDNIhiU9gCXxwvwFtk=;
	h=From:To:Cc:Subject:Date:From;
	b=t9lpHijBS6YLNxgqwXK5TFmoCTMysFQDmJLP2n73Vs+AN0rzLOvHk5kIzQ+U7eZ2s
	 P3El3mktFXOLLyFUxgJe5i6/411xe581/jYzfy0qCzVlA/rbJcesXZh16vQ5IGOKOa
	 5rFcQKByVBMm7URO4o9JvtZCLLirEvGeGE29qZly9MZ8bOAQwgJ3EhOecv5FvkfrDp
	 GnHTwXrNiXSH83b2oLjHfkwcSTq4TV7BPYyU88yk82T2sOxuoQmxLnqVhcK3SVZT1u
	 E0+6r+rQrt3JpbKyYuqba0HdMMVjISCUz3C8XppB8oYm0whhk5bj2MRBcPgMejCCPQ
	 d8nBZfJerVEqA==
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
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC bpf-next 1/2] bpf: Fail uprobe multi link with negative offset
Date: Wed, 13 Dec 2023 15:12:33 +0100
Message-ID: <20231213141234.1210389-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 774cf476a892..0dbf8d9b3ace 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3397,6 +3397,11 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 			goto error_free;
 		}
 
+		if (uprobes[i].offset < 0) {
+			err = -EINVAL;
+			goto error_free;
+		}
+
 		uprobes[i].link = link;
 
 		if (flags & BPF_F_UPROBE_MULTI_RETURN)
-- 
2.43.0


