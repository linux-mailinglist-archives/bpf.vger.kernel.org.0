Return-Path: <bpf+bounces-20830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D184437C
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B62284A51
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 15:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69133129A8D;
	Wed, 31 Jan 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmM6/UsR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98079128369
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716580; cv=none; b=Ozh0oU+bAHm79kA7JO2nE3nFmyy5uv9Mtjf9y34HD0iQVWmgynTWZmLHGMm1gn55Fu8ZUdsajVBMGQiJ/eXgsXq3L0tWag/DmjNgB0ylKf1yjPOLwXWPwTIXyvb0Bi+Y3AjE2S6f0aB75HutYf5BdFspITyH/FbM8NO0ULTD9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716580; c=relaxed/simple;
	bh=pImADInx/+VN237+FUhfbZiAwf7H5rgapiDueUNrNJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzVBR5xJQOV83cK7QRBxLLMzR59F34Ak8CgDweG08SuJbCrbFg1TaClfCbkVi4PSydW2NU/PvPKfKEPUMUORmNpH5oFneBGzo4MEGdN3jxVLHh7VYOeVDABvDMa55Uo4aZ0P6Ht3ukkqxArGQJZUmXyoIugFFtXNaJVRwwIuCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmM6/UsR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ddc5faeb7fso4039048b3a.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716577; x=1707321377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AfdB9iuAQyvE9o/e+hGpFDwr5pL2ipLZOeJ86lP0lo0=;
        b=NmM6/UsRZXvjGLDuKr2eYFPM9k7MC5RvwOy5dCh2Q39IGWByvw/a67o9k3TRMgxOqS
         8LHIrHl1tadAcRnz58VI1r4SCcilmMzv93oQ7WNPpxqb01ytN1ate0sYx5PyBNPIFFzb
         6T9/jssJvm6EhkBkzmHLlwpjkZhgtTre0XHC98chD1qRCj2qY1AXD01mgEMkHtAW2zYi
         Qzaz3rFxGQxY+m5xgFIpiNfuOTRueKl8TcwLiO2YUY1hSaJ4IPJDrS7gaSDghFGaQQng
         ebyn8R24aIBPKLvsBl9OjlEUXwSvN87iHEPHn6x5tQ9ShVaHPpWfl6K8s91RjU4NaHN/
         f+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716577; x=1707321377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfdB9iuAQyvE9o/e+hGpFDwr5pL2ipLZOeJ86lP0lo0=;
        b=YJpkIkherenZFm2Bze8VASEFrSae95C4DPe4Da9xofe47hCzS044iGRl/TOFO5LZKI
         wTAj3g17dHkv9c7Z0Y+7tsl4mh/aUWUpliK2FxODUppgMi8SSQxE/DLmzWIeuV9w0yFm
         rDfHhGcji27kW7ldAowHHhy3SAUprGQjrmXj725P+8Tm+zzaK+6Xw8uCAnccJquymEv9
         Yr69FcyvY4VxfVJH639XiIHr9Zq99sjSwzCKUUQacGmE2jUESXR4uZAU3zCSvjbaRyp0
         pB+33IsPbFpqnov6H5T8skL2Rb/3z8OPVebHYax+PoNO6DTkr/3kaOWC0WoF6IbiMSWB
         nuig==
X-Gm-Message-State: AOJu0Yz8qotFBGdoARVOb1SCX56BVuqyez/sJa/hXFrXGw/AYGzEHpO8
	siiCZPnud3nuuVUqD4kk5nLRdlBb5OC6LSVBdZ/UMUVwHAEvGhWxZ1XpS63p
X-Google-Smtp-Source: AGHT+IHFMb5wiU1Mj6wLWOsaqwBjHvF058Mo1hUmPkyvwx5BnohN3Zalk1Jo4+VDzaslRHLWvdPH+A==
X-Received: by 2002:a05:6a00:2d91:b0:6de:10a1:35c1 with SMTP id fb17-20020a056a002d9100b006de10a135c1mr2370973pfb.5.1706716577281;
        Wed, 31 Jan 2024 07:56:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVf6znpl2zYIH4/6Ls0PytXF/UmHl4PHpw9T9t+FaAI+ump94iHsfpreGweZ8BkgZbIGmhseiKQZhJIa+CHKWlnUjH2nNjSDI4GJEK9ACRiRa7GCYOhEfzQyW34C28hQG5zJL8C5ci64b0BI78=
Received: from localhost.localdomain (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006ddc2cf3662sm10073450pfu.184.2024.01.31.07.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:56:16 -0800 (PST)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	Leon Hwang <hffilwlqm@gmail.com>
Subject: [RFC PATCH bpf-next 0/2] bpf: Add generic kfunc bpf_ffs64()
Date: Wed, 31 Jan 2024 23:56:05 +0800
Message-ID: <20240131155607.51157-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces a new generic kfunc bpf_ffs64(). This kfunc
allows bpf to reuse kernel's __ffs64() function to improve ffs
performance in bpf.

In patch "bpf: Add generic kfunc bpf_ffs64()", there is some data to
confirm that this kfunc is able to save around 10ns for every time on
"Intel(R) Xeon(R) Silver 4116 CPU @ 2.10GHz" CPU server, by comparing
with bpf-implemented __ffs64().

However, it will be better when convert this kfunc to "rep bsf" in
JIT on x86, which is able to avoid a call. But, I haven't figure out the
way.

Leon Hwang (2):
  bpf: Add generic kfunc bpf_ffs64()
  selftests/bpf: Add testcases for generic kfunc bpf_ffs64()

 kernel/bpf/helpers.c                          |  7 +++
 .../testing/selftests/bpf/prog_tests/bitops.c | 54 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bitops.c    | 21 ++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bitops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bitops.c


base-commit: c5809f0c308111adbcdbf95462a72fa79eb267d1
-- 
2.42.1


