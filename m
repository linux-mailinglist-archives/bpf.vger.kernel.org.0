Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CCC4AA04D
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiBDTop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 14:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiBDToo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 14:44:44 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A07C061714
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 11:44:44 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a25so9904340lji.9
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 11:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+7p7SjPlIf2qoaknlsDE3NxXwoy8KpIefdGFaq4c5Ns=;
        b=eA1Fk3TYR/JpkfnoIDJ8/0lNUUWKOxyaWFCQT3NCLvbgC6Oboh+wn/OpPn/ddhZDA3
         /95pIPfnF2JZovHsPEnFoWe5cas5SjwcIhk671q8zDPCgcC7U96wijgYT/2HkdOOqwPE
         5JRuR8kP63wYej2MtAph78zTUZlczL/k3LA4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+7p7SjPlIf2qoaknlsDE3NxXwoy8KpIefdGFaq4c5Ns=;
        b=J8n+FRSGhnVwPZJOQ5bvfJofd2GppOCX0S/LThizz+xE6CLo80OjkXbgO3lwZFAd27
         LgMCgVlnIFtRfpREQXGhFi9/17XdP0LzsSm3W1KaajkEt8auhB73ygzOGyQs68oBPRo4
         vHhc2jBbxexSAyNErZZ52ru4mpqvPqogJ8cyzkotzgMsvrgcndcothdylZFdWiilBiyQ
         jjieYFmd3rI3O363Xk9q37dnIegG6P+uznG87Nr1R7dUUgdm1u7xLCxcUQSgTVfQup8R
         8Xeqvv9w8F7M8/NJplM8l8M0xKJCZNJTWQGvw/fCWZG5wfFL7szw3dwlxcQheJ8/L616
         a44g==
X-Gm-Message-State: AOAM531S9N1zfnDD2/oepW2qATtce0ueEw0fxDTVoWJF7FLL9BCaTIut
        zJfVQpH7pjCgVriE5nuFIawnvDhzMJjBWsnSKf9G6g==
X-Google-Smtp-Source: ABdhPJxB5s8BcySQb85Tldwg+UgD9pi2DNN3XJy/FXx6wr0ehlMTKupMk1RDVfqerNUu9G/dP2HfmIS9Y+JH8vUngPQ=
X-Received: by 2002:a2e:b8d6:: with SMTP id s22mr290009ljp.218.1644003882351;
 Fri, 04 Feb 2022 11:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20220128223312.1253169-1-mauricio@kinvolk.io> <20220128223312.1253169-7-mauricio@kinvolk.io>
 <CAEf4BzZ33dhRcySttxSJ6BA-1pCkbebEksLVa-cR08W=YV6x=w@mail.gmail.com>
In-Reply-To: <CAEf4BzZ33dhRcySttxSJ6BA-1pCkbebEksLVa-cR08W=YV6x=w@mail.gmail.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Fri, 4 Feb 2022 14:44:31 -0500
Message-ID: <CAHap4zuD8j7CXwOK2a12=j0j0b7twHs6gwKEBNagdryHWNQyWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/9] bpftool: Implement relocations recording
 for BTFGen
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 2, 2022 at 5:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 28, 2022 at 2:33 PM Mauricio V=C3=A1squez <mauricio@kinvolk.i=
o> wrote:
> >
> > This commit implements the logic to record the relocation information
> > for the different kind of relocations.
> >
> > btfgen_record_field_relo() uses the target specification to save all th=
e
> > types that are involved in a field-based CO-RE relocation. In this case
> > types resolved and added recursively (using btfgen_put_type()).
> > Only the struct and union members and their types) involved in the
> > relocation are added to optimize the size of the generated BTF file.
> >
> > On the other hand, btfgen_record_type_relo() saves the types involved i=
n
> > a type-based CO-RE relocation. In this case all the members for the
> > struct and union types are added. This is not strictly required since
> > libbpf doesn't use them while performing this kind of relocation,
> > however that logic could change on the future. Additionally, we expect
> > that the number of this kind of relocations in an BPF object to be very
> > low, hence the impact on the size of the generated BTF should be
> > negligible.
> >
> > Finally, btfgen_record_enumval_relo() saves the whole enum type for
> > enum-based relocations.
> >
> > Signed-off-by: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> > Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> > Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> > Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> > ---
>
> I've been thinking about this in background. This proliferation of
> hashmaps to store used types and their members really adds to
> complexity (and no doubt to memory usage and CPU utilization, even
> though I don't think either is too big for this use case).
>
> What if instead of keeping track of used types and members separately,
> we initialize the original struct btf and its btf_type, btf_member,
> btf_enum, etc types. We can carve out one bit in them to mark whether
> that specific entity was used. That way you don't need any extra
> hashmap maintenance. You just set or check bit on each type or its
> member to figure out if it has to be in the resulting BTF.
>
> This can be highest bit of name_off or type fields, depending on
> specific case. This will work well because type IDs never use highest
> bit and string offset can never be as high as to needing full 32 bits.
>
> You'll probably want to have two copies of target BTF for this, of
> course, but I think simplicity of bookkeeping trumps this
> inefficiency. WDYT?
>

It's a very nice idea indeed. I got a version working with this idea.
I keep two instances of the target BTF (as you suggested) one is only
for keeping track of the used types/members, the other one is used as
source when copying the BTF types and also to run the candidate search
algorithm and so on. Actually there is no need to use the highest bit,
I'm just setting the whole name_off to UINT32_MAX. It works fine
because that copy of the BTF isn't used anywhere else. I'm cleaning
this up and hope to send it early next week.

Thanks for all the feedback!
