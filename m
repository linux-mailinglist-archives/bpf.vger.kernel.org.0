Return-Path: <bpf+bounces-63646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B97B09325
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A833C7A2AD2
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C942FD888;
	Thu, 17 Jul 2025 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZADCi0J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371FC2904;
	Thu, 17 Jul 2025 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773133; cv=none; b=vBwLeBFB46uBXjWMSDST1UuKQwrWTuWPCUo8A4SKdLVRIaTC9GZbZ5nN+R2HORt5FOxQxKKZEdfzGvKsW/pBDGzzt/S72+ccQ9SybrSZtE4zn/3rrpsyX4MODup3v1UTAt63sxbMF4Hg/T1D76lnYaUI6MR42Y3R7qSTBApCSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773133; c=relaxed/simple;
	bh=FHZgRD2EXHypECk3pwgEZ8+Bh5htm8l/IdmFuPwgm6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jN2M7PT1P9GJc0ox8NLcMfcRqQoBNE69kh7lCqXMILBn728OzT6ef1FNBL3HXg06NTTMXCmkbbAjYSv2bOn8C6717Y0qoTzdOKs45Y47gYDL2/qNcUQFnoVMR7nTNMB1mf4hKhKGTucOqm1Fp8SjqAovoZYAA/AEq+NblDSaIXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZADCi0J; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2ea08399ec8so890926fac.1;
        Thu, 17 Jul 2025 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752773131; x=1753377931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKUAsFn+BYvl4QRv6W+0B4YT2et3vNZIFHPMajMeuYM=;
        b=RZADCi0JCYpgUyWDx6SMWdFgIWfXRfVTpq6x/1tQ2ga5jHE19zVmOlyQQT16WucWEU
         koFO5sVTFNHVhCLLv4QOH9fBoheuC2yOhcUVMb/CA799w/p6k8UnkFFeficRmLFOPwdv
         cubLOl2ZLb1+Vo1ESYPhdPVrwubGyiSubtvVVr6cOBkp7FWW75SE+2MVBTfVoUBKEDgS
         jsJRGbNgdTcjgRPFBc/Qa4//tVN7ms8+GTXoWDKlp687cDJUzVHcKsJJuYyE17SRmuW+
         48/arYiV216WLgBIjFV4nCJOouSv029HrNABHM2Xsx3khARKQutBjrHPHrEqvbPbRzR1
         ITPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773131; x=1753377931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKUAsFn+BYvl4QRv6W+0B4YT2et3vNZIFHPMajMeuYM=;
        b=MOxG38eBlMWreaUrW0YamLzmb/vyE3PW1Uq/XzuniwxBNdgmPZEUtK8Gy2TjqhgpMH
         T0XJtLtY8qbTUcxbY1Odwp47Tv3b4A63BLYTAn3IBxvKGJC8+x/ZpvpBjQYfCCRp0JxY
         1lAKNncqmMt1ifzHBaXRsscckm6Q8rmEBbYtdxeNjCJByKubURFYgwJTgQMbW4ptCeLq
         U5E3blp0aNeYkHJ2Wu9+XtqWIBdkjLyiYVqoNFIz4UGbD9UDHQ+RPTHm0VG6vgwWjIyi
         lfHZkdwTFNxTTzUNhr9/qfeqKD3rIr2evSbtdpsjHUj5D88mrVYToKSEiQkYZSffV8WO
         hatg==
X-Forwarded-Encrypted: i=1; AJvYcCVTdaT8vzOvOWj/cRn+8kXfw1gyUzZXpE6GcEkrUm/YywdKV8RV5L6u8cy7/58Y5lBA7sQygrHO9+O59WmJ@vger.kernel.org, AJvYcCXZ+hSA52tl/sty1tzHMHZW/1z4aMQGA7aXzZqrJda2Bik6eS/AQu//mUwQITwS9FaitDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZiLLsXNVz9wbKWbbBf8TLfWmLh7tQEg7+EDkDgW1w6NNMwgiL
	xecykbJqMh7enqINF6xpG/irvxigY8eTmKsxulXouydX8CYnoiuCPbcRUFdQLWuQTIwq9WaWoyG
	tmK9DYcap2rW1f4AjSeGo9G9L7OSAqHQ=
X-Gm-Gg: ASbGncvjglwIuwiBm9+6jcV5KnQ7P6GVVsxEZYlLCsUbXhISfe4XvnbdLowFR3FKjMl
	jfNIermrZiVkU88zlyohVPRACmVkYrFlJKdHDSfa/khTo3nWZ4xqoRgl4npUjHwbsrpnf/M6TMk
	ahLF0JyT4KKzJ32KUoy1aHuZEzelqHaAsQMRGXxRiJ0iKh9DN9TVdI2i5kCn09InqN7/EvDkT0q
	gHtTUmChlc3PiwRxC8=
X-Google-Smtp-Source: AGHT+IFV3LJemzAq2naa5xnK/QNurVq5M/iO8tvRMpRLLz6WN5u9FanyUc/XuoKYnP3llvLeMkfTFWXDD3gwJGr/r1M=
X-Received: by 2002:a05:6870:71ce:b0:2e9:95cc:b855 with SMTP id
 586e51a60fabf-2ffaf5a15d7mr6374088fac.34.1752773131235; Thu, 17 Jul 2025
 10:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717115936.7025-1-suchitkarunakaran@gmail.com> <CAEf4BzZ+OTkaXmtWPbOGB0OWz5xmj-d06UWchooO+iUyDHar4g@mail.gmail.com>
In-Reply-To: <CAEf4BzZ+OTkaXmtWPbOGB0OWz5xmj-d06UWchooO+iUyDHar4g@mail.gmail.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Thu, 17 Jul 2025 22:55:20 +0530
X-Gm-Features: Ac12FXzHUYvB11EN96RJ87w4mJ-AVBHzefF2DLUAQSIjyLEeP8_edkErqdrKA6Y
Message-ID: <CAO9wTFjZwOcpaSSJJu_khQ=hCdiiQwuVm-=zOAdTr04gbaa45w@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strcpy() with memcpy() in bpf_object__new()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 at 22:49, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Thu, Jul 17, 2025 at 4:59=E2=80=AFAM Suchit Karunakaran
> <suchitkarunakaran@gmail.com> wrote:
> >
> > Replace the unsafe strcpy() call with memcpy() when copying the path
> > into the bpf_object structure. Since the memory is pre-allocated to
> > exactly strlen(path) + 1 bytes and the length is already known, memcpy(=
)
> > is safer than strcpy().
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 52e353368f58..279f226dd965 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -1495,7 +1495,7 @@ static struct bpf_object *bpf_object__new(const c=
har *path,
> >                 return ERR_PTR(-ENOMEM);
> >         }
> >
> > -       strcpy(obj->path, path);
> > +       memcpy(obj->path, path, strlen(path) + 1);
>
>
> This is user-space libbpf code, where the API contract mandates that
> the path argument is a well-formed zero-terminated C string. Plus, if
> you look at the few lines above, we allocate just enough space to fit
> the entire contents of the string without truncation.
>
> In other words, there is nothing to fix or improve here.
>
> pw-bot: cr
>

That makes sense, strcpy() is indeed safe here. Thanks for the clarificatio=
n.

