Return-Path: <bpf+bounces-65830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D635B29116
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 03:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8ED4478D8
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 01:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048319CC0A;
	Sun, 17 Aug 2025 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIHOeayB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A0A945;
	Sun, 17 Aug 2025 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755395026; cv=none; b=Eh/Ttzpg6H+a2B/1xLavDwUCT8wRyNmBzfSnYwWVdXfl2v5wv2v43Y8D0isgUJDfbEw88Sw/8CiSklL79LZ506oXZz8xM+gqEmK6kvIjOlUZfXl0K9HFe5LCBGviRJGdTlytMn9Wb0YBsu5THAxUHWhtrQs1OfcOq4exGPmE1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755395026; c=relaxed/simple;
	bh=Ldphmxx17wVU8IiRaBaI/KiZxrw5Qx2VOfoV694tjDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pj7ujb9NuYw00o9pqYojdUu+BSfky+fd2GMEDZYvdQf9VWCtLxvcSjd/8gJB3G0crXodpqaOxCnqKKD30v9myIJoi8QlZ7aV3Nl+cneQ72/PPL8shAe2SI9yNsZ91+84VM/d3P4EoigU/k/Kk9HNoNOLMOHD6ly2Q3ny1LYPEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIHOeayB; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e931cdd710dso2443669276.3;
        Sat, 16 Aug 2025 18:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755395024; x=1755999824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INXjray7KhWQ4s+QUawoYGEHlUpc1WH3+1Uq1L8isXQ=;
        b=AIHOeayBinnqRRHYOjYofTTPUentBKgX/qJHBzQAXHJmkd2Fn67v4onG0qs9UjfRhE
         P7TcgXRxRymurEOk3OwgvCZHLZHnj4CXLOb4lQvyF8hNWIheZQIe/d50afiIiCqO3xJS
         qRklNYsNEQYbugeY9mWpHBjA5xfI/haf5jf/OXXt/5GwRTME7QYOOtoL71EbhoE8wIHX
         PtbjAjyLl/esLpgXIYN0SA41S6hnriW5tuhvR+iUhjWD6di7FUJrP+bmA0HRyeemJWyl
         FrXE0O/vQQK97BZ6t2rtA+GWgWlsaaMhHxVF7tU7bJw1G9WpkpU4+Ml8hZatJqrMNKpu
         4uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755395024; x=1755999824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INXjray7KhWQ4s+QUawoYGEHlUpc1WH3+1Uq1L8isXQ=;
        b=JSgnZ0dgUUjG01+PY0CHSeLoeO2LiOJ4JvJ42tO62D0NJaCWhl1u0LHzF2qC/fHNOr
         sAdqXfmaYGfnAsr07Rc7mlRn929Dj3LJWYkmBA4UE9pfN+4EDI9LRWEBqGGkJrLI4tF9
         otHq2uFRTXFqTOwatmEVJot4KVzUqnG50UvCaT8xjORh5XUgDeu/q4SUrwSlDQKS2AqD
         vmmv2bKKWmfMmsUVciQe5NshVEjnYefiA6NVTLAk2bToRRvNetvlo3IjilWlzAexIS7j
         tywcojYDMH5/m9GMYa7Rrf+e1cl/aP3f5HblLv9j9EYoo0D6Xa1WfoZg2g9X/Phz6aOE
         v51A==
X-Forwarded-Encrypted: i=1; AJvYcCUAB1G5OoFmd0XuXAoItpTEvC+BFKzQ/fHCGH1NuzSQC31vf8lLdpuUC4Orob7AMgbf3IE=@vger.kernel.org, AJvYcCVNAgYNqH74dMxeWieZhOHJDRfRJHhDQzBczQJpdC01v31AeSoyLLuRMuyC3K8jQvMcuvisZ6Wq2dZJjyDh@vger.kernel.org, AJvYcCVtNpsoeC/eBYtfkqs71wm1mti/Qhxzr3Q/aK9G9bnAvsdRNPcuyQIZR2OzoYzbSLi0I4NRavhLLXqxdDplMwfHW6Yw@vger.kernel.org
X-Gm-Message-State: AOJu0YzyaclJLdOC+kVEq0VX8gLB6iw3TMdX7rn81ZjomYoaHhIMAvZO
	ABudAa4YMcP5pokwcBGgIVJGlktWiNZ5q7OMKDO50pNsazSQr0ooa3AnuqUxh//uQY/0/lCyLTF
	ur8Ca2DP1hBZfOqm9IIfrXeY1mOzWuh8=
