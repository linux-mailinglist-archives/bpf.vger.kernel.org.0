Return-Path: <bpf+bounces-49060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7097A13CFA
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 15:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC83A9FDB
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C6522A7F6;
	Thu, 16 Jan 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="VMf0aBez"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48678F2B
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039332; cv=none; b=uCod1icuR0ltOpwT0livnZK8y7bR3NVIQB8WKpyql6g1HFg0o7MVImSoPWovjWIu7Kcj/ga8amdlRYBvtKsytjyFtFEbPCcIH3qlzEFQMFDMTTNuz/lnmyd4p2tH0iBqbflAa/n9s2xWT7kaRYazguY5JX0FFu3nGd2iQsoWEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039332; c=relaxed/simple;
	bh=ZY13NJcbexQno8YuPhoJEsqXDpdT0s6SQPG08TKFotc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6snwKdkRHLUvox7601exo14Fi71hmabUmwTrCC9PZBuZ//3Wb+ob0491IViMHozt7Ozhs4SscoXqrvpkE4lFe7wFEhSeFJqGmG3axL4R3Jhf3fGeRaLErkT8MiwH6J8DCyJdK+Rc/bDOCcX397AIgjZtrMm+KoppXI2Idvgc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=VMf0aBez; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43635796b48so6841675e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 06:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1737039329; x=1737644129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9Gg0njoUKqIEbUSNILV+b3Jk22A82UdQJji3hpLUs8=;
        b=VMf0aBezoYTX1ghMDuScLM2mH4tGrWEJFPsgGrOAEbSOnMNpcIvNiYo+gpUtu5Ynia
         Hb/g67Ffalm5Ud4VMaEHUL5cr0s2ewqMgs44/Ai9+7uU9hWGzTd3LD95qMkxNbu4g2pI
         li3miFPRZjSDKhXok72BO5J6KqQ1vnsDk9wEFG9yev5mKJDUl62oLNkv47zBEORvBkj7
         xgRFp3cZulAgL2t5p5PLyHhmm9Ugab6U8sge4AULX+jpGOQ9w3/x1dDsaNmFAfrl+OnR
         voqmTZThkBFmB9RGv5fb6dxI2yqF+O7AazOHVoKGKNyHufMKuUEUIEbtu4dUOYlTQWWY
         8SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737039329; x=1737644129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9Gg0njoUKqIEbUSNILV+b3Jk22A82UdQJji3hpLUs8=;
        b=rYTCkLo5tEca6KqigGzr0llaltuNoUwdZUNzpWn9AkqJiGbln4jlS2WsJ/UeoxjS5H
         RKaCd2KmKRiYWoaUidRTj5Y30dzinaGF3+bel9JSqVOY6igTnnMGr/AU0QN0DPx+Palr
         XDYEQoqRggnjt6zZJ4HEbSJvKYzhFL34EdU/YPG1crbnKmRwJgSem8u6IKodCJykZhTJ
         Zbf6k8XqRsWxLPHrP1ZRbjh5JbNhA9UcxxI5ffKHiq9PIhO/ZdCEuifQny9rkdMzmx4q
         OW5Hs+iXS55jg3p/bhP/o8ajVWgcdpv9dxPpF5iAmjt0AVg2wQX5wcEXXvX8Zr8LJBAT
         R9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1k6Y5Yxy9gL5OygCUmFfFModjqHxgeHQrOj4JNiyD5UVHegXv012/XzixOotqCKh22yE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6095KDIJz/g7Gg3yuGRR2VMJXm5r0hLRcjRXLCZqKost2iqpK
	2j5zPIlmJbNtLkW0Te7OoEOAGcb2yXnL9dBqsVpYRA+c7eWd2ReWDM03QLbKcQs=
