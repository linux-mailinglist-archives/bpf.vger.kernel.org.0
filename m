Return-Path: <bpf+bounces-8201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41848783727
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 02:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0835280F75
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 00:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E4E110F;
	Tue, 22 Aug 2023 00:58:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4510E7
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 00:58:49 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F336D7
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 17:58:46 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9a2033978so61904831fa.0
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 17:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692665924; x=1693270724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP/nJi58kmHeogX2p0EWGvOyB9nu9zKKiAOp5Ah7Hg4=;
        b=pAid+nEZ04TNkxX1jeB88JGSTXazlcfAkAwazknRVuVr+KibF7Ucx1ZOqr1Le/Zuum
         rNh78c1qslP+9kaQCnDbj4ZShduj+YQMOsDQ89eDDnvNHrrPG0pVZuT8L3xX1uu/JI9I
         E+PW19fwm3/InkYYsh2zeT7sSLz5eK4YeGuva4WZIORmQpNr8P0vQvmvPZHbrMbwfDra
         H9FRcZO1f3oSa4X5Etm0QdTFfV+1EmB7utJADLlx8h7bQ4lxThF8T0mczTEHq49+BDKT
         yFpr9ffnMg71lah1YiTOa2IaWjV0EQsmCtaYSC2MXPQUboe4pBi47MpuDRg+qmY2F4JQ
         e/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692665924; x=1693270724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP/nJi58kmHeogX2p0EWGvOyB9nu9zKKiAOp5Ah7Hg4=;
        b=YwBe2cnEOtHrBNHfT6KJbl81e62COyOe20kEWn+AYEr/2Jmqx3LTkAMUmmvU/GdZAu
         aks0BruydM/HRP3QN32ECPFqU9M/74i74IDVEtV1gioItR0eu4/vyed5KOUTDqKQFf+C
         9jCPYisbLmy5cj+BIrv5bBrcb6MsnK6U9P8RyT2kz8eeH6PDbLlhR7Y7oW7m+CQ9LmDE
         sBWAhlEZxHkknSM4QXE8NZi/adVhJxPKuJWIhO3F21L2ygKhcNc7d2YK8fyYRBqSp1Vv
         pY1jdttBnXwxgGjbnt3OqNIeNNVURajkO6Hfehx3GMB2OIUE2AzxPVlPf/6QjwxMqL3d
         J+Ig==
X-Gm-Message-State: AOJu0YwsscCXsFeiOWkAW1tCgJz1uHbbuQojVv+OcrZy1cA6rYIvE6fW
	Y+BrhhV4zXFs2mQQFHyUyP6aWutTwUisxZKc5tk=
X-Google-Smtp-Source: AGHT+IHc51HcZOegd/QFwC/KcM/RiTUq8tWIVpnIlUxFyD3y5OvNNpmnRVqHWsoPTLKV9Z0RwGOgVp5HZDu24KCSQrQ=
X-Received: by 2002:a2e:b0d0:0:b0:2bc:c3ad:f41b with SMTP id
 g16-20020a2eb0d0000000b002bcc3adf41bmr2396310ljl.2.1692665924135; Mon, 21 Aug
 2023 17:58:44 -0700 (PDT)
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
 <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com>
In-Reply-To: <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Aug 2023 17:58:32 -0700
Message-ID: <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
Subject: Re: Question: Is it OK to assume the address of bpf_dynptr_kern will
 be 8-bytes aligned and reuse the lowest bits to save extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 5:55=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/22/2023 7:49 AM, Alexei Starovoitov wrote:
