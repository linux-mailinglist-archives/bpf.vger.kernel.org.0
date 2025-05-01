Return-Path: <bpf+bounces-57170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5E0AA6765
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 01:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E04A7DA0
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 23:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D81266B52;
	Thu,  1 May 2025 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl5s4I/n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4C16DEB3;
	Thu,  1 May 2025 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142030; cv=none; b=U/2k1HjaJ0FIw/1mginYx8zbUVNEKGb2J/2GqKfCYZHibwMqQi6UsXRCM+9dFRBj4T8DYNhLhY9nJkNHJt3PlfnH2lSodfYmnf289jaWZtoyZ1IT8C/yZHy0A9oY4/YVZWP9LXqoQh8QYpRA6yiudn246CIbV3PrSZJ6ZcHZ8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142030; c=relaxed/simple;
	bh=C/tR8iH3JgobGC1X/r0fY9gZGUX3UyIegqXrh1P1mfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOIcgrgOhkfio28DwjR/tOKC2xQMX+Rk5AZsTEbR8/1wR11lecNf0o6CwHqaVqCWJZIs11VclpAYwfVdsrs4e5kzqqJjxkkqaRfnpLjEraX5z9bnR8crwPPCBgRwBuV990fl9S6IoafJ1tWbNvLSweZgEzQM+9a4DWqQepcsTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl5s4I/n; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c1efc457bso1020771f8f.2;
        Thu, 01 May 2025 16:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746142027; x=1746746827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLGY/mmKFDMNfgWBTWZabnwNXPDwi/WRUsGT+xqswBU=;
        b=Yl5s4I/n71i4PwMSEGk63rFXmYLvTIxWqB5Y0eCMOxK6H8kZhxVlzzrMd/+vqsfKly
         nXU7zn9bs+bGJ4OM8BI3z2YjinDEcmhYizHuBc3HF5xlga9Ok+RCVDJtC+5Q+pjc/SFa
         sQzVPxhAYR8ogvu3Ilrk3R+HQ3ju3X1wMbc+fKdoWY6IXqGNxh0dBq812VAlkWhMACe+
         lCiAExEhLFg2h4vTeWQ1Xx3xNIVMpvdARm0U7ppQa41ylS6+/dVMPQZygAwnLO5mqx4B
         7G6A9aUW7/4TSdv0kYFDwLyMRn/fYV6bGLYVlJM7seZm6WvMg6e9qhcUzGfXCYH/1FoF
         1UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142027; x=1746746827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLGY/mmKFDMNfgWBTWZabnwNXPDwi/WRUsGT+xqswBU=;
        b=NI9MvNudY3B4lcC44LNEFkKAeTHhRDGratDvVsg6EzD/XUr5Uz6i/uxmE1DNVfCmkP
         j7XY1dCEbackhX0D/giYLvP9zBJjrY5hRNbllmlfWZoE1e2Jq1AfAkwcUBq9hKC6r4T5
         eI+3x9C0K0ewdavPg7uVH/6NECwcUvaINVcyudZhb/k4BzKUCjpWZk65xjQT5c63Txt5
         KUq9+ryNB9fJbLcLyCnZsZCtDvLkdWcHEKDN+2DkFSTXUWxhTD8FVqGLh48/HLRMzql9
         qfNV0NHq4qPCdvh5XNq3obaEobypXQ+yCTavVU6RClrtmOVBj4mgN7IkUgSGsYtimXYp
         vHdw==
X-Forwarded-Encrypted: i=1; AJvYcCVQuLYxj0cEkTTScpMUmfoB9wbI54nxR5GGEVxB+hovG1u6DlJiHYudop7NjjqORbmfvYs=@vger.kernel.org, AJvYcCXYBXhmEXIgKcZnIoKWHtAX7BJTMQF3orjgZjk06y6cOYtUx9oJIK3o4/aCAtKH03yErjkhFFUt@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxpnCrScO6RdYZg+NMOiVSwaqDuf/jy2z6C1wbQq4R2/zNb38
	1nAzqnfoe8olPuOLACxpYCZcHSiMC6c/N9rErMIpkrbDdZMuk2Rts/jMHLUaUvQb+MVURVbS8nh
	7QCYIyA+ggPK7WKrktuxpJUrFLyay5ZrN
X-Gm-Gg: ASbGncsynShK/g3lD8lkA25PFGyRitBkhpd5z4BYe7Uqp+COE28O4e+ouhNE0n/3Wc2
	+cV0wm+B/EPqPiuv58j9WD13PccRXXLtIEuw1uqenmmvq5JY5RMcXbO8DST/bq8+5Uz0mCDqLjK
	n69r8DTETJYu/14mUvvAw90U7zNrLKm7tWsOJnIgfKjMf6S7Yv
