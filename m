Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF981FB5BB
	for <lists+bpf@lfdr.de>; Tue, 16 Jun 2020 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgFPPMt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jun 2020 11:12:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49411 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728183AbgFPPMt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 16 Jun 2020 11:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592320368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7qhCxvoZ4pGY/L0PLOGhReeWNRTmAqSKJWa5eiJeyRQ=;
        b=gG7t6yTznHEyYtPw94OpzsZ+nyvzqZPSuwuxmJi1qWmv/uFpACuRuBTmAP/uQL/VRuw2Rb
        4fixrS+3/upHi7ucKODR3tQx0RvDS4X/8W1O3PfQnvco8U0ZjExpu+Bt4mhlCeD5zTkebM
        phhj8MDePuMT6yPupYeQqM45ENpGQ1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-2bxKc62ePi6_49bg2UTNWg-1; Tue, 16 Jun 2020 11:12:44 -0400
X-MC-Unique: 2bxKc62ePi6_49bg2UTNWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78888108597C;
        Tue, 16 Jun 2020 15:12:42 +0000 (UTC)
Received: from carbon (unknown [10.40.208.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E9D35C1BD;
        Tue, 16 Jun 2020 15:12:34 +0000 (UTC)
Date:   Tue, 16 Jun 2020 17:12:33 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Toke =?UTF-8?B?SMO4aWxh?= =?UTF-8?B?bmQtSsO4cmdlbnNlbg==?= 
        <toke@redhat.com>, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, brouer@redhat.com
Subject: Re: [PATCH bpf] xdp: handle frame_sz in
 xdp_convert_zc_to_xdp_frame()
Message-ID: <20200616171233.1579d079@carbon>
In-Reply-To: <20200616103518.2963410-1-liuhangbin@gmail.com>
References: <20200616103518.2963410-1-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Jun 2020 18:35:18 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> In commit 34cc0b338a61 we only handled the frame_sz in convert_to_xdp_frame().
> This patch will also handle frame_sz in xdp_convert_zc_to_xdp_frame().
> 
> Fixes: 34cc0b338a61 ("xdp: Xdp_frame add member frame_sz and handle in convert_to_xdp_frame")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks for spotting and fixing this! :-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>


> ---
>  net/core/xdp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 90f44f382115..3c45f99e26d5 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -462,6 +462,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
>  	xdpf->len = totsize - metasize;
>  	xdpf->headroom = 0;
>  	xdpf->metasize = metasize;
> +	xdpf->frame_sz = PAGE_SIZE;
>  	xdpf->mem.type = MEM_TYPE_PAGE_ORDER0;
>  
>  	xsk_buff_free(xdp);



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

