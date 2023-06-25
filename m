Return-Path: <bpf+bounces-3404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C23773D184
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 16:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E8C1C20621
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4A2613D;
	Sun, 25 Jun 2023 14:36:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBA20F4
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 14:36:08 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEA711A;
	Sun, 25 Jun 2023 07:36:07 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7659cb9c42aso19450185a.3;
        Sun, 25 Jun 2023 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687703766; x=1690295766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4aftoAe9ZFkdLQu9LOd7OH+M2fAovpAGenyTnid5wc=;
        b=XCVhoVJP5jzRs9co5oTB/Mwk2YI2HkkhhGTlVXbT6LJ2721vH4u8zmgy2Yy18d3a5g
         sNygwj67DcNn+ZHnRYanMzzsDN+VzAlJqkJ6P6jLaCBHHogspqBEDmjsXRiPcf9IEyeH
         PsZrES+T6UaeqDzJQO9gpfJLdlouyOsEYlqQ3d7t9YSyXZL0tOwmkvx9HpymjCcNdWQA
         8A53vX27yjy4fq7ElQEW3S9Fu2rlqOuB+CkO4kJAmVFjct06VB3lAPWRZH0xXkEJg2L2
         zXAJ8FBYeQGCNayksxkA9NixnRIbajGOWo28YjnTqqIKfK/9j9iqGKTvzM1tP43YDbK3
         Ba+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703766; x=1690295766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4aftoAe9ZFkdLQu9LOd7OH+M2fAovpAGenyTnid5wc=;
        b=WeMFZ5jtE51OmKYb9pv8ZiK//rdxffTLBAPlXHAomKKfuuPnGRrCZE1i96tINNRQO/
         aM27Z1ki097BrzBDfBac0z7PN6jG6L5DJWtepDRFX+s8y3/d52D0KJ73iMFdMgQ7PWrb
         m309xr3Y6uPhTiTHwrfNz7TsnLX9STYLnKZ+IB2uxpbfQLyCfE3rC2EvT5EW80QCdbfU
         jC97XMaRR18wYTuc1RT1tV5Q1eb4qwjZJu5AtVEvpBMrKxyVi3zmXZPnD7SHt5FgTm5G
         j2+Z1IKJIunnl5m8+DzjXqdTNa9yg4hDP8VN3vXNMOMnnPPe5+bAuxfbY7rYJGfzXYvN
         Rddw==
X-Gm-Message-State: AC+VfDyqEf6xWXNOmuYgAJU/CJpaH2/Nc+DhqVgSWPlpA5/bB5uQRGLb
	2dh3ez+YtC4C7m7hIOYDx892Hm62gnJN6bpy8SI=
X-Google-Smtp-Source: ACHHUZ6D4sfG23ec9XO5cdBLq9MIT487ZuB27FwCy8DAolQu8FZa/fIwEQcu3reagBiGGI3CiFNGo1ivEaQA/DCohqU=
X-Received: by 2002:a05:620a:4089:b0:765:5756:799d with SMTP id
 f9-20020a05620a408900b007655756799dmr7077983qko.29.1687703766141; Sun, 25 Jun
 2023 07:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623141546.3751-1-laoar.shao@gmail.com> <20230623141546.3751-10-laoar.shao@gmail.com>
 <CAEf4Bzadyzhncvqv85W=tF+EZLjnUww_ZRCAr6mf-aL5p9P1SA@mail.gmail.com>
In-Reply-To: <CAEf4Bzadyzhncvqv85W=tF+EZLjnUww_ZRCAr6mf-aL5p9P1SA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Jun 2023 22:35:29 +0800
Message-ID: <CALOAHbD3y9P6kXBNdU-zVsVtUDv138D+dJi2=Vn0ryxVYAMJ_g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 09/11] bpf: Support ->fill_link_info for perf_event
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

On Sat, Jun 24, 2023 at 5:55=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 23, 2023 at 7:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
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
> > ignored. It's important to note that if kptr_restrict is not permitted,=
 the
