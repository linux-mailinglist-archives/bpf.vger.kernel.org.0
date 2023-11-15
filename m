Return-Path: <bpf+bounces-15132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BA67ED637
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 22:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76DFCB20BD6
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 21:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8374D43AAF;
	Wed, 15 Nov 2023 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA+hDQeu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95543E1;
	Wed, 15 Nov 2023 13:49:54 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b3e13fc1f7so91919b6e.0;
        Wed, 15 Nov 2023 13:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700084994; x=1700689794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/mwaERQ3SwmBrI38ngnf3Sqr/Nx6mt0Sl6+BMU0ILU4=;
        b=GA+hDQeuqeD4JgVEETFLb607gnypVVz26gC0a8EYe4XHjmH7IJeq7znV7JdO0CToCr
         lhojdDagvOBIUbks9MP9duvUZOPDwm9zPdgB6k3G/YSEjBevJYnxxRFzF6cDjGVMb5QZ
         sxyjgm6ZZt3VzWpgcm3QZBmQk7E2SlL1jhT1NHHrRMsEsMo6HMyU9/IIzJHiq9AEczUk
         Xwb/w/NbEYifRm1Acxettzx0ZD68RlxVEZn88yppx9o2ieWzsUvDBU5S+PioX9hP6n5q
         LLvos2yz7CUnDN00GTqOWCYBFNLfxB599MfDEQLnpqCGqtpH7THmUMy3RpdnCarl1GFu
         1Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700084994; x=1700689794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mwaERQ3SwmBrI38ngnf3Sqr/Nx6mt0Sl6+BMU0ILU4=;
        b=Jm+DnhwavYl9WbvG2u4mlTxr0+brPahB/WxHf2JD33JhiFn1YCy+9+Cwd1+BnbMsIG
         v/3JSbRaFro/jJVjcIZJUtOIDBGaUZ81Wk17fBAxMKG5rCL9e6dhVd2sZjxuJJtksriu
         A8n4XfUsogXkSukUpm5JlZlhGYvMPpTO023c6vFl5uwOGHpdbrOTnIInrMfjqYH1gNN8
         AVlSqrEVb4rbjUR7QXvd+ljwYDo4UWq/NNzPeNvUSBOWBFTCiDSDDkJuVR1PlGdz545c
         R3+78VHyUed35dEf0wpUj6quAAQI0Gr2GNBew68c2oXTJHlu9uwPnODVEgndBG2zTScb
         YHJg==
X-Gm-Message-State: AOJu0YwjuCBi/NgEFNMB1UuYadJzUsxT7QV9xLicNxMDRR8Io6y4hLNU
	LP3jEcWShNKlHn+5ym0UDqo=
X-Google-Smtp-Source: AGHT+IGN/DZMh28EybqJsKqiSuMABTnc0NCP3BZUHgseuo2lzHBa/VpDdttCWXpspGPeXiBYt5RV9A==
X-Received: by 2002:a05:6358:e99:b0:16b:fa63:4f44 with SMTP id 25-20020a0563580e9900b0016bfa634f44mr6054764rwg.10.1700084991699;
        Wed, 15 Nov 2023 13:49:51 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c091:400::5:54b4])
        by smtp.gmail.com with ESMTPSA id z14-20020ac86b8e000000b0041977932fc6sm3845666qts.18.2023.11.15.13.49.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Nov 2023 13:49:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: pull-request: bpf 2023-11-15
Date: Wed, 15 Nov 2023 13:49:49 -0800
Message-Id: <20231115214949.48854-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 7 non-merge commits during the last 6 day(s) which contain
a total of 9 files changed, 200 insertions(+), 49 deletions(-).

The main changes are:

1) Do not allocate bpf specific percpu memory unconditionally, from Yonghong.

2) Fix precision backtracking instruction iteration, from Andrii.

3) Fix control flow graph checking, from Andrii.

4) Fix xskxceiver selftest build, from Anders.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Eduard Zingerman, Hao Sun, Hou Tao

----------------------------------------------------------------

The following changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:

  Merge tag 'net-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-09 17:09:35 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 1fda5bb66ad8fb24ecb3858e61a13a6548428898:

  bpf: Do not allocate percpu memory at init stage (2023-11-15 07:51:06 -0800)

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'bpf-control-flow-graph-and-precision-backtrack-fixes'

Anders Roxell (1):
      selftests: bpf: xskxceiver: ksft_print_msg: fix format type error

Andrii Nakryiko (5):
      bpf: handle ldimm64 properly in check_cfg()
      bpf: fix precision backtracking instruction iteration
      selftests/bpf: add edge case backtracking logic test
      bpf: fix control-flow graph checking in privileged mode
      selftests/bpf: add more test cases for check_cfg()

Yonghong Song (1):
      bpf: Do not allocate percpu memory at init stage

 include/linux/bpf.h                                | 10 ++-
 kernel/bpf/core.c                                  |  8 +-
 kernel/bpf/verifier.c                              | 87 ++++++++++++++++------
 tools/testing/selftests/bpf/progs/verifier_cfg.c   | 62 +++++++++++++++
 .../testing/selftests/bpf/progs/verifier_loops1.c  |  9 ++-
 .../selftests/bpf/progs/verifier_precision.c       | 40 ++++++++++
 tools/testing/selftests/bpf/verifier/calls.c       |  6 +-
 tools/testing/selftests/bpf/verifier/ld_imm64.c    |  8 +-
 tools/testing/selftests/bpf/xskxceiver.c           | 19 +++--
 9 files changed, 200 insertions(+), 49 deletions(-)

