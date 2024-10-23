Return-Path: <bpf+bounces-42934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B269AD2F5
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD6AB23241
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0186F1CF7D9;
	Wed, 23 Oct 2024 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6KoNjEJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FBB1CF5C4
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704798; cv=none; b=LGIQ/5cTxaEJl/dXX1Mopy8x3rRWMpaq4uOD+dToDpo4oaAHGaJEy7FXv3Orv5d8Dm+r803Y4cB1R1BR8EMVQZGjHdBuMOZlVlJ5KK7ffekU7z94ZjahbIywodETX66PE5WXDd/8678igqBwHWHasugpRPscXH3jukCVI/JUnuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704798; c=relaxed/simple;
	bh=TBrlg700LXSion26XQTvuvubxbi1Bp65cDDgWqyXEzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbJDaMOy3yIRfOwyZAL9BjHM4ePHFLgYl713e/TPqH0EoPHnEwKUK4rozGIlvvpObD73vP//C6nBiWLpOjF2y64yS4EYMjOs7uezAmNa/Vaupunv4mBN9gpvOzDYLxP8nFEW3bA5w8WMJHaktAyjF+jr4hh1Uo3MwFLzj8KTf74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6KoNjEJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7eab7622b61so20728a12.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729704796; x=1730309596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBrlg700LXSion26XQTvuvubxbi1Bp65cDDgWqyXEzc=;
        b=d6KoNjEJNURd6eHlHEVKK1JMYOYHPbFfY8fYse27m0DT87pT6alglMAlRw91469un8
         ku0KDnAIQJIPSyKW45SzQPzTixHewMQw7qxt9GFjWjXpiy+uJYtAk7X7wmFhBYbZKgB+
         Fuzf38mkcyPBOpAujCcg7M9Tef1OhPIi1AYwZeWhGI5VcsrbaqzZC7JcKFCXQBZUFnsS
         +CnaywIPpByKjahYKFcUs9XYyJoqvZiGBJ54z3KJZB1MpyItJ8Tq8WEwgAKExE3ahkBM
         Ubh+dMWcmtk56GvMIl9pwvyTHDUHg9BRIExALSPIKKEHkMUVdX0kSEKQYWX8tnG7IqJG
         mftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704796; x=1730309596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBrlg700LXSion26XQTvuvubxbi1Bp65cDDgWqyXEzc=;
        b=EG5FaYLpR9vTRAPtcYXKgO6xBBVv/n71YjjNA7DTXanXOuPcCZR5TqWfufqmKII+vo
         nTwHSFTHNtmkzxdNx0TfEVaegeHkydmDCcv5jHnBBsYIVYjKmUgiJiUFIENbP4ML0LEj
         pdHTuJ453HsNGabeE/H3OUyo6we4SBLEvJ/b4FE1brUFlPqnFbxvEdSFS9stSb/Op2/l
         sTzeOx2gSfdefjarPjRqT0qv41fOFFjE7/Tkvkz0DRJXQnLB1vChswVXhDuAfinlt08Z
         6bWf7sgAXDh8h74bO8ZdwdC7WoLkZx5jkKNF/vPS4BJIhuPkVlXM49mBYBzTh4FoYbje
         6+5A==
X-Forwarded-Encrypted: i=1; AJvYcCUtixbwWigdImKyPMY8HHdq46xOmQCqAVen+4PBjpL+Ca0xTEa0sSJvRkkJq+btarJDeqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQgL0kiP6xtEWV08Z3fsYiDOuUsjW9iXkxDPIAPFtXlX458qY
	BXIebuIF5e0cBYLIqpJ3qd6sVOzKAMTwtBJAW0xmJwMkaXVo4qsoHtf5mx9uDoejkXlAXCkRoct
	0xTvgLvuAfBh4fy6VfT050pnmJjc=
X-Google-Smtp-Source: AGHT+IH/LdrRl0tQKzgSqqAOI07ffxv0HwhgUp2qz6S5+eCEz6RJ4pWySFENH/oWY5y9s26n2ozJGxWxBqGbt6jl02I=
X-Received: by 2002:a05:6a20:e18a:b0:1cf:4fd9:61db with SMTP id
 adf61e73a8af0-1d978aeacf2mr3896751637.8.1729704796347; Wed, 23 Oct 2024
 10:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023022752.172005-1-houtao@huaweicloud.com>
 <CAEf4BzZpL7faQh61X_pqr+57qxzDD1LcxWgUqNZCCKh1z5hV9w@mail.gmail.com>
 <42a4ec6bccc867d18033583b1dfea0736ac1afb0.camel@gmail.com> <31d0895a217388dfe6bfa5b74c4b346705f894e4.camel@gmail.com>
In-Reply-To: <31d0895a217388dfe6bfa5b74c4b346705f894e4.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 10:33:04 -0700
Message-ID: <CAEf4Bzbyz0+mKQZ+nM0X0RVb-z4F0e1idu1mg=EG31TMWwaiyw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Extend the size of scratched_stack_slots to 128 bits
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 10:13=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2024-10-23 at 09:17 -0700, Eduard Zingerman wrote:
>
> [...]
>
> > > We have other places where we assume that 64 bits is enough to specif=
y
> > > stack slot index (linked regs, for instance). Do we need to update al=
l
> > > of those now as well? If yes, maybe then it's better to make sure
> > > valid programs can never go beyond 512 bytes of stack even for
> > > bpf_fastcall?..
> >
> > Specifically function frames.
> > This is a huge blunder from my side.
>
> The following places are problematic:
> - bpf_jmp_history_entry->flags
> - backtrack_state->stack_masks
>
> The following should be fine:
> - bpf_func_state->stack
>
> Not sure if anything else is affected (excluding scratched_stack_slots).
>
> I agree that we either need to update backtracking logic,
> or drop this stack extension logic.

Using two u64s to describe stack slot mask is really-really
inconvenient and increases memory usage by quite a lot. Given we
intend to have insn_history for each instruction soon, I'd keep stack
size at max of 512 bytes, even with bpf_fastcall. Is it possible?

