Return-Path: <bpf+bounces-69018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1136B8BA19
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858055A228E
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493EC2D2395;
	Fri, 19 Sep 2025 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQTNP9Is"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B01F152D
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758324110; cv=none; b=Mu3QqWRsfghqi5PXTyUcohJ1BDijIMV/kcNP4b7LXgHOjd5axd1obkZKSrFgcBiu+cQEUTjds3UpnTTCcV8uCbgBTAhhXEmaD2TWd6capjpmSm+TUagh+x1zEdaI8rx1fkAIDfM0Fw68zV1TtB1AQDkjcDHjy+rb7uO8lmz+XxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758324110; c=relaxed/simple;
	bh=QJmSU9SuRfNJGRpGTMcuZcLatF7EuHnDysEveLkX+rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWCQXqXXHr9sM7fR9PaISKD34x4zM9MhirGXdCrz11Xo/8GQ/0XV57L2K0JBoeL76UZp5HoHAFfqo6fOsV/d0QcOTHDikcy3mrWDMKnvKd16L9opi9NYDP3S8U1rjoi5EoxAATRMx72p0queVlrHEGfswzJ9KgPKJwsZL8kn3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQTNP9Is; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323266d6f57so2716536a91.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758324109; x=1758928909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uetZERvD5Eqf1TYbNiROBOZR1l3alqp2wC2HsATdNY=;
        b=NQTNP9IsNrgSXcf7pRFb//zNtTpxozLheL0b31GeUpMeGASXGd1tkGiS+9OHynP0Fn
         uns7UvERvPUhFEpdjT70D7ixqQI3TVuA1KAdO/1+e8+t3Y064zxstH91mi2lRk5wc9uz
         WlXsKstCaLxPKBdBYI9u8YMvRbR7ImC2qqyk7esy2Tf8+1L+N+HHxW22IHYK1MNuamPB
         Nf0QKi0g1uJL4SMm1ynqJ92lGCdWsm1GapTYD6/+JPzioAoCnTeHr1ABJ8JuG3h2ngWr
         IB3xq31fhp4bILV2CTm7lEwgQvEtj09OwHIvpweaDkY0c97BY49XYgW3cESuLWFBJSRa
         BodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758324109; x=1758928909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uetZERvD5Eqf1TYbNiROBOZR1l3alqp2wC2HsATdNY=;
        b=KsVpkJjc5Aa9IMHm9uvBS0moNWFa2J/yr982l31UvK0FkwVVaARZExNP/F2uE7hUY4
         FwHJdJ9QYTSlnCvCOBJs2XgsnW28w0cKDCMg/PLJTx7VOYMx/T7ngH92FPs6RP6L9R0K
         qnO718sjazufY/WKEH8JtBddRHu+5vNbXndArrqGyTQhFRsyhhvrt2W3AbMj3yGYk1An
         v5TH9HTPYPIN+xd3nYyq4HXHp8kes1mDZIaOi6lpeQASscm0vmjf3FIaXVJsGshlXPFc
         pwzHSYSn8BAE01mOLgsgw3IH4TXGSil8DYgfavgmjfRxWghQVIzovJRoLMaQa+OoQHr9
         xvyQ==
X-Gm-Message-State: AOJu0YzThn9RnDBo5aGhMhpyhSeIxqmxlSqi0gvJroxfRbNUXrowib32
	dihnj+3tze8sNWuTzf8s6RtVplOrLM/MVHU6y9Cf7e0379mGtHOw9UfvF7aznk6T3HJpernEwkZ
	LPt1dHmheiNsHcdCtpyKK5pLCxi3G8qophQ==
