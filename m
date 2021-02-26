Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9F326208
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 12:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBZLgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 06:36:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229550AbhBZLgi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 06:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614339311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDZwOEVS9t1txKosxZ6AgJPd1yK0dZxFgh8hc7RQj8E=;
        b=T50RlOvQLYgZ5Vf56ucNvbnu1AF/2ynGvZZ/NMThttnypFuaAW/yj38a9mGMBb8j4NjygU
        VSMT5qFoKI/9kAZip0rLyroHZGmHz30cc2owBmnketwSTkoW9ehXxqwsg7vcYhpXReyNOP
        X92tiPNMre4WP7uGt8KaU2hVpkf2AMk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-3hgFCxrrMAisbgoc9V95kQ-1; Fri, 26 Feb 2021 06:35:10 -0500
X-MC-Unique: 3hgFCxrrMAisbgoc9V95kQ-1
Received: by mail-ed1-f71.google.com with SMTP id z12so4340950edb.0
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 03:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sDZwOEVS9t1txKosxZ6AgJPd1yK0dZxFgh8hc7RQj8E=;
        b=to3gkHLWfCt9jVSMzyEwx18hwmchhBdDRuSU0/neJ+WcjEqjtMVgT5t8svnPV25oiw
         fHF2YoV/Easux+kfvtjxvIWkWM8UvDaWIPg6pECw2DscWHmxjzqSpM1cL7Sxqab34dyA
         fpntNtvPTqODKBPDL7hB0KSAexJKEOVSUTFQWcamuchn0UA3tvbnkLI3nkaQYFULdDu6
         E9HluwXirx0iP6G+r8Nyt9qIGoJwLIweBYrmsZcmfiFJFMxzL9sXV/9CA77eOjVHXbZy
         hhQVFgKK3MJpJPUHakMlnMfVJ7VmBbxmSnlEFD87MIKpi3wOw+KogTL4geTZY7LzB+RZ
         bZXQ==
X-Gm-Message-State: AOAM5309plhHR/NMbMVzKMj5s1+tRExkz7As6A3laEkePxi+m2SDqA+8
        mBzv4sqmQBoCSxkIRwhAs3+bgJydlM7Pfhf7vs76jOv9APq+cQ/Z2zy56FoHijzjLK1OVj0IRkV
        HUBJkEmaWM9Wt
X-Received: by 2002:aa7:d58e:: with SMTP id r14mr2688553edq.332.1614339308629;
        Fri, 26 Feb 2021 03:35:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJ+RlYOjg/zeHA4woGsFSGt2uX+17bcQS6qorYsPRKXGF5hGmkznvNlqIdkgMOJB2/ffk+bQ==
X-Received: by 2002:aa7:d58e:: with SMTP id r14mr2688523edq.332.1614339308322;
        Fri, 26 Feb 2021 03:35:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q20sm5186759ejs.17.2021.02.26.03.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:35:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9D548180094; Fri, 26 Feb 2021 12:35:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        bjorn.topel@intel.com, maciej.fijalkowski@intel.com,
        hawk@kernel.org, magnus.karlsson@intel.com,
        john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net
Subject: Re: [PATCH bpf-next v4 0/2] Optimize
 bpf_redirect_map()/xdp_do_redirect()
In-Reply-To: <20210226112322.144927-1-bjorn.topel@gmail.com>
References: <20210226112322.144927-1-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Feb 2021 12:35:07 +0100
Message-ID: <87v9afysd0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> Hi XDP-folks,
>
> This two patch series contain two optimizations for the
> bpf_redirect_map() helper and the xdp_do_redirect() function.
>
> The bpf_redirect_map() optimization is about avoiding the map lookup
> dispatching. Instead of having a switch-statement and selecting the
> correct lookup function, we let bpf_redirect_map() be a map operation,
> where each map has its own bpf_redirect_map() implementation. This way
> the run-time lookup is avoided.
>
> The xdp_do_redirect() patch restructures the code, so that the map
> pointer indirection can be avoided.
>
> Performance-wise I got 3% improvement for XSKMAP
> (sample:xdpsock/rx-drop), and 4% (sample:xdp_redirect_map) on my
> machine.
>
> More details in each commit.
>
> @Jesper/Toke I dropped your Acked-by: on the first patch, since there
> were major restucturing. Please have another look! Thanks!

Will do! Did you update the performance numbers above after that change?

-Toke

