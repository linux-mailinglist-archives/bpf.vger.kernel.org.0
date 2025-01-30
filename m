Return-Path: <bpf+bounces-50096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6874A227B5
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 03:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121481886915
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 02:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86652F88;
	Thu, 30 Jan 2025 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH9k/OmU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2317597;
	Thu, 30 Jan 2025 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738204845; cv=none; b=tDtZhHuhx9y6ucA8euGLjbaji23DMgBMEaeTkDtq/YYJQSk4GLMBq71avFsvN6VtzR70syq5svgm3nKbxX6+VSgPzxIDpXrlXuUf4o22hPNbE3eLjaYMv5U+6vw1l6tHwB1tGdRNwiKekV7IkL/PJSvxepKrYvbL4ynKeAjzWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738204845; c=relaxed/simple;
	bh=9s45aQ98QyDN6mwCUCbC3+YVKYhM6hxCks1tXsZkl/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euE8DXQn++XK/uwwt+v38yGFtlaave60MClr3rWyi6PFN1g4VPPN5VMWumu6BGUsNtdhbqWwtD1ltobuQwBhWpflYTNKJuAFoHVSrSf94RmjzAD6rLDQUNqA0TYfX4IzDpcXls6UD/wqySYdAR0KXHtDkLGStIE5qIFiX6q5geQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH9k/OmU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38632b8ae71so257748f8f.0;
        Wed, 29 Jan 2025 18:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738204841; x=1738809641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s45aQ98QyDN6mwCUCbC3+YVKYhM6hxCks1tXsZkl/8=;
        b=UH9k/OmUwBvVOdvc9P/NriKCKd3q87EZQ+QbBSfGxFcQsYM450xfSn5QepWFE3ZJi+
         KnRUcCl37Jqy+8q96RY1t4NEzZfZw/ad6+Qf2etHHTgS/SqxmXbkrTlEUDnh8Xs/q585
         Nl7UV4EFWFBZbA33c/79P8bofqIna7fZz+tdnMp//VZ/pCW23SeGDgJdKGiWIs6vieBk
         nsRtZJ6PRPxRj/xJJRxc0iFBrasU9QzbFYn4AoSl7XiloS9v97MVNaK1iE/Q7xAl1zGU
         CWJcRFDUVsrI/Hal84jYArMVfLzDGiONtepwanRuOe5vw7O7Ws1gLOLQstsxgocqrrg+
         Hjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738204841; x=1738809641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s45aQ98QyDN6mwCUCbC3+YVKYhM6hxCks1tXsZkl/8=;
        b=cSQ5b1q5PBUwYnFmkV/0SQG2k8eKMBI0jszMzvXDNx4W32ZKiF4qe3i+bidES5dEYt
         6mj6tdqIbLTdHx5e1kPc5BDJbkBQV238zTgZMddXu5/agUtHIuJb+hDQqxAlTSxBBriq
         bT+2VDIQjgZTxVLQojOZbE9TIVWfxKcXdNfjFlEdVa1QJoy9yk6elMwB4ed8u/7ePz3q
         n2yrtilx9UbgBo6OnT0tQVsxEYcx4Z0VGN0042tTy1nwkeji4XLdxk4Lzv+ej03DLh4P
         0trQQDkvP29910o9wWQMwMxFl4utOl6pQqhgdl4RCKlmQQLbWY75+ekr7wtfwLmhLt0A
         IBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJcQVe6wtBe7yDnyy3bsBxttX+dnHjyUIIQfEDg5G/FR5ATIfKxdiIqmR9HuuLdQ0/JaU=@vger.kernel.org, AJvYcCVAN1skgCVCZwbbVBbytTxImg9XTSt7CMDwjBGf4HCqFQgRl2jJrDJ2Z3hM5iPRzdHgBLUggOkyAZHGT72R@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIQysdSEuqXaxWJ8p6UbeDaSa81tI7hZiTw1AZJzpCkX0JRWn
	iFHuzt7ajmCR5r/coATqMU8BOcREdRQ9HR7tB8vZBqLbMJu82sUXpthK9sLtglMp3z/UtJV1Wwc
	rJlA2khBqskakJu7PnWnYmOqt3Ak=
X-Gm-Gg: ASbGncsrOX2jcjvSh80kdoUc4NVrH7IRtyvxtlkQ9mq7rVvkxpmfx5+5DLCz8xXwTLs
	Gu/yN5ovcLvc7iE2y+IE2nqrl6nxOfAP2WNKkj1tpGdFHaXBnJMz4oaAcUBSaiamETVFS15q1w1
	xKoyk2e4hq5tWnw3eFyz2IK5IC4ecp
X-Google-Smtp-Source: AGHT+IGhTeSxR0kSauix+v06lDtacvjfitnDVG6QA0wkIUHi19qt8t05Jpx40XXLSq6sRd86ZONEBV/W/p21i9EWXK8=
X-Received: by 2002:a5d:6d06:0:b0:38a:a11e:7af6 with SMTP id
 ffacd0b85a97d-38c5194f38bmr4430493f8f.6.1738204840474; Wed, 29 Jan 2025
 18:40:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221061018.37717-1-wuyun.abel@bytedance.com>
 <02c69185-1477-485c-af4f-a46f7aadadab@linux.dev> <7139ed64-55be-4b70-a03f-8b2414fc93d3@bytedance.com>
 <CAADnVQ+ws4c=G02HjR7Oww_cSuoVFfkWMjP0BbnUrrDgo6tywQ@mail.gmail.com>
 <3c153542-079a-4566-9f32-8335bbb0456a@linux.dev> <ee5da323-0ad8-4b74-971a-ffbd3eb2b61b@bytedance.com>
In-Reply-To: <ee5da323-0ad8-4b74-971a-ffbd3eb2b61b@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Jan 2025 18:40:29 -0800
X-Gm-Features: AWEUYZltolNK9faWc_Yb4ONxPAMFkM6z3XpJ2Nnb5SFVS9Q8aqAWaj_-56509_I
Message-ID: <CAADnVQLTTQNTAafm51o2fHSqdz+6uepEa=1VUiyQBN2sWQFm8Q@mail.gmail.com>
Subject: Re: Re: [PATCH bpf v2] bpf: Fix deadlock when freeing cgroup storage
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, 
	"open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 10:23=E2=80=AFPM Abel Wu <wuyun.abel@bytedance.com>=
 wrote:
>
> On 1/28/25 7:05 AM, Martin KaFai Lau Wrote:
> > On 1/27/25 2:15 PM, Alexei Starovoitov wrote:
> >> On Sun, Jan 26, 2025 at 1:31=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.=
com> wrote:
> >>>
> >>> On 1/25/25 4:20 AM, Martin KaFai Lau Wrote:
> >>>>
> >>>> imo, that should be a better option instead of having more unnecessa=
ry failures in all other normal use cases which will not be interested in t=
racing cgroup_storage_ptr().
> >>
> >> Martin,
> >>
> >> task_storage_map_free() is doing this busy inc/dec already,
> >> in that sense doing the same in cgroup_storage_map_free() fits.
> >
> > sgtm. Agree to be consistent with the task_storage_map_free.
> >
> > would be nice if the busy inc/dec usage can be revisited after the rqsp=
inlock work.
>
> Agree, and 1ms interval of deadlock dection seems acceptable
> for most workloads.
>
> >
> > Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
>
> Thanks Alexei, Martin.

Applied.

