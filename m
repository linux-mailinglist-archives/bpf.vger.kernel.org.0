Return-Path: <bpf+bounces-48421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2438A07ECF
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A3B163EF3
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069118F2CF;
	Thu,  9 Jan 2025 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="BXvSLJyq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271C188722
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444024; cv=none; b=tPCaeELjhdyI3dA5269O+HzQfQNPbWtJ04XQEy78attG+VEf6h8ql/6qCwUSN6wwsUoSywoVkR0yLr2I+q2A5fKgXuOJP3Foq46MPIv9z3SHb087OB6/k2uOmv3SmAYkmbKOlV3dtMXK7vnrae9cED5BE9DT5mc1pFJbYd4PQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444024; c=relaxed/simple;
	bh=JQPgpsDD7Dkvg4Spn1JmV147T9ZgG3xss1R8SZABTeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1VgMD/U1bC+n4ri7yfP3QSVFdPtYHWGz217UEBFB3cDKdPviyNyaKWPm4NIdLMBfuIly0XAZ5XC9nnNFZ2KMqVjesMecuaFwLyxkH+RuqMmIukoWc6suDpBmbn+NaIYPOk0iI7Bp8Fo2/doSpLNlqIaVmINSpnjM1bG+YHG48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=BXvSLJyq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so631521f8f.0
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 09:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1736444021; x=1737048821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzRIMDH9SyD+MebM9QFVaVUDlX7utdla0+k4ysld59w=;
        b=BXvSLJyqa/kqzaOR5zGlTJ7SPQCCIDfqGge17H4EdQELDKXohV7M6Z0RuXQCxuaeEj
         rFKTy1cc+0ukAXEa5bcijiHPKb2V9qvs6qkFlSMJTKDqSJQdWX3MBSymo6/yONDGzLIN
         etlI2qUMBHxozQ2N6GJZgvTb3+CB9e4dNElOAgLJo3qyITV86X877pNBUB+HsgAEKk5/
         d+FrEohx2ImTU5ISFUkyGS222hV4rpR8vJ56J9j70pbZ0tVR1suWAaJ1XipSLdzKBlP2
         qmupmeZeZ1hvGu8nIjW/+2pC1G5jt+m6C7ctXR6rqK0k/e1WbB+qu7/4zhWY2FKskJ6f
         y4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736444021; x=1737048821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzRIMDH9SyD+MebM9QFVaVUDlX7utdla0+k4ysld59w=;
        b=JUoYPGcNCjGhdkebTzpIxowE3YRGGgQQ4oZ1XN02T4c0uxOpULm9Ub+IgtfkNDCgD8
         ccr3e2N2TNGHo00IA2lafMo0dR46l0kDEhyOvHaVQ74jc/jLwIMLzO5D0YCL0cnIiDUs
         N+n7F3z7f5Gvix/uvZBzzRd4jHKPsTGW/bsLIyyY1iPdOZombaAzw33LjWvzF6O6md5l
         ckr3KXqRARC73mqYNsgjVaFehy2DoLF/8EmeHbykt40+Xhu2BPFU3oY9TizUJLQSCe6v
         964YxRBmpqAd7mQlUAdPJucj3MOSZLjFIBwQ2LHVH1L1f2FkgQ/Q35iMimn/Ju4zeDJ7
         kilw==
X-Forwarded-Encrypted: i=1; AJvYcCWju5pPu1wJjvkA0tfX5kkr1VQnGTbVDu5zJ/B7YCik0ZmN7nG4IgPkx1HiUyzOoco57L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD89sZeTjso30PVhTDJT5WBlveR04uOgW28SWSy2CUPrzr7tLh
	iy9xQmXu52rMaFtiHL5wsR7ZOKXKv84rWqeWt96rpyxLJ6Q8QpUxW7YtJhHdc8U=
X-Gm-Gg: ASbGnctxzfysHlMkWzcLSDpxRIsM+hWCk4iyvidDdntFj6HYNAuvEKv9EmhiYCHdyfx
	SGWu/sR8hSe9ncBBdbQ+rhSbv6lxdae2AW5/tLvbZR1gQ6YgDQmLxC63wtAG26iI1TwGCdnwNd8
	sVj6eNRC6TKYEw2fbdMRiX2VBMvD+cdZinR+ux7kFDVSL1YoMmJ+aOKNVBBfQiu4cB0v+DuDEyV
	lgeytjK9lXap940Q2svx5VhBJOqSBW8qEwopiDEIKLX6A==
X-Google-Smtp-Source: AGHT+IGa20U0TzBG6VWruYSV6IJ++iyPDV4cLyWId3dDM1z3+foviNtZ0d/HOsrKp/liqdy4kkjYag==
X-Received: by 2002:a05:6000:1ac6:b0:386:36e7:f44f with SMTP id ffacd0b85a97d-38a872db271mr6176389f8f.18.1736444021148;
        Thu, 09 Jan 2025 09:33:41 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c990sm2377350f8f.56.2025.01.09.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:33:40 -0800 (PST)
