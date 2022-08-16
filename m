Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9A55964FE
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 23:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiHPVyg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 17:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiHPVyf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 17:54:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7D769F53
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:54:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fy5so21391359ejc.3
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=h61IqeiJgd5848lUuEwsckDeBvaRxasrdZzYJronRtg=;
        b=E5AIhyKn5Co0KEicXCCIMOuOcb4e7F7gDdPOSCK2vlLSfqM2jLivAzDXEkqKfcAo23
         5RzyxGVQyJiBAQpq/z1Gz6qWHJ9eIufY1GHLnOd10sHKEQHqrk2GPfwy3PCYXlrkOOu6
         I6mP71kd35KrGeeY2GammmDUW6i7EpLpXHiz+ZEbxRbVMKr7FQdEwqjy75JcWp77r5M6
         J2MnAvpbGq99Aw5PMA3LOaQCz3sK0KIv1yvIyZTpMryIK4ko8JwvOA5gWeAAzTspwlq7
         uKEh8TlZs7rl4ngamICt8kRwnzokwueFUfOkxH8F2EBNZlQfGu5EkvKNG2rV8RkQSlm3
         2suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=h61IqeiJgd5848lUuEwsckDeBvaRxasrdZzYJronRtg=;
        b=aQZTOV4D+7EdUZoKhHWEGcXFFu8IYWNY6EOyZEs9Tg7FDBKhCI+DZZJUrf8iAwG6Jo
         Y9cGym/hGvpRQZy8600FUl0itLuKrAHGFTzChvOBElwJjyceapdDnR/4siAOsl0mIlZ2
         1jS2CjJ++Mx5ZeA3DqDtxVR5ro5TowBNNVxyKbl4iSri209R1gn+XBGIav42nWrBl+js
         Irm8tW4MQ2ZL7cUc3g0EjHrXPG2pop9/QPM6vk2Mg8ItqpNzvrYJuMbVLcioGKbRiNHm
         EHkVRU2OaosGd2DIiVF1SGm5uqVq9ZEhU6Tngx0JICP/bvvRwF63OBrZrSA+C6oSnoYG
         cjBw==
X-Gm-Message-State: ACgBeo3AQV8vm+9J8XxILfbWlcmZPmR4PvtYDiRsM4ap/+XOa7stBfQj
        sp3nEHoSbXMbaEpwyTzWhrnJXwoqii/CBMHhopGuhyOs
X-Google-Smtp-Source: AA6agR7So0XIrDgLlYDrYlL6qIO6ggk0t7vdYhTouKtBbZXFajTb4DogeUhNiF4Wd1juyVD0mRQBPWwZig9voWUrmyM=
X-Received: by 2002:a17:907:1361:b0:730:8f59:6434 with SMTP id
 yo1-20020a170907136100b007308f596434mr14981100ejb.745.1660686871516; Tue, 16
 Aug 2022 14:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220816001929.369487-1-andrii@kernel.org> <20220816001929.369487-3-andrii@kernel.org>
 <CA+khW7g6GL7DwEwKfsszmKdW4562nd6MzuT640su2TmFfp6Y2g@mail.gmail.com>
In-Reply-To: <CA+khW7g6GL7DwEwKfsszmKdW4562nd6MzuT640su2TmFfp6Y2g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Aug 2022 14:54:20 -0700
Message-ID: <CAEf4BzbTb_jbe5Kz-29kgyY38PzuF7Nfria==LTGmCdn+zevYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: streamline bpf_attr and
 perf_event_attr initialization
To:     Hao Luo <haoluo@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Tue, Aug 16, 2022 at 2:33 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Aug 15, 2022 at 8:53 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Make sure that entire libbpf code base is initializing bpf_attr and
> > perf_event_attr with memset(0). Also for bpf_attr make sure we
> > clear and pass to kernel only relevant parts of bpf_attr. bpf_attr is
> > a huge union of independent sub-command attributes, so there is no need
> > to clear and pass entire union bpf_attr, which over time grows quite
> > a lot and for most commands this growth is completely irrelevant.
> >
> > Few cases where we were relying on compiler initialization of BPF UAPI
> > structs (like bpf_prog_info, bpf_map_info, etc) with `= {};` were
> > switched to memset(0) pattern for future-proofing.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Looks good to me. I went over all the functions in this change and

Thanks!

> verified the conversion is correct. There is only one question: I
> noticed, for bpf_prog_load() and probe_memcg_account(), we only cover
> up to fd_array and attach_btf_obj_fd. Should we cover up to the last
> field i.e. core_relo_rec_size?

libbpf never sets those fields, I think it's only used from light
skeleton generated loaded BPF program, so I felt like it's unnecessary
to include that yet

>
> Acked-by: Hao Luo <haoluo@google.com>
>
>
> >  tools/lib/bpf/bpf.c           | 173 ++++++++++++++++++++--------------
> >  tools/lib/bpf/libbpf.c        |  43 ++++++---
> >  tools/lib/bpf/netlink.c       |   3 +-
> >  tools/lib/bpf/skel_internal.h |  10 +-
> >  4 files changed, 138 insertions(+), 91 deletions(-)
> >

[...]
