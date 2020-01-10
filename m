Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799CD137618
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 19:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgAJSgP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jan 2020 13:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgAJSgO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 13:36:14 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7C1206DA
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578681373;
        bh=ZUQib7bnoTZU/304mmRL5Mwvrc5MIbAoLniN4Uk/qYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h+t8K1VgQO2sqGDI7eQ7fhLz4uqrI7kcD8o9E7GRSvSk41bGfpwcP9glUFoAvpEDO
         vKIazUnxJip7Y+EjMYX0HhhIVOP6z+pIhksR/gsQBuQuSZmDtqtPngJW4t/hkoWZMQ
         2xFlT4rI9w8G0PDoS9dgMdPkyWxgZOQAOXfipC44=
Received: by mail-wr1-f42.google.com with SMTP id z7so2721778wrl.13
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 10:36:12 -0800 (PST)
X-Gm-Message-State: APjAAAUPt4HpVe/BL3Ct3nCj0T6n0ZWkrYeTCf/4OjNxDs7WxuGxtg0g
        Vy7/zyZhXifLSN8GBRI0kL1Tj0/46/5DAnWfsEQrSQ==
X-Google-Smtp-Source: APXvYqzCH1wGkq2uxYvjqfJcJaKKKqpsUBHA/6LICwgzdTRsCsItPO4rziFdbUkhHPuHyevVbw3EbFyp7cT5odZ4Uhs=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr4718822wro.195.1578681371413;
 Fri, 10 Jan 2020 10:36:11 -0800 (PST)
MIME-Version: 1.0
References: <21bf6bb46544eab79e792980f82520f8fbdae9b5.camel@intel.com>
 <DB882EE8-20B2-4631-A808-E5C968B24CEB@amacapital.net> <cdd157ef011efda92c9434f76141fc3aef174d85.camel@intel.com>
 <CALCETrV_tGk=B3Hw0h9viW45wMqB_W+rwWzx6LnC3-vSATOUOA@mail.gmail.com>
 <400be86aab208d0e50a237cdbd3195763396e3ed.camel@intel.com>
 <CALCETrXXJhkNXmjTX_8VEO39+uE4XECtm=QNTDh1DpncXKhKhw@mail.gmail.com> <96dd98b3c4f73b205b6e669ca87fa64901c117d6.camel@intel.com>
In-Reply-To: <96dd98b3c4f73b205b6e669ca87fa64901c117d6.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 10 Jan 2020 10:35:59 -0800
X-Gmail-Original-Message-ID: <CALCETrWjx-D2sdJZbnydPgunNKmxuhYm=+6iPoy0DHEKCMkMsw@mail.gmail.com>
Message-ID: <CALCETrWjx-D2sdJZbnydPgunNKmxuhYm=+6iPoy0DHEKCMkMsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "luto@kernel.org" <luto@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "mjg59@google.com" <mjg59@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "thgarnie@chromium.org" <thgarnie@chromium.org>,
        "kpsingh@chromium.org" <kpsingh@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "revest@chromium.org" <revest@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "namit@vmware.com" <namit@vmware.com>,
        "jackmanb@chromium.org" <jackmanb@chromium.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "kafai@fb.com" <kafai@fb.com>, "yhs@fb.com" <yhs@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "mhalcrow@google.com" <mhalcrow@google.com>,
        "andriin@fb.com" <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Jan 9, 2020, at 3:01 PM, Edgecombe, Rick P <rick.p.edgecombe@intel.com=
> wrote:

>> The vmap code immediately removes PTEs when unmaps occur (which it may
>> very well do right now -- I haven't checked) but also tracks the
>> kernel_tlb_gen associated with each record of an
>> unmapped-but-not-zapped area.  Then we split vm_unmap_aliases() into a
>> variant that unmaps all aliases and a variant that merely promises to
>> unmap at least one alias.  The former does what the current code does
>> except that it skips the IPI if all areas in question have tlb_gen <
>> flushed_kernel_tlb_gen.  The latter clears all areas with tlb_gen <
>> flushed_kernel_tlb_gen and, if there weren't any, does
>> flush_tlb_kernel_range() and flushes everything.
>>
>> (Major caveat: this is wrong for the case where
>> flush_tlb_kernel_range() only flushes some but not all of the kernel.
>> So this needs considerable work if it's actually going to me useful.
>> The plain old "take locks and clean up" approach might be a better
>> bet.)
>>
>
> Hmm. In normal usage (!DEBUG_PAGE_ALLOC), are kernel range tlb shootdowns=
 common
> outside of module space users and lazy vmap stuff? A tlb_gen solution mig=
ht only
> be worth it in cases where something other than vm_unmap_aliases() and he=
lpers
> was doing this frequently.

I suspect that the two bug users aside from vunmap() will be eBPF and,
eventually, XPFO / =E2=80=9Cexclusive pages=E2=80=9D / less crappy SEV-like
implementations / actual high quality MKTME stuff / KVM
side-channel-proof memory.  The latter doesn=E2=80=99t actually exist yet (=
the
SEV implementation sidesteps this with a horrible hack involving
incoherent mappings that are left active with fingers crossed), but it
really seems like it=E2=80=99s coming.

In general, if we=E2=80=99re going to have a pool of non-RW-direct-mapped
pages, we also want some moderately efficient way to produce such
pages.

Right now, creating and freeing eBPF programs in a loop is probably a
performance disaster on large systems.
