Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC95B4269
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 00:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIIWTL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiIIWTL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 18:19:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A6EE999
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:19:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l14so7203877eja.7
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ofyGm9sV7DeQLWwMPtMa2iQ4L8RQvltBVllAWj7pM48=;
        b=SO8jVfm6ysDvnMykY40XJbMVkldnzjesw0QZUbsAe6m3VeKuEkxQRucC5nyj982ngC
         LK0sH1ZBQARISxJeR3/I1I4f5XNBI8h7svYyiBt/+HFQn+HfyDhC4QwLO9QmpMJBOnoz
         uOM5W1hAObvv6ma6h3U7XlcAV1o1KK8eIcqOSykUp8EVgi1CEM/u/nR8XEkYb286dGP1
         FBFERcUAdWN33hx3Dbs5aWWbopE1oPPNFNEM1AFod7pFMyyyQNeGVp312GlgmrnLkCqA
         s80OjE5QR41qdP/VcqxJgRExpUcFpR4LPAFac62DfBNRZVIiI+4DOwBLonZe+nJV2EU1
         TbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ofyGm9sV7DeQLWwMPtMa2iQ4L8RQvltBVllAWj7pM48=;
        b=rydYX2BqA5sdNFLY9TNFrXypPv8urXiwkUdFR1LFQr4KpSxp6L/Vkv/6V7MXUw1s4f
         yz/pm1bQg+Chzylw6W93b6ZJ9D/kcNCtqMhYWdJGksOULcBMqZf//AlHAndsY301yaIe
         I7bUlcqO0Ch1qnna2TRp3NeyFluyw9HiN38/FkNKnp5A2iJZQP2ClHMpF0MwZWGxj3Xv
         MIUV5bDgSP/79kBr28NxbLta2hcFS4sVhyqjD8feNG3cm3LpdJJ0NlYfA+Aert1iWpN+
         /gUu3yo3pM8N9DnLd7SopLzxEEAc2M2ZEArTx46Nj66NPTJHxcUHbfKFGZBXgLwAewJA
         a5KQ==
X-Gm-Message-State: ACgBeo1Ld2v9g3pbV+3OQ2xlMGO2UVTA65KLzhYjwkTjISE3whDMUpVd
        7+bpR0kXRyo5SNjQ/gWnUzkDuleopVnRAtCLSfM=
X-Google-Smtp-Source: AA6agR47jJAxirrs8mwihis/z5Y5ano5E8EWkNrzcThW4c+KKrtDuoodZbbzn3hBrcUBCEVOvNFfz9aapv6WSzv4S08=
X-Received: by 2002:a17:907:d19:b0:77b:2fb5:43ec with SMTP id
 gn25-20020a1709070d1900b0077b2fb543ecmr127197ejc.608.1662761948637; Fri, 09
 Sep 2022 15:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
 <20220908000254.3079129-6-joannelkoong@gmail.com> <20220909194138.46aea4cb@blondie>
In-Reply-To: <20220909194138.46aea4cb@blondie>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 9 Sep 2022 15:18:57 -0700
Message-ID: <CAJnrk1a53F=LLaU+gdmXGcZBBeUR-anALT3iO6pyHKiZpD0cNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] bpf: Add bpf_dynptr_clone
To:     Shmulik Ladkani <shmulik.ladkani@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        andrii@kernel.org, ast@kernel.org, Kernel-team@fb.com,
        Eyal Birger <eyal.birger@gmail.com>
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

On Fri, Sep 9, 2022 at 9:41 AM Shmulik Ladkani
<shmulik.ladkani@gmail.com> wrote:
>
> On Wed,  7 Sep 2022 17:02:51 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:
>
> > Add a new helper, bpf_dynptr_clone, which clones a dynptr.
> >
> > The cloned dynptr will point to the same data as its parent dynptr,
> > with the same type, offset, size and read-only properties.
>
> [...]
>
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 4ca07cf500d2..16973fa4d073 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5508,6 +5508,29 @@ union bpf_attr {
> >   *   Return
> >   *           The offset of the dynptr on success, -EINVAL if the dynptr is
> >   *           invalid.
> > + *
> > + * long bpf_dynptr_clone(struct bpf_dynptr *ptr, struct bpf_dynptr *clone)
> > + *   Description
> > + *           Clone an initialized dynptr *ptr*. After this call, both *ptr*
> > + *           and *clone* will point to the same underlying data.
> > + *
>
> How about adding 'off' and 'len' parameters so that a view ("slice") of
> the dynptr can be created in a single call?
>
> Otherwise, for a simple slice creation, ebpf user needs to:
>   bpf_dynptr_clone(orig, clone)
>   bpf_dynptr_advance(clone, off)
>   trim_len = bpf_dynptr_get_size(clone) - len
>   bpf_dynptr_trim(clone, trim_len)

I like the idea, where 'off' is an offset from ptr's offset and 'len'
is the number of bytes to trim.

Btw, I will be traveling for the next ~6 weeks and won't have access
to a computer, so v2 will be sometime after that.

>
> This fits the usecase described here:
>   https://lore.kernel.org/bpf/20220830231349.46c49c50@blondie/
