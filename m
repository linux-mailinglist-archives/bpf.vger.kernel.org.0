Return-Path: <bpf+bounces-15052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89357EAE1D
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 11:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102361C20AAF
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34BC199C6;
	Tue, 14 Nov 2023 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGgK85GF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01B3E475;
	Tue, 14 Nov 2023 10:33:01 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF03D9;
	Tue, 14 Nov 2023 02:33:00 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58a01a9fad0so2162903eaf.1;
        Tue, 14 Nov 2023 02:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699957980; x=1700562780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=blAbt0i8lzgKi7/e6JQha4UrzQk2Y6NrHg4borOBT9A=;
        b=jGgK85GFR52iMsWGKMdepsFEwmFItz0JhIZi7aH64PTv/qGOTv0vMNiUVp92lNF1GA
         h/sjS8qemm7DgoiovhhdZzt3/MQmEy3BmpPd5LahcolOX9ORtpTWWGQVNUtul3hDvPGP
         FRhuV2JmWHkjFqjUJrMvH1t2trSxa+QMwj6zvky4tgiP/8hnGsl5kcF3yanwrIDdqQnG
         Dnpp8V884dyjiMu5JFeVSKPtvCfNcUo//AeiFBkCL0tvDwoPmFKDjRAoBjss6SogT9bD
         mX3A9AriukqxPt86HMre3IqBbQuqJF/RU5Q1xTnK1ApLAYzNQPoxmggODK08BY0bTtyy
         nAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699957980; x=1700562780;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blAbt0i8lzgKi7/e6JQha4UrzQk2Y6NrHg4borOBT9A=;
        b=lIn/eX3zC9YDd8RbhuIjv50nYm1NgEfKs7yfaDQGkzvb9vPJ6PHu8Syy0gRj2qLD2D
         L9Y01fq4gbT4OJWtYFGNEf84I55q+6ZN+xQcH4SVnMhepuFn3UHHviBRe/eAznUnzM5r
         xJjljf+coO7tSnW25qX1uINx8CJ3GvrFjoJRTd9KJYSPbRBWuMyMYUJBgR1OmgLtGZe0
         8DTmfKTO1023T6FLMAMfHxpoNg3fRX/kJyxesOH67zavs8+5lV5BQecP2uvVvHXwPjvy
         dM3dC04K1LQWf+O0YKoPTm9a3J8wp7tGUO23as27T8fhuVj6NgpMT5W8Capa9FZEEhPk
         w2ng==
X-Gm-Message-State: AOJu0YxQdrSIazyI7Fol5MOsa+cb/fgb5rTjtkRSrLrXXGR/E4QwQkkZ
	OScgFq1eF6V8F791kWklS+WEXZ+R5Qvx9GbhW1Q=
X-Google-Smtp-Source: AGHT+IFXrbtgN1buLFOsQl49BTzcM3ZIx6weXiqfE3k0GCW5/nX/+WvrDB2rfg1+S9ku9vcVa6IYA81gjBN/4Zbvmqs=
X-Received: by 2002:a05:6820:1f8c:b0:589:f3e3:326f with SMTP id
 eq12-20020a0568201f8c00b00589f3e3326fmr1175640oob.0.1699957979763; Tue, 14
 Nov 2023 02:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:57d4:0:b0:4f0:1250:dd51 with HTTP; Tue, 14 Nov 2023
 02:32:59 -0800 (PST)
In-Reply-To: <20231114092903.GA590929@alecto.usersys.redhat.com>
References: <20231024161432.97029-2-paul@paul-moore.com> <a5650045-164f-4bff-b688-ddbc66dc95c4@canonical.com>
 <CAHC9VhR-5uK=D0r3zDDsHegjiEqEuhsBhBqLTZ7Xm2PPup64oA@mail.gmail.com>
 <CAGudoHEAes9Avq4EKqNCFwKd_AQPhQE4v6Z3LYCZasJqQXKtjA@mail.gmail.com> <20231114092903.GA590929@alecto.usersys.redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 14 Nov 2023 11:32:59 +0100
