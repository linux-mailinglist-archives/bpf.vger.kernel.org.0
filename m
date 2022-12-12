Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA164A75F
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 19:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiLLSqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiLLSpv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 13:45:51 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C1C7A
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 10:45:18 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gh17so30473835ejb.6
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 10:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uiA2ipXd0o85kZZdHRiQZxCrDLXIrF5IHCTYNirDN/o=;
        b=l7O4NUEI+5E4KnRbCMi3fnVN7R6e/FzXBcIL3kOd2eHpJ+sUO23k0NFhRsV7tEB0dO
         jPx9VPPpCe0GVqwcsJlxRwvVk8bfqFOVhdgKPWz91ksZVhoRlcYdu6puzAKvThvTwY8+
         P/6kKXkFC3B+/B5z1dE7SL8V5wCrbSvatNWua2QbiMYidwixcGqGnOXCA4yB1NThHTZa
         ZuAqSN78eLGFrynXBskasOLYz/NFyst0S8E3hQycs91Iul2COP54Pl8czXi3CWa3t01S
         QH31tTTldYv7LEYBBbRVlLao7AVqeElfyOC6ZQHkA8LFo2WDejgXkuyOb+a9viOjGO1h
         JMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiA2ipXd0o85kZZdHRiQZxCrDLXIrF5IHCTYNirDN/o=;
        b=AEyRaGtPQ4Wimyqs9uFvUWdgtDhu7n69UPodtb58vvh4I22dwWiEFaHs2JdGLVTLER
         aSz4HVJ/DK3DSrJps8Bl5BwBuMgXzxOoU3BKokSzyQGMEppe/APmuyZ1PNl8N+J/aWq+
         SwZTOEE306mtoQvzQ0qDC+Vhiwx4TJmVMnbrf2L5A8D9AqlT4fEuKaBfXNXvPD9WCIxs
         cLfSRhSChIU4bJkELR/V9sJOl68+gMh+FRhoh0MHXAolw150gP+LnuYWje+8BszYzh5g
         fDjI98eQAuZNd2nRgjr81bzldsKBK9M4hh9IUyrTgFVxv1h48W3spckqox6LiT+dH4MN
         uu/g==
X-Gm-Message-State: ANoB5pkUHk+PH1K5w04m+cqTnRYMUxD4heRfJWc+vAzr4m6oHLIyzutB
        mudDwA8/kWJbXm9ByTBiPJNUNQmYsG3S4XXuXAc=
X-Google-Smtp-Source: AA0mqf418MRCP6/+fZgk7+8ALpCInDaTsDvVs2U2M0zvvQN50apPqZOWBTSjwAwe6BgU98k4sgOAzMKJH1zv/Z5AJUg=
X-Received: by 2002:a17:906:180e:b0:7a2:6d38:1085 with SMTP id
 v14-20020a170906180e00b007a26d381085mr64243377eje.114.1670870717266; Mon, 12
 Dec 2022 10:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20221208185703.2681797-1-andrii@kernel.org> <20221208185703.2681797-4-andrii@kernel.org>
 <5452514a9cf33315d5c179b8494ddd3e7eac2228.camel@gmail.com>
In-Reply-To: <5452514a9cf33315d5c179b8494ddd3e7eac2228.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Dec 2022 10:45:04 -0800
Message-ID: <CAEf4BzaDXg=iz8+zLiPxd=6qAWGDndpCyMt94QSWjAFu_bXY0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] selftests/bpf: add non-standardly sized enum
 tests for btf_dump
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        =?UTF-8?Q?Per_Sundstr=C3=B6m_XP?= <per.xp.sundstrom@ericsson.com>
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

On Fri, Dec 9, 2022 at 9:32 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2022-12-08 at 10:57 -0800, Andrii Nakryiko wrote:
> > Add few custom enum definitions testing mode(byte) and mode(word)
> > attributes.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../bpf/progs/btf_dump_test_case_syntax.c     | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> > index 4ee4748133fe..26fffb02ed10 100644
> > --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> > +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> > @@ -25,6 +25,39 @@ typedef enum {
> >       H = 2,
> >  } e3_t;
> >
> > +/* ----- START-EXPECTED-OUTPUT ----- */
> > +/*
> > + *enum e_byte {
> > + *   EBYTE_1 = 0,
> > + *   EBYTE_2 = 1,
> > + *} __attribute__((mode(byte)));
> > + *
> > + */
> > +/* ----- END-EXPECTED-OUTPUT ----- */
> > +enum e_byte {
> > +     EBYTE_1,
> > +     EBYTE_2,
> > +} __attribute__((mode(byte)));
> > +
> > +/* ----- START-EXPECTED-OUTPUT ----- */
> > +/*
> > + *enum e_word {
> > + *   EWORD_1 = 0LL,
> > + *   EWORD_2 = 1LL,
> > + *} __attribute__((mode(word)));
> > + *
> > + */
> > +/* ----- END-EXPECTED-OUTPUT ----- */
> > +enum e_word {
> > +     EWORD_1,
> > +     EWORD_2,
> > +} __attribute__((mode(word))); /* force to use 8-byte backing for this enum */
> > +
> > +/* ----- START-EXPECTED-OUTPUT ----- */
> > +enum e_big {
> > +     EBIG_1 = 1000000000000ULL,
> > +};
> > +
> >  typedef int int_t;
> >
>
> Something is off with this test, when executed on my little-endian
> machine the output looks as follows:
>
> # ./test_progs -n 23/1
> --- -   2022-12-09 17:22:03.412602033 +0000
> +++ /tmp/btf_dump_test_case_syntax.output.Z28uhX        2022-12-09 17:22:03.403945082 +0000
> @@ -23,13 +23,13 @@
>  } __attribute__((mode(byte)));
>
>  enum e_word {
> -       EWORD_1 = 0LL,
> -       EWORD_2 = 1LL,
> +       EWORD_1 = 0,
> +       EWORD_2 = 1,
>  } __attribute__((mode(word)));
>
>  enum e_big {
> -       EBIG_1 = 1000000000000ULL,
> -};
> +       EBIG_1 = 3567587328,
> +} __attribute__((mode(word)));
>

You seem to have too old Clang which doesn't emit ENUM64 types, try upgrading?


> But this is not related to your changes, here is a raw dump:
>
> $ bpftool btf dump file ./btf_dump_test_case_syntax.bpf.o
>
> [10] ENUM 'e_big' encoding=UNSIGNED size=8 vlen=1
>         'EBIG_1' val=3567587328
>
> >  typedef volatile const int * volatile const crazy_ptr_t;
> > @@ -224,6 +257,9 @@ struct root_struct {
> >       enum e2 _2;
> >       e2_t _2_1;
> >       e3_t _2_2;
> > +     enum e_byte _100;
> > +     enum e_word _101;
> > +     enum e_big _102;
> >       struct struct_w_typedefs _3;
> >       anon_struct_t _7;
> >       struct struct_fwd *_8;
>
