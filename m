Return-Path: <bpf+bounces-64530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F1B13D8D
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D84C188C461
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5F926F467;
	Mon, 28 Jul 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUo020F/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F125C809;
	Mon, 28 Jul 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713860; cv=none; b=KfArT2KJo9zYL4T7v0mjZ7YyX+kUaLVsQIURWQZDqS7TueOTX0T8hEltLgdcJFHgPV0QcQgwtXzEYr6NhgRMKp4R2HCHk/0ZZ+dHqKF49/MMbLtUpGTFf4VA80B2EwYnDJXLXNUMjAgq09BmzPaoCF1tG9AIYW4NSEqnqylrrQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713860; c=relaxed/simple;
	bh=wsr1LSR7+n0Itpa/QPxmLvKnRmNsZ0SzdvviS0DEzA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAYxHJxC4TcJgJ/JFNfdmlnGRP2EWkAuJ5qPOdyeTiZZHBYwdLEyoh81YsXEtVNAziNBBhKaeYdrG3aY9erC65MHsC6pAEebfmxyHUJ4BGizXobeer3bzpRdvmXzCz4HFeVN1p/m7wTQhhqGHqd3Hb5yThrMfvbSwC/6REgG9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUo020F/; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e8986a25cbfso2966072276.0;
        Mon, 28 Jul 2025 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753713858; x=1754318658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkhIo9S2NuUPn8Ju9aHWFElGQrfosb66aaSoTyONGdM=;
        b=IUo020F/qNkTExkXPuZcrT/9u1gBl9tFCmi/43wxYWMSZu84U68m71GIU41HicOuHa
         B3btFkW/Hxt791uhKF8udjO0zKKgck4RgHkhgI0POLuUT0/qSaRFhQfs053dhR1J+Xtj
         nl4xD+TWE0co3uvIA/LDZe0/1BJbYgKtKs5XLeGWdRlUw7kQs7GgDHWjW2AbLFWAMfTU
         uQPjut7CeetkRZ60i5wumUCdfrpDOuG/brKix56LrQUSVu22LFugJ+IqjPtzAhG/cJvI
         c/W8JozHdj9gGpYm98pynZXuqqgT5nnB/dMlgqV22bAGSmGK3OW0OMB5G1MGbewbM5M8
         mjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753713858; x=1754318658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkhIo9S2NuUPn8Ju9aHWFElGQrfosb66aaSoTyONGdM=;
        b=U3cTYzwjBgOVd0cz/+qev2GNMbj96D49Lhev3zDWPeBbTkYH4UVnymGZFMQAsvZGEu
         UbVStN/T7RohUOP8FsAiXQSV1+hOSt+7lcHqjO2VlqFdueslQ9fvexrEVfhQuVobUkp2
         VqxvPxLL2e314tjhzWhD5JygT1k6ysybI6NIZdraO81q8Mj3QYIqWlc5IoHOFLnPH0bh
         EB6aH+92TSDPlh0P4/CjDA0XjsxFLVtElc9mHdQYhCkPeLDUcJ+itHw+BKyhd91IUwiU
         9l5xDiLeAAi1juY9SLkjqtF8PmbvszQEccfy3Nxbe8q8reEzWIonw3JycKDfkce0Nzwh
         +i4w==
X-Forwarded-Encrypted: i=1; AJvYcCU8x6s/x5YSktFPYCeBMNCUViffA1gz554zkxHjCTChvNI5ze29xmrJ9den9Qcvxm+/RqdWeFjkx/aU3ClHAjqm/2qM@vger.kernel.org, AJvYcCUZywvVKqBK6VxJeowAWCY39QG8HwGv+lFKG3EiTa34OcwyaKkTgpHW+oOB2NrWSOOQhEk=@vger.kernel.org, AJvYcCV89/uMVOqIg49JQeCwOGrVRTQI924obGX48gUf15dKKuxp0Zw8CtmE5+fpg4eMcKLIMf8qrWOMB/5LJ/dO@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2nblYTczp9f10WVuyHoUgedAu2ce4eRUzew/01bOTy+j/gUn
	kikhSknTLrFC1kpRT+0tdrSek8bnEtjCdbTHsGEsQU7eLeClJt1BTn5VWWGsXrIvwOtwocySu38
	cqybmiit8oe3B6flvPnq++Buvo3CYuis=
