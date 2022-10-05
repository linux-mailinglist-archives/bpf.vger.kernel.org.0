Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851995F4D43
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 03:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJEBDK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 21:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJEBDJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 21:03:09 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD034151A
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 18:03:09 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a2so7655613iln.13
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 18:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yJ/v5flpgbqzzKOS0FYLrm0MIv5XQqM/Le3ziZYOQHI=;
        b=ZC9ITz6o6buy6WwUn+AaoAusFCkjmocrVpdJxCp5hHjv2CRY8MPtaGrVAMXRv2VGix
         zYKcn3Z24SHeHcyk1I9x8BUFFVOFPuIk8Wk3ylLe42RZ0NEdKWBXCCzn6Hzy9PsSVBEk
         xllLfHngj6nxaYhz93NeNw+xexgMO6PfwmmonzAB0ivkRapnTONWOiTCAJqdzuvWLjBk
         teWXLcTESrPwRpzIvyLZ/iRmUgojm0Ky+LyJkS9cfcsU3CUvu1AXxyYvypkSOTZ8Rvap
         huqdoPP5WALMw/WBPzo19pm9krfggmqvkQ/J+TWxHu9S6h7XIRo5kDWdzAV+Sh1X51Th
         Rliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yJ/v5flpgbqzzKOS0FYLrm0MIv5XQqM/Le3ziZYOQHI=;
        b=5DfIzvNpASUim3G0Dy7KlXN5G3nYFMgUIBisGJav59VVqTi4h5OhORG7tmmK9MMcjD
         Z/hDaZouK1CA0b7bQlgwoG434E271/Jxk+29YLv+sVR+pXwA2O931iInQeEGSUU+/Msz
         LdCaZD8YoVM4m8PJgNUnEW4hmNYJa+VHXPWvEY+4QCLAzyD6yTH0/WlTlkQ40VH7VSLq
         254TRPkiJS31pdnqzk5FiTNdETJFCAwXJnnePKZ13rAdQjcRSHQCnwAEAi6xO918zeqc
         a3g4vpuikofVkgjEu0Zj/2GLO3O59Da9d+2wBca5bEJ1PyRM1spp32Hyk6zA8Jp6yhqx
         Dscg==
X-Gm-Message-State: ACrzQf0CgR76uWxYIvgmhonGehSx7TOavSf5US1d6VCGqXyi5uwAd8MK
        gBZBYJ+QoSiTmthJfamv1qMHf6OwzgqiKSzqts+eAg==
X-Google-Smtp-Source: AMsMyM62nBzxdO94Lozo3o57NKTA5aneTHuundWNjPY59L8dQ2zGbFTKjlEmTK3cKl7Np1mP7zA1f10MgH6ZT2e0qZ8=
X-Received: by 2002:a05:6e02:17cb:b0:2f9:1fb4:ba3b with SMTP id
 z11-20020a056e0217cb00b002f91fb4ba3bmr12821161ilu.257.1664931788439; Tue, 04
 Oct 2022 18:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <166256538687.1434226.15760041133601409770.stgit@firesoul>
 <Yzt2YhbCBe8fYHWQ@google.com> <35fcfb25-583a-e923-6eee-e8bbcc19db17@redhat.com>
 <CAKH8qBuYVk7QwVOSYrhMNnaKFKGd7M9bopDyNp6-SnN6hSeTDQ@mail.gmail.com>
 <5ccff6fa-0d50-c436-b891-ab797fe7e3c4@linux.dev> <20221004175952.6e4aade7@kernel.org>
In-Reply-To: <20221004175952.6e4aade7@kernel.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 4 Oct 2022 18:02:56 -0700
Message-ID: <CAKH8qBtdAeHqbWa33yO-MMgC2+h2qehFn8Y_C6ZC1=YsjQS-Bw@mail.gmail.com>
Subject: Re: [PATCH RFCv2 bpf-next 00/18] XDP-hints: XDP gaining access to HW
 offload hints via BTF
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        xdp-hints@xdp-project.net, larysa.zaremba@intel.com,
        memxor@gmail.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        mtahhan@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dave@dtucker.co.uk, Magnus Karlsson <magnus.karlsson@intel.com>,
        bjorn@kernel.org
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

On Tue, Oct 4, 2022 at 5:59 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 4 Oct 2022 17:25:51 -0700 Martin KaFai Lau wrote:
> > A intentionally wild question, what does it take for the driver to return the
> > hints.  Is the rx_desc and rx_queue enough?  When the xdp prog is calling a
> > kfunc/bpf-helper, like 'hwtstamp = bpf_xdp_get_hwtstamp()', can the driver
> > replace it with some inline bpf code (like how the inline code is generated for
> > the map_lookup helper).  The xdp prog can then store the hwstamp in the meta
> > area in any layout it wants.
>
> Since you mentioned it... FWIW that was always my preference rather than
> the BTF magic :)  The jited image would have to be per-driver like we
> do for BPF offload but that's easy to do from the technical
> perspective (I doubt many deployments bind the same prog to multiple
> HW devices)..

+1, sounds like a good alternative (got your reply while typing)
I'm not too versed in the rx_desc/rx_queue area, but seems like worst
case that bpf_xdp_get_hwtstamp can probably receive a xdp_md ctx and
parse it out from the pre-populated metadata?

Btw, do we also need to think about the redirect case? What happens
when I redirect one frame from a device A with one metadata format to
a device B with another?
