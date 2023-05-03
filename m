Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744BE6F5713
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 13:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjECLTo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjECLTk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 07:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26881FCF
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683112733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5KcQFxt1OwjVipvmc6YpAr7EIfZDFTMkByui1W8njA=;
        b=UOLFM/fIbUdOxroY87HhK0IudCIsItx32+XkL7u5TN4qCuQkFxy0raJje51SQAuTWtYujL
        Haxcw8CFliFRD/t7dSvH4ezc5+jFEhoQn2KMYyo8P9aYKl4kPME7CCcQhjLkkLMRc5yP9Z
        uH1pjFQORZ/JDXsjCC5SOdoYVBrrz/w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-dWDTDyp-PD-Ytj2VjFfeEg-1; Wed, 03 May 2023 07:18:52 -0400
X-MC-Unique: dWDTDyp-PD-Ytj2VjFfeEg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9537db54c94so476670166b.2
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 04:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683112731; x=1685704731;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5KcQFxt1OwjVipvmc6YpAr7EIfZDFTMkByui1W8njA=;
        b=fP4QXU7E2PFbx1gdfl3oYB18+nMGRhaoNuKuhMKQJHEbg8ddcqaU2tXhi+dpj+yh++
         qbf9ln+YzTDDbYEBbI90oJ9jZActW2+DnUrlPXJuyLXhNmNDP5ubNzImWTIqsKV4Opeb
         yG9P4jE0FEafk31QxhKCvwh2VATxOYGDbMvzepQmrhPhfPuG/ppdbgfpaBT+fFkz5LKc
         PhpZCxDIWGndtdFS13c4rk0or4q++3RGkpb3mYl6JJnYJtGn4KL9KB/p7sqhM2OliCpH
         hkgqMh2ze7A+NeCka7nWOXWFqY58DxZJKuZvOtrtezWRuMqIqDMLRr/8S5VIRvLyV5Xv
         oYOQ==
X-Gm-Message-State: AC+VfDymaVqcougVJVD0NYC4KtVP46cMiAUWwAbVAF2wz4lXkYijluHo
        /f8yJj2cd1z3XCPWCTqSK6k1EMhpXNul27gbtTcGqyLDFoSFouzguIfuXPHY3vSLwhxt8anrO6L
        OpfrTg838c5f1
X-Received: by 2002:a17:907:3205:b0:965:6d21:48bc with SMTP id xg5-20020a170907320500b009656d2148bcmr818751ejb.75.1683112730250;
        Wed, 03 May 2023 04:18:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GAzfkY9LoIBGnjCpEUkjKgp2s37A98qN1w9G1olO5/gt5rwcw+5Pt8NlF11zSV/CThvGVFA==
X-Received: by 2002:a17:907:3205:b0:965:6d21:48bc with SMTP id xg5-20020a170907320500b009656d2148bcmr818701ejb.75.1683112729351;
        Wed, 03 May 2023 04:18:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i10-20020a05640200ca00b0050bd9d3ddf3sm595879edu.42.2023.05.03.04.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 04:18:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E64B7AFC7B0; Wed,  3 May 2023 13:18:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
        lorenzo@kernel.org, linyunsheng@huawei.com, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org
Subject: Re: [PATCH RFC net-next/mm V3 1/2] page_pool: Remove workqueue in
 new shutdown scheme
In-Reply-To: <20230502193309.382af41e@kernel.org>
References: <168269854650.2191653.8465259808498269815.stgit@firesoul>
 <168269857929.2191653.13267688321246766547.stgit@firesoul>
 <20230502193309.382af41e@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 03 May 2023 13:18:47 +0200
Message-ID: <87ednxbr3c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 28 Apr 2023 18:16:19 +0200 Jesper Dangaard Brouer wrote:
>> This removes the workqueue scheme that periodically tests when
>> inflight reach zero such that page_pool memory can be freed.
>> 
>> This change adds code to fast-path free checking for a shutdown flags
>> bit after returning PP pages.
>
> We can remove the warning without removing the entire delayed freeing
> scheme. I definitely like the SHUTDOWN flag and patch 2 but I'm a bit
> less clear on why the complexity of datapath freeing is justified.
> Can you explain?

You mean just let the workqueue keep rescheduling itself every minute
for the (potentially) hours that skbs will stick around? Seems a bit
wasteful, doesn't it? :)

We did see an issue where creating and tearing down lots of page pools
in a short period of time caused significant slowdowns due to the
workqueue mechanism. Lots being "thousands per second". This is possible
using the live packet mode of bpf_prog_run() for XDP, which will setup
and destroy a page pool for each syscall...

-Toke

