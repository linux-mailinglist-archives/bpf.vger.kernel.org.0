Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C00648DA87
	for <lists+bpf@lfdr.de>; Thu, 13 Jan 2022 16:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiAMPO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 10:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229838AbiAMPO0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 10:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642086865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGfZ+k9OlisB57+oKH6A/Isnu1LREBlh8q7tlJpACSI=;
        b=cHo4ccs/AzlLMn+XFVi8HYnHMJBe52oyfKEdVby1BfbMpzgkBH9Sn/bSILHc+hLaqffnjE
        4O5BlmHMiwPnIoQO03n+seKLjGfeI1BRT9BriCzhTh2thxQsCFhFCja+iD5NbU09QXF/c3
        dJ8sHxbYjtd7ZC0e9EfBXfGhUlUXzCQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-hTVLxipEN9y124IC2JeWZA-1; Thu, 13 Jan 2022 10:14:24 -0500
X-MC-Unique: hTVLxipEN9y124IC2JeWZA-1
Received: by mail-ed1-f72.google.com with SMTP id h1-20020aa7cdc1000000b0040042dd2fe4so4358857edw.17
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 07:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IGfZ+k9OlisB57+oKH6A/Isnu1LREBlh8q7tlJpACSI=;
        b=8GWn3dugUXmhwuSfO8/mCRfoJGcgU0jdMF+TS1WKVq8zsmaFgut3w9voEdjY8F65Fg
         UDKBlAAal23MsjIIsDyzI8cUZko1zSt8g0roGAc1ZeDiG4ReeLMIpQVKo2wLqXnHSpov
         5isnPvxxdyxcNg8YLbXcjdqe0dZdW8Jn9GBpA21l7zDwrlBrhcxzPKrzVYqdwBZ6/MNR
         vWn8hY5R+/yOmBsVj2up1N9t836QjhNmjWzWsJn+zmHKGHvS0rWI3eBEWBHYHXfo1hx2
         ZhkV7vvIUUde5+eCeuXrFC0YfmMEKpwImNgJG2wiXLFvDQSFIP5R02fhN/94W5P3KhAR
         MG2w==
X-Gm-Message-State: AOAM531TUwPzGnNzUTQM708DiLbTdMFVDZ4VZBjulJTMVEbkwrhyE+Ps
        Q/4a5tpS9WOEU9x7G86wjgFkBySo6S23/yZGIYMTyBscEwEnWne2t9YZHj1egpI2jAVyiqyNwkl
        cYMc/MTHfF2Fp
X-Received: by 2002:a17:907:6e89:: with SMTP id sh9mr3824642ejc.309.1642086863650;
        Thu, 13 Jan 2022 07:14:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/9fBsHG4wzp1we/GYs7B2zesdH+1HyynvDDcjcSEl1M9sJTphrEahZInb2uVrGrZgG4bdfA==
X-Received: by 2002:a17:907:6e89:: with SMTP id sh9mr3824628ejc.309.1642086863435;
        Thu, 13 Jan 2022 07:14:23 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id p25sm1261010edw.75.2022.01.13.07.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 07:14:23 -0800 (PST)
Date:   Thu, 13 Jan 2022 16:14:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Christy Lee <christylee@fb.com>,
        Christy Lee <christyc.y.lee@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        He Kuang <hekuang@huawei.com>, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH bpf-next 2/2] perf: stop using deprecated
 bpf__object_next() API
Message-ID: <YeBBzbfjOgE/wfjK@krava>
References: <20211216222108.110518-1-christylee@fb.com>
 <20211216222108.110518-3-christylee@fb.com>
 <YcGO271nDvfMeSlK@krava>
 <CAEf4BzZpNvEtfsVHUJGfwi_1xM+7-ohBPKPrRo--X=fYkYLrsw@mail.gmail.com>
 <YcMr1LeP6zUBdCiK@krava>
 <CAEf4Bzb2HWiuJmeb6WxE2Dift5qQOLBE=j1ZqfpVMjuWV3+EDg@mail.gmail.com>
 <CAPqJDZouQHpUXv4dEGKKe=UjwkZu3=GMQ2M9g2zLYOV6a=gZbw@mail.gmail.com>
 <YdRccTaunl9Fo63X@krava>
 <YdWhz1qaRncxNC/6@krava>
 <CAPqJDZpZrrg4UBz19H-HyEMk7rzn+PCe=qpYDR0uHvD3nPr4yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPqJDZpZrrg4UBz19H-HyEMk7rzn+PCe=qpYDR0uHvD3nPr4yw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 06, 2022 at 09:54:38AM -0800, Christy Lee wrote:
> Thank you so much, I was able to reproduce the original tests after applying
> the bug fix. I will submit a new patch set with the more detailed comments.
> 
> The only deprecated functions that need to be removed after this would be
> bpf_program__set_prep() (how perf sets the bpf prologue) and
> bpf_program__nth_fd() (how perf leverages multi instance bpf). They look a
> little more involved and I'm not sure how to approach those. Jiri, would you
> mind taking a look at those please?

hi,
I checked and here's the way perf uses this interface:

  - when bpf object/sources is specified on perf command line
    we use bpf_object__open to load it

  - user can define parameters in the section name for each bpf program
    like:

      SEC("lock_page=__lock_page page->flags")
      int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
      {
             return 1;
      }

    which tells perf to 'prepare' some extra bpf code for the program,
    like to put value of 'page->flags' into 'flags' argument above

  - perf generates extra prologue code to retrieve this data and does
    that before the program is loaded by using bpf_program__set_prep
    callback

  - now the reason why we use bpf_program__set_prep for that, is because
    it allows to create multiple instances for one bpf program

  - we need multiple instances for single program, because probe can
    result in multiple attach addresses (like for inlined functions)
    with possible different ways of getting the arguments we need
    to load

I guess you want to get rid of that whole 'struct instances' related
stuff, is that right?

perf would need to load all the needed instances for program manually
and somehow bypass/workaround bpf_object__load.. is there a way to
manually add extra programs to bpf_object?

thoughts? ;-)

thanks,
jirka

