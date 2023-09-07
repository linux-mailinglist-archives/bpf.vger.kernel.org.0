Return-Path: <bpf+bounces-9409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A9F7973B7
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36FC1C20B1D
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1B112B80;
	Thu,  7 Sep 2023 15:29:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304E11731;
	Thu,  7 Sep 2023 15:29:46 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A2810DF;
	Thu,  7 Sep 2023 08:29:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1448020a12.1;
        Thu, 07 Sep 2023 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100517; x=1694705317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+iQnvoR9WIvvuphk/xb2y7jezozNmyXY5BuGK/6FCk=;
        b=QT0T5PVV6crUy32yYSeb2fNcVirjKNrqwn3fGxj9zooVxcoFmbb3N1r0LwyFgrMity
         wpsnJIdPUDM11iKltMPmV3dyGXkWWFE4JwjwTNT2iB/OeTdfkSj9E4oOOZSZfcDvsuZb
         U1nGEj/DoYruezOELVvNITFBM7UBW99+U0ThcjI4kxfZ4YWtU2PBuAY+3UpqLJGEkgHP
         yyQjV9RW+WiC1JPVf3OfU6mSeimnrVINx7cjCdn2YfsjdXbe6se2atZyEOqOacIKITUw
         3G3vAbBAS9Cx1nl2rY8F+nOP+zcS0eLQk6HomScvgAsD4H2mSbjB9u2PAk4JUGU+x6Jx
         SYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100517; x=1694705317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+iQnvoR9WIvvuphk/xb2y7jezozNmyXY5BuGK/6FCk=;
        b=biuhGWGYnZoKkw8jcoNBXu9wUv9hbdJu8/eyhXJlI35/EgFb9ugWXhJhZp42Q3hxdE
         b915ln9FPiIxvN/WS+gz1uj5PJJWoxGq7zCrnAqxRvA1pZ+quqXncGIwpsxR5Qt8TvYP
         AdhvRPkSRLt8EhVZhVNMsLpyzIR3/owHAAjZGd4hmulCxDDOF9GyZzQZo6BCglpZa0rn
         KSS0tMhHEkY2oWEURWxQSxfVHCPnELebt83ZKiZH7v5duZIrsPWp1E2Jvb4tELlA3Yme
         SAqF63ta/zxSnvWLDWJS86Se5prnEQgxjmn9qBbLhllGlAQijNF2PqPfSVWrTOu3CWgX
         GI8Q==
X-Gm-Message-State: AOJu0YzIMpD3NsfviubL6CVX0lHvcMEGM/Zpqc5dS5CxSU+uaFf2545e
	RffcfqzhWNlI4WudFh40wZQlw6aFZ1QHBUlpfmY+sev3yrw=
X-Google-Smtp-Source: AGHT+IHvMG7BHxfBuEv/VtwE4M7iBZo1MCLbCeCOoLZE5hIc0qenbVkKo7iV8ndNJxlJRBVF8lgdOHhtNmiXXh4bKeY=
X-Received: by 2002:a17:906:23e9:b0:9a2:276d:d84c with SMTP id
 j9-20020a17090623e900b009a2276dd84cmr4313287ejg.12.1694085243622; Thu, 07 Sep
 2023 04:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABcoxUbYwuZUL-xm1+5juO42nJMgpQX7cNyQELYz+g2XkZi9TQ@mail.gmail.com>
 <87o7ienuss.fsf@toke.dk>
