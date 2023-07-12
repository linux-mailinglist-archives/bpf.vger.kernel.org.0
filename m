Return-Path: <bpf+bounces-4823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ED474FDAB
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769F11C20ECA
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 03:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE7310FF;
	Wed, 12 Jul 2023 03:23:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E080D;
	Wed, 12 Jul 2023 03:23:29 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38CE5C;
	Tue, 11 Jul 2023 20:23:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b73564e98dso9564741fa.3;
        Tue, 11 Jul 2023 20:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689132206; x=1691724206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n8c7kdSJgsXGg8olaGmLIjQ0eKSOKOykwbBGabc4NY=;
        b=YlaqWcaJw+vpU1wCRykZEl60CpKhT6jUk/Y1bjW6UCi4ZNva9JVBbtpLsOtETJTj06
         ve3peQWLNGlzWyUy4kFIQei7TUUsnfKAMSKmvjIyNIF+rrI9Bf44mSMjTOo5dhaFWmdh
         eLfonbQzZWTcaOY6GB0OXS3y6u+iOu7/IeIVXr7CMwYG29FpBOgv9joLE8UTVoLWKbNu
         NqDCs60IOZY07yA1M154WdeYKr1F5A8vaT0Mk2Wf1cE926cy8y0mW6o4h5xGoHsgdYwW
         ZnGD5y5t6eYbPaucY0rXsWxySsRtQjZNYcff8GrcmowixBaZzMHPEGjLMq4ieGXlbxsc
         9EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689132206; x=1691724206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n8c7kdSJgsXGg8olaGmLIjQ0eKSOKOykwbBGabc4NY=;
        b=J+ClJsPV8/K92Tdb22BdkaCDMVO0eRRAFsPic5DGaklOrui79fChyQ4TY2piwyFisQ
         enWlPA3CXWRWL6rVWANHfcDIeae+1Ix9fQkI/pcS65/6bQ0NPjfKav9Wgzyj+U7STfXw
         uQi9o0b31hw+owuYtmGAsB4acOf5SO3fz0JoetyAbiUfpsLLKZCas1VzPEEimdgwph7K
         fD6J+B3rMi5B6Ol+aCWUiyIkCrIAhAV8dp03A/ua0TqZk0fxZ7wEWyKo0kZ/DJ2R0BSC
         b7IByQuno0+qcxPKKJAUhyZpgIPcSgBkVQZLIVlMnCSomSXvZ9E5YyEKASR8wiDxIbT1
         Ph+g==
X-Gm-Message-State: ABy/qLbAk85bGPROycK6cF3fmpEhT9BKCduLCyogs2BfWgrBoVUJVZuQ
	JcIhGERwN9Yo/rjDsDsRpLkdsOEdPrjq/7NuZWA=
X-Google-Smtp-Source: APBJJlHdYyvBw7581xyqZQNstdJn58MVgvYLnbz0GRCQRxxkhjxYsExBO5QP0aBUzrARQWt7y/DJzzb57X7XyRipsI8=
X-Received: by 2002:a2e:9a8e:0:b0:2b6:c61c:745b with SMTP id
 p14-20020a2e9a8e000000b002b6c61c745bmr14770565lji.3.1689132206202; Tue, 11
 Jul 2023 20:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com> <20230707193006.1309662-10-sdf@google.com>
 <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local> <20230711173226.7e9cca4a@kernel.org>
 <CAADnVQJ3iyoZaxaALWd4zTsDT3Z=czU4g7qpmBFWPUs5ucqCMg@mail.gmail.com> <20230711200740.236b0142@kernel.org>
In-Reply-To: <20230711200740.236b0142@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 20:23:14 -0700
Message-ID: <CAADnVQLu2R5-qTgv84Vg2_CAM=J9tmPuUCsqSTzg=Z4PuFkzSA@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 8:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 11 Jul 2023 19:37:23 -0700 Alexei Starovoitov wrote:
> > > I hope I'm not misremembering but I think I suggested at the beginnin=
g
> > > to create a structure describing packet geometry and requested offloa=
ds,
> > > and for the prog fill that in.
> >
> > hmm. but that's what skb is for. skb =3D=3D packet geometry =3D=3D
> > layout of headers, payload, inner vs outer, csum partial, gso params.
> >
> > bpf at tc layer supposed to interact with that correctly.
> > If the packet is modified skb geometry should be adjusted accordingly.
> > Like BPF_F_RECOMPUTE_CSUM flag in bpf_skb_store_bytes().
> >
> > > All operating systems I know end up doing that, we'll end up doing
> > > that as well. The question is whether we're willing to learn from
> > > experience or prefer to go on a wild ride first...
> >
> > I don't follow. This thread was aimed to add xdp layer knobs.
> > To me XDP is a driver level.
>
> Driver is not a layer of the networking stack, I don't think it's
> a useful or meaningful anchor point for the mental model.
>
> We're talking about a set of functionality, we can look at how that
> functionality was exposed in existing code.
>
> > 'struct xdp_md' along with
> > BPF_F_XDP_HAS_FRAGS is the best abstraction we could do generalizing
> > dma-buffers (page and multi-page) that drivers operate on.
>
> I think you're working against your own claim.
> xdp frags explicitly reuse struct skb_shared_info.

Yes they do and it's an implementation detail.
skb_shared_info is convenient for drivers to fill in.
xdp prog isn't aware of the exact mechanism.
skb_shared_info is not exposed to a program.
Not sure what point you're trying to make.

>
> > Everything else at driver level is too unique to generalize.
> > skb layer is already doing its job.
>
> How can you say that drivers are impossible to generalize and than
> that the skb layer "is doing its job" ie. generalizes them?

Yeah. 'generalize' is a wrong word to use to describe a feature
that should have the same look and feel across drivers.
What I meant by 'csum impossible to generalize across drivers'
is that there is no HW-only path across them.
skb layer is doing it through sw fallback and combination
of csum_complete/unnecessary.

I'm saying that your proposal of
"create a structure describing packet geometry and requested offloads"
already exists and it's called skb.
I see no point doing this exercise again at XDP layer.

