Return-Path: <bpf+bounces-41392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05D9968FC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C101F2469F
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A01922D5;
	Wed,  9 Oct 2024 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCjEtdle"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FB189F58
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474015; cv=none; b=i296NQ36BQI708dGF+/swWUn5MoA0MZgMEO7R5XOGqkzWEepy/ek5PRboIfaGb+/UFjHtHVzl4H4jzpcvGsUfW+CCMxKaQKlGB1p4pnWpW9gP7KHZEddcOPJLipcMPtDl03e66Dn5zRiOft73Ojw6+HUtvepNeTTQccVZ5tz43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474015; c=relaxed/simple;
	bh=NaDl5ZuOVfLFopa2JoqM12Ws3nZLohYZvdyEy46xmT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5FOor8zStka3OsXA4H8o0h+zllpdkLxBSqEE+K4W0Gc/ddHdZ/LE8rN/Fz6vWKW51/Kah3efuihu2K8K2l23GVOQekXOWNfwsmcydGqrgZqVGHXzumVxJqR2kbLwEvM1Ocl6Vla4fyIjWx4h+0Yt3SFVmholRtfjaDBgzW4nXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCjEtdle; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7afcf50e2d0so54691485a.3
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474013; x=1729078813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MUl3+mouiCsPxtFkYTzTreFaU9CZlXJfk3s+zvvzZY=;
        b=nCjEtdlesjxRUkaCjAWRYXoMIYeDdDvumnLxOjEhlyK6dcpuUowVzIG3I8IQdaDVOo
         ej0KEFxMDb/MpK/JLYBtzi289QlaihiN0z1oojSRp2BLa1+5wHOPdzGzVjlQXR9Va8Or
         WcNqMWtMeuacPTjeDngyLp8Ik+VeZymLmDAuhU+wcRGxQ8x2vsdmwMMJ+1J/0JPehHrQ
         jjeGifLpWahqFZuo6EaEd5C5BAyjvsycj0riLxLMThNAc616OXC5A15Gi7d6F+sHO5Xj
         a5irHDMDDPT7Nvb75SuzmeybE8EzO7uCydaRZTcL7xbxPp9tTq1kUJFiEhECeoKdoWcR
         kMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474013; x=1729078813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MUl3+mouiCsPxtFkYTzTreFaU9CZlXJfk3s+zvvzZY=;
        b=fkCHsuG2QyxQOZr6RXM1QkE9Mck8lf0MGcoxr7Nz7mC8EsoCfeXlO6TSoxFPDD5nS8
         TqkzgxFyfob0zi9DW2+dMRg2wVd0CiAV13oBETLfV6GhWOaGRr1aZ8EQfvpp9VEdjdMF
         tBALrLgHt6FCWATz9zLbtd3mTOK9ig+JAFQfANqUloJFDm6AWnRosqm+r50IuQl1hTFR
         jZ1z504rMSx/p4C+d77q5m7onc069dp46vH7G7FA93MXk5d+c8Rde4GFkeZEoQgkeYLJ
         cdu3VMseJkkYGZeco3ojW4eMdZi91BP+gPvuSuvjLUsQrqVhA7kr1n+9I7Zi5iFxWAe9
         +MWw==
X-Forwarded-Encrypted: i=1; AJvYcCWb6iiBPKAbM2nzi/AEgUbRDddyejCCapp5Wsbtc6XJ9hdRft3gnLzvSVuB7iOXfExNuoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFuTZIkg7vkNyx3Q97bnYuEgTa8k+Ci3guWxyeCiWDgUjzUXNA
	UII8GtSDTm8cCDYT15QhZUmDyMh/DDgXsouyXX6Xa7pcGFP1Eho+obVPJ84lzWe5OXcgNeTMwRX
	7IzYojOPqMxUnxfy5zT9cPba7HhA=
X-Google-Smtp-Source: AGHT+IF8wC18ZtoKuAkKYP4urYWspPZTga5l2bGZt0CT9Jf2jqxgz/vg/SvbOnRwVJyv417BMA3N9URda77CL8Pzxgs=
X-Received: by 2002:a0c:edb2:0:b0:6cb:ced4:eafd with SMTP id
 6a1803df08f44-6cbced4ebfcmr10927776d6.35.1728474012315; Wed, 09 Oct 2024
 04:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
 <20241008091718.3797027-6-houtao@huaweicloud.com> <CAEf4BzZ2J+Kd3wHNUM92ro1ikD3kqMF9zXEMPbG7u=GAVev3Xw@mail.gmail.com>
 <bcb4adcf-0e02-2543-6cb4-ac237b11a061@huaweicloud.com>
In-Reply-To: <bcb4adcf-0e02-2543-6cb4-ac237b11a061@huaweicloud.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 9 Oct 2024 19:39:35 +0800
Message-ID: <CALOAHbA+k9mgGfc76vuWAEAdCF4mhMFJ9qrt1N5ECiQiWQzFqA@mail.gmail.com>
Subject: Re: [PATCH bpf 5/7] bpf: Change the type of unsafe_ptr in bpf_iter_bits_new()
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 10:45=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
>
> On 10/9/2024 2:30 AM, Andrii Nakryiko wrote:
> > On Tue, Oct 8, 2024 at 2:05=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Under 32-bits host (e.g, arm32) , when a bpf program passes an u64 to
> >> bpf_iter_bits_new(), bpf_iter_bits_new() will use bits_copy to save th=
e
> >> content of the u64, but the size of bits_copy is only 4-bytes, and the=
re
> >> will be stack corruption.
> >>
> >> Fix it by change the type of unsafe_ptr from u64 * to unsigned long *.
> >>
> > This will be confusing as BPF-side long is always 64-bit. So why not
> > instead make sure it's u64 throughout (i.e., bits_copy is u64
> > explicitly), even on 32-bit architectures?
>
> Just learn about the size of BPF-side long is always 64-bits. I had
> considered to change bits_copy to u64. The main obstacle is that the
> pointer type of find_next_bit is unsigned long *, if it is used on an
> u64 under big-endian host, it may return invalid result.

IIUC, BPF  targets only 64-bit systems?

--=20
Regards
Yafang

