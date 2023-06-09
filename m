Return-Path: <bpf+bounces-2216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A657295F2
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 11:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D58A281729
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 09:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D801428C;
	Fri,  9 Jun 2023 09:53:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2213AC1
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 09:53:59 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FF85BBB
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 02:53:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f7a546efb1so11941581cf.2
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 02:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686304433; x=1688896433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkJlRP/qlqG0c7O0dwiXgcUNXV912YKH6KzHHIhZP4k=;
        b=bjV6m1LuWJys5Gdfe85/kELs7Rf71lklE1kaeupQEgZXEY+7et5wwOyeVyMOD3T/7U
         XWqpbWF/vbDC3cIg0UpyeKkvkqCjvgKy4DNb/noKAwDiaIot8OIiXIN3P7cbpkA704za
         hn3AUGkHpqlKmNI63jwIfO2k38WI3CggYN5LYPDSNigLSqmI3Lw/OM4NY4eJ4uewXiN2
         rkltQACF5asCXzpT6cnKprUf4l+GAu5FJ/XBfDKtl98Vx9eEcTq0pFVmJFNd8zDMhY3M
         0h4fqei6Io2uqPAU2li2rcRC7IsbDTeg9BtB7d6yMbK8YKQr/gEYHERmQp56sS8rt3XT
         VVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304433; x=1688896433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkJlRP/qlqG0c7O0dwiXgcUNXV912YKH6KzHHIhZP4k=;
        b=coyyKrOFcbSUNoW9Ki/cYk2XnCRMM76azJwcRyWn5xoX9lvcFsN41xh9zxV9SvgTxg
         SLhjMrtHlvqRh77IS6Y95hbnFj0jtmctpZ9itBtNOyVj6Xllth9VRWexc09XA+1eWEzO
         la4EGlYF71zivD+iAgxYIZF8CfAxKh6ij/BAQ7r5UPDziMPyKH5VramDig0yM4wEgD3d
         x3h2fxNh7s8gqeUKNFTbqHa+MwbltBnYtjWRjoOEiD3RRKoJ89O8UvzddFthGZWF+zM6
         NeoanzUMQUujDr2UzqJHbW1gOey9BSUC4xWM7vtepymI0HKissqcYv1VREM+3b3Epsro
         EWdw==
X-Gm-Message-State: AC+VfDyP3aq0SnmRQlmJ9ejf9o1uw67xUjDQclc9dI4YYQQNqtBaCrvM
	3WDeKWXlq5EZP5WqOlDWpmUjxZhn+wOcSqP0cJrvtJ3wdLfOKxHJ
X-Google-Smtp-Source: ACHHUZ7a3VUdm7zl0KuuS/Jdh5DL/KjYEmbVdqpWcSZ9lJHSBv3hUqzr7XCQHwpCcuacthvytQ965qYtrJmTI0L1S2E=
X-Received: by 2002:a05:622a:288:b0:3f1:630:8659 with SMTP id
 z8-20020a05622a028800b003f106308659mr1009206qtw.53.1686304433593; Fri, 09 Jun
 2023 02:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-9-laoar.shao@gmail.com>
 <CAEf4BzYEwCZ3J51pFnUfGykEAHtdLwB8Kxi0utvUTVvewz4UCg@mail.gmail.com>
In-Reply-To: <CAEf4BzYEwCZ3J51pFnUfGykEAHtdLwB8Kxi0utvUTVvewz4UCg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 9 Jun 2023 17:53:17 +0800
Message-ID: <CALOAHbCrRQ2f9y5AKa9hgMLLzqB+yBEZMxLP-FevK+q=YuMS=w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/11] bpf: Support ->fill_link_info for perf_event
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 7:12=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > By introducing support for ->fill_link_info to the perf_event link, use=
rs
> > gain the ability to inspect it using `bpftool link show`. While the cur=
rent
> > approach involves accessing this information via `bpftool perf show`,
> > consolidating link information for all link types in one place offers
> > greater convenience. Additionally, this patch extends support to the
> > generic perf event, which is not currently accommodated by
> > `bpftool perf show`. While only the perf type and config are exposed to
> > userspace, other attributes such as sample_period and sample_freq are
> > ignored. It's important to note that if kptr_restrict is set to 2, the
> > probed address will not be exposed, maintaining security measures.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       | 22 ++++++++++
> >  kernel/bpf/syscall.c           | 98 ++++++++++++++++++++++++++++++++++=
++++++++
> >  tools/include/uapi/linux/bpf.h | 22 ++++++++++
> >  3 files changed, 142 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index d99cc16..c3b821d 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6443,6 +6443,28 @@ struct bpf_link_info {
> >                         __u32 count;
> >                         __u8  retprobe;
> >                 } kprobe_multi;
> > +               union {
> > +                       struct {
> > +                               /* The name is:
> > +                                * a) uprobe: file name
> > +                                * b) kprobe: kernel function
> > +                                */
> > +                               __aligned_u64 name; /* in/out: name buf=
fer ptr */
> > +                               __u32 name_len;
> > +                               __u32 offset;   /* offset from the name=
 */
> > +                               __u64 addr;
> > +                               __u8 retprobe;
> > +                       } probe; /* uprobe, kprobe */
> > +                       struct {
> > +                               /* in/out: tracepoint name buffer ptr *=
/
> > +                               __aligned_u64 tp_name;
> > +                               __u32 name_len;
> > +                       } tp; /* tracepoint */
> > +                       struct {
> > +                               __u64 config;
> > +                               __u32 type;
> > +                       } event; /* generic perf event */
>
> how should the user know which of those structs are relevant? we need
> some enum to specify what kind of perf_event link it is?
>

Do you mean that we add a new field 'type' into the union perf_event,
as follows ?
    union {
        __u32 type;
        struct {} probe;  /* BPF_LINK_TYPE_PERF_EVENT_PROBE */
        struct {} tp; /* BPF_LINK_TYPE_PERF_EVENT_TP */
        struct {} event; /* BPF_LINK_TYPE_PERF_EVENT_EVENT */
    };

--=20
Regards
Yafang

