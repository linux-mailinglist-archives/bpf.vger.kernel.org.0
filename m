Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481C4678900
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 22:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjAWVBA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 16:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjAWVA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 16:00:59 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE63802C;
        Mon, 23 Jan 2023 13:00:36 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 91BA34E5;
        Mon, 23 Jan 2023 21:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 91BA34E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674507618; bh=kQU2tIJdB9rnhbfeq1gp/o1R3R4HSKI0cgbamerZ2IU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HpgEiaVY8ku4QGhapK3c0YKHIxh225fuM3q4Bdb3X9cze0iTSLyR/H34YvqKa12ao
         Cav7pdLKFM+xSZSiwgyFaotU1JunnfrHMRJRV4ySVwjYvk1jS2Hjo11oWgo8ZqGtpL
         s8z3VZnCdyN+ghwYaB6NfaUCjfuKTCg9BKgTxFkp6oXc0HNTibtAZrLLSk1YNioh6V
         1sZJvveoGKhElYs31uc90sRvBD9GR+3dh3X0lbovLol1mT7BYkpdyfXcU8Hx4y7vAA
         rR9LpV1PnZ0Ba6QyZsIKgegP7Heg3OIXxhDWC9MgMYptH25aVVjqI2skFCxlo9kWGu
         vLCJ96Ro9zdbQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
In-Reply-To: <ebff2166-8a70-af62-b859-6b5c6b008b36@iogearbox.net>
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
 <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
 <Y87We/92xiv5/+g+@maniforge.lan>
 <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
 <ebff2166-8a70-af62-b859-6b5c6b008b36@iogearbox.net>
Date:   Mon, 23 Jan 2023 14:00:17 -0700
Message-ID: <87o7qphspq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> Did you look into making this similar to the EXPORT_SYMBOL() infra? If possible
> that would look much more natural to developers, e.g. :
>
> struct nf_conn *
> bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
>   		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
> {
> 	[...]
> }
>
> EXPORT_BPF_KFUNC(bpf_skb_ct_lookup);

That was my question too; it's a similar functionality that would be
nice to express in a similar way.  Even better, if possible, might be to
fold it into BTF_ID_FLAGS, which I might then rename to EXPORT_KFUNC()
or some such ... :)

Thanks,

jon
