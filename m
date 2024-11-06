Return-Path: <bpf+bounces-44093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2479B9BDBBA
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 03:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77CE1F23FD4
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 02:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504BA18DF90;
	Wed,  6 Nov 2024 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv0Skf5b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195818DF7C;
	Wed,  6 Nov 2024 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858500; cv=none; b=muQardCG4v4Oq1haw3FsltCnWPqHsjoTN62VQ8pi/LZROapjXDGfJTMLV/0N1oVkceIix50vuDPhomTPqF8+a1zfGWXEdN5wAjVNiMJg3ISvawUJXew+xf9LWy28LBZlFp8D+s+JZgdD82WAm6XFLJScg34Pvee+pUuvPWE5UF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858500; c=relaxed/simple;
	bh=+5O2bCBKM34Z1eHChCoHEhyKKVR5boF3WLDbOkKVg6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tpgx+wgFAQppi0ITdwaTTxoD3kfSXig1q8SxZgTDf5XvQnlxiwDD09Pd/XL9ppQDxm8l1texIFo2ef2oaY6JkHjepwvZdQlue7IWd++bwdiRlBA2Ojtx/2gbB+ZgTqu6K12P0WLF0hY6PAVhlxc2KvU0h2jaccId248t7z7vjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv0Skf5b; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso4482118a91.2;
        Tue, 05 Nov 2024 18:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730858499; x=1731463299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxYYlEKfDlrZUkDu7HsmPXCPNPkXskaS+wY418cH17Q=;
        b=Uv0Skf5bB6PsnAOCBMSaKRQNe+jQGs0ydMahm3v5DccIohfpPeL1WXgZFKgHzOLgz+
         lYJuOtS75GEevnBDkFkVERTP15NtuU/BdR+18fV2QZSh1SzIelXKVC2T7qj1AUGpOc9b
         UbpuSRtHLEMKMzSDm7WAdBS9Ohu69hlLj8Uuy6dnxk6c9x4w8vJIjJsSAs8xlNmtty9u
         Q6JLPHlY75hWkvnjOVtM0/akxBty7jJWqbK0prLIorYEkEonISzxlW5QBRKAlf+PtXnB
         b/IaI8vmq8ZsbgG5jkpEnhfPdnBU+yAFz8wp8pZ6w7QUrmWKjZjkI7HhsGh3M6SPPGs9
         Db2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730858499; x=1731463299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxYYlEKfDlrZUkDu7HsmPXCPNPkXskaS+wY418cH17Q=;
        b=rilnZMaBbA06oJYMETQ04yiOQ5ZO5jOCQ5lStAJkODSnQoznNS2gXadUhZV2eBAYj8
         2mMREPNjgiWm+wqU/V1hUInX3CACyea0BnPFAkaGFrDSVRaAbEsvMV3eGOFVfUEEFl9E
         6AfWU+cjKsh72GOE0o28UmkFa6wChYRhBiosUh/oaD5EHA4Pp22v9j1QvMAYWvsMQ6N0
         zjISuTarGHGDlGGptk0KOmh0UBtJiyIU14ULHaVQK3t7wZ6dzIjarB6ju1pzlUbI7jlP
         cIfm6DQ1EZQzoHO+ckE08MkeFU5m0fF51Mw6mWktx8vBopRXNLo4v11nCuLED68liuw6
         0Dyg==
X-Forwarded-Encrypted: i=1; AJvYcCUI5eB6eZ5yqZowTYGmkbCsRFa+ClJZ935FUxQMsnncoGlucBK8tjATIJ40An+1zYSIvwOz3MVfYbk7qwaz@vger.kernel.org, AJvYcCUgbaKXj/t9naSGEjQVDJCzyKGwZc2OYxtWBB1Zf1Z+D7U9D64Kvvs35FeS6nHlBcZVVu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvZ6OY7Yq/Z8iupFk1S02hQxmTfvfNCV327VrrJLk87chnQYT
	3SAyTn9eUpB1AmRqIa4jdkyNx710d8H/ZJH055iPP3Cx2O1bdLpF70xxuss+ZK+lnXWVynTVUIF
	4j+VGbcsxzdMjKvgG3iKBpUuJwQUxdQ==
X-Google-Smtp-Source: AGHT+IGx/96ktyFiAyvlyXyF1+CpdM7WUL3DgFzzA+I+Bv14k6HBjkK9LrCuF8E7LZf0+yP5zsHlI4OTGEXNrVjeSzs=
X-Received: by 2002:a17:90a:fa8c:b0:2e2:d3e1:f863 with SMTP id
 98e67ed59e1d1-2e8f1071be6mr38875214a91.12.1730858498668; Tue, 05 Nov 2024
 18:01:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org>
In-Reply-To: <20241028010818.2487581-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Nov 2024 18:01:25 -0800
Message-ID: <CAEf4BzYPajbgyvcvm7z1EiPgkee1D1r=a8gaqxzd7k13gh9Uzw@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 0/4] uprobes,mm: speculative lockless
 VMA-to-uprobe lookup
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, mjguzik@gmail.com, brauner@kernel.org, 
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	david@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com, 
	zhangpeng.00@bytedance.com, linmiaohe@huawei.com, viro@zeniv.linux.org.uk, 
	hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 6:09=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Implement speculative (lockless) resolution of VMA to inode to uprobe,
> bypassing the need to take mmap_lock for reads, if possible. First two pa=
tches
> by Suren adds mm_struct helpers that help detect whether mm_struct was
> changed, which is used by uprobe logic to validate that speculative resul=
ts
> can be trusted after all the lookup logic results in a valid uprobe insta=
nce.
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
> v3->v4:
> - rebased and dropped data_race(), given mm_struct uses real seqcount (Pe=
ter);
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
> Andrii Nakryiko (2):
>   uprobes: simplify find_active_uprobe_rcu() VMA checks
>   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
>
> Suren Baghdasaryan (2):
>   mm: Convert mm_lock_seq to a proper seqcount
>   mm: Introduce mmap_lock_speculation_{begin|end}
>
>  include/linux/mm.h               | 12 ++---
>  include/linux/mm_types.h         |  7 ++-
>  include/linux/mmap_lock.h        | 87 ++++++++++++++++++++++++--------
>  kernel/events/uprobes.c          | 47 ++++++++++++++++-
>  kernel/fork.c                    |  5 +-
>  mm/init-mm.c                     |  2 +-
>  tools/testing/vma/vma.c          |  4 +-
>  tools/testing/vma/vma_internal.h |  4 +-
>  8 files changed, 129 insertions(+), 39 deletions(-)
>
> --
> 2.43.5
>

Hi!

What's the status of this patch set? Are there any blockers for it to
be applied to perf/core? MM folks are OK with landing the first two
patches in perf/core, so hopefully we should be good to go?

