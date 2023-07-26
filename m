Return-Path: <bpf+bounces-5980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C1763C3D
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 18:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178871C21389
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B263799C;
	Wed, 26 Jul 2023 16:19:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B35E57F
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 16:19:27 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BC72701;
	Wed, 26 Jul 2023 09:19:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b97f34239cso70684981fa.3;
        Wed, 26 Jul 2023 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690388362; x=1690993162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfaC9K7AqxGN6MEogR0sLkTz3CLcnEyvD5fFKZave0o=;
        b=OHc15JB4eCNfL01BE/0pcgcCKs/JsOn9sIzlzgOHzgpSveViDn7GBZvfjgMl90NnJe
         UJwfnMw61noay5LQGtp6FAFFYwFYBz2Ybq3Owx0sQ+787H8QNq3Ya6/M1WMwttG5OzFo
         vl5mW12olIDPt2nTgqjCTk4qNyxs034tKGuIsKmyFYiQ1sJj098h2F9384BUhLEH9FWz
         7cQvFEHgYZcfB61/muC3A9t6NrAzZGHRGUdd0SyuGOpdmkuqZWWtclbIbAgkUOZBB6Nn
         4FxNxvj1FPHkzGaRypO0hMNhYfWh+/RPG4yTfzmwp8VckL4ieojNlX4dqb43OfdSJDnw
         IfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388362; x=1690993162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfaC9K7AqxGN6MEogR0sLkTz3CLcnEyvD5fFKZave0o=;
        b=MGTISIQNXOhoBTO9sFIFYwmdLYle2vA/kFNAf19Y0JLIjpSvZzZS2RtG/9Ck0tlvdJ
         WlLvbIja4ULqY/3S88nsfDLlwlaj15VbioP0nAw5zxmH10y7Pm/D3mwqeJEE4ZZIfM7v
         Ytmrii+9E8lvqjHjGpCJs4RwvdTP8Md7npb3E+hnEF2Pe2e7yKeihqHsp6F96SiManQ9
         SMpaO6N6Sw84vRKwTBxy1pJRm4Yk4J59UMc1wTR52yNh04Mtzfo8QyLRUNKRvFnUWZQE
         pszXYs8H3r4nt/Tm9ZQIYZteh7fuwrT/Vc9OI4Rz568pifaGrWSYlc+BZyIORMB9Xq2e
         P7Jg==
X-Gm-Message-State: ABy/qLYo+vJdpkPMvHC6kHK9EBOHwe91fWezhcn7ZiqwvBlewugmeJP5
	NiFGPmQIr4+gYkBASMeFo+k3ouocj7Z21C/iKnM=
X-Google-Smtp-Source: APBJJlEAb7i5IKahpzWZRgiR8kWFoslt8sZo+RSCeQSp2ZnKVneKcu5hLtrcKBF8JN1NoCxfgE4N6O8OgfftorxAngE=
X-Received: by 2002:a2e:9d9a:0:b0:2b9:b9c8:99 with SMTP id c26-20020a2e9d9a000000b002b9b9c80099mr1501570ljj.22.1690388361344;
 Wed, 26 Jul 2023 09:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLfK3WzBo=dPJ0WEvpO4wFPnSp1uEkBXRWpxRSz7Guou3z7kw@mail.gmail.com>
 <20230725193346.GA5720@breakpoint.cc> <CAADnVQJ+bQ=2XJgY815TfAK-K8BgDAD6n9pLXBHbwBZhsxnUtA@mail.gmail.com>
 <ZMDNywzqUqjmdhOO@calendula>
In-Reply-To: <ZMDNywzqUqjmdhOO@calendula>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Jul 2023 09:19:10 -0700
Message-ID: <CAADnVQ+PHXbeGjm6ty6f7KbGZGinvng1SG_BdDh85T=1tvHoXQ@mail.gmail.com>
Subject: Re: ct state module issue
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, Matt Zagrabelny <mzagrabe@d.umn.edu>, 
	netfilter <netfilter@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 12:40=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter=
