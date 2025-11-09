Return-Path: <bpf+bounces-74003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF22C43798
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 04:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963E4188C868
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 03:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633F1F151C;
	Sun,  9 Nov 2025 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmIuom7H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA06199939
	for <bpf@vger.kernel.org>; Sun,  9 Nov 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762657274; cv=none; b=YU2PM1xSqU3n/cjctWIxeoG57q71Az2ehj4C4aMPtXv05vFSp3b4lRASw/iWxfiP2md7sfJEk8v3UwSRPC9ZRRYJ+9gI3JlWyqpASFKZ8yHMXecExgkXNkrVzlL2+5B6MgrwmbZW3T0Fd37mAk85jIIwifP5UvHMvQYHdpwITHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762657274; c=relaxed/simple;
	bh=qESZOs7qVRRXh6bJdptBB7hTiAoMVKJFzBaPoCkk3EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEdKBDqN1V3wKTg7a3uBkXBs9oflWvWJlHxj30foyNMSmTyHQyED7FtvONCpAbVPfutXnQJWVNlSuJUw3yRRwbyhtmorwVGjIgoOnZmDUlUWrPAOYMjixYuQ9iz6Th47Yy5i3rdogwk+MeyC3078errf0U5ov/jclSyD3ZtMTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmIuom7H; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63f94733d6cso1671305d50.3
        for <bpf@vger.kernel.org>; Sat, 08 Nov 2025 19:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762657270; x=1763262070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6DNnuqiLsyZO9SJ1ruoojCJDemUC0rmD+JV8URPIgI=;
        b=kmIuom7HWv5Bw3LKWVZzRD70GEbWouljPMMw3bkvJX2DiBvWEjpum1E3ODjEAe026c
         ToSXkTv4VBoDYU6JzptKBIn0iM6ngsgZZFOvnLXH9FaqA6Jwgu6qvE4ikHRQxzZPV5Nw
         CeUp9Y/es4e1VsWIMZtvfSc7YRsjFzEZXH8Lxuu++tX/9g6nFUeEsXav0x1Ox87DfvK5
         C60uDeX+PgzJjVsUbcTw+gCW+or976Yv5tToowvIHmvKETm9VyiOHhgIFaDcgfRJ44qD
         MuRK8X1vr31eErv4HL6zoZi4R3iIEdVfbIATpMdTLEptNnExCIWqpiMy7XC9O22Sc/m+
         5aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762657270; x=1763262070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e6DNnuqiLsyZO9SJ1ruoojCJDemUC0rmD+JV8URPIgI=;
        b=w7V4c8rzJp5IwcYMEjmc4sGEkYnuEb7e54uqD7y1nY3e0CAtsBO31DWUnSJy4w7aXC
         m+8HY8k/QR1xaoM7KPZ3GCOMycxu9Rrjc4xpjdf/OxHnbJLz821bQUYxyjVkqDAZ9BOy
         xHwibhSah79m4qrY9NdgjeGtl1WqZnhKFCHMX+1EZpOG384Metmr38GbN/3Wfq8cVvhp
         X/W9iU6yYQX8WpW4AxXXN+Lu7eC4cuzXcSZN7UmZCm/cBRXmjAyyd028PI7QHa2rVr0g
         Ke9blyCHKXievJ0ZDRauKzjYGNBEH8491oIVV5yvnj5zjkcPKghLd/ahpIh6NDxzs11h
         dFmw==
X-Forwarded-Encrypted: i=1; AJvYcCXIP1NzPy0HDVYEf2FXNgHjrfAtG6gFZAtZmp6pdFBQvfrtEDRBg0x5eGh0MG2w27QhD7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIagADHEgfg2EqmDic8pPc01TGYFLHw6wT6x64LPolHe52w24
	Ao1DJS+lic6LbiJCyWbmSUhRHyFYRah1GeEho2OY7atdAXvavva+S3z1N9ChvEoCoMAZC7pmYFX
	/qNYSVzHr7/VG1j1Vqrm8xHxVa+lPPl0=
X-Gm-Gg: ASbGncs6oC0PvfbVhHUc9mLjRKDByMjlRa3uwpD1XHG+5V8I8QocsIGjT3AKWMVRFVp
	m86KUqCNZdGCT9LeoH3NnsaBMAjc4tJjOahkRz0JuQoAskl1p4QZ5p3gHY5Ybaho4qf6T26KxZF
	xJb+LL9vIsfNFy7JjLXlkgMNSgnalYq3+5UyJirGNCA4YRFMcbzcwVG4VOfTxCuepBkHRbct4jS
	v96kdw/KqAST1vchGHaf/7Hj/w/9E2RDAA8rllWV4dH3pzto6ayEEhcOmaqwZrT2f5a2Zcn
X-Google-Smtp-Source: AGHT+IFl0PygBGVQDcDoux4KUpDZWbMWPvO9pvbbbb8+4rH/xr6b/zEQCBbAmTqX2PhbkuQ7hJB0oosFqP46oGnaGwE=
X-Received: by 2002:a05:690c:658a:b0:785:aedf:4ac6 with SMTP id
 00721157ae682-787d5355527mr68221527b3.6.1762657270013; Sat, 08 Nov 2025
 19:01:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107100310.61478-1-a.safin@rosa.ru> <20251107114127.4e130fb2@pumpkin>
In-Reply-To: <20251107114127.4e130fb2@pumpkin>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Nov 2025 11:00:34 +0800
X-Gm-Features: AWmQ_bl4pAwU4DcdzQl2rZraMoW7kKSb0oYzeEjLEM0Qy75Y6egynRfDTOFL-tw
Message-ID: <CALOAHbB1cJ3EAmOOQ6oYM4ZJZn-eA7pP07=sDeG3naOM2G9Aew@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexei Safin <a.safin@rosa.ru>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:41=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri,  7 Nov 2025 13:03:05 +0300
> Alexei Safin <a.safin@rosa.ru> wrote:
>
> > The intermediate product value_size * num_possible_cpus() is evaluated
> > in 32-bit arithmetic and only then promoted to 64 bits. On systems with
> > large value_size and many possible CPUs this can overflow and lead to
> > an underestimated memory usage.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> That code is insane.
> The size being calculated looks like a kernel memory size.
> You really don't want to be allocating single structures that exceed 4GB.

I failed to get your point.
The calculation `value_size * num_possible_cpus() * num_entries` can
overflow. While the creation of a hashmap limits `value_size *
num_entries` to U32_MAX, this new formula can easily exceed that
limit. For example, on my test server with just 64 CPUs, the following
operation will trigger an overflow:

          map_fd =3D bpf_map_create(BPF_MAP_TYPE_PERCPU_HASH, "count_map", =
4, 4,
                                                     1 << 27, &map_opts)

--=20
Regards
Yafang

