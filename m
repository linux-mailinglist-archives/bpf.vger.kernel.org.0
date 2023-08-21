Return-Path: <bpf+bounces-8198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8950978367B
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 01:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431D8280FBD
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 23:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4241B7FB;
	Mon, 21 Aug 2023 23:49:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C71ADF9
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 23:49:39 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8313D
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 16:49:38 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so60550811fa.3
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 16:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692661776; x=1693266576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3EavEzj3e59D7tjoHcGgEseGQ9kSkyP5bppQBdRQZ4=;
        b=kW4kPTZPDn9huWkxTn8nfI3cY5NySy2f+pVvdmWJwI/GNIf2R4/XhNLQG4Mhb5WpKe
         59Yh03QNSnEDXZ6MobWioVEhhJ2mLvhadiGZOaHf1vpTxnwfY8dWZvAY8u4Wmsf9h6v7
         EYT/ePmzo9OwVD9dM1UMHsZnQfbNogLWjxV5MVVvqHkKWyIEOuAEtl3y+KFgDGU/CSag
         1n7GUH4u0towcxxSxFVz7P6oY5U/xRrzTjLRjeQTWPamkPOBuwXQu44uOKs6+2m5W8I2
         nZDW2FDrqdawA8+40CLUcGLAR7EobWFE9f5frHiFbCLhi6BjOoMpa7m5//fQHNfV2sXz
         /1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692661776; x=1693266576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3EavEzj3e59D7tjoHcGgEseGQ9kSkyP5bppQBdRQZ4=;
        b=L/6k7+bB6CQS8YXgOAnNrQkBCYQTZ0FZbazIE3w1l2kgFWsgQksFnmcdxYEk6E8YFT
         BxkpFG7KjhrV7Fo/odkzo42Z7afv5RsqiMcu1nqImmtbOM21rZSdbZvOtZNAYP1OLmU9
         y01fFZWPKoEkI/GHZuIP9eQmhLFy+4CfbyNtgBaMejaZQfR6LAn4kciZFKauHr6ZsUSH
         gKVlxirUogwtkF+z5gGfARMlMcoRpxMw01qf3wh8w5JPHJPehwiA1/2KVh3dbEXC/YC5
         /0MbJEsO1j7Tn4Lv4IjBfXpalST4Eh9kViLxRrrY/1oY5VDf6lNgiRlVbqvNoFaIHWFr
         QLCQ==
X-Gm-Message-State: AOJu0YxDX7HJ56kyGIIAwZEG3vD/GYJJ5HWQ0LornqW3jtaxROEz5Oox
	A4gVRfFRaPBkp4dJ1+lOcfoyHKkAzIOB4ux6cYI=
X-Google-Smtp-Source: AGHT+IFVZcluWg+bgFMlGBkkArxxOO1AdH1dpaaFP9fY7ZQWE2bWbSlzyK3Ecrc3qxpmZvWd3lJxqgeeevZggzO+GVo=
X-Received: by 2002:a2e:a288:0:b0:2b9:aa4d:3719 with SMTP id
 k8-20020a2ea288000000b002b9aa4d3719mr5752598lja.12.1692661776137; Mon, 21 Aug
 2023 16:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com> <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
 <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com> <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com>
In-Reply-To: <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Aug 2023 16:49:24 -0700
Message-ID: <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
Subject: Re: Question: Is it OK to assume the address of bpf_dynptr_kern will
 be 8-bytes aligned and reuse the lowest bits to save extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 3:39=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/18/2023 7:00 AM, Alexei Starovoitov wrote:
> > On Wed, Aug 16, 2023 at 11:35=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >> ping ?
> > Sorry for the delay. I've been on PTO.
> >
> >> On 8/3/2023 9:28 PM, Hou Tao wrote:
> >>> On 8/3/2023 9:19 PM, Hou Tao wrote:
> >>>> Hi,
> >>>>
> >>>> I am preparing for qp-trie v4, but I need some help on how to suppor=
t
> >>>> variable-sized key in bpf syscall. The implementation of qp-trie nee=
ds
> >>>> to distinguish between dynptr key from bpf program and variable-size=
d
> >>>> key from bpf syscall. In v3, I added a new dynptr type:
> >>>> BPF_DYNPTR_TYPE_USER for variable-sized key from bpf syscall [0], so
> >>>> both bpf program and bpf syscall will use the same type to represent=
 the
> >>>> variable-sized key, but Andrii thought ptr+size tuple was simpler an=
d
> >>>> would be enough for user APIs, so in v4, the type of key for bpf pro=
gram
> >>>> and syscall will be different. One way to handle that is to add a ne=
w
> >>>> parameter in .map_lookup_elem()/.map_delete_elem()/.map_update_elem(=
) to
> >>>> tell whether the key comes from bpf program or syscall or introduce =
new
> >>>> APIs in bpf_map_ops for variable-sized key related syscall, but I th=
ink
> >>>> it will introduce too much churn. Considering that the size of
> >>>> bpf_dynptr_kern is 8-bytes aligned, so I think maybe I could reuse t=
he
> >>>> lowest 1-bit of key pointer to tell qp-trie whether or not it is a
> >>>> bpf_dynptr_kern or a variable-sized key pointer from syscall. For
> >>>> bpf_dynptr_kern, because it is 8B-aligned, so its lowest bit must be=
 0,
> >>>> and for variable-sized key from syscall, I could allocated a 4B-alig=
ned
> >>>> pointer and setting the lowest bit as 1, so qp-trie can distinguish
> >>>> between these two types of pointer. The question is that I am not su=
re
> >>>> whether the idea above is a good one or not. Does it sound fragile ?=
 Or
> >>>> is there any better way to handle that ?
> > Let's avoid bit hacks. They're not extensible and should be used
> > only in cases where performance matters a lot or memory constraints are=
 extreme.
> I see. Neither the performance reason nor the memory limitation fit here.
> >
> > ptr/sz tuple from syscall side sounds the simplest.
> > I agree with Andrii exposing the dynptr concept to user space
> > and especially as part of syscall is unnecessary.
> > We already have LPM as a precedent. Maybe we can do the same here?
> > No need to add new sys_bpf commands.
>
> There is no need to add new sys_bpf commands. We can extend bpf_attr to
> support variable-sized key in qp-trie for bpf syscall. The probem is the
> keys from bpf syscall and bpf program are different: bpf syscall uses
> ptr+size tuple and bpf program uses dynptr, but the APIs in bpf_map_ops
> only uses a pointer to represent the key, so qp-trie can not distinguish
> between the keys from bpf syscall and bpf program. In qp-trie v1, the
> key of qp-trie was similar with LPM-trie: both the syscall and program
> used the same key format. But the key format for bpf program changed to
> dynptr in qp-trie v2 according to the suggestion from Andrii. I think it
> is also a bad ideal to go back to v1 again.
>
> >
> > If the existing bpf_map_lookup_elem() helper doesn't fit qp-tree we can
> > use new kfuncs from bpf prog and LPM-like map accessors from syscall.
>
> It is a feasible solution, but it will make qp-trie be different with
> other map types. I will try to extend the APIs in bpf_map_ops first to
> see how much churns it may introduce.

you mean you want to try to dynamically adapt bpf_map_lookup_elem()
to consider 'void *key' as a pointer to dynptr for bpf prog and
lpm-like tuple for syscall?
I'm afraid the verifier changes will be messy, since PTR_TO_MAP_KEY is
quite special.
__bpf_kfunc void *bpf_qptree_lookup(const bpf_map *map, const struct
bpf_dynptr_kern *key, ...);
will be so much easier to add.