> > On Sat, Aug 19, 2023 at 3:39=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> On 8/18/2023 7:00 AM, Alexei Starovoitov wrote:
> >>> On Wed, Aug 16, 2023 at 11:35=E2=80=AFPM Hou Tao <houtao@huaweicloud.=
com> wrote:
> >>>> ping ?
> >>> Sorry for the delay. I've been on PTO.
> >>>
> >>>> On 8/3/2023 9:28 PM, Hou Tao wrote:
> >>>>> On 8/3/2023 9:19 PM, Hou Tao wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> I am preparing for qp-trie v4, but I need some help on how to supp=
ort
> >>>>>> variable-sized key in bpf syscall. The implementation of qp-trie n=
eeds
> >>>>>> to distinguish between dynptr key from bpf program and variable-si=
zed
> >>>>>> key from bpf syscall. In v3, I added a new dynptr type:
> >>>>>> BPF_DYNPTR_TYPE_USER for variable-sized key from bpf syscall [0], =
so
> >>>>>> both bpf program and bpf syscall will use the same type to represe=
nt the
> >>>>>> variable-sized key, but Andrii thought ptr+size tuple was simpler =
and
> >>>>>> would be enough for user APIs, so in v4, the type of key for bpf p=
rogram
> >>>>>> and syscall will be different. One way to handle that is to add a =
new
> >>>>>> parameter in .map_lookup_elem()/.map_delete_elem()/.map_update_ele=
m() to
> >>>>>> tell whether the key comes from bpf program or syscall or introduc=
e new
> >>>>>> APIs in bpf_map_ops for variable-sized key related syscall, but I =
think
> >>>>>> it will introduce too much churn. Considering that the size of
> >>>>>> bpf_dynptr_kern is 8-bytes aligned, so I think maybe I could reuse=
 the
> >>>>>> lowest 1-bit of key pointer to tell qp-trie whether or not it is a
> >>>>>> bpf_dynptr_kern or a variable-sized key pointer from syscall. For
> >>>>>> bpf_dynptr_kern, because it is 8B-aligned, so its lowest bit must =
be 0,
> >>>>>> and for variable-sized key from syscall, I could allocated a 4B-al=
igned
> >>>>>> pointer and setting the lowest bit as 1, so qp-trie can distinguis=
h
> >>>>>> between these two types of pointer. The question is that I am not =
sure
> >>>>>> whether the idea above is a good one or not. Does it sound fragile=
 ? Or
> >>>>>> is there any better way to handle that ?
> >>> Let's avoid bit hacks. They're not extensible and should be used
> >>> only in cases where performance matters a lot or memory constraints a=
re extreme.
> >> I see. Neither the performance reason nor the memory limitation fit he=
re.
> >>> ptr/sz tuple from syscall side sounds the simplest.
> >>> I agree with Andrii exposing the dynptr concept to user space
> >>> and especially as part of syscall is unnecessary.
> >>> We already have LPM as a precedent. Maybe we can do the same here?
> >>> No need to add new sys_bpf commands.
> >> There is no need to add new sys_bpf commands. We can extend bpf_attr t=
o
> >> support variable-sized key in qp-trie for bpf syscall. The probem is t=
he
> >> keys from bpf syscall and bpf program are different: bpf syscall uses
> >> ptr+size tuple and bpf program uses dynptr, but the APIs in bpf_map_op=
s
> >> only uses a pointer to represent the key, so qp-trie can not distingui=
sh
> >> between the keys from bpf syscall and bpf program. In qp-trie v1, the
> >> key of qp-trie was similar with LPM-trie: both the syscall and program
> >> used the same key format. But the key format for bpf program changed t=
o
> >> dynptr in qp-trie v2 according to the suggestion from Andrii. I think =
it
> >> is also a bad ideal to go back to v1 again.
> >>
> >>> If the existing bpf_map_lookup_elem() helper doesn't fit qp-tree we c=
an
> >>> use new kfuncs from bpf prog and LPM-like map accessors from syscall.
> >> It is a feasible solution, but it will make qp-trie be different with
> >> other map types. I will try to extend the APIs in bpf_map_ops first to
> >> see how much churns it may introduce.
> > you mean you want to try to dynamically adapt bpf_map_lookup_elem()
> > to consider 'void *key' as a pointer to dynptr for bpf prog and
> > lpm-like tuple for syscall?
> > I'm afraid the verifier changes will be messy, since PTR_TO_MAP_KEY is
> > quite special.
>
> No. I didn't plan to do that. I am trying to add three new APIs in
> bpf_map_ops to handle lookup/update/delete operation from bpf syscall
> (e.g, map_lookup_elem_syscall). So bpf program and bpf syscall can use
> different API to operate on qp-trie.

How does bpf prog side api look like?
I thought we wanted to use dynptr as a key?

