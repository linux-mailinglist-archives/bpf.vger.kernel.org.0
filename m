Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88805358C05
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhDHSR0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSR0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 14:17:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8777CC061760;
        Thu,  8 Apr 2021 11:17:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c17so2451878pfn.6;
        Thu, 08 Apr 2021 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zRT9DhQ3IT2xhVUi7pk4OyIrhDNRZiy4Zp2TymZk+JU=;
        b=pNx5ONycw/duKKcJaEB2so5CPgjizmV6MWApgVvbsUuk0Gs0USzYv0ViAky1RF7Tvb
         4ZCJE0SBgBcCe1cwCQRbfcqEAT9m9CQKoi699SZsM3nViItKG7hTas4FXqvl1oimIC6K
         aLFGeviuxAzdTZbmlgZKGOS05IIWE7txM7fiTBU8nc6QmTNZZUBtAvKaPl2Rh8ax0gNH
         QcNhgglfBClWtQMtO2P5GNl7B75o2hXCa6Cch+b7u+kqasK5HUTqfMJu1IvN1alYWtKe
         1RvTnUJ+9N2ZjmqZuFopa13dFT9CXwLRbr9SsE/tOikCWXCXQoZTgkSa/C0FTgneVbIF
         qHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zRT9DhQ3IT2xhVUi7pk4OyIrhDNRZiy4Zp2TymZk+JU=;
        b=mYrhIaexo9/b7fPXE7n7pdT51m6OEjHKZin+9+SXlruC8qH5lATc4t4GSlW01Ml3gF
         x3YEFNymqYFg6h8xLpDyxPq4dlTvuT5GO9gR7lMK6wPsBy4cZiAzXn/vfeErqhGU0soZ
         5RNV+GNxKWuQfpyV4/RWzOiWlLAc572HgXO92kG99ZtssAIEEGUEt2g4MZ/Lqh1WWM7i
         HFwTpUJdKb4VpBDmoscVTytFbp2yGfw1F/9Usu5EVr0xW13rAigl6vqdvriO3ylgTV7X
         fGHFvEKTs5cXsXTiLq0HOO4SLb/4WRdjrqLZ6p1NwEV42YW+LleE+PXsnWmiqfIm94h8
         JeFg==
X-Gm-Message-State: AOAM533QEJxLjueKf/sfAczPyDWO5e4HIbbZMBx23H6l2sReBEGrTAbQ
        7ztnd+0O7Fx2lhejKNDpctc=
X-Google-Smtp-Source: ABdhPJxtv+applMNT5t3ZdgbpL2Wr8HwV2YNiDb8xS2EIiSuyR5e4EzAkE4Wp26wex9O3pWfjONGJg==
X-Received: by 2002:a65:610f:: with SMTP id z15mr9346775pgu.360.1617905834030;
        Thu, 08 Apr 2021 11:17:14 -0700 (PDT)
Received: from skbuf (5-12-16-165.residential.rdsnet.ro. [5.12.16.165])
        by smtp.gmail.com with ESMTPSA id c5sm140003pfp.183.2021.04.08.11.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 11:17:13 -0700 (PDT)
Date:   Thu, 8 Apr 2021 21:17:00 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        sameehj@amazon.com, john.fastabend@gmail.com, dsahern@kernel.org,
        brouer@redhat.com, echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com
Subject: Re: [PATCH v8 bpf-next 01/14] xdp: introduce mb in xdp_buff/xdp_frame
Message-ID: <20210408181700.vlay72gyxzknfc7m@skbuf>
References: <cover.1617885385.git.lorenzo@kernel.org>
 <eef58418ab78408f4a5fbd3d3b0071f30ece2ccd.1617885385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eef58418ab78408f4a5fbd3d3b0071f30ece2ccd.1617885385.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 08, 2021 at 02:50:53PM +0200, Lorenzo Bianconi wrote:
> Introduce multi-buffer bit (mb) in xdp_frame/xdp_buffer data structure
> in order to specify if this is a linear buffer (mb = 0) or a multi-buffer
> frame (mb = 1). In the latter case the shared_info area at the end of the
> first buffer will be properly initialized to link together subsequent
> buffers.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/xdp.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index a5bc214a49d9..842580a61563 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -73,7 +73,10 @@ struct xdp_buff {
>  	void *data_hard_start;
>  	struct xdp_rxq_info *rxq;
>  	struct xdp_txq_info *txq;
> -	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
> +	u32 frame_sz:31; /* frame size to deduce data_hard_end/reserved
> +			  * tailroom
> +			  */

This comment would have fit just fine on one line:

	/* frame size to deduce data_hard_end/reserved tailroom */

> +	u32 mb:1; /* xdp non-linear buffer */
>  };
>  
>  static __always_inline void
> @@ -81,6 +84,7 @@ xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
>  {
>  	xdp->frame_sz = frame_sz;
>  	xdp->rxq = rxq;
> +	xdp->mb = 0;
>  }
>  
>  static __always_inline void
> @@ -116,7 +120,8 @@ struct xdp_frame {
>  	u16 len;
>  	u16 headroom;
>  	u32 metasize:8;
> -	u32 frame_sz:24;
> +	u32 frame_sz:23;
> +	u32 mb:1; /* xdp non-linear frame */
>  	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
>  	 * while mem info is valid on remote CPU.
>  	 */
> @@ -179,6 +184,7 @@ void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
>  	xdp->data_end = frame->data + frame->len;
>  	xdp->data_meta = frame->data - frame->metasize;
>  	xdp->frame_sz = frame->frame_sz;
> +	xdp->mb = frame->mb;
>  }
>  
>  static inline
> @@ -205,6 +211,7 @@ int xdp_update_frame_from_buff(struct xdp_buff *xdp,
>  	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
>  	xdp_frame->metasize = metasize;
>  	xdp_frame->frame_sz = xdp->frame_sz;
> +	xdp_frame->mb = xdp->mb;
>  
>  	return 0;
>  }
> -- 
> 2.30.2
> 
