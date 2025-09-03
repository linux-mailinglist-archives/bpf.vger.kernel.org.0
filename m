Return-Path: <bpf+bounces-67315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C5BB426C1
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F0B5E6B30
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D502C158D;
	Wed,  3 Sep 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PejF1BUC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39762C11F5;
	Wed,  3 Sep 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916547; cv=none; b=QI6ZEci0b+LpRMEoZKcxEGJcrN1PPbaGYWk7cIsJ2OiSZmV/VGObvMJrP7axlWJ14NjONRbR0mcIF0pTZzfG4XPz52qZi4vJyYQQ5wTuQCLF+HfX0RHLeniz+8EvowXuXaVufmvOSQAltMRwz5ThCkCr9zYT49MqSj0333igb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916547; c=relaxed/simple;
	bh=wvEMkXHaJpIb5xv6+vYPGH0V897Ec7hErb/+81B2ijg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIlcmWwoFIsvmWay18ptQkCJYK/oV41/TxfRR0VvSl2iN8NumOvodbkdOZOiwmHSqMcgUNFeUi4v8lYMEVrjGwaTiAdMlsy14RNldM3g6VtbxfHSBYEDMEy9CIq7ZNQe5GdWWlcoWlFZBQqptxf/OpeIbz2pvXjCseBQlIf+SDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PejF1BUC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b043da5a55fso12854266b.0;
        Wed, 03 Sep 2025 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756916544; x=1757521344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoXcLYlwl2JhaADi+GiTu4E6RqdYGplWovLMYfPiy+Y=;
        b=PejF1BUCWogRvX4oxF/NBUedhQ2LcLhAbMxGP7ZDjBNM+SGDv3/p84Zvhsu1pzYWhA
         8/EslI31zVRc9EbQxPN9Kyu0OJDmlCXvqEd+iLEA6kv0mrjsef9ObbJMNu4ZghsuWi4S
         RsSR1HfOUgnOlMpz7XSE8yrn/VCsAqhv4HLA8vWdWaaGNE38feeY0gmx4dLgs495rPjb
         EFRsZdKTUB50QNprzz3+z6lmeEig430ChOEBvyJPkYSdJYZJJjJ5n7dBhJg5/p+IpF8a
         nHBIS+AsxDxJe7pxMFnYhjDObbKM3L8KXo7tKBzI8neMHTpx475iNmbZQsaT03yoqwZ2
         RQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916544; x=1757521344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoXcLYlwl2JhaADi+GiTu4E6RqdYGplWovLMYfPiy+Y=;
        b=XS2SxgwK0Hk53qPpYJuuQD1/Xu/cUqCN3gHW8jOpb8R3i4RLS34vFCvnGbSlTB71uR
         ugu1LlgkiEpdfs3WrYdWiBB+y6C80MmvmpwygvlIKni46E8RCkqIe1olsMFS+bAvl1/c
         5KfDN1YsNUxbA/owBlsbg3v9N67ZoV/s5ciT6t9cws+z3K0TY3Tg3bVjJxlVx5OgGgAP
         oL0+eHqv/NlpxRKUNd5cHpwWRSVmVvqzg/UjqhdKNdGVYQTyKtkrDzXnxKQlpgZHJcoP
         kgXeWMxyENhBCBq/UU91lIhX8/GT/JC646ous8WIxvUoTQ8FQgnOC/z0G45JTl+HDzqL
         x0qg==
X-Forwarded-Encrypted: i=1; AJvYcCXFX5GFdriM1dqanQUrj9vWR/tIuKp8IajRlVm+Ea54cFglvKRgWHe39jkLCLn+k83aWNk=@vger.kernel.org, AJvYcCXP9D7P+LGWOD0dVddeVgnRemS36VYQWxYHpFFZLp/IW2bN9OoJWm/Ts1i41E9qNCL7TPBn5E3dfcnJNvRf@vger.kernel.org
X-Gm-Message-State: AOJu0YzNpyyHeV07IQAYxlI2Pf+eDryFDnjejj/rzrtLD5QtKt4uIDnQ
	De9EqKurL6nDHFvDWyVhVxluUdrcU0Y7fKjaitCFimlhyziuPYuHrJZmGa6tEywiYOuiRor25v5
	KLhWza2cKf/X/VcwpaRQHK3AJ2gKxRPw=
