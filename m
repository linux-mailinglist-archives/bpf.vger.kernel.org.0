Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4DA62037E
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiKGXM1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiKGXMW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:12:22 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1797628735
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:12:15 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so57538pjh.1
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UioYz5sAmFzczVkrhsjGPASepDI5h8dRlLuZ9fI55E0=;
        b=PBInVXSe2UOBy5apekQhSOfpvWZVELnbus3l0ugb7V+5fxe1bfiuSs/VJtWXd11ADI
         u9OWvhmeiI3A5XTN17XML12phP3E6SFHt7JPF10CwRnFsIPushxDGzJW5QhRUEr+uKH9
         q9Ds1s6WyaCZoV76829SaC0yZ2oeVvCE8IASvt7b4fe89P1rcfJ9GGkmtDvcudwlN5Wr
         puvMYKsGmYObKGkB/9+fDlBuLsAvs5gA5q7tg9sRDoYE8krK555V4QS0/5+xw9vKBvTj
         b5nMvxYTfrlHvl68ZvJpQlXsP8jEEfZ4B0UeDMnYlj4pPHh6jKfEOcxSgBNBhRYTBkXY
         Sqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UioYz5sAmFzczVkrhsjGPASepDI5h8dRlLuZ9fI55E0=;
        b=RgolzAyqV8nKoAgnwXHQqnf47f2BBYA5Ml8oT6DupOt8F1xmbtfKj3Q1eimw8pmyxe
         orMHwYFsBnb+91iX36aFfPXrG9BSzTeuRh4GWz0+TZ3toN9MHzr0EWq9L0IIKxi2xxH5
         kiP1qh8SmClLabAT8tn5V5A0MTfV3N2eD+VAeS1HcYGsx+VQgDaIDYDYb1+5FlWsybaA
         Fss0D+qNMOWXPQMOONTMnWHG6XEMWcPW8yiGNr1yftGw+0jVO+sOEh2G74kwLpDHQadT
         K03V1bQchjm/KckJys90D3fE6NPf+CoJA/R3cdFlatMWMenpjSKzM5Og5Yek0M+VWn4Y
         krGA==
X-Gm-Message-State: ACrzQf25T0FSgb1TXgXS9yQm8dSvQYQ/ymyB9TraiCl15Uiyz2HBXNbX
        /53QEYLNDUdTmz5/QHnLcKo=
X-Google-Smtp-Source: AMsMyM5U3i9z5DWtmADehzYT6KiQ7E673GTWwuEHKgqTbpDy4r5MT4RJqXvs0wiNt33DfjCKd7MLoQ==
X-Received: by 2002:a17:903:11c3:b0:17a:e62:16e8 with SMTP id q3-20020a17090311c300b0017a0e6216e8mr54745605plh.137.1667862735335;
        Mon, 07 Nov 2022 15:12:15 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id q8-20020a635048000000b00460a5c6304dsm4560937pgl.67.2022.11.07.15.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:12:14 -0800 (PST)
Date:   Tue, 8 Nov 2022 04:42:08 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 03/13] bpf: Rename confusingly named
 RET_PTR_TO_ALLOC_MEM
Message-ID: <20221107231208.ffinxrpg4swvnhla@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-4-memxor@gmail.com>
 <CAJnrk1YV7rxE+y5ud9tNUS+e3d=5PkEpgXibBg38AwPdt0f_8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1YV7rxE+y5ud9tNUS+e3d=5PkEpgXibBg38AwPdt0f_8A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 08, 2022 at 04:05:22AM IST, Joanne Koong wrote:
> On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Currently, the verifier has two return types, RET_PTR_TO_ALLOC_MEM, and
> > RET_PTR_TO_ALLOC_MEM_OR_NULL, however the former is confusingly named to
> > imply that it carries MEM_ALLOC, while only the latter does. This causes
> > confusion during code review leading to conclusions like that the return
> > value of RET_PTR_TO_DYNPTR_MEM_OR_NULL (which is RET_PTR_TO_ALLOC_MEM |
> > PTR_MAYBE_NULL) may be consumable by bpf_ringbuf_{submit,commit}.
> >
> > Rename it to make it clear MEM_ALLOC needs to be tacked on top of
> > RET_PTR_TO_MEM.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h   | 6 +++---
> >  kernel/bpf/verifier.c | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 13c6ff2de540..834276ba56c9 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -538,7 +538,7 @@ enum bpf_return_type {
> >         RET_PTR_TO_SOCKET,              /* returns a pointer to a socket */
> >         RET_PTR_TO_TCP_SOCK,            /* returns a pointer to a tcp_sock */
> >         RET_PTR_TO_SOCK_COMMON,         /* returns a pointer to a sock_common */
> > -       RET_PTR_TO_ALLOC_MEM,           /* returns a pointer to dynamically allocated memory */
> > +       RET_PTR_TO_MEM,                 /* returns a pointer to dynamically allocated memory */
> >         RET_PTR_TO_MEM_OR_BTF_ID,       /* returns a pointer to a valid memory or a btf_id */
> >         RET_PTR_TO_BTF_ID,              /* returns a pointer to a btf_id */
> >         __BPF_RET_TYPE_MAX,
> > @@ -548,8 +548,8 @@ enum bpf_return_type {
> >         RET_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
> >         RET_PTR_TO_TCP_SOCK_OR_NULL     = PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
> >         RET_PTR_TO_SOCK_COMMON_OR_NULL  = PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
> > -       RET_PTR_TO_ALLOC_MEM_OR_NULL    = PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_ALLOC_MEM,
> > -       RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
> > +       RET_PTR_TO_ALLOC_MEM_OR_NULL    = PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_MEM,
>
> Can you also rename this to RET_PTR_TO_RINGBUF_MEM_OR_NULL instead of
> RET_PTR_TO_ALLOC_MEM_OR_NULL, and MEM_RINGBUF instead of MEM_ALLOC?
> RET_PTR_TO_ALLOC_MEM_OR_NULL only pertains to ringbuf records, not
> generic dynamically allocated memory, so I think this rename would
> make this a lot more clear.
>

I have posted it here: https://lore.kernel.org/bpf/20221107230950.7117-6-memxor@gmail.com
