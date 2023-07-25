Return-Path: <bpf+bounces-5890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA3B762781
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 01:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27148281B1A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 23:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3065E27728;
	Tue, 25 Jul 2023 23:48:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D688462
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 23:48:23 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC5E2
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 16:48:22 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5634dbfb8b1so2839906a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 16:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690328902; x=1690933702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1gbm7SHBDO0dPR/G75Fc7n9oOa169DATobxNqRb7Fo=;
        b=Su10Lw0aZkMXrozhNalfPEWGBz3FhkeaPpGtzzOAn1qKwDNInPVoz6XPfyQwSzANfF
         eMDlGZoQ3Es5KlBPDvYqSatRdy++wyXBAZyr3hvFYL1BdkpUtjqCDsXziWGQfvgt7Z1H
         ccUxYrLGoL4bOJ19LhS5PN2iEoPp41kxKBrENXDFjCQQAcByjx4gfmJ+e9sGrRwRobtw
         q2gnlpM+g2l0uNWR0L5w5SdRVCmFAy3COMYFvE7D8DrI1RwSrtdSvLPjEuKrqpDfyiJO
         /I+j8+Gw0LFObfsHX37p6uBdeWU6jaihzh4YEi6wglZB7NFhiNrw5BQIxEGJbP3JCDwO
         mAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690328902; x=1690933702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1gbm7SHBDO0dPR/G75Fc7n9oOa169DATobxNqRb7Fo=;
        b=hsvztGXFcRQJ8HywicknWu3AsUBhJdKw6qanP5hFUQG0e/eEOHOVzIHRG7lN0hzulf
         H6Gwod8BXsWM7eZf57Yi/5HitQVDh8JF17Q6LZmqnULLcw6qTkW+RPxTLFcdObDJy1AQ
         aRVycih4D++xacHQAoL3RPyifs3RUbIyt7JG4FQ2Dc3QqvskSdoJpSm0w03xEtVIreqo
         Ztoc5jzSY9IADTErvtTZ4US/tw8cF32a0DnweWxZNxGtnuipXYU4WqPINtnRO6NmV8Ik
         B4WF+mLXxli8X97TtUV5U8RhVG0dzvM7YF7Pkd0Yz1wH/FynFWW3Nvr43cXBw/SToyeb
         w0rg==
X-Gm-Message-State: ABy/qLZJG3eYxWYggVa/TrsPmujsOxPCY+vQb3OthPEt44/0fDnZmnEa
	iR5Az9t+9AZVxWSFsk/8utntpxw=
X-Google-Smtp-Source: APBJJlH3rRw/OjSC+3HxgvpyffsTjs0Fu3o5pNslJdK66NIDXlelQFYhoNUxe0vY3Ue+cuoipTE3cqc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3ec5:0:b0:557:6227:bf47 with SMTP id
 l188-20020a633ec5000000b005576227bf47mr3108pga.9.1690328902214; Tue, 25 Jul
 2023 16:48:22 -0700 (PDT)
Date: Tue, 25 Jul 2023 16:48:20 -0700
In-Reply-To: <64c056686b527_3a4d294e6@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com> <20230724235957.1953861-3-sdf@google.com>
 <64c0369eadbd5_3fe1bc2940@willemb.c.googlers.com.notmuch> <ZMBPDe+IhvTQnKQa@google.com>
 <64c056686b527_3a4d294e6@willemb.c.googlers.com.notmuch>