Date: Thu, 9 Jan 2025 17:37:39 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Nick Zavaritsky <mejedi@gmail.com>, aspsk2@gmail.com
Subject: Re: [PATCH bpf-next 0/4] expose number of map entries to userspace
Message-ID: <Z4AJY8orP8JMzvhW@eis>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
 <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net>
 <Z3zcTB+SjPK5QOt9@eis>
 <CAAvdH+yNG=GefEd5CcP_52gPzzZexWMMxFAxnM3isX04iErMfQ@mail.gmail.com>
 <CAAvdH+wHjWEvO3e0_=o4imJZq1082pzp-qszbQvj_Ev50eQCrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAvdH+wHjWEvO3e0_=o4imJZq1082pzp-qszbQvj_Ev50eQCrw@mail.gmail.com>

On 25/01/07 12:10PM, Charalampos Stylianopoulos wrote:
> (sorry for double posting, this time in plain text)
> Thanks a lot for the feedback!
> 
> So, to double check, the suggestion is to only extend the libbpf API
> with a new helper that does pretty much what get_cur_elements() does
> in tools/testing/selftests/bpf/map_tests/map_percpu_stats.c ?

What is your use case for getting the number of elements in a
particular map? Will it work for you to just use a variant of
get_cur_elements() from selftests vs. adding new API to libbpf?

[Also, please try not to top-post, see https://www.idallen.com/topposting.html]

> > On Tue, 7 Jan 2025 at 08:44, Anton Protopopov <aspsk@isovalent.com> wrote:
> >>
> >> On 25/01/06 05:19PM, Daniel Borkmann wrote:
> >> > On 1/6/25 3:53 PM, Charalampos Stylianopoulos wrote:
> >> > > This patch series provides an easy way for userspace applications to
> >> > > query the number of entries currently present in a map.
> >> > >
> >> > > Currently, the number of entries in a map is accessible only from kernel space
> >> > > and eBPF programs. A userspace program that wants to track map utilization has to
> >> > > create and attach an eBPF program solely for that purpose.
> >> > >
> >> > > This series makes the number of entries in a map easily accessible, by extending the
> >> > > main bpf syscall with a new command. The command supports only maps that already
> >> > > track utilization, namely hash maps, LPM maps and queue/stack maps.
> >> >
> >> > An earlier attempt to directly expose it to user space can be found here [0], which
> >> > eventually led to [1] to only expose it via kfunc for BPF programs in order to avoid
> >> > extending UAPI.
> >> >
> >> > Perhaps instead add a small libbpf helper (e.g. bpf_map__current_entries to complement
> >> > bpf_map__max_entries) which does all the work to extract that info via [1] underneath?
> >>
> >> One small thingy here is that bpf_map_sum_elem_count() is only
> >> available from the map iterator. Which means that to get the
> >> bpf_map_sum_elem_count() for one map only, one have to iterate
> >> through the whole set of maps (and filter out all but one).
> >>
> >> I wanted to follow up my series by either adding the result of
> >> calling bpf_map_sum_elem_count() to map_info as u32 or to add
> >> possibility to provide a map_fd/map_id when creating an iterator
> >> (so that it is only called for one map). But so far I haven't
> >> a real use case for getting the number of elements for one map only.
> >>
> >> > Thanks,
> >> > Daniel
> >> >
> >> >   [0] https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/
> >> >   [1] https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/
> >> >       https://lore.kernel.org/bpf/20230719092952.41202-1-aspsk@isovalent.com/
> >> >
> >> > > Charalampos Stylianopoulos (4):
> >> > >    bpf: Add map_num_entries map op
> >> > >    bpf: Add bpf command to get number of map entries
> >> > >    libbpf: Add support for MAP_GET_NUM_ENTRIES command
> >> > >    selftests/bpf: Add tests for bpf_map_get_num_entries
> >> > >
> >> > >   include/linux/bpf.h                           |  3 ++
> >> > >   include/linux/bpf_local_storage.h             |  1 +
> >> > >   include/uapi/linux/bpf.h                      | 17 +++++++++
> >> > >   kernel/bpf/devmap.c                           | 14 ++++++++
> >> > >   kernel/bpf/hashtab.c                          | 10 ++++++
> >> > >   kernel/bpf/lpm_trie.c                         |  8 +++++
> >> > >   kernel/bpf/queue_stack_maps.c                 | 11 +++++-
> >> > >   kernel/bpf/syscall.c                          | 32 +++++++++++++++++
> >> > >   tools/include/uapi/linux/bpf.h                | 17 +++++++++
> >> > >   tools/lib/bpf/bpf.c                           | 16 +++++++++
> >> > >   tools/lib/bpf/bpf.h                           |  2 ++
> >> > >   tools/lib/bpf/libbpf.map                      |  1 +
> >> > >   .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
> >> > >   tools/testing/selftests/bpf/test_maps.c       | 35 +++++++++++++++++++
> >> > >   14 files changed, 171 insertions(+), 1 deletion(-)
> >> > >
> >> >

