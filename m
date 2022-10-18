Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BF560369B
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 01:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJRXUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 19:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJRXUP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 19:20:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842BF63351
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:20:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q9so36070921ejd.0
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h6I5QMzvwNCfBnD471w8duXcAI8lAj4I6x7sVzHMDkA=;
        b=N/5od/imKYNZ3eoQnwM6RJR1oGGq//v7njqoEocrB4mPMBrQP/wNSQFQQB4opV7ZM+
         diE8XQXruXxKSQOHwPOuK8tO1hXdfnhmX0ppq2W8+HZIyni5cuOZTAFN/JHlaHVX3taW
         deIsB+fWfimPxBQ2j43PrNSJ1tKAg5T0+Ai31uTCFHxEIhBq9BwBn1GGmqRuzr6cSni5
         iw5N04BvPHoM4QKqouyjYg4Ag1T+92lTDRWZJR4nfXG1THGd0xOECzF4UGERtn1mL1fg
         +LjwXiBATjIFC4o17vtjq8dojGS8EjdTVVn/5MyAuOqvRbEEwkDrhIMd9hO41wARb6eT
         4/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6I5QMzvwNCfBnD471w8duXcAI8lAj4I6x7sVzHMDkA=;
        b=u1l0IzEXEXRST/ddxDO1mHCOBWglP24hvmt8HJrJ+kp5fwfb2Zbe61V6/bH6VDNCPg
         Q+WssirKjbUA3jP+Kzv/knpM3KqylcuAWGGL+3jxnNkiIxpcYqLAjHir4aLWlnI7S0nl
         4GSsFf5VAR1HZce99dmtH7oXRsvJI5LqBz6GGd74Sv1hdPO/ougMdOZyQKZqIeKe502C
         K5lYY4ep8dxWUA9wxxMlxj/e29OpBZoYeCDCLnmPWKrb6iMsViHzw9KAS1gNlwKfSND6
         OmvEzWrMNg5L0+aBKTfo396ffZ4Lxj0Le/SZO+k/GJ6ntQdU2mL3v3Jv4joGjeAtX/05
         VlvQ==
X-Gm-Message-State: ACrzQf3ahJ3T+8GEMmDxcAJM9P617UAu/Hr6HuK0YxO4OwbzK7MUiD2C
        SXNUVzjpoWvXWTI+OyHvv6QBlIgTv4BwHnyL/XU=
X-Google-Smtp-Source: AMsMyM4+Q6QnuFJJ3rlMwb4Hra0KgVBmEJk+dZsMH0JyAv7IMOpP0Yo69XDyFup1tkcfk7BXBZsztoLO3+6ZF+F+eKU=
X-Received: by 2002:a17:907:2d0b:b0:78e:674:6b32 with SMTP id
 gs11-20020a1709072d0b00b0078e06746b32mr4321766ejc.226.1666135213069; Tue, 18
 Oct 2022 16:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221018035646.1294873-1-andrii@kernel.org> <20221018035646.1294873-3-andrii@kernel.org>
 <Y0716CgEDxLQFSOJ@google.com>
In-Reply-To: <Y0716CgEDxLQFSOJ@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Oct 2022 16:20:00 -0700
Message-ID: <CAEf4Bzb2vwb02noeGLX-ZzAnf+T4cX0JHpOwexC1C3MbcyRwMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: only add BPF_F_MMAPABLE flag for
 data maps with global vars
