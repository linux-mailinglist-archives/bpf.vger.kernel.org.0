Return-Path: <bpf+bounces-16165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CA57FDDDD
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 18:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0564CB20F8E
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059483B79C;
	Wed, 29 Nov 2023 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8DcIBOS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34018B6
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 09:01:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-332cb136335so28773f8f.0
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 09:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701277274; x=1701882074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ro32rvbSXFPUgcvcu8vSVPFr0plmQhSXQyZRUyDDug=;
        b=f8DcIBOSPiAGdHzcqboKFYTNJKZDtZRSrV5yHCzE2tpuPIHKDDOjDL90EtoXqBBN9e
         UpWF6eSPBnosRQr1VTpaAy5sYr7fRg6mwNDC/MKVL78ZYavx64zQZ72AC442Kb6UHMwo
         /IvDzZTSrp2sb6CMVHhlFx9CQURR6A/Kx58Qhc4S+5D3WlhsqmBFSak59a1uzG+ewdb8
         t6fmII5g04hDjC8+a1zsJEmpiFKJeSyMIkG7co4jlmaDgDPBFJigA5d2AbxaEZP4Y/Rc
         +YZHzEHo/g5UJqADJwgZL09RHub3ej/qsj1R1OBJ8LSfwFFi7nLBq6yBLEeQzYclMteA
         kh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277274; x=1701882074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ro32rvbSXFPUgcvcu8vSVPFr0plmQhSXQyZRUyDDug=;
        b=GQ78amYEZaxRm2KwMaCmLIgCl/+DF7KfLZVwaEF4jRgJYYvZz4GwO6a1ZC9SCW8ShH
         FtqNwWpLKar/3AWmJPfIG741uNzRrtla7JBa2LineZCei+T5NNQlGMbiDoxhznKpxlgR
         CYQOgrYHlCGILBlouHAvxKkCSWwtRyfsti9qOowLX0UTRviwVUVtIbNoUd//ZJLR4zPw
         M9RVs0gdG7O2RXxBfDSjXaEchKM6mXrJ1By5jKSYxkZhjYkqiZXIRlMV+1OXXYXxTXYl
         pEu7faQUV91XWhZ3XCb0VSjbinUkhC1gEsCCqqgUZd+AIsWFC6KRr81OHmbSAGyTG0ak
         11eQ==
X-Gm-Message-State: AOJu0YxYc9Yb8w/fL2UgU4csDD7FDBEIpIrCzzat74UVA86W75QQHs81
	DYioH64Z92J2CPLXwMpW6nQIuDAeVCs85i2I9jw=
X-Google-Smtp-Source: AGHT+IHzEVtGA+C8+2hYjTSk/XqsgehvrH4AFrn3bw5tIlzr7zhAImRVxx1d+aQVKb2wBG3ExOr+qHFU4lphBHZLz8Q=
X-Received: by 2002:a5d:4b45:0:b0:332:fd0f:b2d9 with SMTP id
 w5-20020a5d4b45000000b00332fd0fb2d9mr8708231wrs.18.1701277274370; Wed, 29 Nov
 2023 09:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87leahx2xh.fsf@oracle.com> <3733942b-f0ef-4e71-8c49-aa4177e9433c@linux.dev>
 <87jzq1t4sk.fsf@oracle.com> <a1073bd0-9df2-4a9e-900c-7e8ac63ac464@linux.dev>
