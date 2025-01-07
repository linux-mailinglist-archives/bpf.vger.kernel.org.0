Return-Path: <bpf+bounces-48051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 639CAA038EE
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 08:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B011885DAD
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E51DF726;
	Tue,  7 Jan 2025 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="FxTLbs4K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329671DE4CE
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235589; cv=none; b=SOhKb0vbtfe0q0p2kHlB+O9aRZr3o97eRUxHi7exaKWvoj26wcZViG6Rj4Kpho0zrgAUZxKT+cDHj6kmPUA3oeCrMy2wqUJpdfJjdlq7evO0roEZ30gexJxRN01hfClyS0NmxTDXCEgtX17VEh5Xj0UoOIdI+2eb++eSmWkyUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235589; c=relaxed/simple;
	bh=XUQKTM6z7ewqOJszAGdwsm3XWSr7aqcjgOnpDzjvrxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1JyjWmd2dwLWqIfSxhycqbrNltakMRy8LgvtxjUOFZavYw0Ui/BoCJkhjBeE6XD8cpkUweISZ+3UvWvQrqgGw2J/46sPCHgXCaIbYU4KiuQQWgVsoqRNqn+jsPeM1tK/4LU+2yQmGI0JWTYfndnuFfb50S4+9KHxbjRwM8+EEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=FxTLbs4K; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso1223016966b.1
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 23:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1736235585; x=1736840385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1APbaI3cDjZdK4oFbUu+l2Yj970rKPio1SR3jcny1sA=;
        b=FxTLbs4K/3MO/vbIZBj9VtX/ZKFm0F+7R8o1HxXFwHKg6twhH41I9O49VbZFTb9Bcq
         rZZFMol2cmTG5XAVK8X9u5whlv04aaAWKh327yh9Mg8UR01drUsGKNN2oaLNCSSVC7R9
         /elz7z8+hTHfVvJPDP0BYVKjAAttIQWQZU3m3P3pO2L4rifGX24+wMKssqJgru/WJgOr
         rMTjT6GrUQzdU45KLHpFX2vzn6aBECERWPxY2JvGDI0kYtrJ04eU8hr3VWvbDKD0SPaO
         8+Wafney0a9qJTGZIuzo67cI+tOCRD2hTohigqk2j3L3i80BD04MPcVdUVe8QpPfK9X4
         AoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736235585; x=1736840385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1APbaI3cDjZdK4oFbUu+l2Yj970rKPio1SR3jcny1sA=;
        b=ECo+fkJauHHAsGTwc92CiO8ZYJB5FEujEawqh5/u6tQi4CFrRGJGUJz/K9uHba3AID
         NzZhdw1iYwpah58hn4+WxXFI7K5TnzhcmfDlKg5wOyiDAJoQrkY7O6FUe2ItsEJHM5Mr
         XJxouJzlAh5x4w30CAyrFdnyy9B5TWWujcDvdQOpfDsqfdWS5Uz+ltSbG0MezfJ35mHW
         LEq/xGyBD3uPvCAykZ/yymQU0LCK003i/AT+ilqfMTYbPGYjf63WEyHDVBuphTCnCauN
         GRei0Oz6waW3Ux1i5nJylHGQq7PFQvjqESAhg3bVxad4B4iwdUASKDwpg5kZaTmJ97ia
         1quA==
X-Forwarded-Encrypted: i=1; AJvYcCWl10tJQFseZ4pNJIxY8NphaV9+5a/AQwD6sf2+ulFOHjcp0nmn4fCfU/lLZ/Py7dGPW78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDG3/Jn6GcQJwlsacT36VTYu7D6sNymkD6H4aRYqTldvooL4sj
	dBqJdS7DZ8V/ZLwfpY6mYPKgEC7twPoKuf8gLTdp/fxJ26eKWbHKoFR7XDjUs30=
