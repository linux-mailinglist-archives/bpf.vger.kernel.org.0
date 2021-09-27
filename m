Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31617419463
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhI0MjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 08:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234367AbhI0MjN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Sep 2021 08:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632746255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IV4RRcnpw5WKxdO+4QYsw2I4BCHSaYMfP2P0AQubmNk=;
        b=auw2UNDYtsGik+35mFJlrw4tpI6U9IXqIqSruhb8iJCXVvH4FGNIxW0ozClkwSh2XQuzS0
        aoHT3rEpnpWr9czQvsRJpeyf4GQXCUECDi28XthNPgp/k969vKX9bHeSX3mZSbESp7bo3O
        OXmVdti+msl+CIuF1GxfAxpN+cJfEBM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-RpK9etZiMJWxMPCBpDzhTQ-1; Mon, 27 Sep 2021 08:37:33 -0400
X-MC-Unique: RpK9etZiMJWxMPCBpDzhTQ-1
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso5742389edj.20
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 05:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IV4RRcnpw5WKxdO+4QYsw2I4BCHSaYMfP2P0AQubmNk=;
        b=QpxquAOE1NgR5klzjF/D+TDkvSg39TCzNDi7/N2cbIKhci31yQmQgnXIutGMRM7DNn
         uCTwfVXobiM+sZr5k58D+niUE3MpgYTQEbSd+eEodPD+7aJ8ozlTr0T5yF3G9HmFcXZH
         RgcrS9Ik73fbfYrvtu//NDXSVckE4DB7sfeA481RfDxw3TZRHyWWCyHw5mWj8kFK52WF
         LQqnpNiSQzjnrPjDKm29Jx9f/loQNyLUAIOrpuZJxiZ0vxOfJn/oq+/eXDSAYoVDUIp5
         M89dDoamL/bUEABkn8v+y5IKKSE1DCSmz1V/SNaR3UKWB3bHQegBNwMe6DEoC88doKz+
         IyoQ==
X-Gm-Message-State: AOAM533h9olWLhKeHRh2iE2RhfGTyhaRVRiHeTBttu3wnM1nZuKJ3l8s
        9g921EXZez/eEU/+DteE/Xnn4YKRadAQKvZaKHdqXZOAJixS3/7lWLlCvKi2z+Sh7/5ga1Ehp1r
        P6hwLRMT3H36D
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr23048266edd.13.1632746251974;
        Mon, 27 Sep 2021 05:37:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVeXLiD7P6GYo71/yLbMji0zgpNyU2nWcQSWvIov7DCcCw4yZkrIQjIdagi9stAKp6JxVOXQ==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr23048235edd.13.1632746251755;
        Mon, 27 Sep 2021 05:37:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f18sm10506929edt.60.2021.09.27.05.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:37:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B4B0618034A; Mon, 27 Sep 2021 14:37:30 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] samples: bpf: avoid name collision with kernel
 enum values
In-Reply-To: <20210926125605.1101605-1-memxor@gmail.com>
References: <20210926125605.1101605-1-memxor@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 27 Sep 2021 14:37:30 +0200
Message-ID: <87sfxqjit1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> In xdp_redirect_map_multi.bpf.c, on newer kernels samples compilation
> fails when vmlinux.h is generated from a kernel supporting broadcast for
> devmap. Hence, avoid naming collisions to prevent build failure.

Hmm, shouldn't the sample just be getting the value from the kernel in
the first place instead of re-defining it?

-Toke

