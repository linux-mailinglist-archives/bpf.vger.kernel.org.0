Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34726597414
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbiHQQXF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 12:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbiHQQXD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 12:23:03 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9D49D675
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 09:23:01 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c185so15886644oia.7
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=UVFUNCqPRpisdlSVRU+tLvNHfgHjwvastlgvyU/I+ug=;
        b=nhD+LomYohgAaMtQcxIoxV4+vU0oMCpwBU85S4CbJpWNUKtrOHMu96fL8IGGB9i7cw
         FNxyZ6ErfmSrX8Yjx7DJa7BfR/bOMY7rG80bdYrOvc0TBQdWfsCyw5PjJYDICr6XKe+H
         JK3MHzzpfJoiBFlNfEtLwxaJnHksXBBcOFgkYQyoUf3mhDxovH/WHeOyApy39dRcRbIQ
         fcxTkUgqfab5tVzG1DNRoypYdqSxaxz4/7zjslkpqhcWYI3keTaRIl+SBo37PltiKNpL
         NAd4uWTOTjI1QLYBuCHvcDwPay7mfA0nxGkY2Qg9BvzND3mU7WGHhnkXAU1YWGsIIF6T
         KwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=UVFUNCqPRpisdlSVRU+tLvNHfgHjwvastlgvyU/I+ug=;
        b=KxiUp6IXz5V+A6AE5BWQMwqs6pe3YSbbRVSmW4mfu+g8F+yWDz3CwMsD+9lChEkr4z
         Bqesyuqo4JmobCr5fOOxOhXMliJp6Fz0MrRBhdfolacTlwMayuPgCIjFD8kesodoQNPO
         g5ZPdk6mjSRVKbiimNIEBIOGcYDN2dGeLJW+5I0YZkJpdNoHZL4d6NCRQ9D/dKCwCqkI
         eohcoWFaqvNK+iXhe9OpSyyK/ADNwuXgw27xvKGU++vp2WcA/If4HCX2JSEsvL0xLJfM
         NZySYYlYvxSqi8fVzHUeEop0dtlkbC73VPqLs+whxsE+VPUGID3eAq4OZlxd0OSRM40v
         JQrA==
X-Gm-Message-State: ACgBeo1mqQbzgSiWljgWjKL7N01+QP6b/rz8BTbH0hC3pDdi+R27F31y
        0l6atCk3K8BRerMbb361xoWr4mm2+7+69uKxXe/j
X-Google-Smtp-Source: AA6agR4q+35QdLDJNp6askIHnce/pTF3ccKGnAJyDAjR93UP09IwkfdsM9vuHIzqMk/HyB//otwciZ/io87A9c4W3cA=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr1872909oie.41.1660753380093; Wed, 17 Aug
 2022 09:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220725124123.12975-1-flaniel@linux.microsoft.com>
 <CAHC9VhTmgMfzc+QY8kr+BYQyd_5nEis0Y632w4S2_PGudTRT7g@mail.gmail.com>
 <4420381.LvFx2qVVIh@pwmachine> <CAHC9VhSMeefG5W_uuTNQYmUUZ1xcuqArxYs5sL9KOzUO_skCZw@mail.gmail.com>
 <ab1bbd48-c48d-5f5a-f090-428ffd54c07e@schaufler-ca.com> <CAHC9VhTxYaLXFbS6JnpskOkADNbL8BA5614VuK3sDTHW6DE3uQ@mail.gmail.com>
 <20220817161924.GA20337@mail.hallyn.com>
In-Reply-To: <20220817161924.GA20337@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Aug 2022 12:22:49 -0400
Message-ID: <CAHC9VhTUid5i8C+W93Zfc_bWMoo7DsvruJ_85Ty0wWsV7xbb4g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] Add capabilities file to securityfs
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
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

On Wed, Aug 17, 2022 at 12:19 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> On Wed, Aug 17, 2022 at 12:10:25PM -0400, Paul Moore wrote:
> > On Wed, Aug 17, 2022 at 11:50 AM Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
> > > On 8/17/2022 7:52 AM, Paul Moore wrote:
> > > > On Wed, Aug 17, 2022 at 7:53 AM Francis Laniel
> > > > <flaniel@linux.microsoft.com> wrote:
> > > >> Le mardi 16 ao=C3=BBt 2022, 23:59:41 CEST Paul Moore a =C3=A9crit =
:
> > > >>> On Mon, Jul 25, 2022 at 8:42 AM Francis Laniel
> > > >>>
> > > >>> <flaniel@linux.microsoft.com> wrote:
> > > >>>> Hi.
> > > >>>>
> > > >>>> First, I hope you are fine and the same for your relatives.
> > > >>> Hi Francis :)
> > > >>>
> > > >>>> A solution to this problem could be to add a way for the userspa=
ce to ask
> > > >>>> the kernel about the capabilities it offers.
> > > >>>> So, in this series, I added a new file to securityfs:
> > > >>>> /sys/kernel/security/capabilities.
> > > >>>> The goal of this file is to be used by "container world" softwar=
e to know
> > > >>>> kernel capabilities at run time instead of compile time.
> > > >>> ...
> > > >>>
> > > >>>> The kernel already exposes the last capability number under:
> > > >>>> /proc/sys/kernel/cap_last_cap
> > > >>> I'm not clear on why this patchset is needed, why can't the
> > > >>> application simply read from "cap_last_cap" to determine what
> > > >>> capabilities the kernel supports?
> > > >> When you capabilities with, for example, docker, you will fill cap=
abilities
> > > >> like this:
> > > >> docker run --rm --cap-add SYS_ADMIN debian:latest echo foo
> > > >> As a consequence, the "echo foo" will be run with CAP_SYS_ADMIN se=
t.
> > > >>
> > > >> Sadly, each time a new capability is added to the kernel, it means=
 "container
> > > >> stack" software should add a new string corresponding to the numbe=
r of the
> > > >> capabilities [1].
> > > > Thanks for clarifying things, I thought you were more concerned abo=
ut
> > > > detecting what capabilities the running kernel supported, I didn't
> > > > realize it was getting a string literal for each supported capabili=
ty.
> > > > Unless there is a significant show of support for this
> > >
> > > I believe this could be a significant help in encouraging the use of
> > > capabilities. An application that has to know the list of capabilitie=
s
> > > at compile time but is expected to run unmodified for decades isn't
> > > going to be satisfied with cap_last_cap. The best it can do with that
> > > is abort, not being able to ask an admin what to do in the presence o=
f
> > > a capability that wasn't around before because the name isn't known.
> >
> > An application isn't going to be able to deduce the semantic value of
> > a capability based solely on a string value, an integer is just as
> > meaningful in that regard.  What might be useful is if the application
>
> Maybe it's important to point out that an integer value capability in
> kernel will NEVER change its string value (or semantic meaning).
>
> The libcap tools like capsh accept integer capabilities, other tools
> probably should as well.  (see man 3 cap_from_text)

Seems like a reasonable thing to me, I would much prefer that than the
approach in this patchset.

--=20
paul-moore.com
