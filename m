Return-Path: <bpf+bounces-2204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458F5728F33
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 07:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CA81C210B0
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 05:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B1615AF;
	Fri,  9 Jun 2023 05:03:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CDF15AA
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 05:03:09 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7E1984
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 22:03:07 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-78676ca8435so1348028241.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 22:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686286986; x=1688878986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6pASMRN4WTirzlCxKRkgmVLpJGOCKaypkG/BDsQ77M=;
        b=QzUI9y6elcnKiew5JNdTTsUd0bGzOzWZtZG8xUUTuzfk/F3D8MLoYTBTfG/8jDjPCJ
         2dhSFb+7NsrfV7tg0vGckyCCSY/BKjb1UBFv9J75wxS4PlTIMVkBwim6II6FuJpFYIHG
         KBi0vmjVdms6w8z/EziTW9Wq+Zb2G5q/ZJtUv4cnkJfJ8OkGenk/zN6ckVQBV5jpoVYR
         UBxiDWYkLO3XhWZ7YZgCwgWvgMazGc+8yVhG8umpulUe8N3wqeMfLsUo2gFA9vxrqfVg
         RKsourVc8g2yXXLfU50l0wClda3hZbQWmt5NQkxjdbCwzrfc7LezPD732Wz4O7ygYCL4
         kRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686286986; x=1688878986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6pASMRN4WTirzlCxKRkgmVLpJGOCKaypkG/BDsQ77M=;
        b=UanEDSIRBtTflMRY/yTVPqmpUfh5zAo9lctSb1NO0f4Pb02GUCAf3uEMou8r4ICWUk
         cFV0JSqAp0QQFPGiM9YIvGiBoMzb2x90/mS94H3GVSZI5eRwgdOP2B9gq60j9S8NitAC
         guNyLijjS5p0rh4StX5OBmKVuS/Dnsp0Mi1WEXdOfgF9EbT82qEFV+lvdUi4/N07pEJx
         1J5Nixb+vJAGKNadD07V322jDvbGdpzU1XkxFeRH2dTP1pvGMpRMRYW6wOd/sg7ClNQ1
         RB//TwRDcMFg7mY2cEFw6U5TAdTsrgea4IJu8WX5G0t8aNOzyB+lr0zl/fegSKHynw8o
         oJvw==
X-Gm-Message-State: AC+VfDydfbRIUxowqJZrDrw3dsoTJTdWXHgy9fewOQp5QfN88FiO9XoK
	V/0m7cOHlQoqfS6KJ3CctbIbaquMFUdufkDpolAeyN5EJWjzKg==
X-Google-Smtp-Source: ACHHUZ4bhI8i3eSfuFEMEApe9N6gOSqQwt12rO9jtXE0a62spQhBSTtV0jSruVTW4Ev6VWfM4HZgw0CDLue44CbXFtM=
X-Received: by 2002:a05:6102:c04:b0:43b:4f2e:359 with SMTP id
 x4-20020a0561020c0400b0043b4f2e0359mr1794994vss.3.1686286986344; Thu, 08 Jun
 2023 22:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFmV8NeH2zLhSY1RMos18OMEnU81ieCMG0aNtN14BGh_Y7Nzwg@mail.gmail.com>
 <4146a048-2838-cd2a-59f1-05369add7e05@meta.com>
