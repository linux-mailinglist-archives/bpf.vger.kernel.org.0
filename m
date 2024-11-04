Return-Path: <bpf+bounces-43972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F79BC0F7
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 23:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C570FB22158
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 22:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA791FA270;
	Mon,  4 Nov 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtPbXOx5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693DE83CD3;
	Mon,  4 Nov 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759559; cv=none; b=SfiAst0hQroPCW6dvciYM9WkyAkSY+DVZMJBVEem0st1iaq5JG6Ha8I7/S0o2SnhIVxEyu+kIWJXH+aQrZuM9ennNEI0EjVy0jaiLyTBygNnzzlrJh0iFpFFc9U9ysLsB421RRL83gUvkf2YvXR6nZRNHtK4pucZgVxFt57Bihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759559; c=relaxed/simple;
	bh=mjrv4wTdlcKzFJuhdOyAICGhdxETluIkpGMZRYRv3J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mb6f12dJScWEXrEL1r0lVYs6fQ9JBnt2DyJAF66+iX4nlQeM5+di4RI9em1MaWO7Kkgc+apfFwrV1baCjd8sZDgQnu+xhW/eJxILQg5hyiC6OsSh/sv0VhSvkwAWLLEAgPllIiNyycG/0J5DgJNXeUzIl3cfpwdnBKp8wkZfaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtPbXOx5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso4055360f8f.1;
        Mon, 04 Nov 2024 14:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730759556; x=1731364356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjrv4wTdlcKzFJuhdOyAICGhdxETluIkpGMZRYRv3J0=;
        b=YtPbXOx5GBJfaU4SM9qbDg9F7KyM4VeljOXuQkTwoL92rKVGMMjqztSnieZth66hjJ
         L1Q7DrgKkHnyHvMGlPW2yS66fkslhdDD4erKa6yoiDkPpRuhVP+5Pxk3s9mgMcm0NitH
         IciLEd9QaI7mdCV5lvFk02pfVFMh9SGl8Kl8fvQNhe66Ot1hRqWSUkZnvVUTfqBnE3rd
         O5PHMHPZRlZ4sf/YAkZ98mwr8xUC+ZA9hIffI8cFTyxKSDHqlz0bzqsTfhTIeLCliRLE
         5tv4faHND0WFXnF6QLpQVJNfs4RWd6jgerb9CvoOmiIPENHoJ0VSY5QPOnlnvCiCUvmE
         tzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759556; x=1731364356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjrv4wTdlcKzFJuhdOyAICGhdxETluIkpGMZRYRv3J0=;
        b=A4sBAAW55ge5fw0J9QatouAnot+KGj2BE9n+6/rRB53jV7Vw/jpD55gIaf2XBG8SkF
         CvlqRm0J8jVb7WSffSCB+xxy3qHFOThgC21D8X+B55OCPAh2mURF0MX0uf6dj2IcqSgp
         AGy66swdMc3CNib6mGJUQVpeTU7vbuAEG0GI6KDbgAqkKaBJBfQZzfUtjnnSbeaMUxcK
         R7NiZFvR7fZwSjWNfo1wUXo8SC3zk3VcXFDw43Rxip0i4Baz/QEVIsQnyaS5263oWQg0
         k9A6AN9t6z150ftjUyb4DNBpxmyT5ZhMksBb70Lndt0CZSZOsp1u6flOy9J3lBoae00J
         Eecg==
X-Forwarded-Encrypted: i=1; AJvYcCU6FrsR4n1Wba52AiQsytL2Dj1uSaSQZDzxLPsbkhW8Ydj6mrYmRTPStytT0ibYeqJ0bv0=@vger.kernel.org, AJvYcCVmEdxn6Ici7RT0dhC+CgNQjE/FK5dyX+HvrL8OW7KMLAup3EG0p3fdVqYssnI29+gpUHVILQkq@vger.kernel.org
X-Gm-Message-State: AOJu0YwLROUiahilZ3cR/Ea3zhUFqTTFSBWp09vKhxexdQ3Z8NC/QzhH
	48TUImlCrJQZrjlBiG95OeR/RxUpnhSCB0/au7DBGWuaMc+QwIzDsJx5eBylvbt5DGl7AZx5h1x
	b09qwLBxRig7d5OiTcA+ykiOQZpA=
X-Google-Smtp-Source: AGHT+IGK4ZJI9qMe1A38LGaeof9HgpRBPQEJ6YWzV01dbldSAuXAsO8U+wSf0RbxJ9Fma63rPV81lyoJ7muRUIJK6GQ=
X-Received: by 2002:adf:e199:0:b0:37d:4eeb:7370 with SMTP id
 ffacd0b85a97d-381c7ae14bdmr15071294f8f.56.1730759555465; Mon, 04 Nov 2024
 14:32:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
 <CAADnVQKnJkJpWkuxC32UPc4cvTnT2+YEnm8TktrEnDNO7ZbCdA@mail.gmail.com>
 <5c16fb2f-efa2-4639-862d-99acbd231660@huaweicloud.com> <CAADnVQLvpwLp=t1oz3ic-EKnaio2DhOCanmuBQ+8nSf-jzBePw@mail.gmail.com>
 <85160853-cc20-40df-b090-62b4359bec37@linux.dev>
In-Reply-To: <85160853-cc20-40df-b090-62b4359bec37@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 14:32:24 -0800
Message-ID: <CAADnVQJEE5yfhpqJ0f4BQVtVh+SWrPeA-9pPu0gfRZB6rm59Ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel symbol for struct_ops trampoline
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 2:13=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 11/4/24 9:53 AM, Alexei Starovoitov wrote:
>
> > As a separate clean up I would switch the freeing to call_rcu_tasks.
> > Synchronous waiting is expensive.
> >
> > Martin,
> >
> > any suggestions?
>
> There is a map->rcu now. May be add a "bool free_after_rcu_tasks_gp" to "=
struct
> bpf_map" and do the call_rcu_tasks() in bpf_map_put(). The
> bpf_struct_ops_map_alloc() can set the map->free_after_rcu_tasks_gp.

Ohh. Great point.
struct_ops map can just set the existing free_after_mult_rcu_gp flag
and get rid of this sync call.
Another flag is overkill imo.

> Take this chance to remove the "st_map->rcu" from "struct bpf_struct_ops_=
map"
> also. It is a left over after cleaning up the kvalue->refcnt in the
> commit b671c2067a04 ("bpf: Retire the struct_ops map kvalue->refcnt.").

+1

> Xu, it will be great if you can follow up with this cleanup. Otherwise, I=
 will
> put it under the top of my todo list. Let me know what you prefer.

