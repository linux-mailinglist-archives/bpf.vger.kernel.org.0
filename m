Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DC7622A55
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 12:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiKILWo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 06:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKILWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 06:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF5BD7
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 03:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667992907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iu6WVQzYd6QVJ2aRddjHWcCe6Wgq/3xvvgm9HbBXmlM=;
        b=ZIj01nKdDnt7pV4RYc9xtnRoCAJOWOyS5Gm+ImKGrZjTUH32kmzu6KiOmOy03HRVqDVtTm
        v4pbEq2fSs8ZAEPMxIO5WgcbAVjcq/Ou/+7ljgq0+1bQk3qbvId4ksSep9Ga3plqhsH3LM
        iMhuwCnTMg6WFpaldT1g9E6Xr6yzano=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-0rzyqaxiOn2Z3nz2huU5lw-1; Wed, 09 Nov 2022 06:21:46 -0500
X-MC-Unique: 0rzyqaxiOn2Z3nz2huU5lw-1
Received: by mail-ed1-f69.google.com with SMTP id y20-20020a056402271400b004630f3a32c3so12521131edd.15
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 03:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iu6WVQzYd6QVJ2aRddjHWcCe6Wgq/3xvvgm9HbBXmlM=;
        b=f3NNDC7DZU+ORuiwrfd+nTRb5libPTX2U33/tV01Psi6mf3KeBWRQyTFxWdZfE3P4v
         GFa1XaEFUZyy+PYImUymBaaJnlpbwDcFaICPKQj+DKDIyfAGcTLdcUL0bxIgZ38sG9ew
         AacYzT9lrApdxm5HR3NrLrctaQbkHErokrr67ihFugAaV0h3VIsR5PTBwYy8rHQqvymF
         a0MU8bie48vVmPDobWJYahtLqVaeQ09EhC2d5Q7eS2fHGwMmVNQ/+2tVvZl6hSB2rNsO
         d9wVjcLF1soPyRD+h/opzsLx2IxIeqQAw0q0LvfMCesaNDkPpTy16g1qv252fFzMTPlK
         9kKA==
X-Gm-Message-State: ANoB5pmleVTBFmPfyag/nFU4N9lrJ06lX8ahl8VRaHiJlDe8RUtByn+S
        m94atzad+mbjZCNHJvNbepD5dnTJwPBqEB1sh0nbrzuFOcG78QAbSTCUN3Zl+GakMWNMNVjPcIb
        F9JVJl29CwSTW
X-Received: by 2002:a17:907:778a:b0:7ae:743c:61c1 with SMTP id ky10-20020a170907778a00b007ae743c61c1mr10018340ejc.511.1667992904103;
        Wed, 09 Nov 2022 03:21:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6TQe48yQLkJdpv+TaqjpnyJXWIfV1jTzYt4LWLlnCMU7wmlEFns3k5hY9omtckGMfN0SMwrQ==
X-Received: by 2002:a17:907:778a:b0:7ae:743c:61c1 with SMTP id ky10-20020a170907778a00b007ae743c61c1mr10018283ejc.511.1667992903225;
        Wed, 09 Nov 2022 03:21:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id qp18-20020a170907207200b007838e332d78sm5687061ejb.128.2022.11.09.03.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:21:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4C42678250B; Wed,  9 Nov 2022 12:21:42 +0100 (CET)
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
Subject: Re: [xdp-hints] [RFC bpf-next v2 04/14] veth: Support rx timestamp
 metadata for xdp
In-Reply-To: <20221104032532.1615099-5-sdf@google.com>
References: <20221104032532.1615099-1-sdf@google.com>
 <20221104032532.1615099-5-sdf@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 09 Nov 2022 12:21:42 +0100
Message-ID: <87iljoz83d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> xskxceiver conveniently setups up veth pairs so it seems logical
> to use veth as an example for some of the metadata handling.
>
> We timestamp skb right when we "receive" it, store its
> pointer in new veth_xdp_buff wrapper and generate BPF bytecode to
> reach it from the BPF program.
>
> This largely follows the idea of "store some queue context in
> the xdp_buff/xdp_frame so the metadata can be reached out
> from the BPF program".
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
>  drivers/net/veth.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 917ba57453c1..0e629ceb087b 100644
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
> @@ -118,6 +119,7 @@ static struct {
>  
>  struct veth_xdp_buff {
>  	struct xdp_buff xdp;
> +	struct sk_buff *skb;
>  };
>  
>  static int veth_get_link_ksettings(struct net_device *dev,
> @@ -602,6 +604,7 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
>  
>  		xdp_convert_frame_to_buff(frame, xdp);
>  		xdp->rxq = &rq->xdp_rxq;
> +		vxbuf.skb = NULL;
>  
>  		act = bpf_prog_run_xdp(xdp_prog, xdp);
>  
> @@ -826,6 +829,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>  
>  	orig_data = xdp->data;
>  	orig_data_end = xdp->data_end;
> +	vxbuf.skb = skb;
>  
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);
>  
> @@ -942,6 +946,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct sk_buff *skb = ptr;
>  
>  			stats->xdp_bytes += skb->len;
> +			__net_timestamp(skb);
>  			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
>  			if (skb) {
>  				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
> @@ -1665,6 +1670,31 @@ static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
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
> +		bpf_patch_append(patch,
> +			/* r5 = ((struct veth_xdp_buff *)r1)->skb; */
> +			BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_1,
> +				    offsetof(struct veth_xdp_buff, skb)),
> +			/* if (r5 == NULL) { */
> +			BPF_JMP_IMM(BPF_JNE, BPF_REG_5, 0, 2),
> +			/*	return 0; */
> +			BPF_MOV64_IMM(BPF_REG_0, 0),
> +			BPF_JMP_A(1),
> +			/* } else { */
> +			/*	return ((struct sk_buff *)r5)->tstamp; */
> +			BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_5,
> +				    offsetof(struct sk_buff, tstamp)),
> +			/* } */

I don't think it's realistic to expect driver developers to write this
level of BPF instructions for everything. With the 'patch' thing it
should be feasible to write some helpers that driver developers can use,
right? E.g., this one could be:

bpf_read_context_member_u64(size_t ctx_offset, size_t member_offset)

called as:

bpf_read_context_member_u64(offsetof(struct veth_xdp_buff, skb), offsetof(struct sk_buff, tstamp));

or with some macro trickery we could even hide the offsetof so you just
pass in types and member names?

-Toke

