Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ABC2A8B8A
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 01:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgKFAlS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 19:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732696AbgKFAlR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 19:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604623276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VtZ0cu4C3egLjiBXqxASyXpEQV3SfJj6r0kl3jNPoYU=;
        b=HwcM1FcACLk8mmxy9A0RVFUUmljF7BKPzW00ZqZkaGEr65XAPAdHBi5dGXvTVq2IzIO78U
        nAcUAHMv90D7BKR1PcjRSYDYlDd7rRZQVjgZP2K4ss3soS0BO+dO+Ic4B2wz2f6iVAs2eS
        bFtj1CUT7NWWEbayFkQ2sMQlt0ZJ3v8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-zCnaVYpuNrey0TTPFjPobQ-1; Thu, 05 Nov 2020 19:41:14 -0500
X-MC-Unique: zCnaVYpuNrey0TTPFjPobQ-1
Received: by mail-pg1-f198.google.com with SMTP id j5so2405950pgt.4
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 16:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VtZ0cu4C3egLjiBXqxASyXpEQV3SfJj6r0kl3jNPoYU=;
        b=mUDwinCDAxYDs+XbujMksx1zjngXEGhhlIisfT+qTGWpAO3DEUXaZp5MGmsYDHdmOo
         M/6YXenmhrkc1ZEjzcYXcYEtg4h3inRTGfjd52ETH9SvlfP7CWauqamGi8nb4Nfz1ZvO
         M5SM96zoO8EEkukg8GObrm3Zz9CghyoGU1QArx2sSYmXxwBcF4ahLpRK+N2/yOw0N2C5
         txAmZ7azFyfHk+9NZZV261BBqTVrqbcdn1H5ke38biJV0Oc5Bd2lDxrUX3c6/xHTBIc3
         4JJx+YLoLAWP/M5UCKHLN3DujVb+NdC/s+nPdbrABydmI0HKoAVXohdiSBMWi+dZdjDd
         eqhw==
X-Gm-Message-State: AOAM532+trjVvY8cSTdY+Q3+NyFvWADY5Cx2ZFf48O0fg09rRL7j45OY
        dGsPlKAF24H2MzucnoVt0r1r9fdNYmBoDK5J9enQk3ArFCGePKY7zO/65fczHwCyw7EeH7ZxhBQ
        bKxF170MTpoE=
X-Received: by 2002:a17:902:9006:b029:d6:e5d0:abfd with SMTP id a6-20020a1709029006b02900d6e5d0abfdmr4774016plp.69.1604623273927;
        Thu, 05 Nov 2020 16:41:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyFWVpTU+blewwK7OzusR3w9n8OaxrHfpl2cY3L/pkHd1Gp2gTOscmDke4Jg+iHOXg8yqndw==
X-Received: by 2002:a17:902:9006:b029:d6:e5d0:abfd with SMTP id a6-20020a1709029006b02900d6e5d0abfdmr4774005plp.69.1604623273644;
        Thu, 05 Nov 2020 16:41:13 -0800 (PST)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ji2sm3527885pjb.35.2020.11.05.16.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:41:12 -0800 (PST)
Date:   Fri, 6 Nov 2020 08:41:03 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCHv3 iproute2-next 3/5] lib: add libbpf support
Message-ID: <20201106004103.GY2408@dhcp-12-153.nay.redhat.com>
References: <20201028132529.3763875-1-haliu@redhat.com>
 <20201029151146.3810859-1-haliu@redhat.com>
 <20201029151146.3810859-4-haliu@redhat.com>
 <db14a227-1d5e-ed3a-9ada-ecf99b526bf6@gmail.com>
 <20201104082203.GP2408@dhcp-12-153.nay.redhat.com>
 <61a678ce-e4bc-021b-ab4e-feb90e76a66c@gmail.com>
 <20201105075121.GV2408@dhcp-12-153.nay.redhat.com>
 <3c3f892a-6137-d176-0006-e5ddaeeed2b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3f892a-6137-d176-0006-e5ddaeeed2b5@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 08:25:12AM -0700, David Ahern wrote:
> > Sorry, when trying to rename the functions. I just found another issue.
> > Even we fix the conflicts right now. What if libbpf add new functions
> > and we got another conflict in future? There are too much bpf functions
> > in bpf_legacy.c which would have more risks for naming conflicts..
> > 
> > With bpf_libbpf.c, there are less functions and has less risk for naming
> > conflicts. So I think it maybe better to not include libbpf.h in bpf_legacy.c.
> > What do you think?
> > 
> >
> 
> Is there a way to sort the code such that bpf_legacy.c is not used when
> libbpf is enabled and bpf_libbpf.c is not compiled when libbpf is disabled.
> 

That what the current code did. In lib/Makefile we only compile bpf_libbpf.o
when libbpf enabled.

ifeq ($(HAVE_LIBBPF),y)
UTILOBJ += bpf_libbpf.o
endif

But bpf code in ipvrf.c is special as it calls both legacy code an libbpf code.
If we put it in bpf_legacy.c, then bpf_legacy.c will be corrupt by libbpf.h.
If we put it in bpf_libbpf.c, then we can't build without bpf_libbpf.o when
libbpf disable.

I haven't figured out a better solution.

Thanks
Hangbin

