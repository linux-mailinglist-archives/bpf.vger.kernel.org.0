Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140111897B7
	for <lists+bpf@lfdr.de>; Wed, 18 Mar 2020 10:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgCRJPp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Mar 2020 05:15:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26775 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbgCRJPo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Mar 2020 05:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584522943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cdyCBIHnyr7Xc+U6VytosOiXyQzrj+T9xmE6ZmyOJuc=;
        b=AUPQPih5f2A0VzLB+Y7mlVkinRyhIrVPAnSEsOIeSN3Q9W6lDMMUjo+2sFrcG8wp/l4AxJ
        rn9NS3mYZrMgUmQT4SVrdh8xIthzQAjCsFoa7atAS2uy/apye4jY2fc89DKOP+p7woxtN4
        6DjTk0GwkwlU+UoihIPA4q5sbPRDhwI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-PIHaXMllPRuazr4VJTTTIA-1; Wed, 18 Mar 2020 05:15:41 -0400
X-MC-Unique: PIHaXMllPRuazr4VJTTTIA-1
Received: by mail-wr1-f69.google.com with SMTP id c6so11937443wrm.18
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2020 02:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cdyCBIHnyr7Xc+U6VytosOiXyQzrj+T9xmE6ZmyOJuc=;
        b=t6Yd5AqW8tRANS0dgfOPI7VC7qOzqme7DRot5U/rm2/3PA/vGQ5dNbH3CB1gRZleQ/
         oF8+8jiQwtt9AQhI761fn6Bs+VMQ0j27fFQUZWRY4NZjPLN4R+3d0+jcqz8jt23yiskF
         KLApIcdXqKi/9A7xv1aWG4hQ/+uQ+5PqyycDJIOY0wMM9KhzGWwvplnqCaq7Q26OWKl1
         +C9QHNP4Zgb3lUP4fasbyEVKfCqpauZZ85Q3ml5Ei5mwVeCiABCc4XMk8VXbpzjwIFKg
         W2rijlt7+zSeuImdGCWClcxheOTdQ8ulb4xUryzIJ4YmXrGUkMna5U/3hpq9uarbCzk4
         zL7Q==
X-Gm-Message-State: ANhLgQ0qixCjQhZMM/Gp5zWaDUKGbz0X1Mi5LCE/oOMrD+HN7MEiWWvR
        OVvkFX1AkILlJQ9jvyLDATxyn4DqjNOzUSnAhDDBy64+48cy2oTrtvrrhOCiIXa45huZq0vkVcf
        /ZFwVp+mp5VMS
X-Received: by 2002:a1c:408b:: with SMTP id n133mr3930986wma.182.1584522940308;
        Wed, 18 Mar 2020 02:15:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtXC+ycWU260kpNdoWJH/ziotg2rWhVm2qN3+a+nSVwo11VcsvweA5wIQkst78hh7LDfN9Mtg==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr3930962wma.182.1584522940056;
        Wed, 18 Mar 2020 02:15:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q8sm3992856wrc.8.2020.03.18.02.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:15:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 61060180362; Wed, 18 Mar 2020 10:15:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, sameehj@amazon.com
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, zorik@amazon.com, akiyano@amazon.com,
        gtzalik@amazon.com, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH RFC v1 09/15] xdp: clear grow memory in bpf_xdp_adjust_tail()
In-Reply-To: <158446619342.702578.1522482431365026926.stgit@firesoul>
References: <158446612466.702578.2795159620575737080.stgit@firesoul> <158446619342.702578.1522482431365026926.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Mar 2020 10:15:38 +0100
Message-ID: <87v9n2koqt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> To reviewers: Need some opinions if this is needed?
>
> (TODO: Squash patch)
> ---
>  net/core/filter.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 0ceddee0c678..669f29992177 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3432,6 +3432,12 @@ BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
>  	if (unlikely(data_end < xdp->data + ETH_HLEN))
>  		return -EINVAL;
>  
> +	// XXX: To reviewers: How paranoid are we? Do we really need to
> +	/* clear memory area on grow, as in-theory can contain uninit kmem */
> +	if (offset > 0) {
> +		memset(xdp->data_end, 0, offset);
> +	}

This memory will usually be recycled through page_pool or equivalent,
right? So couldn't we clear the pages when they are first allocated?
That way, the only data that would be left there would be packet data
from previous packets...

-Toke

