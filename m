Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8652AD692
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 13:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKJMoD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 07:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJMoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 07:44:03 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA74C0613CF
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 04:44:02 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so2865725wml.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 04:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UvRG3/UDW5Vjq8YRtYb+uqUpXP9B9cDWAE5/Njwb59Q=;
        b=ZUmk6CeUVsSrQTx70sUFtpU4WFWXPbFQ3qtEUwSoTdBLS6prFyf0gV50Px+toK6ovA
         wtX5NWXdZG2jF7bnBdVF5IZpY074+3rB1n/VHxyc7OAnuzsLYrImQm5/6mVfxRrfioVf
         NZuMuQoq3O7pTJ6sZMgLrvhZptO7dwXS88wCbNwl6HKT5JeC860bvWklIblAAHng7lRJ
         vv11Pox8Kqrp6nQqjcXbz/u485JuQWmZmiDvn+AbQCJPbL78gyIDkm71JqIE0fqq+O2D
         gpW9tzR1m2nZvTrYMwxFeli6HSCs2/Cq23WUu6MD4jwiIMinhXZcUWZ2qKJKy/6RDEXJ
         SpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UvRG3/UDW5Vjq8YRtYb+uqUpXP9B9cDWAE5/Njwb59Q=;
        b=HYk3a8+L0zj7dv9vTEv7QyK0liFNdemyL/LJQK/8+iujfoTIiEbZueFV82ppUeELy4
         sA/5PnyW7DiRD8CUyM9xzULDUdqv2n67HQr3vABF+v+iKDXy2iU+V/vMJSMcN+6f9PmC
         09GzKRsvclorVrfm1Y3LCUW5na4n7/KhbH6RsfOcLDndJGYx20ph++jCGCl1R6Y01zT5
         gkybw9Ek/+p2IyZiN22Fsw/0YROPL+/6wF3bPURGHsG6WnvC6h4fn8Y1TW+x7WT0Sxo7
         7uiineOAhALRQwn4Bq45HxlAejIbLX5DESoEMbpdsuT4Se1i4USlQdniCRuRoh8uymUq
         ql/w==
X-Gm-Message-State: AOAM532UPRtUR1Au1qGX6CkteEO5+IrwKUnjHa9H06Ie7eZzYh6rgLEh
        AoBG45KPkSiK9FmuxhLvLTSDUA==
X-Google-Smtp-Source: ABdhPJzGR/YEo5b5WT8fqePfng5vmFOTtDu+uHeAD/pW9fZ2T2pXjt/vqwVh+jbl1T62Sir8aaW5ug==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr4535701wmc.36.1605012241729;
        Tue, 10 Nov 2020 04:44:01 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t15sm2791944wmn.19.2020.11.10.04.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 04:44:01 -0800 (PST)
Date:   Tue, 10 Nov 2020 13:43:42 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next v2 5/6] tools/runqslower: Enable out-of-tree
 build
Message-ID: <20201110124342.GC1521675@myrica>
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
 <20201109110929.1223538-6-jean-philippe@linaro.org>
 <CAEf4BzbdnJPr0FjdQmzNEYmUj8fTwVGu6ihqRB44L8ZS7FLVug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbdnJPr0FjdQmzNEYmUj8fTwVGu6ihqRB44L8ZS7FLVug@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 09, 2020 at 12:23:28PM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 9, 2020 at 3:11 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Enable out-of-tree build for runqslower. Only set OUTPUT=.output if it
> > wasn't already set by the user.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  tools/bpf/runqslower/Makefile | 45 +++++++++++++++++++++++------------
> >  1 file changed, 30 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
> > index bcc4a7396713..861f4dcde960 100644
> > --- a/tools/bpf/runqslower/Makefile
> > +++ b/tools/bpf/runqslower/Makefile
> > @@ -1,15 +1,20 @@
> >  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  include ../../scripts/Makefile.include
> >
> > -OUTPUT := .output
> > +ifeq ($(OUTPUT),)
> > +  OUTPUT = $(abspath .output)/
> > +endif
> 
> OUTPUT ?= .. didn't work?

Yes it should, I'll change it. The difference is when make is invoked with
OUTPUT explicitly set to "", then ?= wouldn't override it. But I didn't
see any external Makefile passing OUTPUT= to this one, and the user-facing
option is O=

> 
> > +
> >  CLANG ?= clang
> >  LLC ?= llc
> >  LLVM_STRIP ?= llvm-strip
> > -DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
> > +BPFTOOL_OUTPUT := $(OUTPUT)bpftool/
> > +DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)bpftool
> >  BPFTOOL ?= $(DEFAULT_BPFTOOL)
> >  LIBBPF_SRC := $(abspath ../../lib/bpf)
> > -BPFOBJ := $(OUTPUT)/libbpf.a
> > -BPF_INCLUDE := $(OUTPUT)
> > +BPFOBJ_OUTPUT := $(OUTPUT)libbpf/
> > +BPFOBJ := $(BPFOBJ_OUTPUT)libbpf.a
> > +BPF_INCLUDE := $(BPFOBJ_OUTPUT)
> >  INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../lib)        \
> >         -I$(abspath ../../include/uapi)
> >  CFLAGS := -g -Wall
> > @@ -20,7 +25,6 @@ VMLINUX_BTF_PATHS := /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_REL)
> >  VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword                           \
> >                                           $(wildcard $(VMLINUX_BTF_PATHS))))
> >
> > -abs_out := $(abspath $(OUTPUT))
> >  ifeq ($(V),1)
> >  Q =
> >  else
> > @@ -36,9 +40,13 @@ all: runqslower
> >
> >  runqslower: $(OUTPUT)/runqslower
> >
> > -clean:
> > +clean: $(DEFAULT_BPFTOOL)-clean $(BPFOBJ)-clean
> 
> why separate targets for $(DEFAULT_BPFTOOL)-clean and $(BPFOBJ)-clean?
> Are they intended to be called separately? I don't think
> parallelization is that important for the clean up. Let's just keep
> all the cleaning in one place, not spreading it across Makefile?

Ok

Thanks,
Jean
