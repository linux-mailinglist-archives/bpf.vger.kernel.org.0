Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AFB25DCE8
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 17:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgIDPL4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Sep 2020 11:11:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730220AbgIDPL4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 11:11:56 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-ihUSZxV2O2O6a8T76iYLLw-1; Fri, 04 Sep 2020 11:11:54 -0400
X-MC-Unique: ihUSZxV2O2O6a8T76iYLLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 435B018A2257;
        Fri,  4 Sep 2020 15:11:52 +0000 (UTC)
Received: from carbon (unknown [10.40.208.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 359365D9D2;
        Fri,  4 Sep 2020 15:11:44 +0000 (UTC)
Date:   Fri, 4 Sep 2020 17:11:43 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBl?= =?UTF-8?B?bA==?= 
        <bjorn.topel@intel.com>, magnus.karlsson@intel.com,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH bpf-next 3/6] xsk: introduce xsk_do_redirect_rx_full()
 helper
Message-ID: <20200904171143.5868999a@carbon>
In-Reply-To: <20200904135332.60259-4-bjorn.topel@gmail.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
        <20200904135332.60259-4-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri,  4 Sep 2020 15:53:28 +0200
Björn Töpel <bjorn.topel@gmail.com> wrote:

> From: Björn Töpel <bjorn.topel@intel.com>
> 
> The xsk_do_redirect_rx_full() helper can be used to check if a failure
> of xdp_do_redirect() was due to the AF_XDP socket had a full Rx ring.

This is very AF_XDP specific.  I think that the cpumap could likely
benefit from similar approach? e.g. if the cpumap kthread is scheduled
on the same CPU.

But for cpumap we only want this behavior if sched on the same CPU as
RX-NAPI.  This could be "seen" by the cpumap code itself in the case
bq_flush_to_queue() drops packets, check if rcpu->cpu equal
smp_processor_id().  Maybe I'm taking this too far?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

