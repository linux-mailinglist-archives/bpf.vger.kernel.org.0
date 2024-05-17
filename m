Return-Path: <bpf+bounces-29888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 320088C7F1A
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAEE8B210CB
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 00:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3CB63E;
	Fri, 17 May 2024 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oT8Wm9LU"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E0385;
	Fri, 17 May 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715904987; cv=none; b=oUQMwyiRstpkTdqYT+S25lMurYJdbMGC2Q48FbFrClCg2lAou/UbOl6JPev0ldD5YKYapO1DPoa2Sj2ppUKZR5vTo9tmouTcjV1o7h7+UY/2CZMUPUzqSYjrK7Hlpe1944VvrBUsiVQzRzTCaKlCwiSLqqv9BUeBxGjjnKiksGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715904987; c=relaxed/simple;
	bh=KPTNk01La2c+Nq6kI+my/Qd3z3kXLPZ2eRrPuqO2HnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ECXU1dJ7R+mskKYQPgLrFwzXGTRWqRHPiB9UEGOOvZa5/CuqR1ZxdDSJNfHXhOhhoaOKoxj8TqajYdMAyRUd1/Q3++UcOGBvlJ2ODednvzl69i3+btvQ917516uKAMHvO8Kr/0OM64TOxGEuYARDF68clAaP/UNRoVBHFsVTwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oT8Wm9LU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=u2UNA34byzvinVOp9Sbk1TEfnCR4hPi98pRKE/U16lQ=; b=oT8Wm9LUUvB/j7wKApfnS+ZwC2
	DO5b/VI14qt+EIWwLk2GnAZkltxjG24oNYwm2jtFO8dLV0rnjlBs2qegdEoajE/xdioTSPObrJ9c4
	j/Uk+TEp5Bg3yUNvSyP225GRSjDq036oIcvkxy5g0DqfMIChdbHLmL5sxFuN3Vqs5o6P9Itblw7TU
	F5O9PNN7xTzCKWlOEMsaV2TNA1RoJuqM/OfOnrEj3xuGH/mNfVxz7NSk83rJqrIUfYvMMqC/du5KC
	RfHRlQEVQzLF7jNUTuwHkiUGLpx8wlLTK11CH+AQgBpG5AQUAb8tkDJZmuWmTORCKeBXiT+UM3II6
	MNDaDmKw==;
Received: from mob-194-230-160-35.cgn.sunrise.net ([194.230.160.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s7lGe-000P5d-VF; Fri, 17 May 2024 02:16:15 +0200
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
Subject: pull-request: bpf 2024-05-17
Date: Fri, 17 May 2024 02:16:00 +0200
Message-Id: <20240517001600.23703-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27277/Thu May 16 10:25:03 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 7 non-merge commits during the last 2 day(s) which contain
a total of 8 files changed, 20 insertions(+), 9 deletions(-).

The main changes are:

1) Fix KASAN slab-out-of-bounds in percpu_array_map_gen_lookup and add
   BPF selftests to cover this case, from Andrii Nakryiko.
   (Report https://lore.kernel.org/bpf/20240514231155.1004295-1-kuba@kernel.org/)

2) Fix two BPF selftests to adjust for kernel changes after fast-forwarding
   Linus' tree to make BPF CI all green again, from Martin KaFai Lau.

3) Fix libbpf feature detectors when using token_fd by adjusting the
   attribute size for memset to cover the former, also from Andrii Nakryiko.

4) Fix the description of 'src' in ALU instructions for the BPF ISA
   standardization doc, from Puranjay Mohan.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alan Maguire, Daniel Borkmann, Dave Thaler, Jakub Kicinski, Kumar 
Kartikeya Dwivedi, Zi Shen Lim

----------------------------------------------------------------

The following changes since commit 621cde16e49b3ecf7d59a8106a20aaebfb4a59a9:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2024-05-15 07:30:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 51e2b8d33199df9675d2a36ec6aad0c27e91c6fe:

  selftests/bpf: Adjust btf_dump test to reflect recent change in file_operations (2024-05-17 01:50:11 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Andrii Nakryiko (3):
      libbpf: fix feature detectors when using token_fd
      bpf: save extended inner map info for percpu array maps as well
      selftests/bpf: add more variations of map-in-map situations

Martin KaFai Lau (2):
      selftests/bpf: Adjust test_access_variable_array after a kernel function name change
      selftests/bpf: Adjust btf_dump test to reflect recent change in file_operations

Puranjay Mohan (2):
      bpf, docs: Fix the description of 'src' in ALU instructions
      MAINTAINERS: Update ARM64 BPF JIT maintainer

 Documentation/bpf/standardization/instruction-set.rst          |  5 +++--
 MAINTAINERS                                                    |  2 +-
 kernel/bpf/map_in_map.c                                        |  4 ++--
 tools/lib/bpf/bpf.c                                            |  2 +-
 tools/lib/bpf/features.c                                       |  2 +-
 tools/testing/selftests/bpf/prog_tests/btf_dump.c              |  2 +-
 tools/testing/selftests/bpf/progs/map_kptr.c                   | 10 ++++++++++
 tools/testing/selftests/bpf/progs/test_access_variable_array.c |  2 +-
 8 files changed, 20 insertions(+), 9 deletions(-)

