Return-Path: <bpf+bounces-51183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E998CA31749
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 22:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAA516254C
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 21:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442DB264FB1;
	Tue, 11 Feb 2025 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgHqKxTJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A084264F95;
	Tue, 11 Feb 2025 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308093; cv=none; b=WTKpr+ETNh1//7OWzVRES3qLRS5cdtLBcW9LsX85+DqMyFS1MkjUJIEFcVeE1yYSTVtaut0iaU+XyoTDQycgkmDrKp2hBahsqtgu68U23jZXiB8pT3nUcU0HQiINzkASLMpfVutzYDmlbWTDF3uqwRVI7WtOHqlCt79F0k5hCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308093; c=relaxed/simple;
	bh=I84PdlcrArAmyIIkmsE+YmRfAtmVSB6O7LSN8M+NuDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hESeOMQKbX2GGqjqK6EG37T/Tr3fc985zTOw1Z5aT4NngmtAe4OaABZjnl3okFmoQLHFB1BjSn5H+u5falIS9pYSRJiibgMOd9x24cGZmVBVvqV4kaDD031i0bDlNX2AJf4pjXV6Bgs7omPZBnSj8vRtEqr5oVYNQYyYzZa/C64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgHqKxTJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f7f1e1194so81798675ad.2;
        Tue, 11 Feb 2025 13:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739308091; x=1739912891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPMIq0VmXeAVr2D99+nwxBxgg2P8mlfdxZSMVJIRfH4=;
        b=dgHqKxTJAgyuDmJhZQcKntxPblv39Dux6rgk8e4RTwV399gT9xAQFg+frh3svKLUL8
         7zoNfLg9k4hMuRc8CD9IP0L6quJILdnINmSVZHQAGdZ1tJVX6HsiCfvXeD2aWk91z1oY
         fi3W9jSmCuse/BsNfSXt4COsTYPnN5GYV3siNb8If/wSByMz2oCxO6nFrzY2gsio/dJo
         3E2bCyA3ZWKeVw8W98QXaAFAOGYMMrTJ+Bwb7qOdePNEPZ1HZv1OH27vv6HH7Oraeb3m
         vI8iJSIzb+V+dEk1NeypUFyR5gMsGsC+mE03m51G9BJ2Sy7fm6BpynHh1UfhZKh15nIT
         DO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739308091; x=1739912891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPMIq0VmXeAVr2D99+nwxBxgg2P8mlfdxZSMVJIRfH4=;
        b=gvI1bvUd/ZqoNA/VbSISlv5LV6NRTrXvvKtZPp3lib0eohP2FBiIAKcuwjJykGH21W
         O40FrZDkXmWjMZuZCwOj3L5IWkjFD5mfajfob+NHkmzAgoBNvUwDNIlIfTDUUUz24osL
         1m+CDw7qnwZtcuWrzGyVaRDU/qebIzC7zU76n7JlD408n24VJQW4qi3TExeXY9Un14HU
         gXG5y1B/pja/PjjzIGtWi5KfZgqA4CnY4LpPaKSxRwIXfg4dSZl4L9TaTSi/jZhp7HHP
         HnVC96JREVTTHe9TNwtlTD8iwrg0P41227VozpGgy0HgYkQxg8OXD3L9BU5g3K6Sl1Fm
         5KWw==
X-Forwarded-Encrypted: i=1; AJvYcCXDbimiZQ9dZMz1czqLAZNiOUz+xEEk65Tnil8dgpTvOKXVimjw6Z/BNZGI01n1n1vzNxw=@vger.kernel.org, AJvYcCXLYplazhYJPke7fIkJHGbhtV/oVonjfiAwgL0M4jCxn70A3TTw22rQ6PgkMyuAlBB7cd5FKUf45qEQ68nV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzha+41xH+nncObTrkGwlLNG8x/+/arh6cAOwqd2a8YR8I8YB7o
	EahOwNZs3z7GhQzBKxiCRY+GikLFGcNGvfYe9KndUr+Gl1Sy2YL4DEK1m+ACeYW0oRU6MWlTOCa
	9oST6YVWWpoA3cLNk3H7FqEtWpnI=
X-Gm-Gg: ASbGnctG/BWOPPQ8HImELahbIebXEqkQUjMGdmAzbodPtV4oD+8B/78bXZe8XZ5y0qL
	AHZlMDDfG+jfOrHAM8+Uh3wTiXtcZEuhA6zqwyCPdDFTNs0rwql02wDjF6v9jEGGWkiV/DNiocz
	b+g0txcHEqkyrR
X-Google-Smtp-Source: AGHT+IGGS6iyIpwLp+OhtSJIZ7eqZO0oe02/HhFHSFJWTEwOq/PGEwLBOZY3J10dBfjd6pKuesAOmX5a+adnJlnJcoY=
X-Received: by 2002:a05:6a00:a15:b0:725:df1a:275 with SMTP id
 d2e1a72fcca58-7322c41801emr615799b3a.23.1739308091305; Tue, 11 Feb 2025
 13:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_26592A2BAF08A3A688A50600421559929708@qq.com> <c886e85d-4c24-4a01-b04f-1006dbb7b512@kernel.org>
In-Reply-To: <c886e85d-4c24-4a01-b04f-1006dbb7b512@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Feb 2025 13:07:59 -0800
X-Gm-Features: AWEUYZnfwk9CwCsAv-mbiPhNYMDBvk8kNjEFnQfyx8FCbuEYZ0gwwxFluTgorow
Message-ID: <CAEf4Bzb9qWbF=H0L7ZF+nfztH8KkkfBJL00XgaKCeNpj25o7xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Check map name length when map create
To: Quentin Monnet <qmo@kernel.org>
Cc: Rong Tao <rtoax@foxmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	rongtao@cestc.cn, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, 
	"open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:48=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2025-02-11 18:38 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
> > From: Rong Tao <rongtao@cestc.cn>
> >
> > The size of struct bpf_map::name is BPF_OBJ_NAME_LEN (16).
> >
> > bpf(2) {
> >   map_create() {
> >     bpf_obj_name_cpy(map->name, attr->map_name, sizeof(attr->map_name))=
;
> >   }
> > }
> >
> > When specifying a map name using bpftool map create name, no error is
> > reported if the name length is greater than 15.
> >
> >     $ sudo bpftool map create /sys/fs/bpf/12345678901234567890 \
> >         type array key 4 value 4 entries 5 name 12345678901234567890
> >
> > Users will think that 12345678901234567890 is legal, but this name cann=
ot
> > be used to index a map.
> >
> >     $ sudo bpftool map show name 12345678901234567890
> >     Error: can't parse name
> >
> >     $ sudo bpftool map show
> >     ...
> >     1249: array  name 123456789012345  flags 0x0
> >       key 4B  value 4B  max_entries 5  memlock 304B
> >
> >     $ sudo bpftool map show name 123456789012345
> >     1249: array  name 123456789012345  flags 0x0
> >       key 4B  value 4B  max_entries 5  memlock 304B
> >
> > The map name provided in the command line is truncated, but no error is
> > reported. This submission checks the length of the map name.
> >
> > Signed-off-by: Rong Tao <rongtao@cestc.cn>
>
>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
>

Would it make sense to just warn but proceed with a truncated name?
libbpf truncates the name when creating a map, but preserves the
original name in BTF (and in memory, fetchable through
bpf_map__name()). So from the user's perspective that map is still
named "blah-blah-something-long", even if the kernel records just a
prefix of that.

Basically, instead of forcing users to count the first 15 characters,
warn, but do the right thing anyways?

> Thank you!

