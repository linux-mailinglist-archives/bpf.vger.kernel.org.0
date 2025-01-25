Return-Path: <bpf+bounces-49757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE49A1C095
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 04:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05511671B6
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0ED142903;
	Sat, 25 Jan 2025 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJnyUd4n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC2481B3
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737774405; cv=none; b=rS5UZJ4ZmVa/c+UmNcH3K/hMn3LDAWq9Q1ZR+1IdlqYrjdhd8DAVJ8qtvebCu62IGYs8jcfnbAL71zwGsgExG/Jy96desNIwsHxu1fvV+Mym04NY19CapOif31A/JWRbAG8RfQ64iyn7Ek4pPk3SokX01BczwBlFUEYBvm51RmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737774405; c=relaxed/simple;
	bh=yJe9qcpSg/xTkbUY2DAMomwUVCBkXDxbj2QX016keik=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=snKXUAMc4BVa7Hgbfac/LGn3Qowcv5QDw8+fElyrSV34xFJrozFfua1Hv/KHIaW2LndhWjTwjLhMREayjSartxjlmaazd61rC2UDlN1JfPlQ3SZOrRjBTzhIAM3IFuWmvWfuSQiTlPOQmcJ/NWrKTU4V6jIYY5OkJXIvTXtQ6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJnyUd4n; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afdf8520c2so872860137.2
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 19:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737774402; x=1738379202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yJe9qcpSg/xTkbUY2DAMomwUVCBkXDxbj2QX016keik=;
        b=OJnyUd4nGBnSmDkYl24FkMUQZI37vbFKyubINZ4se4F0VqvXI1kCuzlCdrfbELxjjd
         BkYVI65AFQth3sUgtbnc9zpENryuHM4+z1kqW4UlY2hAYCu9oYpgB4sBA7otlYCC/gkE
         v8aPa5LGvCYs3YUyXMGc+NvYS/vNflD9WPXMfO/PDhh/9CqErRkmDgPnjsvXdXSHY1tn
         liPDYVQJaBBcv0Oc2yNzyj24/aQ3vljJYKgPSOxKcBxiIgwfuEvsNFhrIzNElvoN1Ufs
         oYQzqsQipDlHAc4ABeanBVcdkEQB8ACuR/MVTwMbpu7wIUtj7GFFkH1VFt2b3xa4EHMl
         +74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737774402; x=1738379202;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJe9qcpSg/xTkbUY2DAMomwUVCBkXDxbj2QX016keik=;
        b=hFwvLS0I2SNkhPA58NeazJZH71yveC2SmXCTCUxJOEYx0WeIpDZDz6vRWCLKZvpYHr
         aXLD24PzcaWLPsI27dAZ/EZYq7cDGt/6OFh8yllVdY/GuLb3gaiNnDROyHhQ5AiextvV
         y8t32jTXWG/SkVqxJYP7mz7210oZ5q/lgEoLzDOjZwgWT96AmtTUvTX/W836bYDy3pQr
         jCTOAESOmn8xH23QFNuU3VeAOxsND7fVjBuXqIic2Wc9o1a8EbYhd2QZ38AWda03wY73
         p51HyMIxOTeJiHEssZvLzinkU1wF9/6JFaJJYNM3xXySMshgu/rjgmUgQgcov+eYXJSD
         iJZQ==
X-Gm-Message-State: AOJu0YxlT9AwWfuq6Sw3w2Ksvoo1trLERfVloVsBo+B5XVSa03fwbab4
	z7yDay7ggn/zm+SS8Cyg6fgaEQf0hFXQgwd4keZnJZvRv3gTXVS4oEHcrAe4ZS1QIIv5ZJrYFgD
	IA9fDCMQ1mGnL3496s2Z7i9eX399AvmHQ
X-Gm-Gg: ASbGncsYtBMph6S27ACrPywd2/6bn+KLLW9xfpGYyHW75pK6Mfs3S4jyUlj3wo6OLsj
	MZfOOrX3+b8KURnTp2kSOK8G7zbAV68sxNj5cpdpnpvSGkl2oFIDJa7a+nvLwv1z4WGz7uQJSJo
	X20kbQB9lmEx1iY8LTfrQ=
X-Google-Smtp-Source: AGHT+IEfUE/5iv+HrhTPlGlXrDPzUt+rL1+KHucZloWgXIds8RTZDRI+4S774U9KmGC1w5qakb+3GRVzUPWuLEI7oe8=
X-Received: by 2002:a05:6102:1611:b0:4b2:cc94:1e61 with SMTP id
 ada2fe7eead31-4b690b8b719mr31274683137.2.1737774402256; Fri, 24 Jan 2025
 19:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 24 Jan 2025 19:06:31 -0800
X-Gm-Features: AWEUYZmNUWximZcBE8A8Ku42-q6mpeQc0QZHtEtwmXXJgXxdQHUHOPrTtkRXTPk
Message-ID: <CAM_iQpXiQQ8Pv03ubsfq0=2h0XQ7xLAVDvhWFZjt-7M2OqxhhA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Two-Phase eBPF Program Signing
To: lsf-pc@lists.linux-foundation.org
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The naive approach to signing eBPF programs faces a critical
limitation: programs undergo mandatory modifications by libbpf before
kernel loading, which invalidates conventional signatures. We present
Two-Phase Signing, a solution that implements sequential verification
aligned with the eBPF program lifecycle.

Our approach establishes a baseline signature during initial
compilation, followed by a secondary signature that encompasses both
the modified program and initial signature. This creates a verifiable
chain of trust while accommodating essential libbpf modifications such
as relocations and map file descriptor updates. This approach enables
precise failure diagnosis by distinguishing between compromised
original programs and unauthorized post-compilation modifications.

The Two-Phase Signing method balances security with practicality,
allowing necessary binary modifications while maintaining integrity
verification throughout the program's lifecycle. This approach
provides granular audit capabilities and clear identification of
potential security breaches in the signing chain.

We invite discussion on the implications, trade-offs, and potential
improvements of this approach for securing eBPF programs in production
environments, particularly focusing on practical impact and
integration challenges with existing eBPF frameworks.

Thanks!

