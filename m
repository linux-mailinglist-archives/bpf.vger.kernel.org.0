Return-Path: <bpf+bounces-22973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B5D86BC94
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693E61F24841
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F21B812;
	Thu, 29 Feb 2024 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRl0SNTi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D81102
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165700; cv=none; b=iQ56xOUUgrvQKnXDlQTNx886yxxmcCTnDZX0AdGZvo+z8prIcGbb2E7CSCfPQ36nL2m7GVqgBtVcW91dFwohmbCr6I5plq+NB1E9znpUqRddY8nByoMENxhgqOVApL54ocCQFeLSvo29OlpBIgairSCKjZy6kbGOZOT8CT6QosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165700; c=relaxed/simple;
	bh=zpEDMWvLPFBC9cjObnRJ2h7lYqAbcrAZRjJMjVaH3gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWlkNn8DklkSuX+QvSic6vgg5wyBO53SJ/L4M8gV/atLBWQWjSxtuZQaJgLaDiFCENwsSKF0gvgG+b1Cx4JIsrGsmuVb8e5EXHZPvlVml4hmas7HeNvgQWOIUttywRsFNmQIUeiOhic3mZwPk9I9Yh0sqYANxGag5dzxoEp+yeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRl0SNTi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so3420555ad.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709165698; x=1709770498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRmlSWRH3Z/HSbX9cmFmFamD8SFaZ+fm8oTG4C4dZtg=;
        b=NRl0SNTiPkCyDm3YaODsTEus1HptcYEnPUbfb3llg2hCDFbZtjc8sY183KhzQ2NLjH
         Vy4jM7JZ5FClKiiDgqtVvy7H1IgopiBNNXG0cuKJntwBgcAaPVmDprls39o8dXLYAYJ0
         6+HIOxFbYHhyl84SHhdJl+1nreHoN8cI/nsHdMAWv6Q7l9e7QYeJEVZJYfzvAgoiIxP0
         p4TTquw/6KODKeiS9c0+M9dIoQjao6AduZyr3FmlDlk+Z96JoDOiIXf25rCT6o5F++5r
         7tbF4w/3h9WFWXygmoSY9IGfeL2UQnbaZLCRD3RnJqX4+nOvSc1q8pJhJjUgO/JLYzRP
         eJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165698; x=1709770498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRmlSWRH3Z/HSbX9cmFmFamD8SFaZ+fm8oTG4C4dZtg=;
        b=UZ6ZKm/V1/4FQSvwtJpY94chqrf3RLxXrWx31jN0zw2clOOIKWemcDmuA5AqeIa6YL
         WrlgO40Yk7o7hlOsrqk/7YtN6uudO4XKINZVYxYGU3OglSyNM/mFYEOzCbIerODqixvk
         1vTlB/Lb2PTBi44XsVNGav13Y3WzG+PgE9CMzWS2IaRAHjJri0dvNkpDzOhtMHvMqR6F
         xzKJfL6wsi78omkOwDpteLhQBqJgjx5AHVXFqE5PyXHcWEerFWLzOTcb+I7ecUi04rKy
         nPmUTlYLIxTCwu7BaxOfu8Y9r+U0N2Y0uSpoThIqdbUETw/7MNDuMbEpghl2gdu2C4ur
         is8w==
X-Forwarded-Encrypted: i=1; AJvYcCUIY/dhuLKsNxJWMFJXan0+rjIdw2dwCbxOQkOjhHL/S1ZwSyBPmFGN5nYtRQigj1cR7UzLHT5fQGtyKizzNFCjHE9U
X-Gm-Message-State: AOJu0Yw0aH6CD/BAgm6klNvC8pYPcUgGAnnnsdqVXvFCeLozUHFku3A1
	k0/kHZ7a36ZhXoGgcQ0VPO22vl518TUOZo6APcRHjFSeFNeDnXweMwI78w2/vR6ZrViP123owin
	UEtpozmOai+ZJyRoHC4u7MjTUX3c=
X-Google-Smtp-Source: AGHT+IEO5DkSnzHb7dS6qzpvw7osvw3en8+Rg1gxoTz5BRI4IaBFbMCx9n/8MhFbX9ByKgUUrE6s927gD3P0CnH9DpQ=
X-Received: by 2002:a17:903:1c2:b0:1dc:d642:aacd with SMTP id
 e2-20020a17090301c200b001dcd642aacdmr666660plh.67.1709165698547; Wed, 28 Feb
 2024 16:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-8-eddyz87@gmail.com>
 <1e95162a-a8d7-44e6-bc63-999df8cae987@linux.dev> <CAEf4BzbQryFpZFd0ruu0w9BC6VV-5BMHCzEJJNJz_OXk5j0DEw@mail.gmail.com>
 <1fca7711dfcd9f1033390af6b1e1068ca9629207.camel@gmail.com>
In-Reply-To: <1fca7711dfcd9f1033390af6b1e1068ca9629207.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 16:14:46 -0800
Message-ID: <CAEf4BzZCdy7soj54ysRteL0HjE2X5Zu5wkT_32iRcZ1Ocyv00g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, andrii@kernel.org, daniel@iogearbox.net, 
	kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com, 
	bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-02-28 at 15:55 -0800, Andrii Nakryiko wrote:
> > On Tue, Feb 27, 2024 at 6:11=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
>
> [...]
>
> > > Instead of adding struct_ops_refs and autoload_user_set,
> > >
> > > for BPF_PROG_TYPE_STRUCT_OPS, how about deciding to load it or not by=
 checking
> > > prog->attach_btf_id (non zero) alone. The prog->attach_btf_id is now =
decided at
> > > load time and is only set if it is used by at least one autocreate ma=
p, if I
> > > read patch 2 & 3 correctly.
> > >
> > > Meaning ignore prog->autoload*. Load the struct_ops prog as long as i=
t is used
> > > by one struct_ops map with autocreate =3D=3D true.
> > >
> > > If the struct_ops prog is not used in any struct_ops map, the bpf pro=
g cannot be
> > > loaded even the autoload is set. If bpf prog is used in a struct_ops =
map and its
> > > autoload is set to false, the struct_ops map will be in broken state.=
 Thus,
> >
> > We can easily detect this condition and report meaningful error.
> >
> > > prog->autoload does not fit very well with struct_ops prog and may as=
 well
> > > depend on whether the struct_ops prog is used by a struct_ops map alo=
ne?
> >
> > I think it's probably fine from a usability standpoint to disable
> > loading the BPF program if its struct_ops map was explicitly set to
> > not auto-create. It's a bit of deviation from other program types, but
> > in practice this logic will make it easier for users.
> >
> > One question I have, though, is whether we should report as an error a
> > stand-alone struct_ops BPF program that is not used from any
> > struct_ops map? Or should we load it nevertheless? Or should we
> > silently not load it?
> >
> > I feel like silently not loading is the worst behavior here. So either
> > loading it anyway or reporting an error would be my preference,
> > probably.
>
> The following properties of the struct_ops program are set based on
> the corresponding struct_ops map:
> - attach_btf_id - BTF id of the kernel struct_ops type;
> - expected_attach_type - member index of function pointer inside
>   the kernel type.
>
> No corresponding map means above fields are not set,
> means program fails to load with error report.
>
> So I think it is fine to try loading such programs w/o any additional
> processing.

But Martin is proposing to *not load* programs if their attach_btf_id
is not set. Which is why I'm asking if we should distinguish
situations where a BPF program is stand-alone (never was referenced
from struct_ops map) vs auto-disabling it because struct_ops map that
it was referenced from was explicitly disabled.

