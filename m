Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3446C6462EB
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 22:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLGVFB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 16:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGVFA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 16:05:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFC25E3E6
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 13:04:57 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670447095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7s95N4stbJ58KKd5tqowhzFkeGL5TgOILKJAbS4MGIs=;
        b=WKBVYK2uZpE08u6ttrVF4+1uLE/uC5z+kAhstXmRwmm56K/cMBVW1ykB7SoRaYYZAHUY3f
        5mePSSUPl0FY3Vs5Xgmewchor/FdHlW3MKt+zFCaaNYXuT9H+DRQt188jigDOBplsLJN/z
        85pQgqQE/x4J2Rv0r2J4fAYSiCZMXT8eCJ/aIJQl2zvwnJIghAaZtZ0kq2/VN+SXiSRUt7
        sTIGWRxdpySJT7k7RBcOOeUc/aIOZTOmuHp8K0QHdznYzIMrPD5052v8O4yuzp5Nh0zzAv
        WMhtRVWmzxeZmYkM6lRudh8dETg5PSYWAjLyLZRTvSka14PB5JiwKR3+QBANzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670447095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7s95N4stbJ58KKd5tqowhzFkeGL5TgOILKJAbS4MGIs=;
        b=9DhB4XxjVRVWsaizIzn9gmJ/8s+7Gz4vIjfWE34VAAX7mSMhyr7hh6z1UomTYGtfHaoaHo
        5mjfjg+rJFbq6jCA==
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
In-Reply-To: <de7c70bc-94df-a372-ecfe-d2c707ad9014@csgroup.eu>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
 <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx>
 <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
 <878rjqqhxf.ffs@tglx>
 <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
 <87v8mndy3y.ffs@tglx> <de7c70bc-94df-a372-ecfe-d2c707ad9014@csgroup.eu>
Date:   Wed, 07 Dec 2022 22:04:55 +0100
Message-ID: <87h6y7dix4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christophe,

On Wed, Dec 07 2022 at 16:53, Christophe Leroy wrote:
> Le 07/12/2022 =C3=A0 16:36, Thomas Gleixner a =C3=A9crit=C2=A0:
>> The "use free space in existing mappings" mechanism is not required to
>> be PMD_SIZE based, right?

Correct. I just used it for the example.

>> Large page size, strict separation:
>>=20
>> struct mod_alloc_type_params {
>>     	[MOD_ALLOC_TYPE_TEXT] =3D {
>>          	.mapto_type	=3D MOD_ALLOC_TYPE_TEXT,
>>                  .flags		=3D FLAG_SHARED_PMD | FLAG_SECOND_ADDRESS_SPACE,
>>                  .granularity	=3D PMD_SIZE,
>>                  .alignment	=3D MOD_ARCH_ALIGNMENT,
>>                  .start[0]	=3D MODULES_VADDR,
>>                  .end[0]		=3D MODULES_END,
>>                  .start[1]	=3D MODULES_VADDR_2ND,
>>                  .end[1]		=3D MODULES_END_2ND,
>>                  .pgprot		=3D PAGE_KERNEL_EXEC,
>>                  .fill		=3D text_poke,
>>                  .invalidate	=3D text_poke_invalidate,
>> 	},
>
> Don't restrict implementation to PMD_SIZE only.
>
> On powerpc 8xx:
> - PMD_SIZE is 4 Mbytes
> - Large pages are 512 kbytes and 8 Mbytes.
>
> It even has large pages of size 16 kbytes when build for 4k normal page=20
> size.

@granularity takes any size which is valid from the architecture side
and can handle the @pgprot distinctions.

That's why I separated functionality and configuration.

Note, it's not strict compile time configuration. You can either build
it completely dynamic at boot or have a static configuration structure
as compile time default.

That static default might be __initconst for architectures where there
is no boot time detection and change required, but can be __initdata for
those which need to adjust it to the needs of the detected CPU/platform
before feeding it into the module allocator init function.

Does that answer your question?

Thanks,

        tglx


