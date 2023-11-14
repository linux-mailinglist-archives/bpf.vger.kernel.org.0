Return-Path: <bpf+bounces-15078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1E27EB955
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 23:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18653B20B61
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE91B2E84C;
	Tue, 14 Nov 2023 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OcgvZer1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2852E83A
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 22:29:45 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF65C2
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 14:29:42 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da077db5145so6147306276.0
        for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 14:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700000982; x=1700605782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m2C5AF06LLbDrx4dhwImo+D4UCXJPL3A9jEdY1i/dg=;
        b=OcgvZer1Xjh8ibtRjjVhy87ZoO+kZ+yIqvtgWEw1pbd3z8k1hIgFGQgYG8ZglerIg9
         SujcxsUIffUSF7deJQZG/+K8H8QABKaMjj7tq5nMLnGbfM3QQ+OXLGz+zqBjRgoiGFTo
         BNED5QzV6RgYEysJFItB5OXBUItpjSFcLzsTs0eMimMlg2Swfadtmdd718SBEY59KrPl
         REQQXxktSuetmo16V4YpHAo6Fa535sYd3fSXXxUaOxFuTZAYuY0eWFeSqqVIemDN8eKi
         PQt29kuIeqGDALzpop6rzA/ob/6A66seCq5Iro13YVdCQNbxje0U8VEZLHqUHkGBEF+V
         TLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700000982; x=1700605782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8m2C5AF06LLbDrx4dhwImo+D4UCXJPL3A9jEdY1i/dg=;
        b=hoBrC2k+0C4rJMdKiFyFapPHTIV8I1eZqBO8aXhNoqjYa6TAptaZoSBSbSMGTG7/Ey
         QDtzE1NYC0tUUta85qvOUaWoGkF9N8pNrEAn7nWWV8xiztREIzoqetENNOFe/KOyhwJs
         Kf8Ir0RzXaNVr3tbZeq31uG70M+H5YhLz+6kmW4Un9LY0sQ0ghvA4y5IxlOMxC5gqYJP
         cu+g+lDsLkiXEbihZh5ucdqtCjGOc8QcmtQmm1merb2QkiohyFMfeMPlk0OVsYj1FAJS
         tBBJcfbOKk+CiZHVa8ah80L7TTDrSmibA8NbzWeysYdUQJpBLASrmr+jqJcgzFilCFCh
         bbww==
X-Gm-Message-State: AOJu0Yxl82xy5zvVpbRRgodJJ+aEUppI3Ib8vwkFD2bblUEjeQjOp26H
	/5l5VHqa7+cvAVaS/gCBv32C8bY6jGFz5J8As8Nu
X-Google-Smtp-Source: AGHT+IFktH1BDvQk5K0CnKaxiNtkvJJT2i1HhwXi0VPzmqWO2vnjfDVji3Lj2M3BMSrcxJON0bMCwsKYkGnwkANW1L0=
X-Received: by 2002:a25:b184:0:b0:d9a:d894:7b51 with SMTP id
 h4-20020a25b184000000b00d9ad8947b51mr10230296ybj.57.1700000981765; Tue, 14
 Nov 2023 14:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024161432.97029-2-paul@paul-moore.com> <a5650045-164f-4bff-b688-ddbc66dc95c4@canonical.com>
 <CAHC9VhR-5uK=D0r3zDDsHegjiEqEuhsBhBqLTZ7Xm2PPup64oA@mail.gmail.com>
 <CAGudoHEAes9Avq4EKqNCFwKd_AQPhQE4v6Z3LYCZasJqQXKtjA@mail.gmail.com>
 <20231114092903.GA590929@alecto.usersys.redhat.com> <CAGudoHEDXaPTN1icH64Ff9rOJPJmr6ek-nCUhWtzUb0JqbXDzw@mail.gmail.com>
