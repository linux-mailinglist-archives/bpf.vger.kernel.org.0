Return-Path: <bpf+bounces-20615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE168410AC
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 18:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D7528551C
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A6760EFF;
	Mon, 29 Jan 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTZ2ro2b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BC158D87;
	Mon, 29 Jan 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548807; cv=none; b=mQbNTiLRtHUbij5GPyh2OcyiYiwRYYITCaeeiNG3LlxUKRmRkJjmo9Lb+EfhcGedwzujAnrRa9mBq/9RM2XWw20zxTtKPdrTmYqtRa6DEEwl+KGXdeyemCF0zBlwQ0+x16zAL/NbR4Seus2x8iBoTIbNOzAgxDJ+Cszj0oHAn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548807; c=relaxed/simple;
	bh=wa9YB22wVjqFJd8Nh8AMdYkKlwzGOc8bQjRIBK/kevA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6ZCN9bbL5Cdj7jphJLwoTkhTuQlo99/ooaHuQBJ5zaCt8/lZGOi2XRFDS7wu0EJt4dXaMiYvbchF9g1doUgQxdYlIu4eNB0w+qpUjcSBwXNPr3+vx+Y06UiS4+GRre6r2blHI3/7HT1sw4BeOkfehqyQPSz/k6qxvebwJakcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTZ2ro2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D82C433F1;
	Mon, 29 Jan 2024 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706548807;
	bh=wa9YB22wVjqFJd8Nh8AMdYkKlwzGOc8bQjRIBK/kevA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KTZ2ro2bKLKh2L2toGBxTUCQINeL2au70W0jBu2W0WrKH17+NoZgZVbI8OXTA2dDC
	 wP/CHXQck7RiiwQYjFGzGjgjfPp1/Njfw2EeM78eXkTM8A/w1P+2wxPXxoNarH6PDn
	 OvipsBAEDmOSWln67wMnBynQqh2PyXFS05qd8QYlVqmqcqRbP4cGN1mEJlJUnQVPOW
	 RBeJjE/rbn47LacmIbIrecog3Uw1P7ZJ7KTLlm8GX5lDCBYgqT2x/Zcz8FDmQG/H3T
	 X05NyVSToA/gCYDqnXfgm/5vYYP9RuHf3f51ZtFnsQLc5aA3r2UpkSsxQH8ddpmgL0
	 lpTUpAr6dkByw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-510f37d6714so2425131e87.2;
        Mon, 29 Jan 2024 09:20:06 -0800 (PST)
X-Gm-Message-State: AOJu0YwcU7rvA7SCbZkxTgQovmQN5mudvvx3j31oOoQdGQwP6wm8VNWl
	eqNZue4MjFU8m2WqIoD4frLofGG9teR7iYIaG3WbPoxS+3XiSjzDxgxS+fuV8JNPtBrQDLsqJ0C
	hJtCBgAPulDNO00unXjmfu5MbwEM=
X-Google-Smtp-Source: AGHT+IGpqggARE6gGueJlaVlua70QmIzRJjvY6/hWKpS4tRJaaw4F+FmV91Rg0pVjoyeTDz2cSHvSuaBtIJ2hxcFcWQ=
X-Received: by 2002:a19:7506:0:b0:510:6e7:6999 with SMTP id
 y6-20020a197506000000b0051006e76999mr4119464lfe.45.1706548805246; Mon, 29 Jan
 2024 09:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120150920.3370-1-dev@der-flo.net> <4cf4c371-f922-e061-debf-3642374a34da@iogearbox.net>
In-Reply-To: <4cf4c371-f922-e061-debf-3642374a34da@iogearbox.net>
From: Song Liu <song@kernel.org>
Date: Mon, 29 Jan 2024 09:19:53 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6DhcTah2BmO8t+N26mC=z4cRW-=B2OMZc-Zj-bL_=Jpw@mail.gmail.com>
Message-ID: <CAPhsuW6DhcTah2BmO8t+N26mC=z4cRW-=B2OMZc-Zj-bL_=Jpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] perf/bpf: Fix duplicate type check
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 9:20=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 1/20/24 4:09 PM, Florian Lehner wrote:
> > Remove the duplicate check on type and unify result.
> >
> > Signed-off-by: Florian Lehner <dev@der-flo.net>
>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Song Liu <song@kernel.org>

