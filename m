Return-Path: <bpf+bounces-74655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC1FC60C39
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 23:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AB13B8CCB
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 22:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D000248F51;
	Sat, 15 Nov 2025 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MZPopNpZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA322D4D3
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763247380; cv=none; b=lDExwDyz5oMh4YqJ7lTv9Nyq4GE30JZlIui4Oot5V0CAnowYQewdQ7eCJ772KrRNirVKjsesyVWvHEb4eifqTG74a5ANCslfo+7oGcSUfNPXU9+PhXuYkGQeE7VxPC+CG0tzOIOvzR+kQWuamVTbSpV3huQTcPAbgVW8/wHi47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763247380; c=relaxed/simple;
	bh=ZhDzn/ld47q1+0vFmkFchwNH42k0db3ClRj5pV+jfV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6sf7FzpQnWN6O62wZ9RuNWmg+q1aLdmV0mf3R7TSQVTZLwCI1zrY3pfyntaFmxz+tjNjJ2myGzFG5ob8+Id0MkyP90k1puL+Iynq0AeeC+cFVor1iF7kOFDtllNt3z3d2u021S02xLsAv2byXHs6kntHTzn/NtyiSVkP0ggsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MZPopNpZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47790b080e4so8408605e9.3
        for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 14:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763247375; x=1763852175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3rirvFwtgiK9myBJO3SkNaL50zpazm5MLi6a9zIWYCw=;
        b=MZPopNpZzadmpHCL0H0pk8QdvR0x9qh7J8QjRDObDzmAXGbotY/+mpASNfGOYkCtba
         ws7FQmfKh6d/RLrkvjPaakb94nxGnIfvG5qyrIMVD0pA5lgeAjM9aC3B3QhfPbDCZC7A
         ngPz1Ms/I+v1PosaLwH6uZLsA02ehSnC4Izct8wN6JPmlDZqRzb+3U5dBFp3Xb0dsuqV
         dLAx5ADxY8Q9GaCxJUBJCC2bo4QQ13rB8y5rTuq6XQNiAXdwBfiPVSjg+WsrwwxF6NIs
         smfzKyBeRNmLhfKEafVBPt13ZO9rXyJi18ldRRXUrCSETer11xOLbGmDX67eoQg5LtUr
         HhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763247375; x=1763852175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rirvFwtgiK9myBJO3SkNaL50zpazm5MLi6a9zIWYCw=;
        b=fTu5345yiDP6Mb35rhdMi7nkdn0fbey82zhooaD17+mZh5iIG9KeMC3wyKe3uYLRJr
         sYIhuLUY6PWv7AbeGGgkf22fTvvcPu/rCx8WJBzECK8ADahNDSTlUBz477cx4Gr2+PZ2
         8HSwHSsya4NlLan1buqzGRmaSIryP5HIrfWdSH7k9bbD9+v+GKsuVmwB2dUdQJeGQKRt
         6GKUEjWu/LljxMwJtY865lDC4hNY7faxmJ7wvpAM9UtIzVsWJlcqE2trZUOgyXWlLeCL
         ogEQ+AcXj7gmgm+7CKshbOf7NyiMDLUa94DRmlfARW+znuB9E5M/vyPYCO9pwRN0AySi
         3v6w==
X-Gm-Message-State: AOJu0YzK2qy7Q1BVpZujrLgCUEd48js4SB1I9uu8auW+mA3OowaCUFzp
	BwuEJ0pB4pQPZI2V8Jvq7c9Wm/Wu/VtoZT/WAGK9Ffd3bizwc3ffXdU+CZbUxJNwWcerrCGEHHi
	M8BdJ
X-Gm-Gg: ASbGnculaR9h5Xi1tV+gz6DKkefyLCvCOnnBkLyMRHJDMlytomgMgpRITaXRWOQFRjz
	YVgO+FbHdfSTWAN9cMklS3iOFTZ7mIMgTdhfSG22vgTNTRsciUaet/2h9qlyp7EKGVJFRmlgNoc
	Ex1n13V68ljd5pobdtONyt8NA38omHZWVEdcEMSJX2xe1zM41tsf9aFK9iReXyMgQ3JRdM5e2AU
	BaKeQbYMPuRBzqpw/GEjXyt6tH9Y1EoqSeqSqBltwc0nB9knZoYom3o0W9/Z/6hR6d/8tgR0orS
	2Jr93KM/rdMxWHQmPQg/eT51TOoQYTgbSdECg3/uCeMdJm6kiUOcHfCjhar2fnhNzFv1FvBU2lF
	kQpLpaizSbSd7QXgTvUJWKeXpTE5bNLSrHCI5BdZ5enYoIwTOwzRYqQc6UByy1c/ubnl1S/uMY2
	RKNsIQN+WoY+xgfFUNBa9u9MNqWh8+Ke+tsC0mims=
X-Google-Smtp-Source: AGHT+IFhHfehJmL/emYJozkeYLpGysI2URRv7p229WqUqyuhzY90JVFZqHeviqUdYwHL55ENJIkf2w==
X-Received: by 2002:a05:600c:1382:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-4778fea3098mr56506515e9.25.1763247375256;
        Sat, 15 Nov 2025 14:56:15 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba1462c605sm6641971b3a.21.2025.11.15.14.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 14:56:14 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev
Subject: [bpf-next v1 0/5] selftests/bpf: networking test cleanups and build fix
Date: Sun, 16 Nov 2025 07:55:35 +0900
Message-ID: <20251115225550.1086693-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors several networking-related BPF selftests and fixes
a toolchain propagation issue in runqslower.

The first four patches simplify networking selftests by removing custom
IPv4/IPv6 address wrappers, migrating to sockaddr_storage, dropping
duplicated TCP helpers, and replacing open-coded congestion-control
string checks with bpf_strncmp(). These changes reduce duplication and
improve consistency without altering test behavior.

The final patch fixes a build issue where the runqslower sub-make does
not inherit the LLVM toolchain selected for the main selftests build.
By forwarding CLANG and LLVM_STRIP, the intended toolchain will be used
for the nested build.

Hoyeon Lee (5):
  selftests/bpf: use sockaddr_storage instead of addr_port in
    cls_redirect test
  selftests/bpf: use sockaddr_storage instead of sa46 in
    select_reuseport test
  selftests/bpf: move common TCP helpers into bpf_tracing_net.h
  selftests/bpf: replace TCP CC string comparisons with bpf_strncmp
  selftests/bpf: propagate LLVM toolchain to runqslower build

 tools/testing/selftests/bpf/Makefile          |  1 +
 .../selftests/bpf/prog_tests/cls_redirect.c   | 95 ++++++-------------
 .../bpf/prog_tests/select_reuseport.c         | 67 ++++++-------
 .../selftests/bpf/progs/bpf_cc_cubic.c        |  9 --
 tools/testing/selftests/bpf/progs/bpf_cubic.c |  7 --
 tools/testing/selftests/bpf/progs/bpf_dctcp.c |  6 --
 .../selftests/bpf/progs/bpf_iter_setsockopt.c | 17 +---
 .../selftests/bpf/progs/bpf_tracing_net.h     | 11 +++
 .../selftests/bpf/progs/connect4_prog.c       | 21 ++--
 .../bpf/progs/tcp_ca_write_sk_pacing.c        |  2 -
 tools/testing/selftests/lib.mk                |  1 +
 11 files changed, 87 insertions(+), 150 deletions(-)

-- 
2.51.1


