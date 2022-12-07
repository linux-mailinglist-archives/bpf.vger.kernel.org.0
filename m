Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E2E6462E6
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiLGU5N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiLGU5K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:57:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF19117D
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:57:07 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670446624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j4jZkbcuJIwiAgf91WY2daretNxTTG2dG6tHKPWxG5s=;
        b=1mDnIOdVFdENa9SioPfbGoLSFBWnnRIl0+5DUev/kW7WYKbi+3gEXdtGKSmTtaDemhwEER
        achgTAb/z3y6dkIMuDTM57GI/c/rpZfCkxQUztCRa/fJ1tMJ3ydO8DOHQPLbUEDHpIoxPo
        z6Y2Oie9BCMT0B5Yk6Wa0aPPVHAwXYvJJ47fF0+0ql6u1uRug6uLzFYneICNkOjwD72aGE
        PpZEzd0nDGds1GQ+8S2IEyeoKdqq8sdxlHR43ukkGLato/G52ppFCilujz7L4POv/kLv6j
        tQzM+DQ6xssbeq8Ai7W65gC/LIFYxM2fbq9DAwgafeQpgHg0W2u2+pcAr134Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670446624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j4jZkbcuJIwiAgf91WY2daretNxTTG2dG6tHKPWxG5s=;
        b=8YAU1+YxLGwjaU83ja4X7yCURRPxwpv6QaOXOrtX7dhXDjGuNPIFGelH7wWze2TszQBJ6p
        /BlIz8UDMyBNdaBQ==
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        mcgrof@kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
In-Reply-To: <CAPhsuW7tv3MwKJZeEib_4mFUx-DJL3aZO05CjFkvH0U+EFQyrg@mail.gmail.com>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
 <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx>
 <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
 <878rjqqhxf.ffs@tglx>
 <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
 <87v8mndy3y.ffs@tglx>
 <CAPhsuW7tv3MwKJZeEib_4mFUx-DJL3aZO05CjFkvH0U+EFQyrg@mail.gmail.com>
Date:   Wed, 07 Dec 2022 21:57:04 +0100
Message-ID: <87k033dja7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song!

On Wed, Dec 07 2022 at 11:26, Song Liu wrote:
> On Wed, Dec 7, 2022 at 7:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > I think we can handle all these with a single module_alloc() and a few
>> > module_arch_* functions().
>> struct mod_alloc_type {
>>         unsigned int    mapto_type;
>>         unsigned int    flags;
>>         unsigned int    granularity;
>>         unsigned int    alignment;
>>         unsigned long   start[MOD_MAX_ADDR_SPACES];
>>         unsigned long   end[MOD_MAX_ADDR_SPACES];
>>         pgprot_t        pgprot;
>>         void            (*fill)(void *dst, void *src, unsigned int size);
>>         void            (*invalidate)(void *dst, unsigned int size);
>> };
>
> Yeah, this is a lot better than arch_ functions.

Remember the order of things to worry about: #3 :)

> We probably want two more function pointers here:
>
> int (*protect)(unsigned long addr, int numpages);
> int (*unprotect)(unsigned long addr, int numpages);
>
> These two functions will be NULL for archs that support text_poke;
> while legacy archs use them for set_memory_[ro|x|rw|nx]. Then, I
> think we can get rid of VM_FLUSH_RESET_PERMS.

Depends. You can implement

fill()
	memcpy(...);
        set_memory_ro();

and

invalidate()
	set_memory_rw();
        memset();

as global helpers which can be used by the architecture for the init
struct or used as default for certain types.

> I think I am ready to dive into the code and prepare the first RFC/PATCH.
> Please let me know if there is anything we should discuss/clarify before that.

I think we covered most of it by now, so sure a POC is probably due, but
please yell when you find a gap in step #1 - #3 which we did not cover
yet.

Thanks,

        tglx
