Return-Path: <bpf+bounces-2627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CB731833
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 14:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8B91C20E7D
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831C1548E;
	Thu, 15 Jun 2023 12:10:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5071156DD
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 12:10:36 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ABD193;
	Thu, 15 Jun 2023 05:10:35 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-760929a1783so321872685a.2;
        Thu, 15 Jun 2023 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686831034; x=1689423034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtpYt0rNmWlhLDVfJr9GKI49XXgxxmpUomc3ag0dHYk=;
        b=ofzDYDZ6tA56JRvV3ORH8vRgtMTnZnZ+PHJyioeLpjZ62XG6dDp60PikPWT09YCkaV
         aw6RO3DdcuVA0lTr+PlMLA4B2o2kthGfGG1gLms/WUGrHd3PFK0g/P5f/iPBFD7zBuW4
         59aQqRL5KA1jrAKcw5v4g3P2nBVbsuAYNgjjGiYLOXU8odkTP1dfuhyzT6FOA2ilXoF3
         vT4twMagoz+HPRw/gpTACja+pC6qeIq5AYDPI+VCrui40voVu8AUlnBs29BEmt8p+07f
         k9aGMpqx0dBwKSKYvIfmmTL+El0ZF5AY8PNgJG5ia5vX+Fx2shEljVnO7kOEEg6UO2N2
         3w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831034; x=1689423034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtpYt0rNmWlhLDVfJr9GKI49XXgxxmpUomc3ag0dHYk=;
        b=Qj7CcXMsWL7ZRiaC2LOLxL4Hi86m0fWK1x/3MjUUyG+PIVkHVINuTsRu9VN1KlTHh7
         KS2y5usLEm7rY5sUU2bk5lPvu3Rbzu9rAj94DufKHMDI809q+0dK5ri7BfKJE2yowDey
         S87c0dAk2MtciGk5l9f/fc9g87xw42+UMoje5YfipfuXaB5Wifba13iRowwaeAN1Hz3S
         DiiXB9tpSelubY6VqC5gM687uBroMZ2GF3v0buLH6Ud3Jx4xKCmxeq3oDSX8bCrMFieo
         p9Ej+1HtlKIUkqGCRR1v0/Wa2H9awQSYeZmqhPx8LbZ/ydG8DGG1Z72iAWW/9JgUgyfQ
         D+7w==
X-Gm-Message-State: AC+VfDxoz3hgoHyET9uWZuVhgLEPmVk4IyyCNBUCq7QoeO45N/8KKgLz
	zSLQicagvq70JmYu6iWRch60jVklFipq0frTnDcMttbIo5s=
X-Google-Smtp-Source: ACHHUZ4qJttzC8sR3W8QWfUpn/qA8YR0kamT8c6gbmHPGNskXhNh7btmile+6h7mvBLfj+o9cJZpvzwRdMcPjRo/Jmg=
X-Received: by 2002:a05:6214:c45:b0:62f:f241:75b0 with SMTP id
 r5-20020a0562140c4500b0062ff24175b0mr1586765qvj.18.1686831034282; Thu, 15 Jun
 2023 05:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-2-laoar.shao@gmail.com>
 <ZIrL1szyBiYokMUy@krava>
In-Reply-To: <ZIrL1szyBiYokMUy@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 15 Jun 2023 20:09:58 +0800
Message-ID: <CALOAHbDo1r1KywZhvqo5xGk7BS0dJLEtM7nMdLb1iURR45RQ0A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/10] bpf: Support ->fill_link_info for kprobe_multi
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, quentin@isovalent.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 4:29=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jun 12, 2023 at 03:15:59PM +0000, Yafang Shao wrote:
>
> SNIP
>
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 2bc41e6..742047c 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2548,9 +2548,36 @@ static void bpf_kprobe_multi_link_dealloc(struct=
 bpf_link *link)
> >       kfree(kmulti_link);
> >  }
> >
> > +static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link =
*link,
> > +                                             struct bpf_link_info *inf=
o)
> > +{
> > +     u64 __user *uaddrs =3D u64_to_user_ptr(info->kprobe_multi.addrs);
> > +     struct bpf_kprobe_multi_link *kmulti_link;
> > +     u32 ucount =3D info->kprobe_multi.count;
> > +
> > +     if (!uaddrs ^ !ucount)
> > +             return -EINVAL;
> > +
> > +     kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link, =
link);
> > +     if (!uaddrs) {
> > +             info->kprobe_multi.count =3D kmulti_link->cnt;
> > +             return 0;
> > +     }
> > +
> > +     if (ucount < kmulti_link->cnt)
> > +             return -EINVAL;
> > +     info->kprobe_multi.flags =3D kmulti_link->fp.flags;
> > +     if (!kallsyms_show_value(current_cred()))
> > +             return 0;
> > +     if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)=
))
> > +             return -EFAULT;
> > +     return 0;
> > +}
> > +
> >  static const struct bpf_link_ops bpf_kprobe_multi_link_lops =3D {
> >       .release =3D bpf_kprobe_multi_link_release,
> >       .dealloc =3D bpf_kprobe_multi_link_dealloc,
> > +     .fill_link_info =3D bpf_kprobe_multi_link_fill_link_info,
> >  };
> >
> >  static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, c=
onst void *priv)
> > @@ -2890,6 +2917,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
> >               return err;
> >       }
> >
> > +     link->fp.flags =3D flags;
>
> hum this looks wrong, we can't use fprobe flags to store our flags
> you should add flags to bpf_kprobe_multi_link

Will fix it. Thanks for pointing it out.

--=20
Regards
Yafang

