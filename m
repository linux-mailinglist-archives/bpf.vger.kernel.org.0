Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E002E6E5534
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDQXbw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDQXbt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:31:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787D4C2B;
        Mon, 17 Apr 2023 16:31:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sz19so11489443ejc.2;
        Mon, 17 Apr 2023 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681774304; x=1684366304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ft+5r/C+PwA+Vml33qdh6xFVDPt651TyQEPH1l4swaE=;
        b=qjWLL3AegYPEkneS805gJXAPJ2pcW5BUC1hPzUCWwfDhqNL5+Hb3hineBcephwCS9n
         5ANStZmv5XvP6Czgdp89F92A8JIjUCk81zZ3J/jvek04jrj0ld9sAYmcvgL9GfUnfslV
         JG9zsN6qE+2h2i0YGDNT7Qre2kqCFZz3gi/h4hkYV9JxPStemX+6pf+1xqbc6PscMZaS
         NX3LrcGNx33kw/9gF9Xb62dOBeKME9N6TPVN7SX/B2LjhZvHpohdt8HwFAO+QTLGhIfu
         fEr8giH/d1dZhCdVed7Q6nezM1qreQ9b4osnKofQmhPPozCAgnHwb1OIwjw4j/WCIzJ4
         u5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681774304; x=1684366304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ft+5r/C+PwA+Vml33qdh6xFVDPt651TyQEPH1l4swaE=;
        b=RQjD2+oS/qMtvkJ1Errx7msctm7KOZGmi+nHYAAUd5+Si5OQyy6yZaMpUJjnBia69D
         N8tQyh5XHFLT2rKanSadZksh9D6A9zfBgxinJkGOeGrRHGswR/rr+WZImIyMwsFxmVI9
         uz0OfM5D7L243OfHLQ5F5VzTIoNDYR5vXmXs2Jfx9B0NYg+AZGMkq1iFvxIiTwgT3Smx
         ggHSzDEZxuA29lUroyGwXMm4A3iBXgd7NKDa35eMmOqQs0iXYuBvCIxfXfka2BXKEUBk
         yJ2+n9uewYufoBF1rKSQbr7I3h7Ty3Scvd6yw6b9IR7a68NJdEbxmgWsF9PfxY6jLbCG
         LMUg==
X-Gm-Message-State: AAQBX9ecvUbfIqv3ARHY6vVaio9BB0/dKKqbznUIcFUKi8IJzuTvdJoS
        EMlwMSBvv6z3OXg4SFxRDdsBO6fZgIK+yko/zNw=
X-Google-Smtp-Source: AKy350ZQ15Y3cAfuGrgC3jDIDPkO1EI8U1m/a8BcPyjlZLxvc4KEVmaM/XMqRG2cXOBDMMqR+6oagJClBh3T3skm84w=
X-Received: by 2002:a17:906:4488:b0:94a:8224:dbbc with SMTP id
 y8-20020a170906448800b0094a8224dbbcmr4448766ejo.5.1681774303878; Mon, 17 Apr
 2023 16:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <20230414202345.GA3971@wind.enjellic.com>
In-Reply-To: <20230414202345.GA3971@wind.enjellic.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 16:31:31 -0700
Message-ID: <CAEf4BzZQ8EYNe_oGDEoc0_a3k8C2CYe2F6scBD2Xj2MZ9TE7ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 14, 2023 at 1:24=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote:
>
> On Wed, Apr 12, 2023 at 10:47:13AM -0700, Kees Cook wrote:
>
> Hi, I hope the week is ending well for everyone.
>
> > On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > > On Wed, Apr 12, 2023 at 12:33???AM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> > > >
> > > > Add new LSM hooks, bpf_map_create_security and bpf_btf_load_securit=
y, which
> > > > are meant to allow highly-granular LSM-based control over the usage=
 of BPF
> > > > subsytem. Specifically, to control the creation of BPF maps and BTF=
 data
> > > > objects, which are fundamental building blocks of any modern BPF ap=
plication.
> > > >
> > > > These new hooks are able to override default kernel-side CAP_BPF-ba=
sed (and
> > > > sometimes CAP_NET_ADMIN-based) permission checks. It is now possibl=
e to
> > > > implement LSM policies that could granularly enforce more restricti=
ons on
> > > > a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> > > > capabilities), but also, importantly, allow to *bypass kernel-side
> > > > enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applicatio=
ns and use
> > > > cases.
> > >
> > > One of the hallmarks of the LSM has always been that it is
> > > non-authoritative: it cannot unilaterally grant access, it can only
> > > restrict what would have been otherwise permitted on a traditional
> > > Linux system.  Put another way, a LSM should not undermine the Linux
> > > discretionary access controls, e.g. capabilities.
> > >
> > > If there is a problem with the eBPF capability-based access controls,
> > > that problem needs to be addressed in how the core eBPF code
> > > implements its capability checks, not by modifying the LSM mechanism
> > > to bypass these checks.
>
> > I think semantics matter here. I wouldn't view this as _bypassing_
> > capability enforcement: it's just more fine-grained access control.
> >
> > For example, in many places we have things like:
> >
> >       if (!some_check(...) && !capable(...))
> >               return -EPERM;
> >
> > I would expect this is a similar logic. An operation can succeed if the
> > access control requirement is met. The mismatch we have through-out the
> > kernel is that capability checks aren't strictly done by LSM hooks. And
> > this series conceptually, I think, doesn't violate that -- it's changin=
g
> > the logic of the capability checks, not the LSM (i.e. there no LSM hook=
s
> > yet here).
> >
> > The reason CAP_BPF was created was because there was nothing else that
> > would be fine-grained enough at the time.
>
> This was one of the issues, among others, that the TSEM LSM we are
> working to upstream, was designed to address and may be an avenue
> forward.
>
> TSEM, being narratival rather than deontologically based, provides a
> framework for security permissions that are based on a
> characterization of the event itself.  So the permissions are as
> variable as the contents of whatever BPF related information is passed
> to the bpf* LSM hooks [1].
>
> Currently, the tsem_bpf_* hooks are generically modeled.  We would
> certainly entertain any discussion or suggestions as to what elements
> of the structures passed to the hooks would be useful with respect
> to establishing security policies useful and appropriate to the BPF
> community.

Could you please provide some links to get a bit more context and
information? I'd like to understand at least "narratival rather than
deontologically based" part of this.

>
> We don't want to get in the middle of the restrictive
> vs. authoritative debate, but it would seem that the jury is
> conclusively in on that issue and LSM hooks are not going to be
> allowed to dismiss, or modify, any other security controls.
>
> Hopefully the BPF ABI isn't tied to CAP_BPF as that would seem to make
> it problematic to make controls more granular.
>
> > Kees Cook
>
> Have a good weekend.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>
> [1]: Plus developers don't need to write security policies, you test
> your application in order to get the desired controls for a workload.
