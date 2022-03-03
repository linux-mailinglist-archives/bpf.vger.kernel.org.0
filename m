Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547584CC6F3
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 21:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiCCUPm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 15:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbiCCUPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 15:15:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F1313AA25
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 12:14:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o1so7038496edc.3
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 12:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kmuNG0yiz5WG4N7exvUSlImL0QUiJlJZYN+I707eiNU=;
        b=KxVbauQ60M3kGkUNkBTFo/coAOUmcDCtsji8V+jaIAaSELRp+XHpKRoqYymjIGM94a
         2dr0+KF3fOy5d/HkXlgKKr7ZJXcQOFLO3s9voqftlAYhoL4S1MUdHWu7+q4HIaDLUQqg
         EDLip2LUMfFjiRRw9WorCnEnUrUAtBVHwqS/bPYITC9Pnq4unTLD4NGkUmB4Dnkg9UCq
         kC+dfUb4FL6E+qSnPAVrV2S9yf9duZrU39Rqp72WrFziKPe5BtFL3haSLHnQTLOeEL/r
         w159iE6rB8uH823ZB/iUi7uGfQu3WcTZe3eGVw6IBSvEKDr9zRaHf5rALL+eWWTjMLvC
         Vv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kmuNG0yiz5WG4N7exvUSlImL0QUiJlJZYN+I707eiNU=;
        b=JE//nMYAQaqYsOucYRY1YciVeNDuuYn1fGcTa25jTfMW1I9ugP3NB92D7JzLOhU4Tp
         PBdmLc5b/kj43ftAcztcy8JGsVCRAUgvkgaumJtbcOjMfMarHjEy3uGFvOfAda80JElG
         MZU4KfT6NEq38VhTX5TDmN96RZwsbN6qY+Rgcrunms+Q5+aJ45z2l8dSL5JILVDdTRyP
         QX7rF3Qr/WJQfnWXNonOSjwqkVld9nqKUDKUHJJvYTdBPGm0q1Eey1Q757WXFNjSwugt
         yWFsNn94XImzAsZCwESHrovRgoGb3/6sdjkW2OTm2kWXh0TizkKqFVjVWnqD/H//8jnS
         MO0A==
X-Gm-Message-State: AOAM533xNlwgOOJO09pv0GQGO6W2oQ0ScLet+rRMH0S9gZW+gA7Fp1Ip
        AwS1JycrOX4a97FinaeoeoD3msO+7Gk=
X-Google-Smtp-Source: ABdhPJzalAVv6fuly/BFi1uxeoCJdkVXJcubZk4oNe6s8YNCfdkbGjGkWO/MZ0RHZWvQ5JUVoxymNA==
X-Received: by 2002:a05:6402:1e8b:b0:3da:58e6:9a09 with SMTP id f11-20020a0564021e8b00b003da58e69a09mr35570869edf.155.1646338468967;
        Thu, 03 Mar 2022 12:14:28 -0800 (PST)
Received: from erthalion.local (dslb-178-005-230-047.178.005.pools.vodafone-ip.de. [178.5.230.47])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709066d8700b006d4b4d137fbsm1035942ejt.50.2022.03.03.12.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 12:14:28 -0800 (PST)
Date:   Thu, 3 Mar 2022 21:14:01 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
Subject: Re: [RFC PATCH v4] bpftool: Add bpf_cookie to link output
Message-ID: <20220303201401.xdenf7r42obtrrnn@erthalion.local>
References: <20220225152802.20957-1-9erthalion6@gmail.com>
 <a646e7d3-b4aa-3a00-013e-4fc9531c2d83@fb.com>
 <20220303162010.qcz7dovfg736h4ed@erthalion.local>
 <47222739-81a0-c1ca-fdaa-82a2e0b67ee4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47222739-81a0-c1ca-fdaa-82a2e0b67ee4@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Thu, Mar 03, 2022 at 10:24:28AM -0800, Yonghong Song wrote:
>
> > > > diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> > > > index 7c384d10e95f..152502c2d6f9 100644
> > > > --- a/tools/bpf/bpftool/pids.c
> > > > +++ b/tools/bpf/bpftool/pids.c
> > > > @@ -55,6 +55,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
> > > >    		ref->pid = e->pid;
> > > >    		memcpy(ref->comm, e->comm, sizeof(ref->comm));
> > > >    		refs->ref_cnt++;
> > > > +		refs->bpf_cookie_set = e->bpf_cookie_set;
> > > > +		refs->bpf_cookie = e->bpf_cookie;
> > >
> > > Do we need here? It is weird that we overwrite the bpf_cookie with every new
> > > 'pid' reference.
> > >
> > > When you create a link, the cookie is fixed for that link. You could pin
> > > that link in bpffs e.g., /sys/fs/bpf/link1 and other programs can then
> > > get a reference to the link1, but they should still have the same cookie. Is
> > > that right?
> >
> > Right, I have the same understanding about a single fixed cookie per
> > link. But in this particular case the implementation uses
> > hashmap__for_each_key_entry (which is essentially a loop with a
> > condition inside) and inside it returns as soon as the first entry was
> > found. So I guess it will not override the cookie with every new
> > reference, do I see it correct?
>
> They are not return if pid is not the same.
>
> Let us say the same link is used for pid1 and pid2.
> The pid1 case will have refs->bpf_cookie[_set] set properly.
> The pid2 case will trigger the above code, and since for the same
> link, cookie is fixed, so the above code is not really needed.

Oh, I see, thanks for clarification! Will post a new version soon.
