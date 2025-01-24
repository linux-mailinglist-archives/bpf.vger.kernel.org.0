Return-Path: <bpf+bounces-49625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A2A1ADBB
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 01:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B9416B968
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 00:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0E31876;
	Fri, 24 Jan 2025 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPHkj03g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9F4C91;
	Fri, 24 Jan 2025 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737677086; cv=none; b=qdiNMQSax7+Zcg2LzEOaMV1mStQH3Co1pWpB/y9KKFX2D5VUDBEre+Qn+6bII8JuhWqzJmd01TUuyo9yxTT6c6KYuLUDvANszNQagofadJHFGax4ZSwB9w0gH9Jl3F2i0mIUFWRX1YO86dOedacfgiV3gxNBqoARZCX2eXYVSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737677086; c=relaxed/simple;
	bh=/0D3zhqHQKPwUIQ3nwIHNussk4FwtKkHQzzM/IBcM4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ/DKiNgVZcecJ9l0jK8RV/5LcaH/g91GyTAggosO/mcTszR++8VkRN/KdRmWY+uttjzXgmpcfelfdxS3qvcKXvkjG/qGQmY+UOa4RfF7OH10yrru8cDb3w9uEccaLVY57YwtagabJsrYfpR+V51wJS4CG9hw27wg4dnAXvpfyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPHkj03g; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso2270943276.2;
        Thu, 23 Jan 2025 16:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737677083; x=1738281883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnjhNl+gxwgNIARGeSMd9goOS9xLJvXCt/qd2UtdTFg=;
        b=cPHkj03gKR9Q5+KNDgNUuLtW9joKznqnWhYwT62KPw2CD4TV5AFcuaAX9TygZOHNuo
         B7uoAH6OtU8tx2xRx1k5nxi4cCMv6TjPuFeIZZf9asKl123gA6ksMjfHtmbTjYtjBUVI
         kB2qqF29pO4C/ydDZIURT+oFodkE25/01eo1bEJoovpjgP1vCvGxb1X3uuMSOXe3bxYf
         CtyTE7bPLAOB0WorK2ld/FCFgMhJ6p0odk8+HgiZMys+aMd5WKEBkKgq+Yvp4ldlR7HU
         qrYn2sj/Mp5LsWe4gHBlHkOvlF0wJTuuho3kcjAeivO0mlOANyIgW1AInatXiNjCdjnk
         cnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737677083; x=1738281883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnjhNl+gxwgNIARGeSMd9goOS9xLJvXCt/qd2UtdTFg=;
        b=ghgdFR57pijYEe1ru7hkZbKF1wTMlT2zZvXpG2W4GL8kKFrt0+BSn11MUXs/8ELclX
         wtsMOGcXqhabM9upAi5yzif2hBWOoe5LomM9x5PK4X5zcFtRHRniUHPR7Gts/Py+NmWg
         4LdlWAh9Gqjz0sPafoNAM5yvh8PzVaGYtMg7GUmKQ1bg1N0Fk2jsx/vVT58T6LOGT5yF
         KJylNYpmWxM+KVKVYBwfrwwKe4OxZ2/dW0nymLTm2spBCgaQU+slxhEI0jI2eQdzPaHN
         7807HsDN50dV0PURqtQG8qIqS6ZQXIK0gkQNx7SMn6nZHP1HCNiC09QFvWMhdEpluoOf
         e+7A==
X-Forwarded-Encrypted: i=1; AJvYcCWI5PwgARCdKamaEcRBu4i5Cjvn+3k3R1EWGnrQ+SSMXdieeDTjfrZlXlfmtMOxuDxY3Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5ne3++bP3gwyd9qnT1iTllDRrZr/XAU4HLyztKoekCc1oBUQ
	nO2Eze822ZJNgMQHWAs7wNyMQ6c+LOxiHr23fz6vYhIN2JlNgNpa8kIZ3uWoRGS98cnd+Eux0Ua
	rtZYCbdyOcu+Q+SrljtGuFIQbz3s=
X-Gm-Gg: ASbGncttQDfxrU/xL0kRQhWCANJMyd+Ostd9ANxrHHfS21hjjrMUOsQoDjSBg+C2SVQ
	SjKuLmX4ILHdpGVLpm4Tftyw37IWpGinDn38nslB7FSl9NaLzxD4L5RiUoBLRYA==
X-Google-Smtp-Source: AGHT+IGIJlySrDpdq4YBS5+Dt2KkbNTPhmh6kQMDMIrzAOSrpMCo1bHXY2Rw0hXIRBFvrHo2mOXKNYy71mp+Gqrrw84=
X-Received: by 2002:a05:6902:d48:b0:e58:118a:99e4 with SMTP id
 3f1490d57ef6-e58118a9aa4mr7977035276.15.1737677083197; Thu, 23 Jan 2025
 16:04:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220195619.2022866-1-amery.hung@gmail.com>
 <20241220195619.2022866-3-amery.hung@gmail.com> <16c2f9b5d9c91bf5b8ee8c18a17c9cf846b394e8.camel@gmail.com>
In-Reply-To: <16c2f9b5d9c91bf5b8ee8c18a17c9cf846b394e8.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Jan 2025 16:04:32 -0800
X-Gm-Features: AbW1kvbLWwtMPLz0NYtfCcdzmzGNSL_JElPULxk-Cb_p-39Tf56At0ZLItdOlRA
Message-ID: <CAMB2axOoFbgQsEeLqdtpfWY=4g7yCxO19t8orxa5Ao6gNTXiDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/14] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, 
	amery.hung@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-12-20 at 11:55 -0800, Amery Hung wrote:
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fa=
il__global_subprog.c b/tools/testing/selftests/bpf/progs/struct_ops_refcoun=
ted_fail__global_subprog.c
> > new file mode 100644
> > index 000000000000..43493a7ead39
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__glo=
bal_subprog.c
> > @@ -0,0 +1,37 @@
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "../test_kmods/bpf_testmod.h"
> > +#include "bpf_misc.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +extern void bpf_task_release(struct task_struct *p) __ksym;
> > +
> > +__noinline int subprog_release(__u64 *ctx __arg_ctx)
> > +{
> > +     struct task_struct *task =3D (struct task_struct *)ctx[1];
> > +     int dummy =3D (int)ctx[0];
> > +
> > +     bpf_task_release(task);
> > +
> > +     return dummy + 1;
> > +}
> > +
> > +/* Test that the verifier rejects a program that contains a global
> > + * subprogram with referenced kptr arguments
> > + */
> > +SEC("struct_ops/test_refcounted")
>
> Nit: I'd add a __msg("Validating subprog_release() func#1...")
>      before the error message match, just to make sure that
>      error is reported when subprog_release() is verified.
>

I see. I will add the msg match.

> > +__failure __msg("invalid bpf_context access off=3D8. Reference may alr=
eady be released")
> > +int refcounted_fail__global_subprog(unsigned long long *ctx)
> > +{
> > +     struct task_struct *task =3D (struct task_struct *)ctx[1];
> > +
> > +     bpf_task_release(task);
> > +
> > +     return subprog_release(ctx);
> > +}
> > +
> > +SEC(".struct_ops.link")
> > +struct bpf_testmod_ops testmod_ref_acquire =3D {
> > +     .test_refcounted =3D (void *)refcounted_fail__global_subprog,
> > +};
>
> [...]
>

