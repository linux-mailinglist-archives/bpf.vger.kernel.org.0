Return-Path: <bpf+bounces-11181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDB07B4A92
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 03:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 762B6B20982
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 01:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0591648;
	Mon,  2 Oct 2023 01:40:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44FB369
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 01:40:47 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18E7C4
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 18:40:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-503065c4b25so24531776e87.1
        for <bpf@vger.kernel.org>; Sun, 01 Oct 2023 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696210844; x=1696815644; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H1FYM6R3CMk/wuvAn8YXI8i1/B0HfcQceQhbsxEtKig=;
        b=UPi/VPhQDldYKUkemm+gi0qIEZSRx4y9dy/Y03p7Onj74BF8royXdc9rmDI7zjJ4YB
         PV12irRcyhEqrYJIeYw9VDQ7h3ziStilCAZVkvOGzAmr37NhF3cH/xoOV6VBsJ1Pi9ws
         M53ZWktDkgRxur/l2qLGLXD/KK/73D55ocyJ3x8n4xez0b+zTBAncoLG5Unrt9aExVIM
         BIhUIjwzEEjCGyniIo3SVtUiySqClxQbpJ9U0ebkjfTMgQYX+BXYoz1bKKIuH94TZVN9
         YAYNza3o/ixVU6ydEXUSWMCEVvy4joNlyUkqhbqOZ0nL+sN81jcl+nprl2sVzPpmlc56
         7sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696210844; x=1696815644;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1FYM6R3CMk/wuvAn8YXI8i1/B0HfcQceQhbsxEtKig=;
        b=xUeEQ8o/oihJKYSgMovKLU8BE4C477HCyt/Ypkm7WD06xRVOVI9WnDHTMhgZBXG8jG
         5pMa5IKL6Rv+t90H5kqrnnNdmcYUKF/AcunDXl6OQmFnIvKzrPsJrEgbxv1nfdwCwhHc
         nzwB3uZKlXBPEx9TCWcio7MMIk3l/cuQSvHAq8ipCnUYQpowQJkoejW82d/Y6p7T8QDM
         qxnXYrQEYHIV6QSa3f62S0uVg6QJAvYQMmi+G5/FIxVBLRoieMOVI/sLRM1PObNGm476
         VEXGBwGn9BzbdQ/Hz6SBOSxqBQZj1sUFBV+O4YUvJst8CglZApNdfNK/hQxWOqrx8lZo
         Onvg==
X-Gm-Message-State: AOJu0YxE+ldMU+oYPU15EUsfbOlgJh4Kn8KbYtQrdvMUXQEdkeY0OzrF
	r/lTb5i4pV+l8wRA9J3MqkM=
X-Google-Smtp-Source: AGHT+IE+MM/KoH9IJmDpvej87VtF0X1j6tMmHqJk+CG/u8BDZ2XYkxg+J/uLrfY+qF1V3PkFEpJR3Q==
X-Received: by 2002:a05:6512:1251:b0:503:ed:8616 with SMTP id fb17-20020a056512125100b0050300ed8616mr9860071lfb.59.1696210843463;
        Sun, 01 Oct 2023 18:40:43 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d14-20020ac24c8e000000b005009c4ba3f0sm4443707lfl.72.2023.10.01.18.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 18:40:42 -0700 (PDT)
Message-ID: <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 02 Oct 2023 04:40:40 +0300
In-Reply-To: <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
References: 
	<CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
	 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
	 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
	 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
	 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
	 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
	 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
	 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
	 <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
	 <CAADnVQJn35f0UvYJ9gyFT4BfViXn8T8rPCXRAC=m_Jx_CFjrtw@mail.gmail.com>
	 <5649df64315467c67b969e145afda8bbf7e60445.camel@gmail.com>
	 <CAADnVQJO0aVJfV=8RDf5rdtjOCC-=57dmHF20fQYV9EiW2pJ2Q@mail.gmail.com>
	 <4b121c3b96dcc0322ea111062ed2260d2d1d0ed7.camel@gmail.com>
	 <CAEf4BzbUxHCLhMoPOtCC=6Y-OxkkC9GvjykC8KyKPrFxp6cLvw@mail.gmail.com>
	 <52df1240415be1ee8827cb6395fd339a720e229c.camel@gmail.com>
	 <ec118c24a33fb740ecaafd9a55416d56fcb77776.camel@gmail.com>
	 <CAEf4BzZjut_JGnrqgPE0poJhMjJgtJcafRd6Z_0T0jrW3zARJw@mail.gmail.com>
	 <44363f61c49bafa7901ae2aa43897b525805192c.camel@gmail.com>
	 <CAEf4BzZ-NGiUVw+yCRCkrPQbJAS4wMBsT3e=eYVMuintqKDKqg@mail.gmail.com>
	 <a777445dcb94c0029eb3bd3ddc96ddc493c85ad0.camel@gmail.com>
	 <CAEf4BzZU0MxwLfz-dGbmHbEtqVhEMTxwSG+QfwCuCv09CqLcNw@mail.gmail.com>
	 <ca9ac095cf1b3fff55eea8a3c87670a349bbfbcf.camel@gmail.com>
	 <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
	 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
	 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
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

