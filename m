Return-Path: <bpf+bounces-2144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105217288F7
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 21:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660A41C21054
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CE52D245;
	Thu,  8 Jun 2023 19:46:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9ED294D4
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 19:46:30 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A663F30C3
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 12:46:17 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-565bdae581eso8834547b3.2
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1686253577; x=1688845577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp7JcGm3NEkfhNcSWqAKhc2vwDiRILzaHvhFpJi9A54=;
        b=vYmbq0jllbD1LTy7mRPYtKTiEXtarRokxew2CRMVQt85Nwn5omnLuIBQI4NFXg2iFY
         6fDbGPJuXsYXXcW8UxH7yHSaNrxjqqNitvRrEMS/D1RFnRYjF8XJtc8aqc3v4Rd726p5
         NCUf73FALxwZkUpRzOSnCRfPw3Mwxvi7f2IGrDtvfc8NqOsvIKJ9cNMBmcPhc067uZ5T
         ua5Y/AHjkYapHU7VDr89y270UnYCttrwelbNP2EGYUDvXIDcz8x/9Kn6AOAuMh9/b6e3
         GXKuKXx3S3YfebZZs5VGcrhA+WjDFtedZ/XSFSIGWWGCgTMs6aVHndL5ndPUz3lxHPp7
         e65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253577; x=1688845577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dp7JcGm3NEkfhNcSWqAKhc2vwDiRILzaHvhFpJi9A54=;
        b=kadq5ZWbwwCT0HSIxd3Af0p4JpacTm+GeqebAF+0LtWJ55m+En5GsYcLCSZ3xvMMvp
         iGMqpVNnFUhYlxtvH+BOahQV8CxWJ/Ox6mc8we05BIXI5KlGqVt34eUva+Iq/zBjsJub
         rc1WbiMrn1VrRn3cz0ilEcUNiyyyxz6ZO0O1Y5kz/Jw2NZ2v3RUdtUjYxA4OhkMiB4rp
         8/7Jj8Zpi8s8DE8YblRMTFpa9fQ2szsJH3fco4PnbaDoWYgdOKgo3HF9o11pQgwB+/rH
         riE0V/4wCwxcQrAF63+Y7YhDsio9ITPJT465l0uIzeiAJ20xnDwp9UlJFSvpIh/PpquY
         09SA==
X-Gm-Message-State: AC+VfDxgkdQA10ZVtdV2jdEvQovT/yF/zJQ8qBH1iZZWuyUglWmsCZeo
	3aNp8ijjBSgHYwHZ1vui3m56JZDSTNskNCNGoyWq1Q==
X-Google-Smtp-Source: ACHHUZ54MFEdKvMDz1U/Lj0UmPuzsjFKoC9Q4LqTwz1dt6V7gqbnnFRFjhiDmTAUULFPjxjHrktz1QJu4Ny747v5I1E=
X-Received: by 2002:a81:4f17:0:b0:561:8418:6932 with SMTP id
 d23-20020a814f17000000b0056184186932mr643553ywb.47.1686253576897; Thu, 08 Jun
 2023 12:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607192625.22641-1-daniel@iogearbox.net> <20230607192625.22641-3-daniel@iogearbox.net>
 <CAM0EoMm25tdjxp+7Mq4fowGfCJzFRhbThHhaO7T_46vNJ9y-NQ@mail.gmail.com> <fe2e13a6-1fb6-c160-1d6f-31c09264911b@iogearbox.net>
In-Reply-To: <fe2e13a6-1fb6-c160-1d6f-31c09264911b@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 8 Jun 2023 15:46:05 -0400
Message-ID: <CAM0EoM=FFsTNNKaMbRtuRxc8ieJgDFsBifBmZZ2_67u5=+-3BQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Add fd-based tcx multi-prog infra
 with link support
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, 
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Daniel,

On Thu, Jun 8, 2023 at 6:12=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> Hi Jamal,
>
> On 6/8/23 3:25 AM, Jamal Hadi Salim wrote:
> [...]
> > A general question (which i think i asked last time as well): who
> > decides what comes after/before what prog in this setup? And would
> > that same entity not have been able to make the same decision using tc
> > priorities?
>
> Back in the first version of the series I initially coded up this option
> that the tc_run() would basically be a fake 'bpf_prog' and it would have,
> say, fixed prio 1000. It would get executed via tcx_run() when iterating
> via bpf_mprog_foreach_prog() where bpf_prog_run() is called, and then use=
rs
> could pick for native BPF prio before or after that. But then the feedbac=
k
> was that sticking to prio is a bad user experience which led to the
> development of what is in patch 1 of this series (see the details there).
>

Thanks. I read the commit message in patch 1 and followed the thread
back including some of the discussion we had and i am still
disagreeing that this couldnt be solved with a smart priority based
scheme - but i think we can move on since this is standalone and
doesnt affect tc.

Daniel - i am still curious in the new scheme of things how would
cilium vs datadog food fight get resolved without some arbitration
entity?

> > The idea of protecting programs from being unloaded is very welcome
> > but feels would have made sense to be a separate patchset (we have
> > good need for it). Would it be possible to use that feature in tc and
> > xdp?
> BPF links are supported for XDP today, just tc BPF is one of the few
> remainders where it is not the case, hence the work of this series. What
> XDP lacks today however is multi-prog support. With the bpf_mprog concept
> that could be addressed with that common/uniform api (and Andrii expresse=
d
> interest in integrating this also for cgroup progs), so yes, various hook
> points/program types could benefit from it.

Is there some sample XDP related i could look at?  Let me describe our
use case: lets say we load an ebpf program foo attached to XDP of a
netdev  and then something further upstream in the stack is consuming
the results of that ebpf XDP program. For some reason someone, at some
point, decides to replace the XDP prog with a different one - and the
new prog does a very different thing. Could we stop the replacement
with the link mechanism you describe? i.e the program is still loaded
but is no longer attached to the netdev.


> >> +struct tcx_entry {
> >> +       struct bpf_mprog_bundle         bundle;
> >> +       struct mini_Qdisc __rcu         *miniq;
> >> +};
> >> +
> >
> > Can you please move miniq to the front? From where i sit this looks:
> > struct tcx_entry {
> >          struct bpf_mprog_bundle    bundle
> > __attribute__((__aligned__(64))); /*     0  3264 */
> >
> >          /* XXX last struct has 36 bytes of padding */
> >
> >          /* --- cacheline 51 boundary (3264 bytes) --- */
> >          struct mini_Qdisc *        miniq;                /*  3264     =
8 */
> >
> >          /* size: 3328, cachelines: 52, members: 2 */
> >          /* padding: 56 */
> >          /* paddings: 1, sum paddings: 36 */
> >          /* forced alignments: 1 */
> > } __attribute__((__aligned__(64)));
> >
> > That is a _lot_ of cachelines - at the expense of the status quo
> > clsact/ingress qdiscs which access miniq.
>
> Ah yes, I'll fix this up.

Thanks.

cheers,
jamal
> Thanks,
> Daniel

