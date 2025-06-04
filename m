Return-Path: <bpf+bounces-59639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA8ACE0BC
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF5B1641D3
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA40290DA2;
	Wed,  4 Jun 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atKDwHQV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8A286D4E;
	Wed,  4 Jun 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048629; cv=none; b=gmJ7ttQ/CEt6vlECfQltMpkeXIotoBwoxWjjPWn443pjyssuzKo2/1t+zsDApXYlrzftUJa/W1ful2MfymgAHrk3FAZyy353XIpZYt7V1182zqA7sjBrxVoxirOGPH9qBHMfcbIchY+lB1bS1zAXv30Go62iuOT8AnQ4kKJLMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048629; c=relaxed/simple;
	bh=lN0q7V8NXkjGQu029desiefHUwy+WczFqbl+rAq+1OU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sb1bG/ooGVa5oMBqE8KfplOFuzvRWwLdxZBWY2497ko4+rX6c4XdUF2yzNgy3t8EpJmseL3qCjCJcPsFbGNmrHJPAqdqf3eFQRYRCXh9WqVm9QURJ7LQoc1wUqGyjwoqQE29QXL1JpPuW5ZjOuPFzquG5X0LiDI4m7mL1cS3zDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atKDwHQV; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso788994241.0;
        Wed, 04 Jun 2025 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749048626; x=1749653426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lN0q7V8NXkjGQu029desiefHUwy+WczFqbl+rAq+1OU=;
        b=atKDwHQV1atHKhhP0ix70naPI2R8q3AymGMpt5JTEUlzuxQTYIIbFupZQJ9P6Xucd8
         BTOwBSxu6dWT0G7RaHEyfEsyNPxNIOd4i++ObjL+BGPGlYActiQFAk2sIFoqycDabxU6
         MPKw2e0jv0ldYnG+p+1dLwro9oPsNyCc4dYweljqyntOSQgvFeFxhtXoo5pAc1qLVN9M
         wdl2N2+WCgs38YYXjqaJfhzffuptAuAVpWj0pOVRQRcGN5va7Bhq9HoYfYDHWHdyalU1
         Xqw/AGBGc3cfhpZF2UXR6F7XoIrjqMlcuO+4bHmPKfwIRpAFb13D22RkmTaO5PuDOX8k
         CvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749048626; x=1749653426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN0q7V8NXkjGQu029desiefHUwy+WczFqbl+rAq+1OU=;
        b=BqJ0IruPVKcTddNpGgPLbsE8zkQSH/cAFlqt9W/b49y2h0R5+g4lV7uBAY34VU/IpJ
         9177jzV62oYoDA0gHDMYLBQNfM6NC//ZHlhGNP72z25hqrqN0Sm1XThXd0xLKH/jciQ4
         ZlKGQD+IGIOPHPduPVBUixgMSJ8nvRBqwuxuTqp9BKOZ/qXW4yrwM9b7BbJcFFAqPCx5
         1WzSKCDALG8yDJRLNGN5wDnq+jdMxEnSbgE056NrraJB+Ws1EGFolLQa92BYxyU3bNmm
         HVo0UX0JRV/HohyzvMngVtXFvSfI3t3q3+9UnHeoM+zpaHNw+AWxXhKtDIfFdjfiY8uU
         xPTA==
X-Forwarded-Encrypted: i=1; AJvYcCXihZ6h5ZnNQPj67FssbQqOj3p21Zc3dywZTk0NQ10asSJJA5F7m4XR373LiSpfyCACnWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pdnNTBi1zy1occuG0w+6BTLdA5gz5Lpa3hxp8Aen/eYP3ioD
	RXvPJHdDs5CfPpsmTn5OnEc0vvGEn4SiF229lK7qxKMGj6HIUAXkhz6vHz/K9PGHoWEiEI/X/jF
	DumN/AuV3WReDKVQIG5GoKHwnUxiuxYUKzHwm6VE=
X-Gm-Gg: ASbGncs4XJJC6r45CbObWK3fP9zNcXfGLu6kDslcey5dSRqYe9/3w+jTXzWLKt1OfTa
	Cf3r+1LwZllTeR6ecnYLfZCiC0ZGfQ2Irf/9wpb7tXwnBmT9PQOAe2cFPByT+g1RBzKQSGhvT2u
	cUQPXBMKDHw8t5wDqevur14bPfzQra7Tf/
X-Google-Smtp-Source: AGHT+IHPzqTpkVNsJ+Kupb5X/KoVrEn8d0VHcraqMYvZx6zcN9aKiCfoMbzh+hlnCxEhsuXYB6Uef+rbAH0LhMsgiyQ=
X-Received: by 2002:a05:6102:5790:b0:4e2:86e8:3188 with SMTP id
 ada2fe7eead31-4e74500629cmr2660283137.0.1749048626551; Wed, 04 Jun 2025
 07:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alban Crequy <alban.crequy@gmail.com>
Date: Wed, 4 Jun 2025 16:50:15 +0200
X-Gm-Features: AX0GCFt4Yh0CeLSmxc-39z7ZDpauiYM_8Y_xzo0tlTy6imi9ZMRYgfTryeGV5zQ
Message-ID: <CAMXgnP4nfgJ+gEvXLummspjRegsZsQ=e5Q8GFAONb2yCxVZLnA@mail.gmail.com>
Subject: Loading custom BPF programs at early boot (initrd)
To: linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Yucong Sun <fallentree@fb.com>, mauriciovasquezbernal@gmail.com, 
	albancrequy@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I=E2=80=99m looking to load and attach a BPF program at early boot, that is
before the rootfs is mounted in read-write mode. This is for tracing
I/O operations on disk.

Without BPF, this can be done with a kernel module and then use Dracut
+ dkms to update the initrd. But I am looking to avoid custom kernel
modules and I would like to have a solution with BPF working on most
Linux distros without too much maintenance work for each distro.

I=E2=80=99ve noticed the bpf_preload module, but from the discussion below,=
 I
gather that it does not allow to load custom bpf modules:
https://github.com/torvalds/linux/tree/master/kernel/bpf/preload
https://lwn.net/Articles/889466/

Do you know of prior-art or recommendation how to do this correctly,
and hopefully without a custom kernel module?

Best regards,
Alban

