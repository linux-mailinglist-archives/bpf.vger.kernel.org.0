Return-Path: <bpf+bounces-12522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DF7CD5EB
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 10:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970AB1C20CCB
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA11427D;
	Wed, 18 Oct 2023 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1mIrJ2R8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7513AF4
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 08:03:06 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC0C6
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 01:03:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so6658a12.1
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697616183; x=1698220983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYmrzfbSpfhJpzk7wxE5iReTZLh+c/L+KaX/QfF6tjk=;
        b=1mIrJ2R8kgz3fLvgnIfqcoivKep/rXahaIs5g1vyLRsgUikU4Ncfxis3iFsp94DBPG
         m3ZblEAe1rd9Gej3u3HNkHrH1MCH3AihxYkCfPdsBjmEF2LrEeBkh0taI19LPG1Gnhru
         KOjo2Sx1n5g4vtDcGY0ERcsi/sXR1Bwagu5XtCqLUh9VsG1igU2DclZ9W5Ss3Jy3VDDX
         oTG1PaQtDKN/PflOStpMmCDTxZOACzhGIVSWG1XqssUwFMFiESqsodYiCDMm9OjJ3kTd
         PW+m4olsM9pVo9JK4uspwsnykcp9AXbULz459f7EB29rw0a1gh0on+lL1RQZNJtU00Qz
         IR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697616183; x=1698220983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYmrzfbSpfhJpzk7wxE5iReTZLh+c/L+KaX/QfF6tjk=;
        b=sUQ+H8/Oe9PCK/cVl8SzAuICMWPWMNSp0f1+p5nx0Pc+JICSwvnKvISMfwWnLQOkeQ
         V5QvR1J29CB0p7TQMhInOss7WY5owyLVa7jCRrXR7E/0JAVjT6qPLifZNAG74W3hnX9l
         L5i5qVacdcRVLMAQIqcrZRdSrp/xrbSsMSBF/ZTiJxpqVCrmSl6h5lbZWg5/fc73IN58
         wPNCkp34h4nstZQuHdthS+5miKQwl996XF7Td0q3NzlK0KW92HKQL4teY+hxTvB7mh8/
         yiEK0OEQrlIcGx3DUe+VQoxwHkM5wopLbiR+ly0wMNM+7HMDUXwh7Ap/ZOfZN/tWMej9
         vqGQ==
X-Gm-Message-State: AOJu0YxBvnKtLg5PAKMbTl7xVozCU4H9kp4DuaqDn+6TXg8H14c3ExHe
	8kZSYgFpOLY8MjuisEndkKIEd5V/QEpxbzfN1nN0iw==
X-Google-Smtp-Source: AGHT+IFNOBt7ly7V+Ed15uta76GiRvvZPhBglemdtKMriR48IhSCOFLraZDtdINSzwx5L7ePd0DZkOL9sOFndhSQ6j0=
X-Received: by 2002:a50:cd98:0:b0:53f:3d3d:8b04 with SMTP id
 p24-20020a50cd98000000b0053f3d3d8b04mr116320edi.2.1697616183032; Wed, 18 Oct
 2023 01:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9666242b-d899-c428-55bd-14f724cc4ffd@linux.dev>
 <20231017164807.19824-1-kuniyu@amazon.com> <469fd0e9-686f-f1dc-cb45-6c50ff126ccf@linux.dev>
In-Reply-To: <469fd0e9-686f-f1dc-cb45-6c50ff126ccf@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Oct 2023 10:02:51 +0200
Message-ID: <CANn89iLZDvqrGy9UJ39a49O3NLT74r+5FXfh7u3SxSSm60BJmA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie
 generation/validation SOCK_OPS hooks.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	dsahern@kernel.org, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	mykolal@fb.com, netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 8:19=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/17/23 9:48 AM, Kuniyuki Iwashima wrote:
> > From: Martin KaFai Lau <martin.lau@linux.dev>
> > Date: Mon, 16 Oct 2023 22:53:15 -0700
> >> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> >>> Under SYN Flood, the TCP stack generates SYN Cookie to remain statele=
ss
> >>> After 3WHS, the proxy restores SYN and forwards it and ACK to the bac=
kend
> >>> server.  Our kernel module works at Netfilter input/output hooks and =
first
> >>> feeds SYN to the TCP stack to initiate 3WHS.  When the module is trig=
gered
> >>> for SYN+ACK, it looks up the corresponding request socket and overwri=
tes
> >>> tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
> >>> complete 3WHS with the original ACK as is.
> >>
> >> Does the current kernel module also use the timestamp bits differently=
?
> >> (something like patch 8 and patch 10 trying to do)
> >
> > Our SYN Proxy uses TS as is.  The proxy nodes generate a random number
> > if TS is in SYN.
> >
> > But I thought someone would suggest making TS available so that we can
> > mock the default behaviour at least, and it would be more acceptable.
> >
> > The selftest uses TS just to strengthen security by validating 32-bits
> > hash.  Dropping a part of hash makes collision easier to happen, but
> > 24-bits were sufficient for us to reduce SYN flood to the managable
> > level at the backend.
>
> While enabling bpf to customize the syncookie (and timestamp), I want to =
explore
> where can this also be done other than at the tcp layer.
>
> Have you thought about directly sending the SYNACK back at a lower layer =
like
> tc/xdp after receiving the SYN? There are already bpf_tcp_{gen,check}_syn=
cookie
> helper that allows to do this for the performance reason to absorb synflo=
od. It
> will be natural to extend it to handle the customized syncookie also.
>
> I think it should already be doable to send a SYNACK back with customized
> syncookie (and timestamp) at tc/xdp today.
>
> When ack is received, the prog@tc/xdp can verify the cookie. It will prob=
ably
> need some new kfuncs to create the ireq and queue the child socket. The b=
pf prog
> can change the ireq->{snd_wscale, sack_ok...} if needed. The details of t=
he
> kfuncs need some more thoughts. I think most of the bpf-side infra is rea=
dy,
> e.g. acquire/release/ref-tracking...etc.
>

I think I mostly agree with this.

I am rebasing  a patch adding usec resolution to TCP TS,
that we used for about 10 years at Google, because it is time to upstream i=
t.

I am worried about more changes/conflicts caused by Kuniyuki patch set...

