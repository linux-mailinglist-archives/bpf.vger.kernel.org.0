Return-Path: <bpf+bounces-62277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F948AF742E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826091C20991
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BFD299930;
	Thu,  3 Jul 2025 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kckCnfCM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F82021D3F8
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545923; cv=none; b=rsSHRvuDThQof45j9DtH3C8o4NSjTqysgqhdoLVp/ndsMosOzj/MDoBZusLHojro+c6bqbw/7HebZEM9Hdp/vNbECDlNSSs0QRNCjqSoie2Kh30dlsGtwus2Kehhy4vIHcbPHNSEojiqxdtoRbx2geT5ELEsL0miwqxbPIJhxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545923; c=relaxed/simple;
	bh=S4J99fobTBLE1mv7fNytEpG9fmSZtcD/mHmVfzYtlyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMSUYWzhtpqHY2MwpUOW3kohcY6da0K7GQm2+UWpxsYUzrCaDh9s6rEMNM+dQ4EOSHMfW7oClPtw/qjRA2ZeK8WXkBXrX2+IEMqrXBuzi48MGqQ1X2SKl6qhAFloAGAwKOvvP0yMzfFwfpDw1td+uIrhI8zWuknFCobOLymPiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kckCnfCM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4067ac8f6cdso3949361b6e.2
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545921; x=1752150721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQhKbDgttLDPzwjksoiTuICCO43hP51+1t35DHSJJzk=;
        b=kckCnfCMo5WwqV3HXUYdFQJJNmvjjSKNpH4hFo9Tg2BgmKiWx7qYk38zBMKbdGOEK9
         wUvt3B70pqMs5aWpq/XrbRapQSE4PjLOQ7JXVJ/S9lOtkUMgZ+jA4qr9LvKZc2ftgd1Y
         C9LF5l3Z46zJdW4WYUHnmA9DTIQAgVU29Gc9ieVodfVantMWV8LwBGTt6dDSHR3Ddwzh
         e1T+saK6tUrSiFJeTBmpJrfp6guEsaKxC1+ig6WO2u4Eg9hTn2RDTHh6jVZtQTnWuvLU
         F6lXNAmqz0HEwNc4XohD9kD29wCkuR+RpScBdbP0pCUFOuL0hDhMqQ36VBYE9u+6XHgB
         eR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545921; x=1752150721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQhKbDgttLDPzwjksoiTuICCO43hP51+1t35DHSJJzk=;
        b=RFJkssagMdMuVrCeMjbyfe/ALmdrg7ZxC0kRVJA8u2twTwj366ArUFGD/EEY/0DLu7
         R7xaDlRDXmFFWG3x4fk4mkt03NnsYn6Gko9Al8CVmbGfn+1Llxd9eru0mneVATg/7qBn
         d7c+Kmk5xzjGwtELltoBs5jufaO6+3TMQF8H5Ytzj8kFTbfnz/d70MRKIRQVM6NAeBL4
         xDdKxPsWKhMivVeQL6Xx9xuWQlPSvz56fJsdrE+MOAECpk6gOaFgK70XxpmnzZJPZhIQ
         J9IV5dx+Ya+t9pR2caDO4cHVCEa00k+vFqt2QQH75UQ7zd7Bmp0163qcuCF33wUFK5Y8
         FU0A==
X-Forwarded-Encrypted: i=1; AJvYcCV0xKTg+RWTszj9x8zFcXMcKwzBe41+lPBFX+mwFAl14nYIIqCmcaJxKTP71jq5S9j81rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmLB79HlAZfwv2VadXtWe1iNPaRzFUeL1Q7g+XmHAGRjBT15Y
	XQyDdXYecOifwMT0Q+M8jfHXbjIuRhSKgqwpO0jkRfYEpAH645qLHxWeRwCyQreL1bVYTecVjvq
	1PHPFd5zTi8iJIR5vrBEndRIOsde2FpU=
X-Gm-Gg: ASbGncugSk1FKt0LQ3DLPdXecuQh5SdbvAR0v1FYhPasrwSzSMi5h4ZXzooCn9Y4fNB
	zM6z1BEMZ2SXKzJtROQ+0/hWYRtxC3RFtIoQSzAuN7MX1Y9W28LmiOTCNtf6fsPR0en/l9/1Dx5
	MGpQCjrQFv2XJJk2jEvtcpsd0qsG0UyE0tokWIUM6zRVXFnSHNM/9aDQ==
X-Google-Smtp-Source: AGHT+IHKgh3LV0M1b1DI8XB7Kt26yf3bzmbWqoLaHD9ywjP2Z87i/kydkVEv0FPDtA2B1qW1o+7wGN53vA5wbK1o1BM=
X-Received: by 2002:a05:6808:1708:b0:406:72ad:bb6b with SMTP id
 5614622812f47-40b8932e380mr4527700b6e.37.1751545921313; Thu, 03 Jul 2025
 05:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701074110.525363-1-jianghaoran@kylinos.cn>
In-Reply-To: <20250701074110.525363-1-jianghaoran@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 3 Jul 2025 20:31:50 +0800
X-Gm-Features: Ac12FXzvOvSPQVT9LYj0iv4FoFZsh-_TM9rl_-KtrPi7ZPAloYrcp2RmxBqM7-M
Message-ID: <CAEyhmHSzfMr0J4t7v7cC7roTfybJRqHF_iumFMCYm_iqzJkGOQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix two tailcall-related issues
To: Haoran Jiang <jianghaoran@kylinos.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
	chenhuacai@kernel.org, yangtiezhu@loongson.cn, jolsa@kernel.org, 
	haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 3:41=E2=80=AFPM Haoran Jiang <jianghaoran@kylinos.cn=
> wrote:
>
> 1,Fix the jmp_offset calculation error in the emit_bpf_tail_call function=
.
> 2,Fix the issue that MAX_TAIL_CALL_CNT limit bypass in hybrid tailcall an=
d BPF-to-BPF call
>
> After applying this patch, testing results are as follows:
>
> ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_1
> 413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> 413     tailcalls:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_2
> 413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> 413     tailcalls:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_3
> 413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> 413     tailcalls:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>

Thanks for the fixes. Will review this series soon.
BTW, do you test other tailcall test cases ?

Cheers,
---
Hengqi

> Haoran Jiang (2):
>   LoongArch: BPF: Optimize the calculation method of jmp_offset in the
>     emit_bpf_tail_call function
>   LoongArch: BPF: Fix tailcall hierarchy
>
>  arch/loongarch/net/bpf_jit.c | 140 ++++++++++++++++++++---------------
>  1 file changed, 80 insertions(+), 60 deletions(-)
>
> --
> 2.43.0
>

