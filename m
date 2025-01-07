Return-Path: <bpf+bounces-48067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD9A03D52
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3579E188181B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75A61DF756;
	Tue,  7 Jan 2025 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoInHkcR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4E33993
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248245; cv=none; b=tzt1zFOy2KixShjalwOIFLpYlasj4HA0Bz+NP1cqfmUEStWlhCLw2HuSRvbNYxnyPbgSOPiULYJhAix0GRANk5ImKyN9LOoQVQFO8synabaxc3U/0Fk93K03AdLRD36oIorJpW0bgdW5eVCe653KGksvC2tq6Ot7ifV4bEJ4UdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248245; c=relaxed/simple;
	bh=E+9StflzKPqBMknpXlzs1oW6rrIj9vZmSxeFC14GxSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdQdVoHzeuMNYa3kaAv5si/dDdROIx9fSPtx4gR9jVcLBbRameMCkr5jjQEFyY/UHQAkGIhcFRpAN0koOfbUmfa3pq5CKOpk3LaunOp6zYWjNTb/918XC9UXmMkHBid+mGLYG77X5YrnOS7xcCQ8o8Ly96jY5QoUeEqwUeB+2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoInHkcR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so16030476e87.3
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 03:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736248240; x=1736853040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WZGUI3dB84Vl01DEaY9V1Ugv3huIhg/nxLbxfkp5CH8=;
        b=LoInHkcRxc+LTJGcZZXuNcUvTAlAW1QnTahz7SNjMgLwzNLM2H/6R/IINBKqOBTG7Y
         dOnPUPe0n8MGJs517YrBC5QUtzFfiu8POQg9NwSNS+upRA8EJCJUHyvLvsCYd4hVrZKy
         OY6QIfw5uiw2waVyst7eemZBA/e7ZlQfNJ0vFbnRziWI+PRK8G0QJXOCmO13bkLkxIy4
         5OAQHyk0q5ydzR5dZ0xLAG8e6xLOaS66zQvS/cuK9LXSZKlgC+mnjzKqGED2ttYHGvtz
         4LYIP4zAny8PuKXJpXX6VIYcv6pPre7a3o1b1yx1qbYDR+Z+U8/7bgB6DPBEz9o+1TZB
         MrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248240; x=1736853040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZGUI3dB84Vl01DEaY9V1Ugv3huIhg/nxLbxfkp5CH8=;
        b=lt9wXCKGFZ9M2zRWeGM4+xVyuRhQLO0HBQxqKAOb0CV9pqUISETX4qg9Rj0lXU3DaU
         cjrGAVxNxXO1yY4FlvwwAmJ/RxjmUztQMQB5IB+h66vmVec575EwCdYdCISHIF4PwqJl
         6HFOztogwlPs5OEc8mI8YuEEHdTmCcxHWXQ2Ey/azqNe4mFR/mKhjwwWtPHJvVGkU2Ru
         tIVsaybm5UpN5QLKMnpK1tYYOT7arL0GAlcl4B4U8wOlO2bv+kVybGjVjyu8fFBPDLWy
         CoGlVW/BmazthtlIom+8tJvCBqjiLAKoYtduZg5P4xA569vXQ8uTU18YLx/YcAqzQ0ow
         1B8A==
X-Forwarded-Encrypted: i=1; AJvYcCUiERf8Syjqa1NVzot+MlnMxOvJrzQ+qSwtNWdCNNJg2akbNLWY2q5pw/6TKGF++/XQNMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ePhURLRUWAKXe8tKjlUJAXLLIXQZ1UY1p9+ywaPoD0hrMQ59
	NAuZVFKdRGth7x3qmF4q2pPmMrntkylohlv3ojfwI0JSSOynE2qbfZ5ZAs0nhFEAevxs+lLXs8V
	KZhcfK03C5Ctfe9zqJBJ7bnk91z6yAuEnjpy67lgTqHw=
X-Gm-Gg: ASbGncu1OdyVZxM2jFH61X4CTZwmoDz/wlornBHZomCahTGADxHhEkn1GllTTsJuhWI
	8qzlO9T03P8HCHFT3fqHBpD5ouCMicUUkqUvlzQZVLZJZqhhz7w+bu5Vg9ls9K04q+DPbRAw=
X-Google-Smtp-Source: AGHT+IFN6Yy45eT73eJ8VNuw3xrBKYmwuaAm+UjNow3yKJpMMxgAZdRnKMpyuzaFMxLmmLeIOj+J9vkrlBqjzqpMgho=
X-Received: by 2002:a05:6512:2342:b0:540:3566:5760 with SMTP id
 2adb3069b0e04-54229562ab7mr18413668e87.35.1736248240028; Tue, 07 Jan 2025
 03:10:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
 <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net> <Z3zcTB+SjPK5QOt9@eis> <CAAvdH+yNG=GefEd5CcP_52gPzzZexWMMxFAxnM3isX04iErMfQ@mail.gmail.com>
