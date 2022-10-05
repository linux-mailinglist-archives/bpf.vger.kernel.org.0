Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77BB5F5232
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 12:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiJEKG0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJEKGX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 06:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950D4659FE
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 03:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664964379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQShYH5psmd1zd5q0ecnoXE5H0Hdi6MU/XmKyeWxamE=;
        b=NIwWG69zAEETtawuxsHrE4TrtugnyZ5MMaLVqDL8By50PNC5kFEvC1tM50S6dGkitXcqJR
        ryFWwyb4xEwUISSTNLFPhoz45/do7nr5nwt9REEiel0lfWI1bTo7l2YGXIyComNyS8TNVL
        rFJEhKjYhhXA/f7rPwsPApvtZB7kojU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-490-yhmoQZoSPAqgxqO9UjXI0w-1; Wed, 05 Oct 2022 06:06:18 -0400
X-MC-Unique: yhmoQZoSPAqgxqO9UjXI0w-1
Received: by mail-ej1-f71.google.com with SMTP id oz10-20020a1709077d8a00b00783c1ad301fso6222575ejc.2
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 03:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=gQShYH5psmd1zd5q0ecnoXE5H0Hdi6MU/XmKyeWxamE=;
        b=phJykiL0ZPWJMrcfnTeyp/lZMtnwHH6uehiwNKtxcrC/yuOOv9aG88sazYkMAzoPZb
         HnLXC7Pj9k2kpqmVWjo3A5tommf01hnzpoiaxTBfv2QvOHuku/KsgaIYjKBE5luFjriw
         Fu4H+o5WhN3gf+Np4UmqsMKWlQIpKlEIWInj2cm8RMyo6KQh28AA4GJBznooKkjKll3s
         EXww31E5hJ3JVJ77Vygh+nOIrJq96fs4bzU65C/7A/E6OcXxPwtY+YQmPgH+MJWpThJ2
         TA20/edHsblzqpFqwMT6MQm69xQYwT+lJDgGXAuc87F8QQYKIBrSdSl55kA33Hhivh9j
         vNNw==
X-Gm-Message-State: ACrzQf1gkF01mXD+LYRmjGeCj8COPlBuZw0nQ7CdWSnM36PYs1AJeEyz
        rKhh4iJxxU0EFtIP9NaH5GwXSZDfM+vP4iQEnXMKAuNytxdXTTIL3rTsm0imLY/aShKJSPPRhu5
        fgn/3zmurCxgw
X-Received: by 2002:a17:907:7e8b:b0:78c:c4a8:a91a with SMTP id qb11-20020a1709077e8b00b0078cc4a8a91amr8767428ejc.714.1664964376982;
        Wed, 05 Oct 2022 03:06:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Cb0A2SFrWuei+/Wg8WHMe1yb33J5QbevOnP70Nt/j0/2ImCeBNToi3agCGynSgHe2cXwlIA==
X-Received: by 2002:a17:907:7e8b:b0:78c:c4a8:a91a with SMTP id qb11-20020a1709077e8b00b0078cc4a8a91amr8767398ejc.714.1664964376540;
        Wed, 05 Oct 2022 03:06:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ku16-20020a170907789000b0078d38cda2b1sm143493ejc.202.2022.10.05.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 03:06:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0C89264EB73; Wed,  5 Oct 2022 12:06:15 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        xdp-hints@xdp-project.net, larysa.zaremba@intel.com,
        memxor@gmail.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        mtahhan@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dave@dtucker.co.uk, Magnus Karlsson <magnus.karlsson@intel.com>,
        bjorn@kernel.org
Subject: Re: [xdp-hints] Re: [PATCH RFCv2 bpf-next 00/18] XDP-hints: XDP
 gaining access to HW offload hints via BTF
In-Reply-To: <CAKH8qBtdAeHqbWa33yO-MMgC2+h2qehFn8Y_C6ZC1=YsjQS-Bw@mail.gmail.com>
References: <166256538687.1434226.15760041133601409770.stgit@firesoul>
 <Yzt2YhbCBe8fYHWQ@google.com>
 <35fcfb25-583a-e923-6eee-e8bbcc19db17@redhat.com>
 <CAKH8qBuYVk7QwVOSYrhMNnaKFKGd7M9bopDyNp6-SnN6hSeTDQ@mail.gmail.com>
 <5ccff6fa-0d50-c436-b891-ab797fe7e3c4@linux.dev>
 <20221004175952.6e4aade7@kernel.org>
 <CAKH8qBtdAeHqbWa33yO-MMgC2+h2qehFn8Y_C6ZC1=YsjQS-Bw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 05 Oct 2022 12:06:15 +0200
Message-ID: <87h70iinzc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> On Tue, Oct 4, 2022 at 5:59 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 4 Oct 2022 17:25:51 -0700 Martin KaFai Lau wrote:
>> > A intentionally wild question, what does it take for the driver to return the
>> > hints.  Is the rx_desc and rx_queue enough?  When the xdp prog is calling a
>> > kfunc/bpf-helper, like 'hwtstamp = bpf_xdp_get_hwtstamp()', can the driver
>> > replace it with some inline bpf code (like how the inline code is generated for
>> > the map_lookup helper).  The xdp prog can then store the hwstamp in the meta
>> > area in any layout it wants.
>>
>> Since you mentioned it... FWIW that was always my preference rather than
>> the BTF magic :)  The jited image would have to be per-driver like we
>> do for BPF offload but that's easy to do from the technical
>> perspective (I doubt many deployments bind the same prog to multiple
>> HW devices)..
>
> +1, sounds like a good alternative (got your reply while typing)
> I'm not too versed in the rx_desc/rx_queue area, but seems like worst
> case that bpf_xdp_get_hwtstamp can probably receive a xdp_md ctx and
> parse it out from the pre-populated metadata?
>
> Btw, do we also need to think about the redirect case? What happens
> when I redirect one frame from a device A with one metadata format to
> a device B with another?

Yes, we absolutely do! In fact, to me this (redirects) is the main
reason why we need the ID in the packet in the first place: when running
on (say) a veth, an XDP program needs to be able to deal with packets
from multiple physical NICs.

As far as API is concerned, my hope was that we could solve this with a
CO-RE like approach where the program author just writes something like:

hw_tstamp = bpf_get_xdp_hint("hw_tstamp", u64);

and bpf_get_xdp_hint() is really a macro (or a special kind of
relocation?) and libbpf would do the following on load:

- query the kernel BTF for all possible xdp_hint structs
- figure out which of them have an 'u64 hw_tstamp' member
- generate the necessary conditionals / jump table to disambiguate on
  the BTF_ID in the packet


Now, if this is better done by a kfunc I'm not terribly opposed to that
either, but I'm not sure it's actually better/easier to do in the kernel
than in libbpf at load time?

-Toke

