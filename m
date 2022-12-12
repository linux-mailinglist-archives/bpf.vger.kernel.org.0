Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9964A78C
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 19:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiLLSvL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 13:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiLLSuj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 13:50:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2626A17E33
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 10:48:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g7so976282lfv.5
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 10:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UIiuINHe0M/A5EkSLmu4Kak3lyaqm1Xt57biWxlZznM=;
        b=RGH5B+btpWv3yzhjUk93Z0imZESjK8RMNofQFRyak+3eQtsW0KysgJoHvV9fUTYsPV
         v5jKq0JyB3mO/C9YzJOM5ptEtMUsaWQlRbPyzvvKj9oYDvkz8ivlfPfwRPNAhIuCizRq
         RzV6aWGn4NjZWu+iGo+46JytdKrPE9+KzKPQxYCEuRsP7/7mOqup9sQSX5NScEjeecfO
         dNYcXmOTYfDeGhYttj9g8lBqCrgranIBvKihEIUHB3sYKu292RCsLLnWkh5Bs1dUFZSS
         qzGjmh3iisnsT9hU51Ne/ylLoHBPws5QlksY0SAX78R8XAZMmAZgKcmB/dRY7Lc9gbP8
         oKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIiuINHe0M/A5EkSLmu4Kak3lyaqm1Xt57biWxlZznM=;
        b=wKYdGhW5k/aa4ak7poVfV1sHipEPmxDhcdkOI48kppstlI5EeMtT32UCJdbj822C6D
         bHdmfvfAzJeBy4hAAQjqrlbyDV/5bcuftvrnz26BvGEvRuTLEfGksbsFy35GxoY3pC1D
         /aoJimQlnRA6RR4rihDavM6ehUsy/02NUZBUl9gPt4brQdxVDft218fK4VEehT6C7837
         pW9lxHowJaiOkZ7CicT/mq1T+Z1pib5At2zLOTYqbgnWLdIyG9c4qwQjiTvMBcZbtrJL
         OJ4tKy7kLEenYwqNnmCGqh8nzCeVbefdHmS5IuTkhS4KZLCD0qmynENG4QEPiic4uxLo
         aogQ==
X-Gm-Message-State: ANoB5pmXrWJpMg2qLOeZ1GDQFH81kQLT0/G71CDUXbYoReddxfg6fChN
        dx/JXplLdCSL0shtURXN+zk=
X-Google-Smtp-Source: AA0mqf6LJxWEsa/rux0Li15zoJHjeeVhFz6E7QImRfvXUSX1wkY/0myINBnVKBI5eQOorisALZFoCQ==
X-Received: by 2002:a05:6512:10cd:b0:4b6:ea92:69d9 with SMTP id k13-20020a05651210cd00b004b6ea9269d9mr1896746lfg.61.1670870910125;
        Mon, 12 Dec 2022 10:48:30 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id q11-20020a056512210b00b004b4bab7d5a9sm66081lfr.46.2022.12.12.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:48:29 -0800 (PST)
Message-ID: <503c16e0f6ae319d33ef662406027151dba3222d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] selftests/bpf: add non-standardly sized
 enum tests for btf_dump
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Per =?ISO-8859-1?Q?Sundstr=F6m?= XP 
        <per.xp.sundstrom@ericsson.com>
Date:   Mon, 12 Dec 2022 20:48:28 +0200
In-Reply-To: <CAEf4BzaDXg=iz8+zLiPxd=6qAWGDndpCyMt94QSWjAFu_bXY0w@mail.gmail.com>
References: <20221208185703.2681797-1-andrii@kernel.org>
         <20221208185703.2681797-4-andrii@kernel.org>
         <5452514a9cf33315d5c179b8494ddd3e7eac2228.camel@gmail.com>
         <CAEf4BzaDXg=iz8+zLiPxd=6qAWGDndpCyMt94QSWjAFu_bXY0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-12-12 at 10:45 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 9, 2022 at 9:32 AM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > On Thu, 2022-12-08 at 10:57 -0800, Andrii Nakryiko wrote:
