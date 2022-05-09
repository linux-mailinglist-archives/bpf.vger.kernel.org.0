Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C752035A
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 19:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiEIROt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 13:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiEIROr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 13:14:47 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C173D189949
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 10:10:52 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f7c57ee6feso152354687b3.2
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4XrSlxSscNlEgl6URu3tpLobNfHjTGsXDlf6CmYLso=;
        b=acWv5h2oQihRQJU+S8rr5Tf1KXFn8j/jOSLXaUdTH+Q3k3abOLy+GIga94WRteXRSz
         Yjf5j+10T6dlLCvjvXIXw8du1ge5Q6b1Arqjpsf2+RZAAN+uCqPlVbLjuxrVNoXa5GOx
         cPmhdixIqx3aKSP+U7ZqYxyn0NbCz6lBRFDhSPlBfO33QWLjUDR7N/6LZD631U9QKz0x
         WDoJ7f7Gg2haqXRehSdWwIchupEHNcuhewQ3Y2nnSN1VhORl7/fGN57YxtmvC+ahP38P
         5w0SoynaFMnkI0vqo3mNKpNwd/3Ycf5nzdbQQoQF0mdSVxnRv2NY3XJxjiTe3qlipB2A
         Zk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4XrSlxSscNlEgl6URu3tpLobNfHjTGsXDlf6CmYLso=;
        b=D2/366XiiQjKQgqvFwhSFm1QdmZGIpothQ1Q2CJdwpgH++qzMhxhTR05wRjRyVNQ79
         uT0r8HQRqaLocHawfXZq1ib8m8dyNac5QKahL9jVfjWfQ91L0tTegCgNzRD6De+PYhiE
         1v3AAxHYGNm6L13ZEKmtJAoizAChO3p9Ps/65SMgu9+jr6Vb3uZnd3gduTJ1OHWCy9/W
         LomvTJnj+J4CKoxbnGy1Y1Q/xUgeSI8o3MZOfBHorKi0+G6egmtODmOytZXgDOdbRVun
         jjcwlSHY/VdyiCZr5UcN6yHND5AjvhbXQzsD/6spLoGRUecCD5ggKeONJt3YTFI1whzm
         A/ow==
X-Gm-Message-State: AOAM532CMB4YsIa1UfFMZTMJ3/LlrF4iaX3xv/9G+EL6eyVd+Cypu+fy
        sqS/cO9qdoC13SdFrH/AFzB/CBwBSbklBYSOxCI=
X-Google-Smtp-Source: ABdhPJxGla7fOlufHhfmMqNP4UTNgKe4CgDVTYElHYE1QKR0dgXvk7qru8mmXDfRCDZkbQVqnb0GPvijhziWn/VxSvc=
X-Received: by 2002:a81:24d2:0:b0:2f7:b684:de49 with SMTP id
 k201-20020a8124d2000000b002f7b684de49mr14815522ywk.310.1652116251488; Mon, 09
 May 2022 10:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-2-joannelkoong@gmail.com> <20220506150727.73dvaiyf5rerggj3@dev0025.ash9.facebook.com>
 <CAJnrk1Yc7G9BamfcNDGXvhMbHcrebROxN97GPPNENJ9_vGF5XA@mail.gmail.com>
 <20220506203224.e7pdw3jk6kqpe7dh@dev0025.ash9.facebook.com> <CAEf4BzavPM8o2OnYB3zSj_wfQp5us4rBjjKXzW4q-m-HARSZ1Q@mail.gmail.com>