X-Gm-Gg: ASbGncsGFBzIBneECNZNTtqRyFn/qsmxLknrVpA+y99m6hMvj5adiFkpYmgxji9wmM+
	wVWL1CpF60IXMVrdblPqX5vtQE0I8222k3CHXb/wB6U3V6TLmqqItqsak4eXhxb6Dk/EszijGj2
	kX2hj+/sqDbfdAWL6t7SvhAxxUZ7JFQ+Qkccl6Tvkk7kITOJvrONn53bmmEU8r2TDG5TmX+aaA9
	Q7hbeo=
X-Google-Smtp-Source: AGHT+IGw+BV5iIkJd0xeq+J18BCm8tecXqc78tbEg2RaKDEo5C3nuDCIfgSCSjMoVOvoKdgqUIpwPyRO/aa0OjrYd+I=
X-Received: by 2002:a05:6902:701:b0:e8b:cf19:6675 with SMTP id
 3f1490d57ef6-e8df12529f5mr13184248276.33.1753713857691; Mon, 28 Jul 2025
 07:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728041252.441040-1-dongml2@chinatelecom.cn>
 <20250728041252.441040-2-dongml2@chinatelecom.cn> <aId3ZSnlZRzoDUHC@krava>
In-Reply-To: <aId3ZSnlZRzoDUHC@krava>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 28 Jul 2025 22:44:07 +0800
X-Gm-Features: Ac12FXz9yDuGxyUUvq1yq2Xivxcq9LfAFipWjSp370RUODg_l7KddnP3JNIeLfk
Message-ID: <CADxym3YdOkcr-Jr-NkDUu4HqU7x_5Rwgiz6PS32BktGuLcBJRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] fprobe: use rhashtable
To: Jiri Olsa <olsajiri@gmail.com>
Cc: alexei.starovoitov@gmail.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, hca@linux.ibm.com, revest@chromium.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:13=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jul 28, 2025 at 12:12:48PM +0800, Menglong Dong wrote:
>
> SNIP
>
> > +static const struct rhashtable_params fprobe_rht_params =3D {
> > +     .head_offset            =3D offsetof(struct fprobe_hlist_node, hl=
ist),
> > +     .key_offset             =3D offsetof(struct fprobe_hlist_node, ad=
dr),
> > +     .key_len                =3D sizeof_field(struct fprobe_hlist_node=
, addr),
> > +     .hashfn                 =3D fprobe_node_hashfn,
> > +     .obj_hashfn             =3D fprobe_node_obj_hashfn,
> > +     .obj_cmpfn              =3D fprobe_node_cmp,
> > +     .automatic_shrinking    =3D true,
> > +};
> >
> >  /* Node insertion and deletion requires the fprobe_mutex */
> >  static void insert_fprobe_node(struct fprobe_hlist_node *node)
> >  {
> > -     unsigned long ip =3D node->addr;
> > -     struct fprobe_hlist_node *next;
> > -     struct hlist_head *head;
> > -
> >       lockdep_assert_held(&fprobe_mutex);
> >
> > -     next =3D find_first_fprobe_node(ip);
> > -     if (next) {
> > -             hlist_add_before_rcu(&node->hlist, &next->hlist);
> > -             return;
> > -     }
> > -     head =3D &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BIT=
S)];
> > -     hlist_add_head_rcu(&node->hlist, head);
> > +     rhashtable_insert_fast(&fprobe_ip_table, &node->hlist,
> > +                            fprobe_rht_params);
>
> onw that rhashtable_insert_fast can fail, I think insert_fprobe_node
> needs to be able to fail as well

You are right, the insert_fprobe_node should return a error and
be handled properly.

>
> >  }
> >
> >  /* Return true if there are synonims */
> > @@ -92,9 +93,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_n=
ode *node)
> >       /* Avoid double deleting */
> >       if (READ_ONCE(node->fp) !=3D NULL) {
> >               WRITE_ONCE(node->fp, NULL);
> > -             hlist_del_rcu(&node->hlist);
> > +             rhashtable_remove_fast(&fprobe_ip_table, &node->hlist,
> > +                                    fprobe_rht_params);
>
> I guess this one can't fail in here.. ?

Yeah, the only failure is the entry doesn't exist in the hash
table.

BTW, the usage of rhltable is similar to rhashtable, and the
comment here is valid in the V2 too.

Thanks!
Menglong Dong

>
> jirka
>
> >       }
> > -     return !!find_first_fprobe_node(node->addr);
> > +     return !!rhashtable_lookup_fast(&fprobe_ip_table, &node->addr,
> > +                                     fprobe_rht_params);
> >  }
> >
>
> SNIP

