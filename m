Return-Path: <bpf+bounces-12306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869657CAB07
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 16:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7CB1C2084B
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112928DBF;
	Mon, 16 Oct 2023 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="v2E8Za7V"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36528DA2
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 14:11:55 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E3B9
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 07:11:52 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7be88e9ccso57444107b3.2
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697465511; x=1698070311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoMg9g8v8AetHaIX33+R5g/klxkoiqJo8lKn5yAZeN4=;
        b=v2E8Za7VAxnDi44FbnbPJVWINj4RroAyDXFS+SQg54Qqx8uqrXgtya/XCeCtxs9fTY
         NlpT3sxGQz2QmSGpnN3vz8ZwX0BD2C7EiAC1prSKO1xiyaPSb+k2nsYLkZvFDGVQedlr
         9sF3VU9uj7+ASTujvTkAGAQFvHs9ZNyf6SIYl95sIa8qe4rg0q66jw1nh/tEhk2Svpnv
         DhQmVpSNtKBa9VxaD5JpasbiFEmyJHv94MDw15M0RMEnJs6TJYrgu/SJlBSCorz6c4oi
         uhGWBz9epzYI5SQ06Kog5HkFWwadCAXLbLchGPe9Ksq4mZahpRPv+2ejIMi+ydm2fbG0
         HOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697465511; x=1698070311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoMg9g8v8AetHaIX33+R5g/klxkoiqJo8lKn5yAZeN4=;
        b=Cc79TnkssNgXkGBr2d7XwOG3hElNNwhg016WADKtYg0F423VuvgYHfrSfyHesrF+gM
         2W18LvMCqCTly/tSum1eYHLyiuFPR/D073lnIUeFs0b+wmroXFPGR1WlaYxWhHY2dyKQ
         NHvUET0aJaP9cUQ+blCD0Z8B2M/jvmbrQeBnjTaCsdU3R3CU4P9RuWydBew3L02Mu/uL
         7rSwtfK4FJRtEtP708tJhK5m26vpI8zfs1DH3EqY92e6tn9m3YfeSxYPQmw9E0prrHHG
         4kt2jIUT4b1dWTnh1bOv+TvSeCpnLa8TkPAWMGtvsdjdq1gColbzw3HQLZh39qYhrY1m
         rWTg==
X-Gm-Message-State: AOJu0YxNaiZKyRfVAk+IpAXRUbviH4nz8eN4Tx+BbCJ4erT3yclVML4n
	243cRmj5VlGrDcJKfgwYQgXveR23P6ysZ8kGEBGJxQ==
X-Google-Smtp-Source: AGHT+IFDiM/sTqOJUMPI9jE6iHavuJsBX6SSb7PgfjK2X35ACd0wfeFOC/seTYPGktzQFGz9saxb4Rh+GIL2zSE0LS8=
X-Received: by 2002:a81:ae1c:0:b0:5a7:b53f:c304 with SMTP id
 m28-20020a81ae1c000000b005a7b53fc304mr20070484ywh.37.1697465510990; Mon, 16
 Oct 2023 07:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231014180921.833820-1-victor@mojatatu.com> <ZS1CK76Dkyoz6nZo@dcaratti.users.ipa.redhat.com>
In-Reply-To: <ZS1CK76Dkyoz6nZo@dcaratti.users.ipa.redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 16 Oct 2023 10:11:39 -0400
Message-ID: <CAM0EoMkzht8htqRvwhoQBE_Q2D8f8QiEL0geGErhUPsGC0Y3fA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v2 1/1] net: sched: Disambiguate verdict from
 return code
To: Davide Caratti <dcaratti@redhat.com>
Cc: Victor Nogueira <victor@mojatatu.com>, daniel@iogearbox.net, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, paulb@nvidia.com, bpf@vger.kernel.org, mleitner@redhat.com, 
	martin.lau@linux.dev, netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 10:01=E2=80=AFAM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> hello Victor, thanks for the patch!
>
> On Sat, Oct 14, 2023 at 03:09:21PM -0300, Victor Nogueira wrote:
> > Currently there is no way to distinguish between an error and a
> > classification verdict. Which has caused us a lot of pain with buggy qd=
iscs
> > and syzkaller. This patch does 2 things - one is it disambiguates betwe=
en
> > an error and policy decisions. The reasons are added under the auspices=
 of
> > skb drop reason. We add the drop reason as a part of struct tcf_result.
> > That way, tcf_classify can set a proper drop reason when it fails,
> > and we keep the classification result as the tcf_classify's return valu=
e.
> >
> > This patch also adds a variety of drop reasons which are more fine grai=
ned
> > on why a packet was dropped by the TC classification action subsystem.
> >
> > Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > ---
> >
> > v1 -> v2:
> > - Make tcf_classify set drop reason instead of verdict in struct
> >   tcf_result
> > - Make tcf_classify return verdict (as it was doing before)
> > - Only initialise struct tcf_result in tc_run
> > - Add new drop reasons specific to TC
> > - Merged v1 patch with Daniel's patch (https://lore.kernel.org/bpf/2023=
1013141722.21165ef3@kernel.org/T/)
> >   for completeness
>
> Acked-by: Davide Caratti <dcaratti@redhat.com>
>
> By the way, this might be a chance to remove the "TC mirred to Houston"
> printout and replace it with a proper drop reason (see [1]). WDYT?

sigh. So much history there. I recommend
SKB_DROP_REASON_TC_MIRRED_TO_HOUSTON
/me runs

cheers,
jamal
> thanks,
> --
> davide
>
> [1] https://lore.kernel.org/netdev/Yt2CIl7iCoahCPoU@pop-os.localdomain/
>

