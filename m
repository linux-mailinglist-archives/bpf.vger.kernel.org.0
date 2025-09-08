Return-Path: <bpf+bounces-67778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2615B49979
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9D8442528
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DD023909F;
	Mon,  8 Sep 2025 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMMhkf5x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF4238C2A
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358657; cv=none; b=Qa6ixWYWaJgqj2sQ+C/rvWnQH6pPp/2LGqP1iZF+VsGLvm0KsIfiNxVwJT5brfV3iEY7NmHYobE/YBoD7Mox/La8BlIxY+7EqVPAM97po0iccoRyduSKuP6zjguyUAndIFOgGUxw+bX73Ws37wdAiob1bUA4c6B0JMDm5QjAxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358657; c=relaxed/simple;
	bh=+8/YqbGuV614GQS8O4T5y8tF5gPClFLxwGfyzcogHbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+zwqnxQALLyXZ2lFr4cNHXNhpMlndTofoJWgBhyH7QzGonF1qn9CdU8WhRQCQGlXC4C7fES07l8fdETphQJW4GUgxVsf12nRwYoZ6YZuYfsvStfZ4CwHWEm+8ceFj73ywo58sSPJI6VQw2wFqFZTICHV7JJ055bV5uv1YG/rAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMMhkf5x; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-60f476eab6cso1229271d50.2
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 12:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757358655; x=1757963455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8/YqbGuV614GQS8O4T5y8tF5gPClFLxwGfyzcogHbY=;
        b=BMMhkf5xyP1a8l+7gTp8GEVffqUc8dmINC8eWd7oWEDWOb6B8/ei5J579EGF9AO7C1
         jGgQMHph0EWKfifzxbzm6cw/oe4nk/Hp7MI1rp8bNU6+dIynPR81rEIm6xCVhOwJAEMI
         7rDP890oaJeP2cnjrX3naaFZdlTh4cbdeZW/0csPPwQ4nnmvqEljGrTWoWax/HEs7qlS
         3gmf5NYCdE0DxmH647FmTtxXMipzSoT/Gf/WFaR+nD4FSTu0MgBcbmGsiXg+YFkHeUNN
         1WDhbL14tE5iE+B6F6NRHF4A601oX8WXp2HgyhNTvmTY3is5o6o1qug4CKSsDObrei1e
         pnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757358655; x=1757963455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8/YqbGuV614GQS8O4T5y8tF5gPClFLxwGfyzcogHbY=;
        b=Hyp8GeSDFlkFYIfcQNEPG/8FiIX4PHkONlRqinDoH3jXu9yOrsBFg+FXMCkNZ5ZbH9
         Svm/rdnIAAx8sYTgJAvsH0rit/jJkNbUTLZviJM4rr0lcDlJNVOE9OsURDYxBlid2j11
         tVC01oqPhISUMbqP+rXs8OGrjae953/1PXVnI8WntdNYb7ron6SuAHETWa2fz+k5GkR3
         LNaN58Sc04b0h8G6VzOUF9rueiwQ3DMj7GlvtOrehtBWtAh5EW0U1uq1CMvPQ4vpYpKN
         70uwHetLQdRYuHNGJhcK1pzt7IRzpp8mqi9pO7cC7SlKo86pGiDd/EAqZGaM3BP9kocU
         t9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUUFShWXcbH2DIRIn5crQ58UB0Tv2G0aYbx9Qp0JfHKtjjNOzRq9Ahq80R+uc7gS7v+4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbgMRJNDB8Mp8tKfixMj5EknPjB3+qDZneVC1F3Dlm/MRKor8
	PUrROs81RuN6O8GKsKoBbcn3dEGugp3VXmz9GEkwAXYmop1AhWTOZhdRpQeQrQXgFEcRbhl+j47
	vjhdwHlEwuiiKKfX27mz8tgHLWaMy2hY=
X-Gm-Gg: ASbGncvKlZesuB676w37p3bATGrZP70iI+dZGxmu7f982xZmEvLZ9zwE+wWOrCKkkld
	rTjE8UllCa2uMKlJ2YCJ8q2vz7XSmr79l3gRf9DMzV3Na3HQFVx/OJZRSqeYHPPsM9R/X/dxfo8
	MwjIS9tGl/r6SkG16bbZOuh8owWLtW0a5g+OdFFP54zo+HxyaSbgk5Kfjy45uRaIVuV2Cif5DRv
	xvmUKyf
