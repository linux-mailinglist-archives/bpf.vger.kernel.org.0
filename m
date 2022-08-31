Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28A85A866C
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiHaTHn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 15:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHaTHm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 15:07:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD6AA8961
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 12:07:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id cu2so30378930ejb.0
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HgatfZaAgMg+qU/kPOcERh+KS9vpDq8dLsvGTPm9TNI=;
        b=N/xhZvd0a3qIGXI8C08XeRUTdO4qIa5FGxzOmOqCXjPx2TbOv4yIKm9RQR695Akp7n
         GnH2pdwZ5HO/U8sggYSTMXlG16gqP1bZZM1EZIHcDCafFu73yxzU144BLPRPS/R0647V
         Hro0CY5yMpMK3Ahcn4Kal7NaE9FEZY+7SVPjGbFYuvdOU5GGrYOXNBLTeDgizACH67cw
         zSC/7ey/alTPPj+qbOMESt5ifB2c5BaV+PjPdak32hSaiwrS2S55Vnn1KHrecPg/hkZl
         ttz9e28JPB/9gTMWwrwTWxB4V20cNRJ7rW/2RPK1yg2ocN069ROx3JWffrS3rkB5lr5V
         wKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HgatfZaAgMg+qU/kPOcERh+KS9vpDq8dLsvGTPm9TNI=;
        b=0rVFsHMKaU00Sjd3nnAJJ2YGFxHsjjUE2Xmp8cptM0E3+YXRNawOUF4Wkaz7Jg6gaM
         QKU6kE3ksxaz+TSJXQ7apgYS1fYvMwkeYNybgFnI+n9pIk8h88DRq/SfIiGuIiXpVzCD
         CcBfGVMPMShZznG4mdg5u9SHgwODsbtNeTPmp4CddlFhkhhpwHdFw+6HHePMlLVIk5FJ
         9IReRET4n6RaY7VLw1yhcpLTTuIQFjP+uBzP2n9WA+VeshU0vsYPjEPlcA+Nssqa67U5
         6D5sjAy7rJxyoko6jtnXxf7VIt4p3MSS2sHqSTHjkTqNkh5yMU2GGiiC0+jJxzAsyhaQ
         oJ8g==
X-Gm-Message-State: ACgBeo3kRLnlSDAP2UUWbOtcUdEgbSg+1oM0IBTEzMI/pojjWiXtvMtB
        22finkxoRLAAD9ZCHU/nFUoKBrhisAthXcWPYuoMyhDZuFY=
X-Google-Smtp-Source: AA6agR7K1SCZyg0cLPRUqn95I6b5tXJscEdk9MJw29TthsW9ZnT82xpV0dkHQAhId3Ky4scofmyHNf7YuhNZlzFmbc8=
X-Received: by 2002:a17:907:8687:b0:730:7c7b:b9ce with SMTP id
 qa7-20020a170907868700b007307c7bb9cemr20815442ejc.656.1661972859770; Wed, 31
 Aug 2022 12:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220822052152.378622-1-shmulik.ladkani@gmail.com>
 <20220822052152.378622-2-shmulik.ladkani@gmail.com> <630488c5d0f99_2ad4d720813@john.notmuch>
 <20220831113404.78e6f317@blondie>
In-Reply-To: <20220831113404.78e6f317@blondie>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 31 Aug 2022 12:07:28 -0700
Message-ID: <CAJnrk1b0oy4MQW9aucSCRDRg3dJq8fbA29YMM_Xo7F-YfnTH7w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Support setting variable-length
 tunnel options
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
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

On Wed, Aug 31, 2022 at 1:44 AM Shmulik Ladkani
<shmulik@metanetworks.com> wrote:
>
> On Tue, 23 Aug 2022 00:59:01 -0700
> John Fastabend <john.fastabend@gmail.com> wrote:
>
> > > + * long bpf_skb_set_var_tunnel_opt(struct sk_buff *skb, void *opt, u32 size, u32 len)
> > > + * Description
> > > + *         Set tunnel options metadata for the packet associated to *skb*
> > > + *         to the variable length *len* bytes of option data contained in
> > > + *         the raw buffer *opt* sized *size*.
> > > + *
> > > + *         See also the description of the **bpf_skb_get_tunnel_opt**\ ()
> > > + *         helper for additional information.
> > > + * Return
> > > + *         0 on success, or a negative error in case of failure.
> >
> > This API feels akward to me. Could you collapse this by using a dynamic pointer,
> > recently added? And drop the ptr_to_mem+const_size part at least? That seems
> > redundant with latest kernels.
>
> Revisiting this decision.
>
> After following that path, seems to me that adding the newly proposed
> 'bpf_skb_set_tunnel_opt_dynptr' API creates awkwardness in user's bpf
> program.
>
> Suppose user needs to hold a map of the options received on incoming
> traffic based on whatever 'bpf_skb_get_tunnel_opt' returns.
>
> Then, when user needs to apply the options on the return traffic, we
> have the following two alternative APIs:
>
>
> option A: bpf_skb_set_var_tunnel_opt
> ------------------------------------
>
> struct tun_opts {
>     __u8 data[MAX_OPT_SZ];
>     __u32 len;
> };
> BPF_MAP_TYPE_HASH opts_map; // __type(value, tun_opts)
>
>   ...
>
>   struct tun_opts *opts;
>
>   opts = bpf_map_lookup_elem(&opts_map, &the_flow_key);
>   bpf_skb_set_var_tunnel_opt(skb, opts->data, sizeof(opts->data), opts->len);
>
>
> option B: bpf_skb_set_tunnel_opt_dynptr
> ---------------------------------------
>
> struct tun_opts {
>     __u8 data[MAX_OPT_SZ];
> };
> BPF_MAP_TYPE_HASH opts_map;       // __type(value, tun_opts)
> BPF_MAP_TYPE_HASH opts_len_map;   // __type(value, __u32)
>
>   ...
>
>   struct bpf_dynptr dptr;
>   struct tun_opts *opts;
>   __u32 *opts_len;
>
>   opts = bpf_map_lookup_elem(&opts_map, &the_flow_key);
>   opts_len = bpf_map_lookup_elem(&opts_len_map, &the_flow_key);
>
>   bpf_dynptr_from_mem(opts, sizeof(*opts), 0, &dptr);  // construct a dynptr from the raw option data
>   bpf_dynptr_trim(&dptr, opts_len);                    // trim it based on stored option len
>   bpf_skb_set_tunnel_opt_dynptr(skb, &dptr);
>
>
> IMO, the 2nd user program is less readable:
>  - need to store the received options length in a separate map
>  - 5 bpf function calls instead of 2

I don't think you need a separate map to store the opts length. I
think you can store

struct tun_opts {
     __u8 data[MAX_OPT_SZ];
     __u32 len;
};

in the map, and then do something like:

struct bpf_dynptr ptr;
struct tun_opts *opts;

opts = bpf_map_lookup_elem(&opts_map, &the_flow_key);
bpf_skb_set_tunnel_opt_dynptr(skb, &ptr);

where inside the bpf_skb_set_tunnel_opt_dynptr() helper, you can parse
the dynptr data back to a "struct tun_opts" (after doing requisite
checks, eg making sure dynptr size matches sizeof(struct tun_opts))
and then access tun_opts->data and tun_opts->len accordingly.

What are your thoughts?

>
> Despite the awkwardness of the 'bpf_skb_set_var_tunnel_opt' API (passing
> both constant size *and* dynamic len), it really creates more simple and
> readable ebpf programs.
>
> WDYT?
>
> Best
> Shmulik
>
