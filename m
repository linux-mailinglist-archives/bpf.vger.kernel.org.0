Return-Path: <bpf+bounces-9822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42FA79DC91
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D494282693
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9C211C82;
	Tue, 12 Sep 2023 23:16:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BABDB679;
	Tue, 12 Sep 2023 23:16:58 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD5B10F7;
	Tue, 12 Sep 2023 16:16:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500c37d479aso10100301e87.2;
        Tue, 12 Sep 2023 16:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694560616; x=1695165416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrbSVU4nZUFvuKXs1rDJFefP9fH0F3hyySGPvLoP9m8=;
        b=YzzvrFNtj8Z6VMUMkRu3/32kLqhf2WWzBzG8H1YSIITP3OLuw4c+IyTIMTMHpKOjKt
         25zhumNrSRpDab/8Vkxu6IZYA0W1oBeieNkhIZVWvk1Yxk2ZTRCf2Idgyxqkd5bqxDvF
         kMVNyINz73ncXMJl5pG5D3qfZJggauWCB4Fcsb8PLiF2gh+/TpdcmjdXWeFxntc00L29
         D70UyXFrXQ2s3lMHbJKho0Qv2yLC9B596TzXduupA5oWTfYBZZZwbVNP6fAJeLFUPjEe
         v5ORKFPXlKIw/k2ZxWhIQtApU57xYdu0u7Hv5hNkLF4n1L9CyrgODlhnwOvW5klZdP+k
         LLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694560616; x=1695165416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrbSVU4nZUFvuKXs1rDJFefP9fH0F3hyySGPvLoP9m8=;
        b=jPQ3bvX6lhsloXBm5W//dEIuzrQ8LpnuGCuMOvjPHA04th6r/MJxeMUXu0Euu1wfik
         3a461pIoBpANs8KZbB/nePXEQ2gVmrqoeYvgXlKqIMs4knOHbCjoZVAqAXz7/djGcK4f
         bPpctOMp+eV/UdaxVfnE3pg30LF0LsESHPdFmJgW95952oroFxAayREvV0vlRLXxwXyK
         gN316kgSWc2Qq49penCg0FgIW0cDFeBK1cYUB4NSj9uuEPzW4QYtZNWyel+1fbgq9HSz
         M93WG6WTH4Pnn+crGop28zx5i+5GSMeq0vEPDL4aJDhqBFcfWFMtRy5dOD0/1GnKj32q
         V/bw==
X-Gm-Message-State: AOJu0YzUv9ELVuOxcqStVXnbU/oeCS2XG+zEdUNu963w7xcg4IV00/YQ
	Yx7JwyHVuApCmraJrOYUTLGGIKZd6LGA7Ol47ZI=
X-Google-Smtp-Source: AGHT+IEBY3l3EINWayY7tuJfGoVDjPoP8cqckAfPldb0MCin3ecEklcSeeAUDt1vmekTIwLD2t/Y9JLbGHco4LHds+E=
X-Received: by 2002:a05:6512:31c3:b0:500:a694:46f with SMTP id
 j3-20020a05651231c300b00500a694046fmr951572lfe.19.1694560615656; Tue, 12 Sep
 2023 16:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912224654.6556-1-puranjay12@gmail.com> <20230912224654.6556-6-puranjay12@gmail.com>
 <ZQDuVTSycDcjDkvi@shell.armlinux.org.uk>
In-Reply-To: <ZQDuVTSycDcjDkvi@shell.armlinux.org.uk>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 13 Sep 2023 01:16:44 +0200
Message-ID: <CANk7y0iFdgHgu+RXYJvP3swaRS+-Lr0CgOAdcQWtjs4VkrOzdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf, arm32: Always zero extend for LDX with B/H/W
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shubham Bansal <illusionist.neo@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Wang YanQing <udknight@gmail.com>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 1:04=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Sep 12, 2023 at 10:46:53PM +0000, Puranjay Mohan wrote:
> > The JITs should not depend on the verifier for zero extending the upper
> > 32 bits of the destination register when loading a byte, half-word, or
> > word.
> >
> > A following patch will make the verifier stop patching zext instruction=
s
> > after LDX.
>
> This was introduced by:
>
> 163541e6ba34 ("arm: bpf: eliminate zero extension code-gen")
>
> along with an additional function. So three points:
>
> 1) the commit should probably explain why it has now become undesirable
> to access this verifier state, whereas it appears it was explicitly
> added to permit this optimisation.

I added some details in the cover letter.

For the complete discussion see: [1]

> 2) you state that jits should not depend on this state, but the above
> commit adds more references than you're removing, so aren't there still
> references to the verifier remaining after this patch? I count a total
> of 10, and the patch below removes three.

The JITs should not depend on this state for LDX (loading
a B/H/W.
This patch removes the usage only for LDX.

> 3) what about the bpf_jit_needs_zext() function that was added to
> support the export of this zext state?

That is still applicable, The verifier will still emit zext
instructions for other
instructions like BPF_ALU / BPF_ALU64

>
> Essentially, the logic stated in the commit message doesn't seem to be
> reflected by the proposed code change.

I will try to provide more information.
Currently I have asked Alexei if we really need this in [2].
I still think this optimization is useful and we should keep it.

Thanks,
Puranjay

[1] https://lore.kernel.org/all/CANk7y0j2f-gPgZwd+YfTL71-6wfvky+f=3DkBC_ccq=
sS0EHAysyA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/CANk7y0hK9sQJ-kRx3nQpVJSxpP=3DNzzFaLitOYq8=
=3DPb6Dvk9fpg@mail.gmail.com/

