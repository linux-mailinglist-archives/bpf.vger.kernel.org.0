Return-Path: <bpf+bounces-64687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB069B1579A
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 04:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF707B0160
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55891BD9D0;
	Wed, 30 Jul 2025 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8cY1j5P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFB145A05
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753843128; cv=none; b=MzdCPO24M6wvXFoD6YAitroVWXUARNXe+nna/S0UvJP7vyi9h8tB1tx77lLXTaxVv91blL+02ek9HWVDYbWaNAxSNrnKIOQFYtBFm0LntDiBpsLxLM+aZXVrW407TenluhH3E4CsaVpDUMwwiKggHnIbg9mV5xh5IpsJFU3QgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753843128; c=relaxed/simple;
	bh=hxy0ESxzO4XObHBrlTXB3ewJZj0XWjwyuVMwMuLMrvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQcOAWkoudE/zkA2ypY7PPyk3aWE81uDRIsI/1WxpVmHYp0Akh+2O0lLs0K5cbLvVg1JJhdMDBSntTb4JhK3oboCBiOhQ0ljP1pv4p356cgA3RZdiihUHVGS3K7M3NpNFBA8a8Z9LA2zWNEiSHJF0Cr4IHbIEdBX1pzJjd/zIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8cY1j5P; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e32cf22fdfso579735785a.0
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 19:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753843124; x=1754447924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIlSES37pL41WLJ1KE1AbPZe09fHZmPo8PDptY7TNIE=;
        b=C8cY1j5PeM49tuXbLfzaFbhXpKcqcY0EEP3YbHXa6ibfzMIRnRHkkjEhtkVipjoola
         SCnBjLjw5v2IQ3PhPt1c/KdXefvTBnICrmY3F4qqJ2Iii0LyWLeQ7C5Aw3Simv+seFuv
         i7cvwfwtgZXWGBxbOXW+y9tEwfRVu++A8oPeNKPeOvoZfZJXIuoJk3A5nO29zsNZVIvM
         kfd6CEcywo/R9IHvd+BJfTZ/b2Yp852d3rGV9go5Uxu+5x7P/hN4v3BH8M+FVYjeh73E
         YUyYnhSHxi4wl0ap8eMlHZexeQkFzaojJLc2zsViCNfJutsrMJwaU/MVgBeijw5gL1Ma
         hHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753843124; x=1754447924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIlSES37pL41WLJ1KE1AbPZe09fHZmPo8PDptY7TNIE=;
        b=oZJfkZATIohr0Anun6jNusE5JfENIm6EqlL/dOCDzTNXkpXpBHILd2wtyU+UuyiS6t
         hFWG0nIb0czCwcGFY5a517iho+3W/u6X8g4Sc2rZ/7BxD9ghVDvxUrZ3vAkeZubdi4jM
         CTVzpjDUh8ufc80R/xFF2mGGT5QQyvRwk3A4cjfOP6fDzNCk/9pFMZXxg9URtxdc7hQS
         McDtPM500H/PKaGiaD/oR3zKnk+9et5b3w1Bw9ZUzY8BU6HbsFn2/UgwsfpotJM4ptBs
         vbV8MlyOlwbQe6CEufFNt/6BMvaNP2PQPZJ4tfQEBhgURxn+1DL9mVwBcsmJ+5SicJaj
         rmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgzcphej7v0wbQ4dSpeYhg9TPPSgVJ/+k8KOoW+XOZN8ZM1uYiQRjMHSaIY42smJr4f8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg0fZ8J8hYU03k3Ez6RW4nLMzZogZFqveVqWAKLEtajybzcShD
	O5faxIM7GDC5i3U+vEp+ImkpdAwqaEHS4Ud2cnOBU/qKr41953HMKUoMvNJsD/tEFD5KpAxF+SL
	5mnSxQ+/t9BBt+k2G2n0tWzk2PzxWpEY=
X-Gm-Gg: ASbGnctaT6diLrAv2MmKELWj4DqhiSOZZ+QqjCw5zZYF/0HM5MFI1UrapsaH404wMoW
	01oehnQyxCY7axp+Jn3fRVZLuZ9YWS8yxJQGbMoLCwlZf7IQEBbFuxa8B2bFTCmcuqUb/+MwIFK
	kxbP6ueklAvBsP6wWdTeh7iANtUeiC0EyPo5SXC5jR21j6G56sGQTM8HN9rbHyTBROWedD1+E2m
	t8gxxw=
X-Google-Smtp-Source: AGHT+IHb0vDCcUCJ3tbbdgj1p2HAcP6JMItn9XaNpPNiXoKeDe13xPYPEyV1EjdV+JOfFKVUgeTsnWo7msgg5nFOa4Y=
X-Received: by 2002:a0c:f40e:0:b0:707:6d96:6dd with SMTP id
 6a1803df08f44-7076d96112emr1896606d6.35.1753843124361; Tue, 29 Jul 2025
 19:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729091807.84310-1-laoar.shao@gmail.com> <20250729091807.84310-5-laoar.shao@gmail.com>
 <BADFCED9-4C30-4ED6-88F3-D8CB7054CC56@nvidia.com>
In-Reply-To: <BADFCED9-4C30-4ED6-88F3-D8CB7054CC56@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Jul 2025 10:38:08 +0800
X-Gm-Features: Ac12FXwifuB0zFicKqHjHTHUkwrtxpGWtTsdaSZRCVin1fI3n3SARNs3T4SezGw
Message-ID: <CALOAHbDWqAR=dDoLcGjge-hWTNqEG5yRV+eAoa2rss7WTOD6ig@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/4] selftest/bpf: add selftest for BPF based THP
 order seletection
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@redhat.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 11:36=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 29 Jul 2025, at 5:18, Yafang Shao wrote:
>
> > This self-test verifies that PMD-mapped THP allocation is restricted in
> > page faults for tasks within a specific cgroup, while still permitting
> > THP allocation via khugepaged.
> >
> > Since THP allocation depends on various factors (e.g., system memory
> > pressure), using the actual allocated THP size for validation is
> > unreliable. Instead, we check the return value of get_suggested_order()=
,
> > which indicates whether the system intends to allocate a THP, regardles=
s of
> > whether the allocation ultimately succeeds.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/config            |   2 +
> >  .../selftests/bpf/prog_tests/thp_adjust.c     | 183 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_thp_adjust.c     |  69 +++++++
> >  .../bpf/progs/test_thp_adjust_failure.c       |  24 +++
> >  4 files changed, 278 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_f=
ailure.c
> >
>
> The program below will only work on architectures with 4KB base page
> and PMD order is 9. It is better to read base page size and PMD page size
> from the system.

Thanks for the suggestion. I=E2=80=99ll change it.

--=20
Regards
Yafang