X-Gm-Gg: ASbGnctYdptz4A7Z2cS7/6PwdyI2BZLLXStjmtiiRMHqQkEPuz5lKcatgnD+kTVljzR
	qHG6YAtlbtYQLGWY/UM67ejPr+yocJFjIuEC5zdLU9Dp8WLHGpBsOWnrbui3x8PY+gRpHtIZVkF
	nrdVkSboJdQD5TMaN9K9Ed8TN6sQzBITFHtHL88Pxzw0pUHyrF4Ycmvrf+wZ/QbXJjlQtYcsCOW
	5CXchudRYoU3VPvGKKxMbXfCBPFWvo7Eryi6SfLYeP00w==
X-Google-Smtp-Source: AGHT+IHL8T4nYDz4XQvjSMIF8Ie4SVseQIt1d68UC7+M19p8tUQ+85DUFN/i6b/0XyZ08mAQSik2vQ==
X-Received: by 2002:a17:907:1ca6:b0:aa6:938a:3c40 with SMTP id a640c23a62f3a-ab2918fdaf4mr158053866b.24.1736235585402;
        Mon, 06 Jan 2025 23:39:45 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f073333sm2314667666b.203.2025.01.06.23.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 23:39:44 -0800 (PST)
Date: Tue, 7 Jan 2025 07:43:50 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
Cc: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Nick Zavaritsky <mejedi@gmail.com>, aspsk2@gmail.com
Subject: Re: [PATCH bpf-next 0/4] expose number of map entries to userspace
Message-ID: <Z3zbNjRpje8ebhpT@eis>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
 <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net>

On 25/01/06 05:19PM, Daniel Borkmann wrote:
> On 1/6/25 3:53 PM, Charalampos Stylianopoulos wrote:
> > This patch series provides an easy way for userspace applications to
> > query the number of entries currently present in a map.
> > 
> > Currently, the number of entries in a map is accessible only from kernel space
> > and eBPF programs. A userspace program that wants to track map utilization has to
> > create and attach an eBPF program solely for that purpose.
> > 
> > This series makes the number of entries in a map easily accessible, by extending the
> > main bpf syscall with a new command. The command supports only maps that already
> > track utilization, namely hash maps, LPM maps and queue/stack maps.
> 
> An earlier attempt to directly expose it to user space can be found here [0], which
> eventually led to [1] to only expose it via kfunc for BPF programs in order to avoid
> extending UAPI.

Yes, see the bpf_map_sum_elem_count() kfunc in the
kernel/bpf/map_iter.c file, and the links posted by Daniel.

> Perhaps instead add a small libbpf helper (e.g. bpf_map__current_entries to complement
> bpf_map__max_entries) which does all the work to extract that info via [1] underneath?
>
> Thanks,
> Daniel
> 
>   [0] https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/
>   [1] https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/
>       https://lore.kernel.org/bpf/20230719092952.41202-1-aspsk@isovalent.com/
> 
> > Charalampos Stylianopoulos (4):
> >    bpf: Add map_num_entries map op
> >    bpf: Add bpf command to get number of map entries
> >    libbpf: Add support for MAP_GET_NUM_ENTRIES command
> >    selftests/bpf: Add tests for bpf_map_get_num_entries
> > 
> >   include/linux/bpf.h                           |  3 ++
> >   include/linux/bpf_local_storage.h             |  1 +
> >   include/uapi/linux/bpf.h                      | 17 +++++++++
> >   kernel/bpf/devmap.c                           | 14 ++++++++
> >   kernel/bpf/hashtab.c                          | 10 ++++++
> >   kernel/bpf/lpm_trie.c                         |  8 +++++
> >   kernel/bpf/queue_stack_maps.c                 | 11 +++++-
> >   kernel/bpf/syscall.c                          | 32 +++++++++++++++++
> >   tools/include/uapi/linux/bpf.h                | 17 +++++++++
> >   tools/lib/bpf/bpf.c                           | 16 +++++++++
> >   tools/lib/bpf/bpf.h                           |  2 ++
> >   tools/lib/bpf/libbpf.map                      |  1 +
> >   .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
> >   tools/testing/selftests/bpf/test_maps.c       | 35 +++++++++++++++++++
> >   14 files changed, 171 insertions(+), 1 deletion(-)
> > 
> 

