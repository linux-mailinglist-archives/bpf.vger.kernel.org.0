Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0252F66C7C7
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjAPQef (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 11:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjAPQeE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 11:34:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3068C2C658
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 08:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673886074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0Ks/O5MxLsx7dVOuXdI3SuIbVqOXisFzieVgmhogRI=;
        b=Q8Xu3hxmJr5AK7qHlUndX0Kdzsrmwlv1YvZBB4IDcfi8nzp8qAePz9qrgeWgfZkZyIm6yT
        i3YL1QweQrtZqW3najPW4klIRgbkiJlxFXODP/liDPwpiEnfOr3LbmS7eE6rkIH5mk2L8n
        J5nQEkK7nh9ZqTKaDJwJvCLT1NeDG4Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-7-qpwQlbDDMDK1BfG4U3m93g-1; Mon, 16 Jan 2023 11:21:13 -0500
X-MC-Unique: qpwQlbDDMDK1BfG4U3m93g-1
Received: by mail-ed1-f72.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so19657048edz.21
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 08:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0Ks/O5MxLsx7dVOuXdI3SuIbVqOXisFzieVgmhogRI=;
        b=Xd/rrkGJMoGHBzpYpasfjD5fcBi0o69+rgPFVSZn8EhinRzYtmPQUHfpEiP04hH1Yt
         DkmxuR3VmUyrBGbQHTKIWrWo3UCaVA0tfwuc021HpgSeP8IhnWMcXrYkFiRRe/GQDjzX
         t91rvi5aJ67M6h5nber7REGCQHib00b6Jykz/iTPz2eBv3nR4+fkZI+dC+6FRjKX0Hfo
         9TEVtdQ9aVG5MWkKYFTD/VZSYksUwFqleLULMFUs1F2C7HljgkuRyJxFjI1KQhHK+/ue
         I3sey+XTTu9LyeZ6z2c82at3DyMh8B18ry80zMUGx4dFEXE6OqttmJRbBp8MoLPoFo36
         zP2Q==
X-Gm-Message-State: AFqh2krkuif1cO0lS1Nf/tQAqDCpsVFBH2/m3tThnE6QBvOkDD9tXoqp
        utunQ4eDpVV9v/Aa+U2xuQ36t3+edhf1WRd9XYN8v4krFT8MKBC2acBEewvoeFHeXDnX1nGSDM5
        ktyNKCqDAVtBL
X-Received: by 2002:a17:907:8744:b0:870:c218:c52b with SMTP id qo4-20020a170907874400b00870c218c52bmr4802611ejc.49.1673886071849;
        Mon, 16 Jan 2023 08:21:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXusJW1wpXGKd2RfJI0OBvJR7rxC9sghj+qTSy+I00SQjty2GnseOf5FnJMCBz0JodKWsq91TA==
X-Received: by 2002:a17:907:8744:b0:870:c218:c52b with SMTP id qo4-20020a170907874400b00870c218c52bmr4802581ejc.49.1673886071663;
        Mon, 16 Jan 2023 08:21:11 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id lb6-20020a170907784600b007ad69e9d34dsm12015790ejc.54.2023.01.16.08.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:21:11 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <a5ce7ac4-7901-6146-2c2a-5b4958c14e11@redhat.com>
Date:   Mon, 16 Jan 2023 17:21:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 10/17] veth: Support RX XDP metadata
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230112003230.3779451-1-sdf@google.com>
 <20230112003230.3779451-11-sdf@google.com>
In-Reply-To: <20230112003230.3779451-11-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/01/2023 01.32, Stanislav Fomichev wrote:
> The goal is to enable end-to-end testing of the metadata for AF_XDP.

For me the goal with veth goes beyond *testing*.

This patch ignores the xdp_frame case.  I'm not blocking this patch, but
I'm saying we need to make sure there is a way forward for accessing
XDP-hints when handling redirected xdp_frame's.

I have two use-cases we should cover (as future work).

(#1) We have customers that want to redirect from physical NIC hardware
into containers, and then have the veth XDP-prog (selectively) redirect
into an AF_XDP socket (when matching fastpath packets).  Here they
(minimum) want access to the XDP hint info on HW checksum.

(#2) Both veth and cpumap can create SKBs based on xdp_frame's.  Here it
is essential to get HW checksum and HW hash when creating these SKBs
(else netstack have to do expensive csum calc and parsing in
flow-dissector).

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
>   drivers/net/veth.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 70f50602287a..ba3e05832843 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -118,6 +118,7 @@ static struct {
>   
>   struct veth_xdp_buff {
>   	struct xdp_buff xdp;
> +	struct sk_buff *skb;
>   };
>   
>   static int veth_get_link_ksettings(struct net_device *dev,
> @@ -602,6 +603,7 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
>   
>   		xdp_convert_frame_to_buff(frame, xdp);
>   		xdp->rxq = &rq->xdp_rxq;
> +		vxbuf.skb = NULL;
>   
>   		act = bpf_prog_run_xdp(xdp_prog, xdp);
>   
> @@ -823,6 +825,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>   	__skb_push(skb, skb->data - skb_mac_header(skb));
>   	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
>   		goto drop;
> +	vxbuf.skb = skb;
>   
>   	orig_data = xdp->data;
>   	orig_data_end = xdp->data_end;
> @@ -1602,6 +1605,28 @@ static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>   	}
>   }
>   
> +static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
> +{
> +	struct veth_xdp_buff *_ctx = (void *)ctx;
> +
> +	if (!_ctx->skb)
> +		return -EOPNOTSUPP;
> +
> +	*timestamp = skb_hwtstamps(_ctx->skb)->hwtstamp;

The SKB stores this skb_hwtstamps() in skb_shared_info memory area.
This memory area is actually also available to xdp_frames.  Thus, we
could store the HW rx_timestamp in same location for redirected
xdp_frames.  This could make code path sharing possible between SKB vs
xdp_frame in veth.

This would also make it fast to "transfer" HW rx_timestamp when creating
an SKB from an xdp_frame, as data is already written in the correct place.

Performance wise the down-side is that skb_shared_info memory area is in
a separate cacheline.  Thus, when no HW rx_timestamp is available, then
it is very expensive for a veth XDP bpf-prog to access this, just to get
a zero back.  Having an xdp_frame->flags bit that knows if HW
rx_timestamp have been stored, can mitigate this.


> +	return 0;
> +}
> +
> +static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
> +{
> +	struct veth_xdp_buff *_ctx = (void *)ctx;
> +
> +	if (!_ctx->skb)
> +		return -EOPNOTSUPP;

For xdp_frame case, I'm considering simply storing the u32 RX-hash in
struct xdp_frame.  This makes it easy to extract for xdp_frame to SKB
create use-case.

As have been mentioned before, the SKB also requires knowing the RSS
hash-type.  This HW hash-type actually contains a lot of information,
that today is lost when reduced to the SKB hash-type.  Due to
standardization from Microsoft, most HW provide info on (L3) IPv4 or
IPv6, and on (L4) TCP or UDP (and often SCTP).  Often hardware
descriptor also provide info on the header length.  Future work in this
area is exciting as we can speedup parsing of packets in XDP, if we can
get are more detailed HW info on hash "packet-type".

> +
> +	*hash = skb_get_hash(_ctx->skb); > +	return 0;
> +}
> +

--Jesper

