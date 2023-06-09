Return-Path: <bpf+bounces-2181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6727728C34
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 02:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B2D28183A
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 00:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93F17E5;
	Fri,  9 Jun 2023 00:09:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4577163
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 00:09:18 +0000 (UTC)
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222142D65
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 17:09:16 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 490C45C1843
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 00:09:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DCC925C1704
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 00:09:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686269355; a=rsa-sha256;
	cv=none;
	b=Dm8pJBm4t1Y/XUNjpQtjQM1gA9Vajvn04YozsTo38K7Tzs7vG5CLvyHMqb2xstfDBAUIct
	ASpqRg3WQ1+XERAMMQkInfpQD6ty3AHKt2rd8lbIygZbBbl4UMP2IgLfd6/+px8JKFMMo3
	9uqdzgq7Twug7VELo09XzjyzXj2k8zSd68acUC2D3YLrlSqt2Pqgmeco4MAY9jr94xf7+O
	xPeSqlsoShHhmHtsmt8DB3uYtbFG1HzrSgrCLEz72LGDKj1MBsBSDyDrKtSBz9F74clABM
	Vgb0SJPAwpOtbmafVfpXdXWSLtNITsSzQmFH7n8NtJ+P/X60xmxrqBxAu2AC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1686269355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lQJUql2528Cy+DS6D/lrrawtBMQvuJVlQtJ26lBfYIk=;
	b=nxCHSGRg3ZJkxRy8SBBy57H+IEcLM5Tkw0MS40CrfH8CGirPp79zFfRrFTmQCeRwKQniia
	8a1XoRqxLi5CPrtqkEBgIRf1Ub1dwswZOyKazoFnbMEJrmBwOQZQ6DDj7fS2CUaNYu1nUE
	d7QkoVPGXyMdum0i1Y9ygfxlyNa4Qb8dmA3txPkdOSqtHl2+agK614vmr68CCc5M1J46fx
	NrxI3Z7ILlECRqDfKsOKFDMb+z4jP18dvk9Ugf5sjDcDXnN1A2UxuEvB0u17+MWtlXJ/ib
	jIvnSlsFdvFRSzI0zSc4l5EQvT3nhjcJ3wkSPeNS2j63XyJlQ/TDFMzRvThbwA==
ARC-Authentication-Results: i=1;
	rspamd-6f5cfd578c-rzxxj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Continue: 0b5c2f5f7d383ed6_1686269356124_1999756448
X-MC-Loop-Signature: 1686269356124:3414464930
X-MC-Ingress-Time: 1686269356123
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.120.24 (trex/6.8.1);
	Fri, 09 Jun 2023 00:09:16 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4QchJq37xqz35
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 17:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1686269355;
	bh=lQJUql2528Cy+DS6D/lrrawtBMQvuJVlQtJ26lBfYIk=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=dDoHPKhVC+rSbuXrQXH1ctahyAjgA25ZAMjDsDW+522psbJy33cRsO9a2Cg/4XYOi
	 Ltrq5G01Y8FBynl/M4J7Vkd2TZtyVkvfX5p5/NuGhPauvEr5fCwwfu8xzC/sb8vZqG
	 PipsXZb9CtdoVe3oOri82oo52gIu8s+CmmhxOwWw=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0042
	by kmjvbox (DragonFly Mail Agent v0.12);
	Thu, 08 Jun 2023 17:09:14 -0700
Date: Thu, 8 Jun 2023 17:09:14 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf: ensure main program has an extable
Message-ID: <20230609000914.GA4980@templeofstupid.com>
References: <cover.1686166633.git.kjlx@templeofstupid.com>
 <de425e99876dc6c344e1a4254894a3c81e71a2ec.1686166633.git.kjlx@templeofstupid.com>
 <CAADnVQJd=_OZJUWVcQH7OtaH2cv8FLsB7kBhxZANsR9O3+AfZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJd=_OZJUWVcQH7OtaH2cv8FLsB7kBhxZANsR9O3+AfZA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 08, 2023 at 03:01:36PM -0700, Alexei Starovoitov wrote:
> On Wed, Jun 7, 2023 at 2:04 PM Krister Johansen <kjlx@templeofstupid.com> wrote:
> > Cc: stable@vger.kernel.org
> > Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
> > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > ---
> >  kernel/bpf/verifier.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5871aa78d01a..d6939db9fbf9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17242,6 +17242,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >         prog->jited = 1;
> >         prog->bpf_func = func[0]->bpf_func;
> >         prog->jited_len = func[0]->jited_len;
> > +       prog->aux->extable = func[0]->aux->extable;
> 
> Why not to do this hunk and what I suggested earlier: start from func=1 ?
> That will address double ksym insertion that Yonghong mentioned.

Sure thing.  Yonghong and you have convinced me.

I'll send out a v3 with all changes requested so far.

-K

