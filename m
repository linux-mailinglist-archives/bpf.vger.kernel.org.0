Return-Path: <bpf+bounces-3515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B500373EF4A
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 01:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65D11C20A27
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFAA15AF5;
	Mon, 26 Jun 2023 23:29:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D115AD0
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 23:29:49 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BF91991
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 16:29:45 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1b0606bee45so62769fac.3
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687822184; x=1690414184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB+hLzf5vN2BpJgn/pfhzOLf4wUhdIzhLLOZSbRwpgM=;
        b=PGSK9sycO/nfwep3uZiYAxPhuzUZoaLAFQgIaZ3vyuBHTMbWwG41g4MMUrGP3RysCX
         NZFzlGs63NIhzCrDVWbcPXj6Ym9wEvWf5LmdTJWSlXdjkEdzHGRMsyr8y1yOWvb2zQHG
         RqZlzhstAbHnyXhejxmucJq9C4GkfpqzPJbSDRV+Kz6GUjqSC52Xe4kM4mZe5+SvG76N
         a+gCf4NcQEUr2FzDgXY9R4I36SODa7jtv070GTAbJvOzzmTJg2t0a12/6WbNTf8zRUG1
         aKwlYaUnjUidXu3BkcOc8ZEo2rVcQ95HLJBfest90TJSUAO8EISnH/dWcHZcVkTzZ4Za
         CcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687822184; x=1690414184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eB+hLzf5vN2BpJgn/pfhzOLf4wUhdIzhLLOZSbRwpgM=;
        b=Dl9SEfZa8IinllQ1lbbZh51ytgM40jfuM6J2+tzXBa8CekW8NOHMyU85HYZ2u3ntmK
         J3jSMGmrnUh89XobreS+b8z1F9MSE2mW38hpGIYF9F3Y6jHQ1yXcdvdbZUxcMIcqa1W5
         dF/wrJatMmeZjPWD2v/rwx6/TJbROXK1pkZKYwas/7Qvg77e1V48NcJUHWfbXorMHcIY
         1CZApEn0a1p5HkNDR/0T7uewpshB6RlGolHCvmAJ+xL6EA873Sv5SuFN2ZWEIBSuPabB
         uoWfah8BKBjNwts1s6apikCvolE71KbWDcpp4pdp00Y7fMd+dprp74KG5HTedF3Tc535
         K9QA==
X-Gm-Message-State: AC+VfDydmhMee3GQasRO5erbiJSPaDWomFwCr0U+PhFrBJcgrwP56pWm
	NvsxOq3sveLu+rPwxPRwCy2nm9LMzEIsry+J46kZbg==
X-Google-Smtp-Source: ACHHUZ5x7Ete2qu0HOyY704vpmm5QNQQ/uoPQKHE11ZOwqsylvlZDZQ92OBa9pnA5GLEzpNW55kAnBcaV+KuulUKtEA=
X-Received: by 2002:a05:6808:148f:b0:39e:7af4:7eea with SMTP id
 e15-20020a056808148f00b0039e7af47eeamr42784391oiw.55.1687822184187; Mon, 26
 Jun 2023 16:29:44 -0700 (PDT)
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
In-Reply-To: <CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 26 Jun 2023 16:29:32 -0700
Message-ID: <CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Donald Hunter <donald.hunter@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 3:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 26, 2023 at 2:36=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > > >
> > > > I'd think HW TX csum is actually simpler than dealing with time,
> > > > will you change your mind if Stan posts Tx csum within a few days? =
:)
>
> Absolutely :) Happy to change my mind.
>
> > > > The set of offloads is barely changing, the lack of clarity
> > > > on what is needed seems overstated. IMHO AF_XDP is getting no use
> > > > today, because everything remotely complex was stripped out of
> > > > the implementation to get it merged. Aren't we hand waving the
> > > > complexity away simply because we don't want to deal with it?
> > > >
> > > > These are the features today's devices support (rx/tx is a mirror):
> > > >  - L4 csum
> > > >  - segmentation
> > > >  - time reporting
> > > >
> > > > Some may also support:
> > > >  - forwarding md tagging
> > > >  - Tx launch time
> > > >  - no fcs
> > > > Legacy / irrelevant:
> > > >  - VLAN insertion
> > >
> > > Right, the goal of the series is to lay out the foundation to support
> > > AF_XDP offloads. I'm starting with tx timestamp because that's more
> > > pressing. But, as I mentioned in another thread, we do have other
> > > users that want to adopt AF_XDP, but due to missing tx offloads, they
> > > aren't able to.
> > >
> > > IMHO, with pre-tx/post-tx hooks, it's pretty easy to go from TX
> > > timestamp to TX checksum offload, we don't need a lot:
> > > - define another generic kfunc bpf_request_tx_csum(from, to)
> > > - drivers implement it
> > > - af_xdp users call this kfunc from devtx hook
> > >
> > > We seem to be arguing over start-with-my-specific-narrow-use-case vs
> > > start-with-generic implementation, so maybe time for the office hours=
?
> > > I can try to present some cohesive plan of how we start with the fram=
ework
> > > plus tx-timestamp and expand with tx-checksum/etc. There is a lot of
> > > commonality in these offloads, so I'm probably not communicating it
> > > properly..
> >
> > Or, maybe a better suggestion: let me try to implement TX checksum
> > kfunc in the v3 (to show how to build on top this series).
> > Having code is better than doing slides :-D
>
> That would certainly help :)
> What I got out of your lsfmmbpf talk is that timestamp is your
> main and only use case. tx checksum for af_xdp is the other use case,
> but it's not yours, so you sort-of use it as an extra justification
> for timestamp. Hence my negative reaction to 'generality'.
> I think we'll have better results in designing an api
> when we look at these two use cases independently.
> And implement them in patches solving specifically timestamp
> with normal skb traffic and tx checksum for af_xdp as two independent api=
s.
> If it looks like we can extract a common framework out of them. Great.
> But trying to generalize before truly addressing both cases
> is likely to cripple both apis.

I need timestamps for the af_xdp case and I don't really care about skb :-(
I brought skb into the picture mostly to cover John's cases.
So maybe let's drop the skb case for now and focus on af_xdp?
skb is convenient testing-wise though (with veth), but maybe I can
somehow carve-out af_xdp skbs only out of it..

Regarding timestamp vs checksum: timestamp is more pressing, but I do
have people around that want to use af_xdp but need multibuf + tx
offloads, so I was hoping to at least have a path for more tx offloads
after we're done with tx timestamp "offload"..

> It doesn't have to be only two use cases.
> I completely agree with Kuba that:
>  - L4 csum
>  - segmentation
>  - time reporting
> are universal HW NIC features and we need to have an api
> that exposes these features in programmable way to bpf progs in the kerne=
l
> and through af_xdp to user space.
> I mainly suggest addressing them one by one and look
> for common code bits and api similarities later.

Ack, let me see if I can fit tx csum into the picture. I still feel
like we need these dev-bound tracing programs if we want to trigger
kfuncs safely, but maybe we can simplify further..

