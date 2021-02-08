Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492C0313EB3
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 20:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhBHTSB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 14:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbhBHTRu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 14:17:50 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE0C061788
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 11:17:09 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u4so18603060ljh.6
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 11:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qRRFwTuqO+Aiajdff+1iriDFNvAEXC3WkSMPqPFbz0=;
        b=hXC3e+Os0Tjxx46Zo9mCNNZBdKdyJk28UTJa01dWh9Vczs6hqc9irq9PguyC3Tk7rS
         4JO4AIqc98dIxw9C6vE1E6P2o9KEHlrCidHqPG9ftYsA8S3jw+iwKdRfYhaPsDIWuEGZ
         bV/smCTeJBHCgUSp6ji4efSBf3w4AqruXNbGdlNyl7BUthz/vOtL3g26UfN9i9CTeij9
         UhGf+MeN7gYNjlzDuHyt+KyPpqZ0lY+EaUhxGVccUxobDECzYXBFtCwup/Q2CWMGAYQo
         keK2FJxRIH/8A14eTiNZomVijmQEehdQ0h0jVwjTBTt37tfBGJG93xbC+BIq/SrdSx62
         y/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qRRFwTuqO+Aiajdff+1iriDFNvAEXC3WkSMPqPFbz0=;
        b=ao/rGbI7sXi/JvxaKWV8GQjPr3CoyyXu6N3DNacGFdoUWBIeXr9KVucKaY27odA87j
         063J+OxvnyabvDGQfcCWAGvJLEoasnYlZDs3Ex8/DdFfKW8yxxlpBvWF+LoMtW4WEgfv
         Bdo0SdaRVRz2i0xGkiC149zUBoWgKkOG3WFPD+c57QznXqAeaT/1lOdxlk2bvfzXuKZR
         G+LR8qXPsf8U9tLDJABzTn2V0aDjDAzgj8SEN4O9i6CsZzKq34Rm9BtKFnEwSPPLz6g/
         oDmSTcOFVTlXOi7gBhFp5Gg0TDy0/MVySJsIbBnxhsTZBJsvHEPIeh2uaCzZHvO5PJRl
         IfBw==
X-Gm-Message-State: AOAM533ujuBPmIfHt+pFAejsC4k75j6s5jn3yUYA1Fma7buHzZ6HcB5f
        OQ0q0xfzFkBR+q0YIzSW5WnkghmLMY0YzCqHC/EDxA==
X-Google-Smtp-Source: ABdhPJyBX2gPwejaHESl1FKAyFitddRy5yirbdvVLuQLaVidZ8uswiOJGDhE6a1mUqOrAXgLaCC7FbCEl4C4e9FACv8=
X-Received: by 2002:a2e:8541:: with SMTP id u1mr12328144ljj.0.1612811827604;
 Mon, 08 Feb 2021 11:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20210207071726.3969978-1-yhs@fb.com> <a02164334d0e991820eefa45e2df1a8b49f5537e.camel@klomp.org>
In-Reply-To: <a02164334d0e991820eefa45e2df1a8b49f5537e.camel@klomp.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Feb 2021 11:16:56 -0800
Message-ID: <CAKwvOdmMPjn-_opboZkVhRpYCUuKFv8G9GtKFAj=wqYRjr-jkA@mail.gmail.com>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base type
To:     Mark Wielaard <mark@klomp.org>, David Blaikie <blaikie@google.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 7, 2021 at 6:18 AM Mark Wielaard <mark@klomp.org> wrote:
>
> Hi,
>
> On Sat, 2021-02-06 at 23:17 -0800, Yonghong Song wrote:
> > clang with dwarf5 may generate non-regular int base type,
> > i.e., not a signed/unsigned char/short/int/longlong/__int128.
> > Such base types are often used to describe
> > how an actual parameter or variable is generated. For example,
> >
> > 0x000015cf:   DW_TAG_base_type
> >                 DW_AT_name      ("DW_ATE_unsigned_1")
> >                 DW_AT_encoding  (DW_ATE_unsigned)
> >                 DW_AT_byte_size (0x00)
> >
> > 0x00010ed9:         DW_TAG_formal_parameter
> >                       DW_AT_location    (DW_OP_lit0,
> >                                          DW_OP_not,
> >                                          DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
> >                                          DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
> >                                          DW_OP_stack_value)
> >                       DW_AT_abstract_origin     (0x00013984 "branch")
> >
> > What it does is with a literal "0", did a "not" operation, and the converted to
> > one-bit unsigned int and then 8-bit unsigned int.
>
> Thanks for tracking this down. Do you have any idea why the clang
> compiler emits this? You might be right that it is intended to do what
> you describe it does (but then it would simply encode an unsigned
> constant 1 char in a very inefficient way). But as implemented it
> doesn't seem to make any sense. What would DW_OP_convert of an zero
> sized base type even mean (if it is intended as a 1 bit sized typed,
> then why is there no DW_AT_bit_size)?

David,
Any thoughts on the above sequence of DW_OP_ entries?  This is a part
of DWARF I'm unfamiliar with.

>
> So I do think your patch makes sense. clang clearly is emitting
> something bogus. And so some fixup is needed. But maybe we should at
> least give a warning about it, otherwise it might never get fixed.
>
> BTW. If these bogus base types are only emitted as part of a location
> expression and not as part of an actual function or variable type
> description, then why are we even trying to encode it as a BTF type? It
> might be cheaper to just skip/drop it. But maybe the code setup makes
> it hard to know whether or not such a (bogus) type is actually
> referenced from a function or variable description?
>
> Cheers,
>
> Mark



-- 
Thanks,
~Nick Desaulniers
