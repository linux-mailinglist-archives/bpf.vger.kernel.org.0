Return-Path: <bpf+bounces-75496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD56C86C9C
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31D264E9FED
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63907334C15;
	Tue, 25 Nov 2025 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ou4yP+cP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCD29E11D
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098408; cv=none; b=ZjH/u1Ldm1340HgLx79B/wcTdC8sUtBL3Z7p2Q/vdAZxtzsAxUpacwlzYivnBnigCqK5TlQRkc3+Rqom4eAaKkykxyPwR+IxVwsJrKLk3CKm8I6e7liFY7DRnR4H+G4gfMA753KOIYQH8P36kJ5Cs1ZIsYI4RHqrIBXJ2YfJqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098408; c=relaxed/simple;
	bh=weoF253YS0RDYDNFjzSDJ5tIChF4WqxAAq+yZqEKh9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NgbHXjNe9TyZ4py5p912wCYrrjAtPmt2+IGbPVK53l9GsK2fhMFoMpfj8ZLlNUJpci5/JbBoCgXSp0W4FAGz868hr1G+DU7dI0pXsx8CQXNwawyDc3z+242GEdg8r3OWMhWja21suofEcpY1quOewT/TIcK2+A2Uaw2FJL4VhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ou4yP+cP; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-948c58fe8c2so232405539f.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 11:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764098406; x=1764703206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wynpj+E5fG2Oh1abG+WZEscR5HBvHm5298AKLCuUClg=;
        b=Ou4yP+cPskomYMeVdRXei3aGe4CA8qWru7OsQP6BwdThf2GaArI8DOmVuUTM/9jgv8
         7yfb3c/0JmSqRsVHmB9X6Phme2s4crzBqQXAGysf6khbNn9GegUtUQKxVlcAy26vQYp6
         kl4sPUIwsjVQr7ahV4j/Ysgjpa1LobItHW3YSAHaxTCkylGkOFUf13dApdSBcuce3quJ
         ddfICYEQhhFNAtAxjqjafE/HQviesUSIZ0VFAkfuiWwoW2sMZmGf6ATN89T2oU4YONDk
         y6k1rY57h3ydl5s0+qPDswY0JwxaJs8RBzn4/NiEMU3SkXxLKVYxTQp/dmil0NkNCP06
         IxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764098406; x=1764703206;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wynpj+E5fG2Oh1abG+WZEscR5HBvHm5298AKLCuUClg=;
        b=B5nTmhfNMdYVXn6LMDk7uGPzhBmjMpxi6pEjU34tceB7YUed8qI7wdvb4K9axrLSOz
         nYeIOnrS5eS0II53CKt+pYLpDO5L/4tdxmU9my/hLlgjyliGONmTuFrHJVm2gkr/90E6
         pU/jjEmtegctHIElzM3eue2ahCyGZUX3QRiV1WWceY36iScrY8jEw+1siWAu/F4AKzNM
         TxHbNz73Y2r4b+zGx8fBoNnYVki2wHYmeBfErrwl8WoUBHDNde53LXI87SlJaQyMGGno
         UCUurWCmOzqnOa1Ns47FRaQQg3XqxhUoDBTKtzy285YOmgBS0Q2lcjSVw5j6uaV3OsYo
         l//g==
X-Forwarded-Encrypted: i=1; AJvYcCWc6+NT69K1uWnvQ0XDeftqsz24IYBOBn0ovVNEltFfSuTuRZjiFHrGRpqa15MJDWivDD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgQF+6qCChJLICqH317WMbq+oYxW2v22+meF4ngDTkz/Mrl2y
	i7gBZeeTAnerazDket1aaJkm8UHfj2awkh0wy3UHq59UF7bjIJeS2FSeU7ZZ6X3j7NI=
X-Gm-Gg: ASbGncvBZ3w9yVPNKUyM4FD3Qfzte/dILR9E0ufs0lyyK2Cg2ejmFqOT8UUUFaRxd1t
	RgN95wWIR+73YuZFl6Ny0OsM3UetcAK6nGXatb/1IIyTwvoLZYHZr7pTzxCAkytskuoCpIkwlBS
	r58/VOzQBTrdMzxERpPh2Rzsk753YrnwenbVK2UsUHtT05bc7lnpAfiN8lz8j7qEt0FIaiPaf63
	JC9xdmPa3fipiR1OQIghythaOovWDWCz484fEHn4qjE//EXydhRfCMfjVAo/zIn6zxURReTYF+H
	qLpgR/zeoNOnDLB8CbqSCsDxODVeYCfZO9OCk82dCRk0t3fjTz/QOq5+r6tvU6Rp/LbFGivyyas
	z5Gv6jrVydKKqv821eLgyWIR0W1HbBiT26FVkQSWhDqohbnS/J7ONC9YoJqogSvpUWygkD7E9GQ
	ggIQ==
X-Google-Smtp-Source: AGHT+IEoSNUPWsr6TkiMj1VyTgtSM+H2mYKN8PQqct0sy21hTM0OQb7u5ZARk6n0QLi/CE7kBBB/xg==
X-Received: by 2002:a05:6602:690d:b0:948:a32b:b6c4 with SMTP id ca18e2360f4ac-949473eb047mr1023076839f.3.1764098406436;
        Tue, 25 Nov 2025 11:20:06 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949385c2405sm668551239f.6.2025.11.25.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 11:20:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
 song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, 
 kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org, 
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
Subject: Re: (subset) [PATCH V3 0/6] block: ignore __blkdev_issue_discard()
 ret value
Message-Id: <176409840493.40095.8097031483064544929.b4-ty@kernel.dk>
Date: Tue, 25 Nov 2025 12:20:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 24 Nov 2025 15:48:00 -0800, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() only returns value 0, that makes post call
> error checking code dead. This patch series revmoes this dead code at
> all the call sites and adjust the callers.
> 
> Please note that it doesn't change the return type of the function from
> int to void in this series, it will be done once this series gets merged
> smoothly.
> 
> [...]

Applied, thanks!

[1/6] block: ignore discard return value
      (no commit info)

Best regards,
-- 
Jens Axboe