In-Reply-To: <CAAvdH+yNG=GefEd5CcP_52gPzzZexWMMxFAxnM3isX04iErMfQ@mail.gmail.com>
From: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
Date: Tue, 7 Jan 2025 12:10:28 +0100
X-Gm-Features: AbW1kvYV9M5tQqSB81lBWlmevNnGUlcxEOTRLCEK3vB4GJJFEMci2eqnSLhJVb4
Message-ID: <CAAvdH+wHjWEvO3e0_=o4imJZq1082pzp-qszbQvj_Ev50eQCrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] expose number of map entries to userspace
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, aspsk2@gmail.com
Content-Type: text/plain; charset="UTF-8"

(sorry for double posting, this time in plain text)
Thanks a lot for the feedback!

So, to double check, the suggestion is to only extend the libbpf API
with a new helper that does pretty much what get_cur_elements() does
in tools/testing/selftests/bpf/map_tests/map_percpu_stats.c ?

> On Tue, 7 Jan 2025 at 08:44, Anton Protopopov <aspsk@isovalent.com> wrote:
>>
>> On 25/01/06 05:19PM, Daniel Borkmann wrote:
>> > On 1/6/25 3:53 PM, Charalampos Stylianopoulos wrote:
>> > > This patch series provides an easy way for userspace applications to
>> > > query the number of entries currently present in a map.
>> > >
>> > > Currently, the number of entries in a map is accessible only from kernel space
>> > > and eBPF programs. A userspace program that wants to track map utilization has to
>> > > create and attach an eBPF program solely for that purpose.
>> > >
>> > > This series makes the number of entries in a map easily accessible, by extending the
>> > > main bpf syscall with a new command. The command supports only maps that already
>> > > track utilization, namely hash maps, LPM maps and queue/stack maps.
>> >
>> > An earlier attempt to directly expose it to user space can be found here [0], which
>> > eventually led to [1] to only expose it via kfunc for BPF programs in order to avoid
>> > extending UAPI.
>> >
>> > Perhaps instead add a small libbpf helper (e.g. bpf_map__current_entries to complement
>> > bpf_map__max_entries) which does all the work to extract that info via [1] underneath?
>>
>> One small thingy here is that bpf_map_sum_elem_count() is only
>> available from the map iterator. Which means that to get the
>> bpf_map_sum_elem_count() for one map only, one have to iterate
>> through the whole set of maps (and filter out all but one).
>>
>> I wanted to follow up my series by either adding the result of
>> calling bpf_map_sum_elem_count() to map_info as u32 or to add
>> possibility to provide a map_fd/map_id when creating an iterator
>> (so that it is only called for one map). But so far I haven't
>> a real use case for getting the number of elements for one map only.
>>
>> > Thanks,
>> > Daniel
>> >
>> >   [0] https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/
>> >   [1] https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/
>> >       https://lore.kernel.org/bpf/20230719092952.41202-1-aspsk@isovalent.com/
>> >
>> > > Charalampos Stylianopoulos (4):
>> > >    bpf: Add map_num_entries map op
>> > >    bpf: Add bpf command to get number of map entries
>> > >    libbpf: Add support for MAP_GET_NUM_ENTRIES command
>> > >    selftests/bpf: Add tests for bpf_map_get_num_entries
>> > >
>> > >   include/linux/bpf.h                           |  3 ++
>> > >   include/linux/bpf_local_storage.h             |  1 +
>> > >   include/uapi/linux/bpf.h                      | 17 +++++++++
>> > >   kernel/bpf/devmap.c                           | 14 ++++++++
>> > >   kernel/bpf/hashtab.c                          | 10 ++++++
>> > >   kernel/bpf/lpm_trie.c                         |  8 +++++
>> > >   kernel/bpf/queue_stack_maps.c                 | 11 +++++-
>> > >   kernel/bpf/syscall.c                          | 32 +++++++++++++++++
>> > >   tools/include/uapi/linux/bpf.h                | 17 +++++++++
>> > >   tools/lib/bpf/bpf.c                           | 16 +++++++++
>> > >   tools/lib/bpf/bpf.h                           |  2 ++
>> > >   tools/lib/bpf/libbpf.map                      |  1 +
>> > >   .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
>> > >   tools/testing/selftests/bpf/test_maps.c       | 35 +++++++++++++++++++
>> > >   14 files changed, 171 insertions(+), 1 deletion(-)
>> > >
>> >

