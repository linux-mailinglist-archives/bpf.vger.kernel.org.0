Return-Path: <bpf+bounces-5887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD6C762733
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 01:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCB9281AED
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 23:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118C27704;
	Tue, 25 Jul 2023 23:10:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7E8462;
	Tue, 25 Jul 2023 23:10:35 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F377ADB;
	Tue, 25 Jul 2023 16:10:33 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a3e1152c23so4246892b6e.2;
        Tue, 25 Jul 2023 16:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690326633; x=1690931433;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISs6b/iqumDFIDDnmGROC1Ohm8JbsrLbRk1neGJUdC0=;
        b=nD63sOcW9zd1MF7H4GmjdRYRQjVTJ4oXERmItVVQeTx96UvrW1TKi7Mm4z9/1NpWXZ
         lvyFK07e2AzH1wwyOvH1jy74prEZ4m9FinFz2Zk/clfL6ucPU/FudNH7Hhz3g/cq/oUw
         RIUGbz7KL5xyvWS9HUdlVVZGZiiAyiJ8OneioUC+ZCzNfngV4o0xMcuNVQnpsooPAv/x
         /KJYHLC2YxgZZln0CLUwHZiJp3Xg0JAaT7+ucWXYM8qa4GplZjl/bvEdsR+tftA51J3b
         6bJ/C8TGlJUU1FDhuCXZMTUblL0noPGzoGbYCM1/2mS/B8i9XcPU/aPHOtlyhNJuTBus
         IsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690326633; x=1690931433;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ISs6b/iqumDFIDDnmGROC1Ohm8JbsrLbRk1neGJUdC0=;
        b=MdVmBaBQC11KyuwLSx1sGOspbPK7ChRAIidGlXM6Z1QN1t5t+fVKWFJzKC0NhUv/tX
         te5/APXC/8QuEEvWFHS7Andugit9pWwQ+ruAiELO9kVsJNc9myMJ1vO3I86GcAwDq+Jr
         A5xcmWoRnxUGAoUFEodtQpJ2307/X6aAQHzsSX/Lmez2XIAPzBvXxhFyb/p+ApxsNMYA
         /g/7HjaDeTrbQ2Sk8tE7rVrC1nN226gAhxaoTPvPQrHR75H5lLXMG1kqajEnT670ABqF
         bkyGuLw6GUJ+49R7p5Ff8XE5ZHyhyPvuQLDWdT3Xb6IKy5D+PtXNTf/SZs+rbW1hD2tk
         Hqrg==
X-Gm-Message-State: ABy/qLZPfWdCwwfHj/FK7or5tVeq5bqs4rHjkBI/I4D+bS6Rrz7a6/pr
	0lKcVgB1nynTh2Ps39/WsZk=
X-Google-Smtp-Source: APBJJlHlMpE6nh8O2YwKJHoSZL/mrrXL2KvAxUe+4iRLbLw7fo2C9WSTOerBfRhfvRmenUy9m4rjog==
X-Received: by 2002:a05:6808:1899:b0:3a4:1539:afff with SMTP id bi25-20020a056808189900b003a41539afffmr392238oib.25.1690326633105;
        Tue, 25 Jul 2023 16:10:33 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id b7-20020a0ccd07000000b006360a5daf27sm4695331qvm.127.2023.07.25.16.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:10:32 -0700 (PDT)
Date: Tue, 25 Jul 2023 19:10:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yhs@fb.com, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 kuba@kernel.org, 
 toke@kernel.org, 
 willemb@google.com, 
 dsahern@kernel.org, 
 magnus.karlsson@intel.com, 
 bjorn@kernel.org, 
 maciej.fijalkowski@intel.com, 
 hawk@kernel.org, 
 netdev@vger.kernel.org, 
 xdp-hints@xdp-project.net
