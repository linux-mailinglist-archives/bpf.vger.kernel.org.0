Return-Path: <bpf+bounces-3262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F78073B86E
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 15:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF0E281B65
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 13:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287A4883C;
	Fri, 23 Jun 2023 13:09:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE918BE0
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:09:03 +0000 (UTC)
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760842129;
	Fri, 23 Jun 2023 06:09:02 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id a1e0cc1a2514c-78f6a9800c9so215222241.3;
        Fri, 23 Jun 2023 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687525741; x=1690117741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2gur0xTyOFyTfCQR7Vs6vSqivbDaTiXYcT1KXbo1Nc=;
        b=o4bdvVEsKnnuG/AUZ+SvBanLkTmh7OmaSbskvWBViOapYz8Hb+CCJs0vrYxtweKowq
         s+L3dmVMbvu3S0GxevKn1CziUe+sCgIYBGgJkbA03IiXylBAxgJnrG/SF2OazQ2LhNPp
         dTIPJWtMA2uA1UzzpyEWhhhQzoQj92nt53lACKdKnmJqYjFJI+2ydY4lcLUxhKz+fVEY
         bwfKbkC8VMeXmHJjF/9bee/i3v/iK1KBTDRXjPhtzxIVEWqGim/K1GNH9Il5vIHkWn8f
         vsA6LAQdkgzKKwXYd4lwlJBmZICDxd4dplKz9+L1VtJ6N6XMti5CkbhZaBNrwzp5qu+u
         IHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687525741; x=1690117741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2gur0xTyOFyTfCQR7Vs6vSqivbDaTiXYcT1KXbo1Nc=;
        b=CRK7DEBFE7GH2hxdbdRHs4V+UVAzSdAexHI+WtXBVcpa4C0seg7SXvnZsNV2hRqGVj
         v0v7Qj72K/XKnGUttGVJjt2NlaHmjdapBhzzqua9AmuRsNOKIFvFgWc+dEE6rpu95Vlw
         fU85RzQ1D0PLA+jFYrZgBd6ai19MqyvO8H7v/lQeEvtXDWTctaTdQdbgQbs8wdpIVUsA
         CL7MZU+qGHCpJQNQMmZfVl9f8tXO39KQuuFhIUeKR9+77FslEwWMaY2qZOJtF3IYzPks
         3A0hHCur7Um2BSWtOa7avVCazRE3A+9wpowEE0cssVI1idxsvQ9wcbiC1RLqzm312MDG
         lX2A==
X-Gm-Message-State: AC+VfDxmkwmgDW5reVoOxjaJLdinX+XZew23XATDrvwB44PW64QQbXWt
	l4coksvy2ZpDGxt4KTCrfjUw6zbo47yyr8jU3n8=
X-Google-Smtp-Source: ACHHUZ721dDUmO3rfpLqG/sIqBq/DqFVJ+cLdKn1aZGWxRXenL5Eu7Vld0XBRnNaL7EAxZcWHwa4QYAB2eJ/HxBYa44=
X-Received: by 2002:a67:d003:0:b0:440:cd04:dba0 with SMTP id
 r3-20020a67d003000000b00440cd04dba0mr7190139vsi.13.1687525741220; Fri, 23 Jun
 2023 06:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613025226.3167956-1-imagedong@tencent.com>
 <20230613025226.3167956-3-imagedong@tencent.com> <ca490974-0c5c-cfe9-0c6f-3ead163e7a7b@meta.com>
 <7a82744f454944778f55c36e8445762f@AcuMS.aculab.com> <CADxym3bY5EcZhuJG=x5s7kH+BS93ySAyvV8yZ7yYoXf7HCsZVw@mail.gmail.com>
 <84050129b8ce4db9b4579be0fc022723@AcuMS.aculab.com>
In-Reply-To: <84050129b8ce4db9b4579be0fc022723@AcuMS.aculab.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 23 Jun 2023 21:08:49 +0800
Message-ID: <CADxym3akFCuMgQTF5kM1THUd8yofc4hVrACYGi3APwySftCtxA@mail.gmail.com>
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

On Thu, Jun 22, 2023 at 10:19=E2=80=AFPM David Laight <David.Laight@aculab.=
com> wrote:
>
> ...
> > > Is that right for 86-64?
> > >
> > > IIRC arguments always take (at least) 64bits.
> > > For any 32bit argument (register or stack) the high bits are undefine=
d.
> > > (Maybe in kernel they are always zero?
> > > From 32bit userspace they are definitely random.)
> > >
> >
> > Hello,
> >
> > According to my testing, the compiler will always
> > pass the arguments on 8-byte size with "push" insn
> > if the count of the arguments that need to be passed
> > on stack more than 1 and the size of the argument
> > doesn't exceed 8-byte. In this case, there won't be
> > garbage. For example, the high 4-byte will be made 0
> > if the size of the argument is 4-byte, as the "push" insn
> > will copy the argument from regs or imm into stack
> > in 8-byte.
>
> You have to know whether a value is expected to be 4 or 8
> bytes - a negative 32bit value is zero extended so can't
> be treated as a 64bit value.
>
> That is even true for values passed in registers.
>
> There is also a common problem with values passed in registers
> to system calls by 32bit code (maybe bpf is tracing these).
> In this case the high 32 bits of the register are random.
> They don't get zerod in 32bit mode.
>
> > If the count of the arguments on-stack is 1 and its size
> > doesn't exceed 4-byte, some compiler, like clang, may
> > not use the "push" insn. Instead, it allocates 4 bytes in the
> > stack, and copies the arguments from regs or imm into
> > stack in 4-byte. This is the case we deal with here.
>
> If the compiler sometimes writes a 4 byte (or smaller) value
> to pre-allocated stack then it is always allowed to do that.
> So the high bytes of the stack slot that contains a 32bit
> argument might always be junk.
> The count of on-stack arguments isn't relevant.
>

Yes, the way we clean garbage values is not
relevant, which comes from assumption. However,
It should be ok with the BPF program? like what Yonghong
said.

> > I'm not sure if I understand you correctly. Do you mean
> > that there will be garbage values for 32bit args?
>
> I'm pretty sure that the function call ABI doesn't require the
> caller set the high bits of sub-64bit arguments.
> The fact that they are often written with a push instruction
> that zeros the high bytes isn't really relevant.
>
> > > I think the called code is also responsible form masking 8 and 16bit
> > > values (in reality char/short args and return values just add code
> > > bloat).
> > >
> > > A 128bit value is either passed in two registers or two stack
> > > slots. If the last register is skipped it will be used for the
> > > next argument.
> > >
> >
> > Yeah, this point is considered in save_args(). Once
> > this happen, the count of stack slots should more
> > then 1, and the arguments on-stack will be stored with
> > "push" insn in 8-byte. Therefore, there shouldn't be garbage
> > values in this case?
> >
> > Do I miss something?
>
> The register/stack for these two calls is the same:
>         foo(1, 2, 3, 4, 5, 6, (int128_t)7);
>         bar(1, 2, 3, 4, 5, (int128_t)7, 6);
>

It is ok, as we already consider such cases. For
the foo(), the order we copy args is:

reg1, reg2, reg3, reg4, reg5, reg6, stack1, stack2

and for the bar (), it is:

reg1, reg2, reg3, reg4, reg5, stack1,stack2, reg6

The order of the arguments in the array we passed
to the BPF program is ok.

Thanks!
Menglong Dong

>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

