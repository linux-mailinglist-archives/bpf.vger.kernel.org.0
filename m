Return-Path: <bpf+bounces-42877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD429AC206
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EF21C261D6
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 08:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79FC1607AC;
	Wed, 23 Oct 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCslu3JB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDFE158A04;
	Wed, 23 Oct 2024 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673105; cv=none; b=HPCBGj6cxdAblqfI55xzYNL0HqDHA1ht+7jLQAdg/hdLyVpRFKav8fkFKc26YwWhot1wBmhATGX7gvJmCBF8023vCZmv6dU2IACGToJqZ/CrFZUtI65ahzqwCPAIxQ+qQa66cM2nsvP7RQzIeMiNBO132IHT8c1yWIbTpXaWYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673105; c=relaxed/simple;
	bh=yB98udhSqQkRW3pgk3lehOuNxdNm7oEPiWhTz/nBZhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj5EVr04lJWJZ2BXwn35Psmrf9zxee98tBTlyJRcfvvxVnt/qlOmZFp2axL5kd+thy5+Tl+1sWAyE6wMvEuIdfPIAUkN4SOlOaW4q+KFDd4GxvIerTzYrrnsB8IYOXmA6un+k1sahEVVpHIvLPd9yiifkdxq9XFK59pGE5rsZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCslu3JB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso5050828a12.2;
        Wed, 23 Oct 2024 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729673103; x=1730277903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0J035g5WNycm3AHVCynKcQXgMo5pV2ms4qqq5QBwxuo=;
        b=gCslu3JB4S31p122blDQ8bAKanl4sxSoTddXpI5gaZGu2J0TO2dpJ0geSS8B8Awk7B
         pl1pxx9+TvbYAQ4AQJ+bn0O53TMsvRVj6opy8wr6QTtVi8pEQ4cJhYfKbtMxg+l72hE2
         zA2sc2399NnkqgpJbQ4FyykDTd3/jmTvG8NhBGAKUiXfS+yMEYnmiPgT9MAJHbvWEYBW
         neGyE7V9YijsXb+Lf1iFLPJw4ana8gtKyrbDBi4s0Svec64RuoQur3wz7OCmcxXGF7Ni
         Sik8osWUQ8HWw2fTZuvNBvK/qGNIHqJRG5K9w7pBVSRQeF54L6ldWgk/SHeFwlZmgm/w
         iy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729673103; x=1730277903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J035g5WNycm3AHVCynKcQXgMo5pV2ms4qqq5QBwxuo=;
        b=iwM+gJZ/BuV76ettPrzUznGV8t4JLepYofZ3sMTO4QEZUebUZVI79S/xrex3AqsQms
         1/IhuKBNSz/1jy5MQOLEHml34/xq4va8n7KE1fchVQM+gh8ff9mi43R0nOpPLtUqaxUy
         edqq6Mx3h8peC7lSexzLCyTcZv9Bk7jIkOsBz661SilrQk4EvVVu5MBn5JgF5hikFupU
         csv+364J5+rH0KrkWh5yEBkVSStcKfPCi6M/D2nFnQuRCXMi3eU9JXuPZa7Bb9Suk3ls
         59azH25Qs99z8XI/I6Sy3o0ZOOcbICt52PGp5ZwVj8883A5kDec4otLYzcqPnYkFfN7A
         CoKg==
X-Forwarded-Encrypted: i=1; AJvYcCWycYMFrsmSBeDJNu893ecE3rdZ4rVVoXljLHRxr00m2wp7O1Bk1eVV/F/lkHG+NB9iaek=@vger.kernel.org, AJvYcCXvdsit1iSqocJaSpZvVF+QrHz/EpNDIsiZz3R7EZlPNOJD7M5BBYFsulEKEQiYRsiRi+ZYV0TqNoMsBmP5@vger.kernel.org
X-Gm-Message-State: AOJu0YzXqVqxabyMg64UhqCDDCFbc8pexVS60ZShsMpukwaSJpJxtrkJ
	m9xf8zLP/mfuSkvFX+sIOkoM7LWBpGskv8V1CrTsw1WXmiN98oUy
