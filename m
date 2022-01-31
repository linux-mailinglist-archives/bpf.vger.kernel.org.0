Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B43F4A4C92
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 17:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380669AbiAaQ4Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 11:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380671AbiAaQ4W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 31 Jan 2022 11:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643648181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lpe4J6TXyayllLvpj0n33m3bv6dU5xN6j72mEXZSOkY=;
        b=CBSNoRgo3oAs86/KgdixhUDMb6PvG+HA0pvlD3A2lff6M5SNibeaPGc37eNMnLBm29+WMg
        M8rJOuiXzXGunhKt+X7IKmT9tjhrrCHnDzAMJ85CaFzgq+mW9iic2ExwFxoteRgFohQnmm
        di4Alf83FZCUFZnpaSZmqNvJLsnBD/I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-qmubfugSMcSYAoWXuABTcw-1; Mon, 31 Jan 2022 11:56:20 -0500
X-MC-Unique: qmubfugSMcSYAoWXuABTcw-1
Received: by mail-ed1-f69.google.com with SMTP id v15-20020a50a44f000000b004094f4a8f3bso7295658edb.0
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 08:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lpe4J6TXyayllLvpj0n33m3bv6dU5xN6j72mEXZSOkY=;
        b=1bNgzJMN+0Ni66Cg9lC94NTghqG04I2LO+Z42XBmHM0pAiVzx2xitVCFlr7+au6+a9
         et7HwiZen0cvQKpI2kx/n3dHaf/CpKgD+pcloRerzSztDOEiNy7TNpTEnR93LNloDdzH
         6i2SlPQDWMBFUJAD1/TkaLEq2cKyCsI16BN2UCnAaamBGiLa/zM57y9G71BWCGjodjTh
         INGHJ6PTzw5YGRKT+iiG9X1QPBI1M8u7BAvAZPm38sIeWZNoNARwkylAgzySFwxf4/47
         nar10yrfLmRVouBl56EEhfiIh4FPeBYwbOTAilPWIwv6QawJaZXplQk9vnNvD6KzNi6G
         KEqQ==
X-Gm-Message-State: AOAM532cvcP0aiuiB/5tg1DMDpuwDWMKV/Ft8U/ONVs7QP0kMy2WygKE
        +ODgrBy9cTEu3HXFXpjGBHobWlQ4Fog7Gurrg2KoGGkSqZpzILaH2PxP63jtI2pINkApT4h7v0K
        fLgCYNEbCXwZQ
X-Received: by 2002:a17:907:8a1d:: with SMTP id sc29mr17693515ejc.326.1643648178631;
        Mon, 31 Jan 2022 08:56:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyctQHqJl8JnIY34NCeaf7CoVDfmYj1HmbGNsKfMZkb58IUdGBWA1NbnUQkN+lsoj29a+qzvg==
X-Received: by 2002:a17:907:8a1d:: with SMTP id sc29mr17693502ejc.326.1643648178434;
        Mon, 31 Jan 2022 08:56:18 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id cr8sm17858097edb.47.2022.01.31.08.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:56:17 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:56:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 0/5] Attach a cookie to a tracing program.
Message-ID: <YfgUr4tAdYDpVziO@krava>
References: <20220126214809.3868787-1-kuifeng@fb.com>
 <CAADnVQKkJCj+_aoJN2YtS3-Hc68uk1S2vN=5+0M0Q9KRVuxqoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKkJCj+_aoJN2YtS3-Hc68uk1S2vN=5+0M0Q9KRVuxqoQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 09:17:07PM -0800, Alexei Starovoitov wrote:
> On Wed, Jan 26, 2022 at 1:48 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> >
> > Allow users to attach a 64-bits cookie to a BPF program when link it
> > to fentry, fexit, or fmod_ret of a function.
> >
> > This changeset includes several major changes.
> >
> >  - Add a new field bpf_cookie to struct raw_tracepoint, so that a user
> >    can attach a cookie to a program.
> >
> >  - Store flags in trampoline frames to provide the flexibility of
> >    storing more values in these frames.
> >
> >  - Store the program ID of the current BPF program in the trampoline
> >    frame.
> >
> >  - The implmentation of bpf_get_attach_cookie() for tracing programs
> >    to read the attached cookie.
> 
> flags, prog_id, cookie... I don't follow what's going on here.
> 
> cookie is supposed to be per link.
> Doing it for fentry only will be inconvenient for users.
> For existing kprobes there is no good place to store it. iirc.
> For multi attach kprobes there won't be a good place either.
> I think cookie should be out of band.
> Maybe lets try a resizable map[ip]->cookie and don't add
> 'cookie' arrays to multi-kprobe attach,
> 'cookie' field to kprobe, fentry, and other attach apis.
> Adding 'cookie' to all of them is quite a bit of churn for kernel
> and user space.
> I think resizable bpf map[u64]->u64 solves this problem.

so you mean passing such map fd to link and have bpf_get_attach_cookie
using that map to get the cookie? that could be generic way for all
the links

I have the 'cookie arrays to multi-kprobe attach' code ready and I think 
it should be faster than map[ip] hash lookup? I'll need to check

jirka

> Maybe cookie isn't even needed.
> If the bpf prog can have a clean map[bpf_get_func_ip()] that
> doesn't have to be sized up front it will address the need.
> 

