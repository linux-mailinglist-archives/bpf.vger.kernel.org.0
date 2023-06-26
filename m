Return-Path: <bpf+bounces-3516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DEE73EF4D
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 01:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D387C280EF6
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36315AED;
	Mon, 26 Jun 2023 23:30:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1D15AE7
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 23:30:02 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C69EFB
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 16:30:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b801e6ce85so11271745ad.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 16:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687822201; x=1690414201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBfFQZUX3TFp/GqwGJFfJB4DrjscjdNgSaY0xn6MjAM=;
        b=6B+xzRZ4Vr6/d44ciru9AZg0TUC+dDojZ+J4hgY6gSezr7tUqy4vxRZfwHG7x+xUFq
         Ds3JKiZuneil7R5laOCCwtgqLitSPFKlw895SklwI1CnY4xlSPNINmzcruyy6MBYJNZR
         otj55X4qsL6vk5KAYqCZRgF4ugyb9K3WX512bE4Q+EGl1RXBjRARf4HtIKTv4OzmZOji
         dvjR1J96ASORVMMFFxTCJL+6ddzCL5opClDZ8MBdqHxsc21CD/YmrXILivuhBxSTEriD
         eLrumf4R02/zNnwgPk97gm4ngdqxbXYnML3GtUOLuW15rpNzdeUp4bn1K7mo1JvL82oT
         U//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687822201; x=1690414201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBfFQZUX3TFp/GqwGJFfJB4DrjscjdNgSaY0xn6MjAM=;
        b=WTOfTaVwG/07pzG1+s89X8NQQhbwye7EexIWUH7pMdEVi9+fHY0RiYzJu6ayNxkA9p
         V0ve91IFw2cLFqz9Q+JPXq3ywSl8WoVbLPlxMNcfOyaGyhkMPUJAAHiL/eymkR6G+qzT
         gBUa+p49EAvDvD2AGpHYaq/gWGomVkinaJD16dIdIQly/F/lcmXxaBWhm6cx9HnInA3X
         xs6RYATgxydxj321VTejxS5GsIw9cg+3riHvi8S3fCTsTlwqTBju7lPEEcrDG5KEBnbb
         5BQfWTz7SGLEpZS2ll0vU53YAc6cN7+04aOcfc5fCvNic6oxWrWSYiI+LkOLsoR3aIN0
         reKA==
X-Gm-Message-State: AC+VfDzU+pay2hgAwEuiOHC8UYDX6L8AheRi56VBgmtyzGdCvj34FH2Y
	H0xqQF6AlFwuUJ0ON6JClnfTL66hLctLFf67lxBsnA==
X-Google-Smtp-Source: ACHHUZ7kmR/5IyInq4cGj0nTDpcqrTcSrOkofcHLV+HyI1PKaxQ289bhH25bXNqhGOWXDADOI4KFESBvCraLaHPdPAw=
X-Received: by 2002:a17:902:ecca:b0:1b3:c62d:71b7 with SMTP id
 a10-20020a170902ecca00b001b3c62d71b7mr9340964plh.18.1687822200626; Mon, 26
 Jun 2023 16:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-7-sdf@google.com>
 <87edm1rc4m.fsf@intel.com> <CAKH8qBt1GHnY2jVac--xymN-ch8iCDftiBckzp9wvTJ7k-3zAg@mail.gmail.com>
 <874jmtrij4.fsf@intel.com>
In-Reply-To: <874jmtrij4.fsf@intel.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 26 Jun 2023 16:29:49 -0700
Message-ID: <CAKH8qBvnqOvCnp2C=hmPGwCcEz4UkuE9nod2N9sNmpPve9n_CQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 06/11] net: veth: Implement devtx timestamp kfuncs
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 3:00=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > On Fri, Jun 23, 2023 at 4:29=E2=80=AFPM Vinicius Costa Gomes
> > <vinicius.gomes@intel.com> wrote:
> >>
> >> Stanislav Fomichev <sdf@google.com> writes:
> >>
> >> > Have a software-based example for kfuncs to showcase how it
> >> > can be used in the real devices and to have something to
> >> > test against in the selftests.
> >> >
> >> > Both path (skb & xdp) are covered. Only the skb path is really
> >> > tested though.
> >> >
> >> > Cc: netdev@vger.kernel.org
> >> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>
> >> Not really related to this patch, but to how it would work with
> >> different drivers/hardware.
> >>
> >> In some of our hardware (the ones handled by igc/igb, for example), th=
e
> >> timestamp notification comes some time after the transmit completion
> >> event.
> >>
> >> From what I could gather, the idea would be for the driver to "hold" t=
he
> >> completion until the timestamp is ready and then signal the completion
> >> of the frame. Is that right?
> >
> > Yeah, that might be the option. Do you think it could work?
> >
>
> For the skb and XDP cases, yeah, just holding the completion for a while
> seems like it's going to work.
>
> XDP ZC looks more complicated to me, not sure if it's only a matter of
> adding something like:

[..]

> void xsk_tx_completed_one(struct xsk_buff_pool *pool, struct xdp_buff *xd=
p);
>
> Or if more changes would be needed. I am trying to think about the case
> that the user sent a single "timestamp" packet among a bunch of
> "non-timestamp" packets.

Since you're passing xdp_buff as an argument I'm assuming that is
suggesting out-of-order completions?
The completion queue is a single index, we can't do ooo stuff.
So you'd have to hold a bunch of packets until you receive the
timestamp completion; after this event, you can complete the whole
batch (1 packet waiting for the timestamp + a bunch that have been
transmitted afterwards but were still unacknowleged in the queue).

(lmk if I've misinterpreted)

