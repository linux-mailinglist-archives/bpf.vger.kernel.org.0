Return-Path: <bpf+bounces-76395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 699E4CB2261
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 08:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DE52302ABB5
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E02E1F11;
	Wed, 10 Dec 2025 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/HfJ3cQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F28299AAB
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765350574; cv=none; b=XGOA27O/LfBivAktxXOyHteR5IN8cyJaYzezv8+u2TCLco8Srg5xKJBPkIrjm747dr9tKJGE0xNju1VxZLoN/pQ2MR45MP3h5yY2Pya9E04dKYNcqzt5ghKeG+H2OkH506cKPtmCKFBajULTlSg+8c3KHDKpWYvnMh6EZFIDwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765350574; c=relaxed/simple;
	bh=26nolpmNblwBmBuzKzPK0yRZPS0nM9skp+7aC9R4q08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHay5I+9Y6iD1fUj7B+nPxe5cNDwWmHfJQYT7OBV61uZG1d6iaa8UR8mn3ICxElqbRMuE2wF32HiMsPOlYJh2fEmcVYS43VyLpKY26WQ2gzNyhpPD7fD8JWyBp4an9FiIsRhhTJkuYH9fpZQ4TAwV4KjnzxVsJ48TcOfakIDkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/HfJ3cQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso3861854f8f.3
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 23:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765350571; x=1765955371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EU0VUVqRUtS7aPeBl9evWsKNjXkOCCMm8DbmHiqXpg=;
        b=S/HfJ3cQFto1RAgo+rrACcfN9dwfuFwnAAu+mZhRx8FwpLZRQ/+3c56zpp1fjV+L2+
         CJ2xqr7XMSPB2tFCQ8/sWENL4ildDVkfL1oovPP42uiSOgcH1FbWqbzXzSFjTzZZ2NDa
         SJfoVHTjywYIiqFgfN8m2AwKVDi7cgBYtCjQxp3zHxeu0ECkbUY9bD+r6i/DZTdh63Q0
         2Tf61ibMbg0bKGclUQqdHMO+xO5bLgIypvh90u1Rwd8NTxhVRzapKCFg2aJLNcCrTkLQ
         21uHT/kSG5pNDKvqg4VbVYCOgPWlCYdketP2OntYLTtDuHTDtRBspwc3PMlKP2oCyV2T
         s7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765350571; x=1765955371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+EU0VUVqRUtS7aPeBl9evWsKNjXkOCCMm8DbmHiqXpg=;
        b=R7JgRX28ZLQqLvpw0xLI7DJAazPFp+4TZtNHSaFgg7s2PH71DLiIqFjOTWfk90tRG4
         qQIlxHV4YaE5bZf41rduwyjNMUkKEbP4w4qMKg3hoiocT5dZ30UeMeHmXq2frILWVaGs
         qcTLtrTRmt94veHJ0swLuRjYOKG2o3xskUXDaR+0TC5+YNgG8jl/fPLoyLgfvuPKP/sP
         8X6U6mCkeV4czQc8MhplFjsaYoe7tjdLHm7n4hMpqdVW/fn6J30XD8w3DgfS7V9bh5Be
         v2xobhTbDsit72F3jlMKX0Bf+ppMF5gWMtAbQQeMmKMnS3Ft9BwG6et/2Qaduc02ZP18
         mPqg==
X-Forwarded-Encrypted: i=1; AJvYcCXh4NcqE/tdKhn3T4fE69i6LZWSqL1DNTTwdT2K0V8Syx4DhBivIJKvYuqkiTpbSAyjiqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxFhvcWM9gxDyHRwO2Ra+NoCCL1BOiU16h5i5zCLqoZY4TlZbE
	pmhRV9Mt7hfQHrCILtJyZCjS1B36E1HpjHwOqSmjL+Vjg05ztEsUB3g1r9zi3cO1FynuyrkOQV4
	acqj7VxJPNtnJ5AwX+m5ApLZzIPbxG30=
