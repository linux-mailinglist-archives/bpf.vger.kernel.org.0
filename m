Return-Path: <bpf+bounces-3824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4678C74428E
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 20:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026A928116E
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3D174CF;
	Fri, 30 Jun 2023 18:54:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BAE16413
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 18:54:37 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B63C17
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 11:54:35 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1b06da65bdbso1897994fac.1
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688151275; x=1690743275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1BCu1h7UEAjmjIjguLsq0A1v52CehRWNzfY4dXG948=;
        b=ALOoGNDbwrefP8apjCnlWK7q8HxLNUV3ONq0ZpxinZFufidYitSVBa1PvtT4XVQpOU
         Lqs+K0CDmobgA8HYKFRxfh1R/MVCPhF/WaWAjRZM4H2Gis4sFEA8T/slt5ieJWFs/NMn
         4cD9ewDFDQiT2hKTLkNJ3DzNd8eSri1Il4GSHBymfsP27jik8o10uzbih1uHTj9MGDSY
         2dkZtEQnXd1btC2lLd9RQ/wOVek+FNwnNwHvgXgR9yj4qzqaqoerAQc/GxTJ6TV/yVcQ
         AWeEuSBkf0/x0PaqErzRQtCz+pLkMc7o3A7OYchrdnaCChtZyo0MQ5/rmGtX0gWuVuYh
         7JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688151275; x=1690743275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1BCu1h7UEAjmjIjguLsq0A1v52CehRWNzfY4dXG948=;
        b=VdJJan9U6TgVXT1PKkeLLNAuP65CGhl1pDsH8wRp9+TalKBOmCIb6/Ck1w5fponOmn
         3OQot36txWtlTjbCJt703+nGL2KsxyNpJ1pphGZ0WEUNQm86CfYEnhv9A145bjUbZ4Q+
         vl/lI/oaRQnyJMmdg3XIXYJdkt+Bw0TT1WqvHOdXbLWNRqL9PhxsXhp05yxbVx1eS4Uq
         Skjho9YBGJRvfUrII9EW8Goj/hvfrWMll4g9qL0ukJ6vqc/EjZZMaQKtjZKbNWoV1dHF
         P6im0XCUeMdjXBOmFxe80n8HjqVYvRv5MhvWLCwZxy+E9wkl4DI4XINkyw6t9dzEUAeH
         svnQ==
X-Gm-Message-State: ABy/qLYUTfU8cAYrkDh0ig5jb97biD5msxTXV/fFr1zE9OCuiveOxD1I
	lYCc26dls1pSC7Lpbi/pbArgWi1h3/Y2XRr/Hm29fQ==
X-Google-Smtp-Source: APBJJlFMIrnGsfIh/Yb9ahF8NwrTWHD1Vk9TnWhcfFj9Q1KntsbQtcw/24BCqkxHH8hZah10TO4HgWBqF6yjDTH1TN0=
X-Received: by 2002:a05:6870:e40c:b0:1b0:2491:40fc with SMTP id
 n12-20020a056870e40c00b001b0249140fcmr4629498oag.44.1688151274973; Fri, 30
 Jun 2023 11:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com> <649637e91a709_7bea820894@john.notmuch>
 <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
 <20230624143834.26c5b5e8@kernel.org> <ZJeUlv/omsyXdO/R@google.com>
 <ZJoExxIaa97JGPqM@google.com> <CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
 <CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
 <649b581ded8c1_75d8a208c@john.notmuch> <20230628115204.595dea8c@kernel.org> <87y1k2fq9m.fsf@toke.dk>
In-Reply-To: <87y1k2fq9m.fsf@toke.dk>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 30 Jun 2023 11:54:23 -0700
Message-ID: <CAKH8qBvnNCY=eFh4pMRZqBs88JBd66sVD+Yt8mGyQJOAtq7jrA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 4:43=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Jakub Kicinski <kuba@kernel.org> writes:
>
> > On Tue, 27 Jun 2023 14:43:57 -0700 John Fastabend wrote:
> >> What I think would be the most straight-forward thing and most flexibl=
e
> >> is to create a <drvname>_devtx_submit_skb(<drivname>descriptor, sk_buf=
f)
> >> and <drvname>_devtx_submit_xdp(<drvname>descriptor, xdp_frame) and the=
n
> >> corresponding calls for <drvname>_devtx_complete_{skb|xdp}() Then you
> >> don't spend any cycles building the metadata thing or have to even
> >> worry about read kfuncs. The BPF program has read access to any
> >> fields they need. And with the skb, xdp pointer we have the context
> >> that created the descriptor and generate meaningful metrics.
> >
> > Sorry but this is not going to happen without my nack. DPDK was a much
> > cleaner bifurcation point than trying to write datapath drivers in BPF.
> > Users having to learn how to render descriptors for all the NICs
> > and queue formats out there is not reasonable. Isovalent hired
> > a lot of former driver developers so you may feel like it's a good
> > idea, as a middleware provider. But for the rest of us the matrix
> > of HW x queue format x people writing BPF is too large. If we can
> > write some poor man's DPDK / common BPF driver library to be selected
> > at linking time - we can as well provide a generic interface in
> > the kernel itself. Again, we never merged explicit DPDK support,
> > your idea is strictly worse.
>
> I agree: we're writing an operating system kernel here. The *whole
> point* of an operating system is to provide an abstraction over
> different types of hardware and provide a common API so users don't have
> to deal with the hardware details.
>
> I feel like there's some tension between "BPF as a dataplane API" and
> "BPF as a kernel extension language" here, especially as the BPF
> subsystem has grown more features in the latter direction. In my mind,
> XDP is still very much a dataplane API; in fact that's one of the main
> selling points wrt DPDK: you can get high performance networking but
> still take advantage of the kernel drivers and other abstractions that
> the kernel provides. If you're going for raw performance and the ability
> to twiddle every tiny detail of the hardware, DPDK fills that niche
> quite nicely (and also shows us the pains of going that route).

Since the thread has been quiet for a day, here is how I'm planning to proc=
eed:
- remove most of the devtx_frame context (but still keep it for
stashing descriptor pointers and having a common kfunc api)
- keep common kfunc interface for common abstractions
- separate skb/xdp hooks - this is probably a good idea anyway to not
mix them up (we are focusing mostly on xdp here)
- continue using raw fentry for now, let's reconsider later, depending
on where we end up with generic apis vs non-generic ones
- add tx checksum to show how this tx-dev-bound framework can be
extended (and show similarities between the timestamp and checksum)

Iow, I'll largely keep the same approach but will try to expose raw
skb/xdp_frame + add tx-csum. Let's reconvene once I send out v3. Thank
you all for the valuable feedback!

