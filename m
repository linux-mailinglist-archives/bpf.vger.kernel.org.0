Return-Path: <bpf+bounces-8672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1D4788EBD
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA5828185C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E0107A4;
	Fri, 25 Aug 2023 18:33:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72BA256A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 18:33:56 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34646210A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:33:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a4818db4aso1702305a12.2
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692988433; x=1693593233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTFnopBhnyJMr4rPsdfYrwnmTYs6TdUvC5QHjsZ9bIQ=;
        b=dc+kPd8wGxZU/6Uc6ke8ozahadl+wJ6QtTJsdw6uPF22+oL8K9ortnkM9XTACONf+d
         u9hEnJSYh1F1QESO9N8770XhqyYFX5bP52tq3nqbhjgoVN6Eu0wFo0Z8ziw4zoYCnzx+
         w+B2Itj3dz25WD9DbmCjhuwqR/plI6QO3xGqfUI/bUiJ+dBsDlZimii5v3hp40UR/pcI
         SwjAaf7CF2tpJGSZp/3XeKh5QZTY15MX8zxZehe9s9IvSQ13fbpCwbVT7Z7FkCr4tH//
         Au9hLxBH5FLOgLq0LvAVn7EFXqVewU/pEdJ2gstp2mikq5S6HGSsuB9LdZqY+5GBM0AR
         8SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692988433; x=1693593233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTFnopBhnyJMr4rPsdfYrwnmTYs6TdUvC5QHjsZ9bIQ=;
        b=Cs1qGwCKWCcCC+6je35KcnH7OwcTnuf7y1r5KhaR+zGMd58qFNIwGu717PlNT2+hHu
         8h2O454NOjx4U/vXHDXBf0pHL2nZ536AzgCbtwuKxaiMmKtYeNtrgbNwjmjAgyhAo5H8
         yqiIcNQaj5dvQWyfg9+0DpJTSI8CKHtt9suTy7P9WKonhMwn/Fmnpn1p1x49uZkGv/k5
         i2L337LvxkTb2f+bTygb0IWNrsxEz1HDiXOexWXVZXq7rzb/KU76mitC/uKJd1wbqZJ8
         0E5YGBT2+sK0AhO6mqpepGZOxV3wVhawChfldleJAkPeN2DNDoheTuXxS3gkZD8fxP+r
         R5fA==
X-Gm-Message-State: AOJu0Yxr3tUuXhvTbzZPB2O0kZzmiJP4bMgzqVBvUkY5+lmziXzJrLrj
	EvMax8tWE7qoVAfgfUQ4Vvr2qrDWkG6H4U6NHQ5AwNwo
X-Google-Smtp-Source: AGHT+IHe0gVq3PIrUAKO1ume/LH8liRAGhcwB/54ofjTBl5LfEolnbsyrOYyIP5twRCvVYnx/CQMPGydDYplJFQHjvA=
X-Received: by 2002:a05:6402:330:b0:522:3855:7ec5 with SMTP id
 q16-20020a056402033000b0052238557ec5mr16137327edw.10.1692988433550; Fri, 25
 Aug 2023 11:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com> <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
 <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com>
 <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com> <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
 <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com> <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
 <57e3df33-f49b-5c8b-82b3-3a8c63a9b37e@huaweicloud.com> <CAADnVQ+2JoqJJvinPvKA+4Nm8F9rTrpXBdq4SmbTeq_9bw=mwg@mail.gmail.com>
 <a3eb33c4-b84f-5386-291c-c43d77b39c48@huaweicloud.com>
In-Reply-To: <a3eb33c4-b84f-5386-291c-c43d77b39c48@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 11:33:42 -0700
Message-ID: <CAEf4BzZPno3m+G0v8ybxb=SMNbmqofCa5aa_Ukhh2OnZO9NxXw@mail.gmail.com>
Subject: Re: Question: Is it OK to assume the address of bpf_dynptr_kern will
 be 8-bytes aligned and reuse the lowest bits to save extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 6:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/22/2023 11:25 AM, Alexei Starovoitov wrote:
> > On Mon, Aug 21, 2023 at 6:46=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> On 8/22/2023 8:58 AM, Alexei Starovoitov wrote:
> >>> On Mon, Aug 21, 2023 at 5:55=E2=80=AFPM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> >>>> Hi,
> >>>>
> >>>> On 8/22/2023 7:49 AM, Alexei Starovoitov wrote:
> >>>>> On Sat, Aug 19, 2023 at 3:39=E2=80=AFAM Hou Tao <houtao@huaweicloud=
.com> wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 8/18/2023 7:00 AM, Alexei Starovoitov wrote:
> >>>>>>> On Wed, Aug 16, 2023 at 11:35=E2=80=AFPM Hou Tao <houtao@huaweicl=
oud.com> wrote:
> >>>>>>>
> >> SNIP
> >>>>>>> If the existing bpf_map_lookup_elem() helper doesn't fit qp-tree =
we can
> >>>>>>> use new kfuncs from bpf prog and LPM-like map accessors from sysc=
all.
> >>>>>> It is a feasible solution, but it will make qp-trie be different w=
ith
> >>>>>> other map types. I will try to extend the APIs in bpf_map_ops firs=
t to
> >>>>>> see how much churns it may introduce.
> >>>>> you mean you want to try to dynamically adapt bpf_map_lookup_elem()
> >>>>> to consider 'void *key' as a pointer to dynptr for bpf prog and
> >>>>> lpm-like tuple for syscall?
> >>>>> I'm afraid the verifier changes will be messy, since PTR_TO_MAP_KEY=
 is
> >>>>> quite special.
> >>>> No. I didn't plan to do that. I am trying to add three new APIs in
> >>>> bpf_map_ops to handle lookup/update/delete operation from bpf syscal=
l
> >>>> (e.g, map_lookup_elem_syscall). So bpf program and bpf syscall can u=
se
> >>>> different API to operate on qp-trie.
> >>> How does bpf prog side api look like?
> >>> I thought we wanted to use dynptr as a key?
> >> Yes. bpf prog will use dynptr as the map key. The bpf program will use
> >> the same map helpers as hash map to operate on qp-trie and the verifie=
r
> >> will be updated to allow using dynptr as map key for qp-trie.
> > And that's the problem I just mentioned.
> > PTR_TO_MAP_KEY is special. I don't think we should hack it to also
> > mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
>
> Sorry for misunderstanding your reply. But before switch to the kfunc
> way, could you please point me to some code or function which shows the
> specialty of PTR_MAP_KEY ?
>
>

Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
logic assumes that there is associated struct bpf_map * pointer from
which we know fixed-sized key length.

But getting back to the topic at hand. I vaguely remember discussion
we had, but it would be good if you could summarize it again here to
avoid talking past each other. What is the bpf_map_ops changes you
were thinking to do? How bpf_attr will look like? How BPF-side API for
lookup/delete/update will look like? And then let's go from there?
Thanks!

