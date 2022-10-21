Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6A607C5B
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJUQgG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 12:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJUQgG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 12:36:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9D83B70D;
        Fri, 21 Oct 2022 09:36:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l22so7958622edj.5;
        Fri, 21 Oct 2022 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3qsx6nsoUqw1ZCbrPWKSuLYEMJ8gmzhRn6UpnCX/n3Q=;
        b=qTPBgLMRZ3r9umExwtba1KKsYveKlbYtY2KIExdrPpWsCn0kGINqklGnIMx/QrbuNG
         1U7nvMRgKDe9Rj+p2U6vyUn8rLVFmNhO8hlunAx/zshe+sGhb26x2OJQaCK6ZLZT+qK8
         ksP4JihvJ5OgFrwsfjtMuw+G4o6aNIIP9Ob+CTl8zABKMZpvUieyL+hF7RbJwT9w0E5L
         8vgEWYgiad1YAPRjxH0t0ic1UUSI4i2LTGABUbkQIE4XDjKKoP9pmRM8g0x0ULi/pmCd
         i5O9JpHcfMcQtoL+cyxhVzrfrdkAGNcAjI5A1hQmEzjdNosWv4/JvkDK+S1YW+gPx8hq
         KRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qsx6nsoUqw1ZCbrPWKSuLYEMJ8gmzhRn6UpnCX/n3Q=;
        b=PiIk9xJHhSqq6f44RdPbCvL3vZAI+sIl5GdWusdKj+N7bcb/7/DF8gjSWHv7dcsWu/
         2XlihQUQ5wND/m5Y48Jl7aanAT0huLPoA15ogOxrvsSgGvZ9sHB4oypt5/1jQax1ypf2
         arIhisc+6m2QtIQwgDPfXrihQvM4AzxM81emwLNvkMi+uJ9f9gf2gLwcWqDxpKo0PJbj
         nRU+6qylBjfiaCz+asMycq63AOkWyXlBiOMHdaSwjSNzVL75cw2KWow4NeKap+5cLobC
         QRH9AYgEKmveP4QA7eapxsR5J1CIMAReSV9sk2zXJzyM4HcQwsysxUca/rh6VveLnKHc
         Yj4Q==
X-Gm-Message-State: ACrzQf36QQ6eAioR1BFkBb+I9UEX0pWRWjpa4brNFoKTia9g9kGXfSSg
        yFmOTtPW5mTuEF64g1VehPspCluRmxVeBdNl8OU=
X-Google-Smtp-Source: AMsMyM4BvWFEACETyyOjIpm3iuYesPk2n7xJESar5hVHT74WYqlmdbT+57+TXNyDMo21uW9QCkyFC5lQ7yNb3a2M2YE=
X-Received: by 2002:a17:906:dc8f:b0:78d:f675:226 with SMTP id
 cs15-20020a170906dc8f00b0078df6750226mr16383737ejc.745.1666370162831; Fri, 21
 Oct 2022 09:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <1666364523-9648-1-git-send-email-alan.maguire@oracle.com> <Y1LJlPBQauNS/xkX@krava>
In-Reply-To: <Y1LJlPBQauNS/xkX@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 09:35:50 -0700
Message-ID: <CAEf4BzbtRqkcx8CHBqdXXWmWLeX-zsrEYMy_CgL7i48PTYjCNg@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarves: zero-initialize struct cu in cu__new()
 to prevent incorrect BTF types
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org,
        dwarves@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org
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

On Fri, Oct 21, 2022 at 9:32 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, Oct 21, 2022 at 04:02:03PM +0100, Alan Maguire wrote:
> > BTF deduplication was throwing some strange results, where core kernel
> > data types were failing to deduplicate due to the return values
> > of function type members being void (0) instead of the actual type
> > (unsigned int).  An example of this can be seen below, where
> > "struct dst_ops" was failing to deduplicate between kernel and
> > module:
> >
> > struct dst_ops {
> >         short unsigned int family;
> >         unsigned int gc_thresh;
> >         int (*gc)(struct dst_ops *);
> >         struct dst_entry * (*check)(struct dst_entry *, __u32);
> >         unsigned int (*default_advmss)(const struct dst_entry *);
> >         unsigned int (*mtu)(const struct dst_entry *);
> > ...
> >
> > struct dst_ops___2 {
> >         short unsigned int family;
> >         unsigned int gc_thresh;
> >         int (*gc)(struct dst_ops___2 *);
> >         struct dst_entry___2 * (*check)(struct dst_entry___2 *, __u32);
> >         void (*default_advmss)(const struct dst_entry___2 *);
> >         void (*mtu)(const struct dst_entry___2 *);
> > ...
> >
> > This was seen with
> >
> > bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
> >
> > ...which rewrites the return value as 0 (void) when it is marked
> > as matching DW_TAG_unspecified_type:
> >
> > static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
> > {
> >        if (tag_type == 0)
> >                return 0;
> >
> >        if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
> >                // No provision for encoding this, turn it into void.
> >                return 0;
> >        }
> >
> >        return type_id_off + tag_type;
> > }
> >
> > However the odd thing was that on further examination, the unspecified type
> > was not being set, so why was this logic being tripped?  Futher debugging
> > showed that the encoder->cu->unspecified_type.tag value was garbage, and
> > the type id happened to collide with "unsigned int"; as a result we
> > were replacing unsigned ints with void return values, and since this
> > was being done to function type members in structs, it triggered a
> > type mismatch which failed deduplication between kernel and module.
> >
> > The fix is simply to calloc() the cu in cu__new() instead.
> >
> > Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>
> awesome, this fixes the missing dedup I was seeing
> with current pahole:
>
>         $ bpftool btf dump file ./vmlinux.test | grep "STRUCT 'task_struct'" | wc -l
>         69
>
> with this patch:
>
>         $ bpftool btf dump file ./vmlinux.test | grep "STRUCT 'task_struct'" | wc -l
>         1
>

Nice and a great catch! I generally try to stick to calloc() in libbpf
exactly so I don't have to worry about stuff like this.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
>
>
> > ---
> >  dwarves.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/dwarves.c b/dwarves.c
> > index fbebc1d..424381d 100644
> > --- a/dwarves.c
> > +++ b/dwarves.c
> > @@ -626,7 +626,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
> >                  const unsigned char *build_id, int build_id_len,
> >                  const char *filename, bool use_obstack)
> >  {
> > -     struct cu *cu = malloc(sizeof(*cu) + build_id_len);
> > +     struct cu *cu = calloc(1, sizeof(*cu) + build_id_len);
> >
> >       if (cu != NULL) {
> >               uint32_t void_id;
> > --
> > 2.31.1
> >
