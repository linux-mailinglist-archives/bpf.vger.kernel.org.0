Return-Path: <bpf+bounces-57305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9500FAA7E05
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 04:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B407B1849
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 02:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD0C1519BC;
	Sat,  3 May 2025 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPvSSAKw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F707EAC7;
	Sat,  3 May 2025 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746238260; cv=none; b=IkLfKzqQcbuACdOrEi0+3RGe7dVWelPPfGk3xFtJdOem8umPivt2nyjsvsePV81bgEsp81nDBSAA4/7jx68yncQBfrZrzhv8rsYnNOdafd5D7MYbkHnj8U9Bi5iFTpW/3zynauaT2jpgXQg6URGsr7sHu9wRXIhvLSAhY8yfafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746238260; c=relaxed/simple;
	bh=Py2mgNDSFu2k5qj12RIg3AtazNtUFBYxoy+ho7+cLzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1/IxvQPBEIHpA8CgCYyiMNUSGgBdBgGMGp50nNd0TWIgkf3UivcP1zpZ2jXDZPQqgFv4VgM1mJBRT76Rr330sFsWJIeQqlLcqlKrc/5/XoKOZU2qGA2XiDEQDZpBBLq+VEV9oMjgVgelJdFu/uthhBgDnaxHWpoDffTfG1Zroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPvSSAKw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ac56756f6so2643413f8f.2;
        Fri, 02 May 2025 19:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746238256; x=1746843056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvYFCDQc5LUBzpE6Y+n9WDTDTHU/dT0TY7EgYqCmvFU=;
        b=FPvSSAKw8FZUgKqhp61VsgwT+gBX7BGK26gSvki6i0eARvaeYQTDJOJ8FT0xHBBMcK
         iOb0HEzf+AxNWFMyXpSC67ktFJodQlfip4WrxuT8vn0t88jmcqL+6CLARvUe17/zrWUw
         qmFdX6gxgtaAYlgYksFu8YI500TQH08LJ9OkrsnMH2PrfAyus/YhKpMfouTFQ+jGSS/1
         5qZKkEuG/b7e7ooM2u55qSKg9TSss5QzgFRGY3ZFqHsMjbyQXXK0LLgkrvc2F0Q0vaHX
         e7IpnwjXP5kW4USeDyGvcuf3ZDYJBN4Olw7kfQHTpf2N3XSXjJtKkubVRyPjUbt8nBtX
         1KRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746238256; x=1746843056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvYFCDQc5LUBzpE6Y+n9WDTDTHU/dT0TY7EgYqCmvFU=;
        b=FcMNttSJJfdxl5jYnbJgmioe5GXX+/CcLGq6w1dVlbuQ0WSPE/VTFS1y4P4iRO/v9A
         ZHI8RZ6S8310aq4CBNsXABdgEaBmen4a7l/WjcI21yqU1z8M1+pU0qRGmKM70+i7Fw8K
         U46s7OO53b3zX8XvwZVsysbsolFkvxsUfwKNTgtJtnP3Hw71rz7qznka0P7AgIDqZH7o
         yAEubzdYroIIRtyfcA/UYLhsS1iuVlCnEizvbi08PODpKmJ0upn66zUZ6ZwI7/TKDoMX
         /Pc+MOwVx1b5fSKVzRbDzXzm7oD56i2T/kk5l6UJoQk4pJ/h7QL/BFxJ2y6G3g38UZrJ
         /eqA==
X-Forwarded-Encrypted: i=1; AJvYcCUzNSQqcqW/KU2kLD+oDF4rwdK/PAnY1I7IIl6XXe7jqLs9wuXoZE+gq7RPkAFq9wsGjHM=@vger.kernel.org, AJvYcCWu8EW0WTVuHbHGhLucOM1/Mp1+uX1sGf4wqVkbOcNUMBesLrpUb/GigH8unQlkIKiFoWL/5a/+B4nCQk1b@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqhBwlwhBNFso4ruTEoba9w6y11nelb0NUyyHQ8qz78sFBVpn
	Fm1oQFo4O7SbNQ4y7dnf+J/iYZSYuOU+lU9iaQn/DOghfnSUzz8BIc3UuGbIGhTQNAsBU+2Cm4m
	sQluZapSNWMaU2HD0QappLhcnoF/GMGIO
