Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1390B63E707
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 02:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLABT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 20:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLABT3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 20:19:29 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F93489301
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:19:28 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ha10so742875ejb.3
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSUxnqopPiV9+rRAxzbdZtFwd+GpjboWzAf6D3PexQ0=;
        b=phr37tUVyax1zarYT5MWSHGrrn0sIWCPSyoOzuuXfPijT4jd7zDAb7dNVeBh9nG6V1
         +i5Nht14TCWbnwmftWH7jj4CEjN/aX2VS0a5tOYcxyHU5gInyzJHj6LeiYEJl9oeysnU
         mcN+2QQmCHjHIvGQnrygRmzrgpt0ILr8ZcynIxlEjz81CQelBqrR7Ow27olJ1X9KWqA9
         +Wo2BnV9mDfrmCs91MkMbcq7iswKDF7kdOx7PIpfsHnvNp+0ZO3QSWdp+V8+C9qa8Q8s
         OAkP5OxYdft9fw9vkET0InzZhUNpCX9ngl+OPg56bragffqN+wJCBeNkssu/Jf8K/5Gu
         zNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSUxnqopPiV9+rRAxzbdZtFwd+GpjboWzAf6D3PexQ0=;
        b=6DiiMkCGP7Um6DtfnE+sPfej9AazqecsgeD0TjDDNk5PQ2EBFQdygKmmdqR6IBEKOK
         ituIDUH8DUFTMGVOtQ1VOAPSynrihmxGXIhjDstJQ8yF8m4yWWGirtY9vK0g+l+5L6f2
         tVPhNdTj+IP5yaXu9tockqRpgwqBI0eT9Zo2YdiVKrgIP0mBPOs+P98H+ycnp9WzN9eh
         QCzbYLUgHsaSmGo21UYHdBM1L/nUiW2w6XTtqsWOqsWMKqVc68vCQUkHBJLuSqexTG9j
         w5hL35OcrFBL3zzCo5+EK88ouflH1NcbBt7oyuDIt02chjTv39vE2kE398z5e2/hBTkr
         zkBw==
X-Gm-Message-State: ANoB5pk2hrdw9hiwflsNCDjTZA42NAXs6YMoOQv6VOx47vB7oIqw8TEQ
        tYCQxdZ23L6+D0AjWdY0nRseky7RGlxDh4DBw3w=
X-Google-Smtp-Source: AA0mqf7vU2zBUvrg+VCETk9o0b7aS6TcbmwY4ssJaSPdJ3ml8OEG/Nasgwo0ina/93BzjFkqEkABgLykQnjxh2A1q+o=
X-Received: by 2002:a17:906:414c:b0:7a9:ecc1:2bd2 with SMTP id
 l12-20020a170906414c00b007a9ecc12bd2mr42589881ejk.545.1669857566626; Wed, 30
 Nov 2022 17:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20221130144240.603803-1-toke@redhat.com> <20221130144240.603803-2-toke@redhat.com>
 <CAEf4BzaXbNkx85pBAB=gSshQvdGySkuZzw+HJ9KmDDA1JuheNQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaXbNkx85pBAB=gSshQvdGySkuZzw+HJ9KmDDA1JuheNQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 17:19:14 -0800
Message-ID: <CAEf4Bzb+Vg0QGb40f2z4UrhNhzcH6sEvzoVjvvM=uVHXFRchpw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add local definition of enum
 nf_nat_manip_type to bpf_nf test
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jiri Benc <jbenc@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 30, 2022 at 5:18 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 30, 2022 at 6:42 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
> >
> > The bpf_nf selftest calls the bpf_ct_set_nat_info() kfunc, which takes =
a
> > parameter of type enum nf_nat_manip_type. However, if the nf_nat code i=
s
> > compiled as a module, that enum is not defined in vmlinux BTF, and
> > compilation of the selftest fails.
> >
> > A previous patch suggested just hard-coding the enum values:
> >
> > https://lore.kernel.org/r/tencent_4C0B445E0305A18FACA04B4A959B57835107@=
qq.com
> >
> > However, this doesn't work as the compiler then complains about an
> > incomplete type definition in the function prototype. Instead, just add=
 a
> > local definition of the enum to the selftest code.
> >
> > Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info =
kfunc")
> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > ---
> >  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/te=
sting/selftests/bpf/progs/test_bpf_nf.c
> > index 227e85e85dda..6350d11ec6f6 100644
> > --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > @@ -43,6 +43,11 @@ struct bpf_ct_opts___local {
> >         u8 reserved[3];
> >  } __attribute__((preserve_access_index));
> >
> > +enum nf_nat_manip_type {
> > +       NF_NAT_MANIP_SRC,
> > +       NF_NAT_MANIP_DST
> > +};
> > +
>
> and enum redefinition error if vmlinux.h already defines it?...


... which is apparently proven by our CI already:

  [0] https://github.com/kernel-patches/bpf/actions/runs/3584446939/jobs/60=
31141757

>
> >  struct nf_conn *bpf_xdp_ct_alloc(struct xdp_md *, struct bpf_sock_tupl=
e *, u32,
> >                                  struct bpf_ct_opts___local *, u32) __k=
sym;
> >  struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *, struct bpf_sock_tup=
le *, u32,
> > --
> > 2.38.1
> >