X-Gm-Gg: ASbGncvXx671HJJEtk9k+o14QV77J+th1fulc/cxVNv/QnGRS8TLPiq2TLPFhod1G5L
	wS25v9IsEPzpFW8M44KFGBs27N77PM6OTON/xtLZU+Ad6rbSz3VwjyfGBPuoVa67g3WeCG7rerP
	ndq7NENLY9CwjJ4LNO9eFdTajHP1PnGBEQc0DJ3SL2VBauaZ+ysin8+jCXFCpgqdztZ9XRHnPe8
	Il0zDmDd/DXVFX84b+4TuBV0tZpfjGYRA==
X-Google-Smtp-Source: AGHT+IFbZuWzMjSkG7RYmosd6ej1vettN0EHmythUfUiocZs428X6ytb4lw8Iy204U31+95NwCvSQTB7O9XZVkV1ki8=
X-Received: by 2002:a17:90b:2c90:b0:32e:32e4:9785 with SMTP id
 98e67ed59e1d1-33097fdc529mr6405738a91.6.1758324108672; Fri, 19 Sep 2025
 16:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7949d9ee-b463-4fd4-830e-0bb74fb5b2a0@kernel.org> <20250917183847.318163-1-tstellar@redhat.com>
In-Reply-To: <20250917183847.318163-1-tstellar@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 16:21:33 -0700
X-Gm-Features: AS18NWArw6Xz-OyZCGv7L1fTZ3DTXxHOGO6ZhS7d6476kcZo1roNF2HMLl9kqrQ
Message-ID: <CAEf4BzY5a8yK2G1ZGGAYGeUW7ocLw=aOoyOhjZWh28fyPiE85A@mail.gmail.com>
Subject: Re: [PATCH] bpftool: Fix -Wuninitialized-const-pointer warnings with
 clang >= 21 v2
To: Tom Stellard <tstellar@redhat.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:39=E2=80=AFAM Tom Stellard <tstellar@redhat.com>=
 wrote:
>
> This fixes the build with -Werror -Wall.
>
> btf_dumper.c:71:31: error: variable 'finfo' is uninitialized when passed =
as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>    71 |         info.func_info =3D ptr_to_u64(&finfo);
>       |                                      ^~~~~
>
> prog.c:2294:31: error: variable 'func_info' is uninitialized when passed =
as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>  2294 |         info.func_info =3D ptr_to_u64(&func_info);
>       |
>
> v2:
>   - Initialize instead of using memset.
>
> Signed-off-by: Tom Stellard <tstellar@redhat.com>
> ---
>  tools/bpf/bpftool/btf_dumper.c | 4 +++-
>  tools/bpf/bpftool/prog.c       | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumpe=
r.c
> index 4e896d8a2416..89715c32a1a3 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -38,7 +38,9 @@ static int dump_prog_id_as_func_ptr(const struct btf_du=
mper *d,
>         __u32 info_len =3D sizeof(info);
>         const char *prog_name =3D NULL;
>         struct btf *prog_btf =3D NULL;
> -       struct bpf_func_info finfo;
> +       /* Initialize finfo to silence -Wuninitialized-const-pointer warn=
ing
> +        * in clang >=3D 21. */

incorrectly formatted comments, but also I'm not sure they add much
useful information. So I just dropped them

Also I dropped "v2" suffix from the commit header, as mentioned
earlier, v2 should go into the [PATCH ...] part.

Applied to bpf-next, thanks.


> +       struct bpf_func_info finfo =3D {};
>         __u32 finfo_rec_size;
>         char prog_str[1024];
>         int err;
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 96eea8a67225..2540f570a38b 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -2216,7 +2216,9 @@ static void profile_print_readings(void)
>
>  static char *profile_target_name(int tgt_fd)
>  {
> -       struct bpf_func_info func_info;
> +       /* Initialize func_info to silence -Wuninitialized-const-pointer
> +        * warning in clang >=3D 21. */
> +       struct bpf_func_info func_info =3D {};
>         struct bpf_prog_info info =3D {};
>         __u32 info_len =3D sizeof(info);
>         const struct btf_type *t;
> --
> 2.51.0
>
>

