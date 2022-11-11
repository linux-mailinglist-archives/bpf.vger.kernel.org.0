Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18516624FA0
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 02:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKKBes (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 20:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKKBer (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 20:34:47 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FC145090
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 17:34:46 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id e12-20020a62aa0c000000b0056c12c0aadeso1921090pff.21
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 17:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBhaBp/PRamS87QJfTHEWwkn/0XN+3AwIjvzHXr1qVQ=;
        b=VrYXtYVQo2gYHj+UntQMk47uX1dXCa9THmoaGhjl3DiDk13G+e7pPs+ca9KwHuYDE7
         BHSGKng5zMclWAaMC12CfLhDYoPeLmJ/ugTOojwJbvXSpRZU064WwHSbRPpGWlTnsNpw
         aCcXtd8ZIiSQJTzHuR0Kg40Xoy3ky+lOx7S3v76//VoqXxmYVKIzmfnvlP9HQeLfyryb
         GYX4H4y1F1dzm03YgqE2LiR7VE5LtncVSKwwrIMP7Nq+LF4DurcOSC6sE4m5YjQ5mOzp
         mdfFY1jYzBAG1G+4ilFGmEP98J/vnspe+Qt/hHJ3XpGRdjvMObF443jg09KVyLCs3ZYp
         qRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBhaBp/PRamS87QJfTHEWwkn/0XN+3AwIjvzHXr1qVQ=;
        b=54dZ0sVzlncGGM05350bkrS/Y+paRI+NOZmT2FJqECXGqnmHy136YRNPJU103Qmm3m
         77NFDJHBZDsR4gW8xetiENJqLHC2l1QTeMKRp4vKzTXnihVd11GrsJxSiywbDD+cCX8B
         ssm0Ee8pNyNamFaS4ihuHXE8fuEyRf04pgKbadBc8E4xZENnhWoKH2xIx4ERVt5RyBsj
         sT/f6bpdh4HJccykRym5csaWs9MrjkOt2J6xW69hF98fzdN3Z4GXFCu8gYtwupATUfRq
         Hyst2Rs4/6GfxrIkguCS4stmEFB2LswMFL/iK5uOCustVOAwTRzwdFEPwbJNshjQXj+l
         8odw==
X-Gm-Message-State: ANoB5pnBvQZEqcSsll0vCogVclwYqSEbKzJeIYYHcLCsr6KT3/UR5kuK
        xhzsrheOrnVs++MTf/vqnOOr4h4=
X-Google-Smtp-Source: AA0mqf7e3qRqFvxdC0ND0bWgiqQ+pCIw/yQ16RGOVlLATJlRtetuz4Jkjcfc906XUdaPO9VfXf85IiQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e890:b0:186:a22a:177e with SMTP id
 w16-20020a170902e89000b00186a22a177emr195941plg.163.1668130485711; Thu, 10
 Nov 2022 17:34:45 -0800 (PST)
Date:   Thu, 10 Nov 2022 17:34:44 -0800
In-Reply-To: <Y22khvpDYu639yom@google.com>
Mime-Version: 1.0
References: <20221110223240.1350810-1-eddyz87@gmail.com> <Y22khvpDYu639yom@google.com>
Message-ID: <Y22mtIyofEus4KZ0@google.com>
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

On 11/10, Stanislav Fomichev wrote:
> On 11/11, Eduard Zingerman wrote:
> > A fix for the LLVM compilation error while building bpftool.
> > Replaces the expression:
> >
> >   _Static_assert((p) == NULL || ...)
> >
> > by expression:
> >
> >   _Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) || ...)

> IIUC, when __builtin_constant_p(p) returns false, we just ignore the NULL  
> check?
> Do we have cases like that? If no, maybe it's safer to fail?

> s/(p) == NULL : 0/(p) == NULL : 1/ ?

I'm probably missing something, can you pls clarify? So the error is as
follows:

>> btf_dump.c:1546:2: error: static_assert expression is not an integral  
>> constant expression
    hashmap__find(name_map, orig_name, &dup_cnt);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./hashmap.h:169:35: note: expanded from macro 'hashmap__find'
    hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
    ^~~~~~~~~~~~~~~~~~~~~~~
    ./hashmap.h:126:17: note: expanded from macro 'hashmap_cast_ptr'
    _Static_assert((p) == NULL || sizeof(*(p)) ==  
sizeof(long),                                             
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    btf_dump.c:1546:2: note: cast from 'void *' is not allowed in a constant  
expression
    ./hashmap.h:169:35: note: expanded from macro 'hashmap__find'
    hashmap_find((map), (long)(key), hashmap_cast_ptr(value))

This line in particular:

    btf_dump.c:1546:2: note: cast from 'void *' is not allowed in a constant  
expression

And the code does:

   size_t dup_cnt = 0;
   hashmap__find(name_map, orig_name, &dup_cnt);

So where is that cast from 'void *' is happening? Is it the NULL check  
itself?

Are we simply guarding against the user calling hashmap_cast_ptr with
explicit NULL argument?

> > When "p" is not a constant the former is not considered to be a
> > constant expression by LLVM 14.
> >
> > The error was introduced in the following patch-set: [1].
> > The error was reported here: [2].
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > [1]  
> https://lore.kernel.org/bpf/20221109142611.879983-1-eddyz87@gmail.com/
> > [2] https://lore.kernel.org/all/202211110355.BcGcbZxP-lkp@intel.com/
> > ---
> >  tools/lib/bpf/hashmap.h   | 3 ++-
> >  tools/perf/util/hashmap.h | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> > index 3fe647477bad..0a5bf1937a7c 100644
> > --- a/tools/lib/bpf/hashmap.h
> > +++ b/tools/lib/bpf/hashmap.h
> > @@ -123,7 +123,8 @@ enum hashmap_insert_strategy {
> >  };
> >
> >  #define hashmap_cast_ptr(p) ({								\
> > -	_Static_assert((p) == NULL || sizeof(*(p)) == sizeof(long),			\
> > +	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
> > +				sizeof(*(p)) == sizeof(long),				\
> >  		       #p " pointee should be a long-sized integer or a pointer");	\
> >  	(long *)(p);									\
> >  })
> > diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
> > index 3fe647477bad..0a5bf1937a7c 100644
> > --- a/tools/perf/util/hashmap.h
> > +++ b/tools/perf/util/hashmap.h
> > @@ -123,7 +123,8 @@ enum hashmap_insert_strategy {
> >  };
> >
> >  #define hashmap_cast_ptr(p) ({								\
> > -	_Static_assert((p) == NULL || sizeof(*(p)) == sizeof(long),			\
> > +	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
> > +				sizeof(*(p)) == sizeof(long),				\
> >  		       #p " pointee should be a long-sized integer or a pointer");	\
> >  	(long *)(p);									\
> >  })
> > --
> > 2.34.1
> >
