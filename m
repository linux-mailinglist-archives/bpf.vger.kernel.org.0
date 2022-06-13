Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB1549C2E
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 20:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbiFMSwl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbiFMSwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 14:52:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA50F3CA69
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:53:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f9so5480784plg.0
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2GbAzwYBGIAdGpmUitTP78WCtQDJfOSlirBrPIPUJV8=;
        b=m3ONiZU+Rou5uFM8Eo43NO6t1p7xohN4UsrO9zzqfd2t5DSYZF6aCyNo1PAEp4wGy4
         mGb30oww3a1gWPumw6dGcs+YAvtJSUSawhqQyB4TG+Gy0c8AmMEnVCl4g0gBqBTpFYHr
         hplz9lwGhl6cXOpvxYPhhEgk8QIhI6pLJ/vVDf+s7QNuXGSrPUm9CubDqvm1eaJ+n9pY
         aIKfqoNmGg66euRy4TPmYoGq044fdfvFQVAVvyJXRiG2S4+aS2w8Fq1mE+KKD5PJovGl
         2w5DZWherj/mZ1dVBZUeGojVIPIjXSsiBotJL8ltyJycwKBhruNHmOyPm+H0lA1wm/6c
         j31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GbAzwYBGIAdGpmUitTP78WCtQDJfOSlirBrPIPUJV8=;
        b=HKK0+xFi5eH6pL7tFW6YQAv7x54ZKtUX1tbPVT9vW+EvbqSYvlEz7GxFWTJucuGOqd
         IajCnKatieGJSlrpaf6dJ1qKOEYzsLJcEo+VgTq16W0tzzRzTFrSUHxdFHMg3vonz+We
         x9UdITywt4Av7U1I2YC58B2VFNqgxCIbdi/iCNMf9dBPDk+XFX0vOyvaS2xsE4Fl6eLE
         K0s/znNDwuMBkN1JsEI/GaMWvN1W0YV55IjEqMD3aGEDe1JKGG2IiSqy4iFYlmK0BYS9
         nMe9MKCHiKGhDCL0Jm04rfz/PcMYjV0z1+MdhR+H42Tmo6ISbYCykkdQps99HE/q91Vd
         emOw==
X-Gm-Message-State: AOAM533zNg7Zw78JDnT8oHhGydFhllByMrvOO1Phtely/dpZUk4pT9GX
        tLxdqxHcO+tM/F7KV0GJPX/vqAtiUwUL/rzSgu5s3g==
X-Google-Smtp-Source: ABdhPJwLvjhNA4wdh9PO/0kLpiWDSG4Sg8BkodLfb2uzxEvf+kazkBVqDJpJmcve/BAAaS7b4YKa91joEJt/KhvkX5U=
X-Received: by 2002:a17:90b:380b:b0:1e6:67f6:f70c with SMTP id
 mq11-20020a17090b380b00b001e667f6f70cmr16244566pjb.120.1655135635925; Mon, 13
 Jun 2022 08:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220610165803.2860154-1-sdf@google.com> <20220610165803.2860154-10-sdf@google.com>
 <a0ebf40e-6c21-435e-0d87-bca7a2113241@isovalent.com>
In-Reply-To: <a0ebf40e-6c21-435e-0d87-bca7a2113241@isovalent.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 13 Jun 2022 08:53:44 -0700
Message-ID: <CAKH8qBudovmLGuBiTBXXu_TZkev-mBbTtz1fqdsqsk61uMAWiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 09/10] bpftool: implement cgroup tree for BPF_LSM_CGROUP
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 13, 2022 at 5:08 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> 2022-06-10 09:58 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> > $ bpftool --nomount prog loadall $KDIR/tools/testing/selftests/bpf/lsm_cgroup.o /sys/fs/bpf/x
> > $ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_alloc
> > $ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_bind
> > $ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_clone
> > $ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_post_create
> > $ bpftool cgroup tree
> > CgroupPath
> > ID       AttachType      AttachFlags     Name
> > /sys/fs/cgroup
> > 6        lsm_cgroup                      socket_post_create bpf_lsm_socket_post_create
> > 8        lsm_cgroup                      socket_bind     bpf_lsm_socket_bind
> > 10       lsm_cgroup                      socket_alloc    bpf_lsm_sk_alloc_security
> > 11       lsm_cgroup                      socket_clone    bpf_lsm_inet_csk_clone
> >
> > $ bpftool cgroup detach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_post_create
> > $ bpftool cgroup tree
> > CgroupPath
> > ID       AttachType      AttachFlags     Name
> > /sys/fs/cgroup
> > 8        lsm_cgroup                      socket_bind     bpf_lsm_socket_bind
> > 10       lsm_cgroup                      socket_alloc    bpf_lsm_sk_alloc_security
> > 11       lsm_cgroup                      socket_clone    bpf_lsm_inet_csk_clone
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> The changes for bpftool look good to me, thanks!
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you for the review!

> > ---
> >  tools/bpf/bpftool/cgroup.c | 80 +++++++++++++++++++++++++++-----------
> >  1 file changed, 58 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> > index 42421fe47a58..6e55f583a62f 100644
> > --- a/tools/bpf/bpftool/cgroup.c
> > +++ b/tools/bpf/bpftool/cgroup.c
>
> > @@ -542,5 +577,6 @@ static const struct cmd cmds[] = {
> >
> >  int do_cgroup(int argc, char **argv)
> >  {
> > +     btf_vmlinux = libbpf_find_kernel_btf();
> >       return cmd_select(cmds, argc, argv, do_help);
> >  }
>
> This is not required for all "bpftool cgroup" operations (attach/detach
> don't need it I think), but should be inexpensive, right?

Good point, let's move it close to the place where we use it
regardless of whether it's expensive or not.
