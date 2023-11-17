Return-Path: <bpf+bounces-15268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89C7EF8B6
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FB0B20B0C
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4EC43AAF;
	Fri, 17 Nov 2023 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOhYAOL6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9CD6D
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:33:01 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50970c2115eso3568304e87.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700253179; x=1700857979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQXktW7bqjdbRZwOE0dKHiUWqD4Wap4fQoSK+yKyJek=;
        b=DOhYAOL6jmi3idOu04ELzkLWHqdkwfZNgG91WOZjN1zfTMlq+b8O/xt5+OOaQEDlCU
         ecAUvX73GZ4t1kwG1M6g0b2mU2zi2/uncmFz9EkJWM5/1uwWTjCELqjff+uShWshGu+q
         65hjWoHPDnlT8F63ciGG362oHFn65eDioq61mOz69K3IdWZsZziJNOPfsQ46EW6RYUv1
         kHqPv6XzL4pYRMc3LZPLuvGIicmw6dF25u0j33CvZrRJkHTKMHsVG0fbwGYc2v0U/qEI
         hVaeGpHwFaVCsBFjAjnycKU9SR5/fF5RmGvw8M+Rd7ZIigGJjN+tN8n8zP9fTkGd9CGZ
         cXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700253179; x=1700857979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQXktW7bqjdbRZwOE0dKHiUWqD4Wap4fQoSK+yKyJek=;
        b=pCy17hBZjI3yb8t6FJZLdK/uf3tcoaH/xYiM+QyRmiu4yWO+vgWpcK8rb95JqfjwRN
         Wuq7lgOhHYIRJE1AIP9eLsBAQXfr8Vpi0ECicSG0B1JsBdHUQcNS3D6TrVD5KYTVyOjF
         /XpThmv7xnWT09BwL2TSM1gKX5VBvvLrrNHz+jSoAeeKKJohZ2JvUF34jQg5x4BS+rBZ
         HoUQxg5jV0qLJkR2hBtd2JlCSjPfEH7jj/u5HyIqYc6Vtf0K+ZObUxKa0A/tNGDdQ9iz
         TgzEye2jLvM1JbGC198wwl28POwNxIACKRM4e00YXWPg0o65Q86wtKWWW5jlob6glcP3
         0/xQ==
X-Gm-Message-State: AOJu0YzxUTjPvBbkPNpAPnIT3uWzcozGjZGvXOwcdoI+NHlfxFdfbWjS
	c0XPGXWK2fOY1ux3KiUCAh10Xt6tbvtUgQG/WqQ=
X-Google-Smtp-Source: AGHT+IFzX7bKvapKKYgGP8fR4wflUyKelxc+x7oTxrygwf8TItqxIK4hckxHbcnbDUH1+/U9TVMppNUfvWmSKtWcYDE=
X-Received: by 2002:a05:6512:108d:b0:50a:a243:3eb2 with SMTP id
 j13-20020a056512108d00b0050aa2433eb2mr617876lfg.36.1700253179362; Fri, 17 Nov
 2023 12:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-13-eddyz87@gmail.com>
 <CAEf4BzYd_Dv4fEoPe+n+sRXxHFmYrTs7w45jtYeQByNH521gzA@mail.gmail.com> <6da7c6b9617663daa54ed27d2c1637cc71dfb7a3.camel@gmail.com>
In-Reply-To: <6da7c6b9617663daa54ed27d2c1637cc71dfb7a3.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 15:32:48 -0500
Message-ID: <CAEf4BzbNYveHmjxmKN9doBD_yEh6nyEiqQVSSbeh-yMnNJsG8Q@mail.gmail.com>
Subject: Re: [PATCH bpf 12/12] selftests/bpf: check if max number of bpf_loop
 iterations is tracked
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 1:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-11-17 at 11:47 -0500, Andrii Nakryiko wrote:
> [...]
> > > +SEC("?raw_tp")
> > > +__success __log_level(2)
> > > +/* Check that last verified exit from the program visited each
> > > + * callback expected number of times: one visit per callback for eac=
h
> > > + * top level bpf_loop call.
> > > + */
> > > +__msg("r1 =3D *(u64 *)(r10 -16)       ; R1_w=3D111111 R10=3Dfp0 fp-1=
6=3D111111")
> > > +/* Ensure that read above is the last one by checking that there are
> > > + * no more reads for ctx.i.
> > > + */
> > > +__not_msg("r1 =3D *(u64 *)(r10 -16)      ; R1_w=3D")
> >
> > can't you enforce that we don't go above 111111 just by making sure to
> > use r1 - 111111 + 1 as an index into choice_arr()?
> >
> > We can then simplify the patch set by dropping __not_msg() parts (and
> > can add them separately).
>
> Well, r1 could be 0 as well, so idx would be out of bounds.
> But I like the idea, it is possible to check that r1 is either 00000,
> 100000, ..., 111111 and do something unsafe otherwise.

then why not `return choice_arr[r <=3D 111111 ? (r & 1) : -1];` or
something along those lines?

> Thank you. I'll drop __not_msg() then.

yep, thanks

>
>

