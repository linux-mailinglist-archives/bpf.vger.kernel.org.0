Return-Path: <bpf+bounces-18137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A3E8162AD
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 22:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C961F2204F
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 21:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEEB495DE;
	Sun, 17 Dec 2023 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM/dfxCO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11FC4B130
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 21:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA54DC433C8;
	Sun, 17 Dec 2023 21:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702850144;
	bh=qLhBVjMmJJSpBuv71uFj5UZ98OWdv9VxqQBtPptJofU=;
	h=From:To:Cc:Subject:Date:From;
	b=EM/dfxCOKIcVjoih9cqmEhhyYXQXawQLTjJ+KktZ9LSkkzGtvba5aLkpfKBeXLXQ1
	 aVXI2e+uWInolDlQX3BFqtka+ONRi/9rBw7tKeyozKRqlxbRu3zGqALFLmtR30jWip
	 i30q4UET1DO8HE6lixru2HUEu98oatuCB0U9y7Z9Rlm+lfLUrRDBFI58GERKFXly0T
	 FTyryMASJ2pBPFyBcGhslcyYFUudKMpbmrIpsk/vcC32o1bJVTU6X6LQMypSGctxVR
	 4ZsWnhJKNngjrSHctUt1ksI2GYgL/+FuUyKcXQf0PiRv/aNclLvMxZi94lFgwXTjDL
	 29wNp+hwEeP4w==
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
Subject: [PATCHv2 bpf-next 0/2] bpf: Add check for negative uprobe multi offset
Date: Sun, 17 Dec 2023 22:55:36 +0100
Message-ID: <20231217215538.3361991-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding the check for negative offset for uprobe multi link.

v2 changes:
- add more failure checks [Alan]
- move the offset retrieval/check up in the loop to be done earlier [Song]

thanks,
jirka

---
Jiri Olsa (2):
      bpf: Fail uprobe multi link with negative offset
      selftests/bpf: Add more uprobe multi fail tests

 kernel/trace/bpf_trace.c                                   |   8 +++--
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 152 insertions(+), 5 deletions(-)

