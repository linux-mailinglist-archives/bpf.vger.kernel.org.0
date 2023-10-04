Return-Path: <bpf+bounces-11342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A013E7B7616
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 03:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 567A3281556
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 01:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D57805;
	Wed,  4 Oct 2023 01:05:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E59182
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 01:05:36 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814BAAB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 18:05:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-504a7f9204eso1762431e87.3
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 18:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696381533; x=1696986333; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3sT7J8diHzF88DKLvst/9nkHCScEmt6CAL5+xeVjAdg=;
        b=g7Zq01uCeCopoC7MofBRV95QESGF3lOMmdQtEWrWkW4kjLGzoIkyvUeD/RVICN0afK
         /h8ABcZkTaVRn2TERo6mJUOIPEZBR7q6clsOFekGkK9fsKFAHwF254QutQZyxNpen38J
         wuzz6pXBK1fcA7nJOJrfbmDEkuvfks8r7QbmqU/uMS+k5Q9nei+Jzf1lqTP8GV+/4l1E
         f2efnuP7M9iE+RSppxYRWZ7JB+rkw0bzWZdHnCu798UWM8Mrx1nVBikLUDSKzjFUngKG
         dSVsTY6Bv1kxZ7Gf2tK2dFtZMDEnSzMpX/IsU2EyQLP7csWoLFNUzJgdDUQ9bFH059vI
         x9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696381533; x=1696986333;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sT7J8diHzF88DKLvst/9nkHCScEmt6CAL5+xeVjAdg=;
        b=vM3KYQ9rUP86aOR2wvAdvDuhjvkIaoK7DUahIYbpaCE2Z1HiTfZ+V8wuvIdKMb7iY9
         jXnDhAM6QqLV+fY9NDEJsdzha4+EQJJ3bC23WfC8/Og3W5WrU8JJeZfL4c/yRWIPEw9o
         3u1uYWIknfbCnUWUupGaAFhGw2vehKvHzn3wvg4/wc0Mpga5t8lywz2QiKS43AL7ac5m
         I/PsHm3ihNAVf6mj0tREfEW05l+CWvkLRXJkvpTTwivmg/HwTCNhehaWECR1ldPOk2kq
         oMwMXhFcASA8KblidIPxVDJcj9Dh/JMS0W16tBI77km7UWqAuJT00SXt9+/l5hgN2nZE
         Gksg==
X-Gm-Message-State: AOJu0YzS0zxCR++GEijWv+PHB997OfrpAUPOSN3NuF3Oe9ldcDWWs0NJ
	at9sjUnbfGbPtd7PMa0bN58=
X-Google-Smtp-Source: AGHT+IHdxCPeHV8ocK21BuojO20reA/c6GMVTQNraUbztyAEZi7JApMFDPgBiRgdF8ZO7DImGK7UBg==
X-Received: by 2002:a05:6512:3f27:b0:504:7e90:e05b with SMTP id y39-20020a0565123f2700b005047e90e05bmr614130lfa.14.1696381532406;
        Tue, 03 Oct 2023 18:05:32 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d21-20020ac24c95000000b004fea1a2231dsm374992lfl.263.2023.10.03.18.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 18:05:31 -0700 (PDT)
Message-ID: <3d88ede5cbe38ae96be0c148770454b2344fdcce.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 04 Oct 2023 04:05:30 +0300
In-Reply-To: <20231003230820.iazvofhysfmurwon@MacBook-Pro-49.local>
References: 
	<CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
	 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
	 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
	 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
	 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
	 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
	 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
	 <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
	 <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
	 <5b7f4b6199decf266a9218b674c232662ed13db5.camel@gmail.com>
	 <20231003230820.iazvofhysfmurwon@MacBook-Pro-49.local>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-03 at 16:08 -0700, Alexei Starovoitov wrote:
[...]
> > When bpf_iter_next() is reached in state C and states_equal() shows
> > that there is potentially equivalent state V:
> > - copy C' of C is created sing copy_verifier_state(), it updates all
> >   branch counters up the ownership chain as with any other state;
> > - C' is put to env->loop_stack.
>=20
> and C' points to normal parent and increments its branches as part of __p=
ush_stack().

Yes.

> void foo()
> {
>   if (...) { .. } // no pruning
>   if (...) { .. } // no pruning
>=20
>   bpf_for(...)
>   if (...) { .. } // all ok
> }
>=20
> Essentially any complex code before the loop has a high chance of the ver=
ifier
> state explosion.

Yes. This may be an issue. I'll try to hack a layered variant I talked
before to see what are the underlying issues. The idea is to verify
every child state of the loop entry before moving to any branches of
loop's parent states. This would allow to compute local "steady loop"
and mark everything after loop entry as safe (.branches =3D=3D 0).

> > It is possible and correct to propagate liveness and precision from V
> > to C when loop steady state is achieved, as at that point we know for
> > sure that C is a sub-state of V. However, currently loop states are
> > tracked globally and no states are processed after loops steady state
> > is reached, hence I don't do liveness and precision propagation.
>=20
> Hmm. I think the code is doing it:
> if (is_iter_next_insn(env, insn_idx)) {
>   if (states_equal(env, &sl->state, cur)) {
>     push_loop_stack(env, insn_idx, env->prev_insn_idx);
>     goto hit;
> hit:
>   propagate_liveness()

Yes and this should be changed. It should not produce incorrect
results as additional precision and read marks are conservative,
but will hinder state pruning in some scenarios.

> DFS + BFS traversal doesn't guarantee safety.
> We delayed looping states in loop_stack, but it doesn't mean
> that the loop body reached a steady state.
> Your own num_iter_bug() is an example.
> The verifier will miss exploring path with r7 =3D 0xdead.
> When C' is popped from loop_stack there is chance it will explore them,
> but there is no guarantee.
> For this particular num_iter_bug() case the loop processing
> will eventually propagate precision marks and retrying with C' later,
> the C' will be correctly rejected, since precision marks are there.
> But I think that is more due to luck and the shape of the test.
>=20
> if (is_iter_next_insn(env, insn_idx)) {
>   if (states_equal(env, &sl->state, cur)) {
>=20
> is a foot gun. It finds broken equivalence and potentially skipping
> whole blocks of code.
> What guarantees that C' from loop_stack will explore them?

The idea is that when `env->stack.size =3D=3D 0` all V's non-delayed
children states are explored and relevant precision marks are
propagated to V. If at this point some states_equal(V, C') is false it
is necessary to schedule C' for one more exploration round as it might
visit some code blocks that were not visited on the path from V to C'
(as different predictions decisions could be made).
If a point is reached when for all loop states C' there are some
states V such that states_equal(V, C'), there are no more
configurations that can visit code blocks not visited on the path from
V to C', as prediction decisions would be the same.

> I think avoiding states_equal(V, cur) when V state didn't converge
> is a mandatory part of the fix.

But there are no other heuristics that suggest that exploration of the
infinite series of loop iterations could be stopped for current path.

> I can see that little bit of out-of-order state processing probably
> is still correct, but delaying loop_stack all the way until=20
> env->stack.size =3D=3D 0 is just broken.
> For example we can push looping state in process_iter_next_call()
> not the top of the stack, but place it after branches with
> insn_idx >=3D iter_next's insn_idx.

This should be based on state parentage chain as code blocks could be
non-linearly structured.

> This way the delayed looping states will still be processed
> around loop processing and every code block before the loop
> will converge to branches =3D 0.
> To do that we don't need another loop_stack.

Will comment in the morning.

