Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99C62B58F9
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 05:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKQExK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 23:53:10 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47699 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgKQExK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 23:53:10 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0093F5C009A;
        Mon, 16 Nov 2020 23:53:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 16 Nov 2020 23:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=jxZSZint9SmHeOI37m5Z1GfQTXx
        Isq7qz61YwvNqS8g=; b=T02tRm5UceakDgUAbVLZSvXFywz58JybvPUMfpRSfxv
        ym8kxp/Co6fN604wtpfWX3LxUe3+JdRFRm8MUdN0Dw5LcFTqElKof94ZzfR7V81c
        Ptqfp3uXG14Fy5N3aO4J6Okk1XtjYX0Exi7VDklVY9Eh7IB9Ntx/5itxA4QiXRfq
        wO9fBwpWzlPYG5k4gws1ZtwXMYwr7bxL5F85UMS1Myc4n3i34S7B585NIfYeDO5u
        pY1Q46NfO/muMkHRq3SNQVOW8+z+56R7IV9xeVaPreoNgNdHpfS7nqxVXOJIvMjW
        Oz2erUCidrdVwieJk83hlOFySX9IbmfHkg/PA17PX4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jxZSZi
        nt9SmHeOI37m5Z1GfQTXxIsq7qz61YwvNqS8g=; b=bbd0Pysrn4VqoDYTWRCCZJ
        xiPYJzD5ljwQCep9uQvf/l1Jei/01/NXUgPV/cC2hMrXFXBTzF9+dX3tEt75ukF1
        ME0TUMoYsaVX9tBwq3rdc4T4sdhwFQYxBcIeIETKUTLXdrNQ5tMw6nko3UkTjlGs
        cRcxyDnnCIoOfmaEXl9ZldR/2xIQKfN5D2gU/tTgAQYOwcQ808AaOiGfe3DICR1W
        h0rNKUiJmOM9C0/+8K8ZoGBbGRfjK+6yv536bPj6YtU5KWHCyyba/36hK5Hc46Yv
        qowTc+Bq4LbTqAHf6XWD6TEJpAjHqNVvo80ft8/fopMmeXRcTn5M86n8d2bKb0cQ
        ==
X-ME-Sender: <xms:NFezX_9Ma2zx6BodU0eJWuYSxO7KjXp2HqLZAdYWmkA6rq-GQAUI9Q>
    <xme:NFezX7v-5vWmLD6eFHEWI7xudwYUDlvmAxOg1dIAm29mP0oSau4rndtkaElUa8oT2
    P9UiX1BSWtnt1eM4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefvddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpefgieejhfeffefgjefhgeeutdfhjefhgffgtdfhjeeuueejfeef
    veehgfeiieetieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeeiledrud
    ekuddruddthedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:NFezX9DP-jEXGXlEy8mAwh3u1bMduWbcJ9Kw6AAqFl7SS8U-PpsHRw>
    <xmx:NFezX7fHItfn1nqTlKbjYn9PdLFe_ksw5sEb2DcKepLERyKoYZ47zQ>
    <xmx:NFezX0M3NeRmapADZ7P5OSW57XnJzjTp1wd-a4gDW0RccauN3IQsRA>
    <xmx:NFezXz1bjCGorXyiw25PtfC29ZOAsfwHAkrPf7tZJhoJ2EWWdiw4fw>
Received: from maharaja.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3B5C03064AAF;
        Mon, 16 Nov 2020 23:53:07 -0500 (EST)
