Return-Path: <bpf+bounces-27989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F048B424D
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC0F1F222C2
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784373A1B9;
	Fri, 26 Apr 2024 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G1m5msKm"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB43BBE6;
	Fri, 26 Apr 2024 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171375; cv=none; b=pwECL0NE6qFeT/JIzPAGe4MPcY/inlKPa4KmOE+PhzonxXEZ9rANTcGmY3kC9gyn+8ctejkZ9B5inkztgjdebprsMTiTfoCPdvNtOV5n6EgYQz9Rv4zN/HfxCtbYN7/WWhwLyN2Q4Ih818zbznqIBk+BUTLfUbmrRwswvShVRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171375; c=relaxed/simple;
	bh=1T9WPb0ShseSt6MCLsMq6ZrJl4sruiRMyFdv22QrfLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rybmZ/MUa9KCBZaSf37kmdWJ0n1dUvRHMocD/HGAxn6pDlk76iCVqxl9CPzzg1lPSSmgsrbj28VzGlJyjxPeF3htYd1QfS1gzv7BkRHftqIFX7whgWCRga5k4p2GlRDfpQTvWrpakQngaPALJWvfJlifjGCXB5jVwNCKgHB2AGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G1m5msKm; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=+DLaccrhT7k3iqNDz0dREoZuUXR57sjg+S8VyePm5mQ=; b=G1m5msKmAfBf9ZNueJ+c/Ji6BO
	Yj6fnJV/s5myjTAETURpRbLGNB7kzaZIbnBth+ttT3hBkdWw5WcPnuAxSUiamGBJ1/OcTsgTW51+L
	D02A5wLJHqdo6aotTVu+Mt/lplr5lyra6A8uZ+cOEwU9Fn4skXDvkmMRuMsK2bFBctngphVpVD3sG
	ygQWk0W3KSXvO4RN8cCSo+FW0rmC60v18VsxF3FEM09YkiLqfHLM5T26y2NqQk+MGVIWqqy+SFU5S
	10rDPC/wfJAkgI7SNeZ+FONEOt2nWa9fl1tHKrIQNAi3/KZPrZYQr8w/mDkdfgWajAIF1JDr34oQg
	s/Kv7d7Q==;
Received: from 19.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.19] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s0UHJ-000EB8-5k; Sat, 27 Apr 2024 00:42:49 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2024-04-26
Date: Sat, 27 Apr 2024 00:42:48 +0200
Message-Id: <20240426224248.26197-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27257/Fri Apr 26 10:25:03 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 12 non-merge commits during the last 22 day(s) which contain
a total of 14 files changed, 168 insertions(+), 72 deletions(-).

The main changes are:

1) Fix BPF_PROBE_MEM in verifier and JIT to skip loads from vsyscall page, from Puranjay Mohan.

2) Fix a crash in XDP with devmap broadcast redirect when the latter map is in process
   of being torn down, from Toke Høiland-Jørgensen.

3) Fix arm64 and riscv64 BPF JITs to properly clear start time for BPF program runtime
   stats, from Xu Kuohai.

4) Fix a sockmap KCSAN-reported data race in sk_psock_skb_ingress_enqueue, from Jason Xing.

5) Fix BPF verifier error message in resolve_pseudo_ldimm64, from Anton Protopopov.

6) Fix missing DEBUG_INFO_BTF_MODULES Kconfig menu item, from Andrii Nakryiko.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Björn Töpel, Breno Leitao, Daniel Borkmann, Hangbin Liu, Ilya 
Leoshkevich, Ivan Babrou, Jesper Dangaard Brouer, John Fastabend, Pu 
Lehui, Russell King (Oracle), Stanislav Fomichev, Vincent Li

----------------------------------------------------------------

The following changes since commit c88b9b4cde17aec34fb9bfaf69f9f72a1c44f511:

  Merge tag 'net-6.9-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-04-04 14:49:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to a86538a2efb826b9a62c7b41e0499948b04aec7d:

  Merge branch 'bpf-prevent-userspace-memory-access' (2024-04-26 09:45:19 -0700)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'bpf-prevent-userspace-memory-access'

Andrii Nakryiko (1):
      bpf, kconfig: Fix DEBUG_INFO_BTF_MODULES Kconfig definition

Anton Protopopov (1):
      bpf: Fix a verifier verbose message

Björn Töpel (1):
      MAINTAINERS: bpf: Add Lehui and Puranjay as riscv64 reviewers

Jason Xing (1):
      bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue

Puranjay Mohan (5):
      MAINTAINERS: Update email address for Puranjay Mohan
      arm32, bpf: Reimplement sign-extension mov instruction
      bpf: verifier: prevent userspace memory access
      bpf, x86: Fix PROBE_MEM runtime load check
      selftests/bpf: Test PROBE_MEM of VSYSCALL_ADDR on x86-64

Toke Høiland-Jørgensen (1):
      xdp: use flags field to disambiguate broadcast redirect

Xu Kuohai (2):
      bpf, arm64: Fix incorrect runtime stats
      riscv, bpf: Fix incorrect runtime stats

 .mailmap                                           |  1 +
 MAINTAINERS                                        |  8 +--
 arch/arm/net/bpf_jit_32.c                          | 56 ++++++++++++++-----
 arch/arm64/net/bpf_jit_comp.c                      |  6 +--
 arch/riscv/net/bpf_jit_comp64.c                    |  6 +--
 arch/x86/net/bpf_jit_comp.c                        | 63 +++++++++++-----------
 include/linux/filter.h                             |  1 +
 include/linux/skmsg.h                              |  2 +
 kernel/bpf/core.c                                  |  9 ++++
 kernel/bpf/verifier.c                              | 33 +++++++++++-
 lib/Kconfig.debug                                  |  5 +-
 net/core/filter.c                                  | 42 +++++++++++----
 net/core/skmsg.c                                   |  5 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  3 ++
 14 files changed, 168 insertions(+), 72 deletions(-)

