Return-Path: <bpf+bounces-1735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963A37209C8
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 21:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C971C2122E
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F81E526;
	Fri,  2 Jun 2023 19:27:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0617759
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 19:27:23 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2C1BE
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 12:27:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1ac373c9eso14938071fa.0
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685734038; x=1688326038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/lyn+ye+CAjTm3Zj6oaUjibRBo97E8VtKU1NNblZ6g=;
        b=ODU7jBHB7hzhGw8U+eUBQcEEQeNnIDz/7C+RgG/M82NmE+JxaYT/dQ/8ESlrI8F1It
         5R23S7E9hTxWnSi/S3EDBCkkPVQKvtXG+1gK/YAYOXpSj8HTHT2lgiGRBbFf16BRYnR/
         ruoVgwGz3hySocI34dJVsRjRkPzJkbDgCDQZX4ahGOo92uTnYNty27BUmhN2ObosHBy3
         W939l19dv6X9MFB8kaTLU08KuK9H9tSKbxHCoGd9o8q6ocqwacFVmTquYNMdqa8oEacu
         OPH7tZGyM1dCqqymRea68o3LO7CAAoA6RF8RgYQOL0CkGTVO7idgIu2vc5uETJq5DnsI
         0BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685734038; x=1688326038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/lyn+ye+CAjTm3Zj6oaUjibRBo97E8VtKU1NNblZ6g=;
        b=KRO2YkxfLgBN0onTwsW4ebeOg7HzzMb77toHAoiJECUQfKhSdn+yKetVDMO+seNbqm
         /BuJ0SsXpy/pxDNYNyqz7Eaoa8a3BOFbddHLI/C6vLQgFe5HCNkYuqpSxslPHjbPTEYp
         kPymx5KlD50/IIKkWC4gnDyCGEtSTKQlanvZnI3+4aSlAm3mv21gxggD5mYThFkkay43
         Ruo2415h8nPTN7MOFagSL1EpNkIFBWZ1soTmmxyCV0QR14GisZwAei8FXQ3OL+4+rcDM
         IK0YiVttLSlEB1UExPj2528iC/bG+ZkJ6ZMCHTP5/qMTJtu90QRaVZ61UFNepcxhVrS3
         eKYg==
X-Gm-Message-State: AC+VfDzDN1g29hSIdUczwJFMaOM/jOMbfXdyN2PLfvCUAZXgcyyDjKgg
	+e72HDIQa/S3rj31fyNwlU3/9HJbazqbW9YH/vY=
X-Google-Smtp-Source: ACHHUZ5wt9yET5S/cwTvxb1ojtPc6l70ib4JEL9tksSRqJehEGEw5VVTVyG5S6iGbHnb57DlhVi8dGzxsz3gsHIXfao=
X-Received: by 2002:a05:651c:1023:b0:2a8:a9f7:205b with SMTP id
 w3-20020a05651c102300b002a8a9f7205bmr582108ljm.36.1685734037735; Fri, 02 Jun
 2023 12:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530172739.447290-1-eddyz87@gmail.com> <20230530172739.447290-2-eddyz87@gmail.com>
 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local> <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
 <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
 <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com> <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
In-Reply-To: <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jun 2023 12:27:06 -0700
Message-ID: <CAADnVQ+crhOPcnmC-N+CNbQ6PGdG6KKE+s5P1TEq_2KxL14iSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 12:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-06-02 at 11:50 -0700, Andrii Nakryiko wrote:
> [...]
> > > > The thread is long. Could you please describe it again in pseudo co=
de?
> > >
> > > - Add a function mark_precise_scalar_ids(struct bpf_verifier_env *env=
,
> > >                                         struct bpf_verifier_state *st=
)
> > >   such that it:
> > >   - collect PRECISE_IDS: a set of IDs of all registers marked in env-=
>bt
> > >   - visit all registers with ids from PRECISE_IDS and make sure
> > >     that these registers are marked in env->bt
> > > - Call mark_precise_scalar_ids() from __mark_chain_precision()
> > >   for each state 'st' visited by states chain processing loop,
> > >   so that:
> > >   - mark_precise_scalar_ids() is called for current state when
> > >     __mark_chain_precision() is entered, reusing id assignments in
> > >     current state;
> > >   - mark_precise_scalar_ids() is called for each parent state, reusin=
g
> > >     id assignments valid at 'last_idx' instruction of that state.
> > >
> > > The idea is that in situations like below:
> > >
> > >    4: if (r6 > r7) goto +1
> > >    5: r7 =3D r6
> > >    --- checkpoint #1 ---
> > >    6: <something>
> > >    7: if (r7 > X) goto ...
> > >    8: r7 =3D 0
> > >    9: r9 +=3D r6
> > >
> > > The mark_precise_scalar_ids() would be called at:
> > > - (9) and current id assignments would be used.
> > > - (6) and id assignments saved in checkpoint #1 would be used.
> > >
> > > If <something> is the code that modifies r6/r7 the link would be
> > > broken and we would overestimate the set of precise registers.
> > >
> >
> > To avoid this we need to recalculate these IDs on each new parent
> > state, based on requested precision marks. If we keep a simple and
> > small array of IDs and do a quick linear search over them for each
> > SCALAR register, I suspect it should be very fast. I don't think in
> > practice we'll have more than 1-2 IDs in that array, right?
>
> I'm not sure I understand, could you please describe how it should
> work for e.g.?:
>
>     3: r6 &=3D 0xf            // assume safe bound
>     4: if (r6 > r7) goto +1
>     5: r7 =3D r6
>     --- checkpoint #1 ---
>     6: r7 =3D 0
>     7: if (r7 > 10) goto exit;
>     8: r7 =3D 0
>     9: r9 +=3D r6
>
> __mark_chain_precision() would get to checkpoint #1 with only r6 as
> precise, what should happen next?
>
> As a side note: I added several optimizations:
> - avoid allocation of scalar ids for constants;

+1

> - remove sole scalar ids from cached states;
> - do a check as follows:
>   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))

Ignoring rcur->id > 0 ? Is it safe?

>     return false;
>
> And I'm seeing almost zero performance overhead now.
> So, maybe what we figured so far is good enough.
> Need to add more tests, though.

