Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD77E629ED0
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbiKOQT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbiKOQTN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:19:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1472E2FFD4
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668529066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dDNdu3Y9fr5FOdr8MTcDO+pL9js6k+/irqVmUcE/IG0=;
        b=Xw+vMsLqLP9L7542ruzEvg/e4oo6xevorFsm9LwpVaYmXo25l7FJUDvuMqN+2KwgPD2tIb
        qCO1KW8LTsT2imo6rc45KsbMTRvp7hDU4XS+0QE7h4vDRNHYsI2JeEIpuo49+ChWK9bNjM
        BbWHlVQXhvpwW8RGZlYStvpYOQpQYTg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-S_v66jvDN-KaeWuJJzWpGg-1; Tue, 15 Nov 2022 11:17:45 -0500
X-MC-Unique: S_v66jvDN-KaeWuJJzWpGg-1
Received: by mail-ej1-f70.google.com with SMTP id sg37-20020a170907a42500b007adaedb5ba2so7593616ejc.18
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDNdu3Y9fr5FOdr8MTcDO+pL9js6k+/irqVmUcE/IG0=;
        b=4DWL1udoWjFBoXn/juEWmxuP6C9O/RYZ2U/B8Be7ipjY1pH85lZG4mK+zSIWDcwK19
         BAL4SE9ltHwjtUQ1CJi1NUxM3mGHHC6LCd1AQf3cmdlOuRkbs0krJF72c3Pv2Lm+9nY/
         KdW7t45BzX8fmcUBSirxtwsirOay97+WapN8Fwc7/+CvDDONgM9OzuqSljlR7BFPR/RD
         d+sF3ffWay2s3+6wcvlP/vkUnUotu4q45YstPUqR/CPGowBnSR0oNHsYlPWO8cRHTV5O
         kQW75GwErjIyk8foiSP2VLulQ1axlWM/FU2elpXNecTwtHarSHcBLWoWQqwDumYGH1Zs
         ju8A==
X-Gm-Message-State: ANoB5plzjVCOkTznI7hyHX8rWxx7zLOtExvYcVZcIzIcOQGSyjyBMQ9e
        PkX+RKYlSJ4+WSJCQNwPVNoqDMPXRsHlbEk1eTFLy/QK7TJKUydbrNSfsjsjZIT9AjGOsh5fH1U
        u35wfz++42z7l
X-Received: by 2002:a17:906:4dd6:b0:7ad:a030:487e with SMTP id f22-20020a1709064dd600b007ada030487emr14892564ejw.508.1668529063838;
        Tue, 15 Nov 2022 08:17:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4cIst8+Ig0NZcClVeIsQkF2jZkdjAmTbe5xwQCO1YruIKHoWA/N3/mXPzzpNeqf2RQNQE7OA==
X-Received: by 2002:a17:906:4dd6:b0:7ad:a030:487e with SMTP id f22-20020a1709064dd600b007ada030487emr14892527ejw.508.1668529063454;
        Tue, 15 Nov 2022 08:17:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7cfc7000000b004610899742asm6234653edy.13.2022.11.15.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:17:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4A90F7A6CDA; Tue, 15 Nov 2022 17:17:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] [PATCH bpf-next 05/11] veth: Support rx timestamp
 metadata for xdp
In-Reply-To: <20221115030210.3159213-6-sdf@google.com>
References: <20221115030210.3159213-1-sdf@google.com>
 <20221115030210.3159213-6-sdf@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 15 Nov 2022 17:17:42 +0100
Message-ID: <87h6z0i449.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> The goal is to enable end-to-end testing of the metadata
> for AF_XDP. Current rx_timestamp kfunc returns current
> time which should be enough to exercise this new functionality.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Anatoly Burakov <anatoly.burakov@intel.com>
> Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> Cc: Maryam Tahhan <mtahhan@redhat.com>
> Cc: xdp-hints@xdp-project.net
> Cc: netdev@vger.kernel.org
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  drivers/net/veth.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 2a4592780141..c626580a2294 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -25,6 +25,7 @@
>  #include <linux/filter.h>
>  #include <linux/ptr_ring.h>
>  #include <linux/bpf_trace.h>
> +#include <linux/bpf_patch.h>
>  #include <linux/net_tstamp.h>
>  
>  #define DRV_NAME	"veth"
> @@ -1659,6 +1660,18 @@ static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  	}
>  }
>  
> +static void veth_unroll_kfunc(const struct bpf_prog *prog, u32 func_id,
> +			      struct bpf_patch *patch)
> +{
> +	if (func_id == xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP_SUPPORTED)) {
> +		/* return true; */
> +		bpf_patch_append(patch, BPF_MOV64_IMM(BPF_REG_0, 1));
> +	} else if (func_id == xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP)) {
> +		/* return ktime_get_mono_fast_ns(); */
> +		bpf_patch_append(patch, BPF_EMIT_CALL(ktime_get_mono_fast_ns));
> +	}
> +}

So these look reasonable enough, but would be good to see some examples
of kfunc implementations that don't just BPF_CALL to a kernel function
(with those helper wrappers we were discussing before).

-Toke