Message-ID: <ZMBfRPxMk0F45a/s@google.com>
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
From: Stanislav Fomichev <sdf@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/25, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
> > On 07/25, Willem de Bruijn wrote:
> > > Stanislav Fomichev wrote:
> > > > This change actually defines the (initial) metadata layout
> > > > that should be used by AF_XDP userspace (xsk_tx_metadata).
> > > > The first field is flags which requests appropriate offloads,
> > > > followed by the offload-specific fields. The supported per-device
> > > > offloads are exported via netlink (new xsk-flags).
> > > > 
> > > > The offloads themselves are still implemented in a bit of a
> > > > framework-y fashion that's left from my initial kfunc attempt.
> > > > I'm introducing new xsk_tx_metadata_ops which drivers are
> > > > supposed to implement. The drivers are also supposed
> > > > to call xsk_tx_metadata_request/xsk_tx_metadata_complete in
> > > > the right places. Since xsk_tx_metadata_{request,_complete}
> > > > are static inline, we don't incur any extra overhead doing
> > > > indirect calls.
> > > > 
> > > > The benefit of this scheme is as follows:
> > > > - keeps all metadata layout parsing away from driver code
> > > > - makes it easy to grep and see which drivers implement what
> > > > - don't need any extra flags to maintain to keep track of that
> > > >   offloads are implemented; if the callback is implemented - the offload
> > > >   is supported (used by netlink reporting code)
> > > > 
> > > > Two offloads are defined right now:
> > > > 1. XDP_TX_METADATA_CHECKSUM: skb-style csum_start+csum_offset
> > > > 2. XDP_TX_METADATA_TIMESTAMP: writes TX timestamp back into metadata
> > > >    area upon completion (tx_timestamp field)
> > > > 
> > > > The offloads are also implemented for copy mode:
> > > > 1. Extra XDP_TX_METADATA_CHECKSUM_SW to trigger skb_checksum_help; this
> > > >    might be useful as a reference implementation and for testing
> > > > 2. XDP_TX_METADATA_TIMESTAMP writes SW timestamp from the skb
> > > >    destructor (note I'm reusing hwtstamps to pass metadata pointer)
> > > > 
> > > > The struct is forward-compatible and can be extended in the future
> > > > by appending more fields.
> > > > 
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> > > > +/* Request transmit checksum offload. Checksum start position and offset
> > > > + * are communicated via csum_start and csum_offset fields of struct
> > > > + * xsk_tx_metadata.
> > > > + */
> > > > +#define XDP_TX_METADATA_CHECKSUM		(1 << 1)
> > > > +
> > > > +/* Force checksum calculation in software. Can be used for testing or
> > > > + * working around potential HW issues. This option causes performance
> > > > + * degradation and only works in XDP_COPY mode.
> > > > + */
> > > > +#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)
> > > 
> > > Not sure how useful this is, especially if only for copy mode.
> > 
> > Seems useful at least as a reference implementation? But I'm happy
> > to drop. It's used only in the tests for now. I was using it to
> > verify csum_offset/start field values.
> 
> If testing over veth, does anything even look at the checksum?

My receiver in the xdp_metadata test looks at it and compares to the
fixed (verified) value:

	ASSERT_EQ(udph->check, 0x1c72, "csum");

The packet is always the same (and macs are fixed), so we are able
to do that.
 
> > > > +struct xsk_tx_metadata {
> > > > +	__u32 flags;
> > > > +
> > > > +	/* XDP_TX_METADATA_CHECKSUM */
> > > > +
> > > > +	/* Offset from desc->addr where checksumming should start. */
> > > > +	__u16 csum_start;
> > > > +	/* Offset from csum_start where checksum should be stored. */
> > > > +	__u16 csum_offset;
> > > > +
> > > > +	/* XDP_TX_METADATA_TIMESTAMP */
> > > > +
> > > > +	__u64 tx_timestamp;
> > > > +};
> > > 
> > > Is this structure easily extensible for future offloads,
> > > such as USO?
> > 
> > We can append more field. What do we need for USO? Something akin
> > to gso_size/gso_segs/gso_type ?
> 
> Yes, a bit to set the feature (gso_type) and a field to store the
> segment size (gso_size).
> 
> Pacing offload is the other feature that comes to mind. That could
> conceivably use the tx_timestamp field.

Right, so we can append to this struct and add more XDP_TX_METADATA_$(FLAG)s
to signal various features. Jakub mentioned that it might be handy
to pass l2_offset/l3_offset/l4_offset, but I'm not sure whether
he was talking about xSO offloads or something else.

