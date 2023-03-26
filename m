Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AB66C9276
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 06:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjCZE74 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 00:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCZE7z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 00:59:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A048E83FB
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 21:59:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso5566311pjb.2
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 21:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679806794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmCR7wvoBI76X2bv8+FRrtcMQa8rH3PZ1ENSx+LcaUQ=;
        b=Fxadq7XIPbWWqhF0geupqdFi8wnvfL3L8e//qyo5Y3tqBE5sdClJ1DHTSoSuNqkZ4/
         PdTHvuUSoOUlHUGR2093VvXWnbi7tUqnVeioR5Fl7K5uDVKrQhQCsA7DMji85yeDz0EI
         G5mQMystYIemvhsBkKJILYQ4wOtP3PNsC+4xM62GjeuOiPeGHNM0afoZbh/vjQ/BQz0a
         zgMM1WcGXHHCNPY3axcEiajSdnIOo3MUAw5b9ZyKnOMIkNP18Eu/JdlGsP3f9tC4A785
         nNFd1bRUlC6d2L50BX9Ht38R1XnPGLl+ah1nBBDFL1CWcqFaQ0eqt77CJ3CO5LUmE9hq
         iBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679806794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmCR7wvoBI76X2bv8+FRrtcMQa8rH3PZ1ENSx+LcaUQ=;
        b=qTJ9yNPGML2zuAWWrZVlkqJ7CVx2rBIIgvw9Xu3HX/RQJTcLs+zph9C6PCxKPi8RwK
         dmNC6fKvOokqIEujVNnxNPbOqjt/4RGsNFPDTfWbhdVIiu5FElCJH/6U+/q7nd1cME4I
         ykTaInFaoJGONYpL4bWYnn4lE0v47hpZnydLDohUzCiEYmhHG82ju2gWfgcG4E1tNhqB
         OLSLj6/Csf2SdYEn+yGsOotQPU2x4Les2Rlx9PHnmiIzBcHT4w41XJkeXv+z9YMl3yds
         ltqRIMuAeVO49frux/BLlbuhl/CaY+9I2j+TfDnbx79yWichy5HMcBrQO8hyCL9aZqja
         w4AQ==
X-Gm-Message-State: AO0yUKUtGlYuhZhu0czcMhZlSgKmDT5vK0R6VmH3X9ENDej1Lq5Cwdly
        ouYd0DbWn6i92biKAbQVyHBIMGm/SOh2DCP+
X-Google-Smtp-Source: AK7set9xtzvRd5kkc08AxqWgKgaSp/cl0CymBwqQgNCSpdwseOxSmbnZ/IaD/tEoFUu5nc+VEil4KA==
X-Received: by 2002:a05:6a20:7b29:b0:dc:a14e:d9bf with SMTP id s41-20020a056a207b2900b000dca14ed9bfmr6403155pzh.43.1679806793832;
        Sat, 25 Mar 2023 21:59:53 -0700 (PDT)
Received: from MacBook-Pro-6.local (i223-217-15-101.s41.a014.ap.plala.or.jp. [223.217.15.101])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b0062bae1101c5sm3125716pff.202.2023.03.25.21.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 21:59:53 -0700 (PDT)
Date:   Sat, 25 Mar 2023 21:59:44 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 3/3] veristat: guess and substitue underlying
 program type for freplace (EXT) progs
Message-ID: <20230326045944.rjayv2d2xbdlz5m2@MacBook-Pro-6.local>
References: <20230324232745.3959567-1-andrii@kernel.org>
 <20230324232745.3959567-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324232745.3959567-4-andrii@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 24, 2023 at 04:27:45PM -0700, Andrii Nakryiko wrote:
> +static int guess_prog_type_by_ctx_name(const char *ctx_name,
> +				       enum bpf_prog_type *prog_type,
> +				       enum bpf_attach_type *attach_type)
> +{
> +	/* We need to guess program type based on its declared context type.
> +	 * This guess can't be perfect as many different program types might
> +	 * share the same context type.  So we can only hope to reasonably
> +	 * well guess this and get lucky.
> +	 *
> +	 * Just in case, we support both UAPI-side type names and
> +	 * kernel-internal names.
> +	 */
> +	static struct {
> +		const char *uapi_name;
> +		const char *kern_name;
> +		enum bpf_prog_type prog_type;
> +		enum bpf_attach_type attach_type;
> +	} ctx_map[] = {
> +		/* __sk_buff is most ambiguous, for now we assume cgroup_skb */
> +		{ "__sk_buff", "sk_buff", BPF_PROG_TYPE_CGROUP_SKB, BPF_CGROUP_INET_INGRESS },
> +		{ "bpf_sock", "sock", BPF_PROG_TYPE_CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND },
> +		{ "bpf_sock_addr", "bpf_sock_addr_kern",  BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_BIND },
> +		{ "bpf_sock_ops", "bpf_sock_ops_kern", BPF_PROG_TYPE_SOCK_OPS, BPF_CGROUP_SOCK_OPS },
> +		{ "sk_msg_md", "sk_msg", BPF_PROG_TYPE_SK_MSG, BPF_SK_MSG_VERDICT },
> +		{ "bpf_cgroup_dev_ctx", "bpf_cgroup_dev_ctx", BPF_PROG_TYPE_CGROUP_DEVICE, BPF_CGROUP_DEVICE },
> +		{ "bpf_sysctl", "bpf_sysctl_kern", BPF_PROG_TYPE_CGROUP_SYSCTL, BPF_CGROUP_SYSCTL },
> +		{ "bpf_sockopt", "bpf_sockopt_kern", BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT },
> +		{ "sk_reuseport_md", "sk_reuseport_kern", BPF_PROG_TYPE_SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE },
> +		{ "bpf_sk_lookup", "bpf_sk_lookup_kern", BPF_PROG_TYPE_SK_LOOKUP, BPF_SK_LOOKUP },
> +		{ "xdp_md", "xdp_buff", BPF_PROG_TYPE_XDP, BPF_XDP },
> +		/* tracing types with no expected attach type */
> +		{ "bpf_user_pt_regs_t", "pt_regs", BPF_PROG_TYPE_KPROBE },
> +		{ "bpf_perf_event_data", "bpf_perf_event_data_kern", BPF_PROG_TYPE_PERF_EVENT },
> +		{ "bpf_raw_tracepoint_args", NULL, BPF_PROG_TYPE_RAW_TRACEPOINT },
> +	};
> +	int i;
> +
> +	if (!ctx_name)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(ctx_map); i++) {
> +		if (strcmp(ctx_map[i].uapi_name, ctx_name) == 0 ||
> +		    (!ctx_map[i].kern_name || strcmp(ctx_map[i].kern_name, ctx_name) == 0)) {

I'm struggling to understand above A || (B || C) logic.
() are redundant?

> +			*prog_type = ctx_map[i].prog_type;
> +			*attach_type = ctx_map[i].attach_type;
> +			return 0;
> +		}
> +	}
> +
> +	return -ESRCH;

This will never be hit, since "bpf_raw_tracepoint_args", NULL is last and
it will always succeed.

The idea is to always succeed in guessing and default to raw_tp ?
... and there should be only one entry with kern_name == NULL...
But it's not mentioned anywhere in the comments.
A weird way to implement a default.
I'm definitely missing something.