X-Google-Smtp-Source: AGHT+IGSy9GyXqs+fwplsa9WfpXjqSFkymFMc0mxy7evawyYnCi9lOwOWllSPF9D48sJgFfyR/sbVQ==
X-Received: by 2002:a05:6a21:3a82:b0:1d9:16db:902e with SMTP id adf61e73a8af0-1d978aebccdmr1821366637.9.1729673103101;
        Wed, 23 Oct 2024 01:45:03 -0700 (PDT)
Received: from localhost.localdomain ([210.205.14.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76dfe0cecsm899108a91.52.2024.10.23.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:45:02 -0700 (PDT)
Date: Wed, 23 Oct 2024 17:44:58 +0900
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: Fix out-of-bounds write in trie_get_next_key()
Message-ID: <Zxi3iroUTKnU0ssx@localhost.localdomain>
References: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
 <CAADnVQ+Ow2E8qghEZw6x63VS4gM5rDtbM9R-ob00Rha2yBvfgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQ+Ow2E8qghEZw6x63VS4gM5rDtbM9R-ob00Rha2yBvfgA@mail.gmail.com>

On Tue, Oct 22, 2024 at 12:51:05PM -0700, Alexei Starovoitov wrote:
> On Mon, Oct 21, 2024 at 6:49 PM Byeonguk Jeong <jungbu2855@gmail.com> wrote:
> >
> > trie_get_next_key() allocates a node stack with size trie->max_prefixlen,
> > while it writes (trie->max_prefixlen + 1) nodes to the stack when it has
> > full paths from the root to leaves. For example, consider a trie with
> > max_prefixlen is 8, and the nodes with key 0x00/0, 0x00/1, 0x00/2, ...
> > 0x00/8 inserted. Subsequent calls to trie_get_next_key with _key with
> > .prefixlen = 8 make 9 nodes be written on the node stack with size 8.
> 
> Hmm. It sounds possible, but pls demonstrate it with a selftest.
> With the amount of fuzzing I'm surprised it was not discovered earlier.
> 
> pw-bot: cr

I sent this again because lkml did not understand previous one which is
8B encoded.

With a simple test below, the kernel crashes in a minute or you can
discover the bug on KFENCE-enabled kernels easily.

#!/bin/bash
bpftool map create /sys/fs/bpf/lpm type lpm_trie key 5 value 1 \
entries 16 flags 0x1name lpm

for i in {0..8}; do
	bpftool map update pinned /sys/fs/bpf/lpm \
	key hex 0$i 00 00 00 00 \
	value hex 00 any
done

while true; do
	bpftool map dump pinned /sys/fs/bpf/lpm
done

In my environment (6.12-rc4, with CONFIG_KFENCE), dmesg gave me this
message as expected.

[  463.141394] BUG: KFENCE: out-of-bounds write in trie_get_next_key+0x2f2/0x670

[  463.143422] Out-of-bounds write at 0x0000000095bc45ea (256B right of kfence-#156):
[  463.144438]  trie_get_next_key+0x2f2/0x670
[  463.145439]  map_get_next_key+0x261/0x410
[  463.146444]  __sys_bpf+0xad4/0x1170
[  463.147438]  __x64_sys_bpf+0x74/0xc0
[  463.148431]  do_syscall_64+0x79/0x150
[  463.149425]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  463.151436] kfence-#156: 0x00000000279749c1-0x0000000034dc4abb, size=256, cache=kmalloc-256

[  463.153414] allocated by task 2021 on cpu 2 at 463.140440s (0.012974s ago):
[  463.154413]  trie_get_next_key+0x252/0x670
[  463.155411]  map_get_next_key+0x261/0x410
[  463.156402]  __sys_bpf+0xad4/0x1170
[  463.157390]  __x64_sys_bpf+0x74/0xc0
[  463.158386]  do_syscall_64+0x79/0x150
[  463.159372]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

