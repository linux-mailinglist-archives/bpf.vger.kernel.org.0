Return-Path: <bpf+bounces-68425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01ADB585BD
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BDA4C158C
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780872877E9;
	Mon, 15 Sep 2025 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjeB+8P6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085F2747B
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967155; cv=none; b=Pg6ZW5WwtwohHbGAUBZ97qq8JiJc609BjGdBVx7L/it6SyR0c3JrJM92a6NxbS3xYmVOjTdwW7hy3GHQaGqVAcLA5dT16DPTD02kNhSrToAbsE6Iak1QJI28xey0wzgWrJzKccz3/uM6ZACTUMfYO44Yi7o2Rqty1pZkOzztaGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967155; c=relaxed/simple;
	bh=+4cAha+GNtslo8nFhT1TGSyJk475EODX1gnUyWldtI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=en4XeIqp7lVgYMyjroJUTIrorpw8G2P2a8gkV8cz6MmwmoT9uIoOlIquW6wy8Ir2JvSb+KZYtnAhIOonjdbgwFsxspHyVV089ISVHle8QqtjWTIJUH1xC7CORGtNgp5E+KGOTqhkaZdMHih62YeQl6INxeqHncPSCOV/TUTuA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjeB+8P6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32e1c8223d3so1670349a91.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967153; x=1758571953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WduNv1WIwdYSGi7gAYyJrn75gVtKTHW4dN7GUyZibzA=;
        b=BjeB+8P6YwjVFZmFhz+nl5EDSXk6vt2XQjjOVZrLTMJzBvkMCEj0R2BWnIcwckguQM
         UJ12WMiyH/NxZae+IfT826y8V/lK+Of81oBc6hjxFF40lkvLIh9vAWVods3USlS4s57Z
         kCyccczdExX9PLf7a9JraebCgxiQCojW1YJ8nCoLJhMEvlmRKZTtod/Ww1eLbFYqyV2Q
         lJge/oUa1BNtuxkiBAcEDMsSPzACnvDxR0UVB3yrv9gDsgHsb+NpbiGBaJM31JWBN9Ao
         CsFfTVu/sFy4crUFwmS2toiGZRCkDu2EXCydo0R54gs/1hBsP1go+rXepw3INnASJTSo
         jqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967153; x=1758571953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WduNv1WIwdYSGi7gAYyJrn75gVtKTHW4dN7GUyZibzA=;
        b=ZdoK2RrO1odjmZTJjQthNB3Gb10q268kGlTc9Msll6u3mnWcbOKeV7Jvt6Wp+OmpsX
         f51JOy9ovG/4S+pSqdFVH/PLnfoJ4zFLHBAahU7OP1MB63ogcW14rGLTdqhGkvqqoBDd
         7wQiasPczVJ71Q76oIiljujITCUMXDq86ZwCkE03RKCET4E8GevFTMJJMsDya7B6nXGR
         yqomDYaP2nWyQ7MwwgnfUBYl6XV/xMw9GQ4Nlr8RR4Q27OiFzLMhnXJlctdiRvPJta67
         VjGoQXO9olxak+sgUV+3vkFTvDgNBFSCuJx/I1fjfMfUU0c3AAaXX3qUXCxlntsSuLS1
         OFxw==
X-Forwarded-Encrypted: i=1; AJvYcCXTqiOqt766vd8gLNJ/3wr56ArDPw61UtX76dbUKsw4qx8rM5U8j9mb0Mosvg3EfeE0JYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJ40fYuhF8F0vNSu5nXLIVaJKb+0gGn4lKxKjyZ63AO9gJ6aL
	yP9CRlyQOP+++m4Pw0pZT2d/I6ZXcAyB3SR+Ek+s3WjgvjSje7YYjy2qos6HTmgb4omiPRHIFL6
	fSE4fepWnBVh9R1qMBUk4CLTMabu+u5s=
