Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F2160D2C4
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 19:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJYRuM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJYRuK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 13:50:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDAE2BB0C;
        Tue, 25 Oct 2022 10:50:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bp11so21847637wrb.9;
        Tue, 25 Oct 2022 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLgvf8+jcLueS2m85FZOCCTl0+pu+RRqs5gE7k132Ew=;
        b=JesPhdpAnA8vBsbE+8g8h4vUgBwbQOeUCvia+Anqhk8ccJsGcGpS4l8LcCehXZNW7Y
         aDA7rrvzvssliRjx1JrzbaDryWrmfGV6+sP3WP7GpGRRyrUMy675wYumSseYTzlOInru
         aWukOOgBaQiUMH6I03DQMcqRRP/gTqxyI4NIWKsBYOIC0cNT1NbbGnbg2/B4GN4kWXGI
         y9S3BP+zvYRx1kXafgHjqKmqt9II6Mp+IK5varHgymFOBs2xgUD9CuALx/hMXOecbb8a
         lv3KrRdMyHWAZArvzsUZ+BUjjMXEHhtGoX3gcaXe9ewrn2CJb2rYnRxudriMrFtyF5o6
         /RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLgvf8+jcLueS2m85FZOCCTl0+pu+RRqs5gE7k132Ew=;
        b=KlK5kHMxPWdgfbMc2gVuTqDutEuhqZmKLpYoEBCHtFxhQHaRHcqWa+VI9BZJmByLiL
         Xid4e41L5JuytNeqiXlxk2QsVNsiGlqlKRuAJcQeMQ5asLmR+0MJp/gpeNhCBfpZYhza
         +I22NpeZuIRqhFf4DCLoZTeRhTy4m5vQodM1Vx8solf47/DfNeRvrz/o4zs6tRNoa9rf
         +I7ph/mDBCK7FWPqXON+py0uB3Rnn8AsPmlsuzI3pU6ft7Okzka56J7WN3eT0d+P306f
         GsdfbD2Jas3EvWkHprrkZ0TZ6aUBSqlKN35fAS3Q95y9gz4Zygys4CA4mw9wE9eLkc6I
         HZ3A==
X-Gm-Message-State: ACrzQf2LBuWqQljBrHm24o2F/FNRfTdq0AhT4JwC3My4YdVxJcH45hrZ
        fDWcWs+vo6qVrQP54zq0+iw=
X-Google-Smtp-Source: AMsMyM650VMDeHz/oyedkIfA0SO9XAmtCZaDAdiHusW2JIVCdHayXiaELMUEBZHqYZtWKNaK5I3/LQ==
X-Received: by 2002:a05:6000:1d93:b0:22e:5d8a:c8f8 with SMTP id bk19-20020a0560001d9300b0022e5d8ac8f8mr26190005wrb.324.1666720207977;
        Tue, 25 Oct 2022 10:50:07 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d0eb:e336:b451:acd2])
        by smtp.gmail.com with ESMTPSA id c1-20020adfe741000000b00236883f2f5csm801740wrn.94.2022.10.25.10.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 10:50:07 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     "Jesper D. Brouer" <netdev@brouer.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, brouer@redhat.com,
        dave@dtucker.co.uk, Toke Hoiland Jorgensen <toke@redhat.com>
Subject: Re: [PATCH bpf-next v8 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <5cd2d8ee-a0aa-070f-17c8-dacd816f0927@brouer.com> (Jesper
        D. Brouer's message of "Tue, 25 Oct 2022 15:57:47 +0200")
Date:   Tue, 25 Oct 2022 17:47:47 +0100
Message-ID: <m2pmefyhn0.fsf@gmail.com>
References: <20221021142259.18093-1-donald.hunter@gmail.com>
        <20221021142259.18093-2-donald.hunter@gmail.com>
        <5cd2d8ee-a0aa-070f-17c8-dacd816f0927@brouer.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Jesper D. Brouer" <netdev@brouer.com> writes:

> On 21/10/2022 16.22, Donald Hunter wrote:
>> +
>> +Usage
>> +=====
>
> Can we make it more clear, that below refers to usage from BPF programs.
> E.g. changing title "Usage" to something else, or create a sub-section.
> Below we have subsections "Kernel BPF" and "Userspace", do set aside
> kernel-side and userspace API users.
>
> Sorry for bringing this up so late (v8), but I think it is important
> that the documentation makes it easy for the reader to quickly grasp
> which section is BPF-prog code and which is userspace libbpf APIs.
> IMHO this should then be consistent across out docs.

Agreed. I will add "Kernel BPF" and "Userspace" subsections consistently
for both Usage and Examples.
