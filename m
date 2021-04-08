Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A27358D56
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 21:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhDHTQO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 15:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhDHTQN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 15:16:13 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF00C061760;
        Thu,  8 Apr 2021 12:16:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w10so2091200pgh.5;
        Thu, 08 Apr 2021 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Epf1D6+7n7NuoJHYOA6+19Kynu8l8Y+5ZIlz5BptAo=;
        b=BFhTOc5plf1L1j7y+GLKg/l9QZQaSZIKkc4aPTFmXxyXEtu/K47QqM8w85/uE+lUWG
         reYx5ZZegb8AX/LPcWophMYpv9v/P2NhIaJhmubXxznWkhg3T04KslwvR7P3oxhsU6AP
         IVab9VpcG3rm0GwH/UetoE005jnD/G5xB8csHt90lbZSuYi/fN41OHvuDJqCj5+Z2KH8
         tE2DJmSJ6uywAK2m6JgAzU61z/A7/5812GJTRSy7zf0C6ROIPbo8POp4ZsrTjkDcv9wQ
         njxAatNGvVwf28slSNO8pNYOTLc2T+CmnoQjsFUW8jmIbE8nj2yOGayKkHQ6/3GX3Jlm
         7zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Epf1D6+7n7NuoJHYOA6+19Kynu8l8Y+5ZIlz5BptAo=;
        b=M6TeKZ2CK2j0XYFO++9YFNjgmsvC8r1Y6I6ZBd8geEOdN2lopW/v8nLRtrgDU1uFE6
         P1+PSKcaXwaq6K6Ka05BcqQ9FmnNEllaSGF6TXGbBH7jPYEMWYDRk4A8Y6/5Obxj/1zU
         dAZN1J9h6Pred2ISSPS/NcW5UWOd/Ok3btFlOLO86+eJQ79okios5hKAZBmIfH8VjWtT
         b0+aHBT4TTWdEBXQx5bI4qVnC8AZmooZXklOgr7eGBk3ngEFrpRpTqoYDhuxSSSxS6SC
         k4hQvOOy1UNuMQbhbAy9TazN3FjBp2cBgbiDOEcVcpDKk8KkUwdw4rIlXh+aHP5+pUFQ
         10rw==
X-Gm-Message-State: AOAM531UIx10/LeGhcY0X9wAhkQCmsxkEEcLZo3Cafk55z4EaJ/xcq4+
        NA8KkkqVW0D9ndP3hQn6XHs=
X-Google-Smtp-Source: ABdhPJzrh0S8dEaRLQx5/KiHrTR9HWJp3yOf7gDCPy4TDZDLW7eGoFoY7tlkDPRgX57fyFCRTBZcEg==
X-Received: by 2002:a62:7f4a:0:b029:23f:3271:60fe with SMTP id a71-20020a627f4a0000b029023f327160femr9179415pfd.10.1617909361778;
        Thu, 08 Apr 2021 12:16:01 -0700 (PDT)
Received: from skbuf (5-12-16-165.residential.rdsnet.ro. [5.12.16.165])
        by smtp.gmail.com with ESMTPSA id h19sm215712pfc.172.2021.04.08.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:00 -0700 (PDT)
Date:   Thu, 8 Apr 2021 22:15:47 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        sameehj@amazon.com, john.fastabend@gmail.com, dsahern@kernel.org,
        brouer@redhat.com, echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com
Subject: Re: [PATCH v8 bpf-next 08/14] bpf: add multi-buff support to the
 bpf_xdp_adjust_tail() API
Message-ID: <20210408191547.zlriol6gm2tdhhxi@skbuf>
References: <cover.1617885385.git.lorenzo@kernel.org>
 <427bd05d147a247fc30fd438be94b5d51845b05f.1617885385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427bd05d147a247fc30fd438be94b5d51845b05f.1617885385.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 08, 2021 at 02:51:00PM +0200, Lorenzo Bianconi wrote:
