Return-Path: <bpf+bounces-15079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA27EB95F
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 23:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB0AEB20BA1
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 22:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798726AF3;
	Tue, 14 Nov 2023 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IswBA9nK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC533083;
	Tue, 14 Nov 2023 22:32:16 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051DCFA;
	Tue, 14 Nov 2023 14:32:15 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5875e24c749so3244934eaf.1;
        Tue, 14 Nov 2023 14:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700001134; x=1700605934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhzuEU81ElbxL9bVKL6KDLHN6K/p74gwFfTaOSir1ec=;
        b=IswBA9nK29yh9T6e5W3k63TUlX4MHCSQkiu0XXXaSy962DCve0OjkDXLaX0BxaEOEP
         L+5Nb18i8A+1IuUyMlWi3JtT/+7D+5TDwItHA/JXze6hioBKaxVGfvH5Qe739UGLHvRX
         DoiCi7yyrUjzpwcPviW0qXNyXxqltbBwHU9oQo30pbtEeSmGoMIazaHpeOFXDYEDo4Hk
         Jd0rD41tFsLehXs5UZ9YsAvv8Ws3VHG1OsAwEWtyByUbqbsBa4X3MACJC9ogHaVUII3N
         OOpuyxb5bW7JNScaEvEb75xAcb6ntQlTV/N49+ZzudUjBk+vxAEASWIkIMDt2g+bO5f9
         58aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700001134; x=1700605934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhzuEU81ElbxL9bVKL6KDLHN6K/p74gwFfTaOSir1ec=;
        b=OPH95coY+YrDEPaoM94CArqnedHKN1fakGNrElAcvYfcoaPkaiqAIkgFdCUN7sn4Zz
         PvZHB6URgK+RFNDzKKxflINgVNSUEYm1RhGBaGfzCioj7MKvCf0cs7WZd5pJ9SkPPhwK
         i+vkAsbudocAF18zClFeIge6G4mgib+lQvrEyKJ1nl/y6l3PTxpjDkFAJYCpi9+Kaipg
         tBpr83CReSQ9qg0E9TDXWj4WBVBenWx3tDXLuerc4GctZ+ZGlEXMDw2JPgyPuIOicx0U
         pS+264aJODyhTsCMHD/5fw1tAu3Xy7aaj4lzVgYj8vt9AYmt8VsEEwufDIISQgOr6BPW
         E6+w==
X-Gm-Message-State: AOJu0YxqjqWBRZkRdS/L99u5iVhFrlgtlXm8NTC29wQ6sOJ0+pI2e1ap
	VktZIsm2qMf+3+I6bb3I45rkoYehdS4SG4wcKvE=
X-Google-Smtp-Source: AGHT+IFlNdHtdA7WYxN4DjbHyz119O5bT0kXRmV8L0J4WqnX5kRY/PZwDDF5KFLqc0uxtewXKEQwQoej5XIZMiLd0N4=
X-Received: by 2002:a05:6820:2c8f:b0:57b:3b48:6f11 with SMTP id
 dx15-20020a0568202c8f00b0057b3b486f11mr2853523oob.4.1700001134225; Tue, 14
 Nov 2023 14:32:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7510:0:b0:4f0:1250:dd51 with HTTP; Tue, 14 Nov 2023
 14:32:13 -0800 (PST)
In-Reply-To: <CAHC9VhSjJ+ZgScF9f=8Fyovn15tKgaqFdV1qZxp=RWiuZSAdAA@mail.gmail.com>
References: <20231024161432.97029-2-paul@paul-moore.com> <a5650045-164f-4bff-b688-ddbc66dc95c4@canonical.com>
 <CAHC9VhR-5uK=D0r3zDDsHegjiEqEuhsBhBqLTZ7Xm2PPup64oA@mail.gmail.com>
 <CAGudoHEAes9Avq4EKqNCFwKd_AQPhQE4v6Z3LYCZasJqQXKtjA@mail.gmail.com>
 <20231114092903.GA590929@alecto.usersys.redhat.com> <CAGudoHEDXaPTN1icH64Ff9rOJPJmr6ek-nCUhWtzUb0JqbXDzw@mail.gmail.com>
 <CAHC9VhSjJ+ZgScF9f=8Fyovn15tKgaqFdV1qZxp=RWiuZSAdAA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 14 Nov 2023 23:32:13 +0100
Message-ID: <CAGudoHFGT2QaMGLzePtY23AQk85Uy2uMKDV08n_ep6k-7EE0zQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: don't take task_lock() in audit_exe_compare()
 code path
