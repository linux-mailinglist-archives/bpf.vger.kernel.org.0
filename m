Return-Path: <bpf+bounces-4131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB0749214
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 01:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973ED2811B5
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 23:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2215AEE;
	Wed,  5 Jul 2023 23:51:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F29156E0
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 23:51:43 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB5E1732
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 16:51:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso789615e9.2
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688601072; x=1691193072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Mfok7eYQjOsdxIBoOyQ7iQNNU7NAvU/wR5s1OcIivk=;
        b=neieQfegKsP6exQYVcagTnPSm+kg5//f4TQ5IVznHjaA7ckkkCEET12yFvvLcOZHVa
         3QKTu5kKWMv+uofAkVS/d4Jwu3gWmgt1FywripLJLhamgynn1ap2/DsgJFeCFr5ykU1c
         65zA9YG4lAlspwMlGckDARnWJAUMDyd6yHhY827i14MwURMvfOgjw2eYhKW9zm/BZTIz
         v/L0lPPyxxF8KYxNLY3ApsFgv6pMqkgzP6aMKINGEba9qD8OLSG/d3sKyH8kvjdroYC1
         XIXOUoleusJp6Rc7Alk5rXwdfx0MlFSysfKZNHpfeEzEpWe8YIo8dS2z8uv7U5WF6RIu
         bPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688601072; x=1691193072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Mfok7eYQjOsdxIBoOyQ7iQNNU7NAvU/wR5s1OcIivk=;
        b=kdWu7xCKfYrmQvsY5VFp59h99G7hGdnthax5FDHBxVJemOvr8kn/yo78UpI1nZukCG
         RsCWX5kuzKDdfegEJz3vXvYWG94oOyqFm233P4mhXTkm7PrEePjwzgGQJF7nvJ/nZieA
         ZzI/MRFoyu2qrCbxXojEsYhSiVZcIIYKrENuu9++Ca9DU33udHiGh0BQtkjHB5GlbDzI
         127XiGBfZgu1UGDmOe5clNI5aqLL5CEbXPwXsdkbsi3kSeh9Pkc9ZyZ+LTlSMhNfhx4J
         risHXipNPv2UXIbucM8fQNPcDQCzahT4tqo3SJo2nMGhodqx3X4wr72ZUDShhRvfhm+J
         Dyig==
X-Gm-Message-State: ABy/qLbXQ8yRy4nqckFlI/8xuFLRVEJUzZY4qlpr6nl5kjhFM/EOToCv
	avsFv934krW93NKCHDc0mMCqjW8e3xMiZiLpCMc=
X-Google-Smtp-Source: APBJJlGxKubcojUPCCRUbpj6OaaP0CYLlHKIrfubs5kSgIY/t7Nbgwet+UcPwvPTzx6ys6irOJRAYHOhvcot5IuC6SA=
X-Received: by 2002:a1c:ed09:0:b0:3fa:7478:64be with SMTP id
 l9-20020a1ced09000000b003fa747864bemr93093wmh.1.1688601072240; Wed, 05 Jul
 2023 16:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9c636a63-1f3d-442d-9223-96c2dccb9469@moroto.mountain>
 <61cb2c19-5f09-4f0a-baf1-adc69c3031f4@huaweicloud.com> <CAEf4Bzau5eNcLj-Us2VSW1zmCET-=jA5pFZTfhVWeEjGqQ2_Nw@mail.gmail.com>
In-Reply-To: <CAEf4Bzau5eNcLj-Us2VSW1zmCET-=jA5pFZTfhVWeEjGqQ2_Nw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jul 2023 16:51:00 -0700
Message-ID: <CAEf4BzYOktFTv_b4r3H=8U6W6V6rxCxAFOBX4=Up_-BPzrbZ4w@mail.gmail.com>
Subject: Re: [bug report] bpf: Enforce BPF ringbuf size to be the power of 2
To: Hou Tao <houtao@huaweicloud.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, andriin@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 4:49=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 3, 2023 at 6:47=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> w=
rote:
> >
> > Hi,
> >
> > On 6/30/2023 6:35 PM, Dan Carpenter wrote:
> > > Hello Andrii Nakryiko,
> > >
> > > The patch 517bbe1994a3: "bpf: Enforce BPF ringbuf size to be the
> > > power of 2" from Jun 29, 2020, leads to the following Smatch static
> > > checker warning:
> > >
> > >       kernel/bpf/ringbuf.c:198 ringbuf_map_alloc()
> > >       warn: impossible condition '(attr->max_entries > 68719464448)'
> > >
> > > Also Clang warns:
> > >
> > > kernel/bpf/ringbuf.c:198:24: warning: result of comparison of constan=
t
> > > 68719464448 with expression of type '__u32' (aka 'unsigned int') is
> > > always false [-Wtautological-constant-out-of-range-compare]
> > >         if (attr->max_entries > RINGBUF_MAX_DATA_SZ)
> > >             ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
> > >
> > > kernel/bpf/ringbuf.c
> > >     184 static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr=
)
> > >     185 {
> > >     186         struct bpf_ringbuf_map *rb_map;
> > >     187
> > >     188         if (attr->map_flags & ~RINGBUF_CREATE_FLAG_MASK)
> > >     189                 return ERR_PTR(-EINVAL);
> > >     190
> > >     191         if (attr->key_size || attr->value_size ||
> > >     192             !is_power_of_2(attr->max_entries) ||
> > >     193             !PAGE_ALIGNED(attr->max_entries))
> > >     194                 return ERR_PTR(-EINVAL);
> > >     195
> > >     196 #ifdef CONFIG_64BIT
> > >     197         /* on 32-bit arch, it's impossible to overflow record=
's hdr->pgoff */
> > > --> 198         if (attr->max_entries > RINGBUF_MAX_DATA_SZ)
> > >
> > > This check used to be inside bpf_ringbuf_alloc() and it used be:
> > >
> > >       if (data_sz > RINGBUF_MAX_DATA_SZ)
> > >
> > > In that context where data_sz is a size_t the condition and the
> > > #ifdef CONFIG_64BIT made sense but here it doesn't.  Probably just
> > > delete the check.
> > It seems the check before 517bbe1994a3 is only used for future
> > extension. Considering the type of max_entries is u32, I think it is OK
> > to remove the check and the macro definition.
>
> I'm fine removing this, given page size is always at least 4096,
> ringbuf is capable of addressing all 4GBs easily. Hou, will you be
> able to send a patch?
>

Never mind, I see that you already did, thanks! Catching up :)

>
> > >
> > >     199                 return ERR_PTR(-E2BIG);
> > >     200 #endif
> > >     201
> > >     202         rb_map =3D bpf_map_area_alloc(sizeof(*rb_map), NUMA_N=
O_NODE);
> > >     203         if (!rb_map)
> > >     204                 return ERR_PTR(-ENOMEM);
> > >     205
> > >     206         bpf_map_init_from_attr(&rb_map->map, attr);
> > >     207
> > >     208         rb_map->rb =3D bpf_ringbuf_alloc(attr->max_entries, r=
b_map->map.numa_node);
> > >     209         if (!rb_map->rb) {
> > >     210                 bpf_map_area_free(rb_map);
> > >     211                 return ERR_PTR(-ENOMEM);
> > >     212         }
> > >     213
> > >     214         return &rb_map->map;
> > >     215 }
> > >
> > > regards,
> > > dan carpenter
> > >
> > > .
> >
> >

