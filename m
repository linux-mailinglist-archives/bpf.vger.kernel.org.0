Return-Path: <bpf+bounces-1554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29867718F17
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 01:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0837281657
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0FD40783;
	Wed, 31 May 2023 23:42:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FEA168A8
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 23:42:16 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DAA11D
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 16:42:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so102511e87.1
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 16:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685576532; x=1688168532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SgCEHhFQXRSTWAZuMcaTt3fjfGWcyMvCCNjKvHRSA2Q=;
        b=NiHvMRv46aCuTTLZWmqib6/vHhjSNnbhk70d4j71eiF8U/EdAXK7ykg8VHLJ1gUyJ2
         GniFNmqKRnor6ut2F6tyIphKugQ4FYMpgxghQPsZ5XOgKh1frkcNicyQtgh/Ngsy+jY+
         ZeqjcQx1siY0kTF/T45vyAlZst5JAhGgaPjkbtDWfCcnzIik2U/cS/RQ4aB3nU+d0a6U
         SBNsBW/NizLNbnZys80550x7eEa0OaWHVhV6YPUc3lioUI2pa79MxYsguRS15Xl16nIi
         AkCDLtZbRx+8gEtQez3NxjsjVKyTuqXEPjtOsscb6GxNcJHX6DxoPaRqyei6wj5TfFgl
         PYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685576532; x=1688168532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgCEHhFQXRSTWAZuMcaTt3fjfGWcyMvCCNjKvHRSA2Q=;
        b=RpjYFhJdjREB2+b/Ae5IU3EjmZblLapgRbttiWqeTOJ6cnEH6RO0+wIg48lFqHo8oR
         SSI7l16q6Kgqc/4u9XaYBzLJzc161yexumyHECwKhZsPYCQSzblyyE7znqHTGNT94TqW
         7X8PoeJwQtIt1zCbovVSgxxGb5lHsPhGJT43KcYN5mWaMpV3NwIG++yK/W6kOFiL670J
         r41WqW0g6dx4VRKPUhfXe6eGUTN3XL7JYx3jgC6ormnyE261PSHULFZD3zIMeGTjMoLU
         uswQXW88EtMRt2H53DJ8Lf+7BBr94VAvbc7wjdKugOVF23RdnSH/ELIdAiZbyI/QQHaF
         GWOg==
X-Gm-Message-State: AC+VfDzD1Na8zqHmboPhfV8OzpFaRWkNU8ovyPMply1o49GxlIdZJdlV
	3RHLEqU98dOQhhPWu6ZQVAPdzJIM+OyHEQ==
X-Google-Smtp-Source: ACHHUZ5p4U3o0CWyQd2wtHtEqVHTBm8OWfHOtJpXw3XHN4nwgyCEYgdouznNnPM3Ew92dHz4p0nv4A==
X-Received: by 2002:ac2:59c4:0:b0:4f4:e053:c85b with SMTP id x4-20020ac259c4000000b004f4e053c85bmr253661lfn.30.1685576532332;
        Wed, 31 May 2023 16:42:12 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g13-20020a19ac0d000000b004f42718cbb1sm876792lfc.292.2023.05.31.16.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 16:42:11 -0700 (PDT)
Message-ID: <12d9acab03e76491a34318dc2973b60f10712239.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Thu, 01 Jun 2023 02:42:10 +0300
In-Reply-To: <CAEf4Bza+60Wjbk=Hww1joxoykx+HeyP_Nv5igP7V0RZi=-3OVg@mail.gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <f2abf39bcd4de841a89bb248de9e242a880aaa93.camel@gmail.com>
	 <CAEf4BzYjvjbm9g1N9Z04kXV1N3+KH+dZ_sq_0NWuhyuJ+A18UQ@mail.gmail.com>
	 <a13ee48ac037d0dbb6796c7ea5965140ec7ef726.camel@gmail.com>
	 <CAEf4BzYE_7m3FNc6dtZeKb6tNbW4xkhz6SVdV6KetD5reSer6A@mail.gmail.com>
	 <aa64ee05281ec952df41b7a7842ed2836ae79762.camel@gmail.com>
	 <CAEf4BzZVd2=QnXe-A_n9zBYKcsY=DiHhH3EG8yB9Cq5+8D5jcQ@mail.gmail.com>
	 <eaa12a66fa3e06e24232507359fa0a07f43d514d.camel@gmail.com>
	 <CAEf4Bza+60Wjbk=Hww1joxoykx+HeyP_Nv5igP7V0RZi=-3OVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-05-31 at 15:54 -0700, Andrii Nakryiko wrote:
> [...]=20
>
> well, what can I say... force all imprecise logic isn't that
> straightforward either, but so far it still holds. And the big idea
> here is similar: whatever happens between two checkpoints doesn't
> matter if its effect is not visible at the end of the checkpoint.
>=20
> So I guess the intent of my proposal is correct: every time we mark r6
> as precise, we should mark r7 as well in each state in which they are
> still linked. Which necessitates to do this on each walk up the state
> chain.
>=20
> At least let's give it a try and see how it holds up against existing
> tests and whatever test you can come up with?..
=20
I'll try this thing, thanks a lot for all the input!
Hopefully will get back tomorrow.

> [...]
>=20
> BTW, I did contemplate extending jmp_history to contain extra flags
> about "interesting" instructions, though. Specifically, last
> unsupported case for precision backtracking is when register other
> than r10 is used for stack access (which can happen when one passes a
> pointer to a SCALAR to parent function's stack), for which having a
> bit next to such instruction saying "this is really a stack access"
> would help cover the last class of unsupported situations.

Yes, it would have required some kind of redesign for this case as
well. My expectation is that only a few registers get range on each
find_equal_scalars() call, so storing big masks for all frame levels
is very sub-optimal.

> But this is a pretty significant complication. And to make it really
> practical, we'd need to think very hard on how to implement
> jmp_history more efficiently, without constant reallocations. I have a
> hunch that jmp_history should be one large resizable array that all
> states share and just point into different parts of it. When state is
> pushed to the stack, we just remember at which index it starts. When a
> state is finalized, its jump history segment shouldn't be needed by
> that state and can be reused by its siblings and parent states.
> Ultimately, we only have a linear chain of actively worked-on states
> which do use jmp_history, and all others either don't need it
> *anymore* (verified states) or don't need it *yet* (enqueued states).
>
> This would allow us to even have an exact "log of execution" with
> insn_idx and associated extra information, but it will be code path
> dependent, unlike bpf_insn_aux. And the best property is that it will
> never grow beyond 1 million instructions deep (absolute worst case).

I'm not sure I understand why is it bounded.
Conditionals and loops potentially give big number of possible
execution paths over a small number of instructions.
So, keeping per-path / per-instruction still is going to blow up in
terms of memory use. To keep it bounded (?) something smart needs to
know which visited states could never be visited again.

> We might not even need backtracking in its current form if we just
> proactively maintain involved registers information (something that we
> currently derive during instruction interpretation in backtrack_insn).

Well, precision marks still have to be propagated backwards, so some
form of "backward movement" within a state will have to happen anyway.
Like, we have a combination of forward and backward analyses in any case.
Sounds a bit like you want to converge the design to some kind of a
classical data flow analysis, but have states instead of basic blocks.

> So at some point I'd like to get to thinking and implementing this,
> but it isn't the most pressing need right now, of course.
> [...]

