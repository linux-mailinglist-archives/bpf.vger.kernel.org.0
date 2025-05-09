Return-Path: <bpf+bounces-57859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D916AAB18D4
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D3B5247A1
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37B22E3FD;
	Fri,  9 May 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNrR1p77"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4A21B9CE;
	Fri,  9 May 2025 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804948; cv=none; b=s6cLPz1c9F0mQNgCPVfJmklW/hh/xoJVbRWPVpJvhAiD8m5NX0qw5oVOM2KbgtfJPS8w6FpGSDMezeT6Ri0dKq/Vy0onC2wfa2ETWKqpMIrA2Iipa2ONIlBAj628VVnCl678NWEvKHJdrcv2O77kUjQij3x0buJnUcHgiG8WZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804948; c=relaxed/simple;
	bh=WED+U0og4n1pWlHE7/mRpnZjg78tmmAnOvhGMNoOyQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrPzHrZYFclrvFE11EyWBPjcZ3SPkLuH0gHQp+3Ib+e94hk1jXDLMKeeTshKcV+9KAUeTzxm8P8w0H4v4jHJo94G3oIh+iFANkBMX3jZ5ZhismrxwKvL5LPKuANxsHGynGhI1xe6AiaVr9QEPlGz50npbjm+0QJoBqFKorarFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNrR1p77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084ECC4CEED;
	Fri,  9 May 2025 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746804947;
	bh=WED+U0og4n1pWlHE7/mRpnZjg78tmmAnOvhGMNoOyQ0=;
	h=From:To:Cc:Subject:Date:From;
	b=jNrR1p77t1XFr5fWb4nb1IRsJ6RD3WYdmdA7YJhjBSs58ej0HRafQR6fcLiZyaY70
	 JG3IQ7boPFTtvddClOemzMj1wfQqs6JYmQ9zEeuzHtGdqP0x6+VNNjQc0KtVi9cP3+
	 ETjCF7NpEfhKlFTTsTW4s9ZSlEZqezgNPPfC8TplBy051Ak1b2w/zU3Odr8xpKm3Yv
	 Qy+mvzcRQS+r8VRlE8RAKUFq/v6r/mDUry4mMYTTTmIg7dPIkRmViDhdtAXy/p7aAh
	 OUapD2RCHS6tWgzU9H47qP7fU6i8lN6bWLywUjD71JESeJgz9dSa24KBAcgkYUeSWp
	 2e8lXxGHeNLpw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCHv2 bpf-next 0/3] bpf: Retrieve ref_ctr_offset from uprobe perf link
Date: Fri,  9 May 2025 17:35:36 +0200
Message-ID: <20250509153539.779599-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding ref_ctr_offset retrieval for uprobe perf link info.

v2 changes:
  - display ref_ctr_offset as hex number [Andrii]
  - added acks

thanks,
jirka


---
Jiri Olsa (3):
      bpf: Add support to retrieve ref_ctr_offset for uprobe perf link
      selftests/bpf: Add link info test for ref_ctr_offset retrieval
      bpftool: Display ref_ctr_offset for uprobe link info

 include/uapi/linux/bpf.h                                |  1 +
 kernel/bpf/syscall.c                                    |  5 +++--
 kernel/trace/trace_uprobe.c                             |  2 +-
 tools/bpf/bpftool/link.c                                |  3 +++
 tools/include/uapi/linux/bpf.h                          |  1 +
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 18 ++++++++++++++++--
 6 files changed, 25 insertions(+), 5 deletions(-)

