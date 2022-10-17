Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785486004E4
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 03:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJQBna (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Oct 2022 21:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJQBn3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Oct 2022 21:43:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB8D3DF3B
        for <bpf@vger.kernel.org>; Sun, 16 Oct 2022 18:43:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id s17so4667410qkj.12
        for <bpf@vger.kernel.org>; Sun, 16 Oct 2022 18:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wZR5j8tL/5oU/xGVpP8FKeFl23lIlEh4OAjfmdl9LmQ=;
        b=LCUUaZ+rEAdcyFmlRoH+DxiQj5GHWId2iCVo4YYvyt4lXpr3RedFsnphbEt8DZ+OrT
         HOPNyAnWP0ApPHlBwptTgFQEEJC152s8SSXhwDt3FV9PmOfHjRi/4rs7/j+JKYzPFual
         gbumcAgKZy0anzkJRwdKDlhrIwpJ9rmnLOrnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZR5j8tL/5oU/xGVpP8FKeFl23lIlEh4OAjfmdl9LmQ=;
        b=PWqK8WJzhFRlQV4WzQTbFYclmU1ynGWz6MM7HhDKs7eTHPrtAyGElrbYS6R0B1lk4k
         MIGAtZ1tf/c86gZu+NygRtBvc9t3UD62qwgdz8Hr7bHnHKmLaofTCtzHd0TM5lXUuSx4
         yB72Bn657eZgr6rGmUzQPaHUmen5xV+hZehYLHXTOwHW5opaPZW80kVc89F9TRZJsdJ3
         zi8cpQmb8bQ6SOI/FA+TS5vwzmxxk8D8suRbAe8Y1xdvqxpbEuIToKAGP6qtKtdwM4OR
         i30TKqKbCg5gk1kqkF6ulj9PwkqsNIrl4Uc+GSbWQJ1gkmn8jHVHJkCZMoW5uB4fBT1u
         91vA==
X-Gm-Message-State: ACrzQf1wzrnEluSEoFWJDh9MgToebA7wUEZ9Y+yuHDSG4kk/raZkM1Se
        251EGkgw0LlGsNdj77d9tQjx2g==
X-Google-Smtp-Source: AMsMyM4LwJEcNq8FTwK0gfWL1pcdbZc5TXJPV/mHmtv0+HSrux3tZm5YRItfp03F5sE1zgu7hEZU7Q==
X-Received: by 2002:a37:f50b:0:b0:6cb:be4d:6ce8 with SMTP id l11-20020a37f50b000000b006cbbe4d6ce8mr6139565qkk.135.1665971008085;
        Sun, 16 Oct 2022 18:43:28 -0700 (PDT)
Received: from C02YVCJELVCG ([136.56.55.162])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006e8f8ca8287sm8311244qkp.120.2022.10.16.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 18:43:27 -0700 (PDT)
From:   Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date:   Sun, 16 Oct 2022 21:43:18 -0400
To:     Gerhard Engleder <gerhard@engleder-embedded.com>
Cc:     andrew.gospodarek@broadcom.com, ast@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] samples/bpf: Fix MAC address swapping in
 xdp2_kern
Message-ID: <Y0yzNh9Kih1Z9KsK@C02YVCJELVCG>
References: <20221015213050.65222-1-gerhard@engleder-embedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221015213050.65222-1-gerhard@engleder-embedded.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 15, 2022 at 11:30:50PM +0200, Gerhard Engleder wrote:
> xdp2_kern rewrites and forwards packets out on the same interface.
> Forwarding still works but rewrite got broken when xdp multibuffer
> support has been added.
> 
> With xdp multibuffer a local copy of the packet has been introduced. The
> MAC address is now swapped in the local copy, but the local copy in not
> written back.
> 
> Fix MAC address swapping be adding write back of modified packet.
> 

Nice catch!  Thanks for posting this.

> Fixes: 772251742262 ("samples/bpf: fixup some tools to be able to support xdp multibuffer")
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

> ---
>  samples/bpf/xdp2_kern.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/samples/bpf/xdp2_kern.c b/samples/bpf/xdp2_kern.c
> index 3332ba6bb95f..67804ecf7ce3 100644
> --- a/samples/bpf/xdp2_kern.c
> +++ b/samples/bpf/xdp2_kern.c
> @@ -112,6 +112,10 @@ int xdp_prog1(struct xdp_md *ctx)
>  
>  	if (ipproto == IPPROTO_UDP) {
>  		swap_src_dst_mac(data);
> +
> +		if (bpf_xdp_store_bytes(ctx, 0, pkt, sizeof(pkt)))
> +			return rc;
> +
>  		rc = XDP_TX;
>  	}
>  
> -- 
> 2.30.2
> 
