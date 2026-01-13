Return-Path: <bpf+bounces-78709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E20D18E7D
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4CFB300EA15
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5E538F228;
	Tue, 13 Jan 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV/19Eyz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02C38BDD3
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308531; cv=none; b=GldTtRgzENuZ589/DLle+MbOFiof+7lt53Sf6MvDsLH7o8XJECT1hYAmgUThyWgXVbqjEAoA9l20Uspk91hKP8nk4BmTem/085+AIg58obCt8d5MoeDdFkP1mf980pwngz9D4/tiYACgYvGKul0wCbBAjiAmt+VywaTdHGnRLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308531; c=relaxed/simple;
	bh=fPvScNJm08GXpxdP/lDXFxyU87ddHt7Npp9XynNH5c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEj7xM6KXEbJIuLBMRbYT/tKQ8vdQTefyV6ulEu6R5un+z1Xv5Fo4vLfot2TgwzeA1ovX/7ek18GsmZfyTppOfzFEWT2OShARtt2mU9sA1ggVqo1CZQSkZQ3/7teINIfUb+I+qZ8vnIalw2xjeAb1gVJ/KyobJIMj+4WW00SjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV/19Eyz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7926d5dbdf7so30750897b3.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768308529; x=1768913329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNnW6s/SZBu2UFj4TzBUvNaszCcdwzNSNbMjemvajVs=;
        b=PV/19EyzsQPxOG6XOlCHx159aBC4sKUkD3q1xIYi3mhVa4g7oDpi8+hEP2qFobDmNe
         V54FIDOavivMyc9auvJStBZV1585wIYxPLNtE9SVKS5MUzbCM9TdAHmV6eIV6Ic1OjQI
         /+W98MBuCfEpJnoQn8Pz0NyX1PiPlDkgkhkbOyMnU3F4wYEVA9Gr0cNFkYT8ziqErc2C
         Yi2Obrj/BNg1sgq9q/zhWEGW2NvQw5mhl/EUKpLuEgOtUzHODc9NzyRyrL6uCCeEoXEe
         9ucyX1kjCx7iJRvyvsTwo/JWBh9oobc0t0E+RkLUC4Variq81XzCHdmubZP3LNu+/k24
         f7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768308529; x=1768913329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNnW6s/SZBu2UFj4TzBUvNaszCcdwzNSNbMjemvajVs=;
        b=Yh8eIimLv6XK6bPgVYBG1SPpOzV4IMHV+lft1tVhxFI7SlNbQQA0FEThW5/9VhIe7c
         VXcodDfE2bYlqfV5e1nJE2IufkGe9qaAkmrtgV7rpBOxehEic5p/PH4zwnNWt0gZ/GKB
         e4kNP+D2r/wZK2X9A5wbsFcrRaW7toFj8yzAKY1qYMXLaJmXAP/fkKQYtaPePWWpyQ5B
         lDEbh7HZdGNvi3prVFoE89U9QXOzajHGOvB71B9/L62TWxelUUwGzwIPsCmJRqT1vcTo
         SCYNif2Zda3ySNiimIn+eWBS9heB/HB91RDle9HXZ60T6rfoUEqkXYN/xHnbAMeXOHHl
         t/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLaQAT7JCbpYoWAw1A87o1fSWvSRBeBd000YercDwnh69auDT81+6av8RJgVolKJgWiN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMOENT84F2UmSo6VQ/J71ya2gciY1+UUIdYI1VsXWr7q9YlXeX
	kXI3tZo8XmsbXW13iaKhLizpOBNE96nUAaiDLcjeB1kQpyyBbb78oSHlAUnbbhOwtLH+URO+qFg
	LPHOz+Vvsm34zGPJUy9ZOJNWbYJLB3HU=
X-Gm-Gg: AY/fxX56O4ytgI0X0wbDfzfL+sr0IghPMrG+0zUQMcsrQtnT0tAarOISMbmsBbhBHSn
	he9IAb81PkkPrUqjhnuZ4GoEF73a2aWCDEXhdI4RXeFtlapgV+D0iC43szbHni7+Q8JuBg05eN0
	qe/rifreuZyPkOuCtVGX6SsdI64lUqZFRp95bbUpHdQcrXUCJku1lgIPKJ8DroarbNHRDWYhZGj
	Ovuj5cmtu1IcVH8s6/ScKnDNe7wD7KQiXWBxybR+Zel5ofR4L94biRYVbiWdBuaE1xQdEiD
