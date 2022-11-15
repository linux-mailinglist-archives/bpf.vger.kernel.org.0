Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489AE62A218
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 20:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKOTnN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 14:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKOTnN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 14:43:13 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2FF2E9D7
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:43:12 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 140so13579230pfz.6
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=szM/2ZX2R2I9MNajgWVzizdqYHE6oAwcQf3hDaOaVuE=;
        b=T3jMD85uhEGx1Ini6Vz7+ipaURAMXevocyvw7OrxiGVpuEF7mP0OtDCeDGvqnrXY5u
         ZQjgGuRwSruJfvySTUwsuED2iXiuwa86Ab+eN6rAO6Nq5O7/IqdTSsNrJnTnSKN/z3o6
         BHm4VZCERn+ZVPhcF6OFSmjenPbuf3HOdUZAHiHaZl8+plg01NHDkwrxKIdz1asEXB96
         QbTbcvsyxJ8mHOvd48yjJksphfaDkz0suLL4EIlnHf9HYWyChEda/3hQgsKHPoODKKQQ
         H6ay5AzxiaoOxfhLmgo1JIGEjl/iISfpO/nmhFBWiEZlXLLRDaADvtMWFrh2Yy26kpRT
         5kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szM/2ZX2R2I9MNajgWVzizdqYHE6oAwcQf3hDaOaVuE=;
        b=pKgahvbsMWUEPX8UVqGUAbsXW7g0fmEQsPk4i9lXT3/DhI/zuEhukG5Kwk8GTOati/
         8CNQVCidjjC0u+CxffF2ogGXvvFkPywIfz8F4lMgFua9+cLDUBMbD6vE0bQtWBL7TtFY
         u7HMEvqL0Ly5o/XS0+DuzQNH/xO+Y5Tp843MUcKvZmZVqTqi9up9mB433ozmVvRCwl/8
         u5alVkO6I9z0SlYtsyTDYc/whaPg4kY6qZLIPw2J341MYrS9PQzmbqvnXGf013Vq4Ard
         1WDU9ZDlMIyw3eRK6fy9OwXYj5gNnvdLAYtfVxZIdNW3CDUKygxFvA0btWWjqnZ2yGY7
         8NTQ==
X-Gm-Message-State: ANoB5pkRk7jpNfIRPCbuez4qtvAVAyqVadxzb7+ll80dyUYDzZIMRhdh
        xVU/15WI5y062FKgIhUD97Q=
X-Google-Smtp-Source: AA0mqf7sPKD7ZUW0SX1oLY399v6z0uianLtvwsTP6bzziS310Vz0rsVd3ausGj/TPeztldLD2zn4Pw==
X-Received: by 2002:a63:1cf:0:b0:470:71df:a6c3 with SMTP id 198-20020a6301cf000000b0047071dfa6c3mr17324971pgb.447.1668541391645;
        Tue, 15 Nov 2022 11:43:11 -0800 (PST)
Received: from MacBook-Pro-5.local.dhcp.thefacebook.com ([2620:10d:c090:500::7:32e])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b00178acc7ef16sm10174530pln.253.2022.11.15.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:43:11 -0800 (PST)
Date:   Tue, 15 Nov 2022 11:43:08 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, memxor@gmail.com
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf_get_kern_btf_id()
 kfunc
Message-ID: <20221115194308.ej5lwd2jo6ulebut@MacBook-Pro-5.local.dhcp.thefacebook.com>
References: <20221114162328.622665-1-yhs@fb.com>
 <20221114162339.625320-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114162339.625320-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 08:23:39AM -0800, Yonghong Song wrote:
> The signature of bpf_get_kern_btf_id() function looks like
>   void *bpf_get_kern_btf_id(obj, expected_btf_id)
> The obj has a pointer type. The expected_btf_id is 0 or
> a btf id to be returned by the kfunc. The function
> currently supports two kinds of obj:
>   - obj: ptr_to_ctx, expected_btf_id: 0
>     return the expected kernel ctx btf id
>   - obj: ptr to char/unsigned char, expected_btf_id: a struct btf id
>     return expected_btf_id
> The second case looks like a type casting, e.g., in kernel we have
>   #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
> bpf program can get a skb_shared_info btf id ptr with bpf_get_kern_btf_id()
> kfunc.

Kumar has proposed 
bpf_rdonly_cast(any_64bit_value, btf_id) -> PTR_TO_BTF_ID | PTR_UNTRUSTED.
The idea of bpf_get_kern_btf_id(ctx) looks complementary.
The bpf_get_kern_btf_id name is too specific imo.
How about two kfuncs:

bpf_cast_to_kern_ctx(ctx) -> ptr_to_btf_id | ptr_trusted 
bpf_rdonly_cast(any_scalar, btf_id) -> ptr_to_btf_id | ptr_untrusted

ptr_trusted flag will have semantics as discsused with David and Kumar in:
https://lore.kernel.org/bpf/CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com/

The verifier knows how to cast safe pointer 'ctx' to kernel 'mirror' structure.
No need for additional btf_id argument.
We can express it as ptr_to_btf_id | ptr_trusted and safely pass to kfuncs.
bpf_rdonly_cast() can accept any 64-bit value.
There is no need to limit it to 'char *' arg. Since it's ptr_to_btf_id | ptr_untrusted
it cannot be passed to kfuncs and only rdonly acccess is allowed.
Both kfuncs need to be cap_perfmon gated, of course.
Thoughts?
