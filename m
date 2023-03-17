Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89066BF3A7
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCQVN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCQVN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:13:26 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA91262FF9
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 14:13:18 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j9-20020aa79289000000b00625894ca452so3236901pfa.22
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679087598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrCUL/IGk54+SRxEDAGZ4cJXeb0snqO4bHPhQ/dVI4Q=;
        b=PU8vs4E5e6ghVuGp8NM4vO9YnC+Tj+QscxvmGFXINdIujpv1l/0Z3SL08tlzAU4heT
         uSSQUgQ2x1Mp1ykqsLRfhZBO9aShvD6pqe3R3vRjLUmcorcH5RDbwcwjcKjEiTAcbGen
         MImT7AscwjCF5Uw82RPwLkhtJESF2axcTlr8BUIbiIaVJ7Xb6yoNPzHKS6X3vq06x+N2
         sipleHRi/4Vckclg3UVU4tP0JFPSLhjjoMRkWyWoZqjizHz9gm/JedLC1mTLljhI1NIK
         KGYvPVaV0kymAmX756tlvW2AkxN2SbpLE1C6jZeuAaGeC0T8BU+cK6BP9kCVe+TrnlnS
         BJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679087598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrCUL/IGk54+SRxEDAGZ4cJXeb0snqO4bHPhQ/dVI4Q=;
        b=hqPIEXWEtbm5IPGb3QnYIHh+9E7TJbBR7EDThG4kmd8hd3U/S3X6xgwFCk6fnHmq+Q
         pbsJr1lLa6Nh2IkizCFkRtS5+puhpjqLLLI2JdxoX4KMMHVcSisIzr7WsYoOLGCxKINY
         t+5fx3XmQH8VtIz66+0J1/trjmt/eQzCWBuUI37HBwzzbnlozqQ1oRHc+8TdZVk6KBAx
         ciPTjlL9AjFadW8/31veLa6xq9+j4Huu/RSQgOdxJx4jPyYA7cDc8FL55E60BTVuM7cx
         VUtX0YdiwcKzbF/F0vOusJO8hyxEXZ0yGef+MzIgQOTPKkkCsXmPm+lOMDtFCENuf+Ea
         8Nkw==
X-Gm-Message-State: AO0yUKU/BT7+fvrgDkKEAmjzL7T6PIPj42BYTLIXDBXrciEL49HN1xDS
        2zOfUqZ1Bia3UhpIRYJ+SvT3dEA=
X-Google-Smtp-Source: AK7set9AAuLyGkvi/Qt66TYj53e5MBcSr8TF1vXUUvJ2uwZNcWye632kPx7liFKfwrSQNZWTjg3Jl18=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:a3c7:b0:1a0:51f6:a252 with SMTP id
 q7-20020a170902a3c700b001a051f6a252mr3537782plb.3.1679087598192; Fri, 17 Mar
 2023 14:13:18 -0700 (PDT)
Date:   Fri, 17 Mar 2023 14:13:16 -0700
In-Reply-To: <167906361094.2706833.8381428662566265476.stgit@firesoul>
Mime-Version: 1.0
References: <167906343576.2706833.17489167761084071890.stgit@firesoul> <167906361094.2706833.8381428662566265476.stgit@firesoul>
Message-ID: <ZBTX7CBzNk9SaWgx@google.com>
Subject: Re: [PATCH bpf-next V1 4/7] selftests/bpf: xdp_hw_metadata RX hash
 return code info
From:   Stanislav Fomichev <sdf@google.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/17, Jesper Dangaard Brouer wrote:
> When driver developers add XDP-hints kfuncs for RX hash it is
> practical to print the return code in bpf_printk trace pipe log.

> Print hash value as a hex value, both AF_XDP userspace and bpf_prog,
> as this makes it easier to spot poor quality hashes.

> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

(with a small suggestion below, maybe can do separately?)

> ---
>   .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |    9 ++++++---
>   tools/testing/selftests/bpf/xdp_hw_metadata.c      |    5 ++++-
>   2 files changed, 10 insertions(+), 4 deletions(-)

> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c  
> b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index f2a3b70a9882..f2278ca2ad03 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -76,10 +76,13 @@ int rx(struct xdp_md *ctx)
>   	} else
>   		meta->rx_timestamp = 0; /* Used by AF_XDP as not avail signal */

> -	if (!bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash))
> -		bpf_printk("populated rx_hash with %u", meta->rx_hash);
> -	else
> +	ret = bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash);
> +	if (ret >= 0) {
> +		bpf_printk("populated rx_hash with 0x%08X", meta->rx_hash);
> +	} else {
> +		bpf_printk("rx_hash not-avail errno:%d", ret);
>   		meta->rx_hash = 0; /* Used by AF_XDP as not avail signal */
> +	}

>   	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
>   }
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c  
> b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 400bfe19abfe..f3ec07ccdc95 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -3,6 +3,9 @@
>   /* Reference program for verifying XDP metadata on real HW. Functional  
> test
>    * only, doesn't test the performance.
>    *

[..]

> + * BPF-prog bpf_printk info outout can be access via
> + * /sys/kernel/debug/tracing/trace_pipe

Maybe we should just dump the contents of
/sys/kernel/debug/tracing/trace for every poll cycle?

We can also maybe enable tracing in this program transparently?
I usually forget 'echo 1 >
/sys/kernel/debug/tracing/events/bpf_trace/bpf_trace_printk/enable'
myself :-)

> + *
>    * RX:
>    * - UDP 9091 packets are diverted into AF_XDP
>    * - Metadata verified:
> @@ -156,7 +159,7 @@ static void verify_xdp_metadata(void *data, clockid_t  
> clock_id)

>   	meta = data - sizeof(*meta);

> -	printf("rx_hash: %u\n", meta->rx_hash);
> +	printf("rx_hash: 0x%08X\n", meta->rx_hash);
>   	printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
>   	       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
>   	if (meta->rx_timestamp) {


