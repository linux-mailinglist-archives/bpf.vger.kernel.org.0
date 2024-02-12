Return-Path: <bpf+bounces-21764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2DD851E81
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B23B2478D
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60847F69;
	Mon, 12 Feb 2024 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGta/M23"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534A4CB22
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768912; cv=none; b=TuZ+ERBMhXZEVm2jI6GAHXcH5s0jD/K+RHPcIq+6aZvMEgenX+18mtNKeVe08jWURcM/2fruAoaGNYCmWkhvuNWPA3QKviOz47WlYQiSpAY4mUNB38uRqeo/f8Ys0IMEo0U+i9UTRhuiKg8qaoU9CPo3cFtHic+AtCZhzRn711g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768912; c=relaxed/simple;
	bh=kojok2c9WTGlR7zPo1yDdbtgn1jjaHIYZMBF7FCzoUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvCuN8a4qI7ZU/lUsj7vhwEVseoW5saq26UmjIEjL2wi8bdPI1XDjH4ghtxpMLaJ554N3Ze7eVi/AVonJ5p32OqgpbMrpjLN7t6o1ExQglR5kDpYD1oN9jY6RASUrXItcrXAs0MhTjR6x+Bj7J7rdyJtkV9kfGX7laXnfyuXQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGta/M23; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3394ca0c874so2519109f8f.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 12:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707768909; x=1708373709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaXyLf0rlgT3ERwoRMW+FZewiXwcvNDh+cVWPKZgz40=;
        b=kGta/M23odthpdS2mUH/T2MlpaMKwyiij5Y2ciCwZHMQnb+7Jp+KFAwASzN9pXk0d+
         SQpyUQ5a49hsEePQIhsRjhD46enf2rBJdEXJl6z+wwlZT+mB4XyPs890l3hb7/QQrETg
         ZqLrOr/rwgJHcaGoJvwqP4M8FDMPYHYI/Zb6eZmKYc8RdLfZT2WBer1tNwnfWI/Xhl8Q
         YJy164dmzKYE/W+LwK1LpNVh72/6pv0C9gsiJYotTDpKCVu2oxMwzdsNT6jGDkCRYnd0
         +QtkVPmlZJ46el2TK2eZDSu2A662vcPrWeiFdPdtU6DnrNxq5sQJPAQg3KhU+Y/ShDgt
         Tv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768909; x=1708373709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaXyLf0rlgT3ERwoRMW+FZewiXwcvNDh+cVWPKZgz40=;
        b=gEOjrH+facoKzYMOfQTJgGx9GgWZgUnnZWcSepoW+0n2IclbUw5+bYsexqWxZM0Urq
         qVpa2BGYbQjjTxgk7bspt3PUDIE2ug1Swo4SyFiiN/iocHPhnjhx504BUTSUjZGvLXje
         jMaIxcpJV7Ew2BRzah6dk4P0n2W9X6sLYg6SoI1SZjZBhN1UH4zU8t8i1gh1oiqwhEz8
         IdvDnjn5uAlEHH9O/q/fyAw89RmTJ4zzA0CZPn88bqBTl2uI6hBZzox+8MwfDVXJV6va
         yF4vH45f/Q0nJS4/rTBAKO1AqDmoAKLomiruxQkiEyhDL3EKmOp+1hg6xnGSmIn86Nq/
         gU9g==
X-Gm-Message-State: AOJu0YwsUo8ieu0srrPkBrVpC4rxN6JRVi1C2mR3IZDRe8+1j1TlTE3U
	NoYZk+E7VZvVKNJ86oyzSurchRwHHm/aaZVeDX17NB4R9NtmpyOCqDTpOTDkmResjSab4dq96DE
	0aq0dk/+k7XMNTKTp8yMCn2oWBp0=
X-Google-Smtp-Source: AGHT+IHpOp2YAL/4T7pXJ3ADMzkd3FmSJ1znP94djoyRBiFToNx3U3/SAYWlk1OcRcRw7giKQF99XDLBrGg9cagP3gQ=
X-Received: by 2002:a5d:5449:0:b0:33b:643b:d86c with SMTP id
 w9-20020a5d5449000000b0033b643bd86cmr5898005wrv.54.1707768909245; Mon, 12 Feb
 2024 12:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-13-alexei.starovoitov@gmail.com> <59623808ebfd5ecd48cdb4c07a28326d777e7769.camel@gmail.com>
In-Reply-To: <59623808ebfd5ecd48cdb4c07a28326d777e7769.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 12:14:58 -0800
Message-ID: <CAADnVQLxymxv5TGsu94=FznK9qqZjSLfwq4k2BSxg-v0FCVuSA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/20] libbpf: Add support for bpf_arena.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:12=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2024-02-08 at 20:06 -0800, Alexei Starovoitov wrote:
> [...]
>
> > @@ -9830,8 +9861,8 @@ int bpf_map__set_value_size(struct bpf_map *map, =
__u32 size)
> >               int err;
> >               size_t mmap_old_sz, mmap_new_sz;
> >
> > -             mmap_old_sz =3D bpf_map_mmap_sz(map->def.value_size, map-=
>def.max_entries);
> > -             mmap_new_sz =3D bpf_map_mmap_sz(size, map->def.max_entrie=
s);
> > +             mmap_old_sz =3D bpf_map_mmap_sz(map);
> > +             mmap_new_sz =3D __bpf_map_mmap_sz(size, map->def.max_entr=
ies);
> >               err =3D bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz=
);
> >               if (err) {
> >                       pr_warn("map '%s': failed to resize memory-mapped=
 region: %d\n",
>
> I think that as is bpf_map__set_value_size() won't work for arenas.

It doesn't and doesn't work for ringbuf either.
I guess we can add a filter by map type, but I'm not sure
how big this can of worms (extra checks) will be.
There are probably many libbpf apis that can be misused.
Like bpf_map__set_type()

