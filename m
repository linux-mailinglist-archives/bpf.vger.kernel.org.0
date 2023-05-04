Return-Path: <bpf+bounces-49-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE426F7964
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A692C280F48
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29EC158;
	Thu,  4 May 2023 22:51:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDB156FB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:51:32 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3FF59DB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:51:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so2143767a12.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683240689; x=1685832689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xRB6HOtx8DCO6n5L6e4eUglSmVul7+DzP9jGkKuO5c=;
        b=hNNZpwYK6y9ECjhBmthLlHwUf8nWGL3wHwRjKm+kGWgXBm/5rt2y/TgBxAOFNxCHUU
         rZ9VQHBoFJIH/hW9PSthP6cORHwmOa2ELgAiG7y5+X0DXNqWqhrPqZoPY+eFUE2HOeqv
         KUHS9aM6LXqBQpQY/RiQ7N3G5wg5bHbTHYRN7QD5sngx9cxLCGyvSyexTZ3b5/QrAfbm
         8AzyGdKj/BhHXTx8SIbooOOBIYsmG9YfoeepBN7ZL64lRevKdgRZqCiv+sToTUPfODAH
         OurMH6zuH0gPAsh9Q8tw7yuJN8KXcUVHr5mZQ3ki2f2wiFiE/rHXiak8R3tERJRrQpkk
         ek9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240689; x=1685832689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xRB6HOtx8DCO6n5L6e4eUglSmVul7+DzP9jGkKuO5c=;
        b=bOJB4Ce/LfzP106zmitHgqMYrVTauHXeDdG1KsmZmGmQ7mofdJk5qoySU4bue3Qh8F
         fEwNESGdsKYK5BycGbJ8EH1wQ2NilBo+h7McrSgHdjKbOFGinQb8A6dvRufT70dw8sN6
         /rA/P3HWffDsI2tioseZKR7EtChoyi+9VLeZTbikfFf4fg5VYESeUxAtZoZha8rsdQzF
         3jdBuvgMiWvfoMATxpL9jLLIIi5pBAGiOlbMlRNN/nYc9BT2kqSZFaedrtO+3h19XSou
         nkDJJG2C0AUAKHuIBLTKDsyyZe5ovPbwULcaywa995erplvvY2ur4K1q++UWKrQsH9DE
         L/lA==
X-Gm-Message-State: AC+VfDyk9klOxvobWZGGOVS5slxzilvnFxDoPE0mpF8b4V+OAcIEkH4Q
	zUn0jw4QTQ7hTSh+l0eCPFo8AogTThWb+CyfP1m/7tKC
X-Google-Smtp-Source: ACHHUZ6BhJwoVy7A5efIyVqiIKrsneeuBzKpfxx5Zqzb4P30eQ1XzG+B/PacEiAhncYPL5ZTjN6ya5FRQ2ajLKdRsg4=
X-Received: by 2002:a17:907:1c03:b0:961:8fcd:53bc with SMTP id
 nc3-20020a1709071c0300b009618fcd53bcmr407780ejc.21.1683240688776; Thu, 04 May
 2023 15:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-5-andrii@kernel.org>
 <20230504200544.mikkqyc7h7ftxal3@MacBook-Pro-6.local>
In-Reply-To: <20230504200544.mikkqyc7h7ftxal3@MacBook-Pro-6.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 15:51:16 -0700
Message-ID: <CAEf4BzbT1MNiUC5A0MTFjVvYOsXnh06SHukGgvzx-wdjRV8uHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/10] bpf: remember if bpf_map was unprivileged
 and use that consistently
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 1:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 02, 2023 at 04:06:13PM -0700, Andrii Nakryiko wrote:
> >  }
> >
> > -static struct bpf_map *array_map_alloc(union bpf_attr *attr)
> > +static u32 array_index_mask(u32 max_entries)
> >  {
> > -     bool percpu =3D attr->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY;
> > -     int numa_node =3D bpf_map_attr_numa_node(attr);
> > -     u32 elem_size, index_mask, max_entries;
> > -     bool bypass_spec_v1 =3D bpf_bypass_spec_v1();
>
> static inline bool bpf_bypass_spec_v1(void)
> {
>         return perfmon_capable();
> }
>
> > +             /* unprivileged is OK, but we still record if we had CAP_=
BPF */
> > +             unpriv =3D !bpf_capable();
>
> map->unpriv flag makes sense as !CAP_BPF,
> but it's not equivalent to bpf_bypass_spec_v1.
>

argh, right, it's perfmon_capable() :(

what do you propose? do bpf_capable and perfmon_capable fields for
each map separately? or keep unpriv and add perfmon_capable
separately? or any better ideas?..


> >               break;
> >       default:
> >               WARN(1, "unsupported map type %d", map_type);
> >               return -EPERM;
> >       }
> >
> > +     /* ARRAY-like maps have special sizing provisions for mitigating =
Spectre v1 */
> > +     if (unpriv) {
> > +             switch (map_type) {
> > +             case BPF_MAP_TYPE_ARRAY:
> > +             case BPF_MAP_TYPE_PERCPU_ARRAY:
> > +             case BPF_MAP_TYPE_PROG_ARRAY:
> > +             case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
> > +             case BPF_MAP_TYPE_CGROUP_ARRAY:
> > +             case BPF_MAP_TYPE_ARRAY_OF_MAPS:
> > +                     err =3D bpf_array_adjust_for_spec_v1(attr);
> > +                     if (err)
> > +                             return err;
> > +                     break;
> > +             }
> > +     }
> > +
> >       map =3D ops->map_alloc(attr);
> >       if (IS_ERR(map))
> >               return PTR_ERR(map);
> >       map->ops =3D ops;
> >       map->map_type =3D map_type;
> > +     map->unpriv =3D unpriv;
> >
> >       err =3D bpf_obj_name_cpy(map->name, attr->map_name,
> >                              sizeof(attr->map_name));
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index ff4a8ab99f08..481aaf189183 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8731,11 +8731,9 @@ record_func_map(struct bpf_verifier_env *env, st=
ruct bpf_call_arg_meta *meta,
> >       }
> >
> >       if (!BPF_MAP_PTR(aux->map_ptr_state))
> > -             bpf_map_ptr_store(aux, meta->map_ptr,
> > -                               !meta->map_ptr->bypass_spec_v1);
> > +             bpf_map_ptr_store(aux, meta->map_ptr, meta->map_ptr->unpr=
iv);
> >       else if (BPF_MAP_PTR(aux->map_ptr_state) !=3D meta->map_ptr)
> > -             bpf_map_ptr_store(aux, BPF_MAP_PTR_POISON,
> > -                               !meta->map_ptr->bypass_spec_v1);
> > +             bpf_map_ptr_store(aux, BPF_MAP_PTR_POISON, meta->map_ptr-=
>unpriv);
> >       return 0;
> >  }
> >
> > --
> > 2.34.1
> >

