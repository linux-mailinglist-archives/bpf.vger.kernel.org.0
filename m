Return-Path: <bpf+bounces-2674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3E573201F
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A973128158A
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 18:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8B0EAD9;
	Thu, 15 Jun 2023 18:36:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B82E0F5
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 18:36:02 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAA8E4D
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 11:36:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f81b83b8d5so14965e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686854159; x=1689446159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/omKCOwcp2EQQ6DXjBeRhC2FJTA991mg7uA9FudSf/A=;
        b=7WdakyK4oshrb7I5mdAEawHE0gqSwfLUnysc+u81KTB9OE/I+XGjBLzBBp3ij1Rroi
         p+5EBevPxH87tpo3p3ieW1oj0qbl3XssFNbWV8YRR1BVb1DePQYjtvaKoPZXBGi/AwCV
         ykyKgG90f8VITucN+MA3Hre7wb28C1mpX2VXgUjdWwKmK4RsaEBv7adwXOV4dOUDZjNQ
         g7XDBzFN9y+PwMvzc35xpRyystMw8iseLKE9SuXRwRhPgM+LTT2jq/oTyyz8f6P0mJiS
         euovvm+o/bp6aOraSWwOXY4j20rWBPjWLMdzrVgGv2LUVLQylboa8sPwWcZr5/ktJiXg
         dhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686854159; x=1689446159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/omKCOwcp2EQQ6DXjBeRhC2FJTA991mg7uA9FudSf/A=;
        b=As7AnCRdiRTSVnx98t30ftGlisqc2CsWUY6o6v8MuGV42kJ3w5OZG3lWSex/cwzZZo
         5qGdnmjbuigJaUra5XUmJRwOrDHDp/AjQV2dnmPXSfnrtMKRC1R6/FRzVNEMPoNYvuwj
         hZzxnL5b7cGRsnGJNd6Z7CTC/GBRxAatAr6Hi7K7cI/dhoH9E463hAkg7uEg4opgmDrS
         mEANFTTx+/n4zwOJPAc4ercqtEP0gLQiOJkUYCaTCc9p2bMkqco581NRsxOqoZqftMSQ
         WZqakBM0qP5uVOqEymCT2f4BShhHF+xKNFwzqAvlRXjt0ic9oBF2bMbJV4HFdrYLQRdd
         tV1A==
X-Gm-Message-State: AC+VfDwp4FKva3qJkTHAmLzkECaCjgT+TOeaPcVS3ZjdapR18fdXPCRn
	pstX8r1NKkTo6u06R9szRgsAgsRdGeXuGTuYrVwh
X-Google-Smtp-Source: ACHHUZ79usijn1wldJc0UmWEzOBq8i+jS57yOqXyNMWUbtJum/djNxOiWYDRtdkAS1PE7qMfthc7LVkEy7WkdFS9y7M=
X-Received: by 2002:a05:600c:4e52:b0:3f7:e4d8:2569 with SMTP id
 e18-20020a05600c4e5200b003f7e4d82569mr224049wmq.5.1686854159080; Thu, 15 Jun
 2023 11:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJc0_fwx6MQa+Uozk+PJB0qb3JP5=9_WcCjOb8qa34u=DVbDmQ@mail.gmail.com>
 <2023061453-guacamole-porous-8a0e@gregkh> <CAADnVQLuHTNPEuXpSUgkNHoK1-X8KxU=spdYWB2bMp6icS+j0g@mail.gmail.com>
In-Reply-To: <CAADnVQLuHTNPEuXpSUgkNHoK1-X8KxU=spdYWB2bMp6icS+j0g@mail.gmail.com>
From: Robert Kolchmeyer <rkolchmeyer@google.com>
Date: Thu, 15 Jun 2023 11:35:46 -0700
Message-ID: <CAJc0_fwKZS2=9DfaNSNF7-UBsXTEaopNFXdK3i57KcxUm5rOvA@mail.gmail.com>
Subject: Re: BPF regression in 5.10.168 and 5.15.93 impacting Cilium
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>, 
	regressions@lists.linux.dev, Martin KaFai Lau <kafai@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Sasha Levin <sashal@kernel.org>, Paul Chaignon <paul@isovalent.com>, 
	Meena Shanmugam <meenashanmugam@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 14, 2023 at 2:48=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 14, 2023 at 1:57=E2=80=AFPM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Wed, Jun 14, 2023 at 11:23:52AM -0700, Robert Kolchmeyer wrote:
> > > Hi all,
> > >
> > > I believe 5.10.168 and 5.15.93 introduced a regression that impacts
> > > the Cilium project. Some information on the nature of the regression
> > > is available at https://github.com/cilium/cilium/issues/25500. The
> > > primary symptom seems to be the error `BPF program is too large.`
> > >
> > > My colleague has found that reverting the following two commits:
> > >
> > > 8de8c4a "bpf: Support <8-byte scalar spill and refill"
> > > 9ff2beb "bpf: Fix incorrect state pruning for <8B spill/fill"
> > >
> > > resolves the regression.
> > >
> > > If we revert these in the stable tree, there may be a few changes tha=
t
> > > depend on those that also need to be reverted, but I'm not sure yet.
> > >
> > > Would it make sense to revert these changes (and any dependent ones)
> > > in the 5.10 and 5.15 trees? If anyone has other ideas, I can help tes=
t
> > > possible solutions.
> >
> > Can you actually test if those reverts work properly for you and if
> > there are other dependencies involved?
> >
> > And is this issue also in 6.1.y and Linus's tree?  If not, why not, are
> > we just missing a commit?  We can't revert something from a stable
> > release if you are going to hit the same issue when moving to a new
> > release, right?
> >
> > thanks,
> >
> > greg k-h
>
> Before jumping to reverts..
> how is it fixed in 6.0+ kernels?
>
> "BPF program is too large" can probably be worked around on the cilium si=
de.
> The kernel cannot guarantee that a particular program will
> always be verifiable. We find safety bugs in the verifier and often
> enough the fixes to such issues make the verifier work harder to prove
> the safety of the program.
> This is one of such cases. These two commits are necessary.
> Reverting them will prevent loading of valid programs.
> So reverts is a dangerous path.
> The best is to identify the other patches from 6.0+ and backport them.
> The second best path is to bump 1M limit to something higher to
> mitigate "more work by the verifier".

Thanks all for the pointers, this is super helpful.

I'm working on getting more details, and I'll post here when I have them.

-Robert

