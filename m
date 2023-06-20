Return-Path: <bpf+bounces-2959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7397377FA
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 01:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF162813CF
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60E18C04;
	Tue, 20 Jun 2023 23:40:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9E18B10
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 23:40:34 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626121710
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:40:32 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-57026f4bccaso57268517b3.2
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687304431; x=1689896431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wjbpbd+Lg05k3NFTF8umD5DXnTuonHmR7e7+P/pnUFw=;
        b=HjIJADVXRxGb9Cjcqa7J+5Ub5kBPj6K+oCFchTvmn8GoCZnGcevYvBjg3Gj23NgHhc
         VS1Wlm98V1rDg/Hmz+yrc9serHFEcylNRAht3oTxte0hSLpgKwZ/CkMzs2vGniJk1kEL
         lJTOaBbj/X0XnsNLF6NBPOSExmiTXQC5+bQGqZP/RWVL6jtkNC+8ftwgvGkqUhtYVpiA
         eySoQ0Cnm0gezaINtNNhZRzhbElWvy5n+AREzNQeKB+j8G2flp5vj35TtsLSZXXx+nXx
         PvvX78POmfvTREqQ1II0PZFUJxJmy1E8vvha+L1SXZ4Qo6KAu4Lhd5t4T+x8rriTGA/d
         J1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687304431; x=1689896431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wjbpbd+Lg05k3NFTF8umD5DXnTuonHmR7e7+P/pnUFw=;
        b=hxOJLNVN1lcTcy7ZJkNtDlvHucF55Z6K/PabFQWeyRpxVSGGyRpU9gD/6/F9FB+C2j
         RSea4zRvo+ltFq9oVabcT0IpYTcmpgQ2GLIbFnWjA+5ZGVYrAmbPcmPRuJXvD4TrAasZ
         Lm2HpyLQPs3CwANeFCISJM40YwmLM1jx9Q5iVTE69OC+AErJwjmCO5cd5lNFY7XFK0dW
         rnJKd3xJJtv5zphlXoYGZj2cc6QMW1Iv+zRtHFbULd+V2/Aq00EwyqUqNlZNBVJnc/zl
         7YM+5Lj1LIjgtAspBELB/m1SMjNqICyCYg7TPuwix6eGQAVZam+oBj1ytDmvMUl5joVC
         R9PA==
X-Gm-Message-State: AC+VfDwuFnO80BnHfvzYdx3efhngZXRmxZ9emveeF/w79Xsk9agK1V9R
	RlUmbr3WnLYzKeNVfZNbM6bpa+DaUljH6fO0Tpvc
X-Google-Smtp-Source: ACHHUZ7GFSij/9rTOMFvVXFNqglvqE4CqiCQ5d/8QmpTJYsSNqDFgFC7UXgwrCHPjMHdnAH5XeYa4UklDjtrpHy2TW4=
X-Received: by 2002:a25:ad56:0:b0:beb:39a9:2be6 with SMTP id
 l22-20020a25ad56000000b00beb39a92be6mr9430748ybe.51.1687304431513; Tue, 20
 Jun 2023 16:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230119231033.1307221-1-kpsingh@kernel.org> <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
 <63e525a8.170a0220.e8217.2fdb@mx.google.com> <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
 <CACYkzJ4w3BKNaogHdgW8AKmS2O+wJuVZSpCVVTCKj5j5PPK-Vg@mail.gmail.com>
In-Reply-To: <CACYkzJ4w3BKNaogHdgW8AKmS2O+wJuVZSpCVVTCKj5j5PPK-Vg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Jun 2023 19:40:20 -0400
Message-ID: <CAHC9VhSqGtZFXn-HW5pfUub4TmU7cqFWWKekL1M+Ko+f5qgi1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
To: KP Singh <kpsingh@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	jackmanb@google.com, renauld@google.com, casey@schaufler-ca.com, 
	song@kernel.org, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 6:03=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Fri, Feb 10, 2023 at 9:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Feb 9, 2023 at 11:56 AM Kees Cook <keescook@chromium.org> wrote=
