Return-Path: <bpf+bounces-77333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D629FCD7F2B
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 04:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92C67304D4EA
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 03:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D62D0620;
	Tue, 23 Dec 2025 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hhoQX0TE"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560882C236D
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459377; cv=none; b=acjJqmGlW56RcEKiXQ6cH1ynO/Hzz6dNpOW6SlK164TzwE8Td2a217SvzeWpf2ociytHoLrn8XjAnnltNuwGuH7DWhG2M3kwD3mr5jfIaY+r1XTC4AnCRNWttzCPVqzulz39G/oH26KfiMBMVmMGVgS652tK7zz5cHmX1cxSTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459377; c=relaxed/simple;
	bh=ytRpw626d2B1QzPR1Ew/pa6p2XN/8EY2MLoVtCzGaS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rE1BqCMdVAOCgEKUVnd+eFcWLsvYA5QPNJzJT4hWVKKRMQuddh7lacakyaqiFfaQnXtVn19z/HsrHOaULDtLIUNTtmgE9SyH4dZI585fiZLkH0TSrDpGR4pXULyJbHeX0FldcVkWYYXcpgosEtND0STSTx9p87RNVVHloB2Ftc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hhoQX0TE; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766459361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZcZnllijaalGMrElgL86g18d/eiz3nxCYnvfBLSc0k=;
	b=hhoQX0TEXgJB7rWiNxT4i3slue/uWm/NO9pe5bG3CNmAc0ky5okhCeylMjNbsQsyrHoOKr
	RL1mtMMGm+s9eMaPcA5K3dip3fHNMrQBh2A/DzL36Vq+yPsR01qj3It9eLJKUWV16nIGyN
	cWsokGNXndUoPM7ovLn8DOZv5bGjaZA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,  linux-mm <linux-mm@kvack.org>,  LKML
 <linux-kernel@vger.kernel.org>,  JP Kobryn <inwardvessel@gmail.com>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Shakeel Butt <shakeel.butt@linux.dev>,  Michal
 Hocko <mhocko@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v3 4/6] mm: introduce BPF kfuncs to access
 memcg statistics and events
In-Reply-To: <CAADnVQJ_WLMRXYV5p4Lk2+nxdC01iAaKQhYecMjx4rXdBeXjNw@mail.gmail.com>
	(Alexei Starovoitov's message of "Mon, 22 Dec 2025 16:11:19 -1000")
References: <20251222221754.186191-1-roman.gushchin@linux.dev>
	<20251222221754.186191-5-roman.gushchin@linux.dev>
	<CAADnVQJ_WLMRXYV5p4Lk2+nxdC01iAaKQhYecMjx4rXdBeXjNw@mail.gmail.com>
Date: Mon, 22 Dec 2025 19:09:14 -0800
Message-ID: <87ms39c2sl.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Dec 22, 2025 at 12:18=E2=80=AFPM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> +       if (idx < 0 || idx >=3D MEMCG_NR_STAT || !memcg_stat_item_valid(=
idx))
>> +               return (unsigned long)-1;
>
> memcg_stat_item_valid() and memcg_stat_item_valid()
> helpers introduced specifically to be used in these kfuncs,
> so I feel it's cleaner to do all idx checking within them
> instead of splitting the checks like this.
> Then it will be easier to see that
> memcg_stat_item_valid(idx) access is in bounds when idx < MEMCG_NR_STAT
>
> Also I'd do one check like (u32)idx >=3D MEMCG_NR_STAT
> and drop idx < 0 part. Compiler is probably smart enough to
> optimize this way itself, but I'd still do one check.

Sure, good point.
Thanks for reviews!