X-Google-Smtp-Source: AGHT+IGqd+4X2KpejHE1K0XtSnAtmcd4kSkCrpeYEaLJ+Y++5vtsTd3EXl4p8MPupHm7XlL6B9j1WORo8J83lxJYSBM=
X-Received: by 2002:a05:6000:2cb:b0:39e:e557:7d9 with SMTP id
 ffacd0b85a97d-3a099ad27c0mr397103f8f.5.1746142026420; Thu, 01 May 2025
 16:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214039.2919818-1-ameryhung@gmail.com> <CAEf4BzYUNckc9pXcE7BawxWFVfY--p12c3ax8ySP1P+BEww91w@mail.gmail.com>
In-Reply-To: <CAEf4BzYUNckc9pXcE7BawxWFVfY--p12c3ax8ySP1P+BEww91w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 May 2025 16:26:55 -0700
X-Gm-Features: ATxdqUHLqvR1ZRadaKm8w3mkPqxKoCF_K5PZqYERxnA9XL-tD5EA4byk18z-IMM
Message-ID: <CAADnVQL92e=-Nzr0O5Geev4y7cWG2m1UR_D7izF+Rd2ccPMNKQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/2] Task local data API
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 1:37=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Lack of support for shared libraries is a big limitation, IMO, so I
> think we should design for that support from the very beginning.
>
> FWIW, I think this compile-time static __thread variable definitions
> are unnecessarily limiting and add a non-trivial amount of complexity.
> I think it's more reasonable to go with a more dynamic approach, and
> I'll try to outline what an API (and some implementation details)
> might look like.
>
> Note, all this is related to the user-space side of things. BPF-side
> is unchanged, effectively, except you get a guarantee that all the
> data will definitely be page-aligned, so you won't need to do these
> two uptr pages handling.
>
> First, data structures. You'll have one per-process metadata structure
> describing known keys and their assigned "offsets":
>
> struct tld_metadata {
>     int cnt;
>     char keys[MAX_KEY_CNT];
>     __u16 offs[MAX_KEY_CNT];
>     __u16 szs[MAX_KEY_CNT];
> };

In Amery's proposal it's
u16 key_cnt;
struct {
  char key[TASK_LOCAL_DATA_KEY_LEN];
  u16 off;
} keys[];

If we start allocation from the end of the page then we
don't need 'szs' array.

> typedef struct { int off; } tld_off_t;

This is a good tweak.

> tld_off_t tld_add_key_def(const char *key_name, size_t key_size);

Dropping bpf_ prefix and sticking to tld_ is a good move too.

> This API can be called just once per each key that process cares
> about. And this can be done at any point, really, very dynamically.
> The implementation will:
>   - (just once per process) open pinned BPF map, remember its FD;
>   - (just once) allocate struct tld_metadata, unless we define it as
> pre-allocated global variable;

The main advantage of the new scheme is support for shared libraries.
That's a big plus, but the requirement that everything (shared libs,
static libs, application itself) has to go through this library
(it would have to be shared ?) is quite inconvenient imo.

Let's tweak this proposal and make the kernel the source of truth.
Then shared libs, static and application would only need to agree
on the protocol of accessing bpf task local storage instead of
being forced to use this "tld" library because it's stateful.
"tld" library will be there, but it will be stateless.

We may need to tweak the kernel uptr api a bit, but at a high level
let all user space things assume that two __uptr-s in that special
task local storage map are the source of truth.
First, the user space (.so, .a or a.out) will do is
map_lookup_elem(tls_map_fd) and if __uptr are pointing somewhere
use that memory regardless of which part of this process allocated it
(assuming that .so, .a or a.out won't be freeing it until exit).
If __uptr udata is still NULL, allocate page-aligned page and
map_update_elem(). The kernel doesn't need to deal with races
here since it's a task local value.
If __uptr umetadata is there after lookup, use that to find
and add keys. Here we need some generic locking mechanism,
since umetadata is per-process. Like test-and-set spinlock
that sits within umetadata region and all .so-s, .a-s, a.out
have the same algorithm to lock and access it.

If not there, allocate a page of umetadata and map_update_elem().
Here the kernel would need to deal with races, but I hope
BPF_NOEXIST should already work correctly? I haven't checked.
Worst case we'd need to add support for BPF_F_LOCK (if not already there).

>   - (locklessly) check if key_name is already in tld_metadata, if yes
> - return already assigned offset;
>   - (locklessly) if not, add this key and assign it offset that is
> offs[cnt - 1] + szs[cnt - 1] (i.e., we just tightly pack all the
> values (though we should take care of alignment requirements, of
> course);

I'm not quite sure how different processes can do it locklessly.
But if we allocate from the top of the page and there is only one
'offset' field then we can do it lockless. Like:
allocate(size sz)
{
       size_t old =3D atomic_read(&obj->offset);

       if ((ssize_t)(old - sz) >=3D 0 &&
           atomic_cmpxchg(&obj->offset, old, old - sz) =3D=3D old)
               return ..; // success
}

No suggestions for the rest of the proposal.

