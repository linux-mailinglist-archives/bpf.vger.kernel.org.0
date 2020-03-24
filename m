Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662FE19135B
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCXOgo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 10:36:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38313 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgCXOgn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 10:36:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id t28so17204252ott.5;
        Tue, 24 Mar 2020 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+6SMs9HN8ojrvC2ckrrp6QggN8jhqny5rSNhL6g0zy0=;
        b=A7Sl4XsLguqmsw36gXsfa1E9F7sla5Tdk4vBaonLFEyk/m4f2iD20AgIq7UBBA0Ry6
         0BQymON2HkI6geWK93zhHtCTfG5xCHkPl+1XFVgsp4Z7M6xfHfcT0SnlUuMvzibLXujd
         pJFP4BGpsvC60cohMobtQChzlcMwwpTv1MFMmBkVEBYE6jinpXH4OQPhZJTk3iEALDHX
         xscregkJDHTd1uvQLyBGYtLgRJ6H89TyV6rbJvxzH0Nj1TNtzRMaSUtk5jGx5POVpqs1
         +BLX0F+cvVyyKibTP4K0UxVABhzagBfVsshvsyjff16VOM39jOuZe1KabiJzle0MCzyn
         KrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+6SMs9HN8ojrvC2ckrrp6QggN8jhqny5rSNhL6g0zy0=;
        b=Tl9/+iBw9EezC+8rZRtSkyGfLGO4ZPhqoXr5nFX6TPr/oSvaKxqTM5rWAPsIZFoF9o
         tSSUvhtLiiaAd83acF1iD1bR89WuHre4Qjv6ycwj04TMkzAxreXnFko0IDs+dHcmmyjH
         iVATsZ8ZwCWE26DxPcX17m4IPksWKpqJVevXNnXmrPLrtRaSMF331Yp3JbbeW5dVVmmf
         PR0PzivBJruCw0d3ubkLKrwpj4oltWbpBvhjQ2FDDM1TGb0Tq3cnU+QFaX4mT+4osLVa
         bNqWruD2NGUV/CBl2aoFIgtJVm9NmCogCmUeHDQECPbvqkodvAxZShuLtSURPqwvqZTT
         8HYg==
X-Gm-Message-State: ANhLgQ1OfK65wBjIOUWZlTXMjmEhW3454UgB6YWOWHHW8bV+SDEZwVQJ
        2u913V3cE4GxWH2Bop9q2pPeLNsYmr6qAhLeQd0=
X-Google-Smtp-Source: ADFU+vs6YOUeLgySzfbSk2Kmu7sfJbTsbskcXO/nR6vSLSbcJkpnvDFqtqM8N8JT83mJm/bKbecG49OJwWrlhlYP6SI=
X-Received: by 2002:a4a:6841:: with SMTP id a1mr2067234oof.18.1585060602808;
 Tue, 24 Mar 2020 07:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-6-kpsingh@chromium.org>
 <6d45de0d-c59d-4ca7-fcc5-3965a48b5997@schaufler-ca.com> <20200324015217.GA28487@chromium.org>
In-Reply-To: <20200324015217.GA28487@chromium.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 24 Mar 2020 10:37:51 -0400
Message-ID: <CAEjxPJ7LCZYDXN1rYMBA2rko0zbTp0UU0THx0bhsAnv0Eg4Ptg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
To:     KP Singh <kpsingh@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 23, 2020 at 9:52 PM KP Singh <kpsingh@chromium.org> wrote:
>
> On 23-M=C3=A4r 18:13, Casey Schaufler wrote:
> > On 3/23/2020 9:44 AM, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > The bpf_lsm_ nops are initialized into the LSM framework like any oth=
er
> > > LSM.  Some LSM hooks do not have 0 as their default return value. The
> > > __weak symbol for these hooks is overridden by a corresponding
> > > definition in security/bpf/hooks.c
> > >
> > > +   return 0;
>
> [...]
>
> > > +}
> > > +
> > > +DEFINE_LSM(bpf) =3D {
> > > +   .name =3D "bpf",
> > > +   .init =3D bpf_lsm_init,
> >
> > Have you given up on the "BPF must be last" requirement?
>
> Yes, we dropped it for as the BPF programs require CAP_SYS_ADMIN
> anwyays so the position ~shouldn't~ matter. (based on some of the
> discussions we had on the BPF_MODIFY_RETURN patches).
>
> However, This can be added later (in a separate patch) if really
> deemed necessary.

It matters for SELinux, as I previously explained.  A process that has
CAP_SYS_ADMIN is not assumed to be able to circumvent MAC policy.
And executing prior to SELinux allows the bpf program to access and
potentially leak to userspace information that wouldn't be visible to
the
process itself. However, I thought you were handling the order issue
by putting it last in the list of lsms?
