Return-Path: <bpf+bounces-59178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E619AC6D77
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 18:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37301C00684
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154E28BABC;
	Wed, 28 May 2025 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AicoMd/h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D792E401
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448316; cv=none; b=TDIZgKeBQ1LrplnhvTErooIISQCpm4Q0rkVsTcHEe0njhLbD3Wr94cxn6F+AxrUc4W+5usL51k6Shk2ggHEtNGrTiulv+qnd+Qwz+Xf0skR51AlDanzlWcswEMsrmmmGaVqFfKGtWaa169lmZvlHE0RGoEW87v5qeZK23MZ0FUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448316; c=relaxed/simple;
	bh=7s+rlihC0one1sWeMyAPi7eCkoG2SZ3y6zbSgxP3I+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvrSnb2P2jzdwyuIy28bdVGqzBifhTxMhY55L3ZNGkngY9j5m+37H5i5raB7XByXdPgZULXuANpROdIqJK9WwyTa2Q5l9nrmO3tyawhoKNid6rUlP3C4RiBS6aB8qjVlxMOzp+dAbq4xUmC900QTWCtLXnoAP/S4qQvRuyoarkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AicoMd/h; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311ef4fb549so632489a91.2
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748448314; x=1749053114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOTrPO5qtqYs4V6iaLY8+zAPepne5PCcERMY0TE9erQ=;
        b=AicoMd/hDMGMuIJKjcrYibUjpDtcRgih12/CWZEY5Ym82MBboTCZ539kzW1chTIjUo
         IcWdxxM6mSYU4XURlnkH2ZJWtB10OsXVNH47PSfemfZ5Ni0+UAUhDY7U+Pwu/D71jy7F
         vPargNuo+YIh06hzUo8T+Ce+Td06n/c+Jm+t03fuIla0I2w2TbQdbO2q5DPNKsrZnl/6
         Hkaj7UoVvaB7dRyui/0EhwAKsLO8Y2C7zYsPF4LyHdYBqeICVPYpYTnkKETho1SRcnsp
         qv1bTtojmknE4GiHdBEU6QnlcUHAWOVcizlHe6oo5L03LHAiDAjroVUuPZPJvBOucFXD
         YR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748448314; x=1749053114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOTrPO5qtqYs4V6iaLY8+zAPepne5PCcERMY0TE9erQ=;
        b=pmQevrpzwLErjtS1PI4ymcZOcgfPle/Hq1dFV1oyK+z3buFZWJWQi+7i/sDilRKfrg
         rh/b2VFW7mPLbVSEC3WkVGwgbCofbenm8wJsju7tyErLrBLSmt/+UChcGTe+yaGOK3/S
         3lR8Z/riewQRdp/vq6Z3CJjSfODrH9ju1VG9YNvdIVnVkruv/Ob4ZKSSD53ODJuAlPUc
         SdH8g2VNnxwOJZpG5k5O8l7rNqzSbLdiNYL2Tz1gdM2kBUjD5mYeyflRVJdRFJo6hbZj
         gTImWGdlrrRUaIapQnMUoTW5EkBJJULJh/Kd7kCA/FW+7Mcp+bGf3Sb1OhEDpJdo14d+
         7JJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl1iqAn6tR53GjqUNIbp62OUjnzsexsx3VnIFgLzKvzxYbQb/8p6bLDzI+7Uas7xMqz78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kFif2ZBVbAz1Fo1F56h0Kk4jcuqoQkKHfcNS/pYtaliv7YeR
	zIf9Q456/6M1SE7TUd9sWhyJXSCyos+ECTbKy1s6KcANX4dDcfOmpMVxDfetaCRcfT5wMILZ9q+
	LKD1lblc210HLQZxPOsyHHzsvsXtp1mM=
X-Gm-Gg: ASbGncvUqlcD3Aq26AMWZeLMjxy9nJG3XJ8KqUR5sLjscsIb8oMcmLjqLIai4JPuv9u
	0uuduPoS2JsT0pJNWgkHrbx+Bg2RDAYvYY211auT9p+RHMSVqpYjGX5XxZf70PtlxdTuAqdsYib
	Q6/YvO7SVXMyh9EnlvQuGjseTO3sBTR18=
