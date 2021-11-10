Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9744CD20
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 23:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhKJWxv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 17:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhKJWxt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 17:53:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73864C061766
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 14:51:01 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b15so16437746edd.7
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 14:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQSkGqQMKDMaaOKqC0GgKOiJJpI/Unr6KCrdKvaDG+Y=;
        b=n+bAu2ylQYtuhkL0/zYouHRqrPD40IHzRB0619kXdJxkzpwbRvDWxwy/+z/N3lrbr0
         F2omQuMg0q5XrXnBoeZr8syq9S+mjz7okjtyNAMvEoYl+8cbSDK/U4qIeQ360JIX8+s9
         k5OTc4Pd1Mc+F8KqVDmPOhFU+IgIFEKXwFyFZw/YiYf8iDlHhfdAyMS0Yc82/BCHflwP
         iWqZZPpBCAOBH7YQkmIP7C5XLxHv7vnDHcaNVA7sePKo4BXn36t7mI4qm7mfjFlnzfl4
         RZQJZYkIWpQZMyCdo2lXJhsHdAAOsyxXBIcYrYopKOIpcDuikwOS05IyxlwdsqhM45xH
         GBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQSkGqQMKDMaaOKqC0GgKOiJJpI/Unr6KCrdKvaDG+Y=;
        b=GsIJPLamx9icodLF1TbSYo8QmFq9VwWlVHsw383H5hhQ5tDpAZcpd/j/datl8jjQ3i
         OMvyNbq00ynxNUaPhs97XqOG7ZXlGTd0Vx7WJ8A/Otvguhvyt5giegG7WowhOBg9BSVT
         RONCeTpXuEnvRzyy7YWtZ8jFs7KmWRIzoi3SkEnCF7sf+zdFmeBxMjH8ZTAYjO0OzdAs
         T0XLqPeA16qVRJ8UiPZoAYfT49JDrfxy/1gsNHL3rh1COpa2xfKuplVUV74oHkz2CGQg
         zdh7HWjU8j02JRDXu/kzNnqII2AMYDCR4R/5hGUAVkMN+jVUaP0v1BHEnuNxG6DZA2OR
         61ZA==
X-Gm-Message-State: AOAM531f9+sxO5iuM5lq61mrW2GPg0a2oPVaR/W9lQjI7BMqIllmbV3H
        3ijEmLsEOqaSniq0hA7BNIWrRG4JZ64Azz0eU90uzA==
X-Google-Smtp-Source: ABdhPJyAFXatvuiGvtv0EulTBPTIvRdlM6bhT4kaXWu2T1oV2E2DfYlvhx1VVVvHhFWgVAqnWJuIb9TeCKygoCDZ1WI=
X-Received: by 2002:a17:906:38ce:: with SMTP id r14mr3418479ejd.268.1636584659859;
 Wed, 10 Nov 2021 14:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20211109003052.3499225-1-haoluo@google.com> <CAEf4BzZn0Oa_AXYFbsCXX3SXqeZCRNVGPQRrkVH5VGPiOBe04A@mail.gmail.com>
 <CA+khW7g3SP5+0TYr-jtZ6Ookq9wwBWtR-bJhzPhDopxwkCbB2w@mail.gmail.com> <CAADnVQJv_MUnrHdCLK2fh4rWtzPJajF4rho7KAnWccaNfVBpqA@mail.gmail.com>
In-Reply-To: <CAADnVQJv_MUnrHdCLK2fh4rWtzPJajF4rho7KAnWccaNfVBpqA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 10 Nov 2021 14:50:48 -0800
Message-ID: <CA+khW7jE7s1XZrMRXU4v8Z3vFauUb3fn-pCn3sVxcaf4rWTkEw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/3] bpf: Prevent writing read-only memory
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 10, 2021 at 2:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 10, 2021 at 11:55 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Tue, Nov 9, 2021 at 8:43 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Nov 8, 2021 at 4:31 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > There are currently two ways to modify a kernel memory in bpf programs:
> > > >  1. declare a ksym of scalar type and directly modify its memory.
> > > >  2. Pass a RDONLY_BUF into a helper function which will override
> > > >  its arguments. For example, bpf_d_path, bpf_snprintf.
> > > >
> > > > This patchset fixes these two problem. For the first, we introduce a
> > > > new reg type PTR_TO_RDONLY_MEM for the scalar typed ksym, which forbids
> > > > writing. For the second, we introduce a new arg type ARG_CONST_PTR_TO_MEM
> > > > to differentiate the arg types that only read the memory from those
> > > > that may write the memory. The previous ARG_PTR_TO_MEM is now only
> > > > compatible with writable memories. If a helper doesn't write into its
> > > > argument, it can use ARG_CONST_PTR_TO_MEM, which is also compatible
> > > > with read-only memories.
> > > >
> > > > In v2, Andrii suggested using the name "ARG_PTR_TO_RDONLY_MEM", but I
> > > > find it is sort of misleading. Because the new arg_type is compatible
> > > > with both write and read-only memory. So I chose ARG_CONST_PTR_TO_MEM
> > > > instead.
> > >
> > > I find ARG_CONST_PTR_TO_MEM misleading. It's the difference between
> > > `char * const` (const pointer to mutable memory) vs `const char *`
> > > (pointer to an immutable memory). We need the latter semantics, and
> > > that *is* PTR_TO_RDONLY_MEM in BPF verifier terms.
> > >
> >
> > Ah, I am aware of the semantic difference between 'char * const' and
> > 'const char *', but your explanation in the bracket helps me see your
> > point better. It does seem PTR_TO_RDONLY_MEM matches the semantics
> > now. Let me fix and send an update.
>
> I thought earlier we agreed that flag approach is prefered.
> Looks like OR_NULL discussion is progressing nicely and
> IS_RDONLY or IS_RDWR flags will just fit right in.
> What's the reason to go with this approach ?
> It seems it will make the refactoring more tedious later.

I felt this patch series has been holding for too long and is now mostly ready.

In contrast, I wasn't sure how many iterations are needed for the flag
patch and kind of worried it may further delay this patch, so I
developed these two patches independently.

I can certainly merge them into one if that's preferred.
