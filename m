Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0854391AB9
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhEZOvP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 10:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234894AbhEZOvP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 10:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622040583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXLY5p1Ui3F90iWwwgskqQCwFB741w5JDK1m9GlZNc8=;
        b=a+xH6XHQT44ANDgA65pYkNyZs8qaEeZVCBOrqobWhFy55RuOydlj/FoioITrrSQSs+D8lr
        +gqa8XpfO3tAR9xN/ReLrgRvT8Ji0syIGig4OREJbcgCHTYCUeKCs5hbp/jZ5xg819Br8l
        S7aOQekoC+LQ6nDwICYTa1qiHO4flA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-chD9sL6sPRy0gBs8UapwTQ-1; Wed, 26 May 2021 10:49:40 -0400
X-MC-Unique: chD9sL6sPRy0gBs8UapwTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57A64180FD66;
        Wed, 26 May 2021 14:49:38 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CA395D9C6;
        Wed, 26 May 2021 14:49:27 +0000 (UTC)
Date:   Wed, 26 May 2021 16:49:26 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Saeed Mahameed <saeed@kernel.org>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Kubiak, Marcin" <marcin.kubiak@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, bpf@vger.kernel.org,
        brouer@redhat.com
Subject: Re: AF_XDP metadata/hints
Message-ID: <20210526164926.1705a6d3@carbon>
In-Reply-To: <20210525142027.1432-1-alexandr.lobakin@intel.com>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com>
        <DM4PR11MB5422733A87913EFF8904C17184579@DM4PR11MB5422.namprd11.prod.outlook.com>
        <20210507131034.5a62ce56@carbon>
        <DM4PR11MB5422FE9618B3692D48FCE4EA84549@DM4PR11MB5422.namprd11.prod.outlook.com>
        <20210510185029.1ca6f872@carbon>
        <DM4PR11MB54227C25DFD4E882CB03BD3884539@DM4PR11MB5422.namprd11.prod.outlook.com>
        <20210512102546.5c098483@carbon>
        <DM4PR11MB542273C9D8BF63505DC6E21784519@DM4PR11MB5422.namprd11.prod.outlook.com>
        <7b347a985e590e2a422f837971b30bd83f9c7ac3.camel@nvidia.com>
        <DM4PR11MB5422762E82C0531B92BDF09A842B9@DM4PR11MB5422.namprd11.prod.outlook.com>
        <DM4PR11MB5422269F6113268172B9E26A842A9@DM4PR11MB5422.namprd11.prod.outlook.com>
        <DM4PR11MB54224769926B06EE76635A6484299@DM4PR11MB5422.namprd11.prod.outlook.com>
        <20210521153110.207cb231@carbon>
        <1426b
 c91c6c6ee3aaf3d85c4291a12968634e521.camel@kernel.org>
        <87lf85zmuw.fsf@toke.dk>
        <20210525142027.1432-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 25 May 2021 16:20:27 +0200 Alexander Lobakin <alexandr.lobakin@inte=
l.com> wrote:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>=20
> > Saeed Mahameed <saeed@kernel.org> writes:
> >  =20
> > > On Fri, 2021-05-21 at 15:31 +0200, Jesper Dangaard Brouer wrote: =20
[...]
> > > I agree we need full visibility and transparency, i actually recommen=
d:
> > > bpf@vger.kernel.org =20
> >=20
> > +1, please keep this on the list :) =20
>=20
> Sure, let's keep it the classic way.
> I removed the netdev ML from the CCs and added bpf there.

I'm very happy with the momentum, that multiple people and companies are
interested in this XDP-hints subject.  I doubt everyone is subscribed
to bpf@vger.kernel.org and I'm having a hard time remembering who to
Cc.  I see this as a working group effort.

Is anybody against that we create xdp-hints@xdp-project.net (and I/toke
will add people to this list).  This is only to reduce the Cc list, and
we should still keep bpf@vger.kernel.org in Cc as well as our upstream
discussion list.  If nobody object then we will do this in a couple of
days...

(Do let me know offlist, if you want to be removed from this Cc list
prior to creating this... else CC list, you are opting in :-P ).
--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