X-Google-Smtp-Source: AGHT+IGswV08sSAmvSn8euvMWiEC52hHfQGxnOl+5ZPO3/HOmOkA+a1aOi21b41KCkMzZe3VicGM8wsCIgOtaEbT2Kw=
X-Received: by 2002:a17:90b:3ece:b0:301:9f62:a944 with SMTP id
 98e67ed59e1d1-311e7470efdmr5042892a91.33.1748448313856; Wed, 28 May 2025
 09:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev> <20250526162146.24429-3-leon.hwang@linux.dev>
 <CAADnVQJZ1dpSf3AtfNsvovogfC75eVs=PiYXMivUpDHDow3Row@mail.gmail.com>
 <CAEf4Bzbw9G4HhL4_ecbgc2=bDbZuVEA2zLnChgqT_WCsq11krQ@mail.gmail.com> <CAADnVQLxzJMAYymtWMFZb6eAK+ha_shRfh+m3W3yFO4dLn-YeA@mail.gmail.com>
In-Reply-To: <CAADnVQLxzJMAYymtWMFZb6eAK+ha_shRfh+m3W3yFO4dLn-YeA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 May 2025 09:05:01 -0700
X-Gm-Features: AX0GCFt0G6gRbR-3aavka374rCKMS4xOT5nCCqepxY2qodWhchRbvjZngVAn67M
Message-ID: <CAEf4BzYUW4oAm4JJ-Kh4HhtfP4GXuQFx+tJ3p7vjMpPYoVv5GQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf, libbpf: Support global percpu data
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:35=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 27, 2025 at 4:25=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, May 27, 2025 at 3:40=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, May 26, 2025 at 9:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.=
dev> wrote:
> > > > +
> > > > +       data_sz =3D map->def.value_size;
> > > > +       if (is_percpu) {
> > > > +               num_cpus =3D libbpf_num_possible_cpus();
> > > > +               if (num_cpus < 0) {
> > > > +                       err =3D num_cpus;
> > > > +                       return err;
> > > > +               }
> > > > +
> > > > +               data_sz =3D data_sz * num_cpus;
> > > > +               data =3D malloc(data_sz);
> > > > +               if (!data) {
> > > > +                       err =3D -ENOMEM;
> > > > +                       return err;
> > > > +               }
> > > > +
> > > > +               elem_sz =3D map->def.value_size;
> > > > +               for (i =3D 0; i < num_cpus; i++)
> > > > +                       memcpy(data + i * elem_sz, map->mmaped, ele=
m_sz);
> > > > +       } else {
> > > > +               data =3D map->mmaped;
> > > > +       }
> > > >
> > > >         if (obj->gen_loader) {
> > > >                 bpf_gen__map_update_elem(obj->gen_loader, map - obj=
->maps,
> > > > -                                        map->mmaped, map->def.valu=
e_size);
> > > > +                                        data, data_sz);
> > >
> > > I missed it earlier, but now I wonder how this is supposed to work ?
> > > skel and lskel may be generated on a system with N cpus,
> > > but loaded with M cpus.
> > >
> > > Another concern is num_cpus multiplier can be huge.
> > > lksel adds all that init data into a global array.
> > > Pls avoid this multiplier.
> >
> > Hm... For skel, the number of CPUs at runtime isn't a problem, it's
> > only memory waste for this temporary data. But it is forced on us by
> > kernel contract for MAP_UPDATE_ELEM for per-CPU maps.
> >
> > Should we have a flag for map update command for per-CPU maps that
> > would mean "use this data as a value for each CPU"? Then we can
> > provide just a small piece of initialization data and not have to rely
> > on the number of CPUs. This will also make lskel part very simple.
>
> Initially it felt too specific, but I think it makes sense.
> The contract was too restrictive. Let's add the flag.
>
> > Alternatively (and perhaps more flexibly) we can extend
> > MAP_UPDATE_ELEM with ability to specify specific CPU for per-CPU maps.
> > I'd probably have a MAP_LOOKUP_ELEM counterpart for this as well. Then
> > skeleton/light skeleton code can iterate given number of times to
> > initialize all CPUs using small initial data image.
>
> I guess this can be a follow up.
> With extra flag lookup/update/delete can look into a new field
> in that anonymous struct:
>         struct { /* anonymous struct used by BPF_MAP_*_ELEM and
> BPF_MAP_FREEZE commands */
>                 __u32           map_fd;
>                 __aligned_u64   key;
>                 union {
>                         __aligned_u64 value;
>                         __aligned_u64 next_key;
>                 };
>                 __u64           flags;
>         };
>

Yep, we'd have two flags: one for "apply across all CPUs", and another
meaning "apply for specified CPU" + new CPU number field. Or the same
flag with a special CPU number value (0xffffffff?).

> There is also "batch" version of lookup/update/delete.
> They probably will need to be extended as well for consistency ?
> So I'd only go with the "use data to update all CPUs" flag for now.

Agreed. But also looking at generic_map_update_batch() it seems like
it just routes everything through single-element updates, so it
shouldn't be hard to add batch support for all this either.

