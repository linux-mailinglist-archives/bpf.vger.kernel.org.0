Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9C2DBCED
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 09:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLPIrD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 03:47:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgLPIrC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Dec 2020 03:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608108336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYnxKZ4kumZ9glZzuqGoRnqAJc8ZF8TPj7iOOqqewlI=;
        b=H6/rzTlujHuetl0EeAqoXDL16pYcRinh+0MzUkhL9F+pEz6e/+sQcVSE1NNxLeOZMhvWJE
        eUsOGj8yg7X75KeDoUHxY4ej4kRFIYOoyhQ27ySv1NCcJ8YbilTJrdjABmPjn4eVN1JiLa
        Ge54JoWCA9Ea2vHds75aEV/3duwUi7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-sUjnykzeM-CadnGgUikm8w-1; Wed, 16 Dec 2020 03:45:33 -0500
X-MC-Unique: sUjnykzeM-CadnGgUikm8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12004107ACE8;
        Wed, 16 Dec 2020 08:45:32 +0000 (UTC)
Received: from carbon (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A33C35D9E3;
        Wed, 16 Dec 2020 08:45:25 +0000 (UTC)
Date:   Wed, 16 Dec 2020 09:45:24 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     brouer@redhat.com, Ivan Babrou <ivan@cloudflare.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next] sfc: reduce the number of requested xdp ev
 queues
Message-ID: <20201216094524.0c6e521c@carbon>
In-Reply-To: <205ba636-f180-3003-a41c-828e1fe1a13b@gmail.com>
References: <20201215012907.3062-1-ivan@cloudflare.com>
        <20201215104327.2be76156@carbon>
        <205ba636-f180-3003-a41c-828e1fe1a13b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 15 Dec 2020 18:49:55 +0000
Edward Cree <ecree.xilinx@gmail.com> wrote:

> On 15/12/2020 09:43, Jesper Dangaard Brouer wrote:
> > On Mon, 14 Dec 2020 17:29:06 -0800
> > Ivan Babrou <ivan@cloudflare.com> wrote:
> >   
> >> Without this change the driver tries to allocate too many queues,
> >> breaching the number of available msi-x interrupts on machines
> >> with many logical cpus and default adapter settings:
> >>
> >> Insufficient resources for 12 XDP event queues (24 other channels, max 32)
> >>
> >> Which in turn triggers EINVAL on XDP processing:
> >>
> >> sfc 0000:86:00.0 ext0: XDP TX failed (-22)  
> > 
> > I have a similar QA report with XDP_REDIRECT:
> >   sfc 0000:05:00.0 ens1f0np0: XDP redirect failed (-22)
> > 
> > Here we are back to the issue we discussed with ixgbe, that NIC / msi-x
> > interrupts hardware resources are not enough on machines with many
> > logical cpus.
> > 
> > After this fix, what will happen if (cpu >= efx->xdp_tx_queue_count) ?  
>
> Same as happened before: the "failed -22".  But this fix will make that
>  less likely to happen, because it ties more TXQs to each EVQ, and it's
>  the EVQs that are in short supply.
>

So, what I hear is that this fix is just pampering over the real issue.

I suggest that you/we detect the situation, and have a code path that
will take a lock (per 16 packets bulk) and solve the issue.

If you care about maximum performance you can implement this via
changing the ndo_xdp_xmit pointer to the fallback function when needed,
to avoid having a to check for the fallback mode in the fast-path.

>
> (Strictly speaking, I believe the limitation is a software one, that
>  comes from the driver's channel structures having been designed a
>  decade ago when 32 cpus ought to be enough for anybody... AFAIR the
>  hardware is capable of giving us something like 1024 evqs if we ask
>  for them, it just might not have that many msi-x vectors for us.)
> Anyway, the patch looks correct, so
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

