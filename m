Return-Path: <bpf+bounces-48625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0937A0A322
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 11:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2E916B619
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C50191F6C;
	Sat, 11 Jan 2025 10:55:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF514E2C2
	for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592910; cv=none; b=sIlGibXAEfzCRP9hgaLCi+69kIeSfTPUv4VuS9vp/CvOv6mkAfv7mPRIrtQwVuNhM1fFgrcfhElUACmfNS4avuKJ8jwVJRT4a+5vaMH83EZwh88JFIla6KZ7EfBsAVo7/pkEUl6ar7BvcXDhyakWHaIwuYeHFg5dxVXk0F2xwtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592910; c=relaxed/simple;
	bh=vhaF4vvXYMF90mavjnRx5oO9t58FYkg4sdLWbykOods=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EyZAmDu4VwsPXiUkP23i0qA9ses19pbH/4hJ0ufPMqIR5kmIm7dqa/yBQzGFGyObYaXYlSsdRFn28L0BM/PSoyXew9jUY1WQaVYUd4ElvXjTotehnNuIGtFuS2ucyHIQUuYCm6+oo7rSd4wOngjVJp1Q0OcVQzV7m9KSOrAe74k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=6wind.com; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so26954061fa.1
        for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 02:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736592907; x=1737197707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p27IAMSMQtEIk9uZPy0vH4i7GFnyx+g3esP8cUpmJ6M=;
        b=Wy4gA9zXwW6yQd+JtYLvveiI6KHwXexQQ4IFsOKXaMHOTkHHZthgpJ4uqyxKNtyNEb
         kmsv45wLeEWDZ409D2VH7/+jkhffteS9ZsM+foMaXf63cWHJxpTLayaTmEhzlTbjeLDZ
         j72g5c/tEsPBJqIDyOA2ZexR4jM9Gj8hd1WdlVSqOIDYMpFILENGS7wXSgeiCGxqIRPB
         oPbTftJ7QVubsRCRWTObN0TKFIHpj2fzZ2KB2xCj+nYQnBxONR3eThqWzEVmxkpkdvTU
         CfnAL9Efqz4eeG+SuWPGT0CNLnro62zlHlDRFZlsCJHRLHuOrw2EG7VbbJUajRhK53AA
         SpPA==
X-Gm-Message-State: AOJu0YwB8Wk1nT5pZNt9lis5TQeAFtr11oV1dRyQS3ywTKWJQ6XEzl0o
	qCcKF9Q41wC3ivoPQYHb3rcYquO43gokWi4VXl0hehuhc53G2T4VPcjMOpP3/mTEFp/Izh26qOu
	zBsAPHwW/fQSBe77T53iSha4iqweukK32
X-Gm-Gg: ASbGncvtQahZfhS1fQyicbLzA65t4KLdG6Z9kqollIWtAlmxkcBCUDn1qP9BG1Hu0Ti
	1TaMWfdOxhjIw00uvUb3RG9t2BeaY+t1WbXVLZbP7eVq4xckwMXhi2ZO0R2i+ymFyKT2GkaTPey
	rWa1h5Hf8sDDFAuN8dhyB8EwdlWN0wnfvSCnbCGeLR1Qt/3aOGK+RJKBE7yIbvacpEkrk59/sgi
	PLWujkKQpEnfW2BN8iDOfnHInDkR3UCFiFuM1FvHmmmF0AGmf/GeDrxer/b9DQsbhea1PkDIE0h
	JgqHswoKTOtLYRCHxpkIe5LcFw==
X-Google-Smtp-Source: AGHT+IEXBnnPiwReejWW192eh/FaqLC7XRV8g365r3Z39yVlUM1soJ4kHwSrovHg24/6c4eI6kqtpJ2KFnAF
X-Received: by 2002:a05:6512:401b:b0:540:20eb:80c5 with SMTP id 2adb3069b0e04-542848166b8mr4586686e87.37.1736592906908;
        Sat, 11 Jan 2025 02:55:06 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5428bea6ba6sm188623e87.128.2025.01.11.02.55.06;
        Sat, 11 Jan 2025 02:55:06 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
	by smtpservice.6wind.com (Postfix) with ESMTP id 7A4E213486;
	Sat, 11 Jan 2025 11:55:06 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: bpf@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 0/1] net/core: kernel/bpf: Remove unused values
Date: Sat, 11 Jan 2025 11:54:44 +0100
Message-Id: <20250111105445.3830433-1-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch addresses Coverity IDs 1497121 & 1496886.

Thank you,

Ariel Otilibili (1):
  net/core: kernel/bpf: Remove unused values

 kernel/bpf/hashtab.c      | 1 -
 net/core/bpf_sk_storage.c | 1 -
 2 files changed, 2 deletions(-)

-- 
2.30.2


