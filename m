Return-Path: <bpf+bounces-37798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D569295A8EF
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C74F1F23503
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24555684;
	Thu, 22 Aug 2024 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN3/UrD5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE24C74
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286886; cv=none; b=Sqfdck+m0w4J2RMqeU8SINbEx+t73OQdf2IMLVpnO1LkQYgU0407qA/JxvgaHv8KkP9LxLPSa299ZXvzBOVPeN9/BJzvI6lTzfI6J1lRxoCN+m722/yRvmwK5229IIUt9ddCo+/PwbYcZD8TvZafhSTHCOYeZAYBqo469vEQJuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286886; c=relaxed/simple;
	bh=Qn8oIly/4t35JwucsWZxRyNIEc3Ou/6Q60WX0BFvJb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miKSdClH2T60BsJUCWejnlQ/EwbMCD9yMA2c2H5Cjiqkpy4NV6rQe+5IikIBlg5C6fgcKJw68tcH+ABAKpns3lQks+tRqPH0Qv2B8LDkmKqb44pFfHH3SJoxnncOJ8NTSnJLF9WCNLB6bA1W9bDIkAF11aHqhKCT656aLbG7ZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TN3/UrD5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso78198f8f.0
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286883; x=1724891683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HaOM1QXu+SU5pE92W00p02IkBYHhpn9oQlF7eHfMKM=;
        b=TN3/UrD5B6PlkZTPypUk6c4o55J6sc1m+ouJMCV9kf7u/qz/KQJp4VM4AVxKFIBlBp
         VymFsQvmC7vOUOPcy9zqsY//gwgulua6BWOfOl+t5T9UwfFMNutCbr+tIwQABLO8tIO6
         +grfUg2ahRiCVq00Hj2oRAxC73Q5rFPTzujPzPT21JJP9OHlJTYBOw1wUQYl+0kEGEtE
         v7GdI1eiZNdDCj8neNuphang6do5G7+QJVunWepwJZyf6ig3Xu4RwqV3RPUIHFe/WYmG
         Y/fCmEW/n4uApGkNQdhDMFBaHc5WWWH/f0wBQRFjI+8lEbqKqG74GgeFEI910rvuRf4l
         6Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286883; x=1724891683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HaOM1QXu+SU5pE92W00p02IkBYHhpn9oQlF7eHfMKM=;
        b=m+D+CjYPfolm+51+LxSd4tTngP70W5oZbh27OJ7mszj5b6PI1djxT39WL2dfvfEfZX
         U44Y8jC/H5C7K3k7W99VjbHeE8ajW6TcWFd5FLevsAsDcEvyAZCle1BE3Gq3lGWix+LW
         lD2ZNz7rLo/pq8wi7mvUI4u/rGyE16Hl1VgpiWXIcfoGmqu3QsovgzwKLug7IvjWET0P
         JlQS+j7MtUCmR+q3luzuCr4+UxcEcKuXF/frTjBHclFz8iqCOrFHMR1uBjI9gcI7kxlz
         W/W1BabV5y2ZVELzPJh1tsW3mMinuHWKhJg8Sq1dEDbEa3+05eNjEKbVNmIDdHzU3OqW
         MCBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvnKHOXlljywcoXSd8UHpjwOvFiSghACQT08GoTJFb7swvxLmRWmXhcVd/x7/0NB5YNdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+46bZTC+UnSn/j9SogeCN27Zv8JORbmVywVxzFL+pXHhiwJz
	vxM2M8Y5HwqGwDgizqnTlx3cOpPE6yV8k19IJbldyo6to9sXfeKIKxBYsH+dLWP0pWzJeMy91t7
	FAw5xTucXAwauwcn3PG9FiFZFpOA=
X-Google-Smtp-Source: AGHT+IHvjHnDrT/ZAD1K9U5CcBzDcNdayybn1wrCGQlANEY5FgW4gT/e3W0gX2Bx1Rsinh29XBh6eaRXrPk8UI4BOO4=
X-Received: by 2002:a05:6000:1283:b0:363:e0e2:eeff with SMTP id
 ffacd0b85a97d-372fd599958mr2646152f8f.20.1724286882802; Wed, 21 Aug 2024
 17:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821233440.1855263-1-martin.lau@linux.dev>
 <20240821233440.1855263-2-martin.lau@linux.dev> <CAADnVQKgT_vJJfOnFdTa6Gpf8s+_D79DwtT8pNzxfw2H4aq1Fg@mail.gmail.com>
 <958b4d92363729f1bed444bc1f4a7d58a54275b1.camel@gmail.com>
In-Reply-To: <958b4d92363729f1bed444bc1f4a7d58a54275b1.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 17:34:31 -0700
Message-ID: <CAADnVQ++V49=-_bK_dSvxG-WxYEOT=3m1u8tQH1ArALKDy+WhA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: Add gen_epilogue to bpf_verifier_ops
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Amery Hung <ameryhung@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:30=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-08-21 at 17:22 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > > +       if (ops->gen_epilogue) {
> > > +               epilogue_cnt =3D ops->gen_epilogue(epilogue_buf, env-=
>prog,
> > > +                                                -(subprogs[0].stack_=
depth + 8));
> > > +               if (epilogue_cnt >=3D ARRAY_SIZE(epilogue_buf)) {
> > > +                       verbose(env, "bpf verifier is misconfigured\n=
");
> > > +                       return -EINVAL;
> > > +               } else if (epilogue_cnt) {
> > > +                       /* Save the ARG_PTR_TO_CTX for the epilogue t=
o use */
> > > +                       cnt =3D 0;
> > > +                       subprogs[0].stack_depth +=3D 8;
> > > +                       insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_R=
EG_FP, BPF_REG_1,
> > > +                                                     -subprogs[0].st=
ack_depth);
> > > +                       insn_buf[cnt++] =3D env->prog->insnsi[0];
> > > +                       new_prog =3D bpf_patch_insn_data(env, 0, insn=
_buf, cnt);
> > > +                       if (!new_prog)
> > > +                               return -ENOMEM;
> > > +                       env->prog =3D new_prog;
> > > +                       delta +=3D cnt - 1;
> >
> > I suspect this is buggy.
> > See commit 5337ac4c9b80 ("bpf: Fix the corner case with may_goto and
> > jump to the 1st insn.")
>
> Actually, I was unable to figure out a counter example for this case,
> patching math seems to be correct, jump targets are just moved down.
> But let's see, maybe Martin can come up with something.

Something like
insn_0
...
r1 =3D 0
if rX =3D=3D .. goto insn_0

this jmp will be rewritten to point to newly added *(u64*)(r10 - ..) =3D r1

so at run time it will overwrite that slot with zero and
epilogue will read zero from it instead of ctx.

