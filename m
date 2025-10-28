Return-Path: <bpf+bounces-72609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC81BC16637
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 19:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A21C4F296D
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCDC34B424;
	Tue, 28 Oct 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTaJHWwp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51D345751
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674610; cv=none; b=tCvX3WvIXJEe5H+AYc9j00mOwy5/dRjm1Y6qV/6sTekLuBhNE6wBLanis3g2dB8JrdX/WskPLDHca9HgaK/NN85c7kjnUgcnplyiyeR/iSLMmcTFntZvP1hOpMCykidZ4iXukYFqweGUGUeHZdzkMv8uAW4toG+sKxcYGbEjA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674610; c=relaxed/simple;
	bh=N/2n9//+KW7oF6yBywFQdC6s1W8qi+KuEL6BiBiuSSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl17P4BYveeYvzEu2lR34dDtlJxNteZAhq2h4yvso8ApuqYMUYXl3I4X3kYWmjpy/pTk1Jux5IcttUrQEpSq02KSgkTOjRPGd19Cb5EGDjqCVoKPquAyNTh+EbnCTqeZjKTmbykZCMZeQBrvQSBZGcRv1jiYzvuA6piGAuX5qq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTaJHWwp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so6396423a91.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674608; x=1762279408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YUIz8wwdRGbzeLmUHhGiVZlg3eCd3kY9ZjME39qTq8=;
        b=ZTaJHWwpI43QriePMm2vLipy+s8KeR1idVe01X4/H+cxgNNlFwXJd0enZGXcx2AHfd
         0nC5D2s7O3Jr5Bk8Efqrx19rGhEo74U85xfSPSzhieSOkVNwvzCC+o0anH+wTRXSLnCc
         JAr23flMCLbd+C5J02N5N5zvJmkjG4jgBep6VgOz61KRd83CK+OY4uwF4TNf0KDrff0T
         +doIEDg9KDWF5wpfLD5TwgqMJ8Vv4MfhkYhAJDDSge/1UbZXFD8YuUiPYLZFGvwlWpl8
         xA+8J7fTumBZwY0tlKOGzHlE03QusHDraWLFAaky1GDD6ltLJiLsE7wiEWkCeXyHAkgU
         aQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674608; x=1762279408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YUIz8wwdRGbzeLmUHhGiVZlg3eCd3kY9ZjME39qTq8=;
        b=ZkrwHTGioOAXCDVyCl2c8H20qozo2vnF53FIeWzL7At/DwNI/TPXeiJtMDKGW4TbjF
         bZtIblkqGegLm9c2alo6I/JBZ+W2eNwCa/LAPziM5WVKBE5zqgTF8SGe9yNw10i6B/JI
         ozqMIJKwv/r0+LoUAwdaleQMHdKMvkk7w2NbbaUvtOcZnTQcvZrUI2zRArThxoc9e2h9
         b8t3QBPB+3Tzc+67Kk6rLFrvqb7IS8p5+Ymm01VToYAn552Eqm755R3bbes0hjmL90Eo
         1YvVNTD0bteX+KaDHcekQlRa4zL9zCQRLsQz2l6j0zMLCakmSYhE2jZtCbKbQwXZeVaa
         usXA==
X-Forwarded-Encrypted: i=1; AJvYcCXG3t33L/CIXIZvHKDaKZcjdEU2TjX+WutCHGUUfyoEUgTAeYJ6pVMhpOGPRzn6Dkoxsgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg638hT/oY1tW9Nj3Ctud3IKLiEwpuDLIFxNYHarSIvNZzGpCw
	vRMx+ctU414P2vGpnmqa2g4/yA9XT9y2H5fD3nVEc48gYTHDGYGn03iD/05SB9hxqPeGGcJ/4tU
	Zx4v0IfvASCmZv7UeTy3E8J8yoQrTrXs=
