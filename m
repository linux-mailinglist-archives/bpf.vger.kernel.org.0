Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8999E63F609
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 18:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiLAROX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 12:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiLAROW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 12:14:22 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0CBAC6F1
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 09:14:21 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y131so795732iof.9
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 09:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fxCmfBah9ZMYfRaa3VChKHviqburNhg5/RwvVPix2pc=;
        b=gU/Yux4O9DYTa2mEHOvL6QQ1GsOU9kvJDJpVRneXLc+UrZWEe9lmn7TrLhQQEKwssr
         5hk782/etlINnAftOyVnywjecVn9OLuRMzHBIfrcsIiIf5tLgFYKQrIgOYo6ksP+aqal
         cFqq1uvcrjlDSS6r0i8iwRHNhH+si8yhszvrOIvREBPmCRLiN/RIc+zDAZMbwQeEQUTm
         WSt88h777LdqwmpX0eJDNWCSd8lv169bUMnLPK4aa7lVqgiSp/hkHLKrtyUQXQ84w+DB
         Hyc9ErsEH9sf/xrk5wHwWY8hJ8sV7MByqgwEnfOMT4vLGcWTzukRMYBtfvb2SsLcCJxo
         FxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxCmfBah9ZMYfRaa3VChKHviqburNhg5/RwvVPix2pc=;
        b=KlfyF0pGaqxAAwxjxF2SvgYbJ+KItPSOZI2F3RtjmFEbtxM331geuEHoixDKfqf05y
         9OPp5JEHJsyHtLRk7RxSna18joIDqi+ZW3MxhgYuT4A59skKvnECslU7wtLCcjoHSW0q
         ANVUo2wcRgqo5POXdhilLuyhvD8chdYwbCXKMl2VbHoI2jbTmFUyhnWApK4BPVybDxWw
         yuqzKZiHUQIiNr005Ib/60GnKepbuhDKm5IIfSRbvkEqdsd+YGz+sw/9ocPeApsDYiLU
         KzsgoykSnj2A6M0M1PW1B2U8IqoBECgSSSdiXjKaEGsx1hk6Nf9WAiaCC8z7mva9bXjO
         6sXw==
X-Gm-Message-State: ANoB5pniNPX5WZSgMK8AcyLIs85e+vzVWt/yRDwcZfAYZ2nDUXYqcm/B
        VNk2hqJQbZsqe8npXPV3HFupOr23ZQzvOMSQCw5rpQ==
X-Google-Smtp-Source: AA0mqf7G1v4A40tgXr1NRHstLcTme21GLZJRJyVkeIBRJ8cOOHakVhk+7tqNHxac0XV9O/wu9t/1tPlmxunVkBo6PRs=
X-Received: by 2002:a02:ccb5:0:b0:375:bdb9:f1e4 with SMTP id
 t21-20020a02ccb5000000b00375bdb9f1e4mr23543554jap.67.1669914860723; Thu, 01
 Dec 2022 09:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20221121182552.2152891-1-sdf@google.com> <20221121182552.2152891-3-sdf@google.com>
 <Y4eRtJOPWBOCKe1Q@lincoln> <CAKH8qBtseOmsWmeprdRsvz0T=vAObYE_CpsYQOX0CsLR_iXNFA@mail.gmail.com>
 <CAKH8qBstSJEN5wvcPAcrnD0at8fNeyLNwijiT4wv=wD9eAd1TA@mail.gmail.com> <Y4ixjzpD9EoBgfGY@lincoln>
