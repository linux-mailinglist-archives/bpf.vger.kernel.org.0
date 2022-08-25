Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E97E5A16BB
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiHYQdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 12:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiHYQdo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 12:33:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827F5B81F5
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 09:33:43 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x15so19409177pfp.4
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=KYx6gX9g7Fbj1Or+g/WAHahx+nCBrW5usgQlZDdwngs=;
        b=bVobJguaLYbipHkHRXrUp1HQCkXRQl9+tqfsKo9o9MFOy+h3lmtX0mev9H5xgHmaR9
         ulCZyzVnA9greH5F0Zo1/aOoS+wdnAGa9YtplwYQZdJR2Ky8vr0TouHeTE9d3AFfff3B
         r6QmpGk+PzIBrryNX0ZGuEbXccXIwayM/ea3MoxuUAfIf32oez8p+ZUsbDfmDA1+nIEv
         1H2CTiofs7qa9Qn2Or3lCV8Hgzii0EK2YqzPb73Mv+rkvu0VIyszrH2de02D6eC6LQAW
         pvdDeaOe8XEF/poGoi3QMiHOYCXGbsY2qHmWmUfJhhJWbwOCvpbIyrY+OmaNefx5X947
         ixrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=KYx6gX9g7Fbj1Or+g/WAHahx+nCBrW5usgQlZDdwngs=;
        b=Db75b6CLoBxLQlEy0d4xra/bKGhwqOmnaWOdCVAkFlF92Q/+pRt66uxOWrZxykZTxU
         yJUvhZjkA6siJZXk1TKRI2iGYAvRlDbG/5B0CblJhgbac0+ls4//8wk2g7XGSb6qwp3p
         fhiUEIZip5ov5m1bX5VJ14l0knpxbshFCqwOAyUkmZ5cWJLJkmuR/VTTRqGe2qwCt+mD
         UL/0reO1+Ykzh3Wt6GroY3ob0ymtbsZDMbHcRAo7KEJhSrOHhrcaVS5OoJPsKt1j7jRn
         xhzXk+gNTwSWiHK3WJ8mPHRLFPNr7tjj00ymnXKcG7zt2lEPA13ifNH/IWe0SfLj0pip
         x0gw==
X-Gm-Message-State: ACgBeo2juBzr262drXuzQ+vOCbhoopMw+SHUCvFJV6dGUixVzb6HVoBt
        aH8ax5pnt0FJ136pVGCcNF3Lr5nilQ4=
X-Google-Smtp-Source: AA6agR6LYA6TaCOvZfffrC8fb/IND8+RVBqaFW7tANKGtp3kYs2DejLtIgjgv6tVFAhNiZeZIt6qtA==
X-Received: by 2002:a63:ef49:0:b0:42b:40b5:9bc4 with SMTP id c9-20020a63ef49000000b0042b40b59bc4mr3934125pgk.266.1661445222636;
        Thu, 25 Aug 2022 09:33:42 -0700 (PDT)
Received: from localhost ([98.97.36.33])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b0016bf803341asm11598523plg.146.2022.08.25.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:33:41 -0700 (PDT)
Date:   Thu, 25 Aug 2022 09:33:39 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Shmulik Ladkani <shmulik@metanetworks.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Message-ID: <6307a4631c9a5_12460b20842@john.notmuch>
In-Reply-To: <20220824044117.137658-5-shmulik.ladkani@gmail.com>
References: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
 <20220824044117.137658-5-shmulik.ladkani@gmail.com>
Subject: RE: [PATCH v5 bpf-next 4/4] selftests/bpf: Add geneve with
 bpf_skb_set_tunnel_opt_dynptr test-case to test_progs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Shmulik Ladkani wrote:
> Add geneve test to test_tunnel. The test setup and scheme resembles the
> existing vxlan test.
> 
> The test also checks variable length tunnel option assignment using
> bpf_skb_set_tunnel_opt_dynptr.
> 
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/test_tunnel.c    | 108 ++++++++++++++
>  .../selftests/bpf/progs/test_tunnel_kern.c    | 136 ++++++++++++++++++
>  2 files changed, 244 insertions(+)

Overall lgtm couple missing ret codes.

[...]

> +
> +SEC("tc")
> +int geneve_set_tunnel_src(struct __sk_buff *skb)
> +{
> +	int ret;
> +	struct bpf_tunnel_key key;
> +	__u32 index = 0;
> +	__u32 *local_ip = NULL;
> +
> +	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
> +	if (!local_ip) {
> +		log_err(ret);

log_err(-1)?

> +		return TC_ACT_SHOT;
> +	}
> +
> +	__builtin_memset(&key, 0x0, sizeof(key));
> +	key.local_ipv4 = *local_ip;
> +	key.remote_ipv4 = 0xac100164; /* 172.16.1.100 */
> +	key.tunnel_id = 2;
> +	key.tunnel_tos = 0;
> +	key.tunnel_ttl = 64;
> +
> +	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
> +				     BPF_F_ZERO_CSUM_TX);
> +	if (ret < 0) {
> +		log_err(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	return TC_ACT_OK;
> +}
> +
> +SEC("tc")
> +int geneve_get_tunnel_src(struct __sk_buff *skb)
> +{
> +	int ret;
> +	struct bpf_tunnel_key key;
> +	struct tun_opts_raw opts;
> +	int expected_opts_len;
> +	__u32 index = 0;
> +	__u32 *local_ip = NULL;
> +
> +	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
> +	if (!local_ip) {
> +		log_err(ret);

log_err(-1)

> +		return TC_ACT_SHOT;
> +	}
> +
> +	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
> +	if (ret < 0) {
> +		log_err(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	ret = bpf_skb_get_tunnel_opt(skb, &opts, sizeof(opts));
> +	if (ret < 0) {
> +		log_err(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	expected_opts_len = (skb->len % sizeof(opts)) & ~(sizeof(__u32) - 1);
> +	if (key.local_ipv4 != *local_ip || ret != expected_opts_len) {
> +		bpf_printk("geneve key %d local ip 0x%x remote ip 0x%x opts_len %d\n",
> +			   key.tunnel_id, key.local_ipv4,
> +			   key.remote_ipv4, ret);

In general I don't really like the printks. But ok.

> +		bpf_printk("local_ip 0x%x\n", *local_ip);
> +		log_err(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	return TC_ACT_OK;
> +}
> +
>  SEC("tc")
>  int vxlan_set_tunnel_dst(struct __sk_buff *skb)
>  {
> -- 
> 2.37.2
> 