X-Gm-Gg: ASbGncswnYPtX6gf3jMY+0iLz6/moBcwZLs8yhSjVcgbQufwEcYy8OQyvhI9EuR8fFx
	B2tUtW/bkxgwEUjAN5n7rSO3bmEgozpWlL1W28uvJ1Yuau36WFJfOnGmkDcBCi55EqZDVS/+pFI
	72P3/SpHGq50VCYr9vlt85RGGMOLI1oKpiV29V6UP+U2UnZsJL14BIMVG5G1d6e/T0p6AyIUtW4
	DweejsmEXv4YMmAigAYho1tdIiBgfUC1cX3qBiMXcJzpg==
X-Google-Smtp-Source: AGHT+IH+2idMD2XNLNkAbVwahZDtrTWO1Tp1+wA9hHxQoEnhWgX5VB9Cd9IJH++HoiCdzNE1bn09VQ==
X-Received: by 2002:a05:600c:4f55:b0:434:ea1a:e30c with SMTP id 5b1f17b1804b1-437c6b468a7mr67857425e9.13.1737039328806;
        Thu, 16 Jan 2025 06:55:28 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275622sm57376f8f.69.2025.01.16.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:55:28 -0800 (PST)
Date: Thu, 16 Jan 2025 14:59:32 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Nick Zavaritsky <mejedi@gmail.com>
Cc: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>, aspsk2@gmail.com
Subject: Re: [PATCH bpf-next 0/4] expose number of map entries to userspace
Message-ID: <Z4ke1A1agEko41v8@eis>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
 <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net>
 <Z3zcTB+SjPK5QOt9@eis>
 <CAAvdH+yNG=GefEd5CcP_52gPzzZexWMMxFAxnM3isX04iErMfQ@mail.gmail.com>
 <CAAvdH+wHjWEvO3e0_=o4imJZq1082pzp-qszbQvj_Ev50eQCrw@mail.gmail.com>
 <Z4AJY8orP8JMzvhW@eis>
 <68891842-975E-48B0-AED5-875F3ABC5F49@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68891842-975E-48B0-AED5-875F3ABC5F49@gmail.com>

On 25/01/14 12:38PM, Nick Zavaritsky wrote:
> 
> > On 9. Jan 2025, at 18:37, Anton Protopopov <aspsk@isovalent.com> wrote:
> > 
> > On 25/01/07 12:10PM, Charalampos Stylianopoulos wrote:
> >> (sorry for double posting, this time in plain text)
> >> Thanks a lot for the feedback!
> >> 
> >> So, to double check, the suggestion is to only extend the libbpf API
> >> with a new helper that does pretty much what get_cur_elements() does
> >> in tools/testing/selftests/bpf/map_tests/map_percpu_stats.c ?
> > 
> > What is your use case for getting the number of elements in a
> > particular map? Will it work for you to just use a variant of
> > get_cur_elements() from selftests vs. adding new API to libbpf?
> 
> (On behalf of Charalampos Stylianopoulos) we would like to get the
> number of elements in some maps for monitoring purposes. The end goal is
> to get someone paged when a fixed-capacity map is about to start
> rejecting inserts.
> 
> We aim to operate a large number of apps in containers (custom packet
> processing services, telekom). We find it most convenient for an app
> itself to expose metrics concerning the maps it has created.
> 
> We currently use a map iterator and a bunch of bpf_probe_read_kernel. We
> foresee the number of maps in our systems getting significantly higher
> in the near future. Therefore enumerating every map in the system to get
> a number of elements in a particular map doesn't look sustainable.
> 
> How do you feel about introducing bpf_map_sum_elem_count_by_fd kfunc,
> available in syscall programs?

This should work already, something like

    __s64 bpf_map_sum_elem_count(const struct bpf_map *map) __ksym;
    __s64 ret_user;

    struct {
            __uint(type, BPF_MAP_TYPE_HASH);
            __type(key, int);
            __type(value, int);
            __uint(max_entries, 4);
    } your_map SEC(".maps");

    SEC("syscall")
    int sum(void *ctx)
    {
            struct bpf_map *map = (struct bpf_map *)&your_map;

            ret_user = bpf_map_sum_elem_count(map);

            return 0;
    }

    char _license[] SEC("license") = "GPL";

Is this sufficient for your use case?

