Return-Path: <bpf+bounces-39364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F01E972545
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 00:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4510FB2355C
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3E518CBFD;
	Mon,  9 Sep 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm76sGHa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD61791EB;
	Mon,  9 Sep 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920680; cv=none; b=mntmGJ8IGJFIf5xLJBD0cQAo75d26MS1vWm37lAxTTh5hasMf5sPlVJY5o1bXIUT5D3tiQn6906a8Z8RtoNaKd+Wrw2gXVaCZKAnG7WptyoYE4PgfxiMY7h0PTlJTt0FA3XhMmjZM4J5daFOAKeld0SqrVkn/dKqUyLXHDMNggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920680; c=relaxed/simple;
	bh=A65dHq8SrBof1EK4+FRX68VeqUYHKWMXQSDOF7udmb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEY0T9VPWOLMK0KJ0GZb4ffCHN60/X/GnjSwtAPwH2B7BsrIBNAIBtK00RaXylL4CpNS2r2dloZEGO0FtMoaYPwEeFzzWPD5LWH0TQndRYvw6UGwvbmcbRwt5ElHnS9PLkLghloNL1Po1tEcSVUCA0ChVKBCWBLPW9IcufXnx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm76sGHa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e1915e18so41685935e9.1;
        Mon, 09 Sep 2024 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725920678; x=1726525478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGt/ZtW+N7LSR9f3LfpNgINkZZJKL/4srk2hg+sEZCo=;
        b=Zm76sGHaZHGqHx1G12RsOOr9Do+MePqXzVsuygQQvfXo5X32xnSo8PmVhJwDdToODl
         Ph/yiWtaSnkTNY+Q53SNUuFZjvutv5IG+TjmwJrwGQCedvLvzw4BlqaokDHYrBkQaWNe
         iv7bishY90IXtNMkdDkajBZ0GeEwO9buyhwIM1I1yGX7KQ1bwyfQm0IZJFpXj6+lfgLP
         aCTsc5hatAr9HZef60SOMiyhCAZhZ/nMhJqvLjKTaE+lo/cT/KAeURa5JKDB/sIsNEzf
         YVQ5Yq1QIg9xRw772duVXNX7MsjO+N3X52TAvpwjSXxneTfMurz0Jym9FYa0KVmEhXCL
         UJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725920678; x=1726525478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGt/ZtW+N7LSR9f3LfpNgINkZZJKL/4srk2hg+sEZCo=;
        b=jyQ+HCH/5UIQbWxYeu5Es4P84GLKwUUvI2BJnt6s29dFhD4odsdLgCQ2tfwdOAD1q5
         H1ZqoPoRceMDN0kgzqy1YO6qkr35FGlqkvR9V4eAkrYnfkZtnU7Fg2+wA2yCW1/Gc/Ox
         kNSJ4FFSuFUJxsTwM5sjGClUkKwpdI6fQdadLPjghX4fyhzLRBVZ2UB8gDO8qRsh1z9a
         LnOjjMI/+/6V1t3s0+3gduElJTy4nNs5Tdo4CNn6cv/QmED24RJyTnraQ9l4ZNWn7955
         QVsZnFAKAexdJdLT30LuFcrkW0SqNjl7pCzDsmyqH9kjBWlRqsYyfMlmMAHopFxI6g1i
         hrcw==
X-Forwarded-Encrypted: i=1; AJvYcCWR4FB+JxbxANgXPN0yE0KN6cqS+l1zFTDPBMC23se9A769qXZWxjH/UJpF+wtfpbtgesqxnP/Z0eevi22YYY7p@vger.kernel.org
X-Gm-Message-State: AOJu0YziE2usm5zSvvQjbnS7P+b/NqxjxqSFb0vIgRFJQzO3vfP1FElx
	d6ylfa2N+2kR4oCXYhzjBfgLidofmPQz4mV78R1wxfSyPPq8mymEZjCm6+zDX3CJGivbtEjI88p
	uZUq2al+VfvniHBMZ6qo8SpLujrF9H9Hd
X-Google-Smtp-Source: AGHT+IGGGQnHFHRHFN3HgHoQZ5vR66XLv7nK6IlX44a9/O0fGie1LFcLEBLjlUbfLxLXMZuJdcoSBYhgq6OybEqE8VE=
X-Received: by 2002:a05:600c:19d2:b0:426:6f1e:ce93 with SMTP id
 5b1f17b1804b1-42c9f9dd28bmr85756975e9.33.1725920677308; Mon, 09 Sep 2024
 15:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909190426.2229940-1-andrii@kernel.org>
In-Reply-To: <20240909190426.2229940-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Sep 2024 15:24:25 -0700
Message-ID: <CAADnVQ+ajceD7GcF197=9H=S9x_kMHvKuwQGv0JgWgr3-R2AdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] MAINTAINERS: record lib/buildid.c as owned by
 BPF subsystem
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:04=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Build ID fetching code originated from ([0]), and is still both owned
> and heavily relied upon by BPF subsystem.

Song,

since you've added this logic back in
commit 615755a77b24 ("bpf: extend stackmap to save
binary_build_id+offset instead of address")

Pls provide your Ack.

> Fix the original omission in [0] to record this fact in MAINTAINERS.
>
>   [0] bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")

Jiri,

since you moved it in that commit pls Ack as well.

This change to the MAINTAINERS file should have been done back then.

So it's obvious who understands and maintains this code.

Currently get_maintainer.pl script is not helpful:

$ ./scripts/get_maintainer.pl lib/buildid.c
Andrew Morton <akpm@linux-foundation.org> (supporter:LIBRARY CODE)
linux-kernel@vger.kernel.org (open list:LIBRARY CODE)

