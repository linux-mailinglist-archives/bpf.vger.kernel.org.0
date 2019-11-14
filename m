Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711A7FCDE7
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2019 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKNShm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Nov 2019 13:37:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34401 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNShm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Nov 2019 13:37:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id y186so5908867lfa.1
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 10:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fHLj/8XgehfTJQohLjwUw/DxLPSQEHrNoDpxosPLFU=;
        b=Bt8D76Nga3+t/MgepVAUCsWfHQH9/MvbX/srcyZGL1pSLQgh33GZcBO+seCVsuxDu1
         p4m7+5HsasK7vkcoN26tkn0h0nL21eb82Leq7WEbBKv5tsNTjJWIy5xgYljR+VbYCJlP
         txJzFfIad1/IgkpTFRZ+hUZeYy/JvPfR+b7Vngno3YXH3He3mwuoxV5sN0Vznu3rmy2t
         duuS+h5pk9wFJmvRIoGvmHbc5OKNrPi/1Sq0SNU3287Ue4H6yAp9zZze3iBql9hZmLpo
         JpznyAtPxWFjUoHKqpcCcADk9Wg/TeXdbiTRh8wGixTgug60sXd6ExZlh3nU6FhhS4dJ
         9OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fHLj/8XgehfTJQohLjwUw/DxLPSQEHrNoDpxosPLFU=;
        b=r9J2ELzPbKay2y1e01QScK5Jy4NodsXLJQLB9pLTCH6AMwWo6y4GhqhyM8RxuRhJr/
         ys/G+f41E1qFrO3X9hqZwgH/CKJi2V+qCPS7PNT8Z2brAys+5co8Xtqjqv1UIVfsTkDO
         sM33H90KOr9vAijRiojb+Pxa6DDvCQhZEss+wQdihIBUULOEZD72I+0IdpCTf/3+lfuy
         fzNsDT9f+BzaBME9+I9fVv3i88G9Gtd6+e9FFpLZ5XqpE5ltoNfHDBYarO8OJo+it7jc
         trxn1NEPhzJWVxFSL9rjdF+UmAF5A7A1oNRCDt+2LYsTu9uoyKvEQLRCktbVJovtfyub
         WPcw==
X-Gm-Message-State: APjAAAUbxWMZp6oN/XvHBOcDrT2mjb3/TxVX0/hzS3PAwjjv9UTs6pCu
        RfUkWoS4V573pW56xx7oVmuFrE+CrvCQl6JkWisxvg==
X-Google-Smtp-Source: APXvYqw5i6Bx+o4jY6o7z4YClIbShWcBRStRr++4ioO+mXQ7nvKupAjt5PKeYOOmAqNObt6Xp5YJxTfXLO7KLFrnfDU=
X-Received: by 2002:a19:4bd6:: with SMTP id y205mr7934972lfa.167.1573756659970;
 Thu, 14 Nov 2019 10:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20191113170005.48813-1-iii@linux.ibm.com> <CAPhsuW6ktX4zDt4fE=C0G4gCZoY_GRdkJFk0sdpsxYVtohnBxA@mail.gmail.com>
 <CAADnVQL0sk7XXGYAMWKoZOYSN7qi6vN5ZW3VJbd7e9Q_wJaBAA@mail.gmail.com> <DFD3A00C-34D2-40B1-86FC-3E37B2718C6D@linux.ibm.com>
In-Reply-To: <DFD3A00C-34D2-40B1-86FC-3E37B2718C6D@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Nov 2019 10:37:28 -0800
Message-ID: <CAADnVQ+XonyPcv6DUbSObG-k3o5iwHyOXyFTJR5pvBHv5JSTDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make bpf_jit_binary_alloc support alignment
 > 4
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Song Liu <liu.song.a23@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 14, 2019 at 10:35 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
>
>
> > Am 14.11.2019 um 19:14 schrieb Alexei Starovoitov <alexei.starovoitov@gmail.com>:
> >
> > On Thu, Nov 14, 2019 at 9:40 AM Song Liu <liu.song.a23@gmail.com> wrote:
> >>
> >> On Wed, Nov 13, 2019 at 9:20 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >>>
> >>> Currently passing alignment greater than 4 to bpf_jit_binary_alloc does
> >>> not work: in such cases it aligns only to 4 bytes.
> >>>
> >>> However, this is required on s390, where in order to load a constant
> >>> from memory in a large (>512k) BPF program, one must use lgrl
> >>> instruction, whose memory operand must be aligned on an 8-byte boundary.
> >>>
> >>> This patch makes it possible to request an arbitrary power-of-2
> >>> alignment from bpf_jit_binary_alloc by allocating extra padding bytes
> >>> and aligning the resulting pointer rather than the start offset.
> >>>
> >>> An alternative would be to simply increase the alignment of
> >>> bpf_binary_header.image to 8, but this would increase the risk of
> >>> wasting a page on arches that don't need it, and would also be
> >>> insufficient in case someone needs e.g. 16-byte alignment in the
> >>> future.
> >
> > why not 8 or 16? I don't follow why that would waste a page.
>
> It might waste a page because bpf_jit_binary_alloc rounds up allocation
> size to PAGE_SIZE, and unnecessary padding might be the last straw that
> would cause another page to be allocated. But that would apply only to
> a tiny amount of programs, whose JITed size is slightly smaller than a
> multiple of PAGE_SIZE.
>
> Sorry, I didn't fully get the 8 vs 16 question. At the moment, for
> s390-specific purpose 8 would be enough. I used 16 just to demonstrate
> that this solution wouldn't be future-proof. AFAIK some Intel
> instructions might want 16 (VMOVDQA?). But maybe it's better to think
> about it when someone actually needs to use them.
>
> >>>
> >>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >>
> >> Maybe we can just make it 8 byte aligned for all architectures?
> >>
> >> #define BPF_IMAGE_ALIGNMENT 8
>
> Seems like I'm overthinking this. If just bumping the alignment to 8 is
> OK, then I'll send a simpler patch.

yes. I think that's better.
