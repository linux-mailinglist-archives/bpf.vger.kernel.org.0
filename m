Return-Path: <bpf+bounces-57128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E40FAA5FF9
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 16:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F471BC58C3
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CE11FDE31;
	Thu,  1 May 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Nz18OdUV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97791EFFB3
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109709; cv=none; b=JXuF+LwdX+uUKwkKfQWu3NFHg8zIu671KxASEMV3Q+OLwORxLKXxiNX8EMo13b50M6JPlicTOalUCqMNDtWajNOzFJ5GOYxJezpH46xHJx9jijRi8QsBD12tB7P03WuAOjrO9AHyxi1BZ3fkSmDG4w3xKK9iqXHcTHGGObw2uDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109709; c=relaxed/simple;
	bh=bsz764YfWE4MRTb/rqiHtlptyqwMLFB4ZEx+pwwq78M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UI8ChG/eokcPy6wSCq1dx+TPf9r5k7Uvk8BMWcFgoSn6TFMak8oDloK2rdvAh79SwBlJn+MyxHEWQZTKZGbFz28Vzar35ZlMMXUpVicJ9KStvha4+Ipn5eWNaGkmyQeMRuYxykrPzBgbaextOpg0F7C08TvwP1yzSJ1fvGp1Ytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Nz18OdUV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a823036so9114165e9.0
        for <bpf@vger.kernel.org>; Thu, 01 May 2025 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746109706; x=1746714506; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=StVEjYMIl6wQyDKAupy/1mKYeucD0OYxvq84SFVjyeE=;
        b=Nz18OdUVPqtfO1CS81ZnZncxcGyeiNFrAzEeWVYMUMZXtJaVFIeU9ypYHo5k9OX9ka
         DH2Vq0YPwxNGy3ry5h0VrD5aUvwG0P5KggRCmQUAmpIurDioH/qiLuhuv9wLpvhps3SF
         q7IWQquVRvqH7uD7oZUkEbG3ZzGJ9gijK+xwPdn8ue4hXSfLmrx/VX7sKi6Pn0ANyKH0
         IznUj/vEXZd+STczZM8JmlO6JWHm/GIdDxp4u0pLkuoudBr3dBdQPrJRY0cudkdfxdPF
         n9r7pAPpEOQLYH7SDhBBjXCz1V/AUDZW2l9Wq5dR6kJQLZja5O1jNxu4m7YUDbGhYX1T
         Is5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109706; x=1746714506;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StVEjYMIl6wQyDKAupy/1mKYeucD0OYxvq84SFVjyeE=;
        b=LScWlZCRFcQTRWSyAIu5JYglcWEXnSjMKW2EQ4VhWtOenRizLJEolwNZdrht0lNrNj
         Ktcngq8cWvf3rJDtjZ4tG6+lKWmbHVaQ5/y4V8e8xIe918S1EcPc/d91UZoZGeMvQ3U4
         hM/dRibYv4aMfj1/U7XOSf5osD+qofFbhbMOUI22LapQFbhltBw2y4uZcbdXb5e2+rsd
         9mGpUSfsoyllHVKxH3ZKYeOStxHQZAmKY9TevF4MIg8+ZHGhe12/nFFjR35FqykOiISW
         Es6XJPLWsZsS/kUewFOh+bJ/ocnAMy2qzheoHy3BTCMf3e61J+eNVRJ6qYjOW6BZtbdI
         ct1A==
X-Forwarded-Encrypted: i=1; AJvYcCW3I4/EAK0XXljCbaaHGgMLdAkRRh/DlmzRrNQ1Rna9c3CjF/0AKzsrgISRpuiIqGEEDSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUv5bI6043VF6W0bKF64jKZnTcpc/3AEW5DdKYHRI3IXJbQU7P
	rVSQ3yjdzdjcuvKkUuwMa2qdAhOagCdsK1wAjXW3Dg9S+chaB2kHXuJlLq4lXtj+qJYTprMKgl7
	m
X-Gm-Gg: ASbGncvbXWwDE/kX5r3dIgkeZIL5FeZki0YPuuJ+2NREQ6Aleomk/krdVLEEcnT/Mnd
	HPDRunz/N1XSccko/9tAGwal3efhFSZfwYoFPzbFHEcZJmdn1O+kEiBKQVtftCPgTFLzJqWb28X
	oti1aOHSCo7lUyntmmDD8I2R2mg2kLJVdT8sE8uE6n2Y72SgBD/VP7Drz5Kz8300pV8U/e9ZE/A
	iLBFoNvWhE9bu0TagqSauNO3BdKgALwVVuI8weSSyl54VMj2YaYQMOdtkMZ4m8SUIe9Nfl64yeF
	QoSvYZfkQ43aVP6anO1DfgboE9g0Veht4nhTj44JadvbeHIefrcxAJQo9qiV54ztj/YGu7UIGfU
	JfgMyWly0ObgrcoKpWvjUIMCzWOwODwMPfH7d
X-Google-Smtp-Source: AGHT+IEPSk+cQIgonsEsIg1aqlii+4w8mjQ/IOfqZ7nsCbNMR2MfqFqMDG1cn5sRDjMY3mVaDu76ig==
X-Received: by 2002:a5d:59af:0:b0:39c:1f11:bb2 with SMTP id ffacd0b85a97d-3a08f761da1mr6037739f8f.22.1746109706055;
        Thu, 01 May 2025 07:28:26 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d15dasm13908445e9.16.2025.05.01.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 07:28:25 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next 0/2] Allow mmap of /sys/kernel/btf/vmlinux
Date: Thu, 01 May 2025 15:28:20 +0100
Message-Id: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASFE2gC/x3MQQqAIBBA0avErBtQwxZdJVqUjTWQJloiRHdPW
 r7F/w8kikwJhuaBSJkTn75Ctg2YffYbIa/VoITSQguJ2R3s74LOzQEVGa37znRkJdQkRLJc/t0
 IS7DoqVwwve8HbY5dLmgAAAA=
X-Change-ID: 20250501-vmlinux-mmap-2ec5563c3ef1
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
With some upcoming changes the library is sitting at 5MiB for a parse.
Most of that memory is simply copying the BTF blob into user space.
By allowing vmlinux BTF to be mmapped read-only into user space I can
cut memory usage by about 75%.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
Lorenz Bauer (2):
      btf: allow mmap of vmlinux btf
      selftests: bpf: add a test for mmapable vmlinux BTF

 include/asm-generic/vmlinux.lds.h                  |  3 +-
 kernel/bpf/sysfs_btf.c                             | 25 ++++++-
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 79 ++++++++++++++++++++++
 3 files changed, 104 insertions(+), 3 deletions(-)
---
base-commit: 38d976c32d85ef12dcd2b8a231196f7049548477
change-id: 20250501-vmlinux-mmap-2ec5563c3ef1

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


