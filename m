Return-Path: <bpf+bounces-42941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18A9AD35E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16E61C222D3
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D371D0DD5;
	Wed, 23 Oct 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDOQnivy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E91D04BB;
	Wed, 23 Oct 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706089; cv=none; b=AxTlKP73JHHvBVgBkFvRRkLDIePHsSRCpZcAkOtWNYxyQ6UgSrtccA0oFT2cQAPQkdiUJTlDIsn/6ZBu16PpW7oKKNjCklf25m1dW/mMV6mTaOH6mEHBBusWkMqYNmrdJrjlgOqAXHs5Xys6eSx8KSNAb7TQFXCGHpjaBYBsh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706089; c=relaxed/simple;
	bh=Op9slF3hj7QkRdJK4MJ0WM2ve3FfTirYm86ftYNV8PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCQGweWelICLIQKb9DY5sXLF44UhJBUjtGcOW16t/3eJPEHPzVRv5XDVCm38BdtfMxVmw/zStj5rMZdsBuZfp/Jijluv9BRIteJayvZetLsyPNBdSdkgxEyHGYxhD6UAgB4hMHD+4n7EWO0zu6CTM/kZ3U8iaVvl4AYn9irOo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDOQnivy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e983487a1so68403b3a.2;
        Wed, 23 Oct 2024 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729706087; x=1730310887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzC0zojgdAaM2rfn3YXXNhX5GBn8pCVofhKBdnpRhHA=;
        b=kDOQnivydrnQyR2TXVHyi5gHt264Mk29VJwvSiRkxrN4ij/wR88+m4tzk5yhv5ug+4
         3N35/YyqcvkOlpmgy6dPTXEeh5nxBgoHa1Na8HXdqdnmcl6/Os6P1EvT7sfYA5Ffh5oh
         JH0ttQMDATi+MUcq72JinnBtEkj1juNaeXl/ILWQz4GkHkL3eCee+KnTvD1yTM1eGcxy
         3ftH8A8ECotp7Mmh4sKKwLViuEB7mWkmWtPeN7c/taDMoNeg/WmxlgO6PwTW2egRw7ye
         urJfUcHf0X4OED7aKz6XJUZsVzu5gWRbTteyIoIy1QGAJd28kfF2EH+SV449GKj1ZrmW
         Br9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729706087; x=1730310887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzC0zojgdAaM2rfn3YXXNhX5GBn8pCVofhKBdnpRhHA=;
        b=brTf4zekySKgHtCzkDROT/5vYLYn4UmMY4mD+hoawJ9vss7k63YrTLXFleHhorP73o
         ae6pOEf9CJz4iGwUk4XxwXF58l3Z1nWvmRIIiZA9SGZ+DfgNaRLqg0sgOM0dCAh1JllV
         QTrjHho8hFv35peH7CRBfDCV5mSkLQ4mcL5KHbSq0DgcE/zKC5U4/yHw3fi92FoFRB1D
         PXt0cjOjQTReOU006MipbMeWnh5ohWvJnJ17fgLw01ih4ydh2gFxxxWgq+6UeBWRlKJN
         zpmKix4kNcT+2sdwkFi0Qa6yK7DYVs1IACfeFeceMi1saG/UDrg+aH3l4XjOewDbU+B0
         SIrg==
X-Forwarded-Encrypted: i=1; AJvYcCUKtyKWzYtI9vdgIXMV8289zIrjmd52AZHhCCaqJwPtwpBCpf+pIZqWmwNY+sKsgzVODIkpemGImqzZyg+a@vger.kernel.org, AJvYcCXBxVu3/0nsU6dGQr3hcGnvn2eV2HyF/7TefUrrfOoESfAOuSgk8EEmLUR7zU/m2mKwbeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCj0UjPuI8XJhAVx4ZtuC6zkbYaAPe7htmFgwxRUMLs0eXR4gg
	7Yj3keV1V3Z4KdyoFS8Ban/3GWlZ7XxqgDnHc6ap/BLfbVC0GHPCTcjFGcFjn7Shgs3XBsRvto4
	08RqQrMvitKGbz/bifduVXNNliYs=
