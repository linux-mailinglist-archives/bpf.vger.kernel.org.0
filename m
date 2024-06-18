Return-Path: <bpf+bounces-32406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3994A90D5A2
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 16:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F67B2F69F
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 14:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658313D242;
	Tue, 18 Jun 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWyawfa6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23615A869;
	Tue, 18 Jun 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718710; cv=none; b=R8fWqDX5BL3rimibW1MSIeoNhJEMqc0yjZLrUrQ/gcANjtOXdvdl8Hp1Jqra6OHBYsj+Qy/JtyId8cjkLRxEh5WNheBNEf+sWa67qxU+euGB9xaeCwPw0w7BhjahB2756njg5FzFfO2mCgX0rvDat01qucEmGoVJWDnNsp/zFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718710; c=relaxed/simple;
	bh=jZTXzxlFYVfRFo7ptSoHB/sfDeGp2NsucUm1L+1pbAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffqqRToS0XMNYLvjmPPO++50r+G9Q+uBvBo39z0rFjQTh4lxSMAF9nAyO2TigTcmk3wfKPzBkBSwECakd3AewC6En4mujMdUu5Vnt+PJWagzruh3Y/OzQX3OQcM59S2oUBM5lbb1HE4iYDZS6FVL6sNcg9DXK86uhWvMoyZsDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWyawfa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F178C4AF1D;
	Tue, 18 Jun 2024 13:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718718709;
	bh=jZTXzxlFYVfRFo7ptSoHB/sfDeGp2NsucUm1L+1pbAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWyawfa6btzKXEdvhC+UgMCuUE7OfMHTqIc3wsT7ajozNZVzUq5AZ4uVnERVajBSb
	 AkYqGy6iKPoC6hIuFT33xTfmMh2d9OAFR1z2ohFFhMVi3XADJgUZqQ9rFFRD0HpURq
	 hB5T4FbOPUkEulizkqo6OomC7SbwaXThQRWC6ZVIFgjfCAyXZDEhB02N6t9Joc6Ofc
	 AFbQBTGUvlSzps6DjOmuWHLdfDp6UIy/u6B6STVTAIK0YVNoyS2x6ofoLQWzsBk/gb
	 OHmUqCem7/YsWsq9HT2p8sqZNaSzfmLR4R39shMxgiiFdiwFPuDLh8cIDTGkX0845G
	 P25Wnzz7v1Y8g==
Date: Tue, 18 Jun 2024 10:51:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>,
	llvm@lists.linux.dev
Subject: Re: [PATCH/RFT] Re: ANNOUNCE: pahole v1.27 (reproducible builds, BTF
 kfuncs)
Message-ID: <ZnGQ8CDRaMBIj5R5@x1>
References: <ZmjBHWw-Q5hKBiwA@x1>
 <20240613214019.GA1423015@thelio-3990X>
 <ZnCQ-Psf_WswMk1W@x1>
 <ZnCWRMfRDMHqSxBb@x1>
 <20240617210810.GA1877676@thelio-3990X>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617210810.GA1877676@thelio-3990X>

On Mon, Jun 17, 2024 at 02:08:10PM -0700, Nathan Chancellor wrote:
> On Mon, Jun 17, 2024 at 05:02:12PM -0300, Arnaldo Carvalho de Melo wrote:
> > Can you try with the one liner below? We remove it from the cus list
> > unconditionally, and since we alloc space with zalloc/calloc in
> > cu__new() and missed initializing that list_head (cu->node) we ended up
> > hitting list_del with a zeroed 'struct list_head' :-\
> > 
> > I'll try and get this cast_common.ko checked into a test repo for pahole
> > so that this gets regression tested.
> > 
> > Please test this patch so that we see if this is the only problem and
> > your kernel build with clang completes successfully.
> 
> Thanks, I rebuilt pahole with the following diff and both my build and
> the other configuration I tested for this regression successfully
> complete.
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Great, I just added this:

From 6a2b27c0f512619b0e7a769a18a0fb05bb3789a5 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 18 Jun 2024 10:37:30 -0300
Subject: [PATCH 1/1] core: Initialize cu->node with INIT_LIST_HEAD()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In cu__new() zalloc() is used defensively, and that helped catch this
problem where we assume that a cu us in the cus list of cu instances,
but that is not the case when we use cus__merge_and_process_cu(), for
instance when loading files created by clang with LTO, as reported by
Peter Jung and narrowed down by Nathan Chancellor.

If we use INIT_LIST_HEAD() in cu__new() to initialize cu->node, which is
what we do with other lists and nodes there, then the unconditional
removal using list_del_init() will be a no-op and removing something not
on the cus list of cu instances will not cause problems, just keep an
unconsistent cus->nr_entries field.

