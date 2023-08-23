Return-Path: <bpf+bounces-8348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BB478547A
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 11:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA9C1C20C70
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42073A956;
	Wed, 23 Aug 2023 09:45:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291BA946
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:45:07 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29DA10E4
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 02:45:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so11124643a12.0
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692783899; x=1693388699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8QtEX/yrqZemUvYdfELzlufdpbCKV3KTmcq7/XaCKF0=;
        b=YSrAE8dXM4XQ6qLhPNoKVQ25stCxDsqT2z16LRgkm9L/I9U/nd4TNjSff8Fyv63WHm
         zaKYvm3kIUjMI0nXRo7m6NkaFbiUXeA/GolysQruOIStUt+aB834XO9rHsVcMM5hvCfE
         b+ZO4OKlzqNwpaiZ9LLWAvrZ80EtmWPd8U7d7j8ongy1jLd149XdHYu7X6rEoiu4LpWB
         8AFOLc0off3E24+LfbL7PZ8VjsIBOf/mepVn67sC8AmIeQk1YZx4f1p6HCBga5b/rpzk
         Bh6u6ZHxL/ItTUSMxj1gkTTgeeCNZVUXN8AWqoQFJtv1OZXLJsjYBiqKQ/wyfUMjbklP
         Hd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692783899; x=1693388699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QtEX/yrqZemUvYdfELzlufdpbCKV3KTmcq7/XaCKF0=;
        b=YpbxDfsnxfUGxJK+TN+L/JRSSqgpUuQQKHHfwHLwmmBghZccCtFmOzZ2cCYi32yL3H
         YgDjh86NT9XxCu5jpYmJSeVmGyE3EVan43fLyc2Hiu7IqipYFnjAuLLY9OQUJZNWgy5R
         7j/EROP7W5hBXjkOTxkUZjhCxog2ugDn6rbLqxMY39NW6u0X46WlQxS6rVd2CUI/L8XC
         LeuGlKK4JNJnvaXi/uY2Wda+D2HpHQbsHd7f8F+xUaEZgc2ZRMwERf3xkU44ZEHQhK3f
         OspvYjGBB0xOSs7g5MGAZYvShgJIZuvsjck2cbr9HfQZf6GdyuVi6kjGdBo5eiQ8A2SN
         jeBg==
X-Gm-Message-State: AOJu0Ywku9ymrW1/rPYrh1IZM3KhbtYpKQ9W/guTAr0fddvwZ3J5kuqG
	9S9FbsGvjQOo/ncA+CbNp/o=
X-Google-Smtp-Source: AGHT+IH+W67lJAluI5cisiDRvu+RXIPJ1upUcfhPGN3J38avdBazsmmeI6yKz90BkwrKcW0BlJFokQ==
X-Received: by 2002:a05:6402:274b:b0:522:c226:34ea with SMTP id z11-20020a056402274b00b00522c22634eamr15458662edd.7.1692783899297;
        Wed, 23 Aug 2023 02:44:59 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i21-20020a05640200d500b00525503fac84sm9173450edu.25.2023.08.23.02.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 02:44:58 -0700 (PDT)
Message-ID: <45af850d8a07305eee252e5aa5014dbe743ca2af.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for
 allow_ptr_leaks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yafang Shao
	 <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Date: Wed, 23 Aug 2023 12:44:57 +0300
In-Reply-To: <CAADnVQJ-BcSfPVL4J8DPA0XXgWtfUSXDzjnNeQvf1Z2SAASQ2g@mail.gmail.com>
References: <20230818083920.3771-1-laoar.shao@gmail.com>
	 <20230818083920.3771-3-laoar.shao@gmail.com>
	 <CAADnVQJ-BcSfPVL4J8DPA0XXgWtfUSXDzjnNeQvf1Z2SAASQ2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-08-21 at 15:45 -0700, Alexei Starovoitov wrote:
[...]
> > diff --git a/tools/testing/selftests/bpf/progs/test_tc_bpf.c b/tools/te=
sting/selftests/bpf/progs/test_tc_bpf.c
> > index d28ca8d..3e0f218 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tc_bpf.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
> > @@ -1,5 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >=20
> > +#include <linux/pkt_cls.h>
> > +#include <linux/ip.h>
> > +#include <linux/if_ether.h>
>=20
> Due to above it fails to compile:
>=20
> In file included from progs/test_tc_bpf.c:4:
> In file included from /usr/include/linux/ip.h:21:
> In file included from /usr/include/asm/byteorder.h:5:
> In file included from /usr/include/linux/byteorder/little_endian.h:13:
> /usr/include/linux/swab.h:136:8: error: unknown type name '__always_inlin=
e'
>   136 | static __always_inline unsigned long __swab(const unsigned long y=
)
>       |        ^
>=20

This is strange, I can compile it no problem. On my system:
/usr/include/linux/swab.h includes /usr/include/linux/stddef.h
which defines __always_inline.

What distro are you using?
I want to try it in chroot to see if we have any issues with test makefiles=
.

