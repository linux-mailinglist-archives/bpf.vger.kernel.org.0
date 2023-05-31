Return-Path: <bpf+bounces-1480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC225717454
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 05:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFA3281415
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 03:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E182186B;
	Wed, 31 May 2023 03:25:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBADEC4
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 03:25:04 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B83C5
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:25:02 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6261d4ea5f0so15573566d6.0
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685503501; x=1688095501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHIn5o5ORWRI/n7RD+HTIWxGY3+BIKTCz/gIJbUhfJ0=;
        b=oNpynZ6GAci9M5YxtcKT91cMYgFK+Hvcq+uDeeiGph/q0zedE3M5iu3vFHv6Mk3iKt
         Quyfto1RI7ToceAJ2nJZTnOoVNKRyMy7Ffvfeu08zrzB2NK5XBkJy5IlcabHNYGdGrFx
         jWMDrVnKucddm4uBTVfIOw5WpxIt2f3AF4SzS9QvcpszTk4G/vk8Vdk4W5mf1mzKpba+
         5K/53hnk0YzOw6o4SV5CGc43Sgl0Y4Xe5VHdBvKSEMJ6aMFIoaFhTUNbNQdwfHhYYxlR
         u+N0V6/QjOKZQOSc3qCfdqv92+deETB1iG7ZBBT7jBvufZdSoqI3sCtXqNNPt7eHujXr
         KaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685503501; x=1688095501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHIn5o5ORWRI/n7RD+HTIWxGY3+BIKTCz/gIJbUhfJ0=;
        b=gBfxJUw0PRNe0BR37caeHOXKLftmMAIHU8DIC1AG1NmsFN2snsJwt5soHVxZQTAzyz
         i/CuiGoJ3rkw94t/MongJ0NYd8npsZi3fSl5jE70RDYQAr6FbPV59luQTGtQoeYQxhVs
         20i2eRk0wb+9mP6a5h3jX6hb0OBgdzuiDyoet7l4NOsp4u+tMlCfWBzKETmSUxnIEqML
         o5PUFsu6R4EobxB13VcV0nJ0PxYnQmlwv58KfaZNRUl+k6+dnp7A9PMSQBcQILomWzIY
         oz4ouupTSPVN9umxzNPSbdItsnLK3iMmwr4021Ft84MZi310LzjnoLOtl375VgDHsHWO
         0+Ew==
X-Gm-Message-State: AC+VfDyxmqZlkIhyEeBlbNV+fSfdRFv2kDetCmlT0q/TpMKgfmJ6PCRr
	jOqpkLS3TCabUv5moTl2gLwPzz+p1//rlHsD5NSqEjYq6k+Eng==
X-Google-Smtp-Source: ACHHUZ45nR2JcX1UYhW/gTLxT9ef2MWJE+DlhgkhA6e5JAsvKvqsjKQdcgsB4pZRsWkyGGN5oXqOpOlcuNVJatjbuo0=
X-Received: by 2002:a05:6214:e43:b0:616:4b40:5ea9 with SMTP id
 o3-20020a0562140e4300b006164b405ea9mr5031527qvc.40.1685503501500; Tue, 30 May
 2023 20:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230528142027.5585-1-laoar.shao@gmail.com> <20230528142027.5585-8-laoar.shao@gmail.com>
 <20230531003713.ml3gb76q4zurue3a@MacBook-Pro-8.local>
In-Reply-To: <20230531003713.ml3gb76q4zurue3a@MacBook-Pro-8.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 31 May 2023 11:24:25 +0800
Message-ID: <CALOAHbCpd5GoBrQcBsnyTH5bY9HwzDLeT8UhdGuG+2Ew2Sh_Zg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 7/8] bpf: Support ->fill_link_info for perf_event
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
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

On Wed, May 31, 2023 at 8:37=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, May 28, 2023 at 02:20:26PM +0000, Yafang Shao wrote:
> > By adding support for ->fill_link_info to the perf_event link, users wi=
ll
> > be able to inspect it using `bpftool link show`. While users can curren=
tly
> > access this information via `bpftool perf show`, consolidating the link
> > information for all link types in one place would be more convenient.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       |  6 ++++++
> >  kernel/bpf/syscall.c           | 46 ++++++++++++++++++++++++++++++++++=
++++++++
> >  tools/include/uapi/linux/bpf.h |  6 ++++++
> >  3 files changed, 58 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 6be9b1d..1f2be1d 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6438,6 +6438,12 @@ struct bpf_link_info {
> >                       __aligned_u64 addrs;
> >                       __u32 count;
> >               } kprobe_multi;
> > +             struct {
> > +                     __aligned_u64 name;
> > +                     __aligned_u64 addr;
>
> __aligned_u64 ? what is the reason?

It is because of the copy-and-paste.  Will use _u64 instead.

>
> > +                     __u32 name_len;
> > +                     __u32 offset;
> > +             } perf_event;
> >       };
> >  } __attribute__((aligned(8)));
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 33a72ec..b12707e 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3329,10 +3329,56 @@ static void bpf_perf_link_show_fdinfo(const str=
uct bpf_link *link,
> >       seq_printf(seq, "offset:\t%llu\n", probe_offset);
> >  }
> >
> > +static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
> > +                                     struct bpf_link_info *info)
> > +{
> > +     struct bpf_perf_link *perf_link =3D container_of(link, struct bpf=
_perf_link, link);
> > +     char __user *ubuf =3D u64_to_user_ptr(info->perf_event.name);
> > +     u32 ulen =3D info->perf_event.name_len;
> > +     const struct perf_event *event;
> > +     u64 probe_offset, probe_addr;
> > +     u32 prog_id, fd_type;
> > +     const char *buf;
> > +     size_t len;
> > +     int err;
> > +
> > +     if (!ulen ^ !ubuf)
> > +             return -EINVAL;
> > +     if (!ubuf)
> > +             return 0;
> > +
> > +     event =3D perf_get_event(perf_link->perf_file);
> > +     if (IS_ERR(event))
> > +             return PTR_ERR(event);
> > +
> > +     err =3D bpf_get_perf_event_info(event, &prog_id, &fd_type,
> > +                                   &buf, &probe_offset,
> > +                                   &probe_addr);
> > +     if (err)
> > +             return err;
> > +
> > +     len =3D strlen(buf);
> > +     info->perf_event.name_len =3D len + 1;
>
> this use of name_len contradicts with patch 8.
> Is it 'in' or 'out' field?

My mistake. I should remove this sentence.
The reason I didn't do it the same with
bpf_raw_tp_link_fill_link_info() is that if we return the buf length
to the userspace when the ubuf is NULL, we have to call
bpf_get_perf_event_info() multiple times.

--=20
Regards
Yafang