In-Reply-To: <CAGudoHEDXaPTN1icH64Ff9rOJPJmr6ek-nCUhWtzUb0JqbXDzw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Nov 2023 17:29:30 -0500
Message-ID: <CAHC9VhSjJ+ZgScF9f=8Fyovn15tKgaqFdV1qZxp=RWiuZSAdAA@mail.gmail.com>
Subject: Re: [PATCH v2] audit: don't take task_lock() in audit_exe_compare()
 code path
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Artem Savkov <asavkov@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	audit@vger.kernel.org, Andreas Steinmetz <anstein99@googlemail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 5:33=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> On 11/14/23, Artem Savkov <asavkov@redhat.com> wrote:
> > On Tue, Oct 24, 2023 at 07:59:18PM +0200, Mateusz Guzik wrote:
> >> For the thread to start executing ->mm has to be set.
> >>
> >> Although I do find it plausible there maybe a corner case during
> >> kernel bootstrap and it may be that code can land here with that
> >> state, but I can't be arsed to check.
> >>
> >> Given that stock code has an unintentional property of handling empty
> >> mm and this is a bugfix, I am definitely not going to protest adding a
> >> check. But I would WARN_ONCE it though.
> >
> > There is a case when this happens. Below is the trace I get when
> > unloading a bpf program of type BPF_PROG_TYPE_SOCKET_FILTER while there
> > is an audit exe filter in place. So maybe the WARN shouldn't be there
> > after all?
> >
> > [  722.833206] ------------[ cut here ]------------
> > [  722.833902] WARNING: CPU: 1 PID: 0 at kernel/audit_watch.c:534
> > audit_exe_compare+0x14d/0x1a0
> [snip]
> > [  722.836308] Call Trace:
> > [  722.836343]  <IRQ>
> > [  722.836375]  ? __warn+0xc9/0x350
> > [  722.836426]  ? audit_exe_compare+0x14d/0x1a0
> > [  722.836485]  ? report_bug+0x326/0x3c0
> > [  722.836547]  ? handle_bug+0x3c/0x70
> > [  722.836596]  ? exc_invalid_op+0x14/0x50
> > [  722.836649]  ? asm_exc_invalid_op+0x16/0x20
> > [  722.836721]  ? audit_exe_compare+0x14d/0x1a0
> > [  722.838368]  audit_filter+0x4ab/0xa70
> > [  722.839965]  ? perf_event_bpf_event+0xf1/0x490
> > [  722.841562]  ? __pfx_audit_filter+0x10/0x10
> > [  722.843157]  ? __pfx_perf_event_bpf_event+0x10/0x10
> > [  722.844757]  ? rcu_do_batch+0x3d7/0xf50
> > [  722.846330]  audit_log_start+0x28/0x60
> > [  722.847870]  bpf_audit_prog.part.0+0x3c/0x150
> > [  722.849398]  bpf_prog_put_deferred+0x8b/0x210
> > [  722.850919]  sk_filter_release_rcu+0xd7/0x110
> > [  722.852439]  rcu_do_batch+0x3d9/0xf50
>
> So the question is if you can get these calls to __bpf_prog_put with
> current->mm !=3D NULL, and the answer is yes.
>
> I slapped this in:
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ed286b8a0f0..fd4385e815f1 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2150,6 +2150,8 @@ static void __bpf_prog_put(struct bpf_prog *prog)
>  {
>         struct bpf_prog_aux *aux =3D prog->aux;
>
> +       WARN_ON(current->mm);
> +
>         if (atomic64_dec_and_test(&aux->refcnt)) {
>                 if (in_irq() || irqs_disabled()) {
>                         INIT_WORK(&aux->work, bpf_prog_put_deferred);
>
> and ran a one-liner I had handy:
> bpftrace -e 'kprobe:prepare_exec_creds { @[kstack(),
> curtask->cred->usage] =3D count(); }'
>
> Traces are close -> __fput -> bpf_prog_release.
>
> I think it is a bug that ebpf can call into audit with current which
> is not even bpf-related, and other times with the 'right' one -- what
> is the exe filter supposed to do? (and what about other audit
> codepaths which perhaps also look at current?)
>
> I have 0 interest in working on it and I don't think it is a high
> priority anyway.
>
> With that in mind I concede replacing WARN_ONCE with a mere check
> would still maintain the original bugfix, while not spewing the new
> trace and it probably should be done for the time being (albeit with a
> comment why).
>
> I do maintain this warn uncovered a problem though.
>
> Ultimately it is Paul's call I think. :)

I'm going to drop the WARN_ON_ONCE() since there is always a risk of
eBPF doing something odd and I don't want to have to keep revisiting
this each time to figure out what is at fault.

Thanks for reporting this Artem, I'll put together a patch and run it
overnight, if everything looks good in the morning I'll post it for
review, comment, etc. before sending it up to Linus.

--=20
paul-moore.com

