Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F37D62A274
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 21:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiKOUFs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 15:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiKOUFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 15:05:47 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A799F6457
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:05:46 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s196so14345511pgs.3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4kUaQFFalWZJabGWS2zlLIPu+5wHKe22VmlC16TS/Q=;
        b=ZI74xwrtV3xiN+va2YWPdRQ/Js1DGKuTjIBup7EtyDbmKi4X6YlqRyX0+I6GgaHd5U
         AZVuSpFprJjOEgR/iE7PQ433Tb7Xp3UOp6MWdzLTJggRkcLOKPTPbXjs9WDdXwGwru25
         /I1sDdD7weK56SD3R/pig0nxrLbDkBtEIxZ6ZEHWXTLanTG4tpcemACd0ycRJdvDv7Th
         MqmD4VSFIW8j3QN3iyCG312eZVzCAvJ5qD6sHrrB3ChwHp6x1w8CVrg30hKRJU8+B+rw
         UbSt+WxyhBAp4peCC+Q6WRBNiTcC5naYHFOhLIfLANbG2VXcVmOgCe4XV/qm8g04He72
         dg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4kUaQFFalWZJabGWS2zlLIPu+5wHKe22VmlC16TS/Q=;
        b=Sgz6FRczPAnhQuWt0xzqamdHb4W/e19C6ezk30Okh5UntoihuCNeExBz0w7I5ICVio
         sQ90cCbj9UiCGzhq/DIk9T+47nQ4uYdLlKXDipHoqgZCmM7vrkvyBZjyy31+e5ZPoblq
         00KrbQLpBS/IZM8ULK4CoKFx8GTGTvdUXee5oD7PxcUpKR1VWwwiy51GcZMwB/ugnG4F
         PIGGZUjnwtfnRdTrMc6NrGoL2QFg1rHjtilaGjZhXylcfKa/zQ7bbQz61boyJjaRxXqb
         sSisg4BrujFm5l6+fULlrIpH0zlDTR54OklHXv+b42jt08Festxb+6w9QIUz1yxAZ+Yy
         TH+g==
X-Gm-Message-State: ANoB5pl7QgEQSS3xl+zCiQXMGJP8vCD8neqyTzxmSG8Ja7BeP64nCfvc
        9NsJjH6EwLW7GS1YyE4wSDMx9dWIepU=
X-Google-Smtp-Source: AA0mqf5Y3S375sLPpurMivWIBPQknQ0C2fDPSqli8sMyTz56xau+UPD4p34FZuBfvIAgWNp6fsnEZQ==
X-Received: by 2002:a65:6d8b:0:b0:46b:158f:6265 with SMTP id bc11-20020a656d8b000000b0046b158f6265mr17317472pgb.193.1668542746096;
        Tue, 15 Nov 2022 12:05:46 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id pb5-20020a17090b3c0500b00212e5068e17sm8763293pjb.40.2022.11.15.12.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 12:05:45 -0800 (PST)
Date:   Wed, 16 Nov 2022 01:35:41 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf_get_kern_btf_id()
 kfunc
Message-ID: <20221115200541.bm7xhdurhpxuv54u@apollo>
References: <20221114162328.622665-1-yhs@fb.com>
 <20221114162339.625320-1-yhs@fb.com>
 <20221115194308.ej5lwd2jo6ulebut@MacBook-Pro-5.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115194308.ej5lwd2jo6ulebut@MacBook-Pro-5.local.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 01:13:08AM IST, Alexei Starovoitov wrote:
> On Mon, Nov 14, 2022 at 08:23:39AM -0800, Yonghong Song wrote:
> > The signature of bpf_get_kern_btf_id() function looks like
> >   void *bpf_get_kern_btf_id(obj, expected_btf_id)
> > The obj has a pointer type. The expected_btf_id is 0 or
> > a btf id to be returned by the kfunc. The function
> > currently supports two kinds of obj:
> >   - obj: ptr_to_ctx, expected_btf_id: 0
> >     return the expected kernel ctx btf id
> >   - obj: ptr to char/unsigned char, expected_btf_id: a struct btf id
> >     return expected_btf_id
> > The second case looks like a type casting, e.g., in kernel we have
> >   #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
> > bpf program can get a skb_shared_info btf id ptr with bpf_get_kern_btf_id()
> > kfunc.
>
> Kumar has proposed
> bpf_rdonly_cast(any_64bit_value, btf_id) -> PTR_TO_BTF_ID | PTR_UNTRUSTED.
> The idea of bpf_get_kern_btf_id(ctx) looks complementary.
> The bpf_get_kern_btf_id name is too specific imo.
> How about two kfuncs:
>
> bpf_cast_to_kern_ctx(ctx) -> ptr_to_btf_id | ptr_trusted
> bpf_rdonly_cast(any_scalar, btf_id) -> ptr_to_btf_id | ptr_untrusted
>
> ptr_trusted flag will have semantics as discsused with David and Kumar in:
> https://lore.kernel.org/bpf/CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com/
>
> The verifier knows how to cast safe pointer 'ctx' to kernel 'mirror' structure.
> No need for additional btf_id argument.
> We can express it as ptr_to_btf_id | ptr_trusted and safely pass to kfuncs.
> bpf_rdonly_cast() can accept any 64-bit value.
> There is no need to limit it to 'char *' arg. Since it's ptr_to_btf_id | ptr_untrusted
> it cannot be passed to kfuncs and only rdonly acccess is allowed.
> Both kfuncs need to be cap_perfmon gated, of course.
> Thoughts?

Here is the PoC I wrote when we discussed this:
It still uses bpf_unsafe_cast naming, but that was before Alexei suggested the
bpf_rdonly_cast name.
https://github.com/kkdwivedi/linux/commits/unsafe-cast (see the 2 latest commits)
The selftest showcases how it will be useful.