X-Gm-Gg: ASbGncsGGswlFiPyXoLFAGPkWQ+g6ZciaVleh21WTLkGaOtklAtKQ+iqvx4p8BqnTqT
	gdJEoiKd0dIFGD3D9lcc+tc3pwnNQdpfFNvQsXISDlL1x64slR4VdxRkSVdutVD2Bsp7UkF07rw
	O8el5g/XIHqoYXjDx2SmhrCBzh3JLqj4ayQSmEJYY8Qi284Ig+JxYE0r64baqiwSSLAUd/yt1dy
	H4Lxdv6nSWchJ29WSFeKUTtQNcy6r4k1A==
X-Google-Smtp-Source: AGHT+IGQ8n18m8I2q6yIHPhanq7C0Sx4MTsmfLvhh5jrkKlsJ9ILbpiYYZi1z3E1dkmEqo+Y2ttHV03Zr7KEsHVDeCo=
X-Received: by 2002:a17:907:724e:b0:b04:5200:5ebe with SMTP id
 a640c23a62f3a-b0452006a0dmr734282566b.54.1756916544055; Wed, 03 Sep 2025
 09:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903135222.97604-1-contact@arnaud-lcm.com>
 <CAADnVQLf0wj9hV=tAA=p_GXgpQ6DxtB4heoDqTmb5dEc5P6zfg@mail.gmail.com> <d6223a4c-3e24-464f-893b-6bef57b973b8@arnaud-lcm.com>
In-Reply-To: <d6223a4c-3e24-464f-893b-6bef57b973b8@arnaud-lcm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Sep 2025 09:22:12 -0700
X-Gm-Features: Ac12FXznT-1rusU-3jxth4QlayUs-SuZES4nwed-YHS-tqSYt9sVH74isA7_nE4
Message-ID: <CAADnVQL5Ms+3N9CYK=YTCMfWYfd=BEzXNggB2Sg+i_obVfUb8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: refactor max_depth computation in bpf_get_stack()
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 9:20=E2=80=AFAM Lecomte, Arnaud <contact@arnaud-lcm.=
com> wrote:
>
>
> On 03/09/2025 18:12, Alexei Starovoitov wrote:
> > On Wed, Sep 3, 2025 at 6:52=E2=80=AFAM Arnaud Lecomte <contact@arnaud-l=
cm.com> wrote:
> >> A new helper function stack_map_calculate_max_depth() that
> >> computes the max depth for a stackmap.
> >>
> >> Changes in v2:
> >>   - Removed the checking 'map_size % map_elem_size' from
> >>     stack_map_calculate_max_depth
> >>   - Changed stack_map_calculate_max_depth params name to be more gener=
ic
> >>
> >> Changes in v3:
> >>   - Changed map size param to size in max depth helper
> >>
> >> Changes in v4:
> >>   - Fixed indentation in max depth helper for args
> >>
> >> Changes in v5:
> >>   - Bound back trace_nr to num_elem in __bpf_get_stack
> >>   - Make a copy of sysctl_perf_event_max_stack
> >>     in stack_map_calculate_max_depth
> >>
> >> Changes in v6:
> >>   - Restrained max_depth computation only when required
> >>   - Additional cleanup from Song in __bpf_get_stack
> > This is not a refactor anymore.
> > Pls don't squash different things into one patch.
> > Keep refactor as patch 1, and another cleanup as patch 2.
>
> The main problem is that patch 2 is not a cleanup too. It is a bug fix
> so it doesn't really
> fit either.
> We could maybe split this patch into 2 new patches but I don't really
> like this idea.
> If we decide to stick to 2 patches format, I don't have any preference
> which patch's scope
> should be extended.

I wasn't proposing to squash cleanup into patch 2.
Make 3 patches where each one is doing one thing.