X-Google-Smtp-Source: AGHT+IETdn0/Z+kdtxgCPsnk1JOdcRPqdeVDkFwVP9cPtTSeNwOReQg8gdnMbDTPs5Mwj1UupySeDOxMyNQqndOgp9c=
X-Received: by 2002:a53:b3c7:0:b0:612:558d:da22 with SMTP id
 956f58d0204a3-612558df281mr5104037d50.25.1757358654212; Mon, 08 Sep 2025
 12:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756983951.git.paul.chaignon@gmail.com> <a3f372a017489ae75545f42a903b12710c2836ca.1756983952.git.paul.chaignon@gmail.com>
 <CAADnVQ+EGdXHBfzrm_FC2mxtZ-Y-VU5Py5GOt9KriC8hVfRB8A@mail.gmail.com>
 <a9751ae4-adf1-4829-a5c9-2153e79d1ba9@iogearbox.net> <a3a927f6-7cad-46c7-9b20-89c9978acad7@gmail.com>
 <aLrkb-6ZFMLfMd-o@mail.gmail.com> <CAMB2axML8WkmA2Bv3gtvTnyq75cDO8ctqnPetB0jsYLQZVmNyg@mail.gmail.com>
 <aL8VXGQASeRo92xz@Tunnel>
In-Reply-To: <aL8VXGQASeRo92xz@Tunnel>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 8 Sep 2025 12:10:42 -0700
X-Gm-Features: Ac12FXy_liAUll-VDRMPJG-60Qivxb79_re27UHGnoi4OQ3GeZwvtqnFiA1-ARw
Message-ID: <CAMB2axO1kXA2JXDgF-mfmAAJL-M4JGE99w8gRKhYe6n62xEgkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:41=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Fri, Sep 05, 2025 at 09:34:54AM -0700, Amery Hung wrote:
> > On Fri, Sep 5, 2025 at 6:24=E2=80=AFAM Paul Chaignon <paul.chaignon@gma=
il.com> wrote:
> > >
> > > On Thu, Sep 04, 2025 at 09:27:58AM -0700, Amery Hung wrote:
>
> [...]
>
> > > > How about letting users specify the linear size through ctx->data_e=
nd? I am
> > > > working on a set that introduces a kfunc, bpf_xdp_pull_data(). A pa=
rt of is
> > > > to support non-linear xdp_buff in test_run_xdp, and I am doing it t=
hrough
> > > > ctx->data_end. Is it something reasonable for test_run_skb?
> > >
> > > Oh, nice! That was next on my list :)
> > >
> > > Why use data_end though? I guess it'd work for skb, but can't we just
> > > add a new field to the anonymous struct for BPF_PROG_TEST_RUN?
> > >
> >
> > I choose to use ctx_in because it doesn't change the interface and
> > feels natural. kattr->test.ctx_in is already copied from users and
> > shows users' expectation about the input ctx. I think we should honor
> > that (as long as the value makes sense). WDYT?
>
> Ok, I think I see your point of view. To me, test.ctx_in *is* the
> context and not metadata about it. I'm worried it would be weird to
> users if we overload that field. I'm not against using that though if
> it's the consensus.

Just about to say the same thing Martin mentioned.

bpf_prog_test_run_xdp() is already using test.ctx_in since
47316f4a3053 ("bpf: Support input xdp_md context in
BPF_PROG_TEST_RUN"). It allows users to supply metadata via
test.data_in. ctx_in->data_meta must be zero and the first
ctx_in->data - ctx_in->data_meta bytes in data_in will be copied into
metadata. So continuing using ctx_in for specifying the linear data
size is a logical next step.

>
> >
> > Thanks for working on this. It would be great if there is some
> > consistency between test_run_skb and test_run_xdp.
>
> Definitely agree! Do you have a prototype anywhere I could check? If
> not, you can always flag any inconsistency when I send the v2.
>

Here is the set I am working on
https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@gmail.com/

Patch 5 allows using ctx_in->data_end to specify the linear xdp_buff
size (i.e., ctx_in->data_end - ctx_in->data). Patch 6 uses it to test
a new kfunc, bpf_xdp_pull_data().

> [...]
>