:
> > > On Fri, Jan 27, 2023 at 03:16:38PM -0500, Paul Moore wrote:
> > > > On Thu, Jan 19, 2023 at 6:10 PM KP Singh <kpsingh@kernel.org> wrote=
:
> > > > >
> > > > > # Background
> > > > >
> > > > > LSM hooks (callbacks) are currently invoked as indirect function =
calls. These
> > > > > callbacks are registered into a linked list at boot time as the o=
rder of the
> > > > > LSMs can be configured on the kernel command line with the "lsm=
=3D" command line
> > > > > parameter.
> > > >
> > > > Thanks for sending this KP.  I had hoped to make a proper pass thro=
ugh
> > > > this patchset this week but I ended up getting stuck trying to wrap=
 my
> > > > head around some network segmentation offload issues and didn't qui=
te
> > > > make it here.  Rest assured it is still in my review queue.
> > > >
> > > > However, I did manage to take a quick look at the patches and one o=
f
> > > > the first things that jumped out at me is it *looks* like this
> > > > patchset is attempting two things: fix a problem where one LSM coul=
d
> > > > trample another (especially problematic with the BPF LSM due to its
> > > > nature), and reduce the overhead of making LSM calls.  I realize th=
at
> > > > in this patchset the fix and the optimization are heavily
> > > > intermingled, but I wonder what it would take to develop a standalo=
ne
> > > > fix using the existing indirect call approach?  I'm guessing that i=
s
> > > > going to potentially be a pretty significant patch, but if we could
> > > > add a little standardization to the LSM hooks without adding too mu=
ch
> > > > in the way of code complexity or execution overhead I think that mi=
ght
> > > > be a win independent of any changes to how we call the hooks.
> > > >
> > > > Of course this could be crazy too, but I'm the guy who has to ask
> > > > these questions :)
> > >
> > > Hm, I am expecting this patch series to _not_ change any semantics of
> > > the LSM "stack". I would agree: nothing should change in this series,=
 as
> > > it should be strictly a mechanical change from "iterate a list of
> > > indirect calls" to "make a series of direct calls". Perhaps I missed
> > > a logical change?
>
> There is no logical change in the 2nd patch that introduces static
> calls. There is however a logical change in the fourth patch (as you
> noticed) which allows some hooks to register themselves as disabled by
> default. This reduces the buggy side effects we have currently with
> BPF LSM.
>
> > I might be missing something too, but I'm thinking of patch 4/4 in
> > this series that starts with this sentence:
>
> Patch 4/4 is the semantic change but we do need that for both a
> performant BPF LSM and eliminating the side effects.
>
> >  "BPF LSM hooks have side-effects (even when a default value is
> >   returned), as some hooks end up behaving differently due to
> >   the very presence of the hook."
> >
> > Ignoring the static call changes for a moment, I'm curious what it
> > would look like to have a better mechanism for handling things like
> > this.  What would it look like if we expanded the individual LSM error
> > reporting back to the LSM layer to have a bit more information, e.g.
> > "this LSM erred, but it is safe to continue evaluating other LSMs" and
> > "this LSM erred, and it was too severe to continue evaluating other
>
> I tried proposing an idea in
> https://patchwork.kernel.org/project/netdevbpf/patch/20220609234601.20263=
62-1-kpsingh@kernel.org/
>  as an LSM_HOOK_NO_EFFECT but that did not seemed to have stuck.

It looks like this was posted about a month before I became
responsible for the LSM layer as a whole, and likely was lost (at
least on the LSM side of things) as a result.

I would much rather see a standalone fix to address the unintended LSM
interactions, then the static call performance improvements in a
separate patchset.

> > LSMs"?  Similarly, would we want to expand the hook registration to
> > have more info, e.g. "run this hook even when other LSMs have failed"
> > and "if other LSMs have failed, do not run this hook"?
> >
> > I realize that loading a BPF LSM is a privileged operation so we've
> > largely mitigated the risk there, but with stacking on it's way to
> > being more full featured, and IMA slowly working its way to proper LSM
> > status, it seems to me like having a richer, and proper way to handle
> > individual LSM failures would be a good thing.  I feel like patch 4/4
> > definitely hints at this, but I could be mistaken.

--=20
paul-moore.com

