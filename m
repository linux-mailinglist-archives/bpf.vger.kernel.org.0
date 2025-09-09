Return-Path: <bpf+bounces-67928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF4B504C1
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64715407D5
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F5635CEBA;
	Tue,  9 Sep 2025 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVsNT+xl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534435AAB5
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440549; cv=none; b=NA+VgOUWxzWfLomHiPudvO4PYQdbgJwcdmRbGK/xIdxUN/R35zJ6ZS/iMbSZ1O0CQ93K+yGHAxX0Bd3kYsxvM3qLKTsdgh6U6CCvgJoU7YiNHvIHe6aWWBu4jaiZluRslZglT6r7n1EvkfS9Ui7b1TGRDMkDNxstEqOHIcz2KDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440549; c=relaxed/simple;
	bh=kg6liD7wVGpeWyLbeqfrlgY+ggYT6hl2VFD6TeNodQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlrCePSmzMSnQ4rfGJE/Si7l2kaRBS/b8zOf+M+gghx51fNmoly04oaRUXs7eS+4bHG5Hg/1Jsrkb+jsEJloVScfp7cqLKOVr0zdzrJYdwF1tqUQR7yw1XafqCn09TJIcgFILcBJKNS2IiPMwE3ZDfpSbn5q0UZuAWglXWJyoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVsNT+xl; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-412a2fe2f31so3726225ab.3
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757440547; x=1758045347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbdWTDtH4qpTFp4chX0FRf/4+hWqh78ZgtDZiKJPfXs=;
        b=aVsNT+xl/EU3c3dXtzCQeHGi/saEyusRv9FAYgtYHDkbLAIR3vmHvbl+uBwRQ0vy0S
         RU1WyeGdW2R4HqXcNb9op0pkakYlfr1ajoN53nsCYU2c887ujZN81+twbabY4O+Xz1+4
         Zu9HsxhNjjry+NYuCcXfcH/JMDKqZd7ed9M1bzSl0oGKBQaheIvuAbVCLAEJm6/ZTItg
         A/vS2kqpU85CXDy0xLFMwnlLuAWmI04J72xwEZdjxn92PUTvfKcA5os4mGek2uupO8gs
         JKYRmZJlJKi368PqT7VZW1oWtOrLACamuZyK7gMujPdOAE4cwpvYPOfoc2Q2eJNvCBHa
         TguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757440547; x=1758045347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbdWTDtH4qpTFp4chX0FRf/4+hWqh78ZgtDZiKJPfXs=;
        b=QzCurW1d33iEdFEEwbIECsw6v9MGdrRmqRGAUgStySjkwkkWH4/vaasqpIiNxl7WYI
         2ygOckg/nV810ERPQKOWz2UGE289Jve+etojclK/D3SQLVamWCWuuRobAipDrUnzgNc4
         dLxlO9Q+N32Nb+q0mUpepZ3Gxzm4Aplu8GReRWr3pOYS6MSyjcpCa7XeFc/6125nSJxE
         0SsuVHSsx1cOTuwvhw30XYHZdoNwLszozeHw77KWImyYQ2frtoWcE76zGhznvF0nsrwI
         eYwEb6QHOmSXu/uJwlZ4XlpZaZHMFExvj0VqhMfaCj/gZ8cmYpRWdjPdlgCKBWg/axUJ
         18wA==
X-Forwarded-Encrypted: i=1; AJvYcCVkFLsmqete9dOV+yu17AZX1rRE8LN73/FXy1LQiD+U7Or7XUtJWWSkFAJjUDbbY3FPoxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKE/Oiu7aLc3Gydg1LfDy5RFvL0LTEiWDgYnr17wYJXIknVmSW
	XIAcp+PkHNqO+RF4xh/+abPl/5Rze+G4zlFFLQ3RnPOatfO/8P2tr1CU3HyuhrMFfUEjVGoNyCw
	Ulfewc7YImAjy7ByuHrjtI+lpWZmR9fk=
X-Gm-Gg: ASbGnct7sB95paB+mMCfyl0OPcXU1sTT+sos2hwTDdeal5Fzi1jOWxvVuDftJrQGo5b
	EP8BGZvHo92PkK7cMBLcNEV5OelOWoqeg4ts8TTko/8oYvRweJhepSOZwi22eOCFZQCCZgFCIc+
	x7td2uMK8Z7CD9eihFQ/ei8ow+J2N4jxdm5GAhMXMW41GubagP7O93Skdg6XYR7lb/u2YL1spSa
	BMyXvvuL/zP8C+FbHokBFTTNmc/8GmpzRrfeNuWsg5Okm++FMEc
X-Google-Smtp-Source: AGHT+IFYOhqvjzIj+LQDRcbWbj0lSHPo3r8cJ+8bzeY75x25Y7X3YqmlaZNse7yuMlkY5D/qr/XKAva8jZDEuj6mqfw=
X-Received: by 2002:a05:6e02:2589:b0:412:fa25:dd54 with SMTP id
 e9e14a558f8ab-412fa25df91mr34189335ab.14.1757440547283; Tue, 09 Sep 2025
 10:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909171638.2417272-1-eddyz87@gmail.com> <CAEf4BzYf3ew_ho3=FWiZr_VYvex=XVFDv8Y9ymTUuAgn9EKqOw@mail.gmail.com>
In-Reply-To: <CAEf4BzYf3ew_ho3=FWiZr_VYvex=XVFDv8Y9ymTUuAgn9EKqOw@mail.gmail.com>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Tue, 9 Sep 2025 10:55:37 -0700
X-Gm-Features: Ac12FXwefaPDEMP95XfBA7Yty91KI43bk1RPN5zsCTKApCZIxtrDmjQIANuIW1E
Message-ID: <CAMtxOX16V7myorKCrJQtGJR=VffcRnmZ63cnpzj_bYXBYPhr2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: remove Mykola Lysenko from BPF
 selftests maintainers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 10:43=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 9, 2025 at 1:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > Unfortunately Mykola won't participate in BPF selftests maintenance
> > anymore. He asked me to remove the entry on his behalf.
> >
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fe168477caa4..6056ad6f1afa 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4682,7 +4682,6 @@ F:        security/bpf/
> >  BPF [SELFTESTS] (Test Runners & Infrastructure)
> >  M:     Andrii Nakryiko <andrii@kernel.org>
> >  M:     Eduard Zingerman <eddyz87@gmail.com>
> > -R:     Mykola Lysenko <mykolal@fb.com>
>
> cc'ing Mykola
>
> >  L:     bpf@vger.kernel.org
> >  S:     Maintained
> >  F:     tools/testing/selftests/bpf/
> > --
> > 2.47.3
> >


 Acked-by: Mykola Lysenko <nickolay.lysenko@gmail.com>

