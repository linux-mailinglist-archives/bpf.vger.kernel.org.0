Return-Path: <bpf+bounces-59466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B604ACBDCB
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 01:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A702E7A9AB4
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 23:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDE3183CC3;
	Mon,  2 Jun 2025 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjI9glo0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532602AE6C
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748908267; cv=none; b=LHTtExu3+VAAkcTjP4omTiiCPqQAMd+M+X+0iLZ6UrRNXTdoStbaWHEBYf+tNi30rXBH2i+qYJn31CmPic9Cvjo0VAWk7wjzfP/kdAxO8E36bdH0K6fiAR5q7R6dgOIfvWONykMZ79w5UIyCW5HuHMTEYK9TCj/Wu1e9nm3tX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748908267; c=relaxed/simple;
	bh=n6hBoyxV21wooXhmpJE4KbFDOs/cj953ILinn6eZPys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZb+yktji+wCryLrOeWXA9BhU03SbU87GerWwWkv62i8yOZ930T5ZRJkIjGtiu4fKpf+vIzyYlel4QmZ8rtC3MhYrF6O+r6Pqay8SgEt/Had/afoAjBJ22Fn+sUAngUCu7m1pEudC8g4BhRWYwlzGXi15mpAhrjWaegrBa5i80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjI9glo0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so2892922a12.1
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 16:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748908265; x=1749513065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NlaLl/kwUHMmKysHdEL/DsCDa1XIetRTFbbgTfH+Zc=;
        b=QjI9glo0bEczG5x/UN1H0QTiVfnZwJEiamYGUk3GXjeBr8QXyNlOBGKPWpvwPlcd14
         7Uk/vQsShuyi/q3n8FnZRjWETJucomlDccjKyqHbCK6yYPSFKC0zm7W+bi9pdJg2ep+2
         GGqgPQlO0WAsBV1UDZO0aeBeQ0LJBRbY0EWPpNBKDGZsOSd8b+3v9deAa8dITJl3jb0O
         ZBiVrJ77NKGmvJWtBH9/JBvuk4++FLXHqIzYOo7WvupW1T1katOWCDx1Gox0ijn4AE4C
         t2BdMkA/mZFTd/Ag+KQhpjOSZ2tv2EOqEsWO7H3pabAzPLhtPbP2eqxL5iigzyXbEUFl
         YQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748908265; x=1749513065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NlaLl/kwUHMmKysHdEL/DsCDa1XIetRTFbbgTfH+Zc=;
        b=v3PxXt35ClECgYYNAxWBcXsKwhtg20gv6b5b09GbzAa59UcBcXOWTC5gLZxcmeS1Pn
         IiA12xZJaKnexgqbwmCeOAcfc3gZKveKLl4HGEzKD2yrBobp/qrLriWVsai+dhMRIswm
         N28VydBUVfBQ9qeg0zyEbdLII5BGQibZZUwhoBqoSvu3u18XXTtZTu2xg/4EepI6FEIo
         UpcFEmYaxQUUH7geBchWzvEO9+9qxyef5c4ZuQ6Vkm12u+NWn9wFaYrMkQ++Lh+dQB6n
         q2f96jr2TM1gHXlzh8AMFw4neMu6pVUAoGyuBlUWoXJgbrVsLn3OLaAw0HKwo4x+kZ1s
         o1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY3bzYWBwqEZFa8dNoTWS6PjcEivfupoXHsp7EQBCtu+uMCO8byqNHh9cUXnBFl5dAttY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xsg9fxxFUI6xalqX4p7Xxqc3gzlURLMnf2Ug9lxKi+obVU16
	uvo0woUTiLrrKECBc096rbiW90tN8xaHB163kA4PUf4huv8Zy/g6QWp9cU2mUFdRCLJtsNUWV3a
	R2iPHOlKPzh/x6BF7lwSC3XwA53L045Y=
