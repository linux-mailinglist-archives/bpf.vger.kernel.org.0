Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241D75971F8
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiHQOwr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbiHQOwr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 10:52:47 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89A091D2B
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 07:52:45 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2a4c51c45so15397628fac.9
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=p6elRDyP8NYnM4v7agKH/wBfu4apiNL55+e+soKTTbc=;
        b=5EuNmx6MxrW8SWGqqbCOqzQ+s8Te51T3R6xgbA89Sk211auzMweoYrkEzMxjTE222U
         6ajGCVZpwYoATV1wudJViEWYzHdMWE8hUymF6A4XgcUut55VxyH8THN525b59Ojd7Ztx
         YU+CVtzxve+a5I1GgsWNYnyT1oNDagT7mlXZ9R6nnZeAGKKjXnfRsVUK4PBaSC71+tNX
         umoDlvWCN6b+g0o5fhq9JbSNm22rqjIfhohpDpUGJAdGySjc8SFqxKoevcEfRIkUrP3f
         +D9Flane7vSbSlWpkP8LIEc1QAsQGoaS5RHdk8l+M97CO/LUjpNHZfVyR2Ej6JHu0Mxz
         Ei3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=p6elRDyP8NYnM4v7agKH/wBfu4apiNL55+e+soKTTbc=;
        b=Wh1WiTokYDEtVuUCYvDNoJtyI63h9uooE7WZAMl++7wc+0Qim91nEuz/yQ0RDTuce7
         j6jiTSn7ROVqwNkIxHLGU0np4oMA2hv3KQZw790NlK25xgQEttiROXZWHxVgYYPWnv60
         kuFhaB98KTD04pHTWInxKP6BwkiFBfVih19nseGikmk4+4L5ZoqDYrQWv8iN/esV11mN
         mUX7eDHcfRpgIwUJzKHQnzfvL/BCCr7TPIrbG6eQc2SEo5X4cNnO2it55Cd9IgPZ5UXQ
         FD2Sj8PzV0TSZ631tHleItt5iXc4LcnKw8Cto61MhEHl4p6PUdHXwfGpCrYgPZp2I/U1
         fg4Q==
X-Gm-Message-State: ACgBeo2sw1AEbKgZ2iJB2fU3YS2BoX620hf3E6HVMpnZ+Z8A93Sb0eRV
        CpRRLxEaSqLQl1PLnU4bazUITGuZqA3bx0vaU7BTa1t7xA==
X-Google-Smtp-Source: AA6agR6jYL1Jhtyl77hp193lRTLCWuiKZuNGi023Wb2umOc1iVGeV0Q1gFXBlEJPHu1RAENEGyZZMACGud4kfjvweVc=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr1902929oao.41.1660747965093; Wed, 17 Aug
 2022 07:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220725124123.12975-1-flaniel@linux.microsoft.com>
 <CAHC9VhTmgMfzc+QY8kr+BYQyd_5nEis0Y632w4S2_PGudTRT7g@mail.gmail.com> <4420381.LvFx2qVVIh@pwmachine>
In-Reply-To: <4420381.LvFx2qVVIh@pwmachine>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Aug 2022 10:52:34 -0400
Message-ID: <CAHC9VhSMeefG5W_uuTNQYmUUZ1xcuqArxYs5sL9KOzUO_skCZw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] Add capabilities file to securityfs
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF [MISC]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 7:53 AM Francis Laniel
<flaniel@linux.microsoft.com> wrote:
> Le mardi 16 ao=C3=BBt 2022, 23:59:41 CEST Paul Moore a =C3=A9crit :
> > On Mon, Jul 25, 2022 at 8:42 AM Francis Laniel
> >
> > <flaniel@linux.microsoft.com> wrote:
> > > Hi.
> > >
> > > First, I hope you are fine and the same for your relatives.
> >
> > Hi Francis :)
> >
> > > A solution to this problem could be to add a way for the userspace to=
 ask
> > > the kernel about the capabilities it offers.
> > > So, in this series, I added a new file to securityfs:
> > > /sys/kernel/security/capabilities.
> > > The goal of this file is to be used by "container world" software to =
know
> > > kernel capabilities at run time instead of compile time.
> >
> > ...
> >
> > > The kernel already exposes the last capability number under:
> > > /proc/sys/kernel/cap_last_cap
> >
> > I'm not clear on why this patchset is needed, why can't the
> > application simply read from "cap_last_cap" to determine what
> > capabilities the kernel supports?
>
> When you capabilities with, for example, docker, you will fill capabiliti=
es
> like this:
> docker run --rm --cap-add SYS_ADMIN debian:latest echo foo
> As a consequence, the "echo foo" will be run with CAP_SYS_ADMIN set.
>
> Sadly, each time a new capability is added to the kernel, it means "conta=
iner
> stack" software should add a new string corresponding to the number of th=
e
> capabilities [1].

Thanks for clarifying things, I thought you were more concerned about
detecting what capabilities the running kernel supported, I didn't
realize it was getting a string literal for each supported capability.
Unless there is a significant show of support for this - and I'm
guessing there isn't due to the lack of comments - I don't think this
is something we want to add to the kernel, especially since the kernel
doesn't really care about the capabilities' names, it's the number
that matters.

--=20
paul-moore.com
