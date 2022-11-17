Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4C62E40A
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 19:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiKQSYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 13:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiKQSYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 13:24:08 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9A6868F
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 10:24:07 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id g62so2559686pfb.10
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 10:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzrd9izOBINhUGei9NEYFay2PTIqnv1ol+lF9aRUpiE=;
        b=J+Z0l6Fx7BOQwj/oZxgUqOXtkvqmFvlf9uffZI2W2aCkoLA+iB82EAEG+gxgnOaM5K
         cOo+shvCHa9cVu3/ug7pf50wnNQ6yxH0xO8NWpYCXgIjWTqTs/3OOYW4dYyfX8KNslNu
         E9bGARyBiPuYv9z+Kl4K1ecngw9DKbRujdDIYeAXRNOCuJNDveGpHCCRCbk7ylU5kUZA
         7Bha6kUerti+7y2Kv3jpf0GsVnwz/6Ilu/YRMJZbCjxjNr/tOU5aYCriQ0dSv9R4/uav
         tXDt0uPoubkrf0WarKAMgOskWOp5ZW0bqUX2OedxPzFzeeD/5eZypqAWjJcbg1s24QnR
         fWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzrd9izOBINhUGei9NEYFay2PTIqnv1ol+lF9aRUpiE=;
        b=kwOPsPsjFRFsIMQDjtMzyGu7XG+PabdmU2eSi3v9w8uvPK/UQtAHpf8cneciIe/ple
         AkUp2PSD//vkmoCb4mgUjrMd3Vxm35a7rbJo6JIuotZEDokBtbcwsLajSio4eWRS/kh6
         MRW08CjRR8loagp84smUl6NqAquzVpaxnrYo/Ac/BnSAZrOsP91jJ2TQyLlhEWaugawi
         uOya8sAVvd5GQQsFe73ma8riilzyQQLmweUprGjjNq5Y5cSWM1KLw5CzoLK7lcn12oEP
         +jIvigJIazBJjSXGI9MW7v7f/honj7SdzN3WxVE5KOulSQuIGqE20X+3e0M9XinkfFXN
         BDSw==
X-Gm-Message-State: ANoB5pm4t0wrCG4kr6iIQHiONfPcFypqnQsaYkAz8tjFzgbZ9nEnTkql
        sS1xboOumiMbGusTgWbGzOs=
X-Google-Smtp-Source: AA0mqf4WVMmFrGXs1DVcURIBbJqL+rNMR8T3wzQFDHpPFco9jBP31UPgP/I+mxS2OqasKCkRtEg/XQ==
X-Received: by 2002:a63:5d3:0:b0:45f:c9d5:d490 with SMTP id 202-20020a6305d3000000b0045fc9d5d490mr3122839pgf.392.1668709447166;
        Thu, 17 Nov 2022 10:24:07 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b0057253eb631dsm1471194pfg.46.2022.11.17.10.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:24:06 -0800 (PST)
Date:   Thu, 17 Nov 2022 23:54:04 +0530
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
Message-ID: <20221117182404.lgi3nq4jcomjlbvp@apollo>
References: <20221114162328.622665-1-yhs@fb.com>
 <20221114162339.625320-1-yhs@fb.com>
 <20221115194308.ej5lwd2jo6ulebut@MacBook-Pro-5.local.dhcp.thefacebook.com>
 <20221115200541.bm7xhdurhpxuv54u@apollo>
 <1f856abf-0161-c560-7941-423c9f8c472e@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f856abf-0161-c560-7941-423c9f8c472e@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 01:56:14AM IST, Yonghong Song wrote:
