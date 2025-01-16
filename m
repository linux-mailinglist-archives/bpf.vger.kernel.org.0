Return-Path: <bpf+bounces-49019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA8AA13152
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 03:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581393A0375
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 02:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4E85FDA7;
	Thu, 16 Jan 2025 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COLd2m+F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF85935967
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 02:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736994228; cv=none; b=tme9lGi/3CpMo7Qganvm6MgwEz66nNOa8XUb7pnYmA+B9l/bl0Kzze5a2X8WC88EfIh9LUNEwQaOA/NRA5y5tZ+PvoO+EgPEFubzmqdp7PA3UOg1GEEfqjnSjN4BERsDV67910BRbJI4bupwZEsI6dcjIw8XsXZNPTZ/6qcJcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736994228; c=relaxed/simple;
	bh=s4e/YqnrHIT92RS81RAxJRDJej6e+hO0qAyCzphiB7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xq2hf/owyZeHP2MGbaV/H9q/tz7W8fvdv5UqYvNcHWktm1Ti45Z6JbK/tEsiJLpbkXoYESANwHzmwXC0MQi2J84NFRbQFtJfiMbxnDNs/qyUDqzXIVh6zBD67UAbyXPGEuNRpAwoYEfusUfpAo0hpMGGKIMDGyFD0Y09BSup0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COLd2m+F; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so420838f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 18:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736994225; x=1737599025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4e/YqnrHIT92RS81RAxJRDJej6e+hO0qAyCzphiB7o=;
        b=COLd2m+F2orGNOPTp0N1u3SfW7Xx5hkORVr7vvnRBc/vzt7OSKHoS3BzQZwcP+WrSJ
         bJzuLiTp2IVGKbK2f7lGwAD/vln1nLT03D4zCmWNSrui3OZzD3OSea8JWVsSBcLVBYgq
         DtCUdV6tuozabILnkMUcn5H7hzMzKCoiggCAWMzg1V3F4aeLFYFQ1HFa7vX/OJF5Olq0
         J58DSG647klqVJktoYIaKVv1sFE8MQtmnlMompLm+vtIq6f+m6xp+Mpuva5Q1tGxUPyk
         xcr7OgmUdN3fK59911cppqYBzI8wYbFzyoZHB+TssLWTABZGKNbjfIn43lqQbaDme1T1
         kULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736994225; x=1737599025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4e/YqnrHIT92RS81RAxJRDJej6e+hO0qAyCzphiB7o=;
        b=woxpWS/XpES8ANaX5WXHUfVNOHogZ53Hb2Uf7JMXhFJdPxenOcPEZXHmLUSQE3mR7I
         vzK7jiMZYZ7LoVr2jTcdoe1bUktSIxYsX2h9MGEPyUw3J24I4mczRzq7nDOKkKwy4D9j
         uw6fFz4f128ZXFiENVAHpzcx+8JJcPEl7UJRsyvK9sTmtuMpLlmE5sWLRwTYDkbsi9Ky
         vbr6Ot2Hooz25vE5b5NXovKQz2uDRyFNA786bp4DiVrNinvYvItjaNKa3n9KaGfEj4OD
         d17GzrpAZ5q6E/hBOGkfUSJX2wjvYYAt0mMt4Cxy4uug3v+MPqX+0Y9jWEV9GKP68/mE
         aUVQ==
X-Gm-Message-State: AOJu0YyMSCPAXYvHnHdo9o2Q3oTyb0KAJR4iJH00KWO/vcjX9FrrqXeY
	+AFPtraWmOvoHDGlLlKvAw0b8PKfabjdmjr0sBQg7I4ponZYx5g3Mw3MXzukm7q64ogBzue6L4E
	knH7tzY9JDSi9E2oCiNU+7Mhj0SCtDMPX
X-Gm-Gg: ASbGnctOxDAFnjJhh0tF7eAVdha1XcRlJZDDzqnjj8dDZMPZkyfMXRAkNTiblL/9RgH
	EF/9yWM/eVHPb+f1j05jfTI0Er9jZHVIojtXBNQWAWq64ssYrCX0YcQ==
X-Google-Smtp-Source: AGHT+IG/3C4uxYhlDydXBca+JI/Xt8S6sYqKKoiYlx43lXzEzNmrRuX5pPxWnMkdakyUd7hXz2SZE9fqz3vtN4LgBpI=
X-Received: by 2002:a05:6000:2a3:b0:385:efc7:932d with SMTP id
 ffacd0b85a97d-38a8730faafmr28249900f8f.46.1736994225010; Wed, 15 Jan 2025
 18:23:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-7-alexei.starovoitov@gmail.com> <422f3667-5048-4274-8aa5-e9ff19b6221e@suse.cz>
In-Reply-To: <422f3667-5048-4274-8aa5-e9ff19b6221e@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Jan 2025 18:23:31 -0800
X-Gm-Features: AbW1kvZ2EtZeHDb-In3isEjicXvQDjI-wxRCro1jO63eXmc0aPtUE8uI5DiC2t0
Message-ID: <CAADnVQJhjUDzt2hRgrDVj6nykR3RsjCEk-BB0udnHR0T1XSm1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/7] mm: Make failslab, kfence, kmemleak aware
 of trylock mode
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/15/25 03:17, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > When gfpflags_allow_spinning() =3D=3D false spin_locks cannot be taken.
> > Make failslab, kfence, kmemleak compliant.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> All these are related to slab, so this would rather belong to a followup
> series that expands the support from page allocator to slab, no?

Sure. I can drop it for now.
It was more of the preview of things to come.
And how gfpflags_allow_spinning() fits in other places.

