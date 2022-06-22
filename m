Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A755468A
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347638AbiFVKPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 06:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiFVKPQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 06:15:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CD53AA56
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 03:15:15 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id a14so6076702pgh.11
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+1XWq8cw7OHb2Bf6aNzAKak0QHCkVQAfW5Wzo+sDjjk=;
        b=U+vnYvVIkG45EDXtQB/tlbop+jl3hoZt7SOJDx5EVsD6SAenfVOatdKhxjCvhKh80h
         ps7x+2lvF7C9wUnLa2U8SfiQ+/JNLkYJj0wskFRYgiGPojH0QVVEeMd3tcm98sJtSuKQ
         6tK4QEOw4QUA14h6XFvA3zMmj+QjyiIzL9r9mZ3Xpxr0mHi7EP0+KkKLKM/Nlcenmuvk
         dLqQgV1ocQ46Nd5ggC+/K+eeb55FaZmEpMat1GoWCYT61e7VauW4EkpMIRxSi27VuBg3
         jMvhdL72i1AtFmPkz3v7rFwFRSETH4ZKV5dZ7NctQlvZnqlEDQJ62YbFoluDKS5ydsK4
         3DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1XWq8cw7OHb2Bf6aNzAKak0QHCkVQAfW5Wzo+sDjjk=;
        b=p26RCrwB/dffkDSH9ER2ex6l7WPTr/9WeDPd5ySX2SLqXI2+FBhZZVyUvYrJdo33m6
         oFMdntkX7bT2Fa39OxHfpS0l4uvuuO9uW+dKY1/UM0ENv6emAnLnU6f2xi+YvJVvR4bv
         +5lESxz0FDYtKB0oFcmGSwjB8+tfw1Jdf5smI/V5BI/EdoP/DabJwlW+ASYRhtr0h9rh
         CzQzBoBAmN3fq1DhfApl2BBM/GZkhkw/Vn7GWJCs8HuQCQIbj2igYMydgOGjqMlE7ic6
         5L67TT1OaBZ//sphlSkWP/g2a/VACP6X0wfxOfegSm+NWZdEAHA+LZYa4iH2odydQuyQ
         W7ow==
X-Gm-Message-State: AJIora+TJlNAAvEqENjTufP8X+EWvney2DbGQDIbasr/G9RQU+THJmej
        +lZCfhGLABiiAxVn6OHPhA0OnKb+1b8=
X-Google-Smtp-Source: AGRyM1vqv/PF80vPpLS6/6MNMtKILKRt7JbY8uD6dwRDdXJx5sirhECsFnJdw3oI0oIRkOr+GN3P1Q==
X-Received: by 2002:a63:8f04:0:b0:40c:a447:a189 with SMTP id n4-20020a638f04000000b0040ca447a189mr2384493pgd.515.1655892915338;
        Wed, 22 Jun 2022 03:15:15 -0700 (PDT)
Received: from Laptop-X1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090b018700b001ece55aec38sm1131230pjs.30.2022.06.22.03.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 03:15:14 -0700 (PDT)
Date:   Wed, 22 Jun 2022 18:15:09 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Yauheni Kaliuta <ykaliuta@redhat.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: How about adding a name for bpftool self created maps?
Message-ID: <YrLrrVMFApQdYpmL@Laptop-X1>
References: <YrEoRyty7decoMhh@Laptop-X1>
 <CACdoK4JrrVoMjvwQusdpYOO5gDqZDKky2QZqyb08p+2R1186Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdoK4JrrVoMjvwQusdpYOO5gDqZDKky2QZqyb08p+2R1186Gw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 10:28:27PM +0100, Quentin Monnet wrote:
> > When I using `bpftool map list` to show what maps user using. bpftool will
> > show maps including self created maps. Apart from the "pid_iter.rodata",
> > there are also array maps without name, which makes it hard to filter out
> > what maps user using. e.g.
> >
> > # bpftool map list
> > 63: array  flags 0x0
> >          key 4B  value 32B  max_entries 1  memlock 4096B
> > 65: array  name pid_iter.rodata  flags 0x480
> >          key 4B  value 4B  max_entries 1  memlock 4096B
> >          btf_id 98  frozen
> >          pids bpftool(10572)
> > 66: array  flags 0x0
> >          key 4B  value 32B  max_entries 1  memlock 4096B
> >
> > So do you have plan to add a special name for the bpftool self created maps?
> > Or do you know if there is a way to filter out these maps?
> 
> Hi Hangbin,
> 
> No plan currently. Adding names has been suggested before, but it's
> not compatible with some older kernels that don't support map names
> [0]. Maybe one solution would be to probe the kernel for map name
> support, and to add a name if supported.

Hi Quentin,

Thanks for the reply. Probe the kernel and add name if supported makes
sense to me.

Thanks
Hangbin

> 
> Other than this I'm not aware of a reliable way to filter out these
> maps at the moment. This could probably be done in bpftool since we
> should have the ids of the self-generated maps. But I think I'd rather
> find a way to add map names, if possible. It would make it easier to
> recognise/filter these maps on regular listing, whereas a new option
> would be harder for users to discover.
> 
> Quentin
> 
> [0] https://lore.kernel.org/bpf/CAEf4BzY66WPKQbDe74AKZ6nFtZjq5e+G3Ji2egcVytB9R6_sGQ@mail.gmail.com/