X-Gm-Gg: ASbGnctO644+YgJqczxTuE49vB1f3cJG9XExCSOPkGirmUnFZotJsMUDsHuI94BBH/H
	WhyrfdPtYsTJdsIxWY4vj3j4PqcOQ6lSJO5fTgaEmbvIbp1l5w1ZYjf3yxbnlf8SQqZ8ABj4ApV
	DZXQ1GttvbKZTwdAjMkL5WEdrCCxt29Tcm2nsfmK7gL1hRXIXA
X-Google-Smtp-Source: AGHT+IGbVjjixu3LgHuneEF5HTxj4XfyNPzJ8aLDT/NMHSFz7VHm+aSPsfODPWfpJOEr0/9mJeBABgCtBB5TMz4kdNM=
X-Received: by 2002:a17:90b:510d:b0:311:f05b:869b with SMTP id
 98e67ed59e1d1-3127c75248emr13603564a91.30.1748908265496; Mon, 02 Jun 2025
 16:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev> <20250526162146.24429-3-leon.hwang@linux.dev>
 <CAADnVQJZ1dpSf3AtfNsvovogfC75eVs=PiYXMivUpDHDow3Row@mail.gmail.com>
 <CAEf4Bzbw9G4HhL4_ecbgc2=bDbZuVEA2zLnChgqT_WCsq11krQ@mail.gmail.com>
 <CAADnVQLxzJMAYymtWMFZb6eAK+ha_shRfh+m3W3yFO4dLn-YeA@mail.gmail.com>
 <CAEf4BzYUW4oAm4JJ-Kh4HhtfP4GXuQFx+tJ3p7vjMpPYoVv5GQ@mail.gmail.com> <d6f9ca33-977f-4486-9d62-8f497858764b@linux.dev>
In-Reply-To: <d6f9ca33-977f-4486-9d62-8f497858764b@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Jun 2025 16:50:51 -0700
X-Gm-Features: AX0GCFvFohu9JKpjPejZTSuI8O8OGAUWl_jI-V3-uLD-SFCQ9lOSPusW51mlX4I
Message-ID: <CAEf4BzZ1A6+uhX5gvCKSZUjvj_TG00-13jEWKbmqfXYEQ5fEZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf, libbpf: Support global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 7:44=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 29/5/25 00:05, Andrii Nakryiko wrote:
> > On Tue, May 27, 2025 at 7:35=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
>
> [...]
>
> >>
> >> I guess this can be a follow up.
> >> With extra flag lookup/update/delete can look into a new field
> >> in that anonymous struct:
> >>         struct { /* anonymous struct used by BPF_MAP_*_ELEM and
> >> BPF_MAP_FREEZE commands */
> >>                 __u32           map_fd;
> >>                 __aligned_u64   key;
> >>                 union {
> >>                         __aligned_u64 value;
> >>                         __aligned_u64 next_key;
> >>                 };
> >>                 __u64           flags;
> >>         };
> >>
> >
> > Yep, we'd have two flags: one for "apply across all CPUs", and another
> > meaning "apply for specified CPU" + new CPU number field. Or the same
> > flag with a special CPU number value (0xffffffff?).
> >
> >> There is also "batch" version of lookup/update/delete.
> >> They probably will need to be extended as well for consistency ?
> >> So I'd only go with the "use data to update all CPUs" flag for now.
> >
> > Agreed. But also looking at generic_map_update_batch() it seems like
> > it just routes everything through single-element updates, so it
> > shouldn't be hard to add batch support for all this either.
>
> Regarding BPF_MAP_UPDATE_{ELEM,BATCH} support for percpu_array maps =E2=
=80=94
> would it make sense to split the flags field as [cpu | flags]?

We coul;d encode CPU number as part of flags, but I'm not sure what we
are trying to achieve here. Adding a dedicated field for cpu number
would be in line of what we did for BPF_PROG_TEST_RUN, so I don't see
a big problem.

>
> When the BPF_F_PERCPU_DATA flag is set, the value could be applied
> either across all CPUs if the cpu is 0xffffffff, or to a specific CPU
> otherwise.

right

>
> Thanks,
> Leon
>
>

