Return-Path: <bpf+bounces-52578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D42AA44F54
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88E117FE77
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 21:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB146212B23;
	Tue, 25 Feb 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIVmS6o4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAEB211A36
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520579; cv=none; b=SGME9k9LDoVUTKaxKgHLymirHPI/p2WIkFImqU7sH7f4N8uDBjHejvwwGTwULyEwl5ATYYma8qiwbcdndTAXMdsVeRHzdYy/smDQSKuAtvLxMBfsy+3bqRWF+HFJI9y2StOCEHKrzPjDXz5znirZOyK4ISXfZwRiuNqGnSJIuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520579; c=relaxed/simple;
	bh=FAqalaQhav2g1RNMMpBhugf6/iCbgCwdMNhgDoC6YQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGH0P/ozdI/TwbRpv8SZ+QcHKHNgyq7Q7EtptQbSXEiD9z3YLNgt71LUX3imG93nk1+Jg26U9vG7bav8cSlH7meG2r09PpOwiJ3BVnzDA84FEQwEl+0xmB+qgAnaBq0BHkS9sLYJtBEd+5ZymyM73KWHrtlZJncECDvPO/Sr3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIVmS6o4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso8054669a91.3
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 13:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740520577; x=1741125377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bFLNzHW5mWLNjtO5LvEKE/1DJ+xvlQufc1ijHHJOPs=;
        b=nIVmS6o46lAFdQluQj7pGIOzGcg6KIxJsyw73pTrfYrsIdYpTWO1eFeVGXOUqEOBED
         uti1r/aIezV6ozn0Lp+Bg8dJeC/FGQCQi4WqsAl+DnqRms4BLinFvCMZhmp3o4iyrm+M
         XcjA0K1WveCimazz2KTAnKzVFSbcl59Qim6r00l1gWJl8LLVtBVydfvG6zTIl7aaxVsh
         cfATAmb0EBtRloPMND1RHBiQS7uQSr0mqtuwgJFyvmhoIIUkHdeMlxUMoNF5AcbtNQAm
         1IYqajei4oGV7YAahH5OY3WiMZk59q6GTEFxB8Ldm7epSij2Hwyb6xyQuRP6alOA7YRq
         uJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520577; x=1741125377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bFLNzHW5mWLNjtO5LvEKE/1DJ+xvlQufc1ijHHJOPs=;
        b=XdTlFvXgJUOCgVYxjjffK4tjuLeHxsLclCJ5oJ+JxLVvZ+fP8To1ftwQ/ZLqhkKKeO
         98MkGR2i/cQRBNJU+s9XBUvKlQ4e1hijBi7OXvlZ6VxC+gaRR8iXnb/x6ILHeRcwvEWO
         Ohpxk8Jh8x8qYrVTK7k2Gh9xuemL/Vf9WMN3Rji0z/T3e5vdN8RsA2FNm8Qu1piiK2PB
         RlhrKkx+l9Cau/5NJu67kg5UB9TDkRQPYwZ+d1PJLzBvJ9zCJql/16lSros0gVdOy1M4
         xhh7fCq9Mzn+l8ua+E9B1uI/6bnBTMeXYlsYNOoiOYUE8eeDJCU9Ik6ZBdyY3cdm115T
         iSPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2UvcRGSisFalHA4hAWDhkCbcgs2gcM1FCHXWibQMduFkOTQuYHZgkMjAbrQw5yvmP6iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwFsbKLStaD5vZwnsINFcmUrq24IcVl6gZxtyjioUSjsoCkYlD
	CKSEOsPt+XF7dKUPeHlKFaX2LwnQ3FPEgxua8uLc03zhZP806e0QgGq2rcKfylGiNT6dtzb05Wg
	t/8k1kuPyu1kpgtT5knFIi4QFpwI=
X-Gm-Gg: ASbGnct+e/StGEj3riEOpCB6oUwZ7uGgYNOr2TdDgjL4z4yd2TG3JBl+jNpdDepNakN
	wbiYW5RBI+RiZIWL7BkBhNnEcrjqqLB2jGVXbz6XQ0tH0VcWhGGCEHCOdRQgvk1OnLI34QxcF6M
	B4kcxPulEYNYjBbOiQz75+PlQ=