In-Reply-To: <CAEf4BzavPM8o2OnYB3zSj_wfQp5us4rBjjKXzW4q-m-HARSZ1Q@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 9 May 2022 10:10:40 -0700
Message-ID: <CAJnrk1aVPpHv5ba-MXvxedEcFdfoEQiopUhy-ddCkM5Laq2Gjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Add MEM_UNINIT as a bpf_type_flag
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     void@manifault.com, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Fri, May 6, 2022 at 3:46 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, May 6, 2022 at 1:32 PM David Vernet <void@manifault.com> wrote:
> >
> > On Fri, May 06, 2022 at 12:09:37PM -0700, Joanne Koong wrote:
> > > I think the bpf philosophy leans more towards conflating related-ish
> > > patches into the same patchset. I think this patch could be its own
> > > stand-alone patchset, but it's also related to the dynptr patchset in that
> > > dynptrs need it to properly describe its initialization helper functions.
> > > I'm happy to submit this as its own patchset though if that is preferred :)
> >
> > Totally up to you, if that's the BPF convention then that's fine with me.
>
> You meant
>
> - [ARG_PTR_TO_UNINIT_MEM]         = &mem_types,
>
> parts as stand-alone patch? That would be invalid on its own without
> adding MEM_UNINT, so would potentially break bisection. So no, it
> shouldn't be a stand-alone patch. Each patch has to be logically
> separate but not causing any regressions in behavior, compilation,
> selftest, etc. So, for example, while we normally put selftests into
> separate tests, if kernel change breaks selftests, selftests have to
> be fixed in the same patch to avoid having any point where bisection
> can detect the breakage.
>
Ah okay, I thought we were talking about having all of the first patch
be its standalone patch. sorry for the confusion.
>
> >
> > >
> > > > -     } else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE ||
> > > > > -                base_type(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
> > > > > +     } else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE) {
> > > > >               if (type_may_be_null(arg_type) && register_is_null(reg))
> > > > >                       return 0;
> > > > >
> > > > > @@ -5811,7 +5801,7 @@ static int check_func_arg(struct bpf_verifier_env
> > > > *env, u32 arg,
> > > > >                       verbose(env, "invalid map_ptr to access
> > > > map->value\n");
> > > > >                       return -EACCES;
> > > > >               }
> > > > > -             meta->raw_mode = (arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE);
> > > > > +             meta->raw_mode = arg_type & MEM_UNINIT;
> > > >
> > > > Given that we're stashing in a bool here, should this be:
> > > >
> > > >         meta->raw_mode = (arg_type & MEM_UNINIT) != 0;
> > > >
> > > I think just arg_type & MEM_UNINIT is okay because it implicitly converts
> > > from 1 -> true, 0 -> false. This is the convention that's used elsewhere in
> > > the linux codebase as well
> >
> > Yeah I think functionally it will work just fine as is. I saw that a few
> > other places in verifier.c use operators that explicitly make the result 0
> > or 1, e.g.:
> >
> > 14699
> > 14700         env->strict_alignment = !!(attr->prog_flags & BPF_F_STRICT_ALIGNMENT);
> >
> > But the compiler will indeed implicitly convert any nonzero value to 1 if
> > it's stored in a bool, so it's not necessary for correctness. It looks like
> > the kernel style guide also implies that using the extra operators isn't
> > necessary, so I think we can leave it as you have it now:
> > https://www.kernel.org/doc/html/latest/process/coding-style.html#using-bool
>
> Yeah, the above example is rather unusual, I'd say. We do
> !!(bool_expr) only when we want to assign that to integer (not bool)
> variable/field as 0 or 1. Otherwise it's a well-defined compiler
> conversion rule for any non-zero value to be true during bool
> conversion.
>
> >
> > > > What do you think about this as a possibly more concise way to express that
> > > > the curr and next args differ?
> > > >
> > > >         return (base_type(arg_curr) == ARG_PTR_TO_MEM) !=
> > > >                 arg_type_is_mem_size(arg_next);
> > > >
> > > I was trying to decide between this and the more verbose expression above
> > > and ultimately went with the more verbose expression because it seemed more
> > > readable to me. But I don't feel strongly :) I'm cool with either one
> >
> > I don't feel strongly either, if you think your way is more readable then
> > don't feel obligated to change it.
> >
>
> Heh, this also caught my eye. It's subjective, but inequality is
> shorter and more readable (even in terms of the logic it expresses).
> But it's fine either way with me.
Since both of you think the inequality way is more readable, I will
change it to inequality for v4 then :)
>
> > Thanks,
> > David