> From: Eelco Chaudron <echaudro@redhat.com>
> 
> This change adds support for tail growing and shrinking for XDP multi-buff.
> 
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/xdp.h |  5 ++++
>  net/core/filter.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index c8eb7cf4ebed..55751cf2badf 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -159,6 +159,11 @@ static inline void xdp_set_frag_size(skb_frag_t *frag, u32 size)
>  	frag->bv_len = size;
>  }
>  
> +static inline unsigned int xdp_get_frag_tailroom(const skb_frag_t *frag)
> +{
> +	return PAGE_SIZE - xdp_get_frag_size(frag) - xdp_get_frag_offset(frag);
> +}
> +

This is an interesting requirement. Must an XDP frame fragment be a full
PAGE_SIZE? enetc does not fulfill it, and I suspect that none of the
drivers with a "shared page" memory model will.

>  struct xdp_frame {
>  	void *data;
>  	u16 len;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index cae56d08a670..c4eb1392f88e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3855,11 +3855,74 @@ static const struct bpf_func_proto bpf_xdp_adjust_head_proto = {
>  	.arg2_type	= ARG_ANYTHING,
>  };
>  
> +static int bpf_xdp_mb_adjust_tail(struct xdp_buff *xdp, int offset)
> +{
> +	struct xdp_shared_info *xdp_sinfo = xdp_get_shared_info_from_buff(xdp);
> +
> +	if (unlikely(xdp_sinfo->nr_frags == 0))
> +		return -EINVAL;

This function is called if xdp->mb is true, but we check whether
nr_frags != 0? Is this condition possible?

> +	if (offset >= 0) {
> +		skb_frag_t *frag = &xdp_sinfo->frags[xdp_sinfo->nr_frags - 1];
> +		int size;
> +
> +		if (unlikely(offset > xdp_get_frag_tailroom(frag)))
> +			return -EINVAL;
> +
> +		size = xdp_get_frag_size(frag);
> +		memset(xdp_get_frag_address(frag) + size, 0, offset);
> +		xdp_set_frag_size(frag, size + offset);
> +		xdp_sinfo->data_length += offset;
> +	} else {
> +		int i, frags_to_free = 0;
> +
> +		offset = abs(offset);
> +
> +		if (unlikely(offset > ((int)(xdp->data_end - xdp->data) +
> +				       xdp_sinfo->data_length -
> +				       ETH_HLEN)))

I think code alignment should be to xdp->data_end, not to (int).

Also: should we have some sort of helper for calculating the total
length of an xdp_frame (head + frags)? Maybe it's just me, but I find it
slightly confusing that xdp_sinfo->data_length does not account for
everything.

> +			return -EINVAL;
> +
> +		for (i = xdp_sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
> +			skb_frag_t *frag = &xdp_sinfo->frags[i];
> +			int size = xdp_get_frag_size(frag);
> +			int shrink = min_t(int, offset, size);
> +
> +			offset -= shrink;
> +			if (likely(size - shrink > 0)) {
> +				/* When updating the final fragment we have
> +				 * to adjust the data_length in line.
> +				 */
> +				xdp_sinfo->data_length -= shrink;
> +				xdp_set_frag_size(frag, size - shrink);
> +				break;
> +			}
> +
> +			/* When we free the fragments,
> +			 * xdp_return_frags_from_buff() will take care
> +			 * of updating the xdp share info data_length.

s/xdp share info data_length/data_length from xdp_shared_info/

> +			 */
> +			frags_to_free++;
> +		}
> +
> +		if (unlikely(frags_to_free))
> +			xdp_return_num_frags_from_buff(xdp, frags_to_free);
> +
> +		if (unlikely(offset > 0))
> +			xdp->data_end -= offset;
> +	}
> +
> +	return 0;
> +}
> +
>  BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
>  {
>  	void *data_hard_end = xdp_data_hard_end(xdp); /* use xdp->frame_sz */
>  	void *data_end = xdp->data_end + offset;
>  
> +	if (unlikely(xdp->mb))
> +		return bpf_xdp_mb_adjust_tail(xdp, offset);
> +
>  	/* Notice that xdp_data_hard_end have reserved some tailroom */
>  	if (unlikely(data_end > data_hard_end))
>  		return -EINVAL;
> -- 
> 2.30.2
> 

