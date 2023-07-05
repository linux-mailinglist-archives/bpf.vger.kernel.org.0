Return-Path: <bpf+bounces-4130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2501F74920D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 01:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D505E2811C9
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 23:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F02F15AEC;
	Wed,  5 Jul 2023 23:49:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA2156E0
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 23:49:52 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8927910F5
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 16:49:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so905815e9.3
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 16:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688600989; x=1691192989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRPuNRvuP1uAseIzUhHNr3Vb/vbtDlRrGC4UsyrQk/A=;
        b=ZPDslEvoBnYvLGO0W0zhBtUqsCQg+U/zN2YCD4tkPDQxCcSzOG5DnjE1t/G+gPH4lC
         XHSZwy7Ul7KXgJxZC1RIUj0dVajK1tibii8Sri7Z2tXtbf8EmTc0ZGHRjEp70aeTi8HQ
         HIS1CYuOPTnkP3tUX1uNm/lulpVRWejO/8eFHuxlE/TlOl906S1mD3VwxkjXf507vath
         pPKPH+QVQoWQirGZJtBUXa9i5cfNyOLatfNNmv9ETJSI/s783Hm9jOjNM5yN6T18Uvph
         4glzE1TGdvlV46f4YKah6jUfNcQsLCzRnkNoq8PmPsKH8Zc56EeDQF2oR8GqjxksiOV6
         AojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688600989; x=1691192989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRPuNRvuP1uAseIzUhHNr3Vb/vbtDlRrGC4UsyrQk/A=;
        b=EzXXjrgZhIpbvtj+zRDbYZ8k/us2I5Odv8eILWQ9vgHXAevh5h0nKfwffFIXucU93/
         czSWVuXmL1vT/sjXio3tZdSwp+rrDH41peGt+hqa1AOdBtGXSLJNlYA0ieyAddNnONcm
         ZXmyG9MVVLFTbAuQShi+ELgdi488W8/ZBPe0o0GAQ51ZVR4I1/+04Xjx7EmPjBxlU7t9
         WpIpOfZieaqrdA43uIwKI1tthBNMKGTEwD9n5Zbu29SllvdVL3pDf5++PLFZ0K5+Cfph
         Yjjhw8hllXFknN/hh9GSyULJENwVH8914AjT6t+M2mzwN55GD5gPRMp7hnW4isGv2wEh
         VMgw==
X-Gm-Message-State: ABy/qLaQ3ZRW2LszzAYCZF6MVyojF8vKB7UfZ+nssOd5qC/duf7p7fO+
	6wlfkewf4l0YNhirbalAkyf184sO7lzrl7bWW6w=
X-Google-Smtp-Source: APBJJlHgiW0I9VE41wFEXeyHIrZXWtMXuFeLoJm3eqwK/LXjME8XcJHWpbbukr/vVJeVNm22s+DZeQhnrdNPZBPPw14=
X-Received: by 2002:a05:600c:220e:b0:3fb:9ea6:7a73 with SMTP id
 z14-20020a05600c220e00b003fb9ea67a73mr100300wml.23.1688600988904; Wed, 05 Jul
 2023 16:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9c636a63-1f3d-442d-9223-96c2dccb9469@moroto.mountain> <61cb2c19-5f09-4f0a-baf1-adc69c3031f4@huaweicloud.com>
In-Reply-To: <61cb2c19-5f09-4f0a-baf1-adc69c3031f4@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jul 2023 16:49:37 -0700
Message-ID: <CAEf4Bzau5eNcLj-Us2VSW1zmCET-=jA5pFZTfhVWeEjGqQ2_Nw@mail.gmail.com>
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

On Mon, Jul 3, 2023 at 6:47=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 6/30/2023 6:35 PM, Dan Carpenter wrote:
> > Hello Andrii Nakryiko,
> >
> > The patch 517bbe1994a3: "bpf: Enforce BPF ringbuf size to be the
> > power of 2" from Jun 29, 2020, leads to the following Smatch static
> > checker warning:
> >
> >       kernel/bpf/ringbuf.c:198 ringbuf_map_alloc()
> >       warn: impossible condition '(attr->max_entries > 68719464448)'
> >
> > Also Clang warns:
> >
> > kernel/bpf/ringbuf.c:198:24: warning: result of comparison of constant
> > 68719464448 with expression of type '__u32' (aka 'unsigned int') is
> > always false [-Wtautological-constant-out-of-range-compare]
> >         if (attr->max_entries > RINGBUF_MAX_DATA_SZ)
> >             ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
> >
> > kernel/bpf/ringbuf.c
> >     184 static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
> >     185 {
> >     186         struct bpf_ringbuf_map *rb_map;
> >     187
> >     188         if (attr->map_flags & ~RINGBUF_CREATE_FLAG_MASK)
> >     189                 return ERR_PTR(-EINVAL);
> >     190
> >     191         if (attr->key_size || attr->value_size ||
> >     192             !is_power_of_2(attr->max_entries) ||
> >     193             !PAGE_ALIGNED(attr->max_entries))
> >     194                 return ERR_PTR(-EINVAL);
> >     195
> >     196 #ifdef CONFIG_64BIT
> >     197         /* on 32-bit arch, it's impossible to overflow record's=
 hdr->pgoff */
> > --> 198         if (attr->max_entries > RINGBUF_MAX_DATA_SZ)
> >
> > This check used to be inside bpf_ringbuf_alloc() and it used be:
> >
> >       if (data_sz > RINGBUF_MAX_DATA_SZ)
> >
> > In that context where data_sz is a size_t the condition and the
> > #ifdef CONFIG_64BIT made sense but here it doesn't.  Probably just
> > delete the check.
> It seems the check before 517bbe1994a3 is only used for future
> extension. Considering the type of max_entries is u32, I think it is OK
> to remove the check and the macro definition.

I'm fine removing this, given page size is always at least 4096,
ringbuf is capable of addressing all 4GBs easily. Hou, will you be
able to send a patch?


> >
> >     199                 return ERR_PTR(-E2BIG);
> >     200 #endif
> >     201
> >     202         rb_map =3D bpf_map_area_alloc(sizeof(*rb_map), NUMA_NO_=
NODE);
> >     203         if (!rb_map)
> >     204                 return ERR_PTR(-ENOMEM);
> >     205
> >     206         bpf_map_init_from_attr(&rb_map->map, attr);
> >     207
> >     208         rb_map->rb =3D bpf_ringbuf_alloc(attr->max_entries, rb_=
map->map.numa_node);
> >     209         if (!rb_map->rb) {
> >     210                 bpf_map_area_free(rb_map);
> >     211                 return ERR_PTR(-ENOMEM);
> >     212         }
> >     213
> >     214         return &rb_map->map;
> >     215 }
> >
> > regards,
> > dan carpenter
> >
> > .
>
>