>
>
> On 11/15/22 12:05 PM, Kumar Kartikeya Dwivedi wrote:
> > On Wed, Nov 16, 2022 at 01:13:08AM IST, Alexei Starovoitov wrote:
> > > On Mon, Nov 14, 2022 at 08:23:39AM -0800, Yonghong Song wrote:
> > > > The signature of bpf_get_kern_btf_id() function looks like
> > > >    void *bpf_get_kern_btf_id(obj, expected_btf_id)
> > > > The obj has a pointer type. The expected_btf_id is 0 or
> > > > a btf id to be returned by the kfunc. The function
> > > > currently supports two kinds of obj:
> > > >    - obj: ptr_to_ctx, expected_btf_id: 0
> > > >      return the expected kernel ctx btf id
> > > >    - obj: ptr to char/unsigned char, expected_btf_id: a struct btf id
> > > >      return expected_btf_id
> > > > The second case looks like a type casting, e.g., in kernel we have
> > > >    #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
> > > > bpf program can get a skb_shared_info btf id ptr with bpf_get_kern_btf_id()
> > > > kfunc.
> > >
> > > Kumar has proposed
> > > bpf_rdonly_cast(any_64bit_value, btf_id) -> PTR_TO_BTF_ID | PTR_UNTRUSTED.
> > > The idea of bpf_get_kern_btf_id(ctx) looks complementary.
> > > The bpf_get_kern_btf_id name is too specific imo.
> > > How about two kfuncs:
> > >
> > > bpf_cast_to_kern_ctx(ctx) -> ptr_to_btf_id | ptr_trusted
> > > bpf_rdonly_cast(any_scalar, btf_id) -> ptr_to_btf_id | ptr_untrusted
>
> Sounds good. Two helpers can make sense as it is indeed true for
> bpf_cast_to_kern_ctx(ctx), the btf_id is not needed.
>
> > >
> > > ptr_trusted flag will have semantics as discsused with David and Kumar in:
> > > https://lore.kernel.org/bpf/CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com/
> > >
> > > The verifier knows how to cast safe pointer 'ctx' to kernel 'mirror' structure.
> > > No need for additional btf_id argument.
> > > We can express it as ptr_to_btf_id | ptr_trusted and safely pass to kfuncs.
> > > bpf_rdonly_cast() can accept any 64-bit value.
> > > There is no need to limit it to 'char *' arg. Since it's ptr_to_btf_id | ptr_untrusted
> > > it cannot be passed to kfuncs and only rdonly acccess is allowed.
> > > Both kfuncs need to be cap_perfmon gated, of course.
> > > Thoughts?
>
> Currently, we only have SCALAR_VALUE to represent 'void *', 'char *',
> 'unsigned char *'. yes, some pointer might be long and cast to 'struct foo
> *', so the generalization of bpf_rdonly_cast() to all scalar value
> should be fine. Although it is possible the it might be abused and incuring
> some exception handling, but guarding it with cap_perfmon
> should be okay.
>
> >
> > Here is the PoC I wrote when we discussed this:
> > It still uses bpf_unsafe_cast naming, but that was before Alexei suggested the
> > bpf_rdonly_cast name.
> > https://github.com/kkdwivedi/linux/commits/unsafe-cast (see the 2 latest commits)
> > The selftest showcases how it will be useful.
>
> Sounds good. I can redo may patch for bpf_cast_to_kern_ctx(), which should
> cover some of existing cases. Kumar, since you are working on
> bpf_rdonly_cast(), you could work on that later. If you want me to do it,
> just let me know I can incorporate it in my patch set.

I think the patch itself is pretty trivial. What's needed is a bit of
refactoring, since I would also want to make this work for module BTF types.

In that case, we need to take a type in prog BTF, look it up in the kernel, and
mark the reg using looked up BTF and BTF ID. However this raises module BTF
reference, and it needs to be kept until verifier is done (as it gets set to
reg->btf).

This is why the helper takes local type ID instead of bpf_core_type_id_kernel,
since that doesn't work for module types (IIUC).

Instead of the current used_btfs array logic, Alexei suggested guarding module
BTF free path with a rwsem, which the verifier can hold in bpf_check, so that we
don't have to worry about keeping module BTF references around during verification.
Modules are loaded/unloaded infrequently so it should be fine.

Then it also became clear we currently stash BTFs in some places unecessarily
and we could simply drop those after prog is verified. So it would make sense
to drop those cases too (kfunc_btf_tab, used_btfs btf_mod_pair, etc.). After
verification the prog only needs to pin the module references, not mod BTF
references.

Maybe all of this does not have to be done together.

So let me know if you want to take it, I have no problems with that, otherwise I
can get to it once I am done with the linked list and dynptr stuff.
