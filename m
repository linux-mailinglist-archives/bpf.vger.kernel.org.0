Return-Path: <bpf+bounces-54297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782CAA672EE
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1781894867
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3620B20A;
	Tue, 18 Mar 2025 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQgtPNPo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71E20AF7E
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298299; cv=none; b=jGtZusreFg54Av/9IDqpHP/JiLMYGlAsLCCCxLHFyneR+VhpeMg+S7JlCegcz9s6dwCx0a+BlcDOxEnf1Qw7h8oPk6Bh9/48yyrZrWi+J3D3JUhlzpsALt6ewbSbyNz8EG12uZtEVRQrg0J+naGl6xPV9kqlgv5RvAFslQqTwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298299; c=relaxed/simple;
	bh=Z9D5OZ7TFXsWdjS+c6h9Qnf9evvPUQ6Qsynw9YQ6sRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QsFot2XGE6eJk2TJhdstQvV7DQ6skuzayOab212xw9B1BwR4rEwnvCT6JfzV60gkrbpDsWT/tyOMkC1EEkUPusihDvtgz+JFPnvSIZMIgNZItG6XrX9CFj1kLOBOfcbebjHmvnXEUgMYMJ2ghHdkkBbxJ28nQ1QM2Teo2Yvas68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQgtPNPo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso5039989a91.2
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 04:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742298297; x=1742903097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UefuxNz7IiBfwsW1AV9o60SGm6COOKLkJ9fZf9SH4s=;
        b=VQgtPNPoMowlLkzhXFo+iYki5vAKXhsIkc7ux64bmfBJXyf4OvhixuWjzRu9v1DmSG
         0qo0ubY6h00lSyko2AJyQh3Gmv8LKRzIB3sSBMOEoiT2SUgLEUfSZShniXxOUo8iva/z
         JUUlHNfjulVCFdoW55a7yDTnjXKeHPeLBWNp6bFHwfrKRx4KmdutMl3S4+15OJeFjw5J
         jtasw+PGtjg4twcurYxOvm4Byk2fZyCbFWtQwuiub+hR8OcMFkZEyxkikpxW4axtL5ek
         QBj+Bjr8QNeXTGSUx23u4AiWtr43XcmvUhA+5jiVF1y0Eds/3PW3cFu9slIkvg+Ekjkl
         PonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742298297; x=1742903097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UefuxNz7IiBfwsW1AV9o60SGm6COOKLkJ9fZf9SH4s=;
        b=KmXtfRbU4LfMMyVBSfeyPjja3nitFXR3s6UtYSyiNJFHxyY3vMbHcD8GW736wkRC0b
         FwNz8diehYCINbuXvbnR3ckYleWjRvA4rq1qyz/J+3VypuP0GNPg6uk14nc4AeEyecXf
         XYUtnhZNxvi3P3wHhFFEc2Tru0V0N0+XtSLXN0B2B8GSwIUBiPeT/OD1CTJmCZzhXDD7
         ZikZigdGBKjl831oyGDU7QcnoG/dzG+A1XzgxPfTnVTYaupAFzyTLbhmD+se8K/GkmCe
         an5Vj8UHAe/wcpFLoy/aHA8avZpea6TVbv2rVZPXkWt82NaWtUcDAvYSwY4dOrXaPoJC
         ghTg==
X-Gm-Message-State: AOJu0Yz5e1EH65LpRfy+56FcOFn0PFB5jbPNBRMkDFpz9qcEfU021h3s
	1rvf5azxhNC18YU9R9z6U+gVYI4BccZOnsHRZxNlyZmIKrnP5arT
X-Gm-Gg: ASbGncubmXvhXCS/gvX2MeJ67z6sJjWSM+kExMydVkoFgOb09z3ig83ijW7Nx1FXOiH
	CsDW43wfBBlB8s7ilxnu9Vbtr0tX1iuEro1udxJAy+r8TvB8YVON0owXVsIwZ2F1pxAb5X+yq/i
	4JmXa1fQ4Jnh0QhJCBRYAkbxlKwUHbMPy2glHe3whKU6Ud8eZSd7bLeMBsw04Nk65h06D5d9Qbo
	qdRgmmf2+8LJfmAsiSMYxERq9kT3bV9hlJQQcOGp8Ih+qqPLTAaVkU2Grwykkvd36xQ20UE4MkX
	QxQBuClocC9bcv1LNieYCVA9dRJfmoAPZM7YyPJ4OBc1UnrRJ5XuD1R736aoalWrKF7EGoOB3g=
	=
X-Google-Smtp-Source: AGHT+IEkNqJt6+69rPv41usgWbox/bs3Bj3ZSkbVFSt+aKFfezAEZuQpJh9BPIv1UGK9vgO/zH/+eg==
X-Received: by 2002:a17:90b:38c3:b0:2ff:692b:b15 with SMTP id 98e67ed59e1d1-301a5b9a2bamr2869051a91.33.1742298296716;
        Tue, 18 Mar 2025 04:44:56 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015353462asm7918551a91.27.2025.03.18.04.44.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 04:44:56 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v5 0/2] bpf: Reject attaching fexit/fmod_ret to __noreturn functions
Date: Tue, 18 Mar 2025 19:44:45 +0800
Message-Id: <20250318114447.75484-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attaching fexit probes to functions marked with __noreturn may lead to
unpredictable behavior. To avoid this, we will reject attaching probes to
such functions. Currently, there is no ideal solution, so we will hardcode
a check for all __noreturn functions.

Once a more robust solution is implemented, this workaround can be removed.

v4->v5:
- Remove unnecessary functions (Alexei)
- Use BTF_ID directly (Alexei)

v3->v4: https://lore.kernel.org/bpf/20250317121735.86515-1-laoar.shao@gmail.com/
- Reject also fmod_ret (Alexei)
- Fix build warnings and remove unnecessary functions (Alexei)

v1->v2: https://lore.kernel.org/bpf/20250223062735.3341-1-laoar.shao@gmail.com/
- keep tools/objtool/noreturns.h as is (Josh)
- Add noreturns.h to objtool/sync-check.sh (Josh)
- Add verbose for the reject and simplify the test case (Song)

v1: https://lore.kernel.org/bpf/20250211023359.1570-1-laoar.shao@gmail.com/

Yafang Shao (2):
  bpf: Reject attaching fexit/fmod_ret to __noreturn functions
  selftests/bpf: Add selftest for attaching fexit to __noreturn
    functions

 kernel/bpf/verifier.c                         | 32 +++++++++++++++++++
 .../bpf/prog_tests/fexit_noreturns.c          |  9 ++++++
 .../selftests/bpf/progs/fexit_noreturns.c     | 15 +++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

-- 
2.43.5