Date:   Mon, 16 Nov 2020 20:53:05 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com
Subject: Re: [PATCH bpf v6 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Message-ID: <20201117045305.ejenig33no3xzzi4@maharaja.localdomain>
References: <cover.1605560917.git.dxu@dxuuu.xyz>
 <470ffc3c76414443fc359b884080a5394dcccec3.1605560917.git.dxu@dxuuu.xyz>
 <CAHk-=wggUw3XYffJ-od8Dbfh-JkXkEuCPjSRR2Z+8HrNUNxJ=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggUw3XYffJ-od8Dbfh-JkXkEuCPjSRR2Z+8HrNUNxJ=g@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Linus,

On Mon, Nov 16, 2020 at 02:15:52PM -0800, Linus Torvalds wrote:
> On Mon, Nov 16, 2020 at 1:17 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Based on on-list discussion and some off-list discussion with Alexei,
> > I'd like to propose the v4-style patch without the `(*out & ~mask)`
> > bit.
> 
> So I've verified that at least on x86-64, this doesn't really make
> code generation any worse, and I'm ok with the patch from that
> standpoint.
> 
> However, this was not what the discussion actually amended at as far
> as I'm concerned.
> 
> I mentioned that if BPF cares about the bytes past the end of the
> string, I want a *BIG COMMENT* about it. Yes, in strncpy_from_user()
> itself, but even more in the place that cares.

Sure, sorry. Will send another version with comments.

> And no, that does not mean bpf_probe_read_user_str().  That function
> clearly doesn't care at all, and doesn't access anything past the end
> of the string. I want a comment in whatever code that accesses past
> the end of the string.

If I'm reading things right, that place is technically in
kernel/bpf/hashtab.c:alloc_htab_elem. In line:

    memcpy(l_new->key, key, key_size);

where `key_size` is the width of the hashtab key. The flow looks like:

    <bpf prog code>
      bpf_map_update_elem()
        htab_map_update_elem()
          alloc_htab_elem()

It feels a bit weird to me to add a comment about strings in there
because the hash table code is string-agnostic, as mentioned in the
commit message.

> And your ABI point is actively misleading:
> 
> > We can't really zero out the rest of the buffer due to ABI issues.
> > The bpf docs state for bpf_probe_read_user_str():
> >
> > > In case the string length is smaller than *size*, the target is not
> > > padded with further NUL bytes.
> 
> This comment is actively wrong and misleading.
> 
> The code (after the patch) clearly *does* pad a bit with "further NUL
> bytes". It's just that it doesn't pad all the way to the end.

Right, it's a bit ugly and perhaps misleading. But it fixes the real
problem of keying a map with potentially random memory that
strncpy_from_user() might append on. If we pad a deterministic number of
zeros it should be ok.

> Where is the actual buffer zeroing done?

Usually the bpf prog does it. I believe (could be wrong) the verifier
enforces the key is initialized in some form.

For my specific use case, it's done in the bpftrace code:
https://github.com/iovisor/bpftrace/blob/0c88a1a4711a3d13e8c9475f7d08f83a5018fdfd/src/ast/codegen_llvm.cpp#L529-L530

> Because without the buffer zeroing, this whole patch is completely
> pointless. Which is why I want that comment, and I want a pointer to
> where that zeroing is done.
> 
> Really. You have two cases:
> 
>  (a) the buffer isn't zeroed before the strncpy_from_user()
> 
>  (b) the buffer is guaranteed to be zero before that
> 
> and in case (a), this patch is pointless, since the data after the
> string is already undefined.

See above -- I think the verifier enforces that the data is initialized.

> And in case (b), I want to see a comment and a pointer to the code
> that actually does the zeroing.

See above also.

> HOWEVER. Look at bpf_probe_read_user_str_common(), and notice how it
> ALREADY does the zeroing of the buffer past the end, it's just that it
> only does it in the error case.

I don't think the error case is very relevant here. I normally wouldn't
make any assumptions about the state of a buffer after a failed function
call.

> Why do you send this patch, instead of
> 
>  (a) get rid of the pointless pre-zeroing
> 
>  (b) change bpf_probe_read_user_str_common() to do
> 
>         int ret;
>         u32 offset;
> 
>         ret = strncpy_from_user_nofault(dst, unsafe_ptr, size);
>         offset = ret < 0 ? 0 : ret;
>         memset(dst+offset, 0, size-offset);
>         return ret;
> 
> which seems to be much simpler anyway. The comment you quote about
> "target is not padded with further NUL bytes" is clearly wrong anyway,
> since that error case *does* pad the target with NUL bytes, and always
> has.

I think on the bpf side there's the same concern about performance.
You can't really dynamically size buffers in bpf land so users usually
use a larger buffer than necessary, sometimes on the order of KBs. So if
we unnecessarily zero out the rest of the buffer it could cause perf
regressions.

[...]

Thanks,
Daniel
