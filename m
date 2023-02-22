Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA969FAD9
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjBVSMD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 13:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBVSMC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 13:12:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A63BDA9
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 10:12:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b12so33981138edd.4
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 10:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn6XVXcbuHFZZPL7xsg6xo9s+Du+/gIhKwE5QLHIIBo=;
        b=P6IsxCooUzRPqeXcuIizLOuLx0AhLEn9mHjYJ6AXVOAaLuW5SaFrjmeiIJnwF1f5zh
         OVgVZksjt8jSrCTFQtPnaNHB7qF3HGc7ZP/yoKuKZDuMm9lDh+ZRn2K4Nb2mOkHvOWXd
         vnH40hmWQLJ/A3IqamX/NNJsGg9jk+3tlz9SjkrFojZrjz01RbOYodvBn5ZZyWMCvJZe
         H1O0vaPEnwBvu0iqycLxGf5moe0CILOUw+LeFraj4lNNKVgzqe8GfQ+naaVbsPP5kTTE
         2cBFVrmX8bk0S8NrQMb2FtNAZiUc32eGE7agSyLQCym9ijOl3dNH+qzZ3702qbMvtAsm
         qe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rn6XVXcbuHFZZPL7xsg6xo9s+Du+/gIhKwE5QLHIIBo=;
        b=GwkfCRKrFPdNKUWuWF8VMUSe1hw/Bh3o7moMhuZyK/iXElL657ZZzezZYTz8TLuRmf
         YhsjOz7WAJc5kXYXGzuDHtkn6OBxwDY43aXDAAvWV5SsdKNfspw9H/oGOxsLEpp9UYmc
         /+oRdlQPkH4k1+rPBZEzMBQK1E0/5Z1f5ESMirjg8nEX54WD/XVeMfd1bHp+ma+nZCDr
         sT9vBabpwnuQiA2LRdX9bX6JEz+o3DHtlKA/by/XqYry2ZwFSRxdak9DmFhP2MdcidxR
         foF0GodjSsC1ovT1ylIZxwKuDxpTPV6KTnvzoadpQaUyJDvyuHG1GEwzm3urShSzNI6x
         DHmg==
X-Gm-Message-State: AO0yUKWevgA3/EmJ67eBxf6AHB2bZuT7SzjtSmcO5z/+R1teVPmb3GY3
        x6f7GncKoUJBy8MyIRgpD0UKKksGoiFbC+U57ig=
X-Google-Smtp-Source: AK7set/AadjdpQKR6I/oNEe/g1KpO1rEKvJy4tmsVMvvA3Ak4AlifyBqKNtcC9UC8Y0CzHntJYMnrl6ldIhS/hsLZiM=
X-Received: by 2002:a17:906:5158:b0:883:ba3b:eb94 with SMTP id
 jr24-20020a170906515800b00883ba3beb94mr7659274ejc.3.1677089519497; Wed, 22
 Feb 2023 10:11:59 -0800 (PST)
MIME-Version: 1.0
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
 <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
 <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com> <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
 <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com>
In-Reply-To: <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 10:11:48 -0800
Message-ID: <CAADnVQ+QNAEaqgOM9PwDs+0dkiL3wmPafJN=XY5ckcgTzmsiEg@mail.gmail.com>
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
To:     David Faust <david.faust@oracle.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>, Mykola Lysenko <mykolal@fb.com>
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

On Wed, Feb 22, 2023 at 10:05 AM David Faust <david.faust@oracle.com> wrote:
>
>
>
> On 2/21/23 14:57, Eduard Zingerman wrote:
> > On Tue, 2023-02-21 at 11:38 -0800, David Faust wrote:
> > [...]
> >> Very nice.
> >> Keeping the 0x6000 tag and instead changing the name sounds good to us.
> >>
> >> From the GCC side, support for BTF tags will be new either way but
> >> conserving DWARF tag numbers is a good idea.
> >
> > Great, thank you!
> >
> >>> Both [1] and [2] are in a workable state, but [2] lacks support for
> >>> subroutine types and "void *" for now. If you are onboard with this change
> >>> I'll proceed with finalizing [1] and [2]. (Also, ":v2" suffix might be not
> >>> the best, I'm open to naming suggestions).
> >>
> >> As for the name, I am not sure the ":v2" suffix is a good idea.
> >>
> >> If we need a new name anyway, this could be a good opportunity to use
> >> something more generic. The annotation DIEs, especially with the new
> >> format, could be more widely useful than exclusively for producing BTF.
> >>
> >> For example, some other tool may want to process these same user
> >> annotations which are now recorded in DWARF, but may not involve BPF/BTF
> >> at all. Tying "btf" into the name seems to unnecessarily discourage
> >> those use cases.
> >>
> >> What do you think about something like "debug_type_tag" or
> >> "debug_type_annotation" (and a similar update for the decl tags)?
> >> The translation into BTF records would be the same, but the DWARF info
> >> would stand on its own without being tied to BTF.
> >>
> >> (Naming is a bit tricky since terms like 'tag' are already in use by
> >> DWARF, e.g. "type tag" in the context of DWARF DIEs makes me think of
> >> DW_TAG_xxxx_type...)
> >>
> >> As far as I understand, early proposals for the tags were more generic
> >> but the LLVM reviewers wished for something more specific due to the
> >> relatively limited use of the tags at the time. Now that the tags and
> >> their DWARF format have matured I think a good case can be made to
> >> make these generic. We'd be happy to help push for such change.
> >
> > On the other hand, BTF is a thing we are using this annotation for.
> > Any other tool can reuse DW_TAG_LLVM_annotation, but it will need a
> > way to distinguish it's annotations from BTF annotations. And this can
> > be done by using a different DW_AT_name. So, it seems logical to
> > retain "btf" in the DW_AT_name. What do you think?
>
> OK I can understand keeping it BTF specific.
>
> Other than that, I don't come up with any significantly different idea
> than to use the ":v2" suffix, so let's go with "btf_type_tag:v2"?

I don't like v2 suffix either.
Please come up with something else.