> > > Add few custom enum definitions testing mode(byte) and mode(word)
> > > attributes.
> > >=20
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  .../bpf/progs/btf_dump_test_case_syntax.c     | 36 +++++++++++++++++=
++
> > >  1 file changed, 36 insertions(+)
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syn=
tax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> > > index 4ee4748133fe..26fffb02ed10 100644
> > > --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> > > +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> > > @@ -25,6 +25,39 @@ typedef enum {
> > >       H =3D 2,
> > >  } e3_t;
> > >=20
> > > +/* ----- START-EXPECTED-OUTPUT ----- */
> > > +/*
> > > + *enum e_byte {
> > > + *   EBYTE_1 =3D 0,
> > > + *   EBYTE_2 =3D 1,
> > > + *} __attribute__((mode(byte)));
> > > + *
> > > + */
> > > +/* ----- END-EXPECTED-OUTPUT ----- */
> > > +enum e_byte {
> > > +     EBYTE_1,
> > > +     EBYTE_2,
> > > +} __attribute__((mode(byte)));
> > > +
> > > +/* ----- START-EXPECTED-OUTPUT ----- */
> > > +/*
> > > + *enum e_word {
> > > + *   EWORD_1 =3D 0LL,
> > > + *   EWORD_2 =3D 1LL,
> > > + *} __attribute__((mode(word)));
> > > + *
> > > + */
> > > +/* ----- END-EXPECTED-OUTPUT ----- */
> > > +enum e_word {
> > > +     EWORD_1,
> > > +     EWORD_2,
> > > +} __attribute__((mode(word))); /* force to use 8-byte backing for th=
is enum */
> > > +
> > > +/* ----- START-EXPECTED-OUTPUT ----- */
> > > +enum e_big {
> > > +     EBIG_1 =3D 1000000000000ULL,
> > > +};
> > > +
> > >  typedef int int_t;
> > >=20
> >=20
> > Something is off with this test, when executed on my little-endian
> > machine the output looks as follows:
> >=20
> > # ./test_progs -n 23/1
> > --- -   2022-12-09 17:22:03.412602033 +0000
> > +++ /tmp/btf_dump_test_case_syntax.output.Z28uhX        2022-12-09 17:2=
2:03.403945082 +0000
> > @@ -23,13 +23,13 @@
> >  } __attribute__((mode(byte)));
> >=20
> >  enum e_word {
> > -       EWORD_1 =3D 0LL,
> > -       EWORD_2 =3D 1LL,
> > +       EWORD_1 =3D 0,
> > +       EWORD_2 =3D 1,
> >  } __attribute__((mode(word)));
> >=20
> >  enum e_big {
> > -       EBIG_1 =3D 1000000000000ULL,
> > -};
> > +       EBIG_1 =3D 3567587328,
> > +} __attribute__((mode(word)));
> >=20
>=20
> You seem to have too old Clang which doesn't emit ENUM64 types, try upgra=
ding?

My apologies, you are correct.

>=20
>=20
> > But this is not related to your changes, here is a raw dump:
> >=20
> > $ bpftool btf dump file ./btf_dump_test_case_syntax.bpf.o
> >=20
> > [10] ENUM 'e_big' encoding=3DUNSIGNED size=3D8 vlen=3D1
> >         'EBIG_1' val=3D3567587328
> >=20
> > >  typedef volatile const int * volatile const crazy_ptr_t;
> > > @@ -224,6 +257,9 @@ struct root_struct {
> > >       enum e2 _2;
> > >       e2_t _2_1;
> > >       e3_t _2_2;
> > > +     enum e_byte _100;
> > > +     enum e_word _101;
> > > +     enum e_big _102;
> > >       struct struct_w_typedefs _3;
> > >       anon_struct_t _7;
> > >       struct struct_fwd *_8;
> >=20

