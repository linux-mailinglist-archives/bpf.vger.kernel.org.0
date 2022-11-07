Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF461FE4A
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 20:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiKGTLH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 14:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiKGTKf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 14:10:35 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC92AC6E
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 11:10:32 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id d123so9675063iof.7
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 11:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=erviGKB6Nsun5EKJl5hBJZE8ooBTgrJ8Z6T63fZPXFE=;
        b=OtmzjJocSoWm1bnb0oipEeshOIUhdJ9fEDPQG5L4EpoHjPJ2OH/TBMUxT3tNiNyWTx
         gzWhRw0FEC/oeEFpxo1mZCcjj/6hnGoWIu+1cOC3HVugZPi2HRdPMFREhFKXxrAQseDA
         V0ls84lUmbW9D/Z+sltLjjJhQwXojeI5SLJ80D3tPO+h9Zfjs4uu82yuFCNC8tPrM2uN
         YPzMunhjHZIUydHN6mit7B5gr/IgB+NWsDzaMZAehBpc7seLrKN/vSw47JGlQ3RILrMN
         fFqvzmR7hlzxZ8MQogSweWxoqBJNxgtqEkHVEOptJUObafaN+y48bhV8YdhnzADDyf0V
         aMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erviGKB6Nsun5EKJl5hBJZE8ooBTgrJ8Z6T63fZPXFE=;
        b=wuJv4cesnima4CmCblKQ6FiU5zQrSjOrMuj/LD1I3I5SLKVU9c0N+pN9V7hPsiWgft
         1tQhpUr9FuBsP7g9JK9DRWxLYkDNvv6+MtctfuMl+pu+eYXiz7yfB3L+jonChagsk8Q/
         l28N+auxSLTVHLPA3J5R6FKh7rNbFF43xnX4Cw6MvWHjFDBf3UaNX1Bs3dGqhTkKXiYO
         Z+VdAFza0Y8VphmUglui6lSb5U82W5iVXL072dMjnnwFh4pLormlEA0qNLXv/57+J9i8
         rysH83K5PS+r/dkOI35FolP2bhyxPOKqIwHDJSEXKZ3lvc+6XO4a+PvtgmtcRkDgFwkW
         JIYA==
X-Gm-Message-State: ACrzQf31wdBomdBoGePsAPkB0ywNvRHK0Ce2Y4E+0srheOpjvmIiNrN8
        t9cX/cQleslv6UWke/YDnH1OsXH/1+aWPcnDG15vWkNWCtQ=
X-Google-Smtp-Source: AMsMyM4KEg0au2uacpnbCzl9DFGJoedCy6eHgWKObP3R1ocX8JPUoPOMDdFXOgZlOgWnqzhpfzgbBz/JTDaMmA4Lg8o=
X-Received: by 2002:a02:cacf:0:b0:375:4038:62a0 with SMTP id
 f15-20020a02cacf000000b00375403862a0mr31256711jap.23.1667848232027; Mon, 07
 Nov 2022 11:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20221104032532.1615099-1-sdf@google.com> <20221104032532.1615099-11-sdf@google.com>
 <20221104143547.3575615-1-alexandr.lobakin@intel.com> <CAKH8qBuaJ1usZEirN9=ReugusS8t_=Mn0LoFdy93iOYpHs2+Yg@mail.gmail.com>
 <20221107171130.559191-1-alexandr.lobakin@intel.com>
In-Reply-To: <20221107171130.559191-1-alexandr.lobakin@intel.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 7 Nov 2022 11:10:21 -0800
Message-ID: <CAKH8qBuV_hCi5dxza8xDm8OXYZ7og=9LKuPqw18KGDCnQg9HQA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 10/14] ice: Support rx timestamp metadata for xdp
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
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

On Mon, Nov 7, 2022 at 9:33 AM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> From: Stanislav Fomichev <sdf@google.com>
> Date: Fri, 4 Nov 2022 11:21:47 -0700
>
> > On Fri, Nov 4, 2022 at 7:38 AM Alexander Lobakin
> > <alexandr.lobakin@intel.com> wrote:
> > >
> > > From: Stanislav Fomichev <sdf@google.com>
> > > Date: Thu,3 Nov 2022 20:25:28 -0700
>
> [...]
>
> > > Hey,
> > >
> > > FYI, our team wants to write a follow-up patch with ice support
> > > added, not like a draft, more of a mature code. I'm thinking of
> > > calling ice C function which would process Rx descriptors from
> > > that BPF code from the unrolling callback -- otherwise,
> > > implementing a couple hundred C code lines from ice_txrx_lib.c
> > > would be a bit too much :D
> >
> > Sounds good! I would gladly drop all/most of the driver changes for
> > the non-rfc posting :-)
> > I'll probably have a mlx4 one because there is a chance I might find
> > HW, but the rest I'll drop most likely.
> > (they are here to show how the driver changes might look like, hence
> > compile-tested only)
> >
> > Btw, does it make sense to have some small xsk selftest binary that
> > can be used to test the metadata with the real device?
> > The one I'm having right now depends on veth/namespaces; having a
> > similar one for the real hardware to qualify it sounds useful?
> > Something simple that sets up af_xdp for all queues, divers some
> > traffic, and exposes to the userspace consumer all the info about
> > frame metadata...
> > Or maybe there is something I can reuse already?
>
> There's XSk selftest already and recently Maciej added support for
> executing it on a physical device (via `-i <iface>` cmdline arg)[0].
> I guess the most optimal solution is to expand it to cover metadata
> cases as it has some sort of useful helper functions / infra? In the
> set I posted in June, I simply expanded xdp_meta selftest, but there
> weren't any XSk bits, so I don't think it's a way to go.

Yeah, I was also extending xskxceiver initially, but not sure we want
to put metadata in there (that test is already too big imo)?
Jesper also pointed out [0], so maybe that thing should live out-of-tree?

I got mlx4 working locally with a small xskxceiver-like selftest. I'll
probably include it in the next non-rfc submission and we can discuss
whether it makes sense to keep it or it's better to extend xskxceiver.

0: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-interaction


> >
> >
> > > > +     } else if (func_id == xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP_SUPPORTED)) {
> > > > +             /* return true; */
> > > > +             bpf_patch_append(patch, BPF_MOV64_IMM(BPF_REG_0, 1));
> > > > +     } else if (func_id == xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP)) {
> > >
> > > [...]
> > >
> > > > --
> > > > 2.38.1.431.g37b22c650d-goog
> > >
> > > Thanks,
> > > Olek
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a693ff3ed5610a07b1b0dd831d10f516e13cf6c6
>
> Thank,
> Olek
