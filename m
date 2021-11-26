Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752C745F4F8
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 19:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhKZTCh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 14:02:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233285AbhKZTAh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Nov 2021 14:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637953043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kJRu5pi2ZYGFjCg7uZ9/h1dqa3bPmwtHSnnnrguZUw=;
        b=cuXD5XtzBQdcWQlSjRwMkMIwndKm4rilPQvVRrhwgvPgybgQ4HeoRSmdUuNP0ZQ1y5E7kb
        GIzOScs+AeXoay5hH7eLggJLU7IUe3nyf2/FZhTeX+ud6TvRRxExaBUTF1a5PKOdRYRHbA
        Gzn9CKptEGrawky4lRKDaPNdeI5qg5Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-nMQqxPGEMrqjHJMhm2nIew-1; Fri, 26 Nov 2021 13:57:22 -0500
X-MC-Unique: nMQqxPGEMrqjHJMhm2nIew-1
Received: by mail-ed1-f71.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso8680353edj.13
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 10:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2kJRu5pi2ZYGFjCg7uZ9/h1dqa3bPmwtHSnnnrguZUw=;
        b=osX9XBYHeC/vSpg15/aO0Pvwwa7O2+xuQNF+tPvwL3KTZf+vv/8dXJFEFITwpf362z
         J3G2mRoO1sx1rQvBOf9QQvKSubWSvUcuhCbm4HxY0HYJ6FRUBexYaOctFFvNWAGawtlx
         hHDSWMom/Z1c//gqa/sBM4Zwpyq1Qn9hVTpXGi8U+A50HrcFKSCT4pCzjmMHir6bcNre
         XBPAoNp1e7FUJM9IqIeosqc09hldl7WwjCtxMB6yUl8CgtN008zgmfxyzDh1ei5xA3Xn
         fT5jSdQnuOQSxbRAYLVHEQfY4QzWOTqxx+mzCEK12HjvZA88hxmeFjK+E4e5MvdTTsLg
         Fe5A==
X-Gm-Message-State: AOAM531ENh6OrOvI3PxOtB/csaqroMJ07uCVbOgttkgETcL5erqD6Fps
        F+sbdorv68uBqxyoTA/CuA+JBlKvT2ULzgv7O+KdH4P5vcUoDHc8b7fCadV6x2TYGAp11UIf3M4
        PQHb49h2gRn/S
X-Received: by 2002:a17:906:c147:: with SMTP id dp7mr41448246ejc.173.1637953040928;
        Fri, 26 Nov 2021 10:57:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQUOHMd+MdSQiFQFsexVrhcvfY2Jn51agKD/aohQi34dFl0rsHMmUOtbDk8s6RqeGih26P8Q==
X-Received: by 2002:a17:906:c147:: with SMTP id dp7mr41448221ejc.173.1637953040708;
        Fri, 26 Nov 2021 10:57:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-118.dyn.eolo.it. [146.241.234.118])
        by smtp.gmail.com with ESMTPSA id yc24sm3401247ejb.104.2021.11.26.10.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 10:57:20 -0800 (PST)
Message-ID: <8f6f900b2b48aaedf031b20a7831ec193793768b.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] bpf: let bpf_warn_invalid_xdp_action()
 report more info
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Date:   Fri, 26 Nov 2021 19:57:19 +0100
In-Reply-To: <20211126101941.029e1d7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1637924200.git.pabeni@redhat.com>
         <277a9483b38f9016bc78ce66707753681684fbd7.1637924200.git.pabeni@redhat.com>
         <20211126101941.029e1d7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2021-11-26 at 10:19 -0800, Jakub Kicinski wrote:
> On Fri, 26 Nov 2021 12:19:11 +0100 Paolo Abeni wrote:
> > -void bpf_warn_invalid_xdp_action(u32 act)
> > +void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act)
> >  {
> >  	const u32 act_max = XDP_REDIRECT;
> >  
> > -	pr_warn_once("%s XDP return value %u, expect packet loss!\n",
> > +	pr_warn_once("%s XDP return value %u on prog %s (id %d) dev %s, expect packet loss!\n",
> >  		     act > act_max ? "Illegal" : "Driver unsupported",
> > -		     act);
> > +		     act, prog->aux->name, prog->aux->id, dev->name ? dev->name : "");
> >  }
> 
> Since we have to touch all the drivers each time the prototype of this
> function is changed - would it make sense to pass in rxq instead? It has
> more info which may become useful at some point.

I *think* for this specific scenario the device name provides all the
necessary info - the users need to know the driver causing the issue.

Others similar xdp helpers - e.g. trace_xdp_exception() - have the same
arguments list used here. If the rxq is useful I guess we will have to
change even them, and touch all the drivers anyway.

Cheers,

Paolo

