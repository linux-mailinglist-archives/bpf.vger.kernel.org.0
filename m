Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A338F55E64A
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbiF1PNe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 11:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348024AbiF1PNV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 11:13:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB552253D
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 08:13:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o16so18197367wra.4
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkzH7QSCl1imbm0hTXo9/+3Qp+0BlsSEHJNs0Hc1eaw=;
        b=aD8bxTii7KraGvmGddDVz/h1eUvPQScBefVu6lWh/XtQN+Th6l5JP38j8mh5PCWdmv
         ivZ+GOyT4NUp1vLuyf+936OpdtcUm93bHpPi/NuCfFfm9Ht/LcTtKHv5Q5Yhmrn9dtI1
         DbqUWvbHd1kOs0y+XGs08N7elWB5WONLt3db+86TV1L3ttSyMEATkEOGkfE/9ammqFfM
         YlIZ37RjNf7L/JuCA45BZCscPEPc4su/4Vkz3qWt+jDTW8HagxPkpNB/jjKDzQyESgYb
         gkCorOJB2nwBj2fHqE0wlStR2mdVfAcAbwZML5gfsfYZSV0vXSjyiF7jzoJyJyQFSRlu
         6hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkzH7QSCl1imbm0hTXo9/+3Qp+0BlsSEHJNs0Hc1eaw=;
        b=tCJnjvFnZ/s1tnwkTo9W/Shw5fKMWBkRZ2nkU6JPzcRn/PE2vGzt/xUeCqxzUlnR+V
         hLGBuW07sXwA3wkbNvPfOoPsGKc6RaEcltAU43ckhYq/IIxtnOBV0rHgR8g5BxwmtJMb
         64T31oIXqwbXHalG+aay/os0lOs9MZV6eHxihkhMTo0RYC1/h6P4pe0sDwFXEfdaaLkk
         8A3Kna6qxV17sEhP7nrKy+B8KL2qunYmLa7Pi13IkqdSf5A0cwTEQYYGuAlHoscbZT5K
         yBE7e7C1ckxiwJpJsZxkpwyYSSyim4/WznaukI8ckrI9d5U0tDuTXuczw5klj2xPM/lm
         UOCQ==
X-Gm-Message-State: AJIora+8bSjAPk5ZPpAbk8svknt65+fxuHgRi7uuoohEHQQUX1eRK5kN
        8pZHB7s1EP9oZ6irGqhAkcB2QB1MqtWosN9FMLpu
X-Google-Smtp-Source: AGRyM1vp6HPEs7LYgA+U4o/zLZn/dgwEAiM3ePTIIoIGPpD3KEz9mvb0hdQMQ2/H0zdCteQ98+iTThAoyekKrRRSjYE=
X-Received: by 2002:adf:f186:0:b0:21b:960b:8f9 with SMTP id
 h6-20020adff186000000b0021b960b08f9mr19216576wro.70.1656429197096; Tue, 28
 Jun 2022 08:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220621233939.993579-1-fred@cloudflare.com> <ce1653b1-feb0-1a99-0e97-8dfb289eeb79@schaufler-ca.com>
 <b72c889a-4a50-3330-baae-3bbf065e7187@cloudflare.com> <CAHC9VhSTkEMT90Tk+=iTyp3npWEm+3imrkFVX2qb=XsOPp9F=A@mail.gmail.com>
 <20220627121137.cnmctlxxtcgzwrws@wittgenstein> <CAHC9VhSQH9tE-NgU6Q-GLqSy7R6FVjSbp4Tc4gVTbjZCqAWy5Q@mail.gmail.com>
 <6a8fba0a-c9c9-61ba-793a-c2e0c2924f88@iogearbox.net> <edc5164b-8e02-2588-1c5b-d917049f666a@cloudflare.com>
In-Reply-To: <edc5164b-8e02-2588-1c5b-d917049f666a@cloudflare.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Jun 2022 11:13:05 -0400
Message-ID: <CAHC9VhQq4smKbQdLJzb_yGQ2VfPWJ6wK8onUh_Np0uU7zAa3rQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Introduce security_create_user_ns()
To:     Frederick Lawler <fred@cloudflare.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 28, 2022 at 11:11 AM Frederick Lawler <fred@cloudflare.com> wrote:
> On 6/27/22 5:15 PM, Daniel Borkmann wrote:
> > On 6/27/22 11:56 PM, Paul Moore wrote:
> >> On Mon, Jun 27, 2022 at 8:11 AM Christian Brauner <brauner@kernel.org>
> >> wrote:
> >>> On Thu, Jun 23, 2022 at 11:21:37PM -0400, Paul Moore wrote:
> >>
> >> ...
> >>
> >>>> This is one of the reasons why I usually like to see at least one LSM
> >>>> implementation to go along with every new/modified hook.  The
> >>>> implementation forces you to think about what information is necessary
> >>>> to perform a basic access control decision; sometimes it isn't always
> >>>> obvious until you have to write the access control :)
> >>>
> >>> I spoke to Frederick at length during LSS and as I've been given to
> >>> understand there's a eBPF program that would immediately use this new
> >>> hook. Now I don't want to get into the whole "Is the eBPF LSM hook
> >>> infrastructure an LSM" but I think we can let this count as a legitimate
> >>> first user of this hook/code.
> >>
> >> Yes, for the most part I don't really worry about the "is a BPF LSM a
> >> LSM?" question, it's generally not important for most discussions.
> >> However, there is an issue unique to the BPF LSMs which I think is
> >> relevant here: there is no hook implementation code living under
> >> security/.  While I talked about a hook implementation being helpful
> >> to verify the hook prototype, it is also helpful in providing an
> >> in-tree example for other LSMs; unfortunately we don't get that same
> >> example value when the initial hook implementation is a BPF LSM.
> >
> > I would argue that such a patch series must come together with a BPF
> > selftest which then i) contains an in-tree usage example, ii) adds BPF
> > CI test coverage. Shipping with a BPF selftest at least would be the
> > usual expectation.
>
> Sounds good. I'll add both a eBPF selftest and SELinux implementation
> for v2.

Thanks Daniel!

-- 
paul-moore.com