> > probed address will not be exposed, maintaining security measures.
> >
> > A new enum bpf_perf_event_type is introduced to help the user understan=
d
> > which struct is relevant.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       |  35 +++++++++++++
> >  kernel/bpf/syscall.c           | 115 +++++++++++++++++++++++++++++++++=
++++++++
> >  tools/include/uapi/linux/bpf.h |  35 +++++++++++++
> >  3 files changed, 185 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 23691ea..1c579d5 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1056,6 +1056,14 @@ enum bpf_link_type {
> >         MAX_BPF_LINK_TYPE,
> >  };
> >
> > +enum bpf_perf_event_type {
> > +       BPF_PERF_EVENT_UNSPEC =3D 0,
> > +       BPF_PERF_EVENT_UPROBE =3D 1,
> > +       BPF_PERF_EVENT_KPROBE =3D 2,
> > +       BPF_PERF_EVENT_TRACEPOINT =3D 3,
> > +       BPF_PERF_EVENT_EVENT =3D 4,
> > +};
> > +
> >  /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
> >   *
> >   * NONE(default): No further bpf programs allowed in the subtree.
> > @@ -6443,6 +6451,33 @@ struct bpf_link_info {
> >                         __u32 count;
> >                         __u32 flags;
> >                 } kprobe_multi;
> > +               struct {
> > +                       __u32 type; /* enum bpf_perf_event_type */
> > +                       __u32 :32;
> > +                       union {
> > +                               struct {
> > +                                       __aligned_u64 file_name; /* in/=
out */
> > +                                       __u32 name_len;
> > +                                       __u32 offset;/* offset from fil=
e_name */
> > +                                       __u32 flags;
> > +                               } uprobe; /* BPF_PERF_EVENT_UPROBE */
> > +                               struct {
> > +                                       __aligned_u64 func_name; /* in/=
out */
> > +                                       __u32 name_len;
> > +                                       __u32 offset;/* offset from fun=
c_name */
> > +                                       __u64 addr;
> > +                                       __u32 flags;
> > +                               } kprobe; /* BPF_PERF_EVENT_KPROBE */
> > +                               struct {
> > +                                       __aligned_u64 tp_name;   /* in/=
out */
> > +                                       __u32 name_len;
> > +                               } tracepoint; /* BPF_PERF_EVENT_TRACEPO=
INT */
> > +                               struct {
> > +                                       __u64 config;
> > +                                       __u32 type;
> > +                               } event; /* BPF_PERF_EVENT_EVENT */
> > +                       };
> > +               } perf_event;
> >         };
> >  } __attribute__((aligned(8)));
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c863d39..02dad3c 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3394,9 +3394,124 @@ static int bpf_perf_link_fill_common(const stru=
ct perf_event *event,
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_KPROBE_EVENTS
> > +static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
> > +                                    struct bpf_link_info *info)
> > +{
> > +       char __user *uname;
> > +       u64 addr, offset;
> > +       u32 ulen, type;
> > +       int err;
> > +
> > +       uname =3D u64_to_user_ptr(info->perf_event.kprobe.func_name);
> > +       ulen =3D info->perf_event.kprobe.name_len;
> > +       info->perf_event.type =3D BPF_PERF_EVENT_KPROBE;
> > +       err =3D bpf_perf_link_fill_common(event, uname, ulen, &offset, =
&addr,
> > +                                       &type);
> > +       if (err)
> > +               return err;
> > +
> > +       info->perf_event.kprobe.offset =3D offset;
> > +       if (type =3D=3D BPF_FD_TYPE_KRETPROBE)
> > +               info->perf_event.kprobe.flags =3D 1;
>
> hm... ok, sorry, I didn't realize that these flags are not part of
> UAPI. I don't think just randomly defining 1 to mean retprobe is a
> good approach. Let's drop flags if there are actually no flags.
>
> How about in addition to BPF_PERF_EVENT_UPROBE add
> BPF_PERF_EVENT_URETPROBE, and for BPF_PERF_EVENT_KPROBE add also
> BPF_PERF_EVENT_KRETPROBE. They will share respective perf_event.uprobe
> and perf_event.kprobe sections in bpf_link_info.
>
> It seems consistent with what we did for bpf_task_fd_type enum.

Good idea. Will do it.


--=20
Regards
Yafang

