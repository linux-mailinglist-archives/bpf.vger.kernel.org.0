Return-Path: <bpf+bounces-693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56388705D9E
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121CD281377
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 03:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D9217ED;
	Wed, 17 May 2023 03:01:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA429105
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:01:12 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0E1C1
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 20:01:10 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-62382e86f81so1354016d6.2
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684292470; x=1686884470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awtoz7Inu51lSF4WxXeVu4PEpiX/h2/h6mLdAj8MoIM=;
        b=prdU+Xn14Ivlxe8WvA2wLOl8/tlD7Oc46WGdBLn7f7kMgZJS9DexWLuE0Q38u+FnnS
         JOVIMwygZrco6Fbq6K15Ny57zkcoYmDaHCMBIQbBxEbzauGh2rXUyJfudPGyw7xJuwap
         JdyfPfV4ToKBWJ4/8xvflLaluYk9CwtW2IozVSXNjt8/9JPqJy8tixoCws/rTTGUyLQh
         m+FDo+ZJM/W0xZem+C1IKzCdjGZtRgFETELp3A3Xin1qlNx2W7w90hd8/ib56rmTtBoM
         bZPpMgHDEkPB/7YTf659jI7VtEfHZ2xH7Ak13YFBOQDtes/SRhgQ1VyNAgsmMBG3/YU9
         JAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292470; x=1686884470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awtoz7Inu51lSF4WxXeVu4PEpiX/h2/h6mLdAj8MoIM=;
        b=gjgkYR7xRn9OE1oVS3VvQ7DWcZ6/TLfXw7TmH5dUplNR2QFyfP2a5mnRYPxN3xYwvd
         9j/bbZsRA3nan5fUunemYIwq70UuWQPHrUcdRi8ju3AeZhF67vxvgxhdg1L21LSLTwk0
         yYc92eozIDBAVdw9Wt9jAy0jHRF7ga8K6PBxMYC5gJl5hGIkINCiXQB9GEkpueOOoQT8
         Kyrrpj5L2btFSSdAOCmUkESAqqjeMtSX9//c0T7BIVKMQwp/TJ2zMIWgMN71oThWklA/
         aAxCGjPtumfW4sKRTmQKq+bhqPqaGEFcD3K+R3i8KYY7h1mMEqUuDxXGpzzDDh1UwifA
         1EmQ==
X-Gm-Message-State: AC+VfDzSSTliQ+cZ/YCLULmlA69mG1Lt19ckBm9x6lco4Seafz+dREwk
	3Zo0DuxqEnwnjh59kshteI3DzK/Lsebfx6z2qyY=
X-Google-Smtp-Source: ACHHUZ5GY89oW3ikPGKjP9Yk1wChYYZIheq0Fh+nycbumg5N3x/25aDxtF8ywFSi7IP+mMrvptBCbkDo0q3/OwJwXF0=
X-Received: by 2002:a05:6214:234f:b0:623:8896:2d77 with SMTP id
 hu15-20020a056214234f00b0062388962d77mr63869qvb.41.1684292469720; Tue, 16 May
 2023 20:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516123926.57623-1-laoar.shao@gmail.com> <20230516123926.57623-2-laoar.shao@gmail.com>
 <CAEf4Bza=ujh+HzoT4V3bc7gjAH92veg0Ez_vBqszm7qETk6SMw@mail.gmail.com>
In-Reply-To: <CAEf4Bza=ujh+HzoT4V3bc7gjAH92veg0Ez_vBqszm7qETk6SMw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 17 May 2023 11:00:33 +0800
Message-ID: <CALOAHbD_78mkmXP_Bpq5cxhjwK64Na=wKHhDNPxSUF4D4+L6ow@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Show target_{obj,btf}_id in tracing
 link fdinfo
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kafai@fb.com, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 6:28=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 16, 2023 at 5:39=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > The target_btf_id can help us understand which kernel function is
> > linked by a tracing prog. The target_btf_id and target_obj_id have
> > already been exposed to userspace, so we just need to show them.
> >
> > The result as follows,
> >
> > $ cat /proc/10673/fdinfo/10
> > pos:    0
> > flags:  02000000
> > mnt_id: 15
> > ino:    2094
> > link_type:      tracing
> > link_id:        2
> > prog_tag:       a04f5eef06a7f555
> > prog_id:        13
> > attach_type:    24
> > target_obj_id:  1
> > target_btf_id:  13964
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Song Liu <song@kernel.org>
> > ---
> >  kernel/bpf/syscall.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 909c112..870395a 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2968,10 +2968,18 @@ static void bpf_tracing_link_show_fdinfo(const =
struct bpf_link *link,
> >  {
> >         struct bpf_tracing_link *tr_link =3D
> >                 container_of(link, struct bpf_tracing_link, link.link);
> > +       u32 target_btf_id;
> > +       u32 target_obj_id;
>
> nit: combine on a single line?
>

Will change it.

> >
> > +       bpf_trampoline_unpack_key(tr_link->trampoline->key,
> > +                                                         &target_obj_i=
d, &target_btf_id);
>
> formatting seems odd?...
>

It is because the vim table size on my current dev server is 4. Will
correct it.

--=20
Regards
Yafang

