Return-Path: <bpf+bounces-4287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687C74A34F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 19:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EAA1C20E01
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 17:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84325BE66;
	Thu,  6 Jul 2023 17:42:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A849460
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:42:35 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A341210F5
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:42:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc587febfso10308595e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688665352; x=1691257352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tBMsdSZRAeT2RYt6RA7mHG2O68RNBhZpjcNxrjBNGUY=;
        b=IT7sRqOlQZEImsrALaQB7cG4zG1RP9Y4mVJ2LdZLpHLMCUzaocUoHucl1jRjTooKwN
         Hdh54OLTDYTGiY8nBj3aNDQa84FG7O89V4NBblqKkz/dODRJniDgaH4hERyLpwGyleRx
         wDpz0MG8P7KXS8goSlJ2Bp1ZeBUbYBASfAN7QEpbDC/ATFjVvA7UX5YdF5s1M23RiIVz
         JODCAJofI/WlBamds/iwQgZkdfHo1xtAA+eCCmVIWTXNrjQLk9+T/gcHnYCJgB+UP3Cb
         XZWmMqUWBRnzerN9ZXxKl7hgPmdQmVDnNN+JhQRBGbsKaLp2UG6aYuPBVtJY1qlXQxvP
         YgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665352; x=1691257352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBMsdSZRAeT2RYt6RA7mHG2O68RNBhZpjcNxrjBNGUY=;
        b=YXCZA3IPlXBDf0MXKNs8B5UOmhkG+UgqEUQfgzf7qcOaWOh7duF+GCqiDrNHJqNim0
         lRzrLCJMgLO/ZneW0oVSzAfCQklZNjx4S2xewDNMfg3IH4Mg7A/C/aVuoFUSsnDvStDm
         wZhLn6s19clM0mqJjdWX8/Zpt3JbJV1T+4zkP3+nu2kIufGzfNQHiG6wKtJQ4ECKwSzy
         RVB1X/XRYgvUVFcQwip4L7PAymGwLBShX9U28X12O9K9gbrVuoPsj13IjCC5PRCZO8wR
         UT9sgiNpHam+Ps2t8f7XkwmNsn1nLT6BczTxYe5R3i/pw8eNqpoKp8eRiu/m+gneYcQu
         ViFA==
X-Gm-Message-State: ABy/qLY9bpXXtFVR34z75cA0xChNgraC5C+rzJ7gEuna6+3Cb3S8o+Q1
	Bn0dEocJLBah7pmyZHpb+Kbhqw==
X-Google-Smtp-Source: APBJJlFIWU5EnXMhICco8eD6LO3mJ6Hk0TrXsXTs/oNiFWYZeU8obldrmzkzt8LbOkEeOAhRpA9FiQ==
X-Received: by 2002:a05:600c:230d:b0:3fb:a616:76b6 with SMTP id 13-20020a05600c230d00b003fba61676b6mr1819706wmo.40.1688665351982;
        Thu, 06 Jul 2023 10:42:31 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id i14-20020adffdce000000b003141f96ed36sm2460670wrs.0.2023.07.06.10.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 10:42:31 -0700 (PDT)
Date: Thu, 6 Jul 2023 17:43:42 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 6/6] selftests/bpf: check that ->elem_count
 is non-zero for the hash map
Message-ID: <ZKb9TjHX3GV35Yol@zh-lab-node-5>
References: <20230705160139.19967-1-aspsk@isovalent.com>
 <20230705160139.19967-7-aspsk@isovalent.com>
 <CAADnVQLZMb3XqJFp8Oaz-83RzVHTV3EwJymKC817ekC57CNMBg@mail.gmail.com>
 <ZKZUpW5QeOviHCne@zh-lab-node-5>
 <CAADnVQJ4-j6bD9vicVi245cRMWijbW=jQhK5ioczBC-7FCi06A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ4-j6bD9vicVi245cRMWijbW=jQhK5ioczBC-7FCi06A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 10:03:30AM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 5, 2023 at 10:42 PM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On Wed, Jul 05, 2023 at 06:26:25PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Jul 5, 2023 at 9:00 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > Previous commits populated the ->elem_count per-cpu pointer for hash maps.
> > > > Check that this pointer is non-NULL in an existing map.
> > > >
> > > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/progs/map_ptr_kern.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > > > index db388f593d0a..d6e234a37ccb 100644
> > > > --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > > > +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > > > @@ -33,6 +33,7 @@ struct bpf_map {
> > > >         __u32 value_size;
> > > >         __u32 max_entries;
> > > >         __u32 id;
> > > > +       __s64 *elem_count;
> > > >  } __attribute__((preserve_access_index));
> > > >
> > > >  static inline int check_bpf_map_fields(struct bpf_map *map, __u32 key_size,
> > > > @@ -111,6 +112,8 @@ static inline int check_hash(void)
> > > >
> > > >         VERIFY(check_default_noinline(&hash->map, map));
> > > >
> > > > +       VERIFY(map->elem_count != NULL);
> > > > +
> > >
> > > imo that's worse than no test.
> > > Just use kfunc here and get the real count?
> >
> > Then, as I mentioned in the previous version, I will have to teach kfuncs to
> > recognize const_ptr_to_map args just for the sake of this selftest, while we
> > already testing all functionality in the new selftest for test_maps. So I would
> > just omit this one. Or am I missing something?
> 
> 
> Don't you want to do:
>  val = bpf_map_lookup_elem(map, ...);
>  cnt = bpf_map_sum_elem_count(map);
> 
> and that's the main use case ?

Not sure I understand what this ^ use case is...

Our primary use case is to [periodically] get the number of elements from the
user space. We can do this using an iterator as you've suggested and what is
tested in the added selftest.

> So teaching the verifier to understand that const_ptr_to_map matches
> BTF 'struct bpf_map *' is essential ?

