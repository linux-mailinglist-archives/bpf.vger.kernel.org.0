Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E74DE1B0
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 20:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbiCRTWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiCRTWi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 15:22:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A92EDC0D
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 12:21:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i11so7052743plr.1
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5YX1gn/VwOJyuBdRtlgzCdAIYacDg/GfKPHkufM3WR0=;
        b=LELYuKHaIWSL5H38CLHKmc6A+eQd005DG7uRtssWj8EfpAoQDk2v/fKQWNZ0CHX3qC
         ZCczRsgzivZfMw8thnV2l7tH6FjA4zAECJKrb1OxJTP86wD3CCFGjTorRjzSxsxJ4h3T
         vrpfwo7xsA/k/yca4QcNaSVbqLZoY6MQMLNUdwH0TMbY4vwcsdbHfajtsQ+AeZdwjQi8
         37hwbOcvLcr0KZwiYy3PrMyyzfiAK0wJdtvUHIZDubFt31FC5aakdmDfPqWzwZpuQDeI
         zxZIAbUq5gJi3y2Y/79X/1FkNFi7enkPs20m03brTcHocFKZvV+tRmSSg/4nUeijoe2o
         KVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5YX1gn/VwOJyuBdRtlgzCdAIYacDg/GfKPHkufM3WR0=;
        b=U22u+89fTSeK7prZoEk/b57eKu4lXZ5g2cTX8thsPyIhxNkETzq3hFqm6dWztSQTe1
         r86bnDoqmc1VJX6uAxAOZFvN0GoTcxVDGVsd81IIlCz07HaWgTPKubh4gvKoL3B2u7mL
         QE90UxlvYg+xoiEWTklxxT9GxO1eVAyhvAhhZqsDqs+QeDk72ZnnL36LiLDvJEFSvfrm
         2WjRm9DDI0JkAYXAuEfmWefk9Jqd1r7ZhbHHcUsOgu8UN2C4MXcoFHEwCWZotxwpqbah
         FBUtJyLl2hzSHx82AOZCRggr0thDPGB8QC7XAUvkBoC88ZFMrKlmwZY+DlUfEt61HoRh
         k9Mg==
X-Gm-Message-State: AOAM530E/lWgekV5mWeC2tuvxbXMa+8eMg9JjTRzd1453KU3jXn4Ubee
        XFIbxAh5pngFUMzuQTTiy9cfJOdn+3g=
X-Google-Smtp-Source: ABdhPJzhpskqn1VXv4Didl8JIPgNTo3RQJaWsjTP9bKGMnkCEXo5o2J2jHcanKqLOPj+YPYCxKkCNA==
X-Received: by 2002:a17:90b:1bc5:b0:1bf:1c96:66ac with SMTP id oa5-20020a17090b1bc500b001bf1c9666acmr23119508pjb.167.1647631278728;
        Fri, 18 Mar 2022 12:21:18 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:7e8b])
        by smtp.gmail.com with ESMTPSA id f30-20020a63755e000000b00381f6b7ef30sm6981358pgn.54.2022.03.18.12.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 12:21:18 -0700 (PDT)
Date:   Fri, 18 Mar 2022 12:21:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Subject: Re: [PATCH bpf-next v2 4/4] selftest/bpf: The test cses of BPF
 cookie for fentry/fexit/fmod_ret.
Message-ID: <20220318192114.pacmegfl3uglju6l@ast-mbp>
References: <20220316004231.1103318-1-kuifeng@fb.com>
 <20220316004231.1103318-5-kuifeng@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316004231.1103318-5-kuifeng@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 05:42:31PM -0700, Kui-Feng Lee wrote:
>  
> +SEC("fentry/bpf_fentry_test1")

Did we discuss whether it makes sense to specify cookie in the SEC() ?

Probably no one will be using cookie when prog is attached to a specific
function, but with support for poor man regex in SEC the cookie
might be useful?
Would we need a way to specify a set of cookies in SEC()?
Or specify a set of pairs of kernel_func+cookie?
None of it might be worth it.
