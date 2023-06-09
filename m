Return-Path: <bpf+bounces-2213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8DD72947C
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 11:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606841C21103
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8BDF5E;
	Fri,  9 Jun 2023 09:14:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BC20F3
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 09:14:59 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859B5597
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 02:14:33 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62884fa0e53so12155886d6.0
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686302072; x=1688894072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cesfe/g6ADwmZ84OGwS+GlXdMRPBQA3HiGdA6/1Wfug=;
        b=D+bDfUEjQaNwBOqaoNB7yz7UpAHHgpOAYO1Nuk4GYyPbeVaY0N63XHCMK45sHmzrG9
         dy1EFnO119rjptnYp3yw8xJVDj9rAQTyJEes7HkE5Tbs6cPuavmq89pFo+VKlQvQVtJa
         C6bA8L1cf5qxFajtLrFxsZL2Zii48lob4Db48y5XzjHmlt1zGFUm6WMS6KzQK78Fmk2n
         n8m11uA6jQccw/rr2wFmK9KQu/L+tltogEtN2brTHVrOjeo6bf00NAwDYmOphb66qfxg
         KHTMZPw9e1gRsxxZkL02OvPQKtX4CXZJrCcpnn0512/qodANwVVnlnpkVR0jWybCUijy
         LRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686302072; x=1688894072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cesfe/g6ADwmZ84OGwS+GlXdMRPBQA3HiGdA6/1Wfug=;
        b=l3jlBRwnfP/OfZ97Xy1lE8U5IRQXgz+nO2I9eRdprouwhxnZr8Tm+fGo0oNy0d1bbX
         3FfV0LVja8rgzftGF/BnzsSJwYBejnEKmjneNFAzJoLhP0nqe3p9yeKopUbimmC9wwps
         0PBU8Sd/hmjOebz/OkfI9vP80o+2dIkjn988+lImtfCfZF1wfKGh2i6JrOPHpEls2IG9
         gmpNgwjWjOXPPKuen58hGrXQJ3fY0vaiCIE3CuReUD7HFN0UgHEhJC1HV5MXNhnLMaZd
         UPtYX1XqU/rbfFJBX1GTJApofoQq0qz/iBUVRJaUdXdyuxnnUpnscyPONmBkQT1FGj5r
         ZqfA==
X-Gm-Message-State: AC+VfDzpe8CC5EItSXmt7JHJd/r+tu5beHA9y41WwGjJpTOF5IvHddQn
	6YweRTXdbxMLnfGgmxwmt7KvFvJn8+F7XZjs4+Y=
X-Google-Smtp-Source: ACHHUZ6yUiyvgGcfY35wtr4zxaWIbgfDlrLcZ+wEdkrzL0uDKiXg30hLcI0mP/NqCz1CP277BSNHkLx50cJu3Qxszv8=
X-Received: by 2002:a05:6214:4115:b0:626:213:165e with SMTP id
 kc21-20020a056214411500b006260213165emr947404qvb.55.1686302072333; Fri, 09
 Jun 2023 02:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-2-laoar.shao@gmail.com>
 <CAEf4BzY8Vi4Y6kf7hOmhWQkKOV=R7tBzb4dgCuicni3bBFWb9A@mail.gmail.com>
In-Reply-To: <CAEf4BzY8Vi4Y6kf7hOmhWQkKOV=R7tBzb4dgCuicni3bBFWb9A@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 9 Jun 2023 17:13:56 +0800
Message-ID: <CALOAHbAfiJ7BWzxBWD3vD9vaAkUa8o_95r8x-A_o5jjAyBFpqA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
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

On Fri, Jun 9, 2023 at 7:05=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > With the addition of support for fill_link_info to the kprobe_multi lin=
k,
> > users will gain the ability to inspect it conveniently using the
> > `bpftool link show` command. This enhancement provides valuable informa=
tion
> > to the user, including the count of probed functions and their respecti=
ve
> > addresses. It's important to note that if the kptr_restrict setting is =
set
> > to 2, the probed addresses will not be exposed, ensuring security.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       |  5 +++++
> >  kernel/trace/bpf_trace.c       | 30 ++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  5 +++++
> >  3 files changed, 40 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a7b5e91..d99cc16 100644
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
> > +                       __u8  retprobe;
>
> from kernel API side it's probably better to just expose flags?

Agreed. The flags will be extensible.

> retprobe is determined by BPF_F_KPROBE_MULTI_RETURN flag

Should we print 'flags' in `bpftool link show` directly? As we print
it in `bpftool map show`.

>
> > +               } kprobe_multi;
> >         };
> >  } __attribute__((aligned(8)));
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 2bc41e6..738efcf 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2548,9 +2548,39 @@ static void bpf_kprobe_multi_link_dealloc(struct=
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
> > +       if (!ucount)
> > +               return 0;
> > +       if (ucount !=3D kmulti_link->cnt)
> > +               return -EINVAL;
>
> should this just check that kmulti_link->cnt is <=3D ucount?...

Agreed.

>
> > +       info->kprobe_multi.retprobe =3D kmulti_link->fp.exit_handler ?
> > +                                     true : false;
> > +       if (kptr_restrict =3D=3D 2)
> > +               return 0;
>
> use kallsyms_show_value() instead of hard-coding this?

Good point. Will use it.

--=20
Regards
Yafang

