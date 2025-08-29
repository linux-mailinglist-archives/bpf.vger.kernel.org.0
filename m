Return-Path: <bpf+bounces-66943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B7B3B433
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 09:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEEA1B27C5F
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092B726AA91;
	Fri, 29 Aug 2025 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agLBi5Og"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103526A0C7;
	Fri, 29 Aug 2025 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452402; cv=none; b=GUpQ4k12LOvZnkgVI5QB/AChOuAMfy6WV5WogZ+6b8jHcZrU0UxKhVcQRaJoVOxpHw1rvpFxfzSC5aA53DBTeRU4uvsx6+7t/uSdzOCfyVLB6T3aJ2qJJgWmh+yBGZGTjHcVNdiMRX776zLINUfHONeDdxKbFqcCYpMbNfOAsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452402; c=relaxed/simple;
	bh=BLwQCdBRaWtkRyxwP03nqZ9do149DeGJJ+GOZteNyj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JT9IoyZjDdOikAbRKzWr8FLTqnbBhgR3D5U7uztVXBPxCqSODnsAcSOsvFMohg6MjSgmPAxucm8lkMepU3CUYR6zWbaIdZhmcbfjlhbxuMZ2KGrHol9xsJbK9lhV43QCcl/0dY0wblYUJsCRelOmAKeDgvCXOXcLKddDLqbVhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agLBi5Og; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e96ff518c08so1437047276.1;
        Fri, 29 Aug 2025 00:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756452400; x=1757057200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLwQCdBRaWtkRyxwP03nqZ9do149DeGJJ+GOZteNyj8=;
        b=agLBi5Ogt3CS117aYn3scWjNLsBsGxvwua48dfqQnAOwNjMLpOrBK4bQVypxjkUZ25
         5u1WqjXEA9rQ2KojxAdK4pFePBbUYYRVTnTrWEx8w1yYEIALjQCGVrgq+IXenx+g6UW9
         Uz3Rcpp6eFmFl0kflUNfV3xQqQfTttb/V4vTV1pWj3sgkat/nhYclo/E9/eD2v5H2PP9
         JsxnfvbQV7UKhcFds2CyFb7s5TCur00uXkzh3nFm7yRDCozoUuhOvi+hzKTbjR6sQUU8
         KTJWYaDyOxLo9mrlPK501VRL4VmYf2oAcWulg1TaDtnXMPwgKDTkYMYbFgh28AvMc9HX
         LuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756452400; x=1757057200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLwQCdBRaWtkRyxwP03nqZ9do149DeGJJ+GOZteNyj8=;
        b=wugbOgopUKQybRODA+B9uIgzKnjRRD8ztkq5wEN7yKTyUZQjTq1+VOyKMRhU5Oc4rr
         8HiVHO+wp1BFGk32Swb5PwWxXHLWA+DM/zOFa9vpWH0wNdfnXIAKMYOqiFoMyGxAmXc2
         sqjZAmAoJXbASOA3Tia4MWJ6te1pz9SnotoM9MQ+P4EHrLTYW4ryHjuPZMqIjNpdYPHx
         TrXcbDglGCTE3thx5hXTYCikcLzMzCVQ79SRb1wLTaLMio3+mvU6h9V1Xr6XRtPyCFQj
         2vSgkbLd0vjpMaPZ4X/6wFr2Rw3NuN0/fgZTzb5UoR84E5L2tdRi0zqzkPQfFVvNWENe
         5fbA==
X-Forwarded-Encrypted: i=1; AJvYcCUQbW0mldsveHe/jNSAgFr2EMAP7fAPLaJDVv9LkVF5aKQ9b0UmHoESqm5873yRTqvD+cuze6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJTwYVO/P8/WhOUbe8j5oRW6WG52BdkY2lvC4kUxGAVPADnQ8R
	j4d8UxMtsd5fYIx74D2si/L6z5cdzNlHqbqvPgM8jvh7HBYvZjXlIVMmEBMQeEtZI5Eay9AWFsy
	ZWfAruyOVQwUzePt3Vt7CNmCXz/IEcIM=
