Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4985C3D9568
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 20:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhG1SkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 14:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG1SkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 14:40:18 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56761C061757
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 11:40:16 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id j18so372361ile.8
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fkgJD+L02rF109J/gXsNEjEGqTAV+6EXubXFUTbNtlw=;
        b=Dr9eXDeJNkbqVjvaowdvvhEXNwY1qVjvDykuN93hSgXo/JT0V/BtcD3iacmNpKsUTW
         1jtPwYy0dXqeX8YcksiBh610Thv2LTc0+1WoNOOc+Ls3yKICYXUy6tKU2U4j5IYHUEdI
         aLLpRh+ncQFMnixJ1NijDFK5t+CaE5MjGsJ80RI7rhDLFCDHgT7iMfQ62VDgUDByb4ow
         50uAeWARBfCJ8v3u74eCF1lBtRa82Mxk+SgQqtjfDWONvv3k+7GX1ejUTyWi/6viKYPb
         WToKdalqt94Im2yi2w1uw/IEZpfNUcHMb1OEgMpNumOuEETcKOaOw7mvxA6ej64sAHJl
         xrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fkgJD+L02rF109J/gXsNEjEGqTAV+6EXubXFUTbNtlw=;
        b=WutYDJzlePYzDDT3OIE1NVRvYP1n4f/hRDdv4FMhXe9beNltl/dS3LLu8SjS7gPGBL
         v6VhcaL7qx9PxPMxCFmafzIZI7Mgn+5vb/N9m5ywsAobRBaygEh4NcGJaS5oC0ZdoQy0
         TNTZFzEIUePwRGA7mwEn8h0G4/6iyoebDubd0IG3gBJbIFDcwOV7O3Gs4Dzz1kkMHViB
         HN6nM0EGvI4zvfwCmgPN3EgykgFwu1qbq0x9/n9cBUaMi3UXTSbXo46nj8Me+ku+/p23
         xQvssrgwZuUkNe7YkK9fs62nSks/kYhG0KW0j4XvjNBokTHNG3ygV1hNG2ajsqRUD9lr
         kb1g==
X-Gm-Message-State: AOAM5327tN0FKRba1xCyOWiH1p+TQmzACJ/maZ75xiGuXrhEe3bXTOGA
        mdpyu9vu/2188epytYbnTFrl/kSP8YwjHQ==
X-Google-Smtp-Source: ABdhPJwyKkJuWCq9CelFQxsHbqgOLQ26G3zjRLXuvMlASkW08koXyJpWrOamh91U2JR0FT4Lb8vuQQ==
X-Received: by 2002:a05:6e02:20eb:: with SMTP id q11mr807219ilv.272.1627497614685;
        Wed, 28 Jul 2021 11:40:14 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id s195sm591719ios.38.2021.07.28.11.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:40:13 -0700 (PDT)
Date:   Wed, 28 Jul 2021 11:40:06 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     BPF-dev-list <bpf@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        William Tu <u9012063@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Message-ID: <6101a4865317f_1e1ff620882@john-XPS-13-9370.notmuch>
In-Reply-To: <YQEpRRxxf0R4Znd3@localhost.localdomain>
References: <20210526125848.1c7adbb0@carbon>
 <YQEpRRxxf0R4Znd3@localhost.localdomain>
Subject: RE: XDP-hints: how to inform driver about hints
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Michal Swiatkowski wrote:
> Hi
> 
> I have just stareted working on generic hints implementation that was
> discussed on netdev workshop. I wondering how we should tell driver that
> hints is supported on XDP program.

I would reword this as, 'how do we enable the hardware to populate hints'.
Sorry bit of a nitpick but there is nothing in the XDP program about
supporting hints.

> 
> I prepared 3 implementation of this approach. In 1 and 3 solution I
> wanted to automatically search for hints usage in XDP program, but it
> doesn't look good because of comparing lines of XDP program in libbpf
> (3) or in bpf core (1).
> 
> For me solution 2 with reusing XDP flags looks good, but I don't
> know if XDP flags can be used for storing information about hints.
> What do you guys think about that?
> 
> Please take a look at code samples:
> 
> (1)
> https://github.com/alobakin/linux/commit/a4f32ba74e5d3eefe607789547e9d5529ed775b0
> don't know how to send flag to driver. Searching for metadata happens
> in load program path, but communication with driver
> (by ndo_bpf call happens in creating link)

I would say no to this because its not an attribute of the bpf program. The
program is going to be just happy to accesss metadata with or without
the driver/hardware cooperating. Its just doing so will result in garbage.

> 
> (2)
> https://github.com/alobakin/linux/commit/72a5d930bea330f5f4827fdf098b723f96acff0c
> simplest solution. Add another flag, everything are there, driver will
> check this flag in ndo_bpf

+1. This makes the most sense to me. Its also easy to implement as a bonus.
These flags are passed to the driver and independent of the program which
I think is correct way to view it. Also if some driver needs to do a
hard reset or flush descriptor rings, etc. its probably already doing it
to configure for XDP.

> 
> (3)
> https://github.com/alobakin/linux/commit/92de1e0e3523317c5749f3c87173dc90b1e8011b
> I haven't tested it yet. I think it is doable to do this search in creating
> link path, but only when user uses syscall instead of netlink API
> (I am pretty sure that this is used in auto generated code by libbpf).
> If we will decide that this solution can be correct I will write a suitable
> sample and chec if this works

I don't like having more knobs 'do it this way and it works', but 'do it
that way and it doesn't'. anyways it seems like the wrong way to me the
link is about BPF program. This is about enabling the hardware.
