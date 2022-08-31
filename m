Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E165A791F
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 10:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiHaIeL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 04:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHaIeK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 04:34:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC45E0AA
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 01:34:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y3so26925623ejc.1
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 01:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=wk2vEHtqDKnUOKmShZ01Zr5PxUlXYM4WzMq4C1GbUMw=;
        b=MpuQ/6x6SswOUjx7LpFsJ880DuAN6ApcGJlyLLH7QelP+xxDK9PmprnB0M45Ciz2U5
         We7k/jCodRwsTC7L2GVfPEiJSUWx1IKMzkKNPP5JkP0gSaN2sb89DMZZDvRirkvKLBd8
         unwMqsU9QN9qp50GYbVHWmkmZ0uPu6YAx0USI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wk2vEHtqDKnUOKmShZ01Zr5PxUlXYM4WzMq4C1GbUMw=;
        b=KoFaGnEGdP2S8Rkd0GWnp2Hneq4l9SQGN4IdIr9brokqcZPtYlMTQTh+lYj4k2P5kG
         T+NHMpgXt7ZWU4ZoToh3NtOI97rzMWaOqcgyXWGhT5jP7H2KRh5ipkNa+rV6e0PhHROV
         tQWUFodogdO6nDQaM6jeDb3xlJZU8gBvyrTCjmXUODl+sG/cvogXapB0y2608cjqr1jC
         XH4HU8W4eUjdVV3A7r7ciAf0YlQJLjy5sRX6C2WutKMKVrqL+S0+sefJ9EbjXgUm97Ko
         Qu0lEtYgtWH7Pp+34h8a8vwB1IWyhNUdtM8xH19l/lCaUDn/tN3uxFikoNYRzFVpbWQC
         MHPg==
X-Gm-Message-State: ACgBeo0oM1nLdB2S/p2yK+wQkcvPdI54GD1lTETyMUjnwdkwUbgaPUn3
        LrH+vFThVbzlhdoPy8V1RmVZ/w==
X-Google-Smtp-Source: AA6agR71TdS+ni8tjUfytd3r+DgFBy927jpeiKqnOlclStYahiJ9z6I2vprCZjDtj7YU021aSUMVdg==
X-Received: by 2002:a17:907:7d8e:b0:742:8ea0:686c with SMTP id oz14-20020a1709077d8e00b007428ea0686cmr4500934ejc.591.1661934847609;
        Wed, 31 Aug 2022 01:34:07 -0700 (PDT)
Received: from blondie ([5.102.239.127])
        by smtp.gmail.com with ESMTPSA id gh21-20020a1709073c1500b0073a644ef803sm6769583ejc.101.2022.08.31.01.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:34:06 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:34:04 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Support setting variable-length
 tunnel options
Message-ID: <20220831113404.78e6f317@blondie>
In-Reply-To: <630488c5d0f99_2ad4d720813@john.notmuch>
References: <20220822052152.378622-1-shmulik.ladkani@gmail.com>
        <20220822052152.378622-2-shmulik.ladkani@gmail.com>
        <630488c5d0f99_2ad4d720813@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Aug 2022 00:59:01 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> > + * long bpf_skb_set_var_tunnel_opt(struct sk_buff *skb, void *opt, u32 size, u32 len)
> > + *	Description
> > + *		Set tunnel options metadata for the packet associated to *skb*
> > + *		to the variable length *len* bytes of option data contained in
> > + *		the raw buffer *opt* sized *size*.
> > + *
> > + *		See also the description of the **bpf_skb_get_tunnel_opt**\ ()
> > + *		helper for additional information.
> > + *	Return
> > + *		0 on success, or a negative error in case of failure.  
> 
> This API feels akward to me. Could you collapse this by using a dynamic pointer,
> recently added? And drop the ptr_to_mem+const_size part at least? That seems
> redundant with latest kernels.

Revisiting this decision.

After following that path, seems to me that adding the newly proposed
'bpf_skb_set_tunnel_opt_dynptr' API creates awkwardness in user's bpf
program.

Suppose user needs to hold a map of the options received on incoming
traffic based on whatever 'bpf_skb_get_tunnel_opt' returns.

Then, when user needs to apply the options on the return traffic, we
have the following two alternative APIs:


option A: bpf_skb_set_var_tunnel_opt
------------------------------------

struct tun_opts {
    __u8 data[MAX_OPT_SZ];
    __u32 len;
};
BPF_MAP_TYPE_HASH opts_map; // __type(value, tun_opts)

  ...

  struct tun_opts *opts;

  opts = bpf_map_lookup_elem(&opts_map, &the_flow_key);
  bpf_skb_set_var_tunnel_opt(skb, opts->data, sizeof(opts->data), opts->len);


option B: bpf_skb_set_tunnel_opt_dynptr
---------------------------------------

struct tun_opts {
    __u8 data[MAX_OPT_SZ];
};
BPF_MAP_TYPE_HASH opts_map;       // __type(value, tun_opts)
BPF_MAP_TYPE_HASH opts_len_map;   // __type(value, __u32)

  ... 

  struct bpf_dynptr dptr;
  struct tun_opts *opts;
  __u32 *opts_len;

  opts = bpf_map_lookup_elem(&opts_map, &the_flow_key);
  opts_len = bpf_map_lookup_elem(&opts_len_map, &the_flow_key);

  bpf_dynptr_from_mem(opts, sizeof(*opts), 0, &dptr);  // construct a dynptr from the raw option data
  bpf_dynptr_trim(&dptr, opts_len);                    // trim it based on stored option len
  bpf_skb_set_tunnel_opt_dynptr(skb, &dptr);


IMO, the 2nd user program is less readable:
 - need to store the received options length in a separate map
 - 5 bpf function calls instead of 2

Despite the awkwardness of the 'bpf_skb_set_var_tunnel_opt' API (passing
both constant size *and* dynamic len), it really creates more simple and
readable ebpf programs.

WDYT?

Best
Shmulik

