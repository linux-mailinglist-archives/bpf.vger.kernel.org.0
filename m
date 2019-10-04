Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39F3CC489
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 23:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfJDVEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 17:04:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42731 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfJDVEl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 17:04:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so10419033qto.9
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rj2svHAXFdfOchRelwBBK0h1arFyU57LbDMlb1pUtJo=;
        b=OL1bb9l5QfYzUzJMX4my5fKK3axGjmvZYxZ6he+GVtTka90O5kjpd19cS3Q0nMKnwO
         VN1EhyJoVe+r5oqZub7LFG1+ZZFc3Fkv5kFh6QgkTfIba5M0lz5zK0FF5XFy1qhX4rvE
         UNClxROPA1aXZ3YWxGRPKK4s0i4oZIz3vWIwGB92v4zOGUDuWsOcLRUgtB2p7+TQ9j1z
         6r98af8WS2uCsSyEje0AjzFgQJy0dVflgdEiNzK5D1rPjk5g1ZHMSiFhFska5fSpimfy
         /ZK/vNsPw01JyWCreqKEawihiIlXmib3A9x+Hdj45TXnAAKbJtIMTmb3f30merM8Dwj3
         QdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rj2svHAXFdfOchRelwBBK0h1arFyU57LbDMlb1pUtJo=;
        b=Ibj+ZV84glyPNY9EgYiZ52k1JPAbqO1nrM1JPwrA5IYqKT2zB1nnsytW37J7ySgL+7
         iqKuYephH6qw93EyWHL/CDbjLQNdfZmM0doGnWjw1VigkXR2DCLl0KSP3BVNjwzdjTeV
         BpRJF3+7YhFq/J1GnMcyPxhrpzQZeFNbC6DfhP5t0CBhLaoqyau/r3UmAd4Gmp7cd4ix
         tN+vvmUWXoQRXLzth5qEDov9QcKooaIYK1EBrulN0n89MFzode2oTa1cveKKH27MRdCS
         C3CAvbi6CHdXxhitEpBOUbdWH2Sr1ZwicPg3yUaoBlYEgNF3+5AdXh6FVRu74ZhIa9K1
         P22A==
X-Gm-Message-State: APjAAAXLJnf0IV9GWhEASUo4bKSrNxAD3gyAqs1dwCPxKxT5Fy0pkbxz
        oO0Vrxj4iATCXcks91bbsGXMFA==
X-Google-Smtp-Source: APXvYqyHNvBOwJUDC+cvgufhu9nqgfWJMtAAJDSwnLKAwb1V578LzrkWdyosGePFZxAgF58UPyNRpg==
X-Received: by 2002:a0c:82a2:: with SMTP id i31mr16216058qva.160.1570223080454;
        Fri, 04 Oct 2019 14:04:40 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h9sm4231952qke.12.2019.10.04.14.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:04:40 -0700 (PDT)
Date:   Fri, 4 Oct 2019 14:04:35 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     David Ahern <dsahern@gmail.com>, Andrii Nakryiko <andriin@fb.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        "Alexei Starovoitov" <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Jiri Benc <jbenc@redhat.com>
Subject: Re: [PATCH v3 bpf-next 5/7] libbpf: move
 bpf_{helpers,endian,tracing}.h into libbpf
Message-ID: <20191004140435.1b84fc68@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <62b1bc6b-8c8a-b766-6bfc-2fb16017d591@fb.com>
References: <20191003212856.1222735-1-andriin@fb.com>
        <20191003212856.1222735-6-andriin@fb.com>
        <da73636f-7d81-1fe0-65af-aa32f7654c57@gmail.com>
        <CAEf4BzYRJ4i05prEJF_aCQK5jnmpSUqrwTXYsj4FDahCWcNQdQ@mail.gmail.com>
        <4fcbe7bf-201a-727a-a6f1-2088aea82a33@gmail.com>
        <CAEf4BzZr9cxt=JrGYPUhDTRfbBocM18tFFaP+LiJSCF-g4hs2w@mail.gmail.com>
        <20191004113026.4c23cd41@cakuba.hsd1.ca.comcast.net>
        <62b1bc6b-8c8a-b766-6bfc-2fb16017d591@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 4 Oct 2019 18:37:44 +0000, Yonghong Song wrote:
> > Having a header which works today, but may not work tomorrow is going
> > to be pretty bad user experience :( No matter how many warnings you put
> > in the source people will get caught off guard by this :(
> > 
> > If you define the current state as "users can use all features of
> > libbpf and nothing should break on libbpf update" (which is in my
> > understanding a goal of the project, we bent over backwards trying
> > to not break things) then adding this header will in fact make things
> > worse. The statement in quotes would no longer be true, no?  
> 
> distro can package bpf/btf uapi headers into libbpf package.
> Users linking with libbpf.a/libbpf.so can use bpf/btf.h with include
> path pointing to libbpf dev package include directory.
> Could this work?

IMHO that'd be the first thing to try.

Andrii, your option (c) also seems to me like a pretty natural fit,
although it'd be a little strange to have code depending on the kernel
version in tree :S
