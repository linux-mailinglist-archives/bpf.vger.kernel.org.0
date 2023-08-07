Return-Path: <bpf+bounces-7164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E618772639
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 15:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917A61C20B40
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29160107B1;
	Mon,  7 Aug 2023 13:42:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D4D51D;
	Mon,  7 Aug 2023 13:42:09 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2A01738;
	Mon,  7 Aug 2023 06:41:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 917EC5C00D8;
	Mon,  7 Aug 2023 09:41:12 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute4.internal (MEProxy); Mon, 07 Aug 2023 09:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1691415672; x=1691502072; bh=+lJs9GYWBNiOAOVqXWOH5SilIPKlB6jLhY/
	Q7PdyL5M=; b=c312f7jQA5+I9qUi7iYMuedJv8L70Agehy5ZgTGHu0Pz7W02Ppn
	1Z0zgOZSW2+Bv0x1KO8g+qvpdX1jJY9WG7g8pnbWkBwFEqg+84zoWP6S1dnE7MOS
	/r5DMQ22koAnK/vCle3StbOWP1xM3F5JzzvnVMv0Jvu4iwB13wo60yRWIiRPYs8s
	dpF+gV36ExFSygq4CkMunTHg+MxRP+jvBJ3G9mvxbnZYKcq5kVzTIJ4PU2BftWrI
	rIqavDwtv+cKnHvhLqrb9Olfx19dG+6qv4BLCUYeF3gzezjfCInoecIgUXOPFgmq
	gKw6f8dhXk8CKVhPpBlgOGitVCq0DA2/GAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1691415672; x=1691502072; bh=+lJs9GYWBNiOAOVqXWOH5SilIPKlB6jLhY/
	Q7PdyL5M=; b=NmN9ldXHdYl8oT9Ay+qbHn3v/Q5TrM9dwmeMiGBHNbuFtqFFVdZ
	FXsekpSzser2hjjbLWZ/LFfpy6gvCojDVo1zSsWnBWA2S9biWuK2PNGZjIUuHPaQ
	KSOgleN5/FltuUD9QXOf+3+vgw0/wtK8mW/Muqm5QrAo3DWsiku0TZ4RO00bodPk
	JO8BV/lilVlQWU+XpztM96iCKIKwwSDwherBuYJg/SNy7U/NlpU5YFmiFjBuAqOt
	YAu/EGAYSG+RQAIw48t/gpQcCDKqgZivS1eVophmS2qSHNE3Y7sIO1zevL+gB6Ub
	7+5imLaLazgqYAv+x+upwHIMgfwCiAz68lQ==
X-ME-Sender: <xms:ePTQZFhj4BgrepeJi7gipSXbCHfnu4sfbC1YaTdukRmuHiUmlFzMQw>
    <xme:ePTQZKB44V1VXUw48nKXZAuErKB1R2HqBUCcfQjQawoD_6-TDqFoYJYgWxegv7JZW
    5yt_j2Yacpz42u3gWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpeforghn
    jhhushgrkhgruceomhgvsehmrghnjhhushgrkhgrrdhmvgeqnecuggftrfgrthhtvghrnh
    epffdvfeejleefjeegfedtieeuleelhffhuedufeevkeeltdelgeetiefgkefhvddvnecu
    ffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgvsehmrghnjhhushgrkhgrrdhmvg
X-ME-Proxy: <xmx:ePTQZFF0QHaQLh1RuKjgP3zP_kN2U6dPHVkA5Ifwxv4-qBYP4sVzRw>
    <xmx:ePTQZKS4gf-qO2z8zRIqXaGcMLLcjMzBhUNKfyGESlz_n0btgobuwQ>
    <xmx:ePTQZCy6kgGn8XT-ax_a7z8RwXM3cWFKhnIlooeEJoUUFKOiea6Fwg>
    <xmx:ePTQZBkTqdOKcxNm50I0dY9yK8GyISvfGeqwQLd9PoRJs8ahLIPh1Q>
Feedback-ID: i3ea9498d:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4B4B831A0065; Mon,  7 Aug 2023 09:41:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <9f0abdcc-1cb2-4a4a-8348-4fcbd2be9a53@app.fastmail.com>
In-Reply-To: 
 <CANn89iJAu5CLq1LkRLt0qJ+ytFGXWGqymMHBnMevcPS4Z2GAXQ@mail.gmail.com>
References: <20230806075216.13378-1-me@manjusaka.me>
 <CANn89i+bMh-xU7PCxf_O5N+vy=83S+V=23mAAmbCuhjuP5Ob9g@mail.gmail.com>
 <8d25f9e8-9653-4e9b-b88b-c5434ce8aabf@app.fastmail.com>
 <CANn89iJAu5CLq1LkRLt0qJ+ytFGXWGqymMHBnMevcPS4Z2GAXQ@mail.gmail.com>
Date: Mon, 07 Aug 2023 21:40:50 +0800
From: Manjusaka <me@manjusaka.me>
To: "Eric Dumazet" <edumazet@google.com>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] [RFC PATCH] tcp event: add new tcp:tcp_cwnd_restart event
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Got you means! LGTM

I will make a patch later and make a try

On Mon, Aug 7, 2023, at 9:25 PM, Eric Dumazet wrote:
> On Mon, Aug 7, 2023 at 2:49=E2=80=AFPM Manjusaka <me@manjusaka.me> wro=
te:
> >
> > > Do not include code before variable declarations.
> > Sorry about that. I will update the code later.
> >
> > > I would rather add a trace in tcp_ca_event(), this would be more g=
eneric ?
> >
> > https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_cong.c#L=
41
> >
> > I think maybe we already have the tcp_ca_event but named tcp_cong_st=
ate_set?
>=20
> I am speaking of tcp_ca_event()...
>=20
> For instance, tcp_cwnd_restart() calls tcp_ca_event(sk, CA_EVENT_CWND_=
RESTART);
>=20
> tcp_set_ca_state() can only set icsk_ca_state to one value from enum
> tcp_ca_state:
> TCP_CA_Open, TCP_CA_Disorder, TCP_CA_CWR, TCP_CA_Recovery, TCP_CA_Loss
>=20
> enum tcp_ca_event has instead:
> CA_EVENT_TX_START, CA_EVENT_CWND_RESTART, CA_EVENT_COMPLETE_CWR,
> CA_EVENT_LOSS, CA_EVENT_ECN_NO_CE, CA_EVENT_ECN_IS_CE
>=20

