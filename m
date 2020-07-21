Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA86227CBF
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgGUKTl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGUKTl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 06:19:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6005C0619D8
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 03:19:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so10359054wrh.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=VeNDrBhjoWE2FDcc+COejQI4vRtmFQlWWQalpBKe3iw=;
        b=h3Yuu03b3a+RZR0aykxkNb/7eIfBNJUZoZW2pX1A85kBFF9CW7XRjjeF4AH1dVeZJ4
         3rsWArPRHxCbYsywDBhxyIFWIzEYzfbhbrSJoeM5PlkfFalv4FQi3zb8aCN8sYR4Xtb3
         GObl/tPMIT7qLt+unX3at5nOgs4GFIBOmVO58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=VeNDrBhjoWE2FDcc+COejQI4vRtmFQlWWQalpBKe3iw=;
        b=Re2To5jO1bYwLomFO9/dza5UhCOFGx174XSC6wz3HMuVh/3l19Jsz/KKlbNeXSZ7q+
         c5SfQg4k4VrvxJU1oatnjBPWbSRqZyjqVDHYPBdv2Hn9NYRK/3XPSBlR34yC3uA59C1b
         8Xx5iIr1QZpGIcNIwULougdDHhPnlEQowcf+FrQ+8SV+CiRfxw/+TfDWJ1mmsVY7yl++
         eRu+sYjFCjWwuJ8p/tmbujqNNvYNbzv6FfZRLxSiSkpRAceRq2w/Df+cZ89PByaOwvV2
         C5gVe0UdpF7kE+Va3Qw2lH95jlL6lBi6StDdqVQBd3OLvoPpALC4Q/TYRfnvKyGOgXCK
         94Bw==
X-Gm-Message-State: AOAM53144AXRL0faIXXJ40q4Z+FWsOw/9xn+5MC65NLmOT8ZU0mhUx5m
        LtJkYHnCCK5MHnNUOrr3VPyy5pGKGBk=
X-Google-Smtp-Source: ABdhPJzlj89CEZ/64j2VOxVbnlm6i5eCK/ix8hoOBzMTwL7fXedScdH/sqvkJfL+/2XPB6GssoKIZw==
X-Received: by 2002:adf:8562:: with SMTP id 89mr28112987wrh.57.1595326779538;
        Tue, 21 Jul 2020 03:19:39 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 33sm40552267wri.16.2020.07.21.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 03:19:39 -0700 (PDT)
References: <20200720194225.17de9962@canb.auug.org.au> <a97220b2-9864-eb49-6e27-0ec5b7e5b977@infradead.org> <20200721044902.24ebe681@canb.auug.org.au> <CAADnVQJNU+tm3WT+JuPoY8TTHWXxQ8OJ0sGCLQGq2Avf+Ri7Yw@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: linux-next: Tree for Jul 20 (kernel/bpf/net_namespace)
In-reply-to: <CAADnVQJNU+tm3WT+JuPoY8TTHWXxQ8OJ0sGCLQGq2Avf+Ri7Yw@mail.gmail.com>
Date:   Tue, 21 Jul 2020 12:19:38 +0200
Message-ID: <87365lxj9h.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 20, 2020 at 09:37 PM CEST, Alexei Starovoitov wrote:
> On Mon, Jul 20, 2020 at 11:49 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> On Mon, 20 Jul 2020 08:51:54 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>> >
>> > on i386 or x86_64:
>> >
>> > # CONFIG_INET is not set
>> > # CONFIG_NET_NS is not set
>> >
>> > ld: kernel/bpf/net_namespace.o: in function `bpf_netns_link_release':
>> > net_namespace.c:(.text+0x32c): undefined reference to `bpf_sk_lookup_enabled'
>> > ld: kernel/bpf/net_namespace.o: in function `netns_bpf_link_create':
>> > net_namespace.c:(.text+0x8b7): undefined reference to `bpf_sk_lookup_enabled'
>> > ld: kernel/bpf/net_namespace.o: in function `netns_bpf_pernet_pre_exit':
>> > net_namespace.c:(.ref.text+0xa3): undefined reference to `bpf_sk_lookup_enabled'
>>
>> Caused by commit
>>
>>   1559b4aa1db4 ("inet: Run SK_LOOKUP BPF program on socket lookup")
>>
>> from the bpf-next tree.
>
> Jakub, please take a look.

Sorry about that. Proposed fix:

  https://lore.kernel.org/bpf/20200721100716.720477-1-jakub@cloudflare.com/  
