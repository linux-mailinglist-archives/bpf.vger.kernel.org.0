Return-Path: <bpf+bounces-3141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869BC73A173
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 15:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6855E1C21098
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A101ED27;
	Thu, 22 Jun 2023 13:06:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB01DCB0
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 13:06:39 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2972111;
	Thu, 22 Jun 2023 06:06:11 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 3f1490d57ef6-bff0beb2d82so1614864276.2;
        Thu, 22 Jun 2023 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687439166; x=1690031166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGsYjRdIk+qTEW9g8j9uHVQZ+FPzEP6/mOPSgQ8KtbM=;
        b=nf9I1PNF0yDYNhtU8M4SAhuCDuln7HMvgdjLpIGLbxc1or0A8Fyo4q4MoIMsYDRV6M
         TzKi2rnw4268I0d3S8sOv6bfY/ZgbuTaZkhuhdvzhxwpZep7KnbFOXrSudVP+7nMveKi
         bbW0u02XKYK1gnoygyCClchPRqtEDIf7pLRfeAAUZMFQ3eovxq1fxyFx95fJi/pZRPO3
         RPq41Nc1X8GGuTOmgeUUyGnl7XEvZi5hkGzkIE6cQw3jcaRLIgKFOPWBM68QghgQuSST
         J583sL7duIAihSBfzYcWLBjCJAHPli0nLE+CJFFkpDgIoQ4g8LLY5PU/CpnGIFqr8xhq
         LHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439166; x=1690031166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGsYjRdIk+qTEW9g8j9uHVQZ+FPzEP6/mOPSgQ8KtbM=;
        b=aEcQhnpOdwo4OAzcAHCjsJj8HtlTD23dO3/OHmQYqjX10kva+bXeyBlAQY1IoEnA79
         l3RncX1YR2gOIMtngJl01pdy0ydKYDzgPynJg6pIM8twuor+pwgRgXQ3mJ8tZ7ML0n8k
         hx/5zmuLWxatgzh8ElXmKUQCEs1uSG9FlKNMzfYiaGh1kQw/Cq0cimfl6zhwTOzN6dge
         F0G+KUl8PSqXbq8X/uXjUt7BSzV56/TxttVJo5cDi6awPf9TUiG/MziSUcET5rWiLcdy
         MQfNkOajiy8ruxkxKw8FWph951fL7dfVjzUYIdhzVSU5OuaDp8vn7pns8SREyNPfEf8D
         +w2w==
X-Gm-Message-State: AC+VfDxMjyZzpZm4ljLsZn7f255yMdbpV23WMa4jMcDzoevAQyk07yH1
	+OmYeD/evmSZ2ecifKooa449emtLPuyhpraA7aI=
X-Google-Smtp-Source: ACHHUZ5KSghISn3pwe8gSN85pDUGy8BHrYbLpNXm41RpUFJvHEAY5V51R2chH9Prr68OMh7ME5lL+95Cj3VTjIMBHV0=
X-Received: by 2002:a25:800c:0:b0:bc5:edbe:8b43 with SMTP id
 m12-20020a25800c000000b00bc5edbe8b43mr13980225ybk.25.1687439166522; Thu, 22
 Jun 2023 06:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613025226.3167956-1-imagedong@tencent.com>
 <20230613025226.3167956-3-imagedong@tencent.com> <ca490974-0c5c-cfe9-0c6f-3ead163e7a7b@meta.com>
 <7a82744f454944778f55c36e8445762f@AcuMS.aculab.com>
In-Reply-To: <7a82744f454944778f55c36e8445762f@AcuMS.aculab.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 22 Jun 2023 21:05:55 +0800
Message-ID: <CADxym3bY5EcZhuJG=x5s7kH+BS93ySAyvV8yZ7yYoXf7HCsZVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] bpf, x86: allow function arguments up to
 12 for TRACING
To: David Laight <David.Laight@aculab.com>
Cc: Yonghong Song <yhs@meta.com>, 
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "benbjiang@tencent.com" <benbjiang@tencent.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 5:06=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> ...
> > > +   /* Generally speaking, the compiler will pass the arguments
> > > +    * on-stack with "push" instruction, which will take 8-byte
> > > +    * on the stack. On this case, there won't be garbage values
> >
> > On this case -> In this case. The same for below another case.
> >
> > > +    * while we copy the arguments from origin stack frame to current
> > > +    * in BPF_DW.
> > > +    *
> > > +    * However, sometimes the compiler will only allocate 4-byte on
> > > +    * the stack for the arguments. For now, this case will only
> > > +    * happen if there is only one argument on-stack and its size
> > > +    * not more than 4 byte. On this case, there will be garbage
> > > +    * values on the upper 4-byte where we store the argument on
> > > +    * current stack frame.
>
> Is that right for 86-64?
>
> IIRC arguments always take (at least) 64bits.
> For any 32bit argument (register or stack) the high bits are undefined.
> (Maybe in kernel they are always zero?
> From 32bit userspace they are definitely random.)
>

Hello,

According to my testing, the compiler will always
pass the arguments on 8-byte size with "push" insn
if the count of the arguments that need to be passed
on stack more than 1 and the size of the argument
doesn't exceed 8-byte. In this case, there won't be
garbage. For example, the high 4-byte will be made 0
if the size of the argument is 4-byte, as the "push" insn
will copy the argument from regs or imm into stack
in 8-byte.

If the count of the arguments on-stack is 1 and its size
doesn't exceed 4-byte, some compiler, like clang, may
not use the "push" insn. Instead, it allocates 4 bytes in the
stack, and copies the arguments from regs or imm into
stack in 4-byte. This is the case we deal with here.

I'm not sure if I understand you correctly. Do you mean
that there will be garbage values for 32bit args?

> I think the called code is also responsible form masking 8 and 16bit
> values (in reality char/short args and return values just add code
> bloat).
>
> A 128bit value is either passed in two registers or two stack
> slots. If the last register is skipped it will be used for the
> next argument.
>

Yeah, this point is considered in save_args(). Once
this happen, the count of stack slots should more
then 1, and the arguments on-stack will be stored with
"push" insn in 8-byte. Therefore, there shouldn't be garbage
values in this case?

Do I miss something?

Thanks!
Menglong Dong

>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

