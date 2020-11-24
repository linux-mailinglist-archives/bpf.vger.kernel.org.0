Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314862C2357
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 11:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgKXKz6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 05:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXKz5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 05:55:57 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D51EC0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 02:55:57 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so21793943wrw.10
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 02:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JCQBMvTLGbn7SPzlBNdpZLU5AFVopTaXD7LVkt4Ri84=;
        b=mlUw/ivDXH4XWWDkCEV/NCzU4KhWITVziZbB6RXassO38zX3wlfSBYpckt3hfp2H1Y
         joHA3G7GwVRgo3sQO7+1q54RpJbFqKkfX9KYayns/eqDqtMJ3k9tl4Cc/DJeukM9O3Oh
         kFUIQK2JJkGL0Tv5JnTMfocUh65k4gCz3UJAW/0EII0x59A0nPJn863xCFUsaTyOEebL
         P42KEuGR7OSvqggkEGWIXduxnakChHIIcWCgh0ZPth4zdmh6Xexd9pEtjbRJEeHzfLcz
         iCIjSTuI15YyB2owjMAHogtwARZxYZ1NGn6ABoq4LLr6VJhDd/Yei6VRas+Yyb9d92Am
         Ay5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JCQBMvTLGbn7SPzlBNdpZLU5AFVopTaXD7LVkt4Ri84=;
        b=NSs7+zHbO7Quz9q68K1DoG0CtbgRixr5PNbzG3T3fpE90MLDG+7K9VSH7etpDMRwsJ
         muR8+IvZfsZQP7+MlLWmBC8UZB1AcB4WWNzI3Z/RWO9703EzSZhK9g5bg4IeO8eVmkYU
         YO6Iqg/meEw4Js+Zjo4ip9cb17qah+1QGgHJ/GSNsD2nCeX9I7ZfIYYQXlnKnPu60bFS
         im1c38FeVQkfhELE2Bto2sI9hsrH7wdjgxGOgPZIZ47VUfAZ5CuYzdo0VOJ8+XjU53mP
         29wmUzOEt/37N9y+Z1FydB2pqiatD5gs/kVglXUP4lqzxTFk0jK9HyerABZu5yVpsn7B
         coFQ==
X-Gm-Message-State: AOAM532DgGridIO72etjXxtBhs6mhxcD56ij4am+mBhWW8JlRBkRthUo
        VpG20j5fM+sUuVbVWfLFBqjyDQ==
X-Google-Smtp-Source: ABdhPJz62LPWkFoWApBb+aoojckNOatdZWmuG4cUbIbj0wnCIOD/adrrob9q2Tqg5aLZL3lh31nTPQ==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr4452239wrt.385.1606215355965;
        Tue, 24 Nov 2020 02:55:55 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id a15sm25504570wrn.75.2020.11.24.02.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:55:55 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:55:51 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH 6/7] bpf: Add instructions for atomic_cmpxchg and friends
Message-ID: <20201124105551.GB1883487@google.com>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-7-jackmanb@google.com>
 <20201124064000.5wd4ngq7ydb63chl@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124064000.5wd4ngq7ydb63chl@ast-mbp>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 10:40:00PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 23, 2020 at 05:32:01PM +0000, Brendan Jackman wrote:
> > These are the operations that implement atomic exchange and
> > compare-exchange.
> > 
> > They are peculiarly named because of the presence of the separate
> > FETCH field that tells you whether the instruction writes the value
> > back to the src register. Neither operation is supported without
> > BPF_FETCH:
> > 
> > - BPF_CMPSET without BPF_FETCH (i.e. an atomic compare-and-set
> >   without knowing whether the write was successfully) isn't implemented
> >   by the kernel, x86, or ARM. It would be a burden on the JIT and it's
> >   hard to imagine a use for this operation, so it's not supported.
> > 
> > - BPF_SET without BPF_FETCH would be bpf_set, which has pretty
> >   limited use: all it really lets you do is atomically set 64-bit
> >   values on 32-bit CPUs. It doesn't imply any barriers.
> 
> ...
> 
> > -			if (insn->imm & BPF_FETCH) {
> > +			switch (insn->imm) {
> > +			case BPF_SET | BPF_FETCH:
> > +				/* src_reg = atomic_chg(*(u32/u64*)(dst_reg + off), src_reg); */
> > +				EMIT1(0x87);
> > +				break;
> > +			case BPF_CMPSET | BPF_FETCH:
> > +				/* r0 = atomic_cmpxchg(*(u32/u64*)(dst_reg + off), r0, src_reg); */
> > +				EMIT2(0x0F, 0xB1);
> > +				break;
> ...
> >  /* atomic op type fields (stored in immediate) */
> > +#define BPF_SET		0xe0	/* atomic write */
> > +#define BPF_CMPSET	0xf0	/* atomic compare-and-write */
> > +
> >  #define BPF_FETCH	0x01	/* fetch previous value into src reg */
> 
> I think SET in the name looks odd.
> I understand that you picked this name so that SET|FETCH together would form
> more meaningful combination of words, but we're not planning to support SET
> alone. There is no such instruction in a cpu. If we ever do test_and_set it
> would be something different.

Yeah this makes sense...

> How about the following instead:
> +#define BPF_XCHG	0xe1	/* atomic exchange */
> +#define BPF_CMPXCHG	0xf1	/* atomic compare exchange */
> In other words get that fetch bit right away into the encoding.
> Then the switch statement above could be:
> +			switch (insn->imm) {
> +			case BPF_XCHG:
> +				/* src_reg = atomic_chg(*(u32/u64*)(dst_reg + off), src_reg); */
> +				EMIT1(0x87);
> ...
> +			case BPF_ADD | BPF_FETCH:
> ...
> +			case BPF_ADD:

... Although I'm a little wary of this because it makes it very messy to
do something like switch(BPF_OP(insn->imm)) since we'd have no name for
BPF_OP(0xe1). That might be fine - I haven't needed such a construction
so far (although I have used BPF_OP(insn->imm)) so maybe we wouldn't
ever need it.

What do you think? Maybe we add the `#define BPF_XCHG 0xe1` and then if we
later need to do switch(BPF_OP(insn->imm)) we could bring back
`#define BPF_SET 0xe` as needed?
