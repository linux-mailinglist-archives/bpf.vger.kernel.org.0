Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6124FA0F1
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 03:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiDIBOK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 21:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiDIBOJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 21:14:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08532FFCC
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 18:12:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t6so2998535plg.7
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2vXZE0uDSFxYmjVDGL9okvlW+ENKtxkiBU829PPFQEU=;
        b=QqWrlPoBdbqjiYWr2fxEv1/7UTg/Cm6x/VduvExPWlBMbKNVedTrjPL5+50Mj5d9Fs
         9q2HGwXLUXPeMQsiW7/kPbGjHDMW9XZhBjyuriWszY38Vbxb739bwp5Y/giwc32WxS1W
         kuiepr2oSKTg06eTuenc7bObAikHCNi/zbgsc64bIuIed7/CzRNQW4ZZIcSyj6xOndj8
         tLyDxjyQwDkWbB9PQ0WWJU0lYswyYl6M0IESz/KumoB2dePpK2QLi8xvSU4R5UAAUejY
         AUpFddpJek7CAl4cnfULB6Mr7CfQnH+hEGaA4L1V+C/TUBV90lwHdKaOjSRc6URex3aQ
         Tghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2vXZE0uDSFxYmjVDGL9okvlW+ENKtxkiBU829PPFQEU=;
        b=n5iU3GIQ2jP+ly8NuvpkMnVCo1QvL1dXcgLFCNsAJvYONNY1XHCS2b+xEGRtrKonPp
         SBNHZuuK6CUWGZpyodknO4rUqnp7rTtKZk9QX87EUtHr6SNU07yinR7BCC9PEQYNXtQW
         HvkcMUS1QBzDmc60NlRhEMLHy7PL6Ky3Fre/mXZTwQ9sDOauuyPzrXi+nfQeClRa2jgG
         3eZg7UDqcmhAZm6SAzCII+XIIDdHgzIcTnm4kuoC0oVbI7sFy+KcF7r6MZNPDXE+1rK/
         p1HC+RlWXFAxDVddnIsl+QcDJSK46jWAYHGM4NaiDYG9iFiUVr2iKxTAr9HM9pEifMgP
         b+DA==
X-Gm-Message-State: AOAM5307tmyJX6GE+4RRVdjHA5AbsWtuESdHzXf8b12u8rbTJ8ihOtB8
        M6B+OWJL/X0wOsYwn16YgVx//CNZ0E8=
X-Google-Smtp-Source: ABdhPJyafbU9/YFxNGoPoaBAHJ0LY4CnTY4iuQZTe42QLKPOyTmCOhfAVx6cdxk1UT3+bUVdjecpzA==
X-Received: by 2002:a17:902:bcc2:b0:14f:23c6:c8c5 with SMTP id o2-20020a170902bcc200b0014f23c6c8c5mr21599658pls.131.1649466722103;
        Fri, 08 Apr 2022 18:12:02 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:4c4c])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79a45000000b00504a1c8b75asm8515316pfj.165.2022.04.08.18.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 18:12:01 -0700 (PDT)
Date:   Fri, 8 Apr 2022 18:11:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_malloc, bpf_free
Message-ID: <20220409011158.dwkolvp4nyjl5kvr@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220402015826.3941317-1-joannekoong@fb.com>
 <20220402015826.3941317-4-joannekoong@fb.com>
 <CAEf4BzbRsA+JTP+4mqWpjRd_KEtaaM74ihz7RKGgpu_outhxTg@mail.gmail.com>
 <CAJnrk1Y8nE7n6PY9f7KBHH-P_ji3vAnuH5UP0r1fAk4OUTUZtQ@mail.gmail.com>
 <CAEf4Bzbp=91iYC5Ggm2W6gd3m_=wYXUXrZ7XLnGU5i=STcVAWA@mail.gmail.com>
 <CAJnrk1bxi9Ax0RBCGEz61tH0v2DCZwy=R132R4BS5737-WMN9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1bxi9Ax0RBCGEz61tH0v2DCZwy=R132R4BS5737-WMN9Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 08, 2022 at 04:37:02PM -0700, Joanne Koong wrote:
> > > > > + *
> > > > > + * void bpf_free(struct bpf_dynptr *ptr)
> > > >
> > > > thinking about the next patch set that will add storing this malloc
> > > > dynptr into the map, bpf_free() will be a lie, right? As it will only
> > > > decrement a refcnt, not necessarily free it, right? So maybe just
> > > > generic bpf_dynptr_put() or bpf_malloc_put() or something like that is
> > > > a bit more "truthful"?
> > > I like the simplicity of bpf_free(), but I can see how that might be
> > > confusing. What are your thoughts on "bpf_dynptr_free()"? Since when
> > > we get into dynptrs that are stored in maps vs. dynptrs stored
> > > locally, calling bpf_dynptr_free() frees (invalidates) your local
> > > dynptr even if it doesn't free the underlying memory if it still has
> > > valid refcounts on it? To me, "malloc" and "_free" go more intuitively
> > > together as a pair.
> >
> > Sounds good to me (though let's use _dynptr() as a suffix
> > consistently). I also just realized that maybe we should call
> > bpf_malloc() a bpf_malloc_dynptr() instead. I can see how we might
> > want to enable plain bpf_malloc() with statically known size (similar
> > to statically known bpf_ringbuf_reserve()) for temporary local malloc
> > with direct memory access? So bpf_malloc_dynptr() would be a
> > dynptr-enabled counterpart to fixed-sized bpf_malloc()? And then
> > bpf_free() will work with direct pointer returned from bpf_malloc(),
> > while bpf_free_dynptr() will work with dynptr returned from
> > bpf_malloc_dynptr().
> I see! What is the advantage of a plain bpf_malloc()? Is it that it's
> a more ergonomic API (you get back a direct pointer to the data
> instead of getting back a dynptr and then having to call
> bpf_dynptr_data to get direct access) and you don't have to allocate
> extra bytes for refcounting?
> 
> I will rename this to bpf_malloc_dynptr() and bpf_free_dynptr().

Let's make it consistent with kptr. Those helpers will be:
bpf_kptr_alloc(btf_id, flags, &ptr)
bpf_kptr_get
bpf_kptr_put

bpf_dynptr_alloc(byte_size, flags, &dynptr);
bpf_dynptr_put(dynptr);
would fit the best.

Output arg being first doesn't match anything we had.
let's keep it last.

zero-alloc or plain kmalloc can be indicated by the flag.
kzalloc() in the kernel is just static inline that adds __GFP_ZERO to flags.
We don't need bpf_dynptr_alloc and bpf_dynptr_zalloc as two helpers.
The latter can be a static inline helper in a bpf program.

Similar to Andrii's concern I feel that bpf_dynptr_free() would be misleading.