Message-ID: <CAGudoHEDXaPTN1icH64Ff9rOJPJmr6ek-nCUhWtzUb0JqbXDzw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: don't take task_lock() in audit_exe_compare()
 code path
To: Artem Savkov <asavkov@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, John Johansen <john.johansen@canonical.com>, 
	audit@vger.kernel.org, Andreas Steinmetz <anstein99@googlemail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 11/14/23, Artem Savkov <asavkov@redhat.com> wrote:
> On Tue, Oct 24, 2023 at 07:59:18PM +0200, Mateusz Guzik wrote:
>> For the thread to start executing ->mm has to be set.
>>
>> Although I do find it plausible there maybe a corner case during
>> kernel bootstrap and it may be that code can land here with that
>> state, but I can't be arsed to check.
>>
>> Given that stock code has an unintentional property of handling empty
>> mm and this is a bugfix, I am definitely not going to protest adding a
>> check. But I would WARN_ONCE it though.
>
> There is a case when this happens. Below is the trace I get when
> unloading a bpf program of type BPF_PROG_TYPE_SOCKET_FILTER while there
> is an audit exe filter in place. So maybe the WARN shouldn't be there
> after all?
>
> [  722.833206] ------------[ cut here ]------------
> [  722.833902] WARNING: CPU: 1 PID: 0 at kernel/audit_watch.c:534
> audit_exe_compare+0x14d/0x1a0
[snip]
> [  722.836308] Call Trace:
> [  722.836343]  <IRQ>
> [  722.836375]  ? __warn+0xc9/0x350
> [  722.836426]  ? audit_exe_compare+0x14d/0x1a0
> [  722.836485]  ? report_bug+0x326/0x3c0
> [  722.836547]  ? handle_bug+0x3c/0x70
> [  722.836596]  ? exc_invalid_op+0x14/0x50
> [  722.836649]  ? asm_exc_invalid_op+0x16/0x20
> [  722.836721]  ? audit_exe_compare+0x14d/0x1a0
> [  722.838368]  audit_filter+0x4ab/0xa70
> [  722.839965]  ? perf_event_bpf_event+0xf1/0x490
> [  722.841562]  ? __pfx_audit_filter+0x10/0x10
> [  722.843157]  ? __pfx_perf_event_bpf_event+0x10/0x10
> [  722.844757]  ? rcu_do_batch+0x3d7/0xf50
> [  722.846330]  audit_log_start+0x28/0x60
> [  722.847870]  bpf_audit_prog.part.0+0x3c/0x150
> [  722.849398]  bpf_prog_put_deferred+0x8b/0x210
> [  722.850919]  sk_filter_release_rcu+0xd7/0x110
> [  722.852439]  rcu_do_batch+0x3d9/0xf50

So the question is if you can get these calls to __bpf_prog_put with
current->mm != NULL, and the answer is yes.

I slapped this in:

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ed286b8a0f0..fd4385e815f1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2150,6 +2150,8 @@ static void __bpf_prog_put(struct bpf_prog *prog)
 {
        struct bpf_prog_aux *aux = prog->aux;

+       WARN_ON(current->mm);
+
        if (atomic64_dec_and_test(&aux->refcnt)) {
                if (in_irq() || irqs_disabled()) {
                        INIT_WORK(&aux->work, bpf_prog_put_deferred);

and ran a one-liner I had handy:
bpftrace -e 'kprobe:prepare_exec_creds { @[kstack(),
curtask->cred->usage] = count(); }'

Traces are close -> __fput -> bpf_prog_release.

I think it is a bug that ebpf can call into audit with current which
is not even bpf-related, and other times with the 'right' one -- what
is the exe filter supposed to do? (and what about other audit
codepaths which perhaps also look at current?)

I have 0 interest in working on it and I don't think it is a high
priority anyway.

With that in mind I concede replacing WARN_ONCE with a mere check
would still maintain the original bugfix, while not spewing the new
trace and it probably should be done for the time being (albeit with a
comment why).

I do maintain this warn uncovered a problem though.

Ultimately it is Paul's call I think. :)

-- 
Mateusz Guzik <mjguzik gmail.com>

