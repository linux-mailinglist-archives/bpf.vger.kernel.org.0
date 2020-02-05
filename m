Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D04B5152604
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2020 06:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgBEFeD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Feb 2020 00:34:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54410 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725906AbgBEFeD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Feb 2020 00:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580880841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpoA79PTiO2rp87/4RjJ0Oaw1CL7CM0sYNu+diR+ohU=;
        b=Y4aMZjIGU3jkmSf2iykgCxUg7WIjMEt1mtdxMOGHeJ5zL0ixC8pFvTp9bx/UxI7nO/+n0i
        GWE7Mjk+roNwFKXxxO7gcnHtL0SClB+VqgHPtU4Gz+99q5IZMrP8MBRF97iDr0d+CPi4wR
        Zd+mDZ3Yge3gW+4nNSXMkFSDu70hgWI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-fhaH2AkPM9eVU6EvAXE7ig-1; Wed, 05 Feb 2020 00:33:58 -0500
X-MC-Unique: fhaH2AkPM9eVU6EvAXE7ig-1
Received: by mail-qt1-f199.google.com with SMTP id d16so641637qtr.2
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2020 21:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UpoA79PTiO2rp87/4RjJ0Oaw1CL7CM0sYNu+diR+ohU=;
        b=ctQn7pZDFS7IXdDaP9Jn96wopXp4s++3YdOfRouOdWz9NVXWtYfSz9VtDQrEVe2SFF
         T9HYJEcqVlWkRsC8wL8QsWe/yTPyDnroFjXVrNJhYJmryPxZh9vll0sBIyD1Bv+OZj7Z
         Wfeenj5ng16oL+D+hTfbW5yCAPcbQZRyzvYdQb9rY+7C3Zm8NGUVFgu1VLljGvg5E7oJ
         SDstb4ls3aISGAs/B2BYdHpfgJ4UyRfWxmSWC+QJSgzot4w3uBcrJ7y/lAH088EOUIC6
         RJg+sxxfnLZodEez6Zeoonu8+yE2w6XADsqDbcyozMHeCU50/I0sJvujBg90ILwRIbCC
         t/5A==
X-Gm-Message-State: APjAAAWJwYjMsSa2y77ZNxPSwuKBljgc7hln4hcNsWHyU9CI7QJ6oT70
        HEPOtFVYsLAvXYisS0bEBjd4Kgkl08ltw/nOOIFppTBrXzklYkKsjyU4iURZvnbuujqvXWhLo+I
        RG4yYVWPa4dmo
X-Received: by 2002:ae9:c10b:: with SMTP id z11mr31554684qki.157.1580880838436;
        Tue, 04 Feb 2020 21:33:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPyGS4sGVa29gfwEv/nW9Jz92sfCSHCicovqzsWK08mnYnXlDIxmWkXBF3U8uJQk1Lyqq61A==
X-Received: by 2002:ae9:c10b:: with SMTP id z11mr31554675qki.157.1580880838213;
        Tue, 04 Feb 2020 21:33:58 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id r3sm3624696qtc.85.2020.02.04.21.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 21:33:57 -0800 (PST)
Date:   Wed, 5 Feb 2020 00:33:52 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc:     jasowang@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, kuba@kernel.org,
        andriin@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4] virtio_net: add XDP meta data support
Message-ID: <20200205003236-mutt-send-email-mst@kernel.org>
References: <8da1b560-3128-b885-b453-13de5c7431fb@redhat.com>
 <20200204071655.94474-1-yuya.kusakabe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204071655.94474-1-yuya.kusakabe@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 04, 2020 at 04:16:55PM +0900, Yuya Kusakabe wrote:
> @@ -852,8 +868,9 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  			 * adjustments. Note other cases do not build an
>  			 * skb and avoid using offset
>  			 */
> -			offset = xdp.data -
> -					page_address(xdp_page) - vi->hdr_len;
> +			metasize = xdp.data - xdp.data_meta;
> +			offset = xdp.data - page_address(xdp_page) -
> +				 vi->hdr_len - metasize;
>  
>  			/* recalculate len if xdp.data or xdp.data_end were
>  			 * adjusted

Tricky to get one's head around.
Can you pls update the comment above to document the new math?

-- 
MST