X-Google-Smtp-Source: AGHT+IH8r6pSZYJrhlvyswY9keD0vhNapeUVfc4WgwLysEX15Sns9APZ9b0HudC/bFg3ZXdudugL5NyKX/kM9UGRi0Y=
X-Received: by 2002:a05:6a00:811:b0:71e:680d:5e94 with SMTP id
 d2e1a72fcca58-72030b61979mr5015362b3a.19.1729706087069; Wed, 23 Oct 2024
 10:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org>
In-Reply-To: <20241010205644.3831427-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 10:54:34 -0700
Message-ID: <CAEf4BzbJRUjcT9J7tFOMmyLsiTwoCMgZDp08EkVrF1vxO66DAA@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 0/4] uprobes,mm: speculative lockless
 VMA-to-uprobe lookup
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, mjguzik@gmail.com, brauner@kernel.org, 
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:56=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Implement speculative (lockless) resolution of VMA to inode to uprobe,
> bypassing the need to take mmap_lock for reads, if possible. Patch #1 by =
Suren
> adds mm_struct helpers that help detect whether mm_struct was changed, wh=
ich
> is used by uprobe logic to validate that speculative results can be trust=
ed
> after all the lookup logic results in a valid uprobe instance. Patch #2
> follows to make mm_lock_seq into 64-bit counter (on 64-bit architectures)=
, as
> requested by Jann Horn.
>
> Patch #3 is a simplification to uprobe VMA flag checking, suggested by Ol=
eg.
>
> And, finally, patch #4 is the speculative VMA-to-uprobe resolution logic
> itself, and is the focal point of this patch set. It makes entry uprobes =
in
> common case scale very well with number of CPUs, as we avoid any locking =
or
> cache line bouncing between CPUs. See corresponding patch for details and
> benchmarking results.
>
> Note, this patch set assumes that FMODE_BACKING files were switched to ha=
ve
> SLAB_TYPE_SAFE_BY_RCU semantics, which was recently done by Christian Bra=
uner
> in [0]. This change can be pulled into perf/core through stable
> tags/vfs-6.13.for-bpf.file tag from [1].
>
>   [0] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/=
?h=3Dvfs-6.13.for-bpf.file&id=3D8b1bc2590af61129b82a189e9dc7c2804c34400e
>   [1] git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>
> v2->v3:
> - dropped kfree_rcu() patch (Christian);
> - added data_race() annotations for fields of vma and vma->vm_file which =
could
>   be modified during speculative lookup (Oleg);
> - fixed int->long problem in stubs for mmap_lock_speculation_{start,end}(=
),
>   caught by Kernel test robot;
> v1->v2:
> - adjusted vma_end_write_all() comment to point out it should never be ca=
lled
>   manually now, but I wasn't sure how ACQUIRE/RELEASE comments should be
>   reworded (previously requested by Jann), so I'd appreciate some help th=
ere
>   (Jann);
> - int -> long change for mm_lock_seq, as agreed at LPC2024 (Jann, Suren, =
Liam);
> - kfree_rcu_mightsleep() for FMODE_BACKING (Suren, Christian);
> - vm_flags simplification in find_active_uprobe_rcu() and
>   find_active_uprobe_speculative() (Oleg);
> - guard(rcu)() simplified find_active_uprobe_speculative() implementation=
.
>
> Andrii Nakryiko (3):
>   mm: switch to 64-bit mm_lock_seq/vm_lock_seq on 64-bit architectures
>   uprobes: simplify find_active_uprobe_rcu() VMA checks
>   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
>
> Suren Baghdasaryan (1):
>   mm: introduce mmap_lock_speculation_{start|end}
>
>  include/linux/mm.h        |  6 ++--
>  include/linux/mm_types.h  |  7 ++--
>  include/linux/mmap_lock.h | 72 ++++++++++++++++++++++++++++++++-------
>  kernel/events/uprobes.c   | 52 +++++++++++++++++++++++++++-
>  kernel/fork.c             |  3 --
>  5 files changed, 119 insertions(+), 21 deletions(-)
>
> --
> 2.43.5
>

This applies cleanly to tip/perf/core with or without Jiri's patches
([0]). No need to rebase and resend, this is ready to go in.

  [0] https://lore.kernel.org/all/20241018202252.693462-1-jolsa@kernel.org/

