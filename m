Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D775B3C0F
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiIIPem (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 11:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiIIPeS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 11:34:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A0148581
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 08:33:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so3054393edc.11
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vtjB1xCqrCXPl2OBN1GSmVjC7Dg8xv/QTmC4nQvC9FA=;
        b=JxxtmC3jHAXB4Fojq+1c3HWBK/an8tGjjiF1rLKAR8MCgrMZllBPPj2haDRS0aFf8G
         YJsyRz/5+MgRx7SPNj75l73mZ2ZGBBB2zqRjBn+YH/WunlruwwcsRK/kCa1G0PmX5gm3
         gMwdPC5LWurk66sO1CSBBn8J+YwC25qNmqcnlOc6dGAExRNToopNAUfVsTY/2TAhgxmb
         9J/ONmk8/FlSEMbpXHNZhbro5fA7B2gDFUHckgATm4INFtXjqvRwn8cM3u1wo9dS/rzI
         c1Bl0e90hK6Z56vkpBhhRGn86Jz4qa02fWiGRext0+UIv+55pCSg01pwBywBx7JCnXkn
         hbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vtjB1xCqrCXPl2OBN1GSmVjC7Dg8xv/QTmC4nQvC9FA=;
        b=cfkyY29XTzjQDpmp3lnWZRDVZWxhbJKztQ9qTKbaCOb17+2LPiLHerDcYAxQRp2T0P
         20kGX/432D/tveALqKvLcvR3UbKRFRYuAm5RjwsqDxNyHnt5OgeiSpj5k78CYiYfTxcK
         aIK779njp0/Z0DDcxyC5YI0v7+WtUGNSu80I6+TYBJAy37uCrpZvz1pxpHIBA2zKfx1I
         i1iUsbj99+Mq5ARfZiaCRqSwO843H2xxsW8Mpnm6gMG4oplK78rJAJw5PdxTh+anLxOZ
         sRgXQfdA/RLlWflPYrSYVDrOZM3sDl9YIx+dJCIRQeMP5xyBvmEalBCtN8Bw9l/oWHbM
         BdIw==
X-Gm-Message-State: ACgBeo0hkr4g0O7ONc9I61NaFlKbspG1vLQ4fUd/iLC4S2Sp58T69GDT
        H/9HElGwAzKNHeRJXpmiUi444NpI++kJ3QWTp9E=
X-Google-Smtp-Source: AA6agR5QOyfkibXte5JDVkyLNMtOEM+Imn+5hFMtMl+8u/UGFIz9xumevwLxVWZu+3PCdrKLhm6l8Iz6PbzvxbaBhXY=
X-Received: by 2002:a05:6402:27ca:b0:43e:ce64:ca07 with SMTP id
 c10-20020a05640227ca00b0043ece64ca07mr12290106ede.66.1662737556268; Fri, 09
 Sep 2022 08:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
 <20220908000254.3079129-2-joannelkoong@gmail.com> <CAPhsuW4kKjpPLJueKH1_jqpJp2XqaCZPr5X+dS6G=5JXpqFqwg@mail.gmail.com>
In-Reply-To: <CAPhsuW4kKjpPLJueKH1_jqpJp2XqaCZPr5X+dS6G=5JXpqFqwg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 9 Sep 2022 08:32:25 -0700
Message-ID: <CAADnVQJBKsiuDV18KaSqAzQvXhS7TcpOxMpEPqLyh2K2wd_tSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Add bpf_dynptr_data_rdonly
To:     Song Liu <song@kernel.org>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 9, 2022 at 8:29 AM Song Liu <song@kernel.org> wrote:
>
> On Thu, Sep 8, 2022 at 1:10 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > Add a new helper bpf_dynptr_data_rdonly
> >
> > void *bpf_dynptr_data_rdonly(struct bpf_dynptr *ptr, u32 offset, u32 len);
> >
> > which gets a read-only pointer to the underlying dynptr data.
> >
> > This is equivalent to bpf_dynptr_data(), except the pointer returned is
> > read-only, which allows this to support both read-write and read-only
> > dynptrs.
> >
> > One example where this will be useful is for skb dynptrs where the
> > program type only allows read-only access to packet data. This API will
> > provide a way to obtain a data slice that can be used for direct reads.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       | 15 +++++++++++++++
> >  kernel/bpf/helpers.c           | 32 ++++++++++++++++++++++++++------
> >  kernel/bpf/verifier.c          |  7 +++++--
> >  tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
> >  4 files changed, 61 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index c55c23f25c0f..cce3356765fc 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5439,6 +5439,20 @@ union bpf_attr {
> >   *             *flags* is currently unused, it must be 0 for now.
> >   *     Return
> >   *             0 on success, -EINVAL if flags is not 0.
> > + *
> > + * void *bpf_dynptr_data_rdonly(struct bpf_dynptr *ptr, u32 offset, u32 len)
> > + *     Description
> > + *             Get a read-only pointer to the underlying dynptr data.
> > + *
> > + *             This is equivalent to **bpf_dynptr_data**\ () except the
> > + *             pointer returned is read-only, which allows this to support
> > + *             both read-write and read-only dynptrs. For more details on using
> > + *             the API, please refer to **bpf_dynptr_data**\ ().
> > + *     Return
> > + *             Read-only pointer to the underlying dynptr data, NULL if the
> > + *             dynptr is invalid or if the offset and length is out of bounds
> > + *             or in a paged buffer for skb-type dynptrs or across fragments
> > + *             for xdp-type dynptrs.
> >   */
> >  #define __BPF_FUNC_MAPPER(FN)          \
> >         FN(unspec),                     \
> > @@ -5652,6 +5666,7 @@ union bpf_attr {
> >         FN(ktime_get_tai_ns),           \
> >         FN(dynptr_from_skb),            \
> >         FN(dynptr_from_xdp),            \
> > +       FN(dynptr_data_rdonly),         \
> >         /* */
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index befafae34a63..30a59c9e5df3 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1572,7 +1572,7 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
> >         .arg5_type      = ARG_ANYTHING,
> >  };
> >
> > -BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
> > +void *__bpf_dynptr_data(struct bpf_dynptr_kern *ptr, u32 offset, u32 len, bool writable)
> >  {
> >         enum bpf_dynptr_type type;
> >         void *data;
> > @@ -1585,7 +1585,7 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
> >         if (err)
> >                 return 0;
>
> Let's return NULL for void* type.
>
> >
> > -       if (bpf_dynptr_is_rdonly(ptr))
> > +       if (writable && bpf_dynptr_is_rdonly(ptr))
> >                 return 0;
> ditto
> >
> >         type = bpf_dynptr_get_type(ptr);
> > @@ -1610,13 +1610,31 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
> >                 /* if the requested data in across fragments, then it cannot
> >                  * be accessed directly - bpf_xdp_pointer will return NULL
> >                  */
> > -               return (unsigned long)bpf_xdp_pointer(ptr->data,
> > -                                                     ptr->offset + offset, len);
> > +               return bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
> >         default:
> > -               WARN_ONCE(true, "bpf_dynptr_data: unknown dynptr type %d\n", type);
> > +               WARN_ONCE(true, "__bpf_dynptr_data: unknown dynptr type %d\n", type);
>
> Let's use __func__ so we don't have to change this again.
>
> WARN_ONCE(true, "%s: unknown dynptr type %d\n", __func__, type);

WARN includes file and line automatically.
Do we really need func here too?
