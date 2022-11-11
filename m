Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A316E626056
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 18:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiKKRUH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 12:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiKKRTx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 12:19:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90859FF6
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 09:19:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t6-20020a25b706000000b006b38040b6f7so4982891ybj.6
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 09:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6PFX+CGHlg2L75TbaYPOEyPm2gVRHc3sOiqBvG6MyE=;
        b=lAhzaPjnGUUwHDdUj5BuuYNAZ9nEkvkUH/fjS+YtSQyLQsRGUvECoifdApGVnGVHSi
         9UfR6Uo4U2f1xwjzic5I2Y2OnaFEqYNsc8BTmSl1UmYQ2j8Dlz4JAs6m5lfHqdUFE990
         WOF5Fa1yKfseL/37Pu29lF+xxqtfys3raM1WGoxRvKptx4juezPTMXb3dzAfwIfd6PFi
         ywAWjUF93qO9GJ9dzQ3xX4pKwRfx6WxqS0AFaumae4jRCbXLKLA8WYg+3f+IA2c/bLZX
         GxiaXDWLb+soY4Oggwz8v+AjU2+h54I456dUQ+sbXUNnVQf+QwUo5OuHsSzsOusAcwdn
         RHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6PFX+CGHlg2L75TbaYPOEyPm2gVRHc3sOiqBvG6MyE=;
        b=7mp2fmF7BZIBafKw5m0SCrWLVV9TxqF2CNnHaymeaCTtZy8D1obrBVTjT1pe1Ilb7g
         QNTNwdTI24zgI0gNstmkXg4ha8e+z+6oYpu+u+EK7TRDAaH0LE6zPH06Bn5/4pkOtpIm
         x9qL278nMejugw52Ci8PmCqmIm/H4Yf4OsWYbUedHkCXL1P6eED6Jxew5hvjsaKbLlIJ
         0DtTQJB0bUilOYlESaoS7IEjF/Y5Mnmd6HWJsSvT5QhavKBDNHd6K2S9d8+6mLLoxB+c
         clM6oQVzxjekAdcjr6Ib4dZ9Er9ZiaqTPcKcbTKHN6Xp/0LXHIQ45YJotkaeWUIclE0P
         02rg==
X-Gm-Message-State: ANoB5plM5nl+GGdPXiKdYseZ6ywtF++7ZP9A2eahrfHnT1W4GKA91rzw
        UzQa4eAfBBkocTMllOFiahQBp90=
X-Google-Smtp-Source: AA0mqf7JTIn+CZqJY44nJAMV7faNM0m14cP2uvxK3tDme4M/b5bxqHh3WxcS8It8p2UE6665q2/gwUU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:8286:0:b0:6be:266d:eeec with SMTP id
 r6-20020a258286000000b006be266deeecmr2716345ybk.397.1668187178083; Fri, 11
 Nov 2022 09:19:38 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:19:36 -0800
In-Reply-To: <7253d4c4f2ffcd3bff90df8cf8f71af7475167de.camel@gmail.com>
Mime-Version: 1.0
References: <20221110223240.1350810-1-eddyz87@gmail.com> <Y22khvpDYu639yom@google.com>
 <Y22mtIyofEus4KZ0@google.com> <7253d4c4f2ffcd3bff90df8cf8f71af7475167de.camel@gmail.com>
Message-ID: <Y26EKFAMfKPktLBd@google.com>
Subject: Re: [PATCH bpf-next] libbpf: hashmap.h update to fix build issues
 using LLVM14