In-Reply-To: <a1073bd0-9df2-4a9e-900c-7e8ac63ac464@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Nov 2023 09:01:03 -0800
Message-ID: <CAADnVQJjQDQBNHZzpuBZfQdfeqGSX9_Y106PDgiY=bi-S0Wsqw@mail.gmail.com>
Subject: Re: BPF GCC status - Nov 2023
To: Yonghong Song <yonghong.song@linux.dev>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:44=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 11/29/23 2:08 AM, Jose E. Marchesi wrote:
> >> On 11/28/23 11:23 AM, Jose E. Marchesi wrote:
> >>> [During LPC 2023 we talked about improving communication between the =
GCC
> >>>    BPF toolchain port and the kernel side.  This is the first periodi=
cal
> >>>    report that we plan to publish in the GCC wiki and send to interes=
ted
> >>>    parties.  Hopefully this will help.]
> >>>
> >>> GCC wiki page for the port: https://gcc.gnu.org/wiki/BPFBackEnd
> >>> IRC channel: #gccbpf at irc.oftc.net.
> >>> Help on using the port: gcc@gcc.gnu.org
> >>> Patches and/or development discussions: gcc-patches@gnu.org
> >> Thanks a lot for detailed report. Really helpful to nail down
> >> issues facing one or both compilers. See comments below for
> >> some mentioned issues.
> >>
> >>> Assembler
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [...]
> >>
> >>> - In the Pseudo-C syntax register names are not preceded by % charact=
ers
> >>>     nor any other prefix.  A consequence of that is that in contexts =
like
> >>>     instruction operands, where both register names and expressions
> >>>     involving symbols are expected, there is no way to disambiguate
> >>>     between them.  GAS was allowing symbols like `w3' or `r5' in synt=
actic
> >>>     contexts where no registers were expected, such as in:
> >>>
> >>>       r0 =3D w3 ll  ; GAS interpreted w3 as symbol, clang emits error
> >>>
> >>>     The clang assembler wasn't allowing that.  During LPC we agreed t=
hat
> >>>     the simplest approach is to not allow any symbol to have the same=
 name
> >>>     than a register, in any context.  So we changed GAS so it now doe=
sn't
> >>>     allow to use register names as symbols in any expression, such as=
:
> >>>
> >>>       r0 =3D w3 + 1 ll  ; This now fails for both GAS and llvm.
> >>>       r0 =3D 1 + w3 ll  ; NOTE this does not fail with llvm, but it s=
hould.
> >> Could you provide a reproducible case above for llvm? llvm does not
> >> support syntax like 'r0 =3D 1 + w3 ll'. For add, it only supports
> >> 'r1 +=3D r2' or 'r1 +=3D 100' syntax.
> > It is a 128-bit load with an expression.  In compiler explorer, clang:
> >
> >    int
> >    foo ()
> >    {
> >      asm volatile ("r1 =3D 10 + w3 ll");
> >      return 0;
> >    }
> >
> > I get:
> >
> >    foo:                                    # @foo
> >            r1 =3D 10+w3 ll
> >            r0 =3D 0
> >            exit
> >
> > i.e. `10 + w3' is interpreted as an expression with two operands: the
> > literal number 10 and a symbol (not a register) `w3'.
> >
> > If the expression is `w3+10' instead, your parser recognizes the w3 as =
a
> > register name and errors out, as expected.
> >
> > I suppose llvm allows to hook on the expression parser to handle
> > individual operands.  That's how we handled this in GAS.
>
> Thanks for the code. I can reproduce the result with compiler explorer.
> The following is the link https://godbolt.org/z/GEGexf1Pj
> where I added -grecord-gcc-switches to dump compilation flags
> into .s file.
>
> The following is the compiler explorer compilation command line:
> /opt/compiler-explorer/clang-trunk-20231129/bin/clang-18 -g -o /app/outpu=
t.s \
>    -S --target=3Dbpf -fcolor-diagnostics -gen-reproducer=3Doff -O2 \
>    -g -grecord-command-line /app/example.c
>
> I then compile the above C code with
>    clang -g -S --target=3Dbpf -fcolor-diagnostics -gen-reproducer=3Doff -=
O2 -g -grecord-command-line t.c
> with identical flags.
>
> I tried locally with llvm16/17/18. They all failed compilation since
> 'r1 =3D 10+w3 ll' cannot be recognized by the llvm.
> We will investigate why llvm18 in compiler explorer compiles
> differently from my local build.

Is that a different issue from:
https://github.com/compiler-explorer/compiler-explorer/issues/5701
?

