Return-Path: <bpf+bounces-5864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334A67622C2
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 21:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627151C20FAB
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339026B1B;
	Tue, 25 Jul 2023 19:57:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD02516D
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 19:57:28 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D119A1;
	Tue, 25 Jul 2023 12:57:26 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so86697381fa.1;
        Tue, 25 Jul 2023 12:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690315045; x=1690919845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yen3PpUnvgoQ4DZ/oMdMMFtdUkFHQ/IxYq1HMzpRxs=;
        b=P5Bn65AOjBhU+zzBiOPQ4y1un78QFAoHlGvedaa9IfI1JQCwoe87ROcWWlolypIL8v
         LGdTSQs4BCyPMqyUOX7Zh95oqVy4wTlwpleyNwCwphn/jQoIr2MHclRdyQkfL9n5TR98
         IxtsWCt51XJ3rhUwlH+rq2szYLp0ZhvwlM8C2muHDEd1JH0T4itXEdrQYqMiAv4Tq/ip
         HdQ5l5VQ5cLzauBrn2l7KGmbpxmlX/i1YEScpxp2oHcS4gtJP56cn9/HxWomzaaBqV51
         Ed2guzCLqMhPHfr4baC/c/kFyES2KH1clhrd/w62rrgKf7TlGf2TqRnKwLT9In8aLYAI
         MdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690315045; x=1690919845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yen3PpUnvgoQ4DZ/oMdMMFtdUkFHQ/IxYq1HMzpRxs=;
        b=iwm4V5Zm6rA6StJysRa1JF8EbhWY8V2r+ShZy31o5UPf3XNx43KtAKeDdwK+jNzLbc
         3xpXrHlcR5Gs/EQJ0w3Gd9k5b7r/7y2CQU7zPAbtRxIFZYO8dUnv3/1Ah0hz09F0RBMH
         QAYGkZ2eOkq/KLNnBCENgSM+nO40lGCjJgQRbNobSdAWtLwOvHnbzGlnssOlHphXrrv8
         PeYLeypXhSMQgd4GaKNPCSHaSOcrgi6xBRwccOKP0hkMaa6pUScaqPRqjqepUbnCsUnj
         +p4rjQd1HkugMPodD8mkcsHA6tlBZEQz4SE+XQ48rqtMDBm33CdiO80uMcmY1Ke9uI4V
         RpOA==
X-Gm-Message-State: ABy/qLa7MQmewdftMaEAi60sqNyIojqwjts/15syDsYtiSj3N5CEOA41
	Tsdt0dijtutpaPs+nb8hFlrIbCSYWuJh/O4Ypda/ol495po=
X-Google-Smtp-Source: APBJJlEb7U9cEDLDgZTHYlxcnE31txxPPmxzCpE3HBQyLyNBf63D/uKKgC4U3OCtIGnRhb1mklHep5LdRmNaCewm7FE=
X-Received: by 2002:a2e:8884:0:b0:2b9:2e85:2f9b with SMTP id
 k4-20020a2e8884000000b002b92e852f9bmr9889492lji.2.1690315044862; Tue, 25 Jul
 2023 12:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLfK3WzBo=dPJ0WEvpO4wFPnSp1uEkBXRWpxRSz7Guou3z7kw@mail.gmail.com>
 <20230725193346.GA5720@breakpoint.cc>
In-Reply-To: <20230725193346.GA5720@breakpoint.cc>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jul 2023 12:57:13 -0700
Message-ID: <CAADnVQJ+bQ=2XJgY815TfAK-K8BgDAD6n9pLXBHbwBZhsxnUtA@mail.gmail.com>
Subject: Re: ct state module issue
To: Florian Westphal <fw@strlen.de>
Cc: Matt Zagrabelny <mzagrabe@d.umn.edu>, netfilter <netfilter@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 12:33=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
>
> [ CCing bpf/btf experts ]
>
> > I'm running kernel: 6.1.0-10-amd64
> > and
> > nftables v1.0.6 (Lester Gooch #5)
> >
> > I have a set of nftables rules that have served me well for Debian 11
> > - thanks in large part to the netfilter mailing list, so...thank you!
> > nftables on Debian 11 is: 0.9.8-3.1+deb11u1
> >
> > I have recently installed Debian 12 and tried my nftables rules and
> > have hit a snag with the connection tracking and a verdict map.
> > nftables on Debian 12 is: 1.0.6-2+deb12u1
> >
> > When I run the offending snippet:
> >
> > # nft -f /etc/nftables.conf.d/300-common.d/200-connection-tracking.nft
> > /etc/nftables.conf.d/300-common.d/200-connection-tracking.nft:4:9-16:
> > Error: Could not process rule: No such file or directory
> >         ct state vmap {
>
> [..]
>         ^^^^^^^^
> > When I watch the kernel logs (journalctl), I see:
> >
> > Jul 25 13:44:04 localhost kernel: BPF: [99725] STRUCT
> > Jul 25 13:44:04 localhost kernel: BPF: size=3D104 vlen=3D12
> > Jul 25 13:44:04 localhost kernel: BPF:
> > Jul 25 13:44:04 localhost kernel: BPF: Invalid name
> > Jul 25 13:44:04 localhost kernel: BPF:
> > Jul 25 13:44:04 localhost kernel: failed to validate module
> > [nf_conntrack] BTF: -22
> > Jul 25 13:44:04 localhost kernel: missing module BTF, cannot register k=
funcs
>
> So nf_conntrack.ko fails to load because of a btf issue.
>
> My question to bpf folks is:
>
> Should we make register_nf_conntrack_bpf() return 'void'?
>
> This way normal conntrack would still work.  bpf programs using
> conntrack kfuncs would fail, but above dmesg splat already gives
> a clue as to why conntrack kfuncs aren't there.
>
> No idea about the actual problem or how to debug that, but bpf
> people should know.

The pr_err() was changed to pr_warn() in
commit 3de4d22cc9ac ("bpf, btf: Warn but return no error for NULL btf
from __register_btf_kfunc_id_set()").


Please upgrade the kernel and ignore the warn if you don't need bpf/btf/kfu=
ncs.

Three links in that commit provide more details.

