Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA226EDB30
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 07:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjDYF34 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 01:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYF3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 01:29:51 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B495FF3
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 22:29:49 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe0146b01so62614167b3.3
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682400588; x=1684992588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YFZYpBv2UpMIY2WEJh2NaZTdcRkoe4O3IP7rQu3MzA=;
        b=YPqMglti7ewwBG4iagtHLT0dYRWJQxyxRGmJu3CpOy3zpPEttLBGOJWlepK6RZMlXc
         uw9mSpvVTpxLGwisjCXabTuOicBpIK2abgA2Zjk5Yo2vLqdY8DovEaRWVUidZryQUqJV
         gtRSU9A/Q2UqsyUox3WalyvPUUUB0pTDD0QlCjaxyLGH3EH/MN7KTXqN6heSV7pj4fSv
         Xj5H0FxU3NhpoQ35r6Zq6UC+xLc83lG2RFybH+dcA8y99LurhjVF3IPD33ZU+jwrSrAo
         qTTtw5XSRC4rnNf3bOS9wYvcKKwxiM6chg/kCbiNyU/mncGR0ZbaYrJ0x0DWXcSRrYw5
         A44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682400588; x=1684992588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YFZYpBv2UpMIY2WEJh2NaZTdcRkoe4O3IP7rQu3MzA=;
        b=VLKfVRIqDByK2YZL8uz5b5Ju0YGjcU+o6ocr/tq+MGYmboaH3c67Ws8o1AqQPmQ+ZD
         Haej3VHXNXP4bWzqUDsO5a4ZRv3gfxFsIYHyI97x2rWp65fBl/ZoTh3hyk068A7y2NxD
         5QEoy1Rqa4V9fyZ0bFSpSN8lLadQ8kLoWNOAmC8P6CIHQqafYhVn0fZN7SsoXSsRDcKl
         04TgLpiBJNP60rzFnk4v+B7Z9ReLaKkUCx/L1ZBdZD78CJYoV6bRJKOD30qaUMX8w/y3
         yJGBkFKq41RJ13U8JFENfyr+wRM7xmuiBzRdo6IPhYrnqulqEVGveskv2gwVEt/Bjmb7
         uJww==
X-Gm-Message-State: AAQBX9dznFVf275XOmZbJjDDWhkb7455ioGVhiWo+XqsVovjgt4g5zJy
        jt3/trQcR0YbDYaSVqz/hLfQkH08xAuKI4e3a9yqvGqfLatBew==
X-Google-Smtp-Source: AKy350Yjih8ONMDLx4LNoc89PlLI3wz46dxPSlcvRtPpqrcMfM6qWgOOszgd4SsI/vFi1u1BY41bGOq3Wt8BEGszf5w=
X-Received: by 2002:a0d:c644:0:b0:54f:6471:c913 with SMTP id
 i65-20020a0dc644000000b0054f6471c913mr8811108ywd.27.1682400588137; Mon, 24
 Apr 2023 22:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-2-joannelkoong@gmail.com> <6446dca6c74fd_389cc208e3@john.notmuch>
In-Reply-To: <6446dca6c74fd_389cc208e3@john.notmuch>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 24 Apr 2023 22:29:37 -0700
Message-ID: <CAJnrk1aVu8Jo8LBsu8_dyVe6uFWR7BWpyQMuR-QkfT03uVie7A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 12:46=E2=80=AFPM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Joanne Koong wrote:
> > Add a new kfunc
> >
> > int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end);
> >
> > which adjusts the dynptr to reflect the new [start, end) interval.
> > In particular, it advances the offset of the dynptr by "start" bytes,
> > and if end is less than the size of the dynptr, then this will trim the
> > dynptr accordingly.
> >
> > Adjusting the dynptr interval may be useful in certain situations.
> > For example, when hashing which takes in generic dynptrs, if the dynptr
> > points to a struct but only a certain memory region inside the struct
> > should be hashed, adjust can be used to narrow in on the
> > specific region to hash.
>
> Would you want to prohibit creating an empty dynptr with [start, start)?

I'm open to either :) I don't reallysee a use case for creating an
empty dynptr, but I think the concept of an empty dynptr might be
useful in general, so maybe we should let this be okay as well?

>
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 00e5fb0682ac..7ddf63ac93ce 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dynptr_=
kern *ptr)
> >       return ptr->size & DYNPTR_SIZE_MASK;
> >  }
> >
> > +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_s=
ize)
> > +{
> > +     u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
> > +
> > +     ptr->size =3D new_size | metadata;
> > +}
> > +
> >  int bpf_dynptr_check_size(u32 size)
> >  {
> >       return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> > @@ -2297,6 +2304,24 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const st=
ruct bpf_dynptr_kern *ptr, u32 o
> >       return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
> >  }
> >
> > +__bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 sta=
rt, u32 end)
> > +{
> > +     u32 size;
> > +
> > +     if (!ptr->data || start > end)
> > +             return -EINVAL;
> > +
> > +     size =3D bpf_dynptr_get_size(ptr);
> > +
> > +     if (start > size || end > size)
> > +             return -ERANGE;
>
> maybe 'start >=3D size'? OTOH if the verifier doesn't mind I guess its OK
> to create the thing even if it doesn't make much sense.

I think there might be use cases where this is useful even though the
zero-sized dynptr can't do anything. for example, if there's a helper
function in a program that takes in a dynptr, parses some fixed-size
chunk of its data, and then advances it, it might be useful to have
the concept of a zero-sized dynptr, so that if we're parsing the last
chunk of the data, then the last call to bpf_dynptr_adjust() will
still succeed and the dynptr will be of size 0, which signals
completion.

>
> > +
> > +     ptr->offset +=3D start;
> > +     bpf_dynptr_set_size(ptr, end - start);
> > +
> > +     return 0;
> > +}
> > +
> >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> >  {
> >       return obj;
> > @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_=
NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > +BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >  BTF_SET8_END(common_btf_ids)
> >
> >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > --
> > 2.34.1
> >