To:     sdf@google.com
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 11:52 AM <sdf@google.com> wrote:
>
> On 10/17, Andrii Nakryiko wrote:
> > Teach libbpf to not add BPF_F_MMAPABLE flag unnecessarily for ARRAY maps
> > that are backing data sections, if such data sections don't expose any
> > variables to user-space. Exposed variables are those that have
> > STB_GLOBAL or STB_WEAK ELF binding and correspond to BTF VAR's
> > BTF_VAR_GLOBAL_ALLOCATED linkage.
>
> > The overall idea is that if some data section doesn't have any variable
> > that
> > is exposed through BPF skeleton, then there is no reason to make such
> > BPF array mmapable. Making BPF array mmapable is not a free no-op
> > action, because BPF verifier doesn't allow users to put special objects
> > (such as BPF spin locks, RB tree nodes, linked list nodes, kptrs, etc;
> > anything that has a sensitive internal state that should not be modified
> > arbitrarily from user space) into mmapable arrays, as there is no way to
> > prevent user space from corrupting such sensitive state through direct
> > memory access through memory-mapped region.
>
> > By making sure that libbpf doesn't add BPF_F_MMAPABLE flag to BPF array
> > maps corresponding to data sections that only have static variables
> > (which are not supposed to be visible to user space according to libbpf
> > and BPF skeleton rules), users now can have spinlocks, kptrs, etc in
> > either default .bss/.data sections or custom .data.* sections (assuming
> > there are no global variables in such sections).
>
> > The only possible hiccup with this approach is the need to use global
> > variables during BPF static linking, even if it's not intended to be
> > shared with user space through BPF skeleton. To allow such scenarios,
> > extend libbpf's STV_HIDDEN ELF visibility attribute handling to
> > variables. Libbpf is already treating global hidden BPF subprograms as
> > static subprograms and adjusts BTF accordingly to make BPF verifier
> > verify such subprograms as static subprograms with preserving entire BPF
> > verifier state between subprog calls. This patch teaches libbpf to treat
> > global hidden variables as static ones and adjust BTF information
> > accordingly as well. This allows to share variables between multiple
> > object files during static linking, but still keep them internal to BPF
> > program and not get them exposed through BPF skeleton.
>
> > Note, that if the user has some advanced scenario where they absolutely
> > need BPF_F_MMAPABLE flag on .data/.bss/.rodata BPF array map despite
> > only having static variables, they still can achieve this by forcing it
> > through explicit bpf_map__set_map_flags() API.
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> Left a nit for spelling and the same 'log err vs size' question.
>
>
> > ---
> >   tools/lib/bpf/libbpf.c | 95 ++++++++++++++++++++++++++++++++++--------
> >   1 file changed, 77 insertions(+), 18 deletions(-)
>

[...]

> > -     /* extern-backing datasecs (.ksyms, .kconfig) have their size and
> > -      * variable offsets set at the previous step, so we skip any fixups
> > -      * for such sections
> > +     /* Extern-backing datasecs (.ksyms, .kconfig) have their size and
> > +      * variable offsets set at the previous step. Further, not every
> > +      * extern BTF VAR has corresponding ELF symbol preserved, so we skip
>
> [..]
>
> > +      * all fixups altogether for such sections and go straight to storting
> > +      * VARs within their DATASEC.
>
> nit: s/storting/sorting/

eagle eye :) will fix!

>
> >        */
> > -     if (t->size)
> > +     if (strcmp(sec_name, KCONFIG_SEC) == 0 || strcmp(sec_name, KSYMS_SEC)
> > == 0)
> >               goto sort_vars;
>
> > -     err = find_elf_sec_sz(obj, sec_name, &size);
> > -     if (err || !size) {
> > -             pr_debug("sec '%s': invalid size %u bytes\n", sec_name, size);
> > -             return -ENOENT;
> > -     }
> > +     /* Clang leaves DATASEC size and VAR offsets as zeroes, so we need to
> > +      * fix this up. But BPF static linker already fixes this up and fills
> > +      * all the sizes and offsets during static linking. So this step has
> > +      * to be optional. But the STV_HIDDEN handling is non-optional for any
> > +      * non-extern DATASEC, so the variable fixup loop below handles both
> > +      * functions at the same time, paying the cost of BTF VAR <-> ELF
> > +      * symbol matching just once.
> > +      */
> > +     if (t->size == 0) {
> > +             err = find_elf_sec_sz(obj, sec_name, &size);
> > +             if (err || !size) {
> > +                     pr_debug("sec '%s': invalid size %u bytes\n", sec_name, size);
>
> nit: same suggestion here - let's log err instead?

sure

>
> > +                     return -ENOENT;
> > +             }
>
> > -     t->size = size;
> > +             t->size = size;
> > +             fixup_offsets = true;
> > +     }
>
> >       for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
> >               const struct btf_type *t_var;

[...]
