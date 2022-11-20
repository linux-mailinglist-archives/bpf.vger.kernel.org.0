Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571DA63176E
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 00:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiKTXrW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 18:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKTXrW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 18:47:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0465B167FE
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 15:47:21 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so24892210ejb.13
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 15:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0cLYuWcXGQrxkYedw83rwJZatfjz3oXDPletNaba4g=;
        b=mGw/bc58bPcY6Skh0aTxHNGC38yBPdEifOWLYyqtYk7+uIm2tf5Hs7As9kr3IRmEIX
         fOfiM0sB/4kwDfta7bhfmb8fZwNSaVy7OwLh9ssGsMGO3d7rrdNfr2FonrCES/RMg+Z4
         iyRxC9K4CBFGNBRETB5ZNGiGo8Cjo3TdayfQvTLurCzQpyKFnG038igt5GW/5s6Rpkjc
         U2FywA/XB2y7DUACy0wy2W+xmUGA2cLb0P+nXCELDawHGUFZ1+wtwjf0VDBJzI7tWGfX
         AWaDmGCBFSFNscLpHbUnzoQtjV8uL6GC1w4WXIDiOfVLiZkD3zhv/wYnc0HiOmeVLf8N
         MTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0cLYuWcXGQrxkYedw83rwJZatfjz3oXDPletNaba4g=;
        b=27PTZClOdI70KHxTJ0J2VEa5sA9EEU3tkBV8ZNSVC0B23uBiRQEc2V3G1bJkAkI7vU
         BxTZ4qz108fBWd3+VEkWtZoxbzPmQVue47HKLgm96F8LGPvJYkhTp7XpcY45v44rr5DK
         3fKC+vdsL5XefB0PnpX2tLGQUOMXkBG+gmSpofV3dWmW4bgyyCRBT1NKoGhr/5TqdDdG
         WPHtgwjNkE1xql9tq8B4i1AqlDG+tASb7RQLugmL2J4asOmBoU4TyA9SE2dMQZfx3LcV
         d7m4y1uMpHmKK7Hu1jGOtxPrQmWYcRUqG2+WVvIfbcjV+xqu8Itk6Yh0XkjRLIaAmUeN
         GuDw==
X-Gm-Message-State: ANoB5pmDyOs0dgwxg9aFds3TJUsK2fRaupGQ005vzL+R4epRA4ZfsSDQ
        RF6T8YH1G+Qhy2cnYVT/htOaaqO7aYxFOMjbvh0=
X-Google-Smtp-Source: AA0mqf5Yan3r1oQG4WWHQj2tw/cELlI6D1NMDQZkydPQf+eK2SizlmGRIoKtEqSj471bKcTH/zXB0GDdeahkaJU8LX8=
X-Received: by 2002:a17:906:4351:b0:78d:513d:f447 with SMTP id
 z17-20020a170906435100b0078d513df447mr13865272ejm.708.1668988039414; Sun, 20
 Nov 2022 15:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20221120195421.3112414-1-yhs@fb.com> <20221120195437.3114585-1-yhs@fb.com>
 <CAADnVQ+92vwqUB=J-QJYtrW0Yqvx2HAJJBREkXPJtW0+gyS1mQ@mail.gmail.com>
 <20221120204930.uuinebxndf7vkdwy@apollo> <20221120223454.ymzd4oqt7nsrbgkn@macbook-pro-5.dhcp.thefacebook.com>
 <CAADnVQLMi-5Avxxd89+wpWksZnxGkCxzjDHrBLzuGUoVmp1Azw@mail.gmail.com>
In-Reply-To: <CAADnVQLMi-5Avxxd89+wpWksZnxGkCxzjDHrBLzuGUoVmp1Azw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 20 Nov 2022 15:47:08 -0800
Message-ID: <CAADnVQJ3U=R7qtbgdMDpnn41PvMREFECjGTfgFcP81TUDe_89g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add a kfunc for generic type cast
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 3:32 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Nov 20, 2022 at 2:34 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 21, 2022 at 02:19:30AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > On Mon, Nov 21, 2022 at 01:46:04AM IST, Alexei Starovoitov wrote:
> > > > On Sun, Nov 20, 2022 at 11:57 AM Yonghong Song <yhs@fb.com> wrote:
> > > > >
> > > > > @@ -8938,6 +8941,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > > > >                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
> > > > >                                 regs[BPF_REG_0].btf = desc_btf;
> > > > >                                 regs[BPF_REG_0].btf_id = meta.ret_btf_id;
> > > > > +                       } else if (meta.func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
> > > > > +                               if (!capable(CAP_PERFMON)) {
> > > > > +                                       verbose(env,
> > > > > +                                               "kfunc bpf_rdonly_cast requires CAP_PERFMON capability\n");
> > > > > +                                       return -EACCES;
> > > > > +                               }
> > > >
> > > > Just realized that bpf_cast_to_kern_ctx() has to be
> > > > gated by cap_perfmon as well.
> > > >
> > > > Also the direct capable(CAP_PERFMON) is not quite correct.
> > > > It should at least be perfmon_capable().
> > > > But even better to use env->allow_ptr_leaks here.
> > >
> > > Based on this, I wonder if this needs to be done for bpf_obj_new as well? It
> > > doesn't zero initialize the memory it returns (except special fields, which is
> > > required for correctness), so technically it allows leaking kernel addresses
> > > with just CAP_BPF (apart from capabilities needed for the specific program types
> > > it is available to).
> > >
> > > Should that also have a env->allow_ptr_leaks check?
> >
> > Yeah. Good point.
> > My first reaction was to audit everything where the verifier produces
> > PTR_TO_BTF_ID and gate it with allow_ptr_leaks.
> > But then it looks simpler to gate it once in check_ptr_to_btf_access().
> > Then bpf_rdonly_cast and everything wouldn't need those checks.
>
> Noticed that check_ptr_to_map_access is doing
> "Simulate access to a PTR_TO_BTF_ID"
> and has weird allow_ptr_to_map_access bool
> which is the same as allow_ptr_leaks.
> So I'm thinking we can remove allow_ptr_to_map_access
> and add allow_ptr_leaks check to btf_struct_access()
> which will cover all these cases.
>
> Also since bpf_cast_to_kern_ctx() is expected to be used out of
> networking progs and those progs are not always GPL we should add
> env->prog->gpl_compatible to btf_struct_access() too.

Since that follow up will cover bpf_rdonly_cast too
I've removed cap_perfmon check from this commit and will push
this series shortly.
