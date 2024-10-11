Return-Path: <bpf+bounces-41789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE6E99ACE0
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 21:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA5D28AA38
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D51D097D;
	Fri, 11 Oct 2024 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izmg42rE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB81D096A;
	Fri, 11 Oct 2024 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675703; cv=none; b=Jux0Pzcn39Cio6lPyIVTUnD0cs9q3q5ddE8v5JV5AJDGFIhooEvcl48xn5Hddb7Ah+GIaobQ/7aDEX7Ce2LIAG+OICsUC7++uyaLZZgyumfYGF+ztLtE1dGNH1IqVoYGKUhQHH5ZdWaY+SmPHo3fHgeVyoakbsukvXqGePxHJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675703; c=relaxed/simple;
	bh=lTu+pTAgA6rLAELTw8xavpn9jGzpqchDEGwultbwUbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4xC2KHeqg2wKXwurbsXGD3W6PPNxvqewPizDaAz9cYYxEH3oQ1Odjxqm8Adbfyzqnb1L+uvxBjOwOKfWwgTImLZMmZcneE+LEGzLxiYPtmn/eXXxJJvQS5UG3rHxRiVfzUgaz1oDw0c4tON8UFh908wb7JptUAt426db/L8ZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izmg42rE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso1565031a12.3;
        Fri, 11 Oct 2024 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728675702; x=1729280502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFisYns8aYjAhl6piQqkukXDSbbS3j/nfB3lQWveeRc=;
        b=izmg42rEZK7Z8eCGIRTS+i23MhJ8vC4ou4ftaBYGr+xusBhoLdcIQ4mG+zsLno/YLv
         Az+ZC8FdUN4+dpj0s8v22oPJcscm1ifbMUJ1ADdpEOs/+lPiEpCph+eko+RZprz9aauK
         X0u8IyOGYrk0P137RhSGE4I7Q7x67eYm+NrowPG9SQKoBbIgsi8H/KQ1HVNZ9c70Z/Ul
         wDQUtBdxz/tyRrNRX4qx6WZ73WnbTv5CrAoy+1f4XXHgTfZ/iyemKhbTH2WsMyQryot1
         9L1IUPsndOnJT3B5VF5TKGWr05BxjweBlraJoLR3XWPqEr2K5cTTt3xMB8H1m1GjhCGU
         boKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675702; x=1729280502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFisYns8aYjAhl6piQqkukXDSbbS3j/nfB3lQWveeRc=;
        b=RVPY4jzqXEbc4PHstJBOGB6CaU/794U+6EMDuPJQKELU6UqnwmGZmLi8JRquc9ex3E
         3Cez/lH7nSRTDu46BSTJqW6UvM1tRtSnFWeSoEsMO2jytn/GBZmUHJ5sBJaQfhOu5C9g
         zNb054Lt3m+ZUdMqjoqKyxV3wjFKzsGWhIvP5fjCFh6yBgms5iX9BOQ8/Tb9UqT2L6we
         996HLtmn14CZxGwRiI82qWsnp2cpZkgcGI4ZgnU4+E3IbH7dSyq1i/mgVPJLY1l1iYU4
         /EF+BAQS6zJ1q2avZEAmSjgON5BlsRM98ixKp40SubXJ0j3BprId5Dyfqc1k2Zl6MMX5
         cn3w==
X-Forwarded-Encrypted: i=1; AJvYcCUwg2aKImPRZXXeKj7kp/VFEfwhH15JemcAtxOSzbDMuOgx5tkTcqO0Ep8FhyME99KoGUo8IQkxkqEk30wG@vger.kernel.org, AJvYcCXgL3drJWgRD3yAFtmZQn4celDgPiKCi3w8dSRFpCYD81M/0oVRYVrM+XLQr9LjW2Vi5Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIzbRPDq9AN8mDZhQvnm8g5IAn8dsBh0KL5DA3tNY6cspotcOH
	MIO7os/SjB968TJqCaF0oohgPV0ZUM3TVFX3HFDFT0jNo6jdErADKKIXAI3pUhV6MPLYj309oJG
	/n1A2wWFgtKfvlOSmhpIhExcTXA8=
X-Google-Smtp-Source: AGHT+IFnIrTaf8dYQzeaJQDq3FbVwzr/O9BD84DlhpqT0nVFykaQwNo0eH2D8Ozpoz1RPjpQ+hUs1KhMQ/opmBDuPvA=
X-Received: by 2002:a17:90a:fe18:b0:2e2:af52:a7b7 with SMTP id
 98e67ed59e1d1-2e31536e834mr601877a91.34.1728675701822; Fri, 11 Oct 2024
 12:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010232505.1339892-1-namhyung@kernel.org> <20241010232505.1339892-2-namhyung@kernel.org>
 <CAADnVQKpYDDsF+qjKRTxgF=UDqajGMi8BVeFD3UfUxS=_FMP0g@mail.gmail.com>
In-Reply-To: <CAADnVQKpYDDsF+qjKRTxgF=UDqajGMi8BVeFD3UfUxS=_FMP0g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Oct 2024 12:41:28 -0700
Message-ID: <CAEf4Bza__VNwyqNdyy-aKS_eiPRThMv2SZaYRvnwr5DXzgqG3g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add kmem_cache iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:44=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 10, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > +struct bpf_iter__kmem_cache {
> > +       __bpf_md_ptr(struct bpf_iter_meta *, meta);
> > +       __bpf_md_ptr(struct kmem_cache *, s);
> > +};
>
> Just noticed this.
> Not your fault. You're copy pasting from bpf_iter__*.
> It looks like tech debt.
>
> Andrii, Song,
>
> do you remember why all iters are using this?

I don't *know*, but I suspect we are doing this because of 32-bit host
architecture. BPF-side is always 64-bit, so to make memory layout
inside the kernel and in BPF programs compatible we have to do this
for pointers, no?

> __bpf_md_ptr() wrap was necessary in uapi/bpf.h,
> but this is kernel iters that go into vmlinux.h
> It should be fine to remove them all and
> progs wouldn't need to do the ugly dance of:
>
> #define bpf_iter__ksym bpf_iter__ksym___not_used
> #include "vmlinux.h"
> #undef bpf_iter__ksym

I don't think __bpf_md_ptr is why we are doing this ___not_used dance.
At some point we probably didn't want to rely on having the very
latest vmlinux.h available in BPF selftests, so we chose to define
local versions of all relevant context types.

I think we can drop all that ___not_used dance regardless (and remove
local definitions in progs/bpf_iter.h).