X-Gm-Gg: ASbGncuJoMp1ysLJBWnYjtvWaC56jemWjL+excNOMQCD4L+VDdUOcNgIGQkfr3YcHVb
	41YjEtovFO8C8NyWzUSPyuC1ZTDjmf/KdMmDw0zKb3eVQ/pfSsnA+vz7aKv2QVXjI13kt8OOVnC
	ev43gttkONtdtDFXl3CNKoGt0gcSUcxpu6+CvForLaIW18Ixrqkd2JxywsT9rVGT0VkjB+m9ibF
	tRvAebQfeZt6IPhQZGjxZqj46WZHMcfdTdZw93GyyDlBWMEa2Bu
X-Google-Smtp-Source: AGHT+IH8KH6R78FyhXRtrzQcaIVsnG91/6cJLU70f7ndWrQyQfxlM9eN/4z9ptWzZKhDEtYEEVVvh50KhDWAV/Id+X0=
X-Received: by 2002:a17:90a:d604:b0:32d:fcd8:1a9 with SMTP id
 98e67ed59e1d1-32dfcd80c3amr10558548a91.32.1757967152824; Mon, 15 Sep 2025
 13:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-5-mykyta.yatsenko5@gmail.com> <c67790c49ae9ce4e1f34df324ab0b217ab867f03.camel@gmail.com>
 <ac73378d-290c-4ab0-a604-6de693ce6c6f@gmail.com>
In-Reply-To: <ac73378d-290c-4ab0-a604-6de693ce6c6f@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Sep 2025 13:12:18 -0700
X-Gm-Features: Ac12FXx7xFECB2sqfw6fx-5_Z5FdFcsTGtASpRw1yUUI5YmyNNmeDkyMoBErzK0
Message-ID: <CAEf4BzZBRkqb0VQM1ejV=O=HKPi3NL4yK+=_PGeWezpgLb1vQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: bpf task work plumbing
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:59=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 9/6/25 00:09, Eduard Zingerman wrote:
> > On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> >
> > [...]
> >
> >> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> >> index 3d080916faf9..4130d8e76dff 100644
> >> --- a/kernel/bpf/arraymap.c
> >> +++ b/kernel/bpf/arraymap.c
> > [...]
> >
> >> @@ -439,12 +439,14 @@ static void array_map_free_timers_wq(struct bpf_=
map *map)
> >>      /* We don't reset or free fields other than timer and workqueue
> >>       * on uref dropping to zero.
> >>       */
> >> -    if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE))=
 {
> >> +    if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE |=
 BPF_TASK_WORK)) {
> > I think that hashtab.c:htab_free_internal_structs needs to be renamed
> > and called here, thus avoiding code duplication.
> Sorry for the delayed follow up on this, just was trying to do it. I'm
> not sure if it is possible
> to reuse anything from hashtab in arraymap at the moment, there is no
> header file for hashtab.
> If we are going to introduce a new file to facilitate code reuse between
> maps, maybe we should go for
> map_intern_helpers.c/h or something like that. WDYT?

no need for new files, just use include/linux/bpf.h (internal header)
and kernel/bpf/helpers.c or kernel/bpf/syscall.c (whichever makes more
sense and contains other map-related helpers)

> >
> >>              for (i =3D 0; i < array->map.max_entries; i++) {
> >>                      if (btf_record_has_field(map->record, BPF_TIMER))
> >>                              bpf_obj_free_timer(map->record, array_map=
_elem_ptr(array, i));
> >>                      if (btf_record_has_field(map->record, BPF_WORKQUE=
UE))
> >>                              bpf_obj_free_workqueue(map->record, array=
_map_elem_ptr(array, i));
> >> +                    if (btf_record_has_field(map->record, BPF_TASK_WO=
RK))
> >> +                            bpf_obj_free_task_work(map->record, array=
_map_elem_ptr(array, i));
> >>              }
> >>      }
> >>   }
> > [...]
> >

[...]

