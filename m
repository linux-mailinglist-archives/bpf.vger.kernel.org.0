Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29226C31AB
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 13:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCUM0L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 08:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCUMZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 08:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEB54BEB1
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679401497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEM2O5AZZfhh/tv2fFyNWLmvspB6ddGG/uJLc6m+gqo=;
        b=YExc8EATnouPIjllzeUSYifwBr4jkyt8wJnvNLIafkRiwBBp9M2DPyIMm2tuASUShRhvx1
        mLj1SlTXrky7x6UEjkzaEoVh2RCgfvNtrdNEUcT3CFXeLDTYVLe9RrXKbTEq1e4CDN4Wkw
        zwUvs8kfflaHKlJakF3fP1GhxSNRPZ0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-8C717VARMfukEt3sAlVMcQ-1; Tue, 21 Mar 2023 08:24:56 -0400
X-MC-Unique: 8C717VARMfukEt3sAlVMcQ-1
Received: by mail-ed1-f70.google.com with SMTP id r19-20020a50aad3000000b005002e950cd3so21975435edc.11
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 05:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679401495;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEM2O5AZZfhh/tv2fFyNWLmvspB6ddGG/uJLc6m+gqo=;
        b=DOz1Fw5Eexg8T8HQ32Zb5NFcgiff+d7xl5LOURNS7Ha5zPrHcT/39HApl2UHE4mxLh
         da/I8rOXTkzOnj3UYUYBGXgwzstgLktDKmfSa6/K+DBL0xuX2DS3iqy8i3sY74BqVqeT
         etMKWbuL7jUprKuhcyAbBpZzg5wJJvfQLw8Qm3aXg2YDghejrc+ZKpU/QUF0kSvTxV1t
         dietYeuOIDZymKmOIWB4Qk17nr11mxXTOjd6AXhQog6vZ+JWsqwetfjDz0fXcAyOpbFa
         BIph3fU6D/5S+wlbrueL7TPH5RLMVa+9vAqUnR9BIG/AvHoWW2jZ69orU/FQFkOQcA0/
         rwOw==
X-Gm-Message-State: AO0yUKURWixWx5Cpjipi5tCVdy/n/FDWOgpnVDIne2RxrjMV9ZYyYrEV
        bfa49+991/pg6DfMr1Oe0bbdN/5n04HoQIdXQyBi3Z489O/C4KiCl+i8lH0pdaqnv1jQqQejd18
        1sN9/RJv1ygRo
X-Received: by 2002:a17:906:22d4:b0:931:a0cb:1ef1 with SMTP id q20-20020a17090622d400b00931a0cb1ef1mr2582548eja.7.1679401495090;
        Tue, 21 Mar 2023 05:24:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set827uIV36c4Q1wXEiOLcV0/nXL1g/9nodarT2GYrZjfT+RM2GjdaYDd2zEWkCpVLiPEKr/xMQ==
X-Received: by 2002:a17:906:22d4:b0:931:a0cb:1ef1 with SMTP id q20-20020a17090622d400b00931a0cb1ef1mr2582528eja.7.1679401494725;
        Tue, 21 Mar 2023 05:24:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u24-20020a17090657d800b00934823127c8sm2567103ejr.78.2023.03.21.05.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 05:24:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 58FFD9E3449; Tue, 21 Mar 2023 13:24:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net, anthony.l.nguyen@intel.com,
        yoong.siang.song@intel.com, boon.leong.ong@intel.com
Subject: Re: [xdp-hints] Re: [PATCH bpf-next V1 1/7] xdp: bpf_xdp_metadata
 use EOPNOTSUPP for no driver support
In-Reply-To: <f42ff647-11b2-4f09-7652-ad85d35b5617@redhat.com>
References: <167906343576.2706833.17489167761084071890.stgit@firesoul>
 <167906359575.2706833.545256364239637451.stgit@firesoul>
 <ZBTZ7J9B6yXNJO1m@google.com>
 <f42ff647-11b2-4f09-7652-ad85d35b5617@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 21 Mar 2023 13:24:53 +0100
Message-ID: <87bkkm8f6y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <jbrouer@redhat.com> writes:

> On 17/03/2023 22.21, Stanislav Fomichev wrote:
>> On 03/17, Jesper Dangaard Brouer wrote:
>>> When driver doesn't implement a bpf_xdp_metadata kfunc the fallback
>>> implementation returns EOPNOTSUPP, which indicate device driver doesn't
>>> implement this kfunc.
>> 
>>> Currently many drivers also return EOPNOTSUPP when the hint isn't
>>> available, which is inconsistent from an API point of view. Instead
>>> change drivers to return ENODATA in these cases.
>> 
>>> There can be natural cases why a driver doesn't provide any hardware
>>> info for a specific hint, even on a frame to frame basis (e.g. PTP).
>>> Lets keep these cases as separate return codes.
>> 
>>> When describing the return values, adjust the function kernel-doc layout
>>> to get proper rendering for the return values.
>> 
>>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>> 
>> I don't remember whether the previous discussion ended in something?
>> IIRC Martin was preferring to use xdp-features for this instead?
>> 
>
> IIRC Martin asked for a second vote/opinion to settle the vote.
> The xdp-features use is orthogonal and this patch does not prohibit the
> later implementation of xdp-features, to detect if driver doesn't
> implement kfuncs via using global vars.  Not applying this patch leaves
> the API in an strange inconsistent state, because of an argument that in
> the *future* we can use xdp-features to solve *one* of the discussed
> use-cases for another return code.
> I argued for a practical PTP use-case where not all frames contain the
> PTP timestamp.  This patch solve this use-case *now*, so I don't see why
> we should stall solving this, because of a "future" feature we might
> never get around to implement, which require the user to use global vars.
>
>
>> Personally I'm fine with having this convention, but I'm not sure how well
>> we'll be able to enforce them. (In general, I'm not a fan of userspace
>> changing it's behavior based on errno. If it's mostly for
>> debugging/development - seems ok)
>>
>
> We enforce the API by documenting the return behavior, like below.  If a 
> driver violate this, then we will fix the driver code with a fixes tag.
>
> My ask is simply let not have ambiguous return codes.

FWIW I don't get the opposition to this patch: having distinct return
codes strictly increases the amount of information that is available to
the caller. Even if some driver happens to use the "wrong" return code,
it's still an improvement for all the drivers that do the right thing
(and, well, we can fix broken drivers). And if a BPF program doesn't
care about the type of failure they can just ignore treat all error
codes the same; realistically, that is what most programs will do, but
that doesn't mean we can't provide the more-granular error codes to the
programs that do care.

My only concern with this patch is that it targets bpf-next and carries
no Fixes tag, so we'll end up with a kernel release that doesn't have
this change...

-Toke