Message-ID: <64c056686b527_3a4d294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZMBPDe+IhvTQnKQa@google.com>
References: <20230724235957.1953861-1-sdf@google.com>
 <20230724235957.1953861-3-sdf@google.com>
 <64c0369eadbd5_3fe1bc2940@willemb.c.googlers.com.notmuch>
 <ZMBPDe+IhvTQnKQa@google.com>
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
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

Stanislav Fomichev wrote:
> On 07/25, Willem de Bruijn wrote:
> > Stanislav Fomichev wrote:
> > > This change actually defines the (initial) metadata layout
> > > that should be used by AF_XDP userspace (xsk_tx_metadata).
> > > The first field is flags which requests appropriate offloads,
> > > followed by the offload-specific fields. The supported per-device
> > > offloads are exported via netlink (new xsk-flags).
> > > 
> > > The offloads themselves are still implemented in a bit of a
> > > framework-y fashion that's left from my initial kfunc attempt.
> > > I'm introducing new xsk_tx_metadata_ops which drivers are
> > > supposed to implement. The drivers are also supposed
> > > to call xsk_tx_metadata_request/xsk_tx_metadata_complete in
> > > the right places. Since xsk_tx_metadata_{request,_complete}
> > > are static inline, we don't incur any extra overhead doing
> > > indirect calls.
> > > 
> > > The benefit of this scheme is as follows:
> > > - keeps all metadata layout parsing away from driver code
> > > - makes it easy to grep and see which drivers implement what
> > > - don't need any extra flags to maintain to keep track of that
> > >   offloads are implemented; if the callback is implemented - the offload
> > >   is supported (used by netlink reporting code)
> > > 
> > > Two offloads are defined right now:
> > > 1. XDP_TX_METADATA_CHECKSUM: skb-style csum_start+csum_offset
> > > 2. XDP_TX_METADATA_TIMESTAMP: writes TX timestamp back into metadata
> > >    area upon completion (tx_timestamp field)
> > > 
> > > The offloads are also implemented for copy mode:
> > > 1. Extra XDP_TX_METADATA_CHECKSUM_SW to trigger skb_checksum_help; this
> > >    might be useful as a reference implementation and for testing
> > > 2. XDP_TX_METADATA_TIMESTAMP writes SW timestamp from the skb
> > >    destructor (note I'm reusing hwtstamps to pass metadata pointer)
> > > 
> > > The struct is forward-compatible and can be extended in the future
> > > by appending more fields.
> > > 
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>

> > > +/* Request transmit checksum offload. Checksum start position and offset
> > > + * are communicated via csum_start and csum_offset fields of struct
> > > + * xsk_tx_metadata.
> > > + */
> > > +#define XDP_TX_METADATA_CHECKSUM		(1 << 1)
> > > +
> > > +/* Force checksum calculation in software. Can be used for testing or
> > > + * working around potential HW issues. This option causes performance
> > > + * degradation and only works in XDP_COPY mode.
> > > + */
> > > +#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)
> > 
> > Not sure how useful this is, especially if only for copy mode.
> 
> Seems useful at least as a reference implementation? But I'm happy
> to drop. It's used only in the tests for now. I was using it to
> verify csum_offset/start field values.

If testing over veth, does anything even look at the checksum?

> > > +struct xsk_tx_metadata {
> > > +	__u32 flags;
> > > +
> > > +	/* XDP_TX_METADATA_CHECKSUM */
> > > +
> > > +	/* Offset from desc->addr where checksumming should start. */
> > > +	__u16 csum_start;
> > > +	/* Offset from csum_start where checksum should be stored. */
> > > +	__u16 csum_offset;
> > > +
> > > +	/* XDP_TX_METADATA_TIMESTAMP */
> > > +
> > > +	__u64 tx_timestamp;
> > > +};
> > 
> > Is this structure easily extensible for future offloads,
> > such as USO?
> 
> We can append more field. What do we need for USO? Something akin
> to gso_size/gso_segs/gso_type ?

Yes, a bit to set the feature (gso_type) and a field to store the
segment size (gso_size).

Pacing offload is the other feature that comes to mind. That could
conceivably use the tx_timestamp field.



