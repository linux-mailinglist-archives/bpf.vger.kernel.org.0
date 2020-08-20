Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C6124C333
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgHTQQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 12:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgHTQQC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 12:16:02 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43265C061385
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 09:16:01 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id j16so536169ooc.7
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpPzndwiSYhaVueh4zOqhGfv4Oo3BxfBjljCA4pNUIM=;
        b=aS8KE4iTIRs5uiKqL5IP+COnR+Ldcy7QhNI0Fs+SpBbNkrd+GF28NFlOZwVXfU00zl
         j9xlxMBX1SaNs94apFw+bOvHsfgwzhfHg1mPOjpSs/xwohYSdnaeU8+R/NArdJ7qfbDH
         VS5lDOzW9PQPL6PgxyyMlRs2hVSikCAJXxPls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpPzndwiSYhaVueh4zOqhGfv4Oo3BxfBjljCA4pNUIM=;
        b=j3+1zZfvrHv0liGB4Rkv0g958TrOYwP+RNYa+LPFA4UjwNgVKM8jhVEDuliVOXLAYG
         mzAZx6BJgKCPHNfKbMahgjoeK486KTrudbLNW/ambgoCj/lmw3LtdOu+PXT01aQR4Wib
         r7iJONGG4jbpKgUq599juiDs5QV96AivLyZnhp7RevUuE9A9JU2i3e2A8DvWsse9uG0c
         OthJa+y1oV/ShGMRm3G8lO4vV1QZgc5eM6AKXKhc/cI9N5USIFdFv3VH0Wzp3t4hMFb1
         WcxhJDR3apygqt405eh17HQ8TH9hJ2ANLLE2N1R+HUSLjHa0O/wZqpBmrr7NWv0bz0iZ
         XSMw==
X-Gm-Message-State: AOAM532T+FS/fa67mEZtKpVWCD7KdhPWhAUJ2gq4RsDv2PtKxk6EC3TF
        DK92Jxd1g799QXX+TuGS0UxqrGR4XHobH+7XJuDttQ==
X-Google-Smtp-Source: ABdhPJxhIFwfgHxw3SxwdM5trgHfAXmTzg6cKfXYVIO/ijSC/WKBlr9CdxjuEg4Cgs9XTqRC/fGONcWAjPxBeg7NZYw=
X-Received: by 2002:a4a:de49:: with SMTP id z9mr3004747oot.6.1597940160388;
 Thu, 20 Aug 2020 09:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200820135729.135783-1-lmb@cloudflare.com> <20200820135729.135783-5-lmb@cloudflare.com>
 <34027dbc-d5c6-e886-21f8-f3e73e2fde4a@fb.com>
In-Reply-To: <34027dbc-d5c6-e886-21f8-f3e73e2fde4a@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 20 Aug 2020 17:15:48 +0100
Message-ID: <CACAyw98gaWmpJT-LPhqKbKgaPG9s=aNU=K2Db1144dihFHzXJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] bpf: override the meaning of
 ARG_PTR_TO_MAP_VALUE for sockmap and sockhash
To:     Yonghong Song <yhs@fb.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 20 Aug 2020 at 17:10, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/20/20 6:57 AM, Lorenz Bauer wrote:
> > The verifier assumes that map values are simple blobs of memory, and
> > therefore treats ARG_PTR_TO_MAP_VALUE, etc. as such. However, there are
> > map types where this isn't true. For example, sockmap and sockhash store
> > sockets. In general this isn't a big problem: we can just
> > write helpers that explicitly requests PTR_TO_SOCKET instead of
> > ARG_PTR_TO_MAP_VALUE.
> >
> > The one exception are the standard map helpers like map_update_elem,
> > map_lookup_elem, etc. Here it would be nice we could overload the
> > function prototype for different kinds of maps. Unfortunately, this
> > isn't entirely straight forward:
> > We only know the type of the map once we have resolved meta->map_ptr
> > in check_func_arg. This means we can't swap out the prototype
> > in check_helper_call until we're half way through the function.
> >
> > Instead, modify check_func_arg to treat ARG_PTR_TO_MAP_VALUE* to
> > mean "the native type for the map" instead of "pointer to memory"
> > for sockmap and sockhash. This means we don't have to modify the
> > function prototype at all
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >   kernel/bpf/verifier.c | 37 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b6ccfce3bf4c..24feec515d3e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3872,6 +3872,35 @@ static int int_ptr_type_to_size(enum bpf_arg_type type)
> >       return -EINVAL;
> >   }
> >
> > +static int resolve_map_arg_type(struct bpf_verifier_env *env,
> > +                              const struct bpf_call_arg_meta *meta,
> > +                              enum bpf_arg_type *arg_type)
> > +{
> > +     if (!meta->map_ptr) {
> > +             /* kernel subsystem misconfigured verifier */
> > +             verbose(env, "invalid map_ptr to access map->type\n");
> > +             return -EACCES;
> > +     }
> > +
> > +     switch (meta->map_ptr->map_type) {
> > +     case BPF_MAP_TYPE_SOCKMAP:
> > +     case BPF_MAP_TYPE_SOCKHASH:
> > +             if (*arg_type == ARG_PTR_TO_MAP_VALUE) {
> > +                     *arg_type = ARG_PTR_TO_SOCKET;
> > +             } else if (*arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
> > +                     *arg_type = ARG_PTR_TO_SOCKET_OR_NULL;
>
> Is this *arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL possible with
> current implementation?

No, the only user is bpf_sk_storage_get and friends which requires
BPF_MAP_TYPE_SK_STORAGE.
I seemed to make sense to map ARG_PTR_TO_MAP_VALUE_OR_NULL, but I can
remove it as
well if you prefer. Do you think this is dangerous?

>
> If not, we can remove this "else if" and return -EINVAL, right?
>
> > +             } else {
> > +                     verbose(env, "invalid arg_type for sockmap/sockhash\n");
> > +                     return -EINVAL;
> > +             }
> > +             break;
> > +
> > +     default:
> > +             break;
> > +     }
> > +     return 0;
> > +}
> > +
> >   static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                         struct bpf_call_arg_meta *meta,
> >                         const struct bpf_func_proto *fn)
> > @@ -3904,6 +3933,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               return -EACCES;
> >       }
> >
> > +     if (arg_type == ARG_PTR_TO_MAP_VALUE ||
> > +         arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
> > +         arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
> > +             err = resolve_map_arg_type(env, meta, &arg_type);
>
> I am okay with this to cover all MAP_VALUE types with func
> name resolve_map_arg_type as a generic helper.
>
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> >       if (arg_type == ARG_PTR_TO_MAP_KEY ||
> >           arg_type == ARG_PTR_TO_MAP_VALUE ||
> >           arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
> >



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