From:   sdf@google.com
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/11, Eduard Zingerman wrote:
> On Thu, 2022-11-10 at 17:34 -0800, sdf@google.com wrote:
> > On 11/10, Stanislav Fomichev wrote:
> > > On 11/11, Eduard Zingerman wrote:
> > > > A fix for the LLVM compilation error while building bpftool.
> > > > Replaces the expression:
> > > >
> > > >   _Static_assert((p) == NULL || ...)
> > > >
> > > > by expression:
> > > >
> > > >   _Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) | 
> | ...)
> >
> > > IIUC, when __builtin_constant_p(p) returns false, we just ignore the  
> NULL
> > > check?
> > > Do we have cases like that? If no, maybe it's safer to fail?
> >
> > > s/(p) == NULL : 0/(p) == NULL : 1/ ?
> >
> > I'm probably missing something, can you pls clarify? So the error is as
> > follows:
> >
> > > > btf_dump.c:1546:2: error: static_assert expression is not an  
> integral
> > > > constant expression
> >     hashmap__find(name_map, orig_name, &dup_cnt);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     ./hashmap.h:169:35: note: expanded from macro 'hashmap__find'
> >     hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
> >     ^~~~~~~~~~~~~~~~~~~~~~~
> >     ./hashmap.h:126:17: note: expanded from macro 'hashmap_cast_ptr'
> >     _Static_assert((p) == NULL || sizeof(*(p)) ==
> > sizeof(long),
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     btf_dump.c:1546:2: note: cast from 'void *' is not allowed in a  
> constant
> > expression
> >     ./hashmap.h:169:35: note: expanded from macro 'hashmap__find'
> >     hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
> >
> > This line in particular:
> >
> >     btf_dump.c:1546:2: note: cast from 'void *' is not allowed in a  
> constant
> > expression
> >
> > And the code does:
> >
> >    size_t dup_cnt = 0;
> >    hashmap__find(name_map, orig_name, &dup_cnt);
> >
> > So where is that cast from 'void *' is happening? Is it the NULL check
> > itself?
> >
> > Are we simply guarding against the user calling hashmap_cast_ptr with
> > explicit NULL argument?

> In case if (p) is not a constant I want the second part of the || to  
> kick-in.
> The complete condition looks as follows:

>    _Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) || \
> 			sizeof(*(p)) == sizeof(long), "...error...")

> The intent is to check that (p) is either NULL or a pointer to
> something of size long. So, if (p) is not a constant the expression
> would be equivalent to:

>    _Static_assert(0 || sizeof(*(p)) == sizeof(long), "...error...")

> I just tried the following:

> 	struct hashmap *name_map;
> 	char x; // not a constant, wrong pointer size
> 	...
> 	hashmap__find(name_map, orig_name, &x);

> And it fails with an error message as intended:

> btf_dump.c:1548:2: error: static_assert failed due to  
> requirement '(__builtin_constant_p((&x)) ? (&x) == ((void *)0) : 0) ||  
> sizeof (*(&x)) == sizeof(long)' "&x pointee should be a long-sized  
> integer or a pointer"
>          hashmap__find(name_map, orig_name, &x);
> ./hashmap.h:170:35: note: expanded from macro 'hashmap__find'
>          hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
> ./hashmap.h:126:2: note: expanded from macro 'hashmap_cast_ptr'
>          _Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||

Awesome, thanks for clarifying!

Acked-by: Stanislav Fomichev <sdf@google.com>

> >
> > > > When "p" is not a constant the former is not considered to be a
> > > > constant expression by LLVM 14.
> > > >
> > > > The error was introduced in the following patch-set: [1].
> > > > The error was reported here: [2].
> > > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > >
> > > > [1]
> > > https://lore.kernel.org/bpf/20221109142611.879983-1-eddyz87@gmail.com/
> > > > [2] https://lore.kernel.org/all/202211110355.BcGcbZxP-lkp@intel.com/
> > > > ---
> > > >  tools/lib/bpf/hashmap.h   | 3 ++-
> > > >  tools/perf/util/hashmap.h | 3 ++-
> > > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> > > > index 3fe647477bad..0a5bf1937a7c 100644
> > > > --- a/tools/lib/bpf/hashmap.h
> > > > +++ b/tools/lib/bpf/hashmap.h
> > > > @@ -123,7 +123,8 @@ enum hashmap_insert_strategy {
> > > >  };
> > > >
> > > >  #define hashmap_cast_ptr(p) ({								\
> > > > -	_Static_assert((p) == NULL || sizeof(*(p)) == sizeof(long),			\
> > > > +	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			 
> \
> > > > +				sizeof(*(p)) == sizeof(long),				\
> > > >  		       #p " pointee should be a long-sized integer or a  
> pointer");	\
> > > >  	(long *)(p);									\
> > > >  })
> > > > diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
> > > > index 3fe647477bad..0a5bf1937a7c 100644
> > > > --- a/tools/perf/util/hashmap.h
> > > > +++ b/tools/perf/util/hashmap.h
> > > > @@ -123,7 +123,8 @@ enum hashmap_insert_strategy {
> > > >  };
> > > >
> > > >  #define hashmap_cast_ptr(p) ({								\
> > > > -	_Static_assert((p) == NULL || sizeof(*(p)) == sizeof(long),			\
> > > > +	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			 
> \
> > > > +				sizeof(*(p)) == sizeof(long),				\
> > > >  		       #p " pointee should be a long-sized integer or a  
> pointer");	\
> > > >  	(long *)(p);									\
> > > >  })
> > > > --
> > > > 2.34.1
> > > >

