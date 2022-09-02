Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5235AB616
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 17:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiIBP64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbiIBP5h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 11:57:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845C8275C2
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 08:51:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w5so2812399wrn.12
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DEtfOXjanLwIczx/EXse/Duqx8Qfix5HKzMkj6Mf2MQ=;
        b=X1S021kSvUHgxeUT2zhHjqazUalWLz/+CUZ1OEWfGoE64fTSTIn6zY01FnAToDOPGb
         YLQoVVkRUX7kkurhokc9bw8HDq86pbPguQuELP7BG4vnLANy6iNaQUUMcAA4hcoJXfmY
         H8RK4aKpJOK81z7cmn8Rvo/nhZwPiX/sG21us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DEtfOXjanLwIczx/EXse/Duqx8Qfix5HKzMkj6Mf2MQ=;
        b=JKeaFCQbezVWIrT3V0C7hzOKtj6fBqX9+Tf2DVPPYkwmKkW7TBtPOB29pW1xpbIT10
         5r2EsxMBQz0vGCsnRNT2xW7rmdIWkjTJ6PwdqzwBGUvMKnAVi+EXabl7KWf7BF1by32b
         VIeaSAZxPT07AFmueHfsGjTebVhj+v10yi51vvfWfDaSilX/DAcn85WhaGNRq6Sbz4nh
         7S73yIHs5ON1ik+euMZKUMzUvS91rvwqHn0ggQBigVXFW4MZg4+l8sQRKg5tLUkjTWJ6
         ntplgxjeWROKwJtwF+XgptyRQW8LNSKcxHdz8tjOlsq43PfyqqMvrVQi2pRRr3ekHaAf
         +r/g==
X-Gm-Message-State: ACgBeo3sRp0pk0Wrk8fX95xSKwwADUk1QRTRFmWsFn5qteVfWHE0pr7c
        hzTsxV4Nwbn2XGwKnJbK/m3Yrw==
X-Google-Smtp-Source: AA6agR6Z0uXPeuLdS8UfAqP/11dbFTXxGq1LEKZcd3+N7anWOIX/FRiDWBmJpcNduPBEj8s+Q3oZAw==
X-Received: by 2002:a05:6000:1f0c:b0:226:f3f3:9929 with SMTP id bv12-20020a0560001f0c00b00226f3f39929mr5457131wrb.362.1662133872710;
        Fri, 02 Sep 2022 08:51:12 -0700 (PDT)
Received: from blondie ([5.102.239.127])
        by smtp.gmail.com with ESMTPSA id az3-20020a05600c600300b003a6a3595edasm2535328wmb.27.2022.09.02.08.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:51:12 -0700 (PDT)
Date:   Fri, 2 Sep 2022 18:51:09 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Support setting variable-length
 tunnel options
Message-ID: <20220902185109.0bc6ebee@blondie>
In-Reply-To: <20220831113404.78e6f317@blondie>
References: <20220822052152.378622-1-shmulik.ladkani@gmail.com>
        <20220822052152.378622-2-shmulik.ladkani@gmail.com>
        <630488c5d0f99_2ad4d720813@john.notmuch>
        <20220831113404.78e6f317@blondie>
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

> On Tue, 23 Aug 2022 00:59:01 -0700
> John Fastabend <john.fastabend@gmail.com> wrote:
> 
> > > + * long bpf_skb_set_var_tunnel_opt(struct sk_buff *skb, void *opt, u32 size, u32 len)
> > > + *	Description
> > > + *		Set tunnel options metadata for the packet associated to *skb*
> > > + *		to the variable length *len* bytes of option data contained in
> > > + *		the raw buffer *opt* sized *size*.
> > > + *
> > > + *		See also the description of the **bpf_skb_get_tunnel_opt**\ ()
> > > + *		helper for additional information.
> > > + *	Return
> > > + *		0 on success, or a negative error in case of failure.    
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
> 
> Despite the awkwardness of the 'bpf_skb_set_var_tunnel_opt' API (passing
> both constant size *and* dynamic len), it really creates more simple and
> readable ebpf programs.
> 
> WDYT?

John, Daniel, would appreciate your opinion re the prefered BPF API we
add to set var-length tunnel options. See the difference in bpf user
programs based on the 2 suggestions above.

Thanks,
Shmulik
