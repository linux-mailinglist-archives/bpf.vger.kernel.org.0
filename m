Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3142444BB39
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhKJFay (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJFay (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 00:30:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78554C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 21:28:07 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n8so2067758plf.4
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 21:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQynKUCQPvmsFtwRfkzXjC8rg6JNth+QCeuAjo2J1eM=;
        b=O5os32VwhqONHYMYeocG4SGp3wEOwAfReC+ZhisQ16rbpYSjfo7agi4nKqhwAmD97a
         zpv98CmTjrVPwdBLmgGuxSTuhglb9NFEZNh4B2NDxsmOrtMMb95uiBS9J4RYiuxsts4l
         XIi+ig7OZTU3Ro3eBNG1ka40Rio6RZ0Z6bf4Pd14mdGIXrOLc2IqBYrnTJhfSoAk74zN
         vWPCsZj1fCR4IdxnqIxQxkJb5MY6G4ViWRFIJRl5kfkGB5eqhBfIkmKoqkNCThxkWwow
         zhhuxNLV3hkMrHL7AoE9A2gWA0UyI/S5PwNNlsVitt5srqQ1/cpR/kQdaeogK0NPFKrH
         urGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQynKUCQPvmsFtwRfkzXjC8rg6JNth+QCeuAjo2J1eM=;
        b=p+AZwHwW8AkNNozEIbXDsOVmq2iGayUFtKaRiQaeL18a5V4qC7Dn3VqiYllmMhpS/6
         IB5RPTO7fDR45BFiFusNve9hxvB4jO77CLJ91XwgqgbP0igFRxK8Mv4atQ0Ks4uwrreW
         7N0T4GWFmBX8NJjj6mEqJY9Uw0B/rXgZEfEGYpFFY7WVb/VpTLBqDg8kdAsSf5J6axpG
         TiajQNjRVzyWIfzRNlRmAnkN7Am7n1ctqHVyH97kaqIipZEnYAB6mIEgAhvcbLNvzbtA
         UXATDO855e8nQEjkY5XdsshNtY44vwTRCOyCB0erreNrPIRtYHuYQu64uxRW257dC4eC
         j/wA==
X-Gm-Message-State: AOAM530wvZHtjgxnYNBl4SBcAb8tdgDIvrP9o36WZ+Cjr+5tZ8yqwXky
        KWDAnTiQsBSipy1lcLEEtog=
X-Google-Smtp-Source: ABdhPJzuIC8agOYHGAT92bDedMa7UL6or+8tq16c1iA6sUNtv1H/mGfhUcZq4icYNRJIg8E2YG2n6g==
X-Received: by 2002:a17:903:2344:b0:142:25b4:76c1 with SMTP id c4-20020a170903234400b0014225b476c1mr13313689plh.43.1636522086889;
        Tue, 09 Nov 2021 21:28:06 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8f53])
        by smtp.gmail.com with ESMTPSA id 17sm21473924pfp.14.2021.11.09.21.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 21:28:06 -0800 (PST)
Date:   Tue, 9 Nov 2021 21:28:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 00/10] Support BTF_KIND_TYPE_TAG for
 btf_type_tag attributes
Message-ID: <20211110052805.qds3qzhabhdr3ah4@ast-mbp.dhcp.thefacebook.com>
References: <20211110051940.367472-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110051940.367472-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 09, 2021 at 09:19:40PM -0800, Yonghong Song wrote:
> LLVM patches ([1] for clang, [2] and [3] for BPF backend)
> added support for btf_type_tag attributes. This patch
> added support for the kernel.
> 
> The main motivation for btf_type_tag is to bring kernel
> annotations __user, __rcu etc. to btf. With such information
> available in btf, bpf verifier can detect mis-usages
> and reject the program. For example, for __user tagged pointer,
> developers can then use proper helper like bpf_probe_read_kernel()
> etc. to read the data.

+#define __tag1 __attribute__((btf_type_tag("tag1")))
+#define __tag2 __attribute__((btf_type_tag("tag2")))
+
+struct btf_type_tag_test {
+       int __tag1 * __tag1 __tag2 *p;
+} g;

Can we build the kernel with the latest clang and get __user in BTF ?
