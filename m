Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F19B5B0D30
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 21:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIGT11 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 15:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIGT1X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 15:27:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09E49C23C;
        Wed,  7 Sep 2022 12:27:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u9so32710526ejy.5;
        Wed, 07 Sep 2022 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rbxAstgqQfuNRBpq8Ijjwuhcg1t0lRJI30o99kg9RaE=;
        b=Sh/WB+jjHBlF265aX/WN6UX25xxUxpmEI3nKIb2wM45O6t4c59fWhJCoiaMdz/VB94
         sze/qLCkjh3WIKsqEoTx2n3tgKGeUiFgpAxUtWXDUmyLEJ8yglFrDl+BGjE2tsjbRTDW
         Qym5v16+wmHyBH/5mZ3lnui8j8DC9sO2DnKhhDyeTKaPmV3YuHeGuRVcSuRLwWIQIytC
         G3ddy+jEKi3/NSkU033q6y922lcANtPvaq4gscYclj8Iz0OqxuOIBbGdgsrMQoOf0Ss5
         0TtnBPvCY/3Zw6Y58t3kVsods4HpENgLZuTlRun6YrQpVDT1N4ipCWZxsUiJuZBmiMKO
         OE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rbxAstgqQfuNRBpq8Ijjwuhcg1t0lRJI30o99kg9RaE=;
        b=lvffc5/9sxskdnWA0Y23aDZApbyX1cDFfuVmPCyIa1pCcFxFT0tBS2dte3u3mAapC1
         Dcdc6e5vk6kXfAM3By7KsDt97jlvIUYdxy7kH6u1XhqRAbp1LZuaP76GQEoBZ07IwHv4
         yrMrq6apQqXlKPSIBXKKUMgkwRsnfQyFgH3uQ4/l8GgWZnFA6a7iGw3EcerVoCY3MYP4
         xpzg9HavqGs+DITZjU5FH60bdDaCaBlpDP9AeQ/b78AA731ZuE8/2dJpP59i7/wUTjFY
         L0mWNzJLtaXxtVT2uTU+MMm1KJ3gWq6clYKr80r09tY8NWt2BxEcad+U/KZEQJiDHX/b
         VgDA==
X-Gm-Message-State: ACgBeo1NO1V3iTblKTcsEt4HBLR4CeeXT9pRj7xAG8kTNgFOAbmAnpev
        2ZqZ0Vt5fh3J70IIdMCllzFUR5n14xihnNMfPHSNOwWk
X-Google-Smtp-Source: AA6agR4s1eNvOleNU30EnuRzrWO3j/hdM68qK6928FAXaT+bYjQ/11p/3pjy7bUVZf2mcsKXTFzdcNK1qxf8nV7v6js=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr3435121ejc.676.1662578841191; Wed, 07
 Sep 2022 12:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
 <CAADnVQKbK__y8GOD4LqaX0aCgT+rtC5aw54-02mSZj1-U6_mgw@mail.gmail.com> <87sfl3j966.fsf@oracle.com>
In-Reply-To: <87sfl3j966.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 7 Sep 2022 12:27:09 -0700
Message-ID: <CAADnVQKbf5nEBnuSLmfZ_kGLmUzeD5htc1ezbJsVg72adF4bLw@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/7] Add support for generating BTF for all variables
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 7, 2022 at 12:07 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> > On Fri, Aug 26, 2022 at 11:54 AM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> [...]
> >> Future Work
> >> -----------
> >>
> >> If this proves acceptable, I'd like to follow-up with a kernel patch to
> >> add a configuration option (default=n) for generating BTF with all
> >> variables, which distributions could choose to enable or not.
> >>
> >> There was previous discussion[3] about leveraging split BTF or building
> >> additional kernel modules to contain the extra variables. I believe with
> >> this patch series, it is possible to do that. However, I'd argue that
> >> simpler is better here: the advantage for using BTF is having it all
> >> available in the kernel/module image. Storing extra BTF on the
> >> filesystem would break that advantage, and at that point, you'd be
> >> better off using a debuginfo format like CTF, which is lightweight and
> >> expected to be found on the filesystem.
> >
> > With all or nothing approach the distros would have a hard choice
> > to make whether to enable that kconfig, increase BTF and consume
> > extra memory without any obvious reason or just don't do it.
> > Majority probably is not going to enable it.
> > So the feature will become a single vendor only and with
> > inevitable bit-rot.
>
> I'd intend to support it even if just a single distribution enabled it.
> But I do see your concern.

This thread was dormant for 8 days.
That's a poor example of "intend to support".


> > Whereas with split BTF and extra kernel module approach
> > we can enable BTF with all global vars by default.
> > The extra module will be shipped by all distros and tools
> > like bpftrace might start using it.
>
> Split BTF is currently limited to a single base BTF file. We'd need more
> patches for pahole to support multiple --btf_base files: e.g.
> vmlinux.btf and vmlinux-variables.btf. There's also the question of
> modules: presumably we wouldn't try to have "$MODULE" and
> "$MODULE-btf-extra" modules due to the added complexity. I doubt the
> space savings would be worth it.
>
> I can look into these concerns, but if possible I would like to proceed
> with this series, as it is a separate concern from the exact mechanism
> by which we include extra BTF into the kernel.

Not an option. Sorry.