X-Gm-Gg: AY/fxX7/8X/FkD3CsmRi71NDSjhwYExJYYqWlsp2vQNwrofcx4RM8SBefUlZklytU09
	CmcJhH/IZxsfJ+2+mYBYYy80TDV5NSPyjEGvo5aJDJzqtEkLg/bMUdIEYW0nBXw1egNnW/XNWj3
	6nG9Af74jDbKZK89Q8+BDyL8saaMmgCbrsPNmVzGU2to09heOptV06iz2lnK+h2DPit/hhyo56Q
	+DIr9RboJKudh9pIVVN2cASgORhjzAMP8Bjuzkw+JGElMIjWfNKy/4Y3tX8Fcoe8BVL74FB
X-Google-Smtp-Source: AGHT+IEUWuCBd+VxvtSqBsdHlpGUtEOyUH5Vet9IDXTK4PfHO9H/osN5TOD7YP2bhiK0aFE0r7edKlgEeScX0rmLktg=
X-Received: by 2002:a05:6000:3108:b0:42b:43b4:2870 with SMTP id
 ffacd0b85a97d-42fa39d4d3bmr1377860f8f.26.1765350571083; Tue, 09 Dec 2025
 23:09:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208161800.2902699-2-andriy.shevchenko@linux.intel.com>
 <CAADnVQ+SXe-CsPHnYkB4SOKct6iMN=PkexaKRd-MJFhC3i8M0A@mail.gmail.com> <aTgl_bjO1O9Ddpmv@smile.fi.intel.com>
In-Reply-To: <aTgl_bjO1O9Ddpmv@smile.fi.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Dec 2025 16:09:19 +0900
X-Gm-Features: AQt7F2ogOQ169Rf8brIHTTEO9I_yuqVyNgBKCB2apVGPY610GEpbdkn_RiqZMwM
Message-ID: <CAADnVQLkSoOL8+kELdmX5nzNcXm-s4VbA5+Q-MPcNySsSiu+RQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bpf: Mark BPF printing functions with __printf() attribute
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alan Maguire <alan.maguire@oracle.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 10:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Dec 09, 2025 at 06:12:46PM +0900, Alexei Starovoitov wrote:
> > On Tue, Dec 9, 2025 at 1:21=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The printing functions in BPF code are using printf() type of format,
> > > and compiler is not happy about them as is:
> > >
> > > kernel/bpf/helpers.c:1069:9: error: function =E2=80=98____bpf_snprint=
f=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format att=
ribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >  1069 |         err =3D bstr_printf(str, str_size, fmt, data.bin_args=
);
> > >       |         ^~~
> > >
> > > kernel/trace/bpf_trace.c:377:9: error: function =E2=80=98____bpf_trac=
e_printk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 for=
mat attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, d=
ata.bin_args);
> > >       |         ^~~
> > >
> > > kernel/trace/bpf_trace.c:433:9: error: function =E2=80=98____bpf_trac=
e_vprintk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 fo=
rmat attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >   433 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, d=
ata.bin_args);
> > >       |         ^~~
> > >
> > > kernel/trace/bpf_trace.c:475:9: error: function =E2=80=98____bpf_seq_=
printf=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 forma=
t attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >   475 |         seq_bprintf(m, fmt, data.bin_args);
> > >       |         ^~~~~~~~~~~
> > >
> > > Fix the compilation errors by adding __printf() attribute. For that
> > > we need to pass it down to the BPF_CALL_x() and wrap into PRINTF_BPF_=
CALL_*()
> > > to make code neater.
>
> > This is pointless churn to shut up a warning.
>
> In some cases, like mine, it's an error.
>
> > Teach syzbot to stop this spam instead.
>
> It prevents to perform `make W=3D1` builds with the default CONFIG_WERROR=
,
> which is 'y'.
>
> > At the end this patch doesn't make any visible difference,
> > since user declarations of these helpers are auto generated
> > from uapi/bpf.h file and __printf attribute is not there.
>
> I see, thanks for the review.
> Any recommendations on how to fix this properly?

Add -Wno-suggest-attribute=3Dformat
to corresponding files in Makefile.

I think it's cleaner than __diag_ignore() in the .c

