Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535434CBF4D
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 14:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiCCOAk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 09:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiCCOAi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 09:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B296D64BC9
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 05:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646315992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EPzzRx3cg/pmzHstqnOsA2Fg9HW56H+MJYqezSg++LE=;
        b=DY7Mnvhnjc5iSYCrRTQ9+3SkfuL7JHUgIdD5kIB25eYhYvDUWlwYHmQAHpy7dZsaW9Mc5H
        XhGpvvFN0OuN/STbVl06fhb3DPxZbwJawQqUF9GemzrVm7NvS3dupOYqj1SObANJoMENC5
        VY1mRYF3VsOk6qPqnHK85BbyZ1YoO0g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-EwjzPpnOOjWiHtzHfqONhw-1; Thu, 03 Mar 2022 08:59:51 -0500
X-MC-Unique: EwjzPpnOOjWiHtzHfqONhw-1
Received: by mail-ej1-f71.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso2760150eje.20
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 05:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EPzzRx3cg/pmzHstqnOsA2Fg9HW56H+MJYqezSg++LE=;
        b=FMh2iuENgz18sRkfah7C+3f8qHKtI3dFxUF6K5z4wmEevzFIhiEhmEWsfaHeWtkEyo
         y1GuiLN0X4oOT5MAd+FOOn93XH7g1PNlXNBbEjaq/XVTc47/LV9Wy0mTVOn8lr/w3JWy
         L+90iL/XEjPxbSZKXOFXGt7Ph4z3jqDJ4ZHykF20yW1gwVHtESx/4NCbzg/V6fAhZZes
         tKStnfFXVreoCHOxj3ASCDc5nLdX5ptJd3R1/msKxhFlHYHSXik7WdyvndtFFabxwNjT
         HkAPmPOTRN1pV1HG3SME+2f73sqyJ+aMjAR2OMiXuGneJBsKMoVc2QYExB57q1WGGXSP
         GDTw==
X-Gm-Message-State: AOAM531OflVbi6DiRlB5BkxLsJAhyjBHsZQ1UUhKniu2XKYx6sl70qjn
        67qmUsf7ndxhCstDgb0X20fwCRfALCFcOuiTmSO9Zwk9Mt97ay07wecgt05NHNsUjxj9h/hK3//
        mV5QYp0t+Tvrd
X-Received: by 2002:a17:906:5d0e:b0:6da:97a8:95bd with SMTP id g14-20020a1709065d0e00b006da97a895bdmr1380848ejt.442.1646315990029;
        Thu, 03 Mar 2022 05:59:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPnR2SJt5wIOYwF3ZPR//qWJvAOvhL8xvzO6S0xyW+z1dASzCi5+vPXcvA+rmAJGVgj2I9eQ==
X-Received: by 2002:a17:906:5d0e:b0:6da:97a8:95bd with SMTP id g14-20020a1709065d0e00b006da97a895bdmr1380809ejt.442.1646315989561;
        Thu, 03 Mar 2022 05:59:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709060c5300b006d582121f99sm711461ejf.36.2022.03.03.05.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 05:59:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 78D1B13199B; Thu,  3 Mar 2022 14:59:47 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH net] xdp: xdp_mem_allocator can be NULL in
 trace_mem_connect().
In-Reply-To: <YiC0BwndXiwxGDNz@linutronix.de>
References: <YiC0BwndXiwxGDNz@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Mar 2022 14:59:47 +0100
Message-ID: <875yovdtm4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> Since the commit mentioned below __xdp_reg_mem_model() can return a NULL
> pointer. This pointer is dereferenced in trace_mem_connect() which leads
> to segfault. It can be reproduced with enabled trace events during ifup.
>
> Only assign the arguments in the trace-event macro if `xa' is set.
> Otherwise set the parameters to 0.
>
> Fixes: 4a48ef70b93b8 ("xdp: Allow registering memory model without rxq reference")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hmm, so before the commit you mention, the tracepoint wasn't triggered
at all in the code path that now sets xdp_alloc is NULL. So I'm
wondering if we should just do the same here? Is the trace event useful
in all cases?

Alternatively, if we keep it, I think the mem.id and mem.type should be
available from rxq->mem, right?

-Toke

