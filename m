Return-Path: <bpf+bounces-2776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D74733DAA
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 04:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25341C2108E
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 02:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7766A3D;
	Sat, 17 Jun 2023 02:49:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106B627
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 02:49:36 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AED30DE;
	Fri, 16 Jun 2023 19:49:34 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-5ed99ebe076so12466426d6.2;
        Fri, 16 Jun 2023 19:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686970173; x=1689562173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K8M3QRuHMyB39RWCtaG8MbUx309vyML41zc9Nqsd5M=;
        b=l2u2xCsD9nDZ3tN3rY3VXidwjeV1Pgqopj+O48e7vMrJiOvOVsH4+QG9D/t64GdPdm
         UkQuI7fmYNbdpDON+zY/qqVb7pKZsrhziFqr4LjOsMTBTTAdA9noqgl4sg8HBd2NYTjY
         KOmUefC65gtb7KswRI+CHIDQt+jXTjSx2wHRU/meDaxtW0cSdPRSJ0aNB84o586VaAdY
         HefIvr7Rdd1DLdjE2Me7VYUddGYMfd1+ensAtZthE8yzvfqWYOjj3UO6I+bfsKCColeI
         wXSFwGBFp/Ruz6TVB3kd3q7r6b6Bi5Lde6j5O6rwbbjmmsZnFqfU02K0RovhblSeq8Pc
         jPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686970173; x=1689562173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K8M3QRuHMyB39RWCtaG8MbUx309vyML41zc9Nqsd5M=;
        b=JS2rHO4zXq0x7pqcvgG2eVO652ADhoKXutpMRMkgmAmpZx0YFNbZ/cNIFsDu+1acqA
         Z03ZqlECmIHraw3EljwG68GtL9LU0b2wS+muCFJg3muHkzUhIHe9FSaKqHIu4cchC1AP
         YEkldYN8MdEN8ntwbcgBkHTR6bBNlXmWPc1DnW/r7XGWFZQ/9snAC4mDRs8lm5aU0lti
         nWJifoTNhRSXVuqBwdZE7edhCn7n0Ih87/+Z3TXp90O8PvEcAY/nM8b8kLxuBo9f8g6S
         oQuornLUfbLwAr9LnN0uhU7WsmoVGNOarA+JLrh7rQ+rMaqjMSwK7jq7dUdBxCBp/uur
         /1gA==
X-Gm-Message-State: AC+VfDxcydyaIq2Gx/mLKcFarrLbnx4OdIGjkCZwrRlEIt36kxN7sQz0
	jRE6kjlP9P/8hA10ltaj3cYptPzpHl/Cv6b+fYg=
X-Google-Smtp-Source: ACHHUZ69k/AHAVp+l6MLdcSpDK9toSZpTfYBp594BcJfATYAe/kpoAzK4QQGQoydlTtsPHbPCXnx8XW2p2z3UX5HPNk=
X-Received: by 2002:a05:6214:250e:b0:5b5:9c2:8c29 with SMTP id
 gf14-20020a056214250e00b005b509c28c29mr5522427qvb.12.1686970173357; Fri, 16
 Jun 2023 19:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-2-laoar.shao@gmail.com>
 <CAEf4BzaKg88jxQEUAT5-BPYbbi6yERDUeHu0qJb4pqSF2JEGig@mail.gmail.com>
In-Reply-To: <CAEf4BzaKg88jxQEUAT5-BPYbbi6yERDUeHu0qJb4pqSF2JEGig@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 17 Jun 2023 10:48:57 +0800
Message-ID: <CALOAHbCFZngUxRF3v1ZogCh09MLMUmjog3jG5hh=H+u_17b7xQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/10] bpf: Support ->fill_link_info for kprobe_multi
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 17, 2023 at 1:24=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > With the addition of support for fill_link_info to the kprobe_multi lin=
k,
> > users will gain the ability to inspect it conveniently using the
> > `bpftool link show`. This enhancement provides valuable information to =
the
> > user, including the count of probed functions and their respective
> > addresses. It's important to note that if the kptr_restrict setting is =
not
> > permitted, the probed address will not be exposed, ensuring security.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       |  5 +++++
> >  kernel/trace/bpf_trace.c       | 28 ++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  5 +++++
> >  3 files changed, 38 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a7b5e91..23691ea 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6438,6 +6438,11 @@ struct bpf_link_info {
> >                         __s32 priority;
> >                         __u32 flags;
> >                 } netfilter;
> > +               struct {
> > +                       __aligned_u64 addrs; /* in/out: addresses buffe=
r ptr */
> > +                       __u32 count;
> > +                       __u32 flags;
> > +               } kprobe_multi;
> >         };
> >  } __attribute__((aligned(8)));
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 2bc41e6..742047c 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2548,9 +2548,36 @@ static void bpf_kprobe_multi_link_dealloc(struct=
 bpf_link *link)
> >         kfree(kmulti_link);
> >  }
> >
> > +static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link =
*link,
> > +                                               struct bpf_link_info *i=
nfo)
> > +{
> > +       u64 __user *uaddrs =3D u64_to_user_ptr(info->kprobe_multi.addrs=
);
> > +       struct bpf_kprobe_multi_link *kmulti_link;
> > +       u32 ucount =3D info->kprobe_multi.count;
> > +
> > +       if (!uaddrs ^ !ucount)
> > +               return -EINVAL;
> > +
> > +       kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link=
, link);
> > +       if (!uaddrs) {
> > +               info->kprobe_multi.count =3D kmulti_link->cnt;
> > +               return 0;
> > +       }
> > +
> > +       if (ucount < kmulti_link->cnt)
> > +               return -EINVAL;
> > +       info->kprobe_multi.flags =3D kmulti_link->fp.flags;
>
> besides what Jiri said, flags should always be returned, just like
> cnt. So structure code instead around uaddrs being optional, that will
> everything more straightforward (i.e., fill out everything but uaddrs
> and then at the end fill out addrs if uaddrs is not zero)

Agree. That will be more straightforward. Will change it.

--=20
Regards
Yafang