X-Gm-Gg: ASbGncvT/j6YPdnLPZTbxhTt+8XepGjIKw3+3Fdvb2WkIxKKxSSBxEjjnn/wVrp5zPP
	oF+NyJRWxTtzLJAknIg09UalRzMTXEnMZI/Mi8hpJNO/9Bdj89Bj/Y6OWOrWkgLTFjtDpo0CmQF
	u2O230A/BFrSim3Y4yF5kVxwh82atBk3r2uUbEqOqdvyWgQGolI0uiUWPm9QoJenLhnU89jxjaH
	hzLhfK02sEwRbXQCC8cdKgimamZSjnA81gkLMAwHlRUwUtLQ/TI3Ehxmgp/3qveN8aaPJnJiVJ3
X-Google-Smtp-Source: AGHT+IF5uRUmVRMsdvmXnOQ/s58+NuQywR1+H1ilzd8u0z1tYFeDtb+IxVChGYm8w5VEsZPqM/8uTgNLgmV5PnDy1Rk=
X-Received: by 2002:a17:90b:582f:b0:32e:9f1e:4ee4 with SMTP id
 98e67ed59e1d1-34027bd6b5cmr6501813a91.17.1761674607530; Tue, 28 Oct 2025
 11:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <20251026154000.34151-4-leon.hwang@linux.dev>
 <CAMB2axPhcYctJYz0bH032-Kc1h2LcJL74O5iS5g=8Qp74GPK_g@mail.gmail.com>
 <377791b5-2294-4ced-a0d3-918c7e078b2b@linux.dev> <CAMB2axPx2RajLzhoOsnffhrOxkw7Zy=D=vHam_Y_5wKS0cqf0g@mail.gmail.com>
 <971495da-bc0e-46d4-bda4-5e9b8310ca3e@linux.dev>
In-Reply-To: <971495da-bc0e-46d4-bda4-5e9b8310ca3e@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 11:03:13 -0700
X-Gm-Features: AWmQ_bnRheSYG69jQZH0dkLn0sMywDw0oGtZbRALO7WE3C87j6rV9LzVKZj-sx4
Message-ID: <CAEf4BzbRA1Ka1piTiQjBfG2z8tp2ucJh_YuazFWNqAVtOhD48g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/4] bpf: Free special fields when update local
 storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, 
	linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:48=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/10/28 01:04, Amery Hung wrote:
> > On Mon, Oct 27, 2025 at 9:15=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Hi Amery,
> >>
> >> On 2025/10/27 23:44, Amery Hung wrote:
> >>> On Sun, Oct 26, 2025 at 8:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.=
dev> wrote:
>
> [...]
>
> >>>>                 selem =3D SELEM(old_sdata);
> >>>>                 goto unlock;
> >>>>         }
> >>>> @@ -654,6 +656,7 @@ bpf_local_storage_update(void *owner, struct bpf=
_local_storage_map *smap,
> >>>>
> >>>>         /* Third, remove old selem, SELEM(old_sdata) */
> >>>>         if (old_sdata) {
> >>>> +               bpf_obj_free_fields(smap->map.record, old_sdata->dat=
a);
> >>>
> >>> Is this really needed? bpf_selem_free_list() later should free specia=
l
> >>> fields in this selem.
> >>>
> >>
> >> Yes, it=E2=80=99s needed. The new selftest confirms that the special f=
ields are
> >> not freed when updating a local storage map.
> >>
> >
> > Hmmm. I don't think so.
> >
> >> Also, bpf_selem_unlink_storage_nolock() doesn=E2=80=99t invoke
> >> bpf_selem_free_list(), unlike bpf_selem_unlink_storage(). So we need t=
o
> >> call bpf_obj_free_fields() here explicitly to free those fields.
> >>
> >
> > bpf_selem_unlink_storage_nolock() unlinks the old selem and adds it to
> > old_selem_free_list. Later, bpf_selem_free_list() will call
> > bpf_selem_free() to free selem in bpf_selem_free_list, which should
> > also free special fields in the selem.
> >
> > The selftests may have checked the refcount before an task trace RCU
> > gp and thought it is a leak. I added a 300ms delay before the checking
> > program runs and the test did not detect any leak even without this
> > specific bpf_obj_free_fields().
>
> Yeah, you're right. Thanks for the clear explanation.
>
> I also verified it by adding a 300ms delay.
>
> So this bpf_obj_free_fields() call isn't needed =E2=80=94 I'll drop it in=
 the
> next revision.

I've dropped it while applying, no need to resend.

>
> Thanks,
> Leon
>

