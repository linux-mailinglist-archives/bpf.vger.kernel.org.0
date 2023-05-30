Return-Path: <bpf+bounces-1414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED67715303
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 03:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18499280FB2
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 01:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EEBEA5;
	Tue, 30 May 2023 01:42:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACFA42
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 01:42:35 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A6FD9
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 18:42:34 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6260b578097so17160736d6.3
        for <bpf@vger.kernel.org>; Mon, 29 May 2023 18:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685410953; x=1688002953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ycqc/qm+zJvFKwVknpnhnF1dsnHSBW7g/m3gdTqjQQ=;
        b=ag9aKK7HLzW/puHsAWwZff1hPi6oHF/U7b0C7Cc7iK5Q/Vn7aeJ1Tn6E5DJTMMUG8v
         wWmfX1mfkE1Mxyw0MWYhpBr78mBcc2vW1cfwQBBNrUPEEes+oPKhdY+EA1bN6DY9X+zH
         bEn6EiGyIaRcWhDWl0/aAFZJMKUQi9h5fCWzmPuAZtuBGkVsMG1iq+zdxM/ltiLaXbn3
         vFZm6/T+k3NkJJtQxSQDvNDhGNXAFV2xpWYLudPwq3YrNpP/lqAvV8Wb3YmBGB1RLKFX
         b7GHcKg2iEKAUAE3Yfs6uxshCzWbESt628QlktKDvZ23xVDktppD53L+OHYx7ShdrpHB
         /XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685410953; x=1688002953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ycqc/qm+zJvFKwVknpnhnF1dsnHSBW7g/m3gdTqjQQ=;
        b=H2lec3ZNUZWMy6msPlcANEyiLdF/JNdM+0N658UAUTgHszCbvC4oUM6BXlKMqsdets
         nSq1bF+DHYynpnwTxXIg6gRIlPanGWjQHNmq2vN44Rmu+Bh0KLPlMd3TlLhhOqr5L/tT
         QwY+gK+2UCE4HmI/xrvb9hhDJCjX0EGrhGeYRnKzyr2BwTQq3ReSXigc3CELlbyruIEt
         a55b0tzgj7pAauIOBBkgFVyVPMTP8JGBSG3ay02ku9XtkIip4OAcaJAWGRCX/GessRqT
         F0wvTh283fV9od/qZImIJl9RlruHy+5C3y4Eo373wlDwPEN2uaHzXkpH0GkqIuewtG5w
         hfDw==
X-Gm-Message-State: AC+VfDzFIEtsZZCqWASM/UoO49JonaZ6p3ggd4tQKFqo1FOYOnqXJP7x
	K7FHvTrzGB5hwPCnu0bKcvXtd72L04uTkXCc3tY=
X-Google-Smtp-Source: ACHHUZ6dL4o+iL4WDifgnIm0WHH9PF1xg8YpuDo4daIOinUCy9w+rV6deo1e6Q3g3iPCs5AsJYzjLD5dCP2jCNtGnzI=
X-Received: by 2002:a05:6214:21ab:b0:625:a982:857 with SMTP id
 t11-20020a05621421ab00b00625a9820857mr474402qvc.50.1685410953354; Mon, 29 May
 2023 18:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230528142027.5585-1-laoar.shao@gmail.com> <20230528142027.5585-3-laoar.shao@gmail.com>
 <ZHSfcabMuoy17ill@krava>
In-Reply-To: <ZHSfcabMuoy17ill@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 30 May 2023 09:41:57 +0800
Message-ID: <CALOAHbBCqAsh+iq7dh1APvbiwNEsbOKaHE8YR8Sr8NKE-2Fw1Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/8] bpf: Support ->fill_link_info for kprobe_multi
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, quentin@isovalent.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 29, 2023 at 8:49=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, May 28, 2023 at 02:20:21PM +0000, Yafang Shao wrote:
>
> SNIP
>
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 0d84a7a..00a0009 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2564,10 +2564,41 @@ static void bpf_kprobe_multi_link_show_fdinfo(c=
onst struct bpf_link *link,
> >       }
> >  }
> >
> > +static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link =
*link,
> > +                                             struct bpf_link_info *inf=
o)
> > +{
> > +     struct bpf_kprobe_multi_link *kmulti_link;
> > +     u64 *uaddrs =3D u64_to_user_ptr(info->kprobe_multi.addrs);
> > +     u32 ucount =3D info->kprobe_multi.count;
> > +     int i;
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
> > +     if (!ucount)
> > +             return 0;
> > +
> > +     if (ucount !=3D kmulti_link->cnt)
> > +             return -EINVAL;
> > +
> > +     for (i =3D 0; i < ucount; i++)
> > +             if (copy_to_user(uaddrs + i, kmulti_link->addrs + i,
> > +                              sizeof(u64)))
> > +                     return -EFAULT;
>
> let's use put_user instead copy_to_user? or even better why not
> copy that with single copy_to_user from kmulti_link->addrs
>

Good point. I will utilize a single copy_to_user instead.

--=20
Regards
Yafang

