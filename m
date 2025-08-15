Return-Path: <bpf+bounces-65723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D9B27925
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACCBAA2B24
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9D2BD5B2;
	Fri, 15 Aug 2025 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUM1IxY4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53B293C42;
	Fri, 15 Aug 2025 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755239052; cv=none; b=hr57pHLYCBwIbDsMMTkfFLdwTr9kQcEFrJ32x4en102tRoL7H1wQ/kbdddbwy2odl3IstfXbHBiV9QB0Qsw+J2WW4ZjF8Pp5CLLcuotwkU+EonqHEP6tqQd7/+NlfBXjS/L+iMWxYBdmjKPhnVDubrw3TTQX/Ofx/uo/wbaI3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755239052; c=relaxed/simple;
	bh=iIOcKGg0BZdG2Y1y8FQghjQJrB5hQv30DjYqir25x1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGotRKv7F4eY8dHBXlK8VkKxXwI5gMD1sDU93/q/eR9MpE5sxUjifeuHaJe7CBKYScwicpt7H12VU8zCHT97NbhAI1LJOICQuitOrpqp2o/VBI7TUIls5TQPFFlhr5iOg+V+pd0QYl/vXsG7agSe2qPeJ8ybhujf4qHBq5JA0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUM1IxY4; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e931cae27c5so1696547276.1;
        Thu, 14 Aug 2025 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755239050; x=1755843850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GoQBPhmL2f6FsydtPjyCuCttyD7KlTP/GQ+sRZqNZE=;
        b=mUM1IxY45rb7aH6loKT1L8GEuS5FOM5Nox2uRu9GjKjct/W1jHERt+KwrwWxOLKmu6
         J94KlxWSFVffjWrxvhDWSJvGt9QpjZiMezp2S4Q4Y0uihXmGKzbnuCba24uoIw+ERJEB
         ji6gokZZ1NuQxS8uoMXuIUKJXQrARDfV/9NGOrXyVuoKIKAMuAiUtB0Wsh99WCIpDP3b
         4mDO8pxmKVSDs7sMkGzhAn3Lrulzu1fY1qQpuN+vND5JIkdbQ1f5fziZOmvXxI0lhZQ1
         K0Oy14Kd1ztaK2PQKSQyKSoLXbjabd8hkjmt5zhScXLrJpgJCI/4HDlHXsXaoiUOixVq
         xy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755239050; x=1755843850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GoQBPhmL2f6FsydtPjyCuCttyD7KlTP/GQ+sRZqNZE=;
        b=awyaNuWWMHHLoavh/vz5SxZXsq0N8rgsCDutOSNdG/Q48p8MpwxqHP/0K1f3ApJpwU
         Hb9xPGPiV4EWpg5KUWgwTXJBtG4Q6bWygNoMq1oSGxKBjKVXVO8Y+50/O8SQBhtOufIP
         fD7dheXANDi2Ad/YLF9TrjxQ1h7GIMh8YGxuNjBLmIyt/XHZEEeBccBXAwQBv80AXRRI
         n1TIwxnwr/6wDNzXuohK0R5U3OPjHfOcJxh9p1SkHF15qz0I93SZJs3OzzfPQNV5okLq
         k2wGGVKfX8Qd48sqfii1KUj4sXj1PqcpncNrs8GDsrPPRTxUHdUmLgxX9OeVcerSzmaD
         dYDA==
X-Forwarded-Encrypted: i=1; AJvYcCUl27BFMphA69tROjnkHd7t0/EHTONMAF+Eq0zE6funo1dPu8G86Z8+DTGtB0RStHBCEusOkJa5GjXp0CCTx3YLCMxJ@vger.kernel.org, AJvYcCW+qSeImsYonvBJXv9nURz2utq7JCPQlUYfLEdVGR1arO0xr1jVUVIjuMfauFZAvHDS+Pw=@vger.kernel.org, AJvYcCWqh3LIJ2D2OsYUGeZy8tERRtFEGzHckWHGQmstN2O5kVut+1W8dMczk6kCDwd1hwm/ni69QT0SXnAMnUPY@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiltMk/oMx/CZCSX8mOLIP/fTvbXeO5TqAoaFJsrAm8T2m6Rr
	Gk41ayiepbczvXReZkmOavrLlgzGP7CAQt6++Lg2J5boiV2y1GErQeU0elPiF/SDjuyXsk7AnHp
	C0ytIib6iRuJ88WeMmI/2XNQ2lPjujkHLRm+KbtI=
X-Gm-Gg: ASbGncsvWfkp4E9rkFXylMKSi+wAOvGRCE2grGQc2mRpRkeKLHFALbT8YTNRI1Jki6V
	QkTqjA3kiyBiHgfQwps3EYwkBaW2tCxHwpbZ3Q0i5PL20Zpx/LDbGPDsxJNxokBM8Yo9PPZ1k8B
	nGTIAAOawrbFN4CfDfEDfKXlVzjNXiwHjOkqOp9LM9Ql/DlHKbmqgzhRKCWbLaO12lp9U6c513+
	KCt3nE=