To: Paul Moore <paul@paul-moore.com>
Cc: Artem Savkov <asavkov@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	audit@vger.kernel.org, Andreas Steinmetz <anstein99@googlemail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 11/14/23, Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Nov 14, 2023 at 5:33=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
>> On 11/14/23, Artem Savkov <asavkov@redhat.com> wrote:
>> > On Tue, Oct 24, 2023 at 07:59:18PM +0200, Mateusz Guzik wrote:
>> >> For the thread to start executing ->mm has to be set.
>> >>
>> >> Although I do find it plausible there maybe a corner case during
>> >> kernel bootstrap and it may be that code can land here with that
>> >> state, but I can't be arsed to check.
>> >>
>> >> Given that stock code has an unintentional property of handling empty
>> >> mm and this is a bugfix, I am definitely not going to protest adding =
a
>> >> check. But I would WARN_ONCE it though.
>> >
>> > There is a case when this happens. Below is the trace I get when
>> > unloading a bpf program of type BPF_PROG_TYPE_SOCKET_FILTER while ther=
e
>> > is an audit exe filter in place. So maybe the WARN shouldn't be there
>> > after all?
>> >
>> > [  722.833206] ------------[ cut here ]------------
>> > [  722.833902] WARNING: CPU: 1 PID: 0 at kernel/audit_watch.c:534
>> > audit_exe_compare+0x14d/0x1a0
>> [snip]
>> > [  722.836308] Call Trace:
>> > [  722.836343]  <IRQ>
>> > [  722.836375]  ? __warn+0xc9/0x350
>> > [  722.836426]  ? audit_exe_compare+0x14d/0x1a0
>> > [  722.836485]  ? report_bug+0x326/0x3c0
>> > [  722.836547]  ? handle_bug+0x3c/0x70
>> > [  722.836596]  ? exc_invalid_op+0x14/0x50
>> > [  722.836649]  ? asm_exc_invalid_op+0x16/0x20
>> > [  722.836721]  ? audit_exe_compare+0x14d/0x1a0
>> > [  722.838368]  audit_filter+0x4ab/0xa70
>> > [  722.839965]  ? perf_event_bpf_event+0xf1/0x490
>> > [  722.841562]  ? __pfx_audit_filter+0x10/0x10
>> > [  722.843157]  ? __pfx_perf_event_bpf_event+0x10/0x10
>> > [  722.844757]  ? rcu_do_batch+0x3d7/0xf50
>> > [  722.846330]  audit_log_start+0x28/0x60
>> > [  722.847870]  bpf_audit_prog.part.0+0x3c/0x150
>> > [  722.849398]  bpf_prog_put_deferred+0x8b/0x210
>> > [  722.850919]  sk_filter_release_rcu+0xd7/0x110
>> > [  722.852439]  rcu_do_batch+0x3d9/0xf50
>>
>> So the question is if you can get these calls to __bpf_prog_put with
>> current->mm !=3D NULL, and the answer is yes.
>>
>> I slapped this in:
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 0ed286b8a0f0..fd4385e815f1 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -2150,6 +2150,8 @@ static void __bpf_prog_put(struct bpf_prog *prog)
>>  {
>>         struct bpf_prog_aux *aux =3D prog->aux;
>>
>> +       WARN_ON(current->mm);
>> +
>>         if (atomic64_dec_and_test(&aux->refcnt)) {
>>                 if (in_irq() || irqs_disabled()) {
>>                         INIT_WORK(&aux->work, bpf_prog_put_deferred);
>>
>> and ran a one-liner I had handy:
>> bpftrace -e 'kprobe:prepare_exec_creds { @[kstack(),
>> curtask->cred->usage] =3D count(); }'
>>
>> Traces are close -> __fput -> bpf_prog_release.
>>
>> I think it is a bug that ebpf can call into audit with current which
>> is not even bpf-related, and other times with the 'right' one -- what
>> is the exe filter supposed to do? (and what about other audit
>> codepaths which perhaps also look at current?)
>>
>> I have 0 interest in working on it and I don't think it is a high
>> priority anyway.
>>
>> With that in mind I concede replacing WARN_ONCE with a mere check
>> would still maintain the original bugfix, while not spewing the new
>> trace and it probably should be done for the time being (albeit with a
>> comment why).
>>
>> I do maintain this warn uncovered a problem though.
>>
>> Ultimately it is Paul's call I think. :)
>
> I'm going to drop the WARN_ON_ONCE() since there is always a risk of
> eBPF doing something odd and I don't want to have to keep revisiting
> this each time to figure out what is at fault.
>
> Thanks for reporting this Artem, I'll put together a patch and run it
> overnight, if everything looks good in the morning I'll post it for
> review, comment, etc. before sending it up to Linus.
>

SGTM. Hopefully we can put the matter to rest after that. ;)

--=20
Mateusz Guzik <mjguzik gmail.com>

