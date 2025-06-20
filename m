Return-Path: <bpf+bounces-61197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D8AE2224
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 20:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1034A16DA
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9482EA746;
	Fri, 20 Jun 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRgb9ajL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015F2E6127;
	Fri, 20 Jun 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443921; cv=none; b=ssmk8snOBlD0gDJrtibdQEoqFQcsL8v8oHPFQx6Bybn9l5cadH1TEjPh2OBdmVIkkRCNNBirMW8nPEyz1Onffu/nPXlgb8c8/Pbt6rx6ILEC1skRlxhZSj26pNiOTktBXEIposliQfCrFk6uVhCSt/AjR6yWh5WfDWW7H7y4/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443921; c=relaxed/simple;
	bh=jGhgKDFEe3Pg7Z8KZ0eA6tMXvUHpocTDBhojXUcAe4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoIWrCnho1GRJJf01Ner6r3TLQyxkpKaIr80kDnfFe0vF0cKp1TR3pVyiyu3w2OvN61fLLFGC5ZIK/plcFLOZ3G4W/2suSsEoCnuMhY38Y1eWHP//wWDSRWP4w8Yonp7NVMvIwoDtOSDtlAPy3cs1wyLJzAKPuBESl8ennv6R+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRgb9ajL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so21318845e9.0;
        Fri, 20 Jun 2025 11:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750443918; x=1751048718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt/i0BLT2snEIhTbJGy1TYFOLnyF4y9hY/P46u8QJs0=;
        b=YRgb9ajLqX1OrIriQ5nUrByhxx7RalmUnjZjcqzg+sDwhvivsDuukxlHRagAxYS8h7
         /5+rQEvLrENoC2cxZFhJPLdVsR8xW5Hxw3jn/jTKACRjbI3MT48EQdk/du190e+JGrSf
         wK6k/qA7oOPXduKaqCsYw795XpqLHM10VHR0rGxFB7rD4GR/mO2qbUX66vZh4HE7A1So
         AZU0RSTuDSd4Gd5gKHaX8eILsI+HKfV7lFxZ86as0QCgQcJ3PqYd9AWg/vvCuFgD17pN
         /IaNYhppap70syk+CPNCUC/AUSMZMD7927yHVF5fTb6gMyZ66IrAUiJUqNTIQ70pCuRl
         r0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750443918; x=1751048718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt/i0BLT2snEIhTbJGy1TYFOLnyF4y9hY/P46u8QJs0=;
        b=xLaBgeKHnrFePasYscJ8gmatw59tIQWqaXSR4wHWRmTUHIXTvnJFxDKv06yH1fA+aE
         sox/A65W/GrPqzuaNwIEk0V0utYP/zYlTv6IYAr++OYRshPTHevPcHjpes1C+ap4rmLB
         pMkRDGek+t4i1SOTaRTQ5+OBqWNp63jYLvmInxHPlMDTwZslTbsLUcC9NtPJ3e7W73Z9
         dABm2Z0Pf2M4NKFeLiQNftw92DgnDJ+uf6sJXgioIQfrJdyN872v/DvRwDRmdteyMfIY
         ZkMUjDLQilopLpAuink8ayLtG/Ps7ed1UrX8QXgdtE2RUox8R2FaHImfG9WNk4Hiuyl7
         w1wg==
X-Forwarded-Encrypted: i=1; AJvYcCVfwZ9eJba3CsnHJ+FYJfun7foDkhO6z9ckcOLgHSxstkU5rWvrq/u1g38cThEba8Wx3jmZz2hviKZ9tiTvnd6mjH18@vger.kernel.org, AJvYcCWO8QLAST5xv/KS5unlAgJ2VBmNr83femqBhTzipJVyE7NZDZC2OBKjAR+FK4cBWzycsqU=@vger.kernel.org, AJvYcCWiPwFBDdAWIf7mymPg4CcnuiDfei+BY0/uDtACXu1T9rnk4ZvMBtztx/fHcWcr2zvDo02TyZgOwJbCjJbg@vger.kernel.org
X-Gm-Message-State: AOJu0YzVf+G2CkVL5OOQ0sHrxcHZwy0eE3qPp8iBzb4s1wKe1vlVYyT/
	/WfqWuJmuEcP4m1AnCMOH8DSYTB6jQL1N4UMiD3RV6Eo0ICNQ8hWIOiiVQI9DsKxOmqwPnxrPAG
	8s7KJUHY8P6gNF5Jj/RPfv78ASeWVSw8=
