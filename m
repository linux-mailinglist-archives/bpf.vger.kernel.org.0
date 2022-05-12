Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57476525633
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 22:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358233AbiELUDZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 16:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355330AbiELUDY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 16:03:24 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBBD5E747
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 13:03:23 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ec42eae76bso69108127b3.10
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ec7h9tWxmUr551a7ljPSVhjqp5m3tvOiW1zZM8zmmw=;
        b=Pqs0Fiyb0EsG2rzR4hV97o/99c6EThmxemtADYllMODoXkgOOvdN+APTa+kNm3AM+t
         SpGxXYOlCOnhw/xdR6zggmIdmBg81LOvRU+zdx2W9+nrBtozlA8WqQuyoAJPgoYw76v+
         wrPfXY779jwn0UgcLS1SAZTJX69vvgtSRZ+NUhsRUJW7aVyjc2dj5jyN8ZPMxey746Lr
         jMcl0byx/CWmfsBCLvfML5xzRz8oXwqV/YU8HbI18iuDu1n5t+1L6D+AwsFSCdGNNrBD
         T5IxNTfJLU3jkG2x+xQb30C8riarU+R/6P1D62YIkUKdR4J58WYFTWc+vB4eqzU/JqWB
         WuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ec7h9tWxmUr551a7ljPSVhjqp5m3tvOiW1zZM8zmmw=;
        b=GHEljkxnm4E+31/EYEa8/ho7OlRvzLNOJQ0IkImfagH2Po8IAISGBICx15JSZSYuOn
         o+75QJqlYC+t3om/5WGn8tZihypN/azMxYcRuRPd7CnFZHNIJkoYZa5yDo27nB74niyj
         yRdDUj9CIsONA719cTZkBXO8gcSVFbypazPKx/d31zBRFspuKGBQiib7NR2cdjuMLfIR
         u1xf6N8kgCYT7RKMbYZZ6A3yW60yyWxfK5CkHmydXGpnxUKoKGIY3ClXhrShIlMkYMnd
         mI/Ro96Ju3dobAjy+CAej+1hS0Q1zDqHN7YTYddtRx45YELpwPxUakZblf/9I7Zf9Bes
         02xg==
X-Gm-Message-State: AOAM533G6PTNXGFjmC0846eouKH+zLWe4sLN1ZlT4/tIrv8dH4uCZA17
        FVmkRNJUfgP86EsXh92zjghNArDTtxtuQ4XHdUqEcv/Jwf8=
X-Google-Smtp-Source: ABdhPJw6ENm/Jq6OLW39+pfY5DeUVTw21xP1T7ItnTJ6p7exUy1PTAlqbNL4zzZErmReAGLV7Z1D5sQuUj7E15lupas=
X-Received: by 2002:a81:1812:0:b0:2f7:b66f:bf3d with SMTP id
 18-20020a811812000000b002f7b66fbf3dmr1966265ywy.263.1652385802699; Thu, 12
 May 2022 13:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-3-joannelkoong@gmail.com> <6c0d9917-fcb2-6a74-81d7-4f9421867d76@iogearbox.net>
In-Reply-To: <6c0d9917-fcb2-6a74-81d7-4f9421867d76@iogearbox.net>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 12 May 2022 13:03:11 -0700
Message-ID: <CAJnrk1Zs6dVAqwbCQ1VShH+00D_EY7ePjyyhfj5UVO5zwSO7JA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add verifier support for dynptrs and
 implement malloc dynptrs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
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

On Wed, May 11, 2022 at 5:05 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/10/22 12:42 AM, Joanne Koong wrote:
> [...]
> > @@ -6498,6 +6523,11 @@ struct bpf_timer {
> >       __u64 :64;
> >   } __attribute__((aligned(8)));
> >
> > +struct bpf_dynptr {
> > +     __u64 :64;
> > +     __u64 :64;
> > +} __attribute__((aligned(8)));
> > +
> >   struct bpf_sysctl {
> >       __u32   write;          /* Sysctl is being read (= 0) or written (= 1).
> >                                * Allows 1,2,4-byte read, but no write.
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 8a2398ac14c2..a4272e9239ea 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1396,6 +1396,77 @@ const struct bpf_func_proto bpf_kptr_xchg_proto = {
> >       .arg2_btf_id  = BPF_PTR_POISON,
> >   };
> >
> > +void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_dynptr_type type,
> > +                  u32 offset, u32 size)
> > +{
> > +     ptr->data = data;
> > +     ptr->offset = offset;
> > +     ptr->size = size;
> > +     bpf_dynptr_set_type(ptr, type);
> > +}
> > +
> > +void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
> > +{
> > +     memset(ptr, 0, sizeof(*ptr));
> > +}
> > +
> > +BPF_CALL_3(bpf_dynptr_alloc, u32, size, u64, flags, struct bpf_dynptr_kern *, ptr)
> > +{
> > +     gfp_t gfp_flags = GFP_ATOMIC;
>
> nit: should also have __GFP_NOWARN
I will add this in to v5
>
> I presume mem accounting cannot be done on this one given there is no real "ownership"
> of this piece of mem?
I'm not too familiar with memory accounting, but I think the ownership
can get ambiguous given that the memory can be persisted in a map and
"owned" by different bpf programs (eg the one that frees it may not be
the same one that allocated it)
>
> Was planning to run some more local tests tomorrow, but from glance at selftest side
> I haven't seen sanity checks like these:
>
> bpf_dynptr_alloc(8, 0, &ptr);
> data = bpf_dynptr_data(&ptr, 0, 0);
> bpf_dynptr_put(&ptr);
> *(__u8 *)data = 23;
>
> How is this prevented? I think you do a ptr id check in the is_dynptr_ref_function
> check on the acquire function, but with above use, would our data pointer escape, or
> get invalidated via last put?

There's a subtest inside the dynptr_fail.c file called
"data_slice_use_after_put" that does:

bpf_dynptr_alloc(8, 0, &ptr);
data =bpf_dynptr_data(&ptr, 0, 8);
bpf_dynptr_put(&ptr);
val = *(__u8 *)data;

and checks that trying to dereference the data slice in that last line
fails the verifier (with error msg "invalid mem access 'scalar'")

In the verifier, the call to bpf_dynptr_put will invalidate any data
slices associated with the dyntpr. This happens in
unmark_stack_slots_dynptr() which calls release_reference() which
marks the data slice reg as an unknown scalar value. When you try to
then dereference the data slice, the verifier rejects it with an
"invalid mem access 'scalar'" message.

Thanks for your comments.
>
> Thanks,
> Daniel