X-Gm-Gg: ASbGncv+D8gjE764u2J+24KANB1jMzM1TTq7BdNsbXD0Ms/GUM6LvYzhC75W2QmFPM2
	5kKMJsbgV5EsjwJNacy6ivBnkyS7EddPbsv/wiNYjGjedpB53Fx9/9ndxBlo3zLwZYzRMIWL0NN
	2u6y6dz/y0w05L26zE1iZd7wsZONP1/o/ePSR9reL2NE98vMtjheH/rnIECRzRms+Eh7HvGr+HT
	cjPFZ8FCs02h7dZ
X-Google-Smtp-Source: AGHT+IEZrf7Ul0SM5Coa5W3xhcU5NjqwAdrQjwR60uWH8xVq0Qzal9GVN5MEuD5dfFtX0H6o3K5eDo3r03gMbs8wrKo=
X-Received: by 2002:a05:690c:fca:b0:721:248b:97a4 with SMTP id
 00721157ae682-721248bab83mr180469277b3.37.1756452399929; Fri, 29 Aug 2025
 00:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
In-Reply-To: <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 29 Aug 2025 00:26:29 -0700
X-Gm-Features: Ac12FXwB-8-TbNnHhSbqwcfKSeGbXPrnlpwG_PIuUUeRIo_iU_xTgV8A65cENzM
Message-ID: <CAMB2axPpaoDfFEBzNTaTjp4GnFKtWy0k-sTez56ap+FBZzLFeA@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Nimrod Oren <noren@nvidia.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com, 
	kernel-team@meta.com, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:39=E2=80=AFAM Nimrod Oren <noren@nvidia.com> wrot=
e:
>
> On 25/08/2025 22:39, Amery Hung wrote:
> > This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
> > pulling nonlinear xdp data. This may be useful when a driver places
> > headers in fragments. When an xdp program would like to keep parsing
> > packet headers using direct packet access, it can call
> > bpf_xdp_pull_data() to make the header available in the linear data
> > area. The kfunc can also be used to decapsulate the header in the
> > nonlinear data, as currently there is no easy way to do this.
>
> I'm currently working on a series that converts the xdp_native program
> to use dynptr for accessing header data. If accepted, it should provide
> better performance, since dynptr can access without copying the data.
>

I feel that bpf_xdp_pull_data() is a more generic approach, but yeah
dynptr may yield better performance. Looking forward to seeing the
numbers.

It will also be great if the dynptr approach doesn't require
xdp_native to make assumptions about the xdp_buff layout (headers are
in frags if linear data is empty), and creates two versions of header
parsing code.

> > This patchset also tries to fix an issue in the mlx5e driver. The drive=
r
> > curretly assumes the packet layout to be unchanged after xdp program
> > runs and may generate packet with corrupted data or trigger kernel warn=
ing
> > if xdp programs calls layout-changing kfunc such as bpf_xdp_adjust_tail=
(),
> > bpf_xdp_adjust_head() or bpf_xdp_pull_data() introduced in this set.
>
> Thanks for working on this!
>
> > Tested with the added bpf selftest using bpf test_run and also on
> > mlx5e with the tools/testing/selftests/drivers/net/xdp.py. mlx5e with
> > striding RQ will produce xdp_buff with empty linear data.
> > xdp.test_xdp_native_pass_mb would fail to parse the header before this
> > patchset.
>
> I got a crash when testing this series with the xdp_dummy program from
> tools/testing/selftests/net/lib/. Need to make sure we're not breaking
> compatibility for programs that keep the linear part empty.

Appreciate the detailed review! I will make sure to test xdp_dummy as
well. I am taking some time off and will get back to this patchset
next week.