X-Google-Smtp-Source: AGHT+IGRT3oY2R2FJjFrJeAdKNlWxRKqtSPewDT0Fts3pT57ovruUEca55cDWIJcF9IGePWNDHaUwKRB5gUYneoFpOk=
X-Received: by 2002:a05:690c:48c6:b0:71c:4271:c4e3 with SMTP id
 00721157ae682-71e6d90e441mr12082407b3.0.1755239049835; Thu, 14 Aug 2025
 23:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731092433.49367-1-dongml2@chinatelecom.cn>
 <20250731092433.49367-2-dongml2@chinatelecom.cn> <20250815004023.144cfbd9ae39fac9ce80ee98@kernel.org>
In-Reply-To: <20250815004023.144cfbd9ae39fac9ce80ee98@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 15 Aug 2025 14:23:58 +0800
X-Gm-Features: Ac12FXzrFeWoMvqbnjqtW4VN89JarCpfhXGP3yEjG-Q_tJXUzlSuExWxW7z0KlU
Message-ID: <CADxym3YxHOYxZxrdd4vkU_sj8p7VNW=HjLOo9nQgO3jkAAfjng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] fprobe: use rhltable for fprobe_ip_table
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: olsajiri@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	hca@linux.ibm.com, revest@chromium.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:40=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Thu, 31 Jul 2025 17:24:24 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > For now, all the kernel functions who are hooked by the fprobe will be
> > added to the hash table "fprobe_ip_table". The key of it is the functio=
n
> > address, and the value of it is "struct fprobe_hlist_node".
> >
> > The budget of the hash table is FPROBE_IP_TABLE_SIZE, which is 256. And
> > this means the overhead of the hash table lookup will grow linearly if
> > the count of the functions in the fprobe more than 256. When we try to
> > hook all the kernel functions, the overhead will be huge.
> >
> > Therefore, replace the hash table with rhltable to reduce the overhead.
> >
>
> Hi Menglong,
>
> Thanks for update, I have just some nitpicks.
>
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v3:
> > - some format optimization
> > - handle the error that returned from rhltable_insert in
> >   insert_fprobe_node
> > ---
> >  include/linux/fprobe.h |   3 +-
> >  kernel/trace/fprobe.c  | 154 +++++++++++++++++++++++------------------
> >  2 files changed, 90 insertions(+), 67 deletions(-)
> >
> > diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> > index 702099f08929..f5d8982392b9 100644
> > --- a/include/linux/fprobe.h
> > +++ b/include/linux/fprobe.h
> > @@ -7,6 +7,7 @@
> >  #include <linux/ftrace.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/refcount.h>
> > +#include <linux/rhashtable.h>
>
> nit: can you also include this header file in fprobe.c ?

OK!

>
> >  #include <linux/slab.h>
> >
[......]
> >
> >       mutex_lock(&fprobe_mutex);
> > -     for (i =3D 0; i < FPROBE_IP_TABLE_SIZE; i++)
> > -             fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &a=
list);
> > +     rhashtable_walk_enter(&fprobe_ip_table.ht, &iter);
>
> nit: Use rhltable_walk_enter() instead.

OK!

I'll send the V4 later with these nitpicks fixed.

Thanks!
Menglong Dong

>
> Others looks good to me.
>
> Thank you,
>
> > +     do {
> > +             rhashtable_walk_start(&iter);
> > +
> > +             while ((node =3D rhashtable_walk_next(&iter)) && !IS_ERR(=
node))
> > +                     fprobe_remove_node_in_module(mod, node, &alist);
> > +
> > +             rhashtable_walk_stop(&iter);
> > +     } while (node =3D=3D ERR_PTR(-EAGAIN));
> > +     rhashtable_walk_exit(&iter);
> >
> >       if (alist.index < alist.size && alist.index > 0)
> >               ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> > @@ -722,8 +729,16 @@ int register_fprobe_ips(struct fprobe *fp, unsigne=
d long *addrs, int num)
> >       ret =3D fprobe_graph_add_ips(addrs, num);
> >       if (!ret) {
> >               add_fprobe_hash(fp);
> > -             for (i =3D 0; i < hlist_array->size; i++)
> > -                     insert_fprobe_node(&hlist_array->array[i]);
> > +             for (i =3D 0; i < hlist_array->size; i++) {
> > +                     ret =3D insert_fprobe_node(&hlist_array->array[i]=
);
> > +                     if (ret)
> > +                             break;
> > +             }
> > +             /* fallback on insert error */
> > +             if (ret) {
> > +                     for (i--; i >=3D 0; i--)
> > +                             delete_fprobe_node(&hlist_array->array[i]=
);
> > +             }
> >       }
> >       mutex_unlock(&fprobe_mutex);
> >
> > @@ -819,3 +834,10 @@ int unregister_fprobe(struct fprobe *fp)
> >       return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(unregister_fprobe);
> > +
> > +static int __init fprobe_initcall(void)
> > +{
> > +     rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
> > +     return 0;
> > +}
> > +late_initcall(fprobe_initcall);
> > --
> > 2.50.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