In-Reply-To: <Y4ixjzpD9EoBgfGY@lincoln>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 1 Dec 2022 09:14:04 -0800
Message-ID: <CAKH8qBuU5bjURwitY+GOO5SVF6+-FZ3panavveaLCJw__S587Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/8] bpf: XDP metadata RX kfuncs
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     toke@redhat.com, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 1, 2022 at 6:08 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
>
> On Wed, Nov 30, 2022 at 12:17:39PM -0800, Stanislav Fomichev wrote:
> > On Wed, Nov 30, 2022 at 11:06 AM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > On Wed, Nov 30, 2022 at 9:38 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> > > >
> > > > On Mon, Nov 21, 2022 at 10:25:46AM -0800, Stanislav Fomichev wrote:
> > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 9528a066cfa5..315876fa9d30 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -15171,6 +15171,25 @@ static int fixup_call_args(struct bpf_verifier_env *env)
> > > > >       return err;
> > > > >  }
> > > > >
> > > > > +static int fixup_xdp_kfunc_call(struct bpf_verifier_env *env, u32 func_id)
> > > > > +{
> > > > > +     struct bpf_prog_aux *aux = env->prog->aux;
> > > > > +     void *resolved = NULL;
> > > >
> > > > First I would like to say I really like the kfunc hints impementation.
> > > >
> > > > I am currently trying to test possible performace benefits of the unrolled
> > > > version in the ice driver. I was working on top of the RFC v2,
> > > > when I noticed a problem that also persists in this newer version.
> > > >
> > > > For debugging purposes, I have put the following logs in this place in code.
> > > >
> > > > printk(KERN_ERR "func_id=%u\n", func_id);
> > > > printk(KERN_ERR "XDP_METADATA_KFUNC_RX_TIMESTAMP_SUPPORTED=%u\n",
> > > >        xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP_SUPPORTED));
> > > > printk(KERN_ERR "XDP_METADATA_KFUNC_RX_TIMESTAMP=%u\n",
> > > >        xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP));
> > > > printk(KERN_ERR "XDP_METADATA_KFUNC_RX_HASH_SUPPORTED=%u\n",
> > > >        xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH_SUPPORTED));
> > > > printk(KERN_ERR "XDP_METADATA_KFUNC_RX_HASH=%u\n",
> > > >        xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH));
> > > >
> > > > Loading the program, which uses bpf_xdp_metadata_rx_timestamp_supported()
> > > > and bpf_xdp_metadata_rx_timestamp(), has resulted in such messages:
> > > >
> > > > [  412.611888] func_id=108131
> > > > [  412.611891] XDP_METADATA_KFUNC_RX_TIMESTAMP_SUPPORTED=108126
> > > > [  412.611892] XDP_METADATA_KFUNC_RX_TIMESTAMP=108128
> > > > [  412.611892] XDP_METADATA_KFUNC_RX_HASH_SUPPORTED=108130
> > > > [  412.611893] XDP_METADATA_KFUNC_RX_HASH=108131
> > > > [  412.611894] func_id=108130
> > > > [  412.611894] XDP_METADATA_KFUNC_RX_TIMESTAMP_SUPPORTED=108126
> > > > [  412.611895] XDP_METADATA_KFUNC_RX_TIMESTAMP=108128
> > > > [  412.611895] XDP_METADATA_KFUNC_RX_HASH_SUPPORTED=108130
> > > > [  412.611895] XDP_METADATA_KFUNC_RX_HASH=108131
> > > >
> > > > As you can see, I've got 108131 and 108130 IDs in program,
> > > > while 108126 and 108128 would be more reasonable.
> > > > It's hard to proceed with the implementation, when IDs cannot be sustainably
> > > > compared.
> > >
> > > Thanks for the report!
> > > Toke has reported a similar issue in [0], have you tried his patch?
> > > I've also tried to address it in v3 [1], could you retry on top of it?
> > > I'll try to insert your printk in my local build to see what happens
> > > with btf ids on my side. Will get back to you..
> > >
> > > 0: https://lore.kernel.org/bpf/87mt8e2a69.fsf@toke.dk/
> > > 1: https://lore.kernel.org/bpf/20221129193452.3448944-3-sdf@google.com/T/#u
> >
> > Nope, even if I go back to v2, I still can't reproduce locally.
> > Somehow in my setup they are sorted properly :-/
> > Would appreciate it if you can test the v3 patch and confirm whether
> > it's fixed on your side or not.
> >
>
> I've tested v3 and it looks like the isssue was resolved.
> Thanks a lot!

Great, thank you for verifying!

> > > > Furthermore, dumped vmlinux BTF shows the IDs is in the exactly reversed
> > > > order:
> > > >
> > > > [108126] FUNC 'bpf_xdp_metadata_rx_hash' type_id=108125 linkage=static
> > > > [108128] FUNC 'bpf_xdp_metadata_rx_hash_supported' type_id=108127 linkage=static
> > > > [108130] FUNC 'bpf_xdp_metadata_rx_timestamp' type_id=108129 linkage=static
> > > > [108131] FUNC 'bpf_xdp_metadata_rx_timestamp_supported' type_id=108127 linkage=static
> > > >
> > > > > +
> > > > > +     if (func_id == xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP_SUPPORTED))
> > > > > +             resolved = aux->xdp_netdev->netdev_ops->ndo_xdp_rx_timestamp_supported;
> > > > > +     else if (func_id == xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP))
> > > > > +             resolved = aux->xdp_netdev->netdev_ops->ndo_xdp_rx_timestamp;
> > > > > +     else if (func_id == xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH_SUPPORTED))
> > > > > +             resolved = aux->xdp_netdev->netdev_ops->ndo_xdp_rx_hash_supported;
> > > > > +     else if (func_id == xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
> > > > > +             resolved = aux->xdp_netdev->netdev_ops->ndo_xdp_rx_hash;
> > > > > +
> > > > > +     if (resolved)
> > > > > +             return BPF_CALL_IMM(resolved);
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > >
> > > > My working tree (based on this version) is available on github [0]. Situation
> > > > is also described in the last commit message.
> > > > I would be great, if you could check, whether this behaviour can be reproduced
> > > > on your setup.
> > > >
> > > > [0] https://github.com/walking-machine/linux/tree/hints-v2