X-Google-Smtp-Source: AGHT+IEO+jCG41UHQ6838e+tPw5huBXcqk+s+AkfZLQAlFsLAzSWXyjDX1MlYDTJJGPecL0Slihr38A2K7DlI7o25g8=
X-Received: by 2002:a05:690e:4086:b0:644:7b59:4219 with SMTP id
 956f58d0204a3-64716b5f6demr18280157d50.10.1768308529217; Tue, 13 Jan 2026
 04:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113121238.11300-2-laoar.shao@gmail.com> <8496feb711aed72644504926d9ff358550c011e3144dea088833ad723f4fe852@mail.kernel.org>
In-Reply-To: <8496feb711aed72644504926d9ff358550c011e3144dea088833ad723f4fe852@mail.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 13 Jan 2026 20:48:13 +0800
X-Gm-Features: AZwV_Qj-roTiKDhQLS2IgDQjyIWDFWT5_Ypxc1AEvOfjfWTRTIJJ48nOdOvssl8
Message-ID: <CALOAHbB_PNGrQ1t3Cz0P0dvLtY2tv9o4DJ=g-U1o_6JuLUNK+g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/3] sched: add helpers for numa balancing
To: bot+bpf-ci@kernel.org
Cc: roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, mkoutny@suse.com, yu.c.chen@intel.com, zhao1.liu@intel.com, 
	bpf@vger.kernel.org, linux-mm@kvack.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 8:42=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched=
/numa_balancing.h
> > index 52b22c5c396d..792b6665f476 100644
> > --- a/include/linux/sched/numa_balancing.h
> > +++ b/include/linux/sched/numa_balancing.h
>
> [ ... ]
>
> > @@ -32,6 +33,28 @@ extern void set_numabalancing_state(bool enabled);
> > extern void task_numa_free(struct task_struct *p, bool final);
> > bool should_numa_migrate_memory(struct task_struct *p, struct folio *fo=
lio,
> >                               int src_nid, int dst_cpu);
> > +
> > +extern struct static_key_false sched_numa_balancing;
> > +static inline bool task_numab_enabled(struct task_struct *p)
> > +{
> > +     if (static_branch_unlikely(&sched_numa_balancing))
> > +             return true;
> > +     return false;
> > +}
> > +
> > +static inline bool task_numab_mode_normal(void)
> > +{
> > +     if (sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL)
> > +             return true;
> > +     return false;
> > +}
> > +
> > +static inline bool task_numab_mode_tiering(void)
> > +{
> > +     if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
> > +             return true;
> > +     return false;
> > +}
> >  #else
> >  static inline void task_numa_fault(int last_node, int node, int pages,
> >                                  int flags)
>
> [ ... ]
>
> > @@ -52,6 +75,10 @@ static inline bool should_numa_migrate_memory(struct=
 task_struct *p,
> >  {
> >       return true;
> >  }
> > +static inline bool task_numab_enabled(struct task_struct *p)
> > +{
> > +     return false;
> > +}
> >  #endif
>
> The #else block adds a stub for task_numab_enabled(), but task_numab_mode=
_normal()
> and task_numab_mode_tiering() are missing from this section. These helper=
s are
> defined when CONFIG_NUMA_BALANCING is enabled, but have no stubs when it =
is
> disabled.
>
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 670fe9fae5ba..7ee5695326e3 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
>
> [ ... ]
>
> > @@ -4843,9 +4844,7 @@ static bool should_abort_scan(struct lruvec *lruv=
ec, struct scan_control *sc)
> >       if (!current_is_kswapd() || sc->order)
> >               return false;
> >
> > -     mark =3D sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERI=
NG ?
> > -            WMARK_PROMO : WMARK_HIGH;
> > -
> > +     mark =3D task_numab_mode_tiering() ? WMARK_PROMO : WMARK_HIGH;
>
> [ ... ]
>
> > @@ -6774,7 +6773,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int =
order, int highest_zoneidx)
> >               enum zone_stat_item item;
> >               unsigned long free_pages;
> >
> > -             if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TI=
ERING)
> > +             if (task_numab_mode_tiering())
> >                       mark =3D promo_wmark_pages(zone);
>
> The original sysctl_numa_balancing_mode is defined to 0 when CONFIG_NUMA_=
BALANCING
> is disabled (see include/linux/sched/sysctl.h), allowing this code to com=
pile and
> work correctly in both configurations. The new task_numab_mode_tiering() =
helper
> lacks a stub in the #else block, so should_abort_scan() and pgdat_balance=
d() in
> mm/vmscan.c will fail to compile when CONFIG_NUMA_BALANCING is not enable=
d.
>
> Would it make sense to add stubs for task_numab_mode_normal() and
> task_numab_mode_tiering() to the #else block, returning false to match th=
e
> original behavior when sysctl_numa_balancing_mode is defined as 0?

Right.
I missed it.  Thanks for the review.

--=20
Regards
Yafang

