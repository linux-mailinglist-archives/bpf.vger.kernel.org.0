Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F1D62E94B
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 00:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiKQXBi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 18:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiKQXBg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 18:01:36 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B8E2DCC
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:01:36 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id w23so2978588ply.12
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFcqpVoaK7KYsED8VmrauYaqyDMYzCZIsGu9Lgrlw1o=;
        b=UGzjjKilbb9xe+t+/h+CRXbFfvEVFhufgL1dZursiB+CQBCdp3O4EyjWoyYTFvnSKN
         rtbs334amsiBWXNvTyAaQ/esWmOQmV4inzdCzcueI3rUIaoNQ/P7309FDOzQSGrmjhLV
         oFuXWN64Tq1tKeheGtm9wMou8oypHE9I6YRpFj8H+ThEukixteeGz4kH5CXV5Ox722zR
         9UbMlIH3tYyE0N/FSwvFlauyU94r0rZr0P931PKKMdYItbEltDmrjto+NOOHjZIPcpfu
         GqYFArqaquJW+PS4sdH21rIXAZmQpxfInk4+AkPcWSJpv/LOmESAWAkJ5YnGKOi9uHAe
         jaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFcqpVoaK7KYsED8VmrauYaqyDMYzCZIsGu9Lgrlw1o=;
        b=w6h5va0ZtRViDJtJEU8ZHJi8AeWt/3h+aV+WIRWCCiPWZ04kobT4lKS56ZPJiHrWmE
         dPhUNmRnLqYcjEoCcTnot3xQAKjoivpgM9t1olcGcgyYN23fvWnLnC4X1jcqKGPT9YQQ
         O7M0Pk/2wMHYVxVXehPrI6bpFTezxfIlCTm+eD4tRawwbIuDQVsqFGrZMA11H8J+CT1+
         JcYersoi232mvtdtphsZsyadU7O7WZJSLMJdsqjDy/98+21S6TcP6BuoGQhfi73Nw1Rb
         s2caUk8ZDvoscJPhkypebPbEWJ/2oExxyOP7V79/2/D/jYkndKg5ZniZMlDd4lnHAorQ
         tspw==
X-Gm-Message-State: ANoB5pn3GMMqVdYekAlXdm+AV+AFaxD71uuw7W87/YlLlw+zuzxwZNCg
        vDNX+I+xOIVSdYnpv5yoUbs=
X-Google-Smtp-Source: AA0mqf5caKDH1sRDu/d5TlxH/L9ShU0467BUbMT/wgAGCkpl5lXNnZK4npRLsd77AwXw/dR+vwDHVQ==
X-Received: by 2002:a17:90a:4a8f:b0:215:f80c:18e6 with SMTP id f15-20020a17090a4a8f00b00215f80c18e6mr11014641pjh.45.1668726095420;
        Thu, 17 Nov 2022 15:01:35 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b00186ffe62502sm1860809pld.254.2022.11.17.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:01:35 -0800 (PST)
Date:   Fri, 18 Nov 2022 04:31:32 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf_get_kern_btf_id()
 kfunc
Message-ID: <20221117230132.frdiksvf3ia6v2ym@apollo>
References: <20221114162328.622665-1-yhs@fb.com>
 <20221114162339.625320-1-yhs@fb.com>
 <20221115194308.ej5lwd2jo6ulebut@MacBook-Pro-5.local.dhcp.thefacebook.com>
 <20221115200541.bm7xhdurhpxuv54u@apollo>
 <1f856abf-0161-c560-7941-423c9f8c472e@meta.com>
 <20221117182404.lgi3nq4jcomjlbvp@apollo>
 <94f9ec8d-8b54-2873-21d0-948c667e20d8@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f9ec8d-8b54-2873-21d0-948c667e20d8@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 04:22:40AM IST, Yonghong Song wrote:
>
>
> On 11/17/22 10:24 AM, Kumar Kartikeya Dwivedi wrote:
> > On Wed, Nov 16, 2022 at 01:56:14AM IST, Yonghong Song wrote:
> > >
> > >
> > > On 11/15/22 12:05 PM, Kumar Kartikeya Dwivedi wrote:
> > > > On Wed, Nov 16, 2022 at 01:13:08AM IST, Alexei Starovoitov wrote:
> > > > > On Mon, Nov 14, 2022 at 08:23:39AM -0800, Yonghong Song wrote:
> > > > > > The signature of bpf_get_kern_btf_id() function looks like
> > > > > >     void *bpf_get_kern_btf_id(obj, expected_btf_id)
> > > > > > The obj has a pointer type. The expected_btf_id is 0 or
> > > > > > a btf id to be returned by the kfunc. The function
> > > > > > currently supports two kinds of obj:
> > > > > >     - obj: ptr_to_ctx, expected_btf_id: 0
> > > > > >       return the expected kernel ctx btf id
> > > > > >     - obj: ptr to char/unsigned char, expected_btf_id: a struct btf id
> > > > > >       return expected_btf_id
> > > > > > The second case looks like a type casting, e.g., in kernel we have
> > > > > >     #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
> > > > > > bpf program can get a skb_shared_info btf id ptr with bpf_get_kern_btf_id()
> > > > > > kfunc.
> > > > >
> > > > > Kumar has proposed
> > > > > bpf_rdonly_cast(any_64bit_value, btf_id) -> PTR_TO_BTF_ID | PTR_UNTRUSTED.
> > > > > The idea of bpf_get_kern_btf_id(ctx) looks complementary.
> > > > > The bpf_get_kern_btf_id name is too specific imo.
> > > > > How about two kfuncs:
> > > > >
> > > > > bpf_cast_to_kern_ctx(ctx) -> ptr_to_btf_id | ptr_trusted
> > > > > bpf_rdonly_cast(any_scalar, btf_id) -> ptr_to_btf_id | ptr_untrusted
> > >
> > > Sounds good. Two helpers can make sense as it is indeed true for
> > > bpf_cast_to_kern_ctx(ctx), the btf_id is not needed.
> > >
> > > > >
> > > > > ptr_trusted flag will have semantics as discsused with David and Kumar in:
> > > > > https://lore.kernel.org/bpf/CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com/
> > > > >
> > > > > The verifier knows how to cast safe pointer 'ctx' to kernel 'mirror' structure.
> > > > > No need for additional btf_id argument.
> > > > > We can express it as ptr_to_btf_id | ptr_trusted and safely pass to kfuncs.
> > > > > bpf_rdonly_cast() can accept any 64-bit value.
> > > > > There is no need to limit it to 'char *' arg. Since it's ptr_to_btf_id | ptr_untrusted
> > > > > it cannot be passed to kfuncs and only rdonly acccess is allowed.
> > > > > Both kfuncs need to be cap_perfmon gated, of course.
> > > > > Thoughts?
> > >
> > > Currently, we only have SCALAR_VALUE to represent 'void *', 'char *',
> > > 'unsigned char *'. yes, some pointer might be long and cast to 'struct foo
> > > *', so the generalization of bpf_rdonly_cast() to all scalar value
> > > should be fine. Although it is possible the it might be abused and incuring
> > > some exception handling, but guarding it with cap_perfmon
> > > should be okay.
> > >
> > > >
> > > > Here is the PoC I wrote when we discussed this:
> > > > It still uses bpf_unsafe_cast naming, but that was before Alexei suggested the
> > > > bpf_rdonly_cast name.
> > > > https://github.com/kkdwivedi/linux/commits/unsafe-cast (see the 2 latest commits)
> > > > The selftest showcases how it will be useful.
> > >
> > > Sounds good. I can redo may patch for bpf_cast_to_kern_ctx(), which should
> > > cover some of existing cases. Kumar, since you are working on
> > > bpf_rdonly_cast(), you could work on that later. If you want me to do it,
> > > just let me know I can incorporate it in my patch set.
>
> I just prototyped a little bit with Alexei's suggested interface. It has
> some differences. I will explain in my next revision.
>
> My prototype already added bpf_rdonly_cast(). As you suggested, it is
> not too hard. I have not done with module btf yet. Will add it
> as you suggested below.
>

It's fine to also leave out types in module BTFs for now, atleast as long you
return a reasonable error message from the verifier. Just relying on btf_vmlinux
is enough for the FIXMEs in selftests.