X-Gm-Gg: ASbGncukkMJxh1dB56AQZEP/TbPGgUdubK1Fb4bFncAFpCgEgzPrvdQyAhi9xh5ZFOn
	MFbceZBhql0fwSkN18l//iyDQcyNRpt4sEcXG1FiA25Mtzt27Gs0n1ehUnEk9l6BSRgrROxN2S5
	3gMk7wgJUlNqOn2KnFM/Rck68dHsQijVM4A8wfNp8gK7mgu5dTSn/iLKjgwR+ZG0A25NnTc8Z/F
	ON8+Tg=
X-Google-Smtp-Source: AGHT+IEdmHjLEhNrrPe88/9otODp0jGP4SLgUq93HvJ/zwzTf61gOYM24Jdh4H02MTUmZEZnCbgFken126vUKD8I7bE=
X-Received: by 2002:a05:690c:34ca:b0:71c:b49:4879 with SMTP id
 00721157ae682-71e6de1f3d5mr98075227b3.36.1755395024187; Sat, 16 Aug 2025
 18:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815064712.771089-1-dongml2@chinatelecom.cn>
 <20250815064712.771089-2-dongml2@chinatelecom.cn> <20250816235023.4dabfbc13a46a859de61cf4d@kernel.org>
In-Reply-To: <20250816235023.4dabfbc13a46a859de61cf4d@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 17 Aug 2025 09:43:33 +0800
X-Gm-Features: Ac12FXwJnuBAOlqW8UHquiz2FqvX4iBojjrgqgjpgY4dXwRalvFvbvrc_28gXwQ
Message-ID: <CADxym3YB69_mZPWqupocOCvBju2ugNcO7hSddwfv+Xp4dAEgEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] fprobe: use rhltable for fprobe_ip_table
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: olsajiri@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	hca@linux.ibm.com, revest@chromium.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 10:50=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> Hi Menglong,
>
> Sorry, one more thing.
>
> > @@ -260,14 +263,12 @@ static int fprobe_entry(struct ftrace_graph_ent *=
trace, struct fgraph_ops *gops,
> >       if (WARN_ON_ONCE(!fregs))
> >               return 0;
> >
> > -     first =3D node =3D find_first_fprobe_node(func);
> > -     if (unlikely(!first))
> > -             return 0;
> > -
> > +     rcu_read_lock();
>
> Actually, we don't need these rcu_read_lock() in this function, because
> the caller function_graph_enter_regs() uses ftrace_test_recursion_trylock=
()
> which disables preemption. Thus we don't need to do this again here.

Yeah, I understand it now. I wondered about this part
for a long time, as I didn't see any RCU lock in the
fprobe_entry(). Thanks for the explanation ;)

I'll send a V5 now.

>
> > +     head =3D rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_para=
ms);
> >       reserved_words =3D 0;
> > -     hlist_for_each_entry_from_rcu(node, hlist) {
> > +     rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >               if (node->addr !=3D func)
> > -                     break;
> > +                     continue;
> >               fp =3D READ_ONCE(node->fp);
> >               if (!fp || !fp->exit_handler)
> >                       continue;
> > @@ -278,17 +279,19 @@ static int fprobe_entry(struct ftrace_graph_ent *=
trace, struct fgraph_ops *gops,
> >               reserved_words +=3D
> >                       FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->ent=
ry_data_size);
> >       }
> > -     node =3D first;
> > +     rcu_read_unlock();
> >       if (reserved_words) {
> >               fgraph_data =3D fgraph_reserve_data(gops->idx, reserved_w=
ords * sizeof(long));
> >               if (unlikely(!fgraph_data)) {
> > -                     hlist_for_each_entry_from_rcu(node, hlist) {
> > +                     rcu_read_lock();
>
> Ditto.
>
> > +                     rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >                               if (node->addr !=3D func)
> > -                                     break;
> > +                                     continue;
> >                               fp =3D READ_ONCE(node->fp);
> >                               if (fp && !fprobe_disabled(fp))
> >                                       fp->nmissed++;
> >                       }
> > +                     rcu_read_unlock();
> >                       return 0;
> >               }
> >       }
>
> Thank you,
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

