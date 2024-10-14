Return-Path: <bpf+bounces-41861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5399C9C2
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 14:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5321C22663
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BBF19F419;
	Mon, 14 Oct 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="KwlBgHTV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2DE19E806
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907925; cv=none; b=P9m9spyg8A0L2bRgMHK/BEf/ue6oR2TK2CpdmSoTIxoKbuOEVq+cC3alAGoEIrMJ87bnjZmTZCNVMJI++xP/dsWFlErceehx9UUGjuDaI987WgEY267zqRKVZOVRPVTicGE4Nit274PXVCJpgGG47Q58f0noGh2Zj0+Uw4vZNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907925; c=relaxed/simple;
	bh=cdvsxftq6OoairQyR8FU6ISgKs5zkUCwikxwwQSU18M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YNF34Jo42WBQVJF92Tgnm+vvhVM8JFWG02tNgPdfk71XV9X/KitQ9JtVjIaZGH6G4NbCyQUkmgr6ONPjbZDo2AVQGBAms8tAM7lkAaZQUIKAh3N4HNLphv+zXtBg9YgPtgZUzgRwPwkJyJ9gB5s6YXB8gQYSM4gzaOrmydqQNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=KwlBgHTV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c97cc83832so1172048a12.0
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1728907921; x=1729512721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YxaJynF0KylsOJUra+CY+ZXssRQQ/gaG7DTSIztuW44=;
        b=KwlBgHTVBlyvOhZXwlHSy5b2hYgxrMLd0Zb8614+2dSF28fCaZ1R8HTl7GZK33mi1F
         inPiYTfyy4uEMba/YSsjrA5uH9jy18wZpO7UF0G4b9RUQJIbIvyhXGgex6ybmyZylwoi
         BJabBfUCZFuDgaCxbFS25kU6nQla/cmnanZ0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728907921; x=1729512721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxaJynF0KylsOJUra+CY+ZXssRQQ/gaG7DTSIztuW44=;
        b=QFH4jEJ1Phe1gzp3KEQKO/xfeQCd/ood9+8MznXcQxwuU459JJUlYI4WZeVKF68sVL
         B6BTMXK8xEedc+/lIpoamtBboFFvmEFk+m6T8uDlUz99bdlIvMH9DfVj+UBgMX7dpS/3
         U58AUfZQhXFWaxh5ysSsqfKDGhzUZ+vdvhrG19s2QAwYTnqH/ecPcTjt+W0HihVNT6RF
         Gr730lROEyXLrIiXr2FN462ye3cQZ2oXcjA1LMBKGQE4xk3oJ0v75FqozG0cxtldw9Z2
         1/BnsIJrb2QMBOhli0uz1kHOs2Kcy4gytCnFq8doa3o+1x53bNjxROvWtmXc/78PYRIz
         Do7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjWjajAR5Glx6ALS7YbTjIoPr7UIhcREMBKj/h2N6mtZwZR9boYLWbwFRIQxS1YaN5oOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznlRlsuJHj9B2BJ3vu+G0iFWDF+foGte032UuK8x6FtBATxGP8
	NKzWkEHGIdS22v9+zL6H2SvUrNbaZtyGNuWLVddcBnuUQnkMxQbZFs9oGloYUtxz8Ebjd2lJYEF
	CZkKxgg==
X-Google-Smtp-Source: AGHT+IFKdUgnHeMazq34ZQy72aigOnHga92imLShe3ApzcRRJgbrWUweyQCsn8PrNuTzzZ6m7QgWPQ==
X-Received: by 2002:a17:907:7ea4:b0:a99:408c:6a16 with SMTP id a640c23a62f3a-a99b9315e79mr916863166b.12.1728907921400;
        Mon, 14 Oct 2024 05:12:01 -0700 (PDT)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a1ac71a7fsm55293666b.15.2024.10.14.05.12.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 05:12:01 -0700 (PDT)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Subject: [PATCH v2 0/3] Fix truncation bug in coerce_reg_to_size_sx and extend selftests.
Date: Mon, 14 Oct 2024 15:11:52 +0300
Message-Id: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses a truncation bug in the eBPF verifier function
coerce_reg_to_size_sx(). The issue was caused by the incorrect ordering
of assignments between 32-bit and 64-bit min/max values, leading to
improper truncation when updating the register state. This issue has been
reported previously by Zac Ecob[1] , but was not followed up on.

The first patch fixes the assignment order in coerce_reg_to_size_sx()
to ensure correct truncation. The subsequent patches add selftests for
coerce_{reg,subreg}_to_size_sx.

Changelog:
	v1 -> v2:
	 - Moved selftests inside the conditional check for cpuv4

[1] (https://lore.kernel.org/bpf/h3qKLDEO6m9nhif0eAQX4fVrqdO0D_OPb0y5HfMK9jBePEKK33wQ3K-bqSVnr0hiZdFZtSJOsbNkcEQGpv_yJk61PAAiO8fUkgMRSO-lB50=@protonmail.com/)

Dimitar Kanaliev (3):
  bpf: Fix truncation bug in coerce_reg_to_size_sx()
  selftests/bpf: Add test for truncation after sign extension in
    coerce_reg_to_size_sx()
  selftests/bpf: Add test for sign extension in
    coerce_subreg_to_size_sx()

 kernel/bpf/verifier.c                         |  8 ++--
 .../selftests/bpf/progs/verifier_movsx.c      | 40 +++++++++++++++++++
 2 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.43.0