In-Reply-To: <87o7ienuss.fsf@toke.dk>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 7 Sep 2023 13:13:27 +0200
Message-ID: <CAP01T76Ce2KHQqTGsqs5K9RM5qSv07rNxnV+-=q_J25i9NkqxA@mail.gmail.com>
Subject: Re: Possible deadlock in bpf queue map
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: Hsin-Wei Hung <hsinweih@uci.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 7 Sept 2023 at 12:26, Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel=
.org> wrote:
>
> +Arnaldo
>
> > Hi,
> >
> > Our bpf fuzzer, a customized Syzkaller, triggered a lockdep warning in
> > the bpf queue map in v5.15. Since queue_stack_maps.c has no major chang=
es
> > since v5.15, we think this should still exist in the latest kernel.
> > The bug can be occasionally triggered, and we suspect one of the
> > eBPF programs involved to be the following one. We also attached the lo=
ckdep
> > warning at the end.
> >
> > #define DEFINE_BPF_MAP_NO_KEY(the_map, TypeOfMap, MapFlags,
> > TypeOfValue, MaxEntries) \
> >         struct {                                                       =
 \
> >             __uint(type, TypeOfMap);                                   =
 \
> >             __uint(map_flags, (MapFlags));                             =
 \
> >             __uint(max_entries, (MaxEntries));                         =
 \
> >             __type(value, TypeOfValue);                                =
 \
> >         } the_map SEC(".maps");
> >
> > DEFINE_BPF_MAP_NO_KEY(map_0, BPF_MAP_TYPE_QUEUE, 0 | BPF_F_WRONLY,
> > struct_0, 162);
> > SEC("perf_event")
> > int func(struct bpf_perf_event_data *ctx) {
> >         char v0[96] =3D {};
> >         uint64_t v1 =3D 0;
> >         v1 =3D bpf_map_pop_elem(&map_0, v0);
> >         return 163819661;
> > }
> >
> >
> > The program is attached to the following perf event.
> >
> > struct perf_event_attr attr_type_hw =3D {
> >         .type =3D PERF_TYPE_HARDWARE,
> >         .config =3D PERF_COUNT_HW_CPU_CYCLES,
> >         .sample_freq =3D 50,
> >         .inherit =3D 1,
> >         .freq =3D 1,
> > };
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3DWARNING: inconsistent lock state
> > 5.15.26+ #2 Not tainted
> > --------------------------------
> > inconsistent {INITIAL USE} -> {IN-NMI} usage.
> > syz-executor.5/19749 [HC1[1]:SC0[0]:HE0:SE1] takes:
> > ffff88804c9fc198 (&qs->lock){..-.}-{2:2}, at: __queue_map_get+0x31/0x25=
0
> > {INITIAL USE} state was registered at:
> >   lock_acquire+0x1a3/0x4b0
> >   _raw_spin_lock_irqsave+0x48/0x60
> >   __queue_map_get+0x31/0x250
> >   bpf_prog_577904e86c81dead_func+0x12/0x4b4
> >   trace_call_bpf+0x262/0x5d0
> >   perf_trace_run_bpf_submit+0x91/0x1c0
> >   perf_trace_sched_switch+0x46c/0x700
> >   __schedule+0x11b5/0x24a0
> >   schedule+0xd4/0x270
> >   futex_wait_queue_me+0x25f/0x520
> >   futex_wait+0x1e0/0x5f0
> >   do_futex+0x395/0x1890
> >   __x64_sys_futex+0x1cb/0x480
> >   do_syscall_64+0x3b/0xc0
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > irq event stamp: 13640
> > hardirqs last  enabled at (13639): [<ffffffff95eb2bf4>]
> > _raw_spin_unlock_irq+0x24/0x40
> > hardirqs last disabled at (13640): [<ffffffff95eb2d4d>]
> > _raw_spin_lock_irqsave+0x5d/0x60
> > softirqs last  enabled at (13464): [<ffffffff93e26de5>] __sys_bpf+0x3e1=
5/0x4e80
> > softirqs last disabled at (13462): [<ffffffff93e26da3>] __sys_bpf+0x3dd=
3/0x4e80
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(&qs->lock);
> >   <Interrupt>
> >     lock(&qs->lock);
>
> Hmm, so that lock() uses raw_spin_lock_irqsave(), which *should* be
> disabling interrupts entirely for the critical section. But I guess a
> Perf hardware event can still trigger? Which seems like it would
> potentially wreak havoc with lots of things, not just this queue map
> function?
>
> No idea how to protect against this, though. Hoping Arnaldo knows? :)
>

The locking should probably be protected by a percpu integer counter,
incremented and decremented before and after the lock is taken,
respectively. If it is already non-zero, then -EBUSY should be
returned. It is similar to what htab_lock_bucket protects against in
hashtab.c.

