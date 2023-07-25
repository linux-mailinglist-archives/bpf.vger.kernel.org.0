Return-Path: <bpf+bounces-5869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DDE762358
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03360281A3D
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 20:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA19B26B61;
	Tue, 25 Jul 2023 20:31:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B851263B1
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 20:31:04 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A499C1
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 13:31:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-584375eacacso8451197b3.0
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690317060; x=1690921860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eC/dy/DsRuqHBiBsNtNWiJUFBceHNUdHIHxVhKEBgUk=;
        b=kSUUZlzE4FvqWwtJwJeMjbzpTx8Owoe0t4uYGtV8QNeG6UtH3Xm/72JvcZlRWiN1vy
         BSHRTERsTsh8ELKePk42T879pOo1eRwvAi+FV5jxvJtKu+H/SE9IU0AHKEdqHqkkIQFz
         y0A+duGwMiSbQvuCtgfpqaGibEvhUFUsYBdpAfpIDvQhBBnEOqYhtprmB8N9R94XDei5
         V/sSS6CBLvVzQS/jXq879y3FI9WtnG98/zCeCnEwFVOMRo0+N+tajB26KhjPQ3ky9sZj
         UdHH3TfdZ7b+S8eTImGpUOm2EkeYWwi7xS+pJh6czH1Ha9h0ZpQ8CkenEPEmprLD60L6
         DCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317060; x=1690921860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eC/dy/DsRuqHBiBsNtNWiJUFBceHNUdHIHxVhKEBgUk=;
        b=VZP4k2CiI/6spbjDzPYgp12mdhPdLaisOIH2k9A6LvBtMInPVETgFJQrr2YedX8Bl7
         r2pqY3N9hmlEcjSkk7uzp4UWDQZ7u2BlRM4rRjogyE4AwCCCeTi53KNip89LZClnZCHf
         7IGa/fsFEiBd8KgXDbtwp9kOtQD0FtY08imv0NCus8XGdG7w1ApaFxMmeZRawAjmxGSP
         jgBWzIeSx7Naq1foo/7k/2Qo8gulHiL1qlqh8dndEgMZKupP2aCk9p2kRw6zqx+4be/R
         PyB9YxFa2Lyqw2m4KxbRfmEIOcYAtWaPfKHsNIurbk/OmHcw9DyuFjAV3WMgqEIpo3Xu
         L4hA==
X-Gm-Message-State: ABy/qLbzVEc9eCrRx1Lod2SCN0SjIuT+nk8NIpmD2xyV5ITufYWpqsfv
	cLjqENSofOlDCU2feygHr5kYDCg=
X-Google-Smtp-Source: APBJJlFbG5nFEEi2H4pwfaVfH/DKTIxAOYLxCgQ0gs6WLs4hQzL1SDyXEJi1sb6g7sI/m1Q0Xe912uY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ad0e:0:b0:576:cd91:b888 with SMTP id
 l14-20020a81ad0e000000b00576cd91b888mr2828ywh.0.1690317060484; Tue, 25 Jul
 2023 13:31:00 -0700 (PDT)
Date: Tue, 25 Jul 2023 13:30:58 -0700
In-Reply-To: <ZMAiYibjYzVTBjEF@corigine.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com> <20230724235957.1953861-3-sdf@google.com>
 <ZMAiYibjYzVTBjEF@corigine.com>
Message-ID: <ZMAxAmg187DgPCAr@google.com>
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
From: Stanislav Fomichev <sdf@google.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/25, Simon Horman wrote:
> On Mon, Jul 24, 2023 at 04:59:51PM -0700, Stanislav Fomichev wrote:
> 
> ...
> 
> Hi Stan,
> 
> > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > index bf71698a1e82..cf1e11c76339 100644
> > --- a/include/uapi/linux/netdev.h
> > +++ b/include/uapi/linux/netdev.h
> > @@ -37,11 +37,26 @@ enum netdev_xdp_act {
> >  	NETDEV_XDP_ACT_MASK = 127,
> >  };
> >  
> > +/**
> > + * enum netdev_xsk_flags
> > + * @NETDEV_XSK_FLAGS_TX_TIMESTAMP: HW timestamping egress packets is supported
> > + *   by the driver.
> > + * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
> > + *   driver.
> > + */
> > +enum netdev_xsk_flags {
> > +	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
> > +	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
> > +
> 
> I know that it isn't the practice in this file.
> but adding the following makes kernel-doc happier
> about NETDEV_XSK_FLAGS_MASK not being documented.
> 
> 	/* private: */

This is autogenerated file :-( But I guess I can try to extend ynl
scripts to put this comment before the mask. Let me look into that...
 
 
> > +	NETDEV_XSK_FLAGS_MASK = 3,
> > +};
> > +
> >  enum {
> >  	NETDEV_A_DEV_IFINDEX = 1,
> >  	NETDEV_A_DEV_PAD,
> >  	NETDEV_A_DEV_XDP_FEATURES,
> >  	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
> > +	NETDEV_A_DEV_XSK_FEATURES,
> >  
> >  	__NETDEV_A_DEV_MAX,
> >  	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
> 
> ...
> 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> 
> ...
> 
> > @@ -626,6 +635,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >  static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  				     struct xdp_desc *desc)
> >  {
> > +	struct xsk_tx_metadata *meta = NULL;
> >  	struct net_device *dev = xs->dev;
> >  	struct sk_buff *skb = xs->skb;
> >  	int err;
> > @@ -678,12 +688,40 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  
> >  			skb_add_rx_frag(skb, nr_frags, page, 0, len, 0);
> >  		}
> > +
> > +		if (desc->options & XDP_TX_METADATA) {
> > +			if (unlikely(xs->tx_metadata_len == 0)) {
> > +				err = -EINVAL;
> > +				goto free_err;
> > +			}
> > +
> > +			meta = buffer - xs->tx_metadata_len;
> > +
> > +			if (meta->flags & XDP_TX_METADATA_CHECKSUM) {
> > +				if (unlikely(meta->csum_start + meta->csum_offset +
> > +					     sizeof(__sum16) > len)) {
> > +					err = -EINVAL;
> > +					goto free_err;
> > +				}
> > +
> > +				skb->csum_start = hr + meta->csum_start;
> 
> hr seems to only be set - by earlier, existing code in this function -
> if skb is NULL. Is it always safe to use it here?
> 
> Smatch flags hr as being potentially used uninitialised,
> the above is my understanding of why it thinks that is so.

Ugh, good point, I've missed that. This part is new and it's from
multi-frag support. I need to be more careful here and apply metadata
only from the first descriptor in the chain. Thanks!

