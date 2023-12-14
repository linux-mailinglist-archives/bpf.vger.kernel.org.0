Return-Path: <bpf+bounces-17831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF15813282
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7D81C213ED
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDDB59E3B;
	Thu, 14 Dec 2023 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoQiwjyv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C50F9C;
	Thu, 14 Dec 2023 06:07:37 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-dbc72b692adso4762363276.2;
        Thu, 14 Dec 2023 06:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702562856; x=1703167656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op8he/8Qs5NIMGtDMiZ0WWcmXVLEsh50AfCUSigfWXg=;
        b=CoQiwjyvywkQC3zuNfaVrUfWEgjGpjapVM1r1c8SLOf0aSDH6cIcAvQg3u+aDpKhiE
         ckLYw8RK49mXldgbyShDuoIQ90aCHAxaa8BkJPXXllRBZn3pSQVa7lUx9dfrKwgoUnRT
         aIs9r3dlG7P0dQ9QhKCxaamu96pf+Lvb3zw3DM2GKJayoFA7KoEzpZ2oCzUcuvTA+/6H
         RCJ9fKzuTHFmMWc57b+9MWlN+9eWES7FFSQPrR7hFAqBAgGB0ISmwoQWjAJezKwfjnxJ
         Re4pVhyLvdR0AtfjgEryp+W16Z2nBjCJ2cld5g0f0C/jfpc346EPMRqCCGeIK88dg0dE
         2Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562856; x=1703167656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=op8he/8Qs5NIMGtDMiZ0WWcmXVLEsh50AfCUSigfWXg=;
        b=CmnXPgBvryJwH6ANRLVBkglT/cXcSnu9egS60iJvjafHZ7NBB9pawcs3hMdQsFHyq8
         RdnnfcToOUAQ2b8FbLbyQcvfgt4hCLAgXXdabn2092n1GhkuhKgEWcVZsUTPzJKUSt16
         RoKyizv8Fpmf+CPXcj+oVCfwJ8aSQ4ABm5jryIWBKZPkmgcDXs0lKxYY57VbLBTnbOt2
         hHAd7+uf2pauSpU3Hn6wYszR1dWXL5JAipiS8rlSa1fr3XVVnCoIM92NHiwTdBbDN0Bh
         WdNYN/I0OjHwH3ZZJf5dl3QfAQbstOTIWRJMWFW2F7gE0d8sJUFo+W7BgyQAA1cy1NB1
         t8hw==
X-Gm-Message-State: AOJu0YxuL2D/r857wxAe+bfZxKXtgYAGxcrfrN1NGKzU9O9oZ567v5Mu
	dc5KqCL6FeW44TdMr6u+ROQTrIMKQkjxlVc+mcs=
X-Google-Smtp-Source: AGHT+IHgEH0XljIaWIJ8jUxF/Yb+GUZNJi9vaq9gm2PHR7XtY8FjscgT+wYHR586Pmu8anNmnxXhQ1nB7TUGIBShFNQ=
X-Received: by 2002:a25:c702:0:b0:db7:dacf:3fc2 with SMTP id
 w2-20020a25c702000000b00db7dacf3fc2mr6129292ybe.111.1702562856108; Thu, 14
 Dec 2023 06:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214062434.3565630-1-menglong8.dong@gmail.com>
 <20231214062434.3565630-2-menglong8.dong@gmail.com> <CAADnVQ+kKxj2hg33CzH_iXdH5fs8wjwpkPP-Jjh41weqf9BEwA@mail.gmail.com>
In-Reply-To: <CAADnVQ+kKxj2hg33CzH_iXdH5fs8wjwpkPP-Jjh41weqf9BEwA@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 14 Dec 2023 22:07:24 +0800
Message-ID: <CADxym3Z1=6R8x7==wMfMA6N+Ha9VtOdpiw5LP7z4frW3=sYjCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: make the verifier tracks the "not
 equal" for regs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Dec 14, 2023 at 9:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 13, 2023 at 10:28=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > We can derive some new information for BPF_JNE in regs_refine_cond_op()=
.
> > Take following code for example:
> >
> >   /* The type of "a" is u16 */
> >   if (a > 0 && a < 100) {
> >     /* the range of the register for a is [0, 99], not [1, 99],
> >      * and will cause the following error:
> >      *
> >      *   invalid zero-sized read
> >      *
> >      * as a can be 0.
> >      */
> >     bpf_skb_store_bytes(skb, xx, xx, a, 0);
> >   }
>
> Please craft a selftest from above with inline asm
> (C might not work as compiler might optimize it)

Okay! Should I add this selftests to reg_bounds as a subtest,
or add a "verifier_reg_edge.c" for verifier testing?

> Also we call:
>         /* fallthrough (FALSE) branch */
>         regs_refine_cond_op(false_reg1, false_reg2,
> rev_opcode(opcode), is_jmp32);
>         /* jump (TRUE) branch */
>         regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
>
> so despite BPF_JNE is not handled explicitly it still should have
> caught above due to rev_opcode() ?

Ennn.....I'm a little confused. In this case, the TRUE path is
handled properly, as the opcode is BPF_JEQ; and the FALSE
is not handled properly, as the opcode is rev_opcode(BPF_JEQ),
which is BPF_JNE. And the bpf_skb_store_bytes() will be called
in the FALSE path. The origin state of false_reg* should be the same
as true_reg*.

