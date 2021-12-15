Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B61476210
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 20:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhLOTrj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 14:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLOTrj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 14:47:39 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C34C061574
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 11:47:39 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id a23so16379512pgm.4
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/nzJKUAXJanUv0iziYPtlESzABqvnZMe5y0XLDWJrKw=;
        b=aENYMKT1+mzFUHFfqzywKw81KTQDiyqGvfnKdxYQ6t5bAoxzqLjdlYuAgmStgNUDT/
         XQrT5IQxMlrAf6t9STOESR2pdoWM6igTQDC5Lpgyb2wz6zZ4/ZspKmtXKoeuiAtDeImH
         UfsergFD2YkSMZTQ7E1LhZPARZeeJi+x2LN31mchVhP0v2AYXnIH5lOmUSlRb7y0e2LM
         KaTG8OUQH2Ft2bg8WO3C5gm7vwZIqnaeV3/nlkgsx+GnkoToImxU2sjNHFmBkFXAzJOI
         bdm5SB3VgvsDIYJnHNMviSKEFyWcXRPspq9AvPc0RhIMnVBdyEAwnfbGvw4tON7lZQn5
         a/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/nzJKUAXJanUv0iziYPtlESzABqvnZMe5y0XLDWJrKw=;
        b=ZbOBJulga7c+zAHekcMY4XVDc2Qo2igN3uT5/ArQyzvR5wP8Tv/qh5FSqKRrlibbix
         HvKTll8Q9uMEXSFKQz38BmvrED7akQ53EbsPmqrzSHihFe5kY7XOnJXRpAo5xnCGkg/O
         enPR1g/ygeA5fvcfOs6/7nGOSvERgxto4juz4wncuiCY15DwUWBO2kjaZBBOaN7jCPOn
         6DQU0wF4VKkRukHd6n3GRrkGWYgda4Pl++NYnQ9RmCrg5JHYpWI/oS5SVqpc1vW4WUcn
         foIzkHIuQzE18olkEFGVZ/rcZmY1v+OlRYHHHhBigX87yMPxbz1RzQXatmYHHCpWsMdQ
         GOMA==
X-Gm-Message-State: AOAM530PnMZgL596gyydHeu4GSqYNVLJaP9qDJ9GL8Psqu03AAG92nN6
        E6+zYLGIdELmIeTp7JkxWZxml24aiTQ=
X-Google-Smtp-Source: ABdhPJz9VSOQ4vqdHy1RUAvnYCs4hVAtfB5xdOvT0vn/cCVnw2nCSzSBdMBqWA5zmkaZQVdgB2RqJQ==
X-Received: by 2002:a05:6a00:7cc:b0:49f:9cf1:2969 with SMTP id n12-20020a056a0007cc00b0049f9cf12969mr10610359pfu.12.1639597658469;
        Wed, 15 Dec 2021 11:47:38 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::1:58b5])
        by smtp.gmail.com with ESMTPSA id s24sm3226508pfm.100.2021.12.15.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:47:38 -0800 (PST)
Date:   Wed, 15 Dec 2021 11:47:36 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/3] bpf: remove the cgroup -> bpf header
 dependecy
Message-ID: <20211215194736.oil2sn5eun4dfp44@ast-mbp.dhcp.thefacebook.com>
References: <20211215181231.1053479-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215181231.1053479-1-kuba@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 15, 2021 at 10:12:28AM -0800, Jakub Kicinski wrote:
> Changes to bpf.h tend to clog up our build systems. The netdev/bpf
> build bot does incremental builds to save time (reusing the build
> directory to only rebuild changed objects).
> 
> This is the rough breakdown of how many objects needs to be rebuilt
> based on file touched:
> 
> kernel.h      40633
> bpf.h         17881
> bpf-cgroup.h  17875
> skbuff.h      10696
> bpf-netns.h    7604
> netdevice.h    7452
> filter.h       5003
> tcp.h          4048
> sock.h         4959
> 
> As the stats show touching bpf.h is _very_ expensive.
> 
> Bulk of the objects get rebuilt because MM includes cgroup headers.
> Luckily bpf-cgroup.h does not fundamentally depend on bpf.h so we
> can break that dependency and reduce the number of objects.
> 
> With the patches applied touching bpf.h causes 5019 objects to be rebuilt
> (17881 / 5019 = 3.56x). That's pretty much down to filter.h plus noise.
> 
> v2:
> Try to make the new headers wider in scope. Collapse bpf-link and
> bpf-cgroup-types into one header, which may serve as "BPF kernel
> API" header in the future if needed. Rename bpf-cgroup-storage.h
> to bpf-inlines.h.
> 
> Add a fix for the s390 build issue.
> 
> v3: https://lore.kernel.org/all/20211215061916.715513-1-kuba@kernel.org/
> Merge bpf-includes.h into bpf.h.
> Remember to git format-patch after fixing build issues.
> 
> v4:
> Change course - break off cgroup instead of breaking off bpf.

Nice. I think this approach is the best so far.
I'll wait a bit for 0-bot to test it with different configs
and BPF CI to catch up.
