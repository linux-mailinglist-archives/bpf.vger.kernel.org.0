Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355845B42AA
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIIWvq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 18:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIIWvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 18:51:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB9925F0
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:51:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e17so4647494edc.5
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tIZI8Vn2b4wb6TqZgkRu82t5KYtxGSgBxKsKAEVIydk=;
        b=S2FHteEB3gm+569JENcuHckJp+++X4SRCLdxwn2z4m9OKBw0/aLea6Hjw9EN+X9IUf
         rZ+Gr62nhH4txRGB0MZxq/LTxwEJGGrlb2jdykaIeE4033nwB4xGNaL5pch5I7rsoGd8
         Bb05lsbdB0NOluPN2KZcd5KRG5VWvNb8O2gDAWpEFVnSk8yjT07zltmpwtLtZbZSLK/o
         2W0wssnbCHREXtRr/slWyjjbP+oY+bmSrVReBaLeKlDLfeyPG3t6xCIxZGjx4Z8zNKwV
         HfvvHw70fQEQnAiru/t2eGqJOqKzTlJRJDWmyvDouVnovdX0g+lA+/ocJQMOr69M8nM1
         2wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tIZI8Vn2b4wb6TqZgkRu82t5KYtxGSgBxKsKAEVIydk=;
        b=AmpSzqtI7idGuTS5sYHABHSV3s0VbwWe9DEU75H8wfnPbtNMo7pxLPF5Br5JbL1Pzx
         VM7U97fx1z6D88qI/qfsiuKfpaWsIV/7hT0nXdYDmtW+9e75+pGG0PyIhgOlHEaB6Vyv
         n0oYUwXiSQpjC8jvtRf/BpWq/M0m+Fc9wLp2rplCGvvXWpYnP0vYsLrTAcgpZ4KuI5LG
         emFQwvBXKFa7MPgMi4kNpJamR2cUJJ1FX1Sq1/1rL+WNjxudZ3wdh2vVmK1PCOuhVgsg
         DfV5jUWh08epGDEGUtwEp3QIraficM9UkPjwM115uZEqk4nZdWtuOM7VRZoS7WTybYNC
         /z6A==
X-Gm-Message-State: ACgBeo34ZOh7RMoRKuamYCqJkUwiz7wQFMblXEXNR0JnZzXDVGcvlwkD
        Q1bejEZameUCk8nSWEigCpVQHU98QE75oLCDApE=
X-Google-Smtp-Source: AA6agR4U4+8YgC2xjcaKXQLQR8zi7ZSgy5vQq91EQHAhOm0axvfc/zx0W2yywEHt61Eta9WqfOlqRVTohykOTFbbBjE=
X-Received: by 2002:a05:6402:1a4f:b0:44e:f731:f7d5 with SMTP id
 bf15-20020a0564021a4f00b0044ef731f7d5mr13014291edb.357.1662763902064; Fri, 09
 Sep 2022 15:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
 <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
 <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
 <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com> <4b987779-bae0-dcd9-2405-e43f401bf5ad@fb.com>
In-Reply-To: <4b987779-bae0-dcd9-2405-e43f401bf5ad@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 9 Sep 2022 15:51:30 -0700
Message-ID: <CAADnVQKypBq879HLAASDvDzdK0ooSkkuf3PBoPK0gKOpA8E7+g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
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

On Fri, Sep 9, 2022 at 3:30 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > ".lock" won't work. We need lock+rb_root or lock+list_head to be
> > in the same section.
> > It should be up to user to name that section with something meaningful.
> > Ideally something like this should be supported:
> > SEC("enqueue") struct bpf_spin_lock enqueue_lock;
> > SEC("enqueue") struct bpf_list_head enqueue_head __contains(foo, node);
> > SEC("dequeue") struct bpf_spin_lock dequeue_lock;
> > SEC("dequeue") struct bpf_list_head dequeue_head __contains(foo, node);
> >
>
> Isn't the "head and lock must be in same section / map_value" desired, or just
> a consequence of this implementation? I don't see why it's desirable from user
> perspective. Seems to have same problem as rbtree RFCv1's rbtree_map struct
> creating its own bpf_spin_lock, namely not providing a way for multiple
> datastructures to share same lock in a way that makes sense to the verifier for
> enforcement.

The requirement to have only one lock in an "allocation"
(which is map value or one global section) comes from the need
to take that lock when doing map updates.
Shared lists/rbtree might require the verifier to take that lock too.
We can improve things with __guarded_by() tags in the future,
but I prefer to start with simple one-lock-per-map-value.
