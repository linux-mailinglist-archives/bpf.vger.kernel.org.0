Return-Path: <bpf+bounces-76740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4430ACC4BE2
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 134D53059596
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77322337686;
	Tue, 16 Dec 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcwSQ73F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6B337B8A
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906647; cv=none; b=Zx2RLvJ82ioBiRdNTmn+pV9+kmONZoLNAC5EuhCjmvrTDbmYCyOCDAU3NtrAVbrNyVd1wMPk/7OFCEE6ZMRKh580sIZ7mImdmTjlFB/M+W3MIUDmTZBgURLZa5ZqLMFbj7Rcu9+oMcijRKggCjnqsku2p6WyCXlZROLuSlIihO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906647; c=relaxed/simple;
	bh=MJyTk49qQ51yGfo3Is/GLV+08CyR4vObYZ8zXkA2AnI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=d0Q9jppdvsUzGhqBiTnTUZ7VtsKGeCMLhy/Z1NvGpzgGCxXS0tJNa36PWomCrxo3AAOT2eigvnVb9QHzhggzjxXlVRUBJPPR4VGIz4bIqgRkKV/kj7t5VzVB9UFNXQIwgphXIHGhaoAJdG0hnmAj2AYx3vbrELH7tqw7cUmSvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcwSQ73F; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4f1899960f0so51265661cf.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765906645; x=1766511445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MJyTk49qQ51yGfo3Is/GLV+08CyR4vObYZ8zXkA2AnI=;
        b=mcwSQ73FpdCsyaaKtuETn37SD4FZto2pQHe7kpn07bhxD0D5VfwNem7OaYwApBG0Qr
         Fq6jb0EOZofGDS8HgQzUVleb2IY3YkbGVTrm/QGp8aVyLmKNFFRe6ENMyiYMI1nhq3MK
         PJJYCyIy3ToOd/5hp5ZquLyIHYK2iyXih1FJ0iF1SVBxXcSPlj8vNeadPSIJuR3QAS9w
         14V9cwdSnPH3uxyB/Va14O+vhwnWQGL+Oeh3Dh7+/oPL246mtHYo5KzQes3i3/R4IryV
         /Cr/OEggaeqaY5Usne9FWIWuLCYPLK7FOkgT84E3kf0l3cG7NuyI7X3ZFAegjKvczGCt
         y4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906645; x=1766511445;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJyTk49qQ51yGfo3Is/GLV+08CyR4vObYZ8zXkA2AnI=;
        b=doSBQgyvnL+GCxcdoNRceBb/CLL0rQEHK54lHfJm+Ob9HCBNwaB40n5sHK6fDR91y0
         QhxdEs/PoZ9w5szkt7/V1nTMT4c6inpITOSEntEmyxO76c2R3pVu8Y+iSZrEzGFfQAtr
         IbBi+qwDvg+dYt1r5+x2fK5Zec+a/QLq/MELtyrR2n6hfJp8mZgOQxKyFGTQdXvGLFKr
         YZlRxqSX3jfRLR3Ujr4M80UWoNn8faWEV5IbbtBkkMWFYxBHEKx5auFYeSgi9vX7HGuN
         nNXanRRLLvR6gobDU2h+wRNlXzJEo4b3vtt+QzDHRdoBqq1B7ECLee9N+DRIp5I5jFmA
         zR6w==
X-Forwarded-Encrypted: i=1; AJvYcCWbc174h5qc3hjwVf1WGcHZecGG/w+nE4dki8RSqxO77kTXRYEKrsDqBVEtIFaDXwxat6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkk/aRxP0DTr6ZDcgk6L0fc+qRlQhuW4qt1Qkp1d3CKERokd6
	kwRJZN2lwviUV7Vu/znlxyQ11sZzkjAMjxtaVMn4iZ1bm0CJ4CW8qoz4A6AVcAQ2VMDMqXsolGY
	PDn6LAhb/ElSxzN92WF8v2bafr+LaTWQ=
X-Gm-Gg: AY/fxX7V4eEGLPADafSZnu0GTKHdeYUx1nh130t0WXvzeN8gqKwo/o7umTaVmtZCymg
	i2R5D7rIa6u3oBQL5OYAFbL7gd3AWYWovRU9ciqfhLDLouiE0GI4aQbzPvVNMZRslSn8Z9d24OM
	LQb5wDXBn1onN2HNhcPDTV3PF7JKDuPMCNCJhXE69fABic+b+Sg6kgA6lOUYvBYJx2dTx70V22R
	1GbtdipM1USVoeyUmCF/fGjVx/I0kowtaGKGB/QlaHHC7rkvV1dKK6gECMLOBl4XugUeVeT
X-Google-Smtp-Source: AGHT+IHWNTNcPs2oFOZ9gpnmgUPL7ItQR8XFnZ5lar/ptwvKsSwNIt9TeT/RrvxqAFMZ+qV3LVFY8rcJ4jGnNtSaK4o=
X-Received: by 2002:a05:622a:1e8e:b0:4ed:b441:d866 with SMTP id
 d75a77b69052e-4f1d05fcb76mr205460621cf.65.1765906644581; Tue, 16 Dec 2025
 09:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cb m <mcb2720838051@gmail.com>
Date: Wed, 17 Dec 2025 01:37:13 +0800
X-Gm-Features: AQt7F2pCFS0Q6wgiH1NCE0m5Q63maT0o7tLDEnILtTrz_SYxMpdzyeIVcoHTrLs
Message-ID: <CAO3QcbiQqPpnCQFPcJYFf1O+-vJR9rUTHKdYwJJ+BMhviXKgFQ@mail.gmail.com>
Subject: Re: [RFC] Rust implementation of BPF verifier
To: alexei.starovoitov@gmail.com
Cc: rust-for-linux@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Alexei,

First of all, it is truly an honor to receive a response from you.
As the co-creator of eBPF and one of the most respected figures in
the Linux kernel community, your work has been a great source of
inspiration for me. I have learned so much from studying the BPF
subsystem and your contributions to the kernel.

Thank you for taking the time to review my RFC.

I completely understand and respect your decision. I am just a
sophomore student who became interested in BPF and Rust, and this
project was born out of pure curiosity and passion for learning.
I realize I have so much more to learn, and receiving feedback
from someone of your expertise is itself a valuable experience.

If it would not be too much trouble, I would be very grateful if
you could share any specific concerns or reasons behind your
decision. Understanding your perspective would be invaluable for
my learning and would help me improve my approach for any future
contributions to the kernel community.

Regardless of the outcome, I am grateful for this opportunity to
engage with the community. I will continue to study and improve,
and I hope to contribute meaningfully to the kernel someday.

Thank you again for your time and guidance.

With sincere respect,
MCB-SMART-BOY

