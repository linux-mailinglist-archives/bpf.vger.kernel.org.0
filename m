Return-Path: <bpf+bounces-6636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BF76C057
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 00:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA140281AFE
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2E727714;
	Tue,  1 Aug 2023 22:22:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2854DC94
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 22:22:16 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF01BFD;
	Tue,  1 Aug 2023 15:22:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so8830141e87.3;
        Tue, 01 Aug 2023 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690928531; x=1691533331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Drqh2sT1zBZMilh9RfOVtxF5CcsHZfTI9cSZ6ogTqM=;
        b=fAEw8pMuFSSL+uoE0Rj73sLu0P3dy0Hja/NJaRmTo9YGzvWK3QpbKMoFFTalgKLL90
         /ECLSOAhifAqm/cMnA+hIP7UPvncdSOpoDAxAgWDwkaf3jlRDilO1t0P57NTQ+2LP3sR
         knD/MkDaWSgWaoKs1JOlIwhVcyrtYl/yUlmkRpTWwDMtoczIQQ3OcQ9LjYeGVoaPZvLo
         kHFQFPUtT10IC87Ur10hjnjSAEZL3Ctuo4dMDcqfqUaqTAZei+jPyJJyzFMeFySSuYHx
         67azAEws2lWARt5Bz2P5xO0X+VQaZ7IjmsFhJB2Kr53x3YuIwKzXzFHEp2g2i2KR3u+Q
         X2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690928531; x=1691533331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Drqh2sT1zBZMilh9RfOVtxF5CcsHZfTI9cSZ6ogTqM=;
        b=I2MVqnoKlN/vTpp/7P1TrA+E50HunztMG8Z/s8tmiKeOg5WILRFOCSDi5ruA3epCAg
         0ROTxM4gL0eU9OnUrrEgQRKOdSutGiZfUVSL7jXFT5Bw+waAvsiycrvuqgm/p9k6+V4q
         XjzyBf8nouiAI9W+f8MO4DRKjuFeBhB1aYw22kE74C6HLeued6vau7aDlHeP0L4xTyHn
         HZz1KY4R+adxQOCOFMoYD52hSV2/HpzNaFGB+K/COI5sxt9rgedOCQ4AxPe3UclCTZwv
         C+1WM6GC30lNhWrSryRVwvyGYmONaQXqRrmJXN16kV5ZCvKFO8cIJz9Jkx9k2plEPed1
         Sn5Q==
X-Gm-Message-State: ABy/qLaunP/HuvJpT8MXvOUE1FxJYqCfWtf98VlzV9Lb/OuJ2/x10u69
	v3upxQOm/XU7cF+jkx7R2bzKDCqGE/g7x6h7k5Y=
X-Google-Smtp-Source: APBJJlGiVqIOr+vkCxGHcpSpIB2TRJjX3OvvxBIukS5jr3bMWJBBhBigqHSsz8HmbGWFyZHJRTZCju8xnMSEYHpymWA=
X-Received: by 2002:a19:e058:0:b0:4f8:69f8:47a0 with SMTP id
 g24-20020a19e058000000b004f869f847a0mr2724007lfj.29.1690928530617; Tue, 01
 Aug 2023 15:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
 <169078863449.173706.2322042687021909241.stgit@devnote2> <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230731211527.3bde484d@gandalf.local.home> <CAADnVQJz41QgpFHr3k0pndjHZ8ragH--=C_bYxrzitj7bN3bbg@mail.gmail.com>
 <20230802001824.90819c7355283843178d9163@kernel.org>
In-Reply-To: <20230802001824.90819c7355283843178d9163@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 15:21:59 -0700
Message-ID: <CAADnVQJ2ixjZUY7hJJMM1iUBAYY2VxdL6v--Rg8wvKypfxBsGw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 8:18=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Mon, 31 Jul 2023 19:24:25 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Mon, Jul 31, 2023 at 6:15=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> > >
> > > On Mon, 31 Jul 2023 14:59:47 -0700
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > > Assuming that is addressed. How do we merge the series?
> > > > The first 3 patches have serious conflicts with bpf trees.
> > > >
> > > > Maybe send the first 3 with extra selftest for above recursion
> > > > targeting bpf-next then we can have a merge commit that Steven can =
pull
> > > > into tracing?
> > >
> > > Would it be possible to do this by basing it off of one of Linus's ta=
gs,
> > > and doing the merge and conflict resolution in your tree before it ge=
ts to
> > > Linus?
> > >
> > > That way we can pull in that clean branch without having to pull in
> > > anything else from BPF. I believe Linus prefers this over having trac=
ing
> > > having extra changes from BPF that are not yet in his tree. We only n=
eed
> > > these particular changes, we shouldn't be pulling in anything specifi=
c for
> > > BPF, as I believe that will cause issues on Linus's side.
> >
> > We can try, but I suspect git tricks won't do it.
> > Masami's changes depend on patches for kernel/bpf/btf.c that
> > are already in bpf-next, so git would have to follow all commits
> > that touch this file.
>
> This point is strange. I'm working on probe/fixes which is based on
> v6.5-rc3, so any bpf-next change should not be involved. Can you recheck
> this point?
>
> > I don't think git is smart enough to
> > thread the needle and split the commit into files. If one commit touche=
s
> > btf.c and something else that whole commit becomes a dependency
> > that pulls another commit with all files touched by
> > the previous commit and so on.
>
> As far as I understand Steve's method, we will have an intermediate branc=
h
> on bpf or probe tree, like
>
> linus(some common commit) ---- probes/btf-find-api
>
> and merge it to both bpf-next and probes/for-next branch
>
>           +----------------------bpf-next --- (merge bpf patches)
>          /                       / merge
> common -/\ probes/btf-find-api -/-\
>           \                        \ merge
>            +----------------------probes/for-next --- (merge probe patche=
s)
>
> Thus, we can merge both for-next branches at next merge window without
> any issue. (But, yes, this is not simple, and needs maxium care)

Sounds like the path of least resistance is to keep the changes
in kernel/trace and consolidate with kernel/bpf/btf.c after the next
merge window.