X-Gm-Gg: ASbGncsUI+edynR2IhT+IQOoPCdLRuLUHHJbSQxfcyfBPGFh6IFRAzcUFGKCsUC40ZZ
	kYuGdhq2SveaCZJQvdrCGaDzwZshXJrjOK2kZ2VKdj3wGnLLXlRqrAr3OUW2aAMLywiV99pXbh8
	DOw0jBhtqvie8BGf4Ifd6K0MOxLj9EdmiiwyGCM/XlwWLZ04nhOuCPOBoZY+Z63K/t3+6VWbiS
X-Google-Smtp-Source: AGHT+IFq8K9bNqZ9f4cupMWMXq68frawsn8RVGfiyeoCiXF/kw+TVdBhMioEWGJkNhfPeR0A5MHmD4r80ke4UoM4SzU=
X-Received: by 2002:a05:6000:40df:b0:3a5:5130:1c71 with SMTP id
 ffacd0b85a97d-3a6d26ec1c6mr3944019f8f.0.1750443917558; Fri, 20 Jun 2025
 11:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619034257.70520-1-chen.dylane@linux.dev> <20250619034257.70520-2-chen.dylane@linux.dev>
 <CAADnVQLyAeo9ztPoJzU1QJUQf6SMptVNoOzZza02xPuXO1ES2g@mail.gmail.com>
 <9eedd830-9222-4ac0-8ccd-72499fb85b13@linux.dev> <CAADnVQJcdVCKPu8aPPj5hZExNTFYAYTd5xkF=Ljfm__+ugirGg@mail.gmail.com>
 <77b09f48-01d9-46f1-8a31-a1824c0eef8d@linux.dev>
In-Reply-To: <77b09f48-01d9-46f1-8a31-a1824c0eef8d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Jun 2025 11:25:06 -0700
X-Gm-Features: Ac12FXyJkFR8rjBuSo4gLhjDVZGf9JFATvweEAE_aYUr4XayfWPQ7zQy3NpA0jE
Message-ID: <CAADnVQ+SgYop50-1S7424ecRKWDM3R=8cHeizRCjeC_FXdkdLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 8:31=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/6/20 10:59, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Thu, Jun 19, 2025 at 7:46=E2=80=AFPM Tao Chen <chen.dylane@linux.dev=
> wrote:
> >>
> >> =E5=9C=A8 2025/6/20 01:17, Alexei Starovoitov =E5=86=99=E9=81=93:
> >>> On Wed, Jun 18, 2025 at 8:44=E2=80=AFPM Tao Chen <chen.dylane@linux.d=
ev> wrote:
> >>>>
> >>>> Show kprobe_multi link info with fdinfo, the info as follows:
> >>>>
> >>>> link_type:      kprobe_multi
> >>>> link_id:        1
> >>>> prog_tag:       a15b7646cb7f3322
> >>>> prog_id:        21
> >>>> type:   kprobe_multi
> >>>
> >>> ..
> >>>
> >>>> +       seq_printf(seq,
> >>>> +                  "type:\t%s\n"
> >>>> +                  "kprobe_cnt:\t%u\n"
> >>>> +                  "missed:\t%lu\n",
> >>>> +                  kmulti_link->flags =3D=3D BPF_F_KPROBE_MULTI_RETU=
RN ? "kretprobe_multi" :
> >>>> +                                        "kprobe_multi",
> >>>
> >>> why print the same info twice ?
> >>> seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
> >>> in bpf_link_show_fdinfo() already did it in a cleaner way.
> >>>
> >>
> >> link_type only shows 'kprobe_multi', maybe we can show the format like=
:
> >
> > Ohh. Especially so. It would be wrong and confusing to display:
> > link_type:      kprobe_multi
> > type: kretprobe_multi
> >
> > Let's fix 'link_type' to display it properly.
>
> What do you think show like this:
>
>      link_type:      kprobe_multi
>      link_id:        1
>      prog_tag:       33be53a4fd673e1d
>      prog_id:        21
>      retprobe:       false

It leaks implementation details.
For the kernel the link type is BPF_LINK_TYPE_KPROBE_MULTI for retprobe too=
,
but show_fdinfo is for humans.
'link_type:' field can be more precise and differentiate
what's effectively a subtype of the link.

