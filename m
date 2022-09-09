Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEB55B363F
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 13:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIILXM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIILXL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 07:23:11 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DC3137786
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 04:23:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i77so1135037ioa.7
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KTLIpYuBwRifdeX4kFi/pziODJv413mtGyQsFDGEz40=;
        b=YCrQnX9VhC3+3UAPmRbjGs3ScBQ5YyxjfrOnf1RZHN4MUGt52YGmivkWC2ngXlGYFZ
         JaB3JDcIIt9gu6EWPGvDKxVX5jGVcdj3mrEUV64UUcPQkEPMYjgVeMhdGZrNCvIG0ntt
         8YAS/se8+qewodl6EJydnOIwR9XHegv9teAIQDW873mddUaXVZWa8b/RbUJoGziPtjly
         3RlHOaDEkASg2CEM/3nBfhhDclRZctVwxsiOgBx0H1CeQ6pnJPQVDjbg0IVvlIvYlCI1
         VkpVmmZulJ5emmG4gz5wZyWkOu2Aa8THGc+LrnSaCWW55o6+xMfpMjlVBg4ykKa74YRG
         CN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KTLIpYuBwRifdeX4kFi/pziODJv413mtGyQsFDGEz40=;
        b=aLo3kC//6GyS3lgm++K03cTmsfgy8yJIKK7XIZ529VnzYmLGc8wtzz3DzWBjktcqTe
         5mZBz6NNk3hx7uQhZzBEkCpdPhFYQotG1pbn0KTbuu9GsoWbgn14/MG64q8Hrllgx6sc
         aG+BE0SsDhwegr9j3Rkbw3agfBB8fArqZLe+oo8DK8qi0pvTxw+I3sgMwb22y4RNDH10
         ZeVXSY/TuMyN/S7MCeEpzuYsJXbCo5pm6X4rbDRQq27EkvdZ8VTcqrl6TyRgCibcFuBj
         WJCAs/TbGhtpkCowaXeQ1+HyyYrEsJiMao+zTO49YeSM+kxCAenPouLUDA63Qel1WqC1
         fJpg==
X-Gm-Message-State: ACgBeo1w3YREFQar52GgAlimztPALLf57bRkRDcxkMDNh7LMAgw/tJuH
        HvXCj8izITbxjR3YMmmHjRntOF49O5EOdUmy9Eg=
X-Google-Smtp-Source: AA6agR7VGT/97E0mxjOekZhw2NagHcuRw4Q/yjrMW9Ctqo0gzqzDS4HvcgLF/3aD/yx3QGzEYhMbJ3XFagqcAKPaUoE=
X-Received: by 2002:a02:3f63:0:b0:349:cef9:d8c2 with SMTP id
 c35-20020a023f63000000b00349cef9d8c2mr7116105jaf.231.1662722590281; Fri, 09
 Sep 2022 04:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-6-memxor@gmail.com>
 <5f4423cb-76f9-4e30-695d-22b7e8ab6422@linux.dev>
In-Reply-To: <5f4423cb-76f9-4e30-695d-22b7e8ab6422@linux.dev>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 9 Sep 2022 13:22:34 +0200
Message-ID: <CAP01T74rwFYCAotHO+dKYiFoXvYWQmtZOF9VFzO4o=8T5Wh6FA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 05/32] bpf: Support kptrs in local storage maps
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
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

On Fri, 9 Sept 2022 at 07:27, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 9/4/22 1:41 PM, Kumar Kartikeya Dwivedi wrote:
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> > index 7ea18d4da84b..6786d00f004e 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -74,7 +74,7 @@ struct bpf_local_storage_elem {
> >       struct hlist_node snode;        /* Linked to bpf_local_storage */
> >       struct bpf_local_storage __rcu *local_storage;
> >       struct rcu_head rcu;
> > -     /* 8 bytes hole */
> > +     struct bpf_map *map;            /* Only set for bpf_selem_free_rcu */
>
> Instead of adding another map ptr and using the last 8 bytes hole,
>
> >       /* The data is stored in another cacheline to minimize
> >        * the number of cachelines access during a cache hit.
> >        */
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > index 802fc15b0d73..4a725379d761 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -74,7 +74,8 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> >                               gfp_flags | __GFP_NOWARN);
> >       if (selem) {
> >               if (value)
> > -                     memcpy(SDATA(selem)->data, value, smap->map.value_size);
> > +                     copy_map_value(&smap->map, SDATA(selem)->data, value);
> > +             /* No call to check_and_init_map_value as memory is zero init */
> >               return selem;
> >       }
> >
> > @@ -92,12 +93,27 @@ void bpf_local_storage_free_rcu(struct rcu_head *rcu)
> >       kfree_rcu(local_storage, rcu);
> >   }
> >
> > +static void check_and_free_fields(struct bpf_local_storage_elem *selem)
> > +{
> > +     if (map_value_has_kptrs(selem->map))
>
> could SDATA(selem)->smap->map be used here ?
>

Yeah, that should work. Thanks Martin.

> > +             bpf_map_free_kptrs(selem->map, SDATA(selem));
> > +}
> > +
> [...]
