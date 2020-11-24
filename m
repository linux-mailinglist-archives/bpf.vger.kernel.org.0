Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017352C26D7
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 14:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbgKXNKw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 08:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733262AbgKXNKu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 08:10:50 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F60EC0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 05:10:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m6so22251454wrg.7
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 05:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GoJAxHLDoVqbIziLFiALs3iwDpgfId+a82Qr/9mzh6c=;
        b=GfwTANUxL2mqjBIacvbmm1WDWKzxM8rCchvjgxbsU9GTD+y+tgH2gadOUaE7vP1sx0
         fP2MlR+hSq8H8i1MBhbs7dHxtIORlLtOIXUKFo9JsT4k+QWLXvS8dxsrGF3tMuRfE+g6
         oenbHXpfAqhB8rdP0rREd8wwr/wElVM8CTsDl+m9JdntghILmNsRhPFeGkqF7QFOPIDg
         Lue3S2QuAwQTLsmY1tIzwQ/aDpBe2gQE5mVQI3r5S1B21knsA+ux7UGsugXnYkkwZ8bT
         b0SGsHDh3Hy9eprE5d/c0X4AbuyU1v/emTK9agBaPfOGiLR5Ee+VWs8848a1865Ko9jz
         VUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GoJAxHLDoVqbIziLFiALs3iwDpgfId+a82Qr/9mzh6c=;
        b=L5fpp+MSxCzCvDFD8I6DZ5kOLgETwKi3F/1tGXeGSmJqZAXZ2F7a9PjN/ucW3jTABv
         ufSmN4pcWcSaRBbRYaMGF2fRzfG5IoNPZP1FWuNAwTE8+vWVW7KENh0IRkfv0f1br24z
         DRQezQ1no+Yo7AA5RmBtPKr+XIwbKRB+TE7KcF8m6z+izjDD/TFwOm8CAWg//UCyN9Do
         iYtWmQ+WpRBJjcTQcQQA1L/McFaeL8X7rVVo7I3pD739Zawy2QeJB2x8DEX9SLmF9HTd
         fwM5wcU3VVtLJqz3yzdvK1dnD5/zPEzaH3NkqIulyFdeJxXIUv/SOtucqXikKkS3IrU+
         Rd8Q==
X-Gm-Message-State: AOAM533F1H3TNx8dPYqXbBUJ+VjhHvrEzIZ+brvTzl2zs/pspXNbhOKT
        03VPxLJfZLIKuRRBHAYHg0AAPw==
X-Google-Smtp-Source: ABdhPJyiOOz4EG0+mUr0d7+GLs+20zZ3MwZW/i+fWgK4URj5tAefLezjF5OoJvmgDG7SGM041lqohw==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr5243259wrl.406.1606223448675;
        Tue, 24 Nov 2020 05:10:48 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id d128sm5812719wmc.7.2020.11.24.05.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 05:10:47 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:10:44 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH 7/7] bpf: Add tests for new BPF atomic operations
Message-ID: <20201124131044.GA1912645@google.com>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-8-jackmanb@google.com>
 <c4cf639c-f499-5179-45f4-0fe374eb7444@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cf639c-f499-5179-45f4-0fe374eb7444@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 04:26:45PM -0800, Yonghong Song wrote:
> On 11/23/20 9:32 AM, Brendan Jackman wrote:
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 3d5940cd110d..4e28640ca2d8 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -250,7 +250,7 @@ define CLANG_BPF_BUILD_RULE
> >   	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
> >   	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
> >   		-c $1 -o - || echo "BPF obj compilation failed") | 	\
> > -	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
> > +	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v4 $4 -filetype=obj -o $2
> 
> We have an issue here. If we change -mcpu=v4 here, we will force
> people to use trunk llvm to run selftests which is not a good idea.
> 
> I am wondering whether we can single out progs/atomics_test.c, which will be
> compiled with -mcpu=v4 and run with test_progs.
> 
> test_progs-no_alu32 runs tests without alu32. Since -mcpu=v4 implies
> alu32, atomic tests should be skipped in test_progs-no-alu32.
> 
> In bpf_helpers.h, we already use __clang_major__ macro to compare
> to clang version,
> 
> #if __clang_major__ >= 8 && defined(__bpf__)
> static __always_inline void
> bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
> {
>         if (!__builtin_constant_p(slot))
>                 __bpf_unreachable();
> ...
> 
> I think we could also use __clang_major__ in progs/atomics_test.c
> to enable tested intrinsics only if __clang_major__ >= 12? This
> way, the same code can be compiled with -mcpu=v2/v3.
> 
> Alternatively, you can also use a macro at clang command line like
>    clang -mcpu=v4 -DENABLE_ATOMIC ...
>    clang -mcpu=v3/v2 ...
> 
> progs/atomics_test.c:
>    #ifdef ENABLE_ATOMIC
>      ... atomic_intrinsics ...
>    #endif

Ah - all good points, thanks. Looks like tools/build/feature/ might
offer a solution here, I'll investigate.

> > diff --git a/tools/testing/selftests/bpf/progs/atomics_test.c b/tools/testing/selftests/bpf/progs/atomics_test.c
> > new file mode 100644
> > index 000000000000..d81f45eb6c45
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/atomics_test.c
> > @@ -0,0 +1,61 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +__u64 add64_value = 1;
> > +__u64 add64_result;
> > +__u32 add32_value = 1;
> > +__u32 add32_result;
> > +__u64 add_stack_value_copy;
> > +__u64 add_stack_result;
> 
> To please llvm10, let us initialize all unitialized globals explicitly like
>    __u64 add64_result = 0;
>    __u32 add32_result = 0;
>    ...
> 
> llvm11 and above are okay but llvm10 put those uninitialized globals
> into COM section (not .bss or .data sections) which BTF did not
> handle them.

Thanks, will initialise everything explicitly.
