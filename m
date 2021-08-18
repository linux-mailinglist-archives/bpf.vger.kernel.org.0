Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53EF3F03BB
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 14:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhHRMbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 08:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234931AbhHRMbq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 08:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629289871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQ4O8ycMkSrrR17u6KlbZPwcNJ+ZHv0tIoID9WRfEQc=;
        b=aBM0OASN4FWs5kmHy5IMkpSgAoxMWWyyteLIK9fZKx4/gdVM4Rc/tiS5zJ7XEYCeW3MyYM
        MWwDajBDdUltL74PqhlU4ekTnnpvohqgIcMQ9Mehn0uzhNES304WoXcNU4E1DiZAIOj2fU
        A9zVnUTlL+/8NRTJ18zYLa464sOk0e0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-BZGeybTrMlCx4LCrP6W_xg-1; Wed, 18 Aug 2021 08:31:10 -0400
X-MC-Unique: BZGeybTrMlCx4LCrP6W_xg-1
Received: by mail-ej1-f70.google.com with SMTP id k21-20020a1709062a55b0290590e181cc34so815631eje.3
        for <bpf@vger.kernel.org>; Wed, 18 Aug 2021 05:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DQ4O8ycMkSrrR17u6KlbZPwcNJ+ZHv0tIoID9WRfEQc=;
        b=ANos9dz7wCC3omXMhhDT82Few1aQCzxFlF3gfLnkR8Ar6GxLxZIi65GytHX5ZGmXOQ
         GPdhSIegXmeK/jvG6s6M5Iyonp1ZyqcLCFeOAMvx3xwI+xSRlFj9OYbkIKOBB8szWoNR
         NLZIC/Sl/mMm2cVLOpxz32Vn7HlCvnKRLh0fUx3Wp36e0zIAMKh9/qm+ZQRQ6/3L+Y+U
         clT5pASuOiIO2rxjdT7zkiE3t9TrGDL0vuu/txD7hXkqfwv9qDm+mQnVWZF3sOHDty+/
         oJAmUYadoLACn6D5waUVbgV6imOCCGRH1wz7ewa9KLqhDFLlSWzm7ZlbVH1EXQ72jWBH
         pBug==
X-Gm-Message-State: AOAM531ClspoL3VZ6XLH7jyuPcYN/NWa5KxeGgqKXm+CpnyagEw6JH1M
        KHCSw4aiexeu3jwXByiPm66QLrGdzmovE1UwZfQ/ydMo0+wtFEV7Xi9LWlWbuAS2CcvktUXCLxh
        CPXW6FqQlk2W7
X-Received: by 2002:a05:6402:22ab:: with SMTP id cx11mr9808602edb.240.1629289869047;
        Wed, 18 Aug 2021 05:31:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqsFem7znHCNOJTx5xHzFRptKqZokaG0VrQZSUKRLyYLSd163BMC9vjZM0Z88pwUrBo2L7cQ==
X-Received: by 2002:a05:6402:22ab:: with SMTP id cx11mr9808567edb.240.1629289868891;
        Wed, 18 Aug 2021 05:31:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w13sm2719164ede.24.2021.08.18.05.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:31:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A14CA180331; Wed, 18 Aug 2021 14:31:07 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v11 bpf-next 17/18] net: xdp: introduce
 bpf_xdp_adjust_data helper
In-Reply-To: <9696df8ef1cf6c931ae788f40a42b9278c87700b.1628854454.git.lorenzo@kernel.org>
References: <cover.1628854454.git.lorenzo@kernel.org>
 <9696df8ef1cf6c931ae788f40a42b9278c87700b.1628854454.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Aug 2021 14:31:07 +0200
Message-ID: <87czqbq6ic.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> For XDP frames split over multiple buffers, the xdp_md->data and
> xdp_md->data_end pointers will point to the start and end of the first
> fragment only. bpf_xdp_adjust_data can be used to access subsequent
> fragments by moving the data pointers. To use, an XDP program can call
> this helper with the byte offset of the packet payload that
> it wants to access; the helper will move xdp_md->data and xdp_md ->data_end
> so they point to the requested payload offset and to the end of the
> fragment containing this byte offset, and return the byte offset of the
> start of the fragment.
> To move back to the beginning of the packet, simply call the
> helper with an offset of '0'.
> Note also that the helpers that modify the packet boundaries
> (bpf_xdp_adjust_head(), bpf_xdp_adjust_tail() and
> bpf_xdp_adjust_meta()) will fail if the pointers have been
> moved; it is the responsibility of the BPF program to move them
> back before using these helpers.
>
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/xdp.h              |  8 +++++
>  include/uapi/linux/bpf.h       | 32 ++++++++++++++++++
>  net/bpf/test_run.c             |  8 +++++
>  net/core/filter.c              | 61 +++++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h | 32 ++++++++++++++++++
>  5 files changed, 140 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index cdaecf8d4d61..ce4764c7cd40 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -82,6 +82,11 @@ struct xdp_buff {
>  	struct xdp_txq_info *txq;
>  	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
>  	u16 flags; /* supported values defined in xdp_flags */
> +	/* xdp multi-buff metadata used for frags iteration */
> +	struct {
> +		u16 headroom;	/* frame headroom: data - data_hard_start */
> +		u16 headlen;	/* first buffer length: data_end - data */
> +	} mb;
>  };
>  
>  static __always_inline bool xdp_buff_is_mb(struct xdp_buff *xdp)
> @@ -127,6 +132,9 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
>  	xdp->data = data;
>  	xdp->data_end = data + data_len;
>  	xdp->data_meta = meta_valid ? data : data + 1;
> +	/* mb metadata for frags iteration */
> +	xdp->mb.headroom = headroom;
> +	xdp->mb.headlen = data_len;
>  }
>  
>  /* Reserve memory area at end-of data area.
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ddbf9ccc2f74..c20a8b7c5c7c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4853,6 +4853,37 @@ union bpf_attr {
>   *		Get the total size of a given xdp buff (linear and paged area)
>   *	Return
>   *		The total size of a given xdp buffer.
> + *
> + * long bpf_xdp_adjust_data(struct xdp_buff *xdp_md, u32 offset)
> + *	Description
> + *		For XDP frames split over multiple buffers, the
> + *		*xdp_md*\ **->data** and*xdp_md *\ **->data_end** pointers
> + *		will point to the start and end of the first fragment only.
> + *		This helper can be used to access subsequent fragments by
> + *		moving the data pointers. To use, an XDP program can call
> + *		this helper with the byte offset of the packet payload that
> + *		it wants to access; the helper will move *xdp_md*\ **->data**
> + *		and *xdp_md *\ **->data_end** so they point to the requested
> + *		payload offset and to the end of the fragment containing this
> + *		byte offset, and return the byte offset of the start of the
> + *		fragment.

This comment is wrong now :)

-Toke

