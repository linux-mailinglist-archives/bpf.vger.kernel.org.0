Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1DA1E9221
	for <lists+bpf@lfdr.de>; Sat, 30 May 2020 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgE3Og4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 May 2020 10:36:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22625 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729090AbgE3Og4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 May 2020 10:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590849414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYF29yT1seaF6Nn7oxZie9sNTdhmGFUGLY8Riq5cZvY=;
        b=B420OcOucyuwPOdXQ3xzbKXKnv5yJDS9abHS9oeb87C3EybZDAPtui27owzLc0nHUxzQtH
        5DggwxKR/4qJQB7M33AHj2f/n8gKjfKihA8kH+dtY/CNAx/UEC9P2ZGdS5rEo3N/vsMWNZ
        wkb3zskx5luYm/FQwMoJps/3AMTn4j0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-p1ZVQgw5MomKe5qhH4_cyg-1; Sat, 30 May 2020 10:36:51 -0400
X-MC-Unique: p1ZVQgw5MomKe5qhH4_cyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 905DA1855A21;
        Sat, 30 May 2020 14:36:49 +0000 (UTC)
Received: from carbon (unknown [10.40.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A192B62ABC;
        Sat, 30 May 2020 14:36:44 +0000 (UTC)
Date:   Sat, 30 May 2020 16:36:43 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     David Ahern <dsahern@gmail.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        brouer@redhat.com
Subject: Re: [PATCH bpf-next RFC 2/3] bpf: devmap dynamic map-value storage
 area based on BTF
Message-ID: <20200530163643.290eb18c@carbon>
In-Reply-To: <CAEf4BzbL1ftGZ9x0hvFDc-PGNexTuMv67VxT=q2NF0y6im6+cg@mail.gmail.com>
References: <159076794319.1387573.8722376887638960093.stgit@firesoul>
        <159076798566.1387573.8417040652693679408.stgit@firesoul>
        <CAEf4BzbL1ftGZ9x0hvFDc-PGNexTuMv67VxT=q2NF0y6im6+cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 30 May 2020 00:19:50 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Fri, May 29, 2020 at 8:59 AM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > The devmap map-value can be read from BPF-prog side, and could be used for a
> > storage area per device. This could e.g. contain info on headers that need  
> 
> If BPF program needs a storage area per device, why can't it just use
> a separate map or just plain array (both keyed by ifindex) to store
> whatever it needs per-device? It's not clear why this flexibility and
> complexity is needed from the description above.

Sorry I though it was obvious, it is for performance reasons and to
reduce the number of maps needed.  We do a lookup in the devmap anyhow,
thus this memory will be cache-hot.  Doing another lookup in a separate
map, which is not guaranteed to be cache-hot, will be wasting cycles.

> > to be added when packet egress this device.
> >
> > This patchset adds a dynamic storage member to struct bpf_devmap_val. More
> > importantly the struct bpf_devmap_val is made dynamic via leveraging and
> > requiring BTF for struct sizes above 4. The only mandatory struct member is
> > 'ifindex' with a fixed offset of zero.
> >
> > Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > ---
> >  kernel/bpf/devmap.c |  216 ++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 185 insertions(+), 31 deletions(-)
> >  
> 
> [...]
> 



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

