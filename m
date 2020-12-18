Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB4D2DE087
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 10:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgLRJop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Dec 2020 04:44:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732768AbgLRJoo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 18 Dec 2020 04:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608284598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOXCSSkKJI7de3/xm9Rz2nHMEQCRsQTSOP3r0Paa/+c=;
        b=S07eP9i3wBSuuOZtvUsLW7x+oC9/kIRX6iihl2a3T8UmJXhDlKbNhuz5OejnDpAfvS7IQ3
        40IiXuQTwZZnRM07uGNw0VZCLWmO0mNj3myNjffR/jvUjem5AXBql4ZLsQHrktWNMVfqnZ
        fW/ThdPFQsOTSLi0wXcqvFW93mUPiu4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-albrO7E7PeWJq5PDG1qjOA-1; Fri, 18 Dec 2020 04:43:16 -0500
X-MC-Unique: albrO7E7PeWJq5PDG1qjOA-1
Received: by mail-pg1-f200.google.com with SMTP id i6so1299265pgg.10
        for <bpf@vger.kernel.org>; Fri, 18 Dec 2020 01:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UOXCSSkKJI7de3/xm9Rz2nHMEQCRsQTSOP3r0Paa/+c=;
        b=RcUycKa8Z+el5SEmk1fFGBoReMDxBlUdePcO4O3NHQ1bE7YTBIlLExZwHeXSIhAP83
         WiGlo5F5Ov8ho89bd9PPpx5JFPeEeL91ERdYez0V/zyPYevkRpKOIEDnuswvt9hoVge6
         acREOb9uDJ0p2uLxkZ/7ZnUWXM/ufyWpANls8xzo7HramGn9DbbSYmWbu6oi34LWFmaM
         9n2IqHCJsL3aT3ctiWgGY0kxeKGWNDQPuTjHWkSstVxCrZdyP4JA2n1fPNf5OL1P8Ex9
         oeJc51jIYoEEXmPW6OZseVG9pfIq/DoZQ1T3Z6ywOTIZEfpDqNBJXx6sbs2SwSpzABy0
         Eu9A==
X-Gm-Message-State: AOAM533DrLlxrcNYBAHeP8Olh5QXxUVFu9IAGuSY0kgUKeulx9q5bB4E
        dsloYAqZUnelvRFeZepeHpyRgdS/e9UaGkrQdGuJh9fjewQRbPlam+pW+xMz03nM3Od7X5JsAYg
        BAOH9KXhScpY=
X-Received: by 2002:a65:5c48:: with SMTP id v8mr3412665pgr.400.1608284595374;
        Fri, 18 Dec 2020 01:43:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyq3MAws4R4Zj4PouAry84JQThg/XDNcfDsfwHUHJWQyW+lVordcg66phsuFMiIN9DmeMif0A==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr3412644pgr.400.1608284595155;
        Fri, 18 Dec 2020 01:43:15 -0800 (PST)
Received: from localhost.localdomain ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s29sm8854119pgn.65.2020.12.18.01.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 01:43:14 -0800 (PST)
Date:   Fri, 18 Dec 2020 17:43:02 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Hangbin Liu <liuhangbin@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCHv12 bpf-next 1/6] bpf: run devmap xdp_prog on flush
 instead of bulk enqueue
Message-ID: <20201218094302.GN273186@localhost.localdomain>
References: <20200907082724.1721685-1-liuhangbin@gmail.com>
 <20201216143036.2296568-1-liuhangbin@gmail.com>
 <20201216143036.2296568-2-liuhangbin@gmail.com>
 <913a8e62-3f17-84ed-e4f5-099ba441508c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913a8e62-3f17-84ed-e4f5-099ba441508c@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

Thanks for the comment.

On Thu, Dec 17, 2020 at 09:07:03AM -0700, David Ahern wrote:
> > +	return n - nframes; /* dropped frames count */
> 
> just return nframes here, since ...
> 
> > +		xdp_drop = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev);
> > +		cnt -= xdp_drop;
> 
> ... that is apparently what you really want.

I will fix this

> > +	if (dst && dst->xdp_prog && !bq->xdp_prog)
> > +		bq->xdp_prog = dst->xdp_prog;
> 
> 
> if you pass in xdp_prog through __xdp_enqueue you can reduce that to just:
> 
> 	if (!bq->xdp_prog)
> 		bq->xdp_prog = xdp_prog;

And this in the next PATCH version.

Thanks
Hangbin