.org> wrote:
>
> Hi Alexei,
>
> On Tue, Jul 25, 2023 at 12:57:13PM -0700, Alexei Starovoitov wrote:
> > On Tue, Jul 25, 2023 at 12:33=E2=80=AFPM Florian Westphal <fw@strlen.de=
> wrote:
> > >
> > > Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
> > >
> > > [ CCing bpf/btf experts ]
> > >
> > > > I'm running kernel: 6.1.0-10-amd64
> > > > and
> > > > nftables v1.0.6 (Lester Gooch #5)
> > > >
> > > > I have a set of nftables rules that have served me well for Debian =
11
> > > > - thanks in large part to the netfilter mailing list, so...thank yo=
u!
> > > > nftables on Debian 11 is: 0.9.8-3.1+deb11u1
> > > >
> > > > I have recently installed Debian 12 and tried my nftables rules and
> > > > have hit a snag with the connection tracking and a verdict map.
> > > > nftables on Debian 12 is: 1.0.6-2+deb12u1
> > > >
> > > > When I run the offending snippet:
> > > >
> > > > # nft -f /etc/nftables.conf.d/300-common.d/200-connection-tracking.=
nft
> > > > /etc/nftables.conf.d/300-common.d/200-connection-tracking.nft:4:9-1=
6:
> > > > Error: Could not process rule: No such file or directory
> > > >         ct state vmap {
> > >
> > > [..]
> > >         ^^^^^^^^
> > > > When I watch the kernel logs (journalctl), I see:
> > > >
> > > > Jul 25 13:44:04 localhost kernel: BPF: [99725] STRUCT
> > > > Jul 25 13:44:04 localhost kernel: BPF: size=3D104 vlen=3D12
> > > > Jul 25 13:44:04 localhost kernel: BPF:
> > > > Jul 25 13:44:04 localhost kernel: BPF: Invalid name
> > > > Jul 25 13:44:04 localhost kernel: BPF:
> > > > Jul 25 13:44:04 localhost kernel: failed to validate module
> > > > [nf_conntrack] BTF: -22
> > > > Jul 25 13:44:04 localhost kernel: missing module BTF, cannot regist=
er kfuncs
> > >
> > > So nf_conntrack.ko fails to load because of a btf issue.
> > >
> > > My question to bpf folks is:
> > >
> > > Should we make register_nf_conntrack_bpf() return 'void'?
> > >
> > > This way normal conntrack would still work.  bpf programs using
> > > conntrack kfuncs would fail, but above dmesg splat already gives
> > > a clue as to why conntrack kfuncs aren't there.
> > >
> > > No idea about the actual problem or how to debug that, but bpf
> > > people should know.
> >
> > The pr_err() was changed to pr_warn() in
> > commit 3de4d22cc9ac ("bpf, btf: Warn but return no error for NULL btf
> > from __register_btf_kfunc_id_set()").
>
> OK, no ENOENT anymore, hence no bail out.
>
> > Please upgrade the kernel and ignore the warn if you don't need bpf/btf=
/kfuncs.
> >
> > Three links in that commit provide more details.
>
> Jul 25 13:44:04 localhost kernel: BPF: [99725] STRUCT
> Jul 25 13:44:04 localhost kernel: BPF: size=3D104 vlen=3D12
> Jul 25 13:44:04 localhost kernel: BPF:
> Jul 25 13:44:04 localhost kernel: BPF: Invalid name
> Jul 25 13:44:04 localhost kernel: BPF:
>
> Are these debugging logs above still displayed? Maybe remove them too
> or only display them when all required things are in place and users
> opt-in to use this new infrastructure?

Kernel doesn't print them to console. These messages go to BTF verifier log
supplied by user space. It's not clear what process sends them to journalct=
l.