X-Gm-Gg: ASbGnctTtBXnW+eLbcZw1EKq8bopwfRurS1ubdIF8Z28ZTo+IN1oK7QujaW4MOlzRV6
	ZS0olJN5DlEy00wvvXP9ZXK65Ew864Pu8BuOUA297t1Slet7SoNLeasU1G/etrI0MhPP+o3hWQz
	zfi7RLjDVTN9yumwLi3MSKlc9hCxxOpMzDPqq33NAkdPj/f47dYw==
X-Google-Smtp-Source: AGHT+IFcMmsyfrjd/SYqCrn0P/xZcw+w2Pud1FcMFxa6/C/lk72GBlbDIQeZVsIwYKnptb8nuMqvKu4OrZ47CX0EEcw=
X-Received: by 2002:a05:6000:1889:b0:391:3f4f:a172 with SMTP id
 ffacd0b85a97d-3a099af1b1fmr3678846f8f.49.1746238256492; Fri, 02 May 2025
 19:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5l4btekupkqatpxkfaolqhc5kw5wra3xvd7dosalem6zuo5vp5@vwfd7idoqdzv>
In-Reply-To: <5l4btekupkqatpxkfaolqhc5kw5wra3xvd7dosalem6zuo5vp5@vwfd7idoqdzv>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 May 2025 19:10:45 -0700
X-Gm-Features: ATxdqUG8odIImfLH6jTWh2EwSNFNSqDOTjr6FEOjlqyInXW9JoDWc47vEA0d7VE
Message-ID: <CAADnVQKgEViz3gQ2QJzCmnm-ou-r-=_i3yLaW5JoKK9okVcGzA@mail.gmail.com>
Subject: Re: [RFC] BPF fault/jitter-injection framework
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 9:10=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Greetings,
>
> I've been thinking what if we had a BPF jitter/fault injection framework
> for more fine-grained and configurable kernel testing.  Current fault
> injection doesn't support function arguments analysis, with BPF we
> can have something like
>
>     // of course bpf_schedule_timeout() doesn't exist yet
>     call bpf_schedule_timeout(120) in blk_execute_rq(rq) if
>     rq->q->disk->major =3D=3D 8 && rq->q->disk->first_minor =3D=3D 0
>
> So that would introduce blk request execution timeouts/jitters for a
> particular gendisk only.  And so on.
>
> Has this been discussed before?  Does this approach even make sense
> or is there a better (another) way to do this?

I think it makes sense.
That was the motivation for us to do:

$ git grep ALLOW_ERROR_INJECTION fs/
fs/btrfs/ctree.c:ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
fs/btrfs/ctree.c:ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
fs/btrfs/disk-io.c:ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
fs/btrfs/free-space-cache.c:ALLOW_ERROR_INJECTION(io_ctl_init, ERRNO);
fs/btrfs/relocation.c:ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TR=
UE);
fs/btrfs/tree-checker.c:ALLOW_ERROR_INJECTION(btrfs_check_leaf, ERRNO);
fs/btrfs/tree-checker.c:ALLOW_ERROR_INJECTION(btrfs_check_node, ERRNO);

The one in open_ctree() actually found a few bugs.
It's a success story.

Targeted error injection works better than random fuzzing.

To call schedule_timeout() bpf program needs to be sleepable.
Majority of LSM and ALLOW_ERROR_INJECTION hooks are sleepable.
All syscalls are sleepable too.
So most of the infrastructure is already available.

Add bpf_schedule_timeout() kfunc and ALLOW_ERROR_INJECTION
where it matters and it's good to go.
kfunc and error inject marks are non binding.
We can remove them if this experiment doesn't work out.