In-Reply-To: <4146a048-2838-cd2a-59f1-05369add7e05@meta.com>
From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Date: Fri, 9 Jun 2023 13:02:55 +0800
Message-ID: <CAFmV8Ndwh3KZZHqSmTv0uk=bmLb8YVsfWxRz+1CXBPN3aAfNmA@mail.gmail.com>
Subject: Re: [BUG] optimizations for branch cause bpf verification to fail
To: Yonghong Song <yhs@meta.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 5:26=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 6/8/23 12:52 PM, Zhongqiu Duan wrote:
> > Hello,  everyone.
> >
> > Recently, I've been doing some work using eBPF techniques. A situation =
was
> > encountered in which a program was rejected by the verifier.
> >
> > Iterate over different maps under different conditions. It should be a =
good idea
> > to use map-of-maps when there are lots of maps. I use if cond for a qui=
ck test.
> >
> > It looks like this:
> >
> > int foo(struct xdp_md *ctx)
> > {
> >     void *data_end =3D (void *)(long)ctx->data_end;
> >     void *data =3D (void *)(long)ctx->data;
> >     struct callback_ctx cb_data;
> >
> >     cb_data.output =3D 0;
> >
> >     if (data_end - data > 1024) {
> >         bpf_for_each_map_elem(&map1, cb, &cb_data, 0);
> >     } else {
> >         bpf_for_each_map_elem(&map2, cb, &cb_data, 0);
> >     }
> >
> >     if (cb_data.output)
> >         return XDP_DROP;
> >
> >     return XDP_PASS;
> > }
> >
> > Compile by clang-15 with optimization level O2:
> >
> > 0000000000000000 <foo>:
> > ;     void *data =3D (void *)(long)ctx->data;
> > 0:       61 12 00 00 00 00 00 00 r2 =3D *(u32 *)(r1 + 0)
> > ;     void *data_end =3D (void *)(long)ctx->data_end;
> > 1:       61 13 04 00 00 00 00 00 r3 =3D *(u32 *)(r1 + 4)
> > ;     if (data_end - data > 1024) {
> > 2:       1f 23 00 00 00 00 00 00 r3 -=3D r2
> > 3:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0 ll
> > 5:       65 03 02 00 00 04 00 00 if r3 s> 1024 goto +2 <LBB0_2>
> > 6:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0 ll
> > 0000000000000040 <LBB0_2>:
> > 8:       b7 02 00 00 00 00 00 00 r2 =3D 0
> > ;     cb_data.output =3D 0;
> > 9:       63 2a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) =3D r2
> > 10:       bf a3 00 00 00 00 00 00 r3 =3D r10
> > 11:       07 03 00 00 f8 ff ff ff r3 +=3D -8
> > 12:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 =3D 0 ll
> > 14:       b7 04 00 00 00 00 00 00 r4 =3D 0
> > 15:       85 00 00 00 a4 00 00 00 call 164
> > 16:       b7 00 00 00 02 00 00 00 r0 =3D 2
> > ;     if (cb_data.output)
> > 17:       61 a1 f8 ff 00 00 00 00 r1 =3D *(u32 *)(r10 - 8)
> > ; }
> > 18:       15 01 01 00 00 00 00 00 if r1 =3D=3D 0 goto +1 <LBB0_4>
> > 19:       b7 00 00 00 01 00 00 00 r0 =3D 1
> > 00000000000000a0 <LBB0_4>:
> > ; }
> > 20:       95 00 00 00 00 00 00 00 exit
> >
> > When loading the prog, the verifier complained "tail_call abusing map_p=
tr".
> > The Compiler's optimizations look fine, so I took a quick look at the c=
ode of
> > the verifier.
> >
> > The function record_func_map called by check_helper_call will ref the c=
urrent
> > map in bpf_insn_aux_data of current insn. After the current branch ends=
,
> > pop stack and enter another branch, but the relevant state is not clear=
ed.
> > This time, record_func_map set BPF_MAP_PTR_POISON as the map state.
> > At the start of set_map_elem_callback_state, poisoned state causing EIN=
VAL.
>
> It will be helpful if you can provide a reproducible test case
> so people can help you to double check whether it is a verifier
> bug/limitation or not. It is hard to decide where is the problem
> in verifier based on the above description.
>

Hi, Yonghong.

The complete example is as follows:

foo.c
---
/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

struct {
   __uint(type, BPF_MAP_TYPE_ARRAY);
   __type(key, __u32);
   __type(value, __u32);
   __uint(max_entries, 1024);
} map1 SEC(".maps"), map2 SEC(".maps");

struct callback_ctx {
   int output;
};

static __u64 cb(struct bpf_map *map, __u32 *key, __u64 *val,
               struct callback_ctx *data)
{
   if (*key =3D=3D 1) {
       data->output =3D 1;
       return 1; /* stop the iteration */
   }
   return 0;
}

SEC("xdp")
int foo(struct xdp_md *ctx)
{
   void *data_end =3D (void *)(long)ctx->data_end;
   void *data =3D (void *)(long)ctx->data;
   struct callback_ctx cb_data;

   cb_data.output =3D 0;

   if (data_end - data > 1024) {
       bpf_for_each_map_elem(&map1, cb, &cb_data, 0);
   } else {
       bpf_for_each_map_elem(&map2, cb, &cb_data, 0);
   }

   if (cb_data.output)
       return XDP_DROP;

   return XDP_PASS;
}

char _license[] SEC("license") =3D "GPL";
---

Environment: linux-6.3 clang-14.0.6 bpftool-7.2.0 libbpf-1.2

Steps to load:

clang -S -target bpf -Wno-visibility -Wall -Wno-unused-value -Wno-pointer-s=
ign \
-Wno-compare-distinct-pointer-types -Werror -O2 -emit-llvm -c -g -o foo.ll =
foo.c
llc -march=3Dbpf -filetype=3Dobj -o foo.o foo.ll
sudo bpftool prog load foo.o /sys/fs/bpf/foo

Regards,
Zhongqiu

> >
> > I'm not very familiar with BPF. If it is designed like this, it is
> > customary to add
> > options on the compiler side to avoid it, then please let me know.
> >
> > Thanks,
> > Zhongqiu
> >