So lets just have this fix in first, keeping Nathan's Tested-by and then
do the a bit more involved fix of either adding that cu to the cus list
or checking at removal time if it is there.

  Program received signal SIGSEGV, Segmentation fault.
  0x00007ffff7f1e13e in __list_del (prev=0x0, next=0x0) at /home/acme/git/pahole/list.h:106
  106		next->prev = prev;
  (gdb) bt
  #0  0x00007ffff7f1e13e in __list_del (prev=0x0, next=0x0) at /home/acme/git/pahole/list.h:106
  #1  0x00007ffff7f1e176 in list_del_init (entry=0x417980) at /home/acme/git/pahole/list.h:165
  #2  0x00007ffff7f1f8f9 in __cus__remove (cus=0x4142a0, cu=0x417980) at /home/acme/git/pahole/dwarves.c:527
  #3  0x00007ffff7f1f92b in cus__remove (cus=0x4142a0, cu=0x417980) at /home/acme/git/pahole/dwarves.c:533
  #4  0x00007ffff7f3d01c in cus__finalize (cus=0x4142a0, cu=0x417980, conf=0x4133c0 <conf_load>, thr_data=0x0)
      at /home/acme/git/pahole/dwarf_loader.c:3040
  #5  0x00007ffff7f3e05c in cus__merge_and_process_cu (cus=0x4142a0, conf=0x4133c0 <conf_load>, mod=0x415cf0, dw=0x416110, elf=0x414380,
      filename=0x7fffffffe3f7 "cast_common.ko", build_id=0x416680 "\265D\371U\213\373u|\037\250\242\032\271\365⒜]y\023", build_id_len=20,
      type_dcu=0x0) at /home/acme/git/pahole/dwarf_loader.c:3482
  #6  0x00007ffff7f3e218 in cus__load_module (cus=0x4142a0, conf=0x4133c0 <conf_load>, mod=0x415cf0, dw=0x416110, elf=0x414380,
      filename=0x7fffffffe3f7 "cast_common.ko") at /home/acme/git/pahole/dwarf_loader.c:3521
  #7  0x00007ffff7f3e396 in cus__process_dwflmod (dwflmod=0x415cf0, userdata=0x415d00, name=0x415ea0 "cast_common.ko", base=65536,
      arg=0x7fffffffde40) at /home/acme/git/pahole/dwarf_loader.c:3581
  #8  0x00007ffff7eb4609 in dwfl_getmodules (dwfl=0x414300, callback=0x7ffff7f3e2ec <cus__process_dwflmod>, arg=0x7fffffffde40, offset=0)
      at ../libdwfl/dwfl_getmodules.c:86
  #9  0x00007ffff7f3e4c5 in cus__process_file (cus=0x4142a0, conf=0x4133c0 <conf_load>, fd=3, filename=0x7fffffffe3f7 "cast_common.ko")
      at /home/acme/git/pahole/dwarf_loader.c:3647
  #10 0x00007ffff7f3e5cd in dwarf__load_file (cus=0x4142a0, conf=0x4133c0 <conf_load>, filename=0x7fffffffe3f7 "cast_common.ko")
      at /home/acme/git/pahole/dwarf_loader.c:3684
  #11 0x00007ffff7f232df in cus__load_file (cus=0x4142a0, conf=0x4133c0 <conf_load>, filename=0x7fffffffe3f7 "cast_common.ko")
      at /home/acme/git/pahole/dwarves.c:2134
  #12 0x00007ffff7f23e8b in cus__load_files (cus=0x4142a0, conf=0x4133c0 <conf_load>, filenames=0x7fffffffe0f0)
      at /home/acme/git/pahole/dwarves.c:2637
  #13 0x000000000040aec0 in main (argc=2, argv=0x7fffffffe0e8) at /home/acme/git/pahole/pahole.c:3805
  (gdb) fr 1
  #1  0x00007ffff7f1e176 in list_del_init (entry=0x417980) at /home/acme/git/pahole/list.h:165
  165		__list_del(entry->prev, entry->next);
  (gdb) p entry
  $1 = (struct list_head *) 0x417980
  (gdb) p entry->next
  $2 = (struct list_head *) 0x0
  (gdb) p entry->prev
  $3 = (struct list_head *) 0x0

Closes: https://github.com/acmel/dwarves/issues/53
Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/pahole/-/issues/1
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/all/20240617210810.GA1877676@thelio-3990X
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dwarves.c b/dwarves.c
index 1ec259f50dbd3778..823a01524a12bb37 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -739,6 +739,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
 		cu->dfops	= NULL;
 		INIT_LIST_HEAD(&cu->tags);
 		INIT_LIST_HEAD(&cu->tool_list);
+		INIT_LIST_HEAD(&cu->node);
 
 		cu->addr_size = addr_size;
 		cu->extra_dbg_info = 0;
-- 
2.45.0


