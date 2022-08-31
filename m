Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55F45A86E5
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 21:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiHaTkx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiHaTkv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 15:40:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11870C6EAF
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 12:40:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso140857wmh.5
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=O8aAi5Jriq+s1y5Nz07GL5ZTdoGetDloiT/Drlx3GoY=;
        b=VI2o2w5GyRY9pIJN5/KwPaqO5t6+iBGrgta/4c1iotfP1VdWMWVgIb9xo2zKrJW8no
         sSn2MEHPxGDKyK7l7Nf+oVhMRanUmtG7CxkGe82ozDGzTzhHDrnyWvdNS0733zorFnaH
         qUZ9iWiHDwOFr9PO3tOSxAAptVQ8NS6UmuiYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O8aAi5Jriq+s1y5Nz07GL5ZTdoGetDloiT/Drlx3GoY=;
        b=txvT7dS8kmNhxkUb6JJn7Jbk/vE9TV6tlU4wO0RIp0c+F4ULp2CDjGihSJnzBP7G79
         OCbPGYek7GnY/+vHWJ0dH24nBSzPlT17xTIJHmTwxlvrp6y1fURFuwHoapXpMCqHIgBj
         eHIxzJIaREe6Bl3qZ0knFcJMWInch1s8BOEvICi2TpYS63tet+06Q69YyYBoDKKH6W+H
         7N8+ZqURAn2+ouoo4qe7Ry+tl3kMIOerQi6tFdxx8eomK+hMNUHwIGvlrVMlKAI8BwXk
         HVJixBPh7jWgAKC2QTa+Rd61e9mzfKOrE6BZz/7ksQADcO8YcITfoQu9HiOC6EcZEJOz
         CxKw==
X-Gm-Message-State: ACgBeo3HYBs8l09t88bfQXv9MtFdELNFLHKvmjGWJXTEbqySrRNW01Sv
        30mk1bHXIjyQMHJuFbSoDIq+dw==
X-Google-Smtp-Source: AA6agR6ujZMnJOEH1wr9LxAoNfO+VLxSvfp60pnv4jcD/yr6VhLJ4B5QJWA4qYyR/G6jUAmFfOYG+w==
X-Received: by 2002:a05:600c:4f48:b0:3a5:e707:bb8c with SMTP id m8-20020a05600c4f4800b003a5e707bb8cmr2973388wmq.198.1661974848294;
        Wed, 31 Aug 2022 12:40:48 -0700 (PDT)
Received: from blondie ([5.102.239.127])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c268b00b003a60bc8ae8fsm2928978wmt.21.2022.08.31.12.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:40:47 -0700 (PDT)
Date:   Wed, 31 Aug 2022 22:40:45 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Support setting variable-length
 tunnel options
Message-ID: <20220831224045.00f71de5@blondie>
In-Reply-To: <CAJnrk1b0oy4MQW9aucSCRDRg3dJq8fbA29YMM_Xo7F-YfnTH7w@mail.gmail.com>
References: <20220822052152.378622-1-shmulik.ladkani@gmail.com>
        <20220822052152.378622-2-shmulik.ladkani@gmail.com>
        <630488c5d0f99_2ad4d720813@john.notmuch>
        <20220831113404.78e6f317@blondie>
        <CAJnrk1b0oy4MQW9aucSCRDRg3dJq8fbA29YMM_Xo7F-YfnTH7w@mail.gmail.com>
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

On Wed, 31 Aug 2022 12:07:28 -0700
Joanne Koong <joannelkoong@gmail.com> wrote:

> > option B: bpf_skb_set_tunnel_opt_dynptr
> > ---------------------------------------
> >
> > struct tun_opts {
> >     __u8 data[MAX_OPT_SZ];
> > };
> > BPF_MAP_TYPE_HASH opts_map;       // __type(value, tun_opts)
> > BPF_MAP_TYPE_HASH opts_len_map;   // __type(value, __u32)
> >
> >   ...
> >
> >   struct bpf_dynptr dptr;
> >   struct tun_opts *opts;
> >   __u32 *opts_len;
> >
> >   opts = bpf_map_lookup_elem(&opts_map, &the_flow_key);
> >   opts_len = bpf_map_lookup_elem(&opts_len_map, &the_flow_key);
> >
> >   bpf_dynptr_from_mem(opts, sizeof(*opts), 0, &dptr);  // construct a dynptr from the raw option data
> >   bpf_dynptr_trim(&dptr, opts_len);                    // trim it based on stored option len
> >   bpf_skb_set_tunnel_opt_dynptr(skb, &dptr);
> >
> >
> > IMO, the 2nd user program is less readable:
> >  - need to store the received options length in a separate map
> >  - 5 bpf function calls instead of 2  
> 
> I don't think you need a separate map to store the opts length.

You are correct, I was under the impression that 'bpf_dynptr_from_mem'
will *only* accept the exact pointer to the map element, due to the
verifier checking this:

	case BPF_FUNC_dynptr_from_mem:
		if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE) {
			verbose(env, "Unsupported reg type %s for bpf_dynptr_from_mem data\n",

However I found out this is also allowed by the verifier:

struct tun_opts {
    __u32 len;
    __u8 data[MAX_OPT_SZ];
};

  opts = bpf_map_lookup_elem(&opts_map, &the_flow_key);
  bpf_dynptr_from_mem(opts->data, sizeof(opts->data), 0, &dptr);
  bpf_dynptr_trim(&dptr, opts->len);
  bpf_skb_set_tunnel_opt_dynptr(skb, &dptr);

Nevertheless, IMO it doesn't change the argument about the better
readability and simplicity of the "bpf_skb_set_var_tunnel_opt" approach:

  opts = bpf_map_lookup_elem(&opts_map, &the_flow_key);
  bpf_skb_set_var_tunnel_opt(skb, opts->data, sizeof(opts->data), opts->len);

which is more straight forward.
                       
It even allows the bpf program to set tunnel options *without* using a
map element at all, e.g. this usecase:

  __u8 data[MAX_OPT_SZ];

  len = bpf_skb_get_tunnel_opt(skb, data, sizeof(data));
  ...
  // fiddle with the skb, the tunnel key, the tunnel remote, or whatever.
  // then send again on a collect-md interface, setting same tunnel
  // opts as seen.
  ...
  bpf_skb_set_var_tunnel_opt(skb, data, sizeof(data), len);
  bpf_redirect()

Best,
Shmulik
