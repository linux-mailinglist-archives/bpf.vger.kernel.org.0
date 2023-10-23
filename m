Return-Path: <bpf+bounces-13011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCC27D3A09
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879D2281365
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24519BBF;
	Mon, 23 Oct 2023 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1RJL0wQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB9F15484
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 14:47:24 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E91A4
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 07:47:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ba081173a3so538411066b.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698072442; x=1698677242; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3nv1FHevyhbLZihznBGVvtmCPjKbXHiKAgIUtkZYkzA=;
        b=G1RJL0wQIi0oWPIjymFmfntgNsw8Xt/uk3Aa0bpoAzODssZZEFy8uz3X7FS69+dvJ5
         1T2K5XXAgXDPDaImnsAl27uoBuK9lXKPbnUMIouTp3+f90HD9dFnSQ7dnkI2miYm/hjP
         QJoiXPrNdswuWMPKzMrBqic1pto/TmgU3OQCNODcefNh4L529UkQdXnqgmyD8aJmjcB5
         wHVDTbEpAbBkTLx9eXbUG37M3wyNTof38eDJEMnAZ+mXChEElF/9+TpJEwyMBs6ZWHOc
         ULQStiOyS16KI+jq2scVd5kCi7Qj7BNLJEkmRrxn4hyb+rFDIK5H8IRqJvNZBCskMH56
         A2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072442; x=1698677242;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nv1FHevyhbLZihznBGVvtmCPjKbXHiKAgIUtkZYkzA=;
        b=Sd5kfKeN9tF8n7arg8/iDkLZx4HjLaN9Vc4JRrAV4VWZiQzYPs/IzOoKinvtNcqLhV
         bJ2ahFYg8h/uYIyOCAiWGCeqPisVC0ik7WwxacX90FxdKAlC3OtQAVLUNwsz1ErMgLmL
         vmdeAPMCsgqPV/jwRfqsVl6OvGcMLJ/6oXzujqRmzzUv4Y8xrMfpn5/qX0ZIvuABgBH3
         Bnxvr3waiQF6ihm0L2SlaYEGIGHBCh8qlSLmJUqiBNsT3Tqcoi1cEy3wGumrmeSv0Hva
         QaiUFOScVdFhiycbeOw6CT/IAaTz/LD6uwVH8e9rX1Ss1ziJsjn6i6BHdOoG14jzH9sE
         qTmA==
X-Gm-Message-State: AOJu0YxLMBoKn4ww9rEpCe8zSeLJxpwuXVLIUXf/0/lH72oc1WVmPi5Y
	mvKG+ghl9/x1phdHK9YzBu8kRJWiKKuon91j
X-Google-Smtp-Source: AGHT+IGhdsWoNt6N2IK+oWvAmSx8/h/DEuZMDA5HWXYP6r3MVGEdo8VyY9kydtQkF78ovb2amsLWbQ==
X-Received: by 2002:a17:907:3d9f:b0:9b2:b152:b0f2 with SMTP id he31-20020a1709073d9f00b009b2b152b0f2mr6869335ejc.10.1698072441363;
        Mon, 23 Oct 2023 07:47:21 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906088d00b0098ec690e6d7sm6737940eje.73.2023.10.23.07.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:47:20 -0700 (PDT)
Message-ID: <ff3368b1c03468b6e67738f2745954403cbe0bc9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/7] bpf: correct loop detection for
 iterators convergence
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com,
 john.fastabend@gmail.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Oct 2023 17:47:19 +0300
In-Reply-To: <CAEf4BzZwEx3P+u+J_4P1trf6=ChQ7cQWEkDjZ2aNLQzoNhz1jA@mail.gmail.com>
References: <20231022010812.9201-1-eddyz87@gmail.com>
	 <20231022010812.9201-6-eddyz87@gmail.com>
	 <CAEf4BzZwEx3P+u+J_4P1trf6=ChQ7cQWEkDjZ2aNLQzoNhz1jA@mail.gmail.com>
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

On Sat, 2023-10-21 at 21:28 -0700, Andrii Nakryiko wrote:
> On Sat, Oct 21, 2023 at 6:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > It turns out that .branches > 0 in is_state_visited() is not a
> > sufficient condition to identify if two verifier states form a loop
> > when iterators convergence is computed. This commit adds logic to
> > distinguish situations like below:
> >=20
> >  (I)            initial       (II)            initial
> >                   |                             |
> >                   V                             V
> >      .---------> hdr                           ..
> >      |            |                             |
> >      |            V                             V
> >      |    .------...                    .------..
> >      |    |       |                     |       |
> >      |    V       V                     V       V
> >      |   ...     ...               .-> hdr     ..
> >      |    |       |                |    |       |
> >      |    V       V                |    V       V
> >      |   succ <- cur               |   succ <- cur
> >      |    |                        |    |
> >      |    V                        |    V
> >      |   ...                       |   ...
> >      |    |                        |    |
> >      '----'                        '----'
> >=20
> > For both (I) and (II) successor 'succ' of the current state 'cur' was
> > previously explored and has branches count at 0. However, loop entry
> > 'hdr' corresponding to 'succ' might be a part of current DFS path.
> > If that is the case 'succ' and 'cur' are members of the same loop
> > and have to be compared exactly.
> >=20
> > Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Co-developed-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  15 +++
> >  kernel/bpf/verifier.c        | 207 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 218 insertions(+), 4 deletions(-)
> >=20
>=20
> LGTM, but see the note below about state being its own loop_entry. It
> feels like a bit better approach would be to use "loop_entry_ref_cnt"
> instead of just a bool used_as_loop_entry, and do a proper accounting
> when child state is freed and when propagating loop_entries. But
> perhaps that can be done in a follow up, if you think it's a good
> idea.

I though about reference counting but decided to use flag instead
because it's a bit simpler. In any case the full mechanism is
opportunistic and having a few stale states shouldn't be a big deal,
those would be freed when syscall exits.
I'll make ref_cnt version and send it as a follow-up, so we can decide
looking at the code whether to peek it or drop it.

>=20
> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
>=20
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 38b788228594..24213a99cc79 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
>=20
[...]
> > @@ -16825,7 +17023,8 @@ static int is_state_visited(struct bpf_verifier=
_env *env, int insn_idx)
> >                          * speed up verification
> >                          */
> >                         *pprev =3D sl->next;
> > -                       if (sl->state.frame[0]->regs[0].live & REG_LIVE=
_DONE) {
> > +                       if (sl->state.frame[0]->regs[0].live & REG_LIVE=
_DONE &&
> > +                           !sl->state.used_as_loop_entry) {
>=20
> In get_loop_entry() you have an additional `topmost !=3D
> topmost->loop_entry` check, suggesting that state can be its own
> loop_entry. Can that happen?

It can, e.g. in the following loop:

    loop: r1 =3D r10;
          r1 +=3D -8;
       --- checkpoint here ---
          call %[bpf_iter_num_next];
          goto loop;
 =20

> And if yes, should we account for that here?

With flag I don't think we need to account for it here because it's a
best-effort thing anyways. (E.g. it misses situation when something
was marked as loop entry initially than entry upper in DFS chain had
been found). With reference count -- yes, it would me more important.


