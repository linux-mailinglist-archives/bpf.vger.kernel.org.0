Return-Path: <bpf+bounces-41167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70705993BFD
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC2C1C23E2D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 01:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C0FEAD0;
	Tue,  8 Oct 2024 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uib873SL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590EEADC
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728349203; cv=none; b=PAzc/0P2P+TP9KvveVp3YI79bnl0r51uBjv0WUBjLE3CR4dJiJpLZ02LpODnl2p1ezwFUjU2G3Lzbb9OuJk3b5HoMky4SV4TECbiwMajK8+ctRn9Ir2SnpfXBDEkqGrtXPeQ03XgLHHXwunATpCtt6gL1x0ZUjCJFYLqbDty1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728349203; c=relaxed/simple;
	bh=Yx3F5YlOkh7M2BkmP670rBYXpi5VIV4PJoN5C7cLGD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snr8xsSz8dOCyaHR/upPdMF+dm3ppm68n5496suKxEFMAOQnkCoQqwKBr++rwxZtzt4z/+Rt/i+Cjeo3hW2IHAcrzxMzqkA+zcXXEMwgCRUy2qN6Pzh4p1aC0Hv6SoZV6YzleprRXD6m6Uz98Nueu83V9FhkLSE6hkTJFg951T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uib873SL; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82cec47242eso169572039f.0
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2024 18:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728349201; x=1728954001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdAT0xnY8PVR5mDFEBklepGm3qlHW/3AhbnISlVnrMY=;
        b=Uib873SLW5pvJkUfIERgxtdI9EKSGaudoCSaKbrJUGVleim4ApY/4ZFu9TvoT/lyfk
         lLLGiHgdx2JFxldRs006ODNPiSQCcuU05Tz0rd5budZBsLTeJ3oUOuZAhhxMt9bFuZ4G
         cjx/oPf7xP4sA8vY3eWtRa3lFdLXsPhpEIpIN+d8xGg4RIlC3MxFTfN+i318X4RCUN4D
         k8YNsFVrxtpLq8VWxaGLulHdjBPkbX3wqC5T8C85DLv5BG/g7BDGKC+dCFJEZN1wGA/b
         o9TR6R155jccxp0QR1edesbMOP7jXAr4nXVlEudyvQc09wJhu0uureZSwteoRdY73knx
         SsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728349201; x=1728954001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdAT0xnY8PVR5mDFEBklepGm3qlHW/3AhbnISlVnrMY=;
        b=Abb9ZtvikfcQ/vTA/xdCtfvxdffNTkl8GGnGlvkNASYySUA9XXs6bkBv2JkjWGP1Ht
         RzFldEIlcnQxXvzOZdwASpRhiZtAWVDVsIPwx0vE8QW/icF/PZxxWY454fnG9yatL4OU
         42G/nSFKXwYfaLWxbUH7DxyOqlMM7dMoCAgL6VBDxhE93uY74La0btFH3mni3NIqw+Rm
         beeb7+3ibWT1JBaj9j0G5C13AL3sIWgD7kgA8mnfm5GFc/6qjYGR1uSP9NnzlmhXnmQG
         83nA0CJiTTuHYk+D1rS4WdVOVnX7kWW4EMlsQeIaPWvr/HjoHmBP1BpjebgoDRjKou0l
         5JLQ==
X-Gm-Message-State: AOJu0YxOla8pqxnZKvhU1iyAQIXmZlAD7BjNpG0U1XSYkKZm176OiAzV
	8H2FwlkY8ay0ijMFXkKTP87ZeqeqyCR5NWSz1VdlB13rfaQ9z4O8Vx7SNkinhHsrwHLZdrR3Fpz
	PXeQnQ8bbFRa14ySURc+6DORjEwI=
X-Google-Smtp-Source: AGHT+IFrtbaPJq1vSosgdhwpVsW4yFTmAvXy+pomxYks32LSHDCjaKoaSqJkIZ7Bnoqm2ygu2ukWPh8438bUnbNxoTQ=
X-Received: by 2002:a05:6e02:1aa2:b0:3a2:463f:fd86 with SMTP id
 e9e14a558f8ab-3a38af208dfmr15182205ab.4.1728349200897; Mon, 07 Oct 2024
 18:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001233242.98679-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241001233242.98679-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 8 Oct 2024 08:59:23 +0800
Message-ID: <CAL+tcoBjZAcbm1x4NVuL4zNjwxk-5CD=vZewDjjTJe724G45Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: syscall_nrs: disable no previous
 prototype warnning
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 7:32=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In some environments (gcc treated as error in W=3D1, which is default), i=
f we
> make -C samples/bpf/, it will be stopped because of
> "no previous prototype" error like this:
>
>   ../samples/bpf/syscall_nrs.c:7:6:
>   error: no previous prototype for =E2=80=98syscall_defines=E2=80=99 [-We=
rror=3Dmissing-prototypes]
>    void syscall_defines(void)
>         ^~~~~~~~~~~~~~~
>
> Actually, this file meets our expectatations because it will be converted=
 to
> a .h file. In this way, it's correct. Considering the warnning stopping u=
s
> compiling, we can remove the warnning directly.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Hello Andrii,

Could you help me review this version?

Thanks,
Jason