> > 
> > [Also, please try not to top-post, see https://www.idallen.com/topposting.html]
> > 
> >>> On Tue, 7 Jan 2025 at 08:44, Anton Protopopov <aspsk@isovalent.com> wrote:
> >>>> 
> >>>> On 25/01/06 05:19PM, Daniel Borkmann wrote:
> >>>>> On 1/6/25 3:53 PM, Charalampos Stylianopoulos wrote:
> >>>>>> This patch series provides an easy way for userspace applications to
> >>>>>> query the number of entries currently present in a map.
> >>>>>> 
> >>>>>> Currently, the number of entries in a map is accessible only from kernel space
> >>>>>> and eBPF programs. A userspace program that wants to track map utilization has to
> >>>>>> create and attach an eBPF program solely for that purpose.
> >>>>>> 
> >>>>>> This series makes the number of entries in a map easily accessible, by extending the
> >>>>>> main bpf syscall with a new command. The command supports only maps that already
> >>>>>> track utilization, namely hash maps, LPM maps and queue/stack maps.
> >>>>> 
> >>>>> An earlier attempt to directly expose it to user space can be found here [0], which
> >>>>> eventually led to [1] to only expose it via kfunc for BPF programs in order to avoid
> >>>>> extending UAPI.
> >>>>> 
> >>>>> Perhaps instead add a small libbpf helper (e.g. bpf_map__current_entries to complement
> >>>>> bpf_map__max_entries) which does all the work to extract that info via [1] underneath?
> >>>> 
> >>>> One small thingy here is that bpf_map_sum_elem_count() is only
> >>>> available from the map iterator. Which means that to get the
> >>>> bpf_map_sum_elem_count() for one map only, one have to iterate
> >>>> through the whole set of maps (and filter out all but one).
> >>>> 
> >>>> I wanted to follow up my series by either adding the result of
> >>>> calling bpf_map_sum_elem_count() to map_info as u32 or to add
> >>>> possibility to provide a map_fd/map_id when creating an iterator
> >>>> (so that it is only called for one map). But so far I haven't
> >>>> a real use case for getting the number of elements for one map only.
> >>>> 
> >>>>> Thanks,
> >>>>> Daniel
> >>>>> 
> >>>>>  [0] https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/
> >>>>>  [1] https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/
> >>>>>      https://lore.kernel.org/bpf/20230719092952.41202-1-aspsk@isovalent.com/
> >>>>> 
> >>>>>> Charalampos Stylianopoulos (4):
> >>>>>>   bpf: Add map_num_entries map op
> >>>>>>   bpf: Add bpf command to get number of map entries
> >>>>>>   libbpf: Add support for MAP_GET_NUM_ENTRIES command
> >>>>>>   selftests/bpf: Add tests for bpf_map_get_num_entries
> >>>>>> 
> >>>>>>  include/linux/bpf.h                           |  3 ++
> >>>>>>  include/linux/bpf_local_storage.h             |  1 +
> >>>>>>  include/uapi/linux/bpf.h                      | 17 +++++++++
> >>>>>>  kernel/bpf/devmap.c                           | 14 ++++++++
> >>>>>>  kernel/bpf/hashtab.c                          | 10 ++++++
> >>>>>>  kernel/bpf/lpm_trie.c                         |  8 +++++
> >>>>>>  kernel/bpf/queue_stack_maps.c                 | 11 +++++-
> >>>>>>  kernel/bpf/syscall.c                          | 32 +++++++++++++++++
> >>>>>>  tools/include/uapi/linux/bpf.h                | 17 +++++++++
> >>>>>>  tools/lib/bpf/bpf.c                           | 16 +++++++++
> >>>>>>  tools/lib/bpf/bpf.h                           |  2 ++
> >>>>>>  tools/lib/bpf/libbpf.map                      |  1 +
> >>>>>>  .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
> >>>>>>  tools/testing/selftests/bpf/test_maps.c       | 35 +++++++++++++++++++
> >>>>>>  14 files changed, 171 insertions(+), 1 deletion(-)
> >>>>>> 
> >>>>> 
> 

