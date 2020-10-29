Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85FD29E63C
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 09:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgJ2IUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 04:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727159AbgJ2IUG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Oct 2020 04:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603959605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TeMqk+ih9QIaMMmCc/T/951IImRhCGbNj2uycs0M7UY=;
        b=Y68nur89F8pFSvOWYxG1mTNLh0o8bqLvSYknPcfhmcMYWX73Z5Vxp+BCXASN0yfuh/+hMh
        B/rUEJZjfehy34zmXPhNXMXIWGYwPQaxvg9d0EM93EGZKk2QNTtSYlPZwGHH12pG2rTRMr
        qaAXDB9pbDyAJs+RX7fiyZdSqo+T8MA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-cbbOKnKZP6a5bKk0x1vaZA-1; Wed, 28 Oct 2020 23:17:26 -0400
X-MC-Unique: cbbOKnKZP6a5bKk0x1vaZA-1
Received: by mail-pf1-f199.google.com with SMTP id a27so1055094pfl.17
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 20:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TeMqk+ih9QIaMMmCc/T/951IImRhCGbNj2uycs0M7UY=;
        b=KNV6qGFXbsSea9HQtf1B8zqlNh46kV2ORq29d1v//NJwNwFQ8GWZHIr6b9/lH0g8R/
         x/1kmNNZ9HDtQ12Ne8aQt4tMGj7f9ERDhroFPNBzkPRbWWlvQ3GH5zf0YefWapwgFbQL
         6uU8JtK9li7PGl8aXiXZy0uY5JBTez7Dzz6iO5fydazoSeZ2ehQJuH7l5L9dZOayBGjJ
         4zZLkK5gaVmBGk1g3BgXxe+8tEZNkXwlst2XoPoIIPQ61PXd1fr7iZB8XSXUS43aeYx5
         TKK8Q12qi5KwP9r+72Im3sPEWBRK5jjlJgr3NZf1pKR7vDbfsO+39Xpvi2chvjkgeWpR
         6jCw==
X-Gm-Message-State: AOAM5324/f/2tG/YrHd55d/JMsfl4oqN/eEAR9G2nI+j4jJFd+cTBB09
        HCDQoST1n8A4rVKIaax855zqJuEDJQxoDQMKW4z42xHJ/JWuDUjvleRYlFiLyqFvzjKKyZfhrKB
        enwf7UG9YgGs=
X-Received: by 2002:a17:90a:ff92:: with SMTP id hf18mr2101050pjb.171.1603941445306;
        Wed, 28 Oct 2020 20:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc9B1oRLut5gSl4Uif8mUf/xBMneqUW090I8ZNd/TXhV5lIoxHL5nTWxZlK5T3iwIYRRhZgg==
X-Received: by 2002:a17:90a:ff92:: with SMTP id hf18mr2101023pjb.171.1603941445054;
        Wed, 28 Oct 2020 20:17:25 -0700 (PDT)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v24sm723401pgi.91.2020.10.28.20.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 20:17:24 -0700 (PDT)
Date:   Thu, 29 Oct 2020 11:17:12 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCHv2 iproute2-next 0/5] iproute2: add libbpf support
Message-ID: <20201029031712.GO2408@dhcp-12-153.nay.redhat.com>
References: <20201023033855.3894509-1-haliu@redhat.com>
 <20201028132529.3763875-1-haliu@redhat.com>
 <7babcccb-2b31-f9bf-16ea-6312e449b928@gmail.com>
 <20201029020637.GM2408@dhcp-12-153.nay.redhat.com>
 <7a412e24-0846-bffe-d533-3407d06d83c4@gmail.com>
 <20201029024506.GN2408@dhcp-12-153.nay.redhat.com>
 <99d68384-c638-1d65-5945-2814ccd2e09e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99d68384-c638-1d65-5945-2814ccd2e09e@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 28, 2020 at 09:00:41PM -0600, David Ahern wrote:
> >>> You need to update libbpf to latest version.
> >>
> >> nope. you need to be able to handle this. Ubuntu 20.10 was just
> >> released, and it has a version of libbpf. If you are going to integrate
> >> libbpf into other packages like iproute2, it needs to just work with
> >> that version.
> > 
> > OK, I can replace bpf_program__section_name by bpf_program__title().
> 
> I believe this one can be handled through a compatability check. Looks

Do you mean add a check like

#ifdef has_section_name_support
	use bpf_program__section_name;
#else
	use bpf_program__title;
#endif

> the rename / deprecation is fairly recent (78cdb58bdf15f from Sept 2020).

Yeah... As Andrii said, libbpf is in fast moving..

> >>
> >>>
> >>> But this also remind me that I need to add bpf_program__section_name() to
> >>> configure checking. I will see if I missed other functions' checking.
> >>
> >> This is going to be an on-going problem. iproute2 should work with
> >> whatever version of libbpf is installed on that system.
> > 
> > I will make it works on Ubuntu 20.10, but with whatever version of libbpf?
> > That looks hard, especially with old libbpf.
> > 
> 
> I meant what comes with the OS. I believe I read that Fedora 33 was just
> released as well. Does it have a version of libbpf? If so, please verify
> it compiles and works with that version too. Before committing I will
> also verify it compiles and links against a local version of libbpf (top
> of tree) just to get a range of versions.
> 

Yes, it makes sense. I will also check the libbpf on Fedora 33.

Thanks
Hangbin

