Return-Path: <bpf+bounces-60657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB38AD9A26
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 07:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694D07A87DA
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 05:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31541BE23F;
	Sat, 14 Jun 2025 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEWHQASM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC822AE8B
	for <bpf@vger.kernel.org>; Sat, 14 Jun 2025 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749877588; cv=none; b=fC/4K3SlcWh35wV2IvCan+Vznxk4BxnbeFq+L16udnpKQQR+xba0EDQ0Us+nmUPrQXjqWIpz2P5aatGvZzG84Abu1joGle3zeR7AR43wWRxH6ZPcSRXNX+nBXYGwRPWb444e6xCdLmrmQ3IK/dC2L/8qFTtoV3rSLnzsxWZ0E8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749877588; c=relaxed/simple;
	bh=LntLIHuNVi0Im7m2EP/vbh9PKJGp0Kxt3oOdPQd9V3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IH9F76Jij2zW9OV6bJm9EXNDHQ+ZGdzlM2JhX7IHq7idTd279bNUz7TP1nkikxomYxoA2mNhzkg1jTq/CZaIVEGZI8yCRybaU044eIBXpbp/KO9/5CifbUDV5dZ66Hr/HA8ep6sPCNORImhrDGcQIBsiWJC30NmIo0FbWjKlNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEWHQASM; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e3e0415a7so27083167b3.0
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 22:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749877586; x=1750482386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpnVtcppRq9GuVzDl6dOTesUuMfqJQFSMF3HA8/couY=;
        b=NEWHQASMgY6Pay7F+zuXilKQQnpGSPU74rkvvP+x7O7jJVzJ/MOLmoj+mdkyqgEpt1
         1BBbjTkT80PufLUACRbRuTOcoMdkP5hQ/WWa7xKpDF+QnUaaI2kQBmYH+28biToqqWa1
         l7gyHWFpI1qJ+KgFFL4HTekNx+ALr1XnoTTAadQQUgyqLvGuSK6VmmQYmGV9mGCutNYO
         eg9MuVxjatNoYDj+6ocQtl5NZWLLrtwBtIc/0pkG0k815mgYUMvc0AjpoEBw1uiu6Wr5
         4dgBXdY+9oGLWt1q/T8hn55vNUJRGKVp2isQK1evnuRt1Gb8hBncuCd3TeVm/Q2uz1kD
         IFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749877586; x=1750482386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpnVtcppRq9GuVzDl6dOTesUuMfqJQFSMF3HA8/couY=;
        b=lnmQbavN8vLx7qawkdBlkl8YGxkHykV6RjBQI897wgJ/tyL/WEoXuzNaGX7PxJxDSO
         lt3Mw4v2sMQhqEBwNhgk7yLcY4L7c7Ojok5GBWE6jPjjjCME9YX3fT11OcCCU3eUD9Jk
         F3ksG9sE2D45hkdqXd2pklyaNgNP4prqqn5UaMkTyKSElGjocR8QuqrjdQyPq+vCKA6O
         Af58S3TCikJWeh/ss7GBE8s8X1oY2aZ5Ang/TzsN0/EOQairj5+JbzQvM8yYoPAuNLEW
         lE44HJA/hySu8sKPv0KgYpeSOtewPkgKffx7mrtxUOxWKzWXEl6E05Z6O9lahnDGal6P
         LmdA==
X-Gm-Message-State: AOJu0YzueCeQ0CwNBtYxGN0dYxqIpiw9ZDU+YG3D/pPHqLiSFRHaKvUR
	SUixceeZ608qJ3HyzaoWfSwyenW2cb7AK3gLtOu22IkgGHXVLNZCkfpZMQ153pkC
X-Gm-Gg: ASbGncsQyjsqjiZG9bd5OrBCHUGgmU5CRdlkAAOXMSPGjobfSH5TdR71725ZWM/hb05
	6AmO/XJq3LYG95yKP1SVf4PLSm52NOi+HXaZyRfpcCpduD09tNKvqfJiK0aMjqdnBP9MBW4hyn9
	H30znwynXtkmhicMyhW+mOx6Lz3cmYxUVIGyE/oDoEM7d33axP0Tf9ABLdPFUtR9qyvwXr7kSSS
	uUBh9UgA8ktd703yS1+ORclLb0W0r/+1fGREwLcIzn1cGTD+OiflihGufNx3deBGWMHmOvEYvvc
	gj/fUg/oMldPtT1Ik8wh//EFwNaqFSXgWj5CjevZLdQoziguATeU
X-Google-Smtp-Source: AGHT+IECQFsP5a6nrHlnpFjuphoKzykCYNPMJgWJvVyKyJs4Emp5JMAyhKQfg1pJ7WLoJ/fnXFDtBQ==
X-Received: by 2002:a05:690c:4b81:b0:70e:3e3d:cfe5 with SMTP id 00721157ae682-711747f9ebdmr34705007b3.4.1749877585933;
        Fri, 13 Jun 2025 22:06:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7115208adf8sm9025907b3.39.2025.06.13.22.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 22:06:25 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	laoar.shao@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH bpf-next v2 0/1] selftests/bpf: more precise cpu_mitigations state detection
Date: Fri, 13 Jun 2025 22:06:16 -0700
Message-ID: <20250614050617.4161083-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kernel executing selftests is configured with spectre mitigations
disabled, verification of unprivileged BPF won't emulate speculative
branches.

A number of selftests relies on speculative branches being visited.
In discussion [1] it was decided not to add additional tests
classification, but to execute unprivileged tests only when
mitigations are enabled.

Current mitigations status detection inspects /proc/cmdline,
which is not sufficient for some configurations.
This patch adds logic to also inspect /proc/config.gz and
/boot/config-$(uname -r).

Changelog:
v1: https://lore.kernel.org/bpf/20250610215221.846484-1-eddyz87@gmail.com/
v1 -> v2:
- added code to visit /boot/config-$(uname -r) (Yafang, Andrii)
- in case if config can't be read, print a warning and disable
  unprivileged tests execution.

[1] https://lore.kernel.org/bpf/20231025031144.5508-1-laoar.shao@gmail.com/

Eduard Zingerman (1):
  selftests/bpf: more precise cpu_mitigations state detection

 tools/testing/selftests/bpf/unpriv_helpers.c | 94 +++++++++++++++++++-
 1 file changed, 91 insertions(+), 3 deletions(-)

-- 
2.47.1


