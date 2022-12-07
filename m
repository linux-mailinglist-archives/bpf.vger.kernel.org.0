Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAA86464E8
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 00:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiLGXRS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 18:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGXRR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 18:17:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716CB88B5D
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 15:17:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C65961B9A
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 23:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B901C43470
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 23:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670455035;
        bh=I17H0Rv10c7SFfmHzW4ugauS88tg02V0YJpQ9blZJJ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=td0iS5R96KeR0silw1ZgdHl2e99z6jPfXfmUrLZvEniXi2zCtX5MNUof/PZ2/kwpg
         HoWSO3Xvu9iNtVtJJnIeyZ5FcIwNoIuO6KExHFD6MnAse3AVRHyJu+GPeyTmW+KJPc
         huLSwPkAZMQyT9Wp5y8rkF5P+lxLNHktcwvjs97UVpWAzS5cQyEeCmMj1hWcxYq5Mx
         HR0g+kN1/MOiDjm/YJyBpmp6DXviEbHKjT4yFOsXxE+qyBoCLlOtBhC/5eLYpo21mp
         t5k06MgjmMTaBFeYvdYuA3FyCB5Tn7zqXdpjzStmsrRfJbMKc8PkiZZZ/r+bT9URbV
         nd/TOwQNRtdZQ==
Received: by mail-ed1-f54.google.com with SMTP id r26so26999004edc.10
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 15:17:15 -0800 (PST)
X-Gm-Message-State: ANoB5plyKQMsbaUBw0L3zpSCtex4BIkyW5R8lN/Wi2/B2T2Bfhy+NCOm
        z2J1oQuOYAufmlBjSKBmG6k7YmwWDgAZc7S9nt4=
X-Google-Smtp-Source: AA0mqf6AvV+Rp9RW4dJ37ynzRUZILOa2gPhawNu2nR8hKHL+QAo0JE3mWzZEbRVBbhj7BhHKEn/yQ76U+t4ovB/Qty8=
X-Received: by 2002:a50:ff08:0:b0:461:dbcc:5176 with SMTP id
 a8-20020a50ff08000000b00461dbcc5176mr71361150edu.53.1670455033618; Wed, 07
 Dec 2022 15:17:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx> <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx> <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
 <878rjqqhxf.ffs@tglx> <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
 <87v8mndy3y.ffs@tglx> <CAPhsuW7tv3MwKJZeEib_4mFUx-DJL3aZO05CjFkvH0U+EFQyrg@mail.gmail.com>
 <87k033dja7.ffs@tglx>
In-Reply-To: <87k033dja7.ffs@tglx>
From:   Song Liu <song@kernel.org>
Date:   Wed, 7 Dec 2022 15:17:00 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5JDWYrDpo0nF0FwA2CH5+0XGJDse6KSR5sON-7PYVv1w@mail.gmail.com>
Message-ID: <CAPhsuW5JDWYrDpo0nF0FwA2CH5+0XGJDse6KSR5sON-7PYVv1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        mcgrof@kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 7, 2022 at 12:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Song!
>
> On Wed, Dec 07 2022 at 11:26, Song Liu wrote:
> > On Wed, Dec 7, 2022 at 7:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > I think we can handle all these with a single module_alloc() and a few
> >> > module_arch_* functions().
> >> struct mod_alloc_type {
> >>         unsigned int    mapto_type;
> >>         unsigned int    flags;
> >>         unsigned int    granularity;
> >>         unsigned int    alignment;
> >>         unsigned long   start[MOD_MAX_ADDR_SPACES];
> >>         unsigned long   end[MOD_MAX_ADDR_SPACES];
> >>         pgprot_t        pgprot;
> >>         void            (*fill)(void *dst, void *src, unsigned int size);
> >>         void            (*invalidate)(void *dst, unsigned int size);
> >> };
> >
> > Yeah, this is a lot better than arch_ functions.
>
> Remember the order of things to worry about: #3 :)
>
> > We probably want two more function pointers here:
> >
> > int (*protect)(unsigned long addr, int numpages);
> > int (*unprotect)(unsigned long addr, int numpages);
> >
> > These two functions will be NULL for archs that support text_poke;
> > while legacy archs use them for set_memory_[ro|x|rw|nx]. Then, I
> > think we can get rid of VM_FLUSH_RESET_PERMS.
>
> Depends. You can implement
>
> fill()
>         memcpy(...);
>         set_memory_ro();
>
> and
>
> invalidate()
>         set_memory_rw();
>         memset();
>
> as global helpers which can be used by the architecture for the init
> struct or used as default for certain types.

Ah, that's right. Legacy archs should always use PAGE_SIZE granularity,
so fill() and invalidate() are sufficient.

>
> > I think I am ready to dive into the code and prepare the first RFC/PATCH.
> > Please let me know if there is anything we should discuss/clarify before that.
>
> I think we covered most of it by now, so sure a POC is probably due, but
> please yell when you find a gap in step #1 - #3 which we did not cover
> yet.

Thanks! Let me see what I can get.

Song
