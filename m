Return-Path: <bpf+bounces-27578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642FD8AF6B3
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 20:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AE61C25002
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C31411F4;
	Tue, 23 Apr 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWPXojsQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB951CD39;
	Tue, 23 Apr 2024 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897352; cv=none; b=YPeHD3QzM9+B2DVhUTiQ5L4UD95jiJhCdWtlgORD3usvBnocoB8YyfVXukU4Fy5tpQUV353VasMNY2VgDDYrWWzYu/6NDeLt0QJctYg5iwkx4uu77NOvzdKJvd0gYcVvOWG1m/F9vvlVzDq38ZyaZ4Qz3VhDjep5HgH7xJoX0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897352; c=relaxed/simple;
	bh=A9kl23EsvQ6kaKUQLbImSrG/li398yeuoAjfSa/5KKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2IxSoNOibESf7TGnVyyh8pFQZvOpb7Hu6Qzc8gAbzBLJK8Qf9UzTVDw8bGCcSsmX9TdomhG8436Pg9s7rxF0mvwuI0bwp1LXnjKSqLbRLx8yynovYwpdkf0UMqAEcWIptablgsaGUcZtYo5f5pTneBXg/U8AHVXotIFZqdYgDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWPXojsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479FDC116B1;
	Tue, 23 Apr 2024 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713897351;
	bh=A9kl23EsvQ6kaKUQLbImSrG/li398yeuoAjfSa/5KKw=;
	h=From:To:Cc:Subject:Date:From;
	b=OWPXojsQiiPgzip4QhxTGkCStbRfes6h9Vxub1M4Rn/JixqMSRzKBMP3nzfWZznzp
	 Dkb+GHZc2nWXNZtUEC9k7xWtzMydVhWzJ39vzM+I85SiDEHO2hnKHVvmPme4dT1vcV
	 zF5tONxhsZZSOTgeWwD2xtVDLKAqLfqkwYwZ7RQ1jaeNVyvOYhbe7iF8t1hi5g3N1X
	 M1eHQW35AT08xiIC2Ic73Hcj86b4FJZ+haxvc2qfUhIXIph2iPdBjcyEaiQMvYsoqu
	 0PvtvS5HmGYt+r1iZmrFFeGQGCKfGDF8teiYx/TDL4tC+d4Zt8oWlwlUstj8YiHueM
	 Ungqee6wW2jzg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] selftests: net: extract BPF building logic from the Makefile
Date: Tue, 23 Apr 2024 11:35:40 -0700
Message-ID: <20240423183542.3807234-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has been sitting in my tree for a while. I will soon add YNL/libynl
support for networking selftests. This prompted a small cleanup of
the selftest makefile for net/. We don't want to be piling logic
for each library in there. YNL will get its own .mk file which can
be included. Do the same for the BPF building section, already.

No funcional changes here, just a code move and small rename.

Jakub Kicinski (2):
  selftests: net: name bpf objects consistently and simplify Makefile
  selftests: net: extract BPF building logic from the Makefile

 tools/testing/selftests/net/Makefile          | 60 +------------------
 tools/testing/selftests/net/bpf.mk            | 53 ++++++++++++++++
 .../net/{nat6to4.c => nat6to4.bpf.c}          |  0
 tools/testing/selftests/net/udpgro.sh         |  2 +-
 tools/testing/selftests/net/udpgro_bench.sh   |  2 +-
 tools/testing/selftests/net/udpgro_frglist.sh |  8 +--
 tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
 tools/testing/selftests/net/veth.sh           |  2 +-
 .../net/{xdp_dummy.c => xdp_dummy.bpf.c}      |  0
 9 files changed, 64 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/net/bpf.mk
 rename tools/testing/selftests/net/{nat6to4.c => nat6to4.bpf.c} (100%)
 rename tools/testing/selftests/net/{xdp_dummy.c => xdp_dummy.bpf.c} (100%)

-- 
2.44.0


