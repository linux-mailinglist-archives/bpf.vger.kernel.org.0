Return-Path: <bpf+bounces-36913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0475D94F5D5
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DBEEB220C7
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F5218732C;
	Mon, 12 Aug 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9kejKKw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88C191
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723483913; cv=none; b=FbN1yApeUTBR3TU9gEB0U8ZAu3GBNf0l3GUr87gk8XHx4CnUP4GBIzbdCnZJsRlBuMcFKfZqHWj6gxKvvwT5BqxYFS9zQHSu+bp558/pAGrcVF2lZ7HHccTSJvED0MFNdnc0RS49AKDI/CPV2qoEtD2hIO7rcXRdiZotHvdo9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723483913; c=relaxed/simple;
	bh=46201QeH0i88KGawI9eV6jpsxuGq1QCZcXrHe0wgUbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHJHK9X80V15daret50MyQ2YAuf3q9rBcq/1l0+5NaxleX83CVm/Auv7WCI9EY2naJB5hQ11uQSp+wTB+5PKkawFy4BeFoJuONUY9TmY1N2nI9mt5XLJyRnP55ifLzMeDCdzdRYR3VsKcpeikvaakAKzJSVXqIOIou9IkGSvmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9kejKKw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428178fc07eso31904855e9.3
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723483910; x=1724088710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwphRrFednBBreHtAjT0EDBXb+FWHmvki9BkCiUiYS8=;
        b=I9kejKKwq+vlnB8VeOi/W7/6hE1WMZGjPoyvs/GoyivGL6P+UPZ8m0B2ZVC5lI094a
         iQYDfcc3KW5ySckPYddiGljPe8JIDnYRrClto8Z88MTWpdDGwq2SRwqusnqOv472Frho
         /iekl2Z+Ckomcwc9sDMhzDJUWVyuOMexRmPFLOsZRMo4g/FeoRT53/IIRhZHLyu2GjDq
         QiClvgqOEjkCpHv2Vo7Q/8iBlHKWtamwNfc8wTFiwlb0+4OHuhalpPMMIvKaFOHGpqJt
         xX5Gq0MbDYEw8p8jO62biS+4RqK2+DmwMCrAV3W0EV057/BZpFGnG52vQnCRjtufqEZy
         miSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723483910; x=1724088710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwphRrFednBBreHtAjT0EDBXb+FWHmvki9BkCiUiYS8=;
        b=TxSIyUprv6ykNHp9sV79Wy0KVLvcCZij5SI6aiSOs1jI5rLXUk/bBxun0tupwLo3f1
         gw6FG8qR7sGX/mg5vdDVyPBWVcnoBVPyOYmYEz713wUnPrw5MRn56jMCK4XDaVDKjkPe
         N9FsWLrWmhAKVjuVhkBkvyDUuUqRag5r4cdxBqzjsGdeEGMEP0qINOeInGoykKcyCqoe
         PCJC15K45KudODcoy/VG9VgKvYr5L4f9vzB//UTU7cO2Ed0JRU/m9Nn/MTXhDQOzaK8g
         IEiivjpoDN6PX9aoPlJ4s6a7W02r+NPE+/yCHgHKVpwNDRhiMa+BBdw2pD3Cg/wFLmQf
         ZOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt6srzJmdnMXlQaCyayLKiYdY0kQgSuAWrWyQM1pzaLia8CyWkONsL+4QXXTLFe0s0ajJN5gXViG/EcUsqS3JQI+Uw
X-Gm-Message-State: AOJu0YyviNvC95gmcPQWkTzopLXMfPwCuVc02NwxvWsGKjMmnvIagWo8
	GaX+Jp2+g7eDsbBMBLgz0kuipMjZbSA3lJWtxXKk+w5EI7wZWcwKD1pna/JtsGT+VTf7QB9rPTH
	o7lDlra+XpJVdNk0+FBGbyG/DPj0=
X-Google-Smtp-Source: AGHT+IFEoyBy7gNRp5zkF8tPuGf5/HYtnrM6x2yqOI1p0FxkX5SSFQ4haq9AjP1vYFlpV87ZGzL4OXHeWZD+MKo9VMc=
X-Received: by 2002:adf:e842:0:b0:368:5a8c:580b with SMTP id
 ffacd0b85a97d-3716ccf1288mr786958f8f.19.1723483909733; Mon, 12 Aug 2024
 10:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807235755.1435806-1-thinker.li@gmail.com>
 <20240807235755.1435806-6-thinker.li@gmail.com> <CAADnVQ+B1oB2Ct+n0PrWnb5zJ2SEBS1ZmREqR_sK=tQys6y3zQ@mail.gmail.com>
 <e136e024-8949-4836-be02-fb1a1ca75f16@gmail.com>
In-Reply-To: <e136e024-8949-4836-be02-fb1a1ca75f16@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 10:31:38 -0700
Message-ID: <CAADnVQJSt3Xqgs-jK3-yOD4=E=0roS+35g-tVqxdm6fYk8rJEQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 5/5] selftests/bpf: test __kptr_user on the value
 of a task storage map.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:15=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
>
> On 8/12/24 09:58, Alexei Starovoitov wrote:
> > On Wed, Aug 7, 2024 at 4:58=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.c=
om> wrote:
> >> +
> >> +       user_data_mmap =3D mmap(NULL, sizeof(*user_data_mmap), PROT_RE=
AD | PROT_WRITE,
> >> +                             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >> +       if (!ASSERT_NEQ(user_data_mmap, MAP_FAILED, "mmap"))
> >> +               return;
> >> +
> >> +       memcpy(user_data_mmap, &user_data_mmap_v, sizeof(*user_data_mm=
ap));
> >> +       value.udata_mmap =3D user_data_mmap;
> >> +       value.udata =3D &user_data;
> >
> > There shouldn't be a need to do mmap(). It's too much memory overhead.
> > The user should be able to write:
> > static __thread struct user_data udata;
> > value.udata =3D &udata;
> > bpf_map_update_elem(map_fd, my_task_fd, &value)
> > and do it once.
> > Later multi thread user code will just access "udata".
> > No map lookups.
>
> mmap() is not necessary here. There are two pointers here.
> udata_mmap one is used to test the case crossing page boundary although
> in the current RFC it fails to do it. It will be fixed later.
> udata one works just like what you have described, except user_data is a
> local variable.

Hmm. I guess I misread the code.
But then:
+       struct user_data user_data user_data =3D ...;
+       value.udata =3D &user_data;

how is that supposed to work when the address points to the stack?
I guess the kernel can still pin that page, but it will be junk
as soon as the function returns.

> >
> > If sizeof(udata) is small enough the kernel will pin either
> > one or two pages (if udata crosses page boundary).
> >
> > So no extra memory consumption by the user process while the kernel
> > pins a page or two.
> > In a good case it's one page and no extra vmap.
> > I wonder whether we should enforce that one page case.
> > It's not hard for users to write:
> > static __thread struct user_data udata __attribute__((aligned(sizeof(ud=
ata))));
>
> With one page restriction, the implementation would be much simpler. If
> you think it is a reasonable restriction, I would enforce this rule.

I'm worried about vmap(). Doing it for every map elemen (same as every
task) might add substantial kernel side overhead.
On my devserver:
sudo cat /proc/vmallocinfo |grep vmap|wc -l
105
sudo cat /proc/vmallocinfo |wc -l
17608

I believe that the mechanism scales to millions, but adding one more
vmap per element feels like a footgun.
To avoid that the user would need to make sure their user_data doesn't
cross the page, so imo we can make this mandatory.