X-Google-Smtp-Source: AGHT+IE1e52nsEJn3n/238wBy4xWZjbhm2y78k+n2WzHu3zZSWWHTzhd7TcaRZ4LoryQ/aVLPTk20VTSVCNszL3Mz9k=
X-Received: by 2002:a17:90a:c88d:b0:2ee:96a5:721c with SMTP id
 98e67ed59e1d1-2fe7e312395mr1439993a91.21.1740520577099; Tue, 25 Feb 2025
 13:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
 <20250225163101.121043-2-mykyta.yatsenko5@gmail.com> <b8b36cfa2700a753e85468591ac3ec458b3a5fa5.camel@gmail.com>
In-Reply-To: <b8b36cfa2700a753e85468591ac3ec458b3a5fa5.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Feb 2025 13:56:05 -0800
X-Gm-Features: AWEUYZnMqj3T4Xe4JslhJS6dDL79amnftj20sFSWBYvBbH-Kcso07S9YCwtsJJ0
Message-ID: <CAEf4BzbHLmDFeL1+24O_LtA6tKV7DDTEi2YzEhifrPX6Gu5mfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] selftests/bpf: implement setting global
 variables in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:04=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2025-02-25 at 16:31 +0000, Mykyta Yatsenko wrote:
>
> New warning for trying to set non-enums from enumerators works fine.
> This still can be abused if numeric value outside of the supported
> range is specified, but that's fine, I think.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -1292,6 +1320,268 @@ static int process_prog(const char *filename, s=
truct bpf_object *obj, struct bpf
> >       return 0;
> >  };
> >
> > +static int append_var_preset(struct var_preset **presets, int *cnt, co=
nst char *expr)
> > +{
> > +     void *tmp;
> > +     struct var_preset *cur;
> > +     char var[256], val[256];
> > +     long long value;
> > +     int r, n, val_len;
> > +
> > +     tmp =3D realloc(*presets, (*cnt + 1) * sizeof(**presets));
> > +     if (!tmp)
> > +             return -ENOMEM;
> > +     *presets =3D tmp;
> > +     cur =3D &(*presets)[*cnt];
> > +     cur->applied =3D false;
> > +
> > +     if (sscanf(expr, "%s =3D %s\n", var, val) !=3D 2) {
> > +             fprintf(stderr, "Could not parse expression %s\n", expr);
> > +             return -EINVAL;
> > +     }
> > +
> > +     val_len =3D strlen(val);
> > +     errno =3D 0;
> > +     r =3D sscanf(val, "%lli %n", &value, &n);
> > +     if (r =3D=3D 1 && n =3D=3D val_len) {
> > +             if (errno =3D=3D ERANGE) {
> > +                     /* Try parsing as unsigned */
> > +                     errno =3D 0;
> > +                     r =3D sscanf(val, "%llu %n", &value, &n);
> > +                     /* Try hex if not all chars consumed */
> > +                     if (n !=3D val_len) {
> > +                             errno =3D 0;
> > +                             r =3D sscanf(val, "%llx %n", &value, &n);
>
> The discrepancy between %lli accepting 0x but %llu not accepting 0x is
> annoying unfortunate. Does not look simpler then before, but let's
> merge this already.

yeah... with sscanf() we at least get whitespace trimming at end, so
don't need to check that. But I agree, doesn't look better.

>
> > +                     }
> > +             }
> > +             if (errno || r !=3D 1 || n !=3D val_len) {
> > +                     fprintf(stderr, "Could not parse value %s\n", val=
);
> > +                     return -EINVAL;
> > +             }
> > +             cur->ivalue =3D value;
> > +             cur->type =3D INTEGRAL;
> > +     } else {
> > +             /* If not a number, consider it enum value */
> > +             cur->svalue =3D strdup(val);
> > +             if (!cur->svalue)
> > +                     return -ENOMEM;
> > +
> > +             cur->type =3D ENUMERATOR;
> > +     }
> > +
> > +     cur->name =3D strdup(var);
> > +     if (!cur->name)
> > +             return -ENOMEM;
> > +
> > +     (*cnt)++;
> > +     return 0;
> > +}
>
> [...]
>

