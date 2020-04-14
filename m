Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110861A77F0
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438039AbgDNJ5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 05:57:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33845 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437925AbgDNJ5O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 05:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586858232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/zXi527zepbl7siVmXAa1ZCzhQAkrLalFUWLrUIrT0=;
        b=Ie+muJQr3K/XhFet7ubnjkQ1H67H/8l16wxjyz++2gsMhS9A68za/WO4rmXJK13NibR6N6
        gamD0bLH5ipwv8Rnpp4/JwAvaTJEM3fFnEOq5Ys+7wFwFpmPkMKkBA5NmITiVqBhENH3B/
        7XCBwjAw2QtiZ6UeLc018aenprhAk7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-0lYqNjreN4yidKt2o6lW0w-1; Tue, 14 Apr 2020 05:57:10 -0400
X-MC-Unique: 0lYqNjreN4yidKt2o6lW0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF1EA802685;
        Tue, 14 Apr 2020 09:57:08 +0000 (UTC)
Received: from carbon (unknown [10.40.208.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BB3C60BE1;
        Tue, 14 Apr 2020 09:56:57 +0000 (UTC)
Date:   Tue, 14 Apr 2020 11:56:56 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= 
        <toke@redhat.com>, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>, brouer@redhat.com
Subject: Re: [PATCH RFC v2 29/33] xdp: allow bpf_xdp_adjust_tail() to grow
 packet size
Message-ID: <20200414115656.2f0e6ac0@carbon>
In-Reply-To: <158634678170.707275.10720666808605360076.stgit@firesoul>
References: <158634658714.707275.7903484085370879864.stgit@firesoul>
        <158634678170.707275.10720666808605360076.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Wed, 08 Apr 2020 13:53:01 +0200 Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7628b947dbc3..4d58a147eed0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3422,12 +3422,26 @@ static const struct bpf_func_proto bpf_xdp_adjust_head_proto = {
>  
>  BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
>  {
> +	void *data_hard_end = xdp_data_hard_end(xdp);
>  	void *data_end = xdp->data_end + offset;
>  
[...]
> +	/* DANGER: ALL drivers MUST be converted to init xdp->frame_sz
> +	 * - Adding some chicken checks below
> +	 * - Will (likely) not be for upstream
> +	 */
> +	if (unlikely(xdp->frame_sz < (xdp->data_end - xdp->data_hard_start))) {
> +		WARN(1, "Too small xdp->frame_sz = %d\n", xdp->frame_sz);
> +		return -EINVAL;
> +	}
> +	if (unlikely(xdp->frame_sz > PAGE_SIZE)) {
> +		WARN(1, "Too BIG xdp->frame_sz = %d\n", xdp->frame_sz);
> +		return -EINVAL;
> +	}

Any opinions on above checks?
Should they be removed or kept?

The idea is to catch drivers that forgot to update xdp_buff->frame_sz,
by doing some sanity checks on this uninit value.  If I correctly
updated all XDP drivers in this patchset, then these checks should be
unnecessary, but will this be valuable for driver developers converting
new drivers to XDP to have these WARN checks?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

Help for reviewers:

+/* Reserve memory area at end-of data area.
+ *
+ * This macro reserves tailroom in the XDP buffer by limiting the
+ * XDP/BPF data access to data_hard_end.  Notice same area (and size)
+ * is used for XDP_PASS, when constructing the SKB via build_skb().
+ */
+#define xdp_data_hard_end(xdp)				\
+	((xdp)->data_hard_start + (xdp)->frame_sz -	\
+	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

