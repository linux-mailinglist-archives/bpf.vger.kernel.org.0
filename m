Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BFB507E85
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 04:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347593AbiDTCGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 22:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiDTCGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 22:06:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557CF1ADBD;
        Tue, 19 Apr 2022 19:03:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t12so439293pll.7;
        Tue, 19 Apr 2022 19:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ibEgNl4ah592y04CKeGYQNxrDcqpD8/OSVG1ddkFp1M=;
        b=LaBe316aDoumG2Dpik722GfIyJarGZhlJL2hYxjNg90jQuXSKB2aY/5AtIGdFNsEl8
         g0MYl+bVmlGWdszBg9naIYf3ZXPmL+FU50nM/eK4NT8Uul9aXtuzJiOfG4FOXRb8zwZ7
         ckf1iEyIpdwhInWPExohuDvx+Htkjttzw7wt2DNATnytGPO+5ANQcV47HCVSrI8xNcg8
         PRegW4jPnuBZwZkerivwO83XXrlHd9GiWoA8IDBnXrX5M8KnqQQky9a19dpW+sauhtA/
         FFBkjy0dbFpsxMHogsGZCykw0UZUo/4eU/FW8twhn8STJJfbe6gfmy5MGl6peGEniQs5
         oXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ibEgNl4ah592y04CKeGYQNxrDcqpD8/OSVG1ddkFp1M=;
        b=VeTiCQXnYOJZLrq+pqW3Iw0VJ9/1fCYwraIKAxIh6DHg7UQflTpqNmZeEDH2ObpeoQ
         dNQmVk7j13BLsn2KXcvNc4mNfl3S1W5X/wr6TrjOjlb4/1lzEVjUVTcGllgiYDaRupL/
         KFb9CB+aZpWNHfk3usV+60BpXoL8+6H8doNOjeaYoaVBbfxXrqRYIFnKM7ezqN+WbNq6
         68pzSkH05Dz53DGIHrDNYg08FGX7Dog8mn2UgW3akHswNpttOZbEN6PWP210URloLhAk
         59+93ien9a+EqBgNdxHkCxD1fypGPOuil+OYGQGISwaDKbgvSPw+Ux3gab0Je368uKIp
         FDdA==
X-Gm-Message-State: AOAM530vXGFEFNTsgNrXY7aHpcou0jE/BJsxZJm+0wCu9SDs2Yrjpx2B
        zQIKsnXcT6sayePEra8f3vM=
X-Google-Smtp-Source: ABdhPJyzXhyfBVQOSAYv7JeeXa5TGCf2yZ58e5LFSZGZY91wL0Wt7M4faqxQtlZ0MlwWbI81/zqbjw==
X-Received: by 2002:a17:902:e1c5:b0:158:e060:4f6c with SMTP id t5-20020a170902e1c500b00158e0604f6cmr18229407pla.163.1650420196781;
        Tue, 19 Apr 2022 19:03:16 -0700 (PDT)
Received: from MacBook-Pro.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:ce98])
        by smtp.gmail.com with ESMTPSA id cw2-20020a056a00450200b0050ab7f48a9csm1415954pfb.170.2022.04.19.19.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:03:16 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:03:11 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Message-ID: <20220420020311.6ojfhcooumflnbbk@MacBook-Pro.local.dhcp.thefacebook.com>
References: <YlpPW9SdCbZnLVog@infradead.org>
 <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com>
 <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
 <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com>
 <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 19, 2022 at 12:20:39PM -0700, Linus Torvalds wrote:
> On Tue, Apr 19, 2022 at 11:42 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > I'd say that bpf_prog_pack was a cure for symptoms and this project tries
> > to address more general problem.
> > But you are right, it'll take some time and won't land in 5.19.
> 
> Just to update people: I've just applied Song's [1/4] patch, which
> means that the whole current hugepage vmalloc thing is effectively
> disabled (because nothing opts in).
> 
> And I suspect that will be the status for 5.18, unless somebody comes
> up with some very strong arguments for (re-)starting using huge pages.

Here is the quote from Song's cover letter for bpf_prog_pack series:

  Most BPF programs are small, but they consume a page each. For systems
  with busy traffic and many BPF programs, this could also add significant
  pressure to instruction TLB. High iTLB pressure usually causes slow down
  for the whole system, which includes visible performance degradation for
  production workloads.

The last sentence is the key. We've added this feature not because of bpf
programs themselves. So calling this feature an optimization is not quite
correct. The number of bpf programs on the production server doesn't matter.
The programs come and go all the time. That is the key here.  The 4k
module_alloc() plus set_memory_ro/x done by the JIT break down huge pages and
increase TLB pressure on the kernel code. That creates visible performance
degradation for normal user space workloads that are not doing anything bpf
related. mm folks can fill in the details here. My understanding it's
something to do with identity mapping.
So we're not trying to improve bpf performance. We're trying to make
sure that bpf program load/unload doesn't affect the speed of the kernel.
Generalizing bpf_prog_alloc to modules would be nice, but it's not clear
what benefits such optimization might have. It's orthogonal here.

So I argue that all 4 Song's fixes are necessary in 5.18.
We need an additional zeroing patch too, of course, to make sure huge page
doesn't have garbage at alloc time and it's cleaned after prog is unloaded.

Regarding JIT spraying and other concerns. Short answer: nothing changed.
JIT spraying was mitigated with start address randomization and invalid
instruction padding. Both features are still present.
Constant blinding is also fully functional.

Any kind of generalization of bpf_prog_pack into general mm feature would be
nice, but it cannot be done as opportunistic cache. We need a guarantee that
bpf prog/unload won't recreate the issue with kernel performance degradation. I
suspect we would need bpf_prog_pack in the current form for foreseeable future.
