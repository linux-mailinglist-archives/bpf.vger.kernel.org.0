Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A417D3B969E
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 21:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhGATgM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 15:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGATgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Jul 2021 15:36:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FF8C061762
        for <bpf@vger.kernel.org>; Thu,  1 Jul 2021 12:33:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w11so10110972ljh.0
        for <bpf@vger.kernel.org>; Thu, 01 Jul 2021 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nkp8B00ycwJr9MIlQRc0VrwsdNbLkEalV2JxoBIwEz0=;
        b=hAGVhOtSg/gpltdMEXUH7u/TdN06+/KUI70LLleG9VZr2zCaYT0yVJGuqYN5emcmGQ
         S1RwGFtgtp8c5wps7I0GRfALoO06wdQir3NwXfRWPrI/ZDqVKjWSChai1Tv73xWK9bTY
         hgX19FBEtaWLGnsJ6NwFrQl+ffZzwXfxWo3vqVhZ42Ru7gbJS7wbDW/2XJEven5atHAF
         FCc+WWikubXyjhu8f43kmUkaLWpZexMlh8LRsuDJJdVZcIyYjEQ3G7hdGVtSz1vhE83M
         iA8CDTSgu4LrCUuHbdf5KdZKIYe8RSDGpO6zzd54vDvEb09pweGcnaDVeeYyHEDB4aN7
         xtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nkp8B00ycwJr9MIlQRc0VrwsdNbLkEalV2JxoBIwEz0=;
        b=oWKXuAWJXtBdJ7lctAnUHQHncLgO7X3R500jZWm9C+C3/iVUw590BNnsVMlf+oLM8R
         lxToyex5qSqnBGABhAdxH4D6jl5bb9Znq5D4SO/1GxIH1aJZN6IXWRqT0YZxWTgy1Jic
         yhbMtXKtZFh/8GgBB5ivxAM/ljfb/UhdKwIan62A7BV4oK+1fgTV6pApgFStE7rdc8q1
         aohDfo/okRr3T0Y3Yb4Yre8HnPpGJ9JEKeuIGWLwVVvaI5SOei4I8/Gz4Q2KSSECvsHS
         g2XeXBxXsvRccUQoRuocbgylIQomgwlqxY1wXlenkG3pL0XS9l6obSCr/FrOub/k6CzW
         D5tg==
X-Gm-Message-State: AOAM5318Kx6dd2pcGwHk0JlyCfMvM535Qfxv2f9yAEkIomshIPCzi3Ox
        4namZUn1hsSMk79+fao37Qof91VQdQoV1TS7i9Y=
X-Google-Smtp-Source: ABdhPJxWzd7M5N4IZjMNC6Y5HpL1QcTszjnUAVEUsh/eBDfR7LosgbQNZWM8+0OTKsInvg60ycJNB4Kqr3rF/IceMJo=
X-Received: by 2002:a2e:9146:: with SMTP id q6mr916447ljg.236.1625168019289;
 Thu, 01 Jul 2021 12:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
 <4117b430ffaa8cd7af042496f87fd7539e4f17fd.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
 <CAADnVQ+78iDs7N=8xA6BZVBnPx78Q-Ljp860nmb8cOq7V_6qtQ@mail.gmail.com> <1625167613.6vloxo7l3w.naveen@linux.ibm.com>
In-Reply-To: <1625167613.6vloxo7l3w.naveen@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 1 Jul 2021 12:33:27 -0700
Message-ID: <CAADnVQJQAb5LHSKw4nLPcHLz85qwBu2V7vy-4gTScHqc5tYykA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/bpf: Fix detecting BPF atomic instructions
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Jackman <jackmanb@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 1, 2021 at 12:32 PM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> Alexei Starovoitov wrote:
> > On Thu, Jul 1, 2021 at 8:09 AM Naveen N. Rao
> > <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >>
> >> Commit 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other
> >> atomics in .imm") converted BPF_XADD to BPF_ATOMIC and added a way to
> >> distinguish instructions based on the immediate field. Existing JIT
> >> implementations were updated to check for the immediate field and to
> >> reject programs utilizing anything more than BPF_ADD (such as BPF_FETCH)
> >> in the immediate field.
> >>
> >> However, the check added to powerpc64 JIT did not look at the correct
> >> BPF instruction. Due to this, such programs would be accepted and
> >> incorrectly JIT'ed resulting in soft lockups, as seen with the atomic
> >> bounds test. Fix this by looking at the correct immediate value.
> >>
> >> Fixes: 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other atomics in .imm")
> >> Reported-by: Jiri Olsa <jolsa@redhat.com>
> >> Tested-by: Jiri Olsa <jolsa@redhat.com>
> >> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >> ---
> >> Hi Jiri,
> >> FYI: I made a small change in this patch -- using 'imm' directly, rather
> >> than insn[i].imm. I've still added your Tested-by since this shouldn't
> >> impact the fix in any way.
> >>
> >> - Naveen
> >
> > Excellent debugging! You guys are awesome.
>
> Thanks. Jiri and Brendan did the bulk of the work :)
>
> > How do you want this fix routed? via bpf tree?
>
> Michael has a few BPF patches queued up in powerpc tree for v5.14, so it
> might be easier to take these patches through the powerpc tree unless he
> feels otherwise. Michael?

Works for me. Thanks!