On Fri, 2023-09-29 at 17:41 -0700, Alexei Starovoitov wrote:
[...]
> I suspect that neither option A "Exit or Loop" or B "widening"
> are not correct.
> In both cases we will do states_equal() with states that have
> not reached exit and don't have live/precision marks.

I'd like to argue about B "widening" for a bit, as I think it might be
interesting in general, and put A aside for now. The algorithm for
widening looks as follows:
- In is_states_equal() for (sl->state.branches > 0 && is_iter_next_insn()) =
case:
  - Check if states are equal exactly:
    - ignore liveness marks on old state;
    - demand same type for registers and stack slots;
    - ignore precision marks, instead compare scalars using
      regs_exact() [this differs from my previous emails, I'm now sure
      that for this scheme to be correct regs_exact() is needed].
  - If there is an exact match then follow "hit" branch. The idea
    being that visiting exactly the same state can't produce new
    execution paths (like with graph traversal).
  - If there is no exact match but there is some state V which for
    which states_equal(V, C) and V and C differ only in inexact
    scalars:
    - copy C to state C';
    - mark range for above mentioned inexact scalars as unbound;
    - continue verification from C';
    - if C' verification fails discard it and resume verification from C.

The hope here is that guess for "wide" scalars would be correct and
range for those would not matter. In such case C' would be added to
the explored states right after it's creation (as it is a checkpoint),
and later verification would get to the explored C' copy again, so
that exact comparison would prune further traversals.

Unfortunately, this is riddled with a number of technical
complications on implementation side.
What Andrii suggests might be simpler.

> The key aspect of the verifier state pruning is that safe states
> in sl list explored all possible paths.
> Say, there is an 'if' block after iter_destroy.
> The push_stack/pop_stack logic is done as a stack to make sure
> that the last 'if' has to be explored before earlier 'if' blocks are chec=
ked.
> The existing bpf iter logic violated that.
> To fix that we need to logically do:
>=20
> if (is_iter_next_insn(env, insn_idx))
>   if (states_equal(env, &sl->state, cur)) {
>    if (iter_state->iter.state =3D=3D BPF_ITER_STATE_DRAINED)
>      goto hit;
>=20
> instead of BPF_ITER_STATE_ACTIVE.
> In other words we need to process loop iter =3D=3D 0 case first
> all the way till bpf_exit (just like we do right now),
> then process loop iter =3D=3D 1 and let it exit the loop and
> go till bpf_exit (hopefully state prune will find equal states
> right after exit from the loop).
> then process loop iter =3D=3D 2 and so on.
> If there was an 'if' pushed to stack during loop iter =3D=3D 1
> it has to be popped and explored all the way till bpf_exit.
>=20
> We cannot just replace BPF_ITER_STATE_ACTIVE with DRAINED.
> It would still be ACTIVE with sl->state.branches=3D=3D0 after that
> state explored all paths to bpf_exit.

This is similar to what Andrii suggests, please correct me if I'm wrong:

> 1. If V and C (using your terminology from earlier, where V is the old
> parent state at some next() call instruction, and C is the current one
> on the same instruction) are different -- we just keep going. So
> always try to explore different input states for the loop.

> 2. But if V and C are equivalent, it's too early to conclude anything.
> So enqueue C for later in a separate BFS queue (and perhaps that queue
> is per-instruction, actually; or maybe even per-state, not sure), and
> keep exploring all the other pending queues from the (global) DFS
> queue, until we get back to state V again. At that point we need to
> start looking at postponed states for that V state. But this time we
> should be sure that precision and read marks are propagated from all
> those terminatable code paths.

More formally, before pruning potential looping states we need to
make sure that all precision and read marks are in place.
To achieve this:
- Process states from env->head while those are available, in case if
  potential looping state (is_states_equal()) is reached put it to a
  separate queue.
- Once all env->head states are processed the only source for new read
  and precision marks is in postponed looping states, some of which
  might not be is_states_equal() anymore. Submit each such state for
  verification until fixed point is reached (repeating steps for
  env->head processing).

