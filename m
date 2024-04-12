Return-Path: <bpf+bounces-26651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01A18A3721
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 22:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA51F20FE8
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118353B2AD;
	Fri, 12 Apr 2024 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW2bHdl7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FA3BB2E;
	Fri, 12 Apr 2024 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954177; cv=none; b=d8S/yodYWVK6cz5dDuBBeSEoikPjIKjd1rq3U0VkexbAPkVV5gFV/flGoKnFTyMLE6K7AzmPk49gS7vzoGERFrgNaHQbd8wsVhxntRLwurdQQ+e4pHD2cAJsJYqtLMa70LyvuV0dhVJm/XZU+k1S2IHkyWAlM72OaWQIfEeIDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954177; c=relaxed/simple;
	bh=k8xBTPWqQx8XZxK5YQHMGvl3pQ7HksQIrKX1/vpHkTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXWpd57oA7ypuZuShr5z5EHtF+/IWE8dygGVgkTIAB60rrJwpN3seYSYRAWhUJxaNGHwzuHqTHcnZJKUAuXCLShPN6p/rDxj+qoO/RD2nk8OYcofh+tqaFlCri2uhCuBPxAG2nbRvv4NWmf62B+fh4k4mMofjWkQEYVr/eFMjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW2bHdl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864FAC113CC;
	Fri, 12 Apr 2024 20:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712954177;
	bh=k8xBTPWqQx8XZxK5YQHMGvl3pQ7HksQIrKX1/vpHkTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LW2bHdl70vlXye8NHCoZmJs2hYChxck4zxiCiOnbqhUJoClK741+SpHGai+JHw3lh
	 SFGaWbl3hOGHympsH+M3H5KaIa5d1qjmca1RNRz3d5SkFc2KkrP5IRzG5xmJ8bH6Av
	 b+7EJmADz0yazy6oGBIFqooV+5sFBcFxh1CBpew3bJtvRiimqlqOQuelB9Rwd57DN8
	 ykrQ8X8x7eXtY5n2JVY/GIDY8LTaI0sP+eBMIn0mezFsPAsYLKWOlmYWnBgRIQpDpi
	 s3Ii595wuiuPR4f71xHN72HhpXBwiNxRU43YKcb1uSrXCoS5kV8w2k1jjWlkrBaq6m
	 Rb5iH42XmUgKw==
Date: Fri, 12 Apr 2024 17:36:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
Message-ID: <ZhmbPVj62mMK1NZq@x1>
References: <20240402193945.17327-1-acme@kernel.org>
 <d9ebf954-bfac-4819-993b-bbf59c69285a@oracle.com>
 <82928441-d185-4165-85ff-425350953e80@oracle.com>
 <ZhQBpAGIDU_koQnp@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhQBpAGIDU_koQnp@x1>

On Mon, Apr 08, 2024 at 11:39:32AM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 08, 2024 at 01:00:59PM +0100, Alan Maguire wrote:
> > On 04/04/2024 09:58, Alan Maguire wrote:
> > > Program terminated with signal SIGSEGV, Segmentation fault.
> > > #0  0x00007f8c8260a58c in ptr_table__entry (pt=0x7f8c60001e70, id=77)
> > >     at /home/almagui/src/dwarves/dwarves.c:612
> > > 612		return id >= pt->nr_entries ? NULL : pt->entries[id];
> > > [Current thread is 1 (Thread 0x7f8c65400700 (LWP 624441))]
> > > (gdb) print *(struct ptr_table *)0x7f8c60001e70
> > > $1 = {entries = 0x0, nr_entries = 2979, allocated_entries = 4096}
> > > (gdb)
> 
> > > So it looks like the ptr_table has 2979 entries but entries is NULL;
> > > could there be an issue where CU initialization is not yet complete
> > > for some threads (it also happens very early in processing)? Can you
> > > reproduce this failure at your end? Thanks!
>  
> > the following (when applied on top of the series) resolves the
> > segmentation fault for me:
>  
> > diff --git a/pahole.c b/pahole.c
> > index 6c7e738..5ff0eaf 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -3348,8 +3348,8 @@ static enum load_steal_kind pahole_stealer(struct
> > cu *cu,
> >                 if (conf_load->reproducible_build) {
> >                         ret = LSK__KEEPIT; // we're not processing the
> > cu passed to this function, so keep it.
> > -                        // Equivalent to LSK__DELETE since we processed
> > this
> > -                       cus__remove(cus, cu);
> > -                       cu__delete(cu);
> >                 }
> >  out_btf:
> >                 if (!thr_data) // See comment about reproducibe_build above
> > 
> 
> Yeah, Jiri also pointed out this call to cu__delete() was new, I was
> trying to avoid having unprocessed 'struct cu' using too much memory, so
> after processing it, delete them, but as you found out there are
> references to that memory...
> 
> > In other words, the problem is we remove/delete CUs when finished with
> > them in each thread (when BTF is generated).  However because the
> > save/add_saved_funcs stashes CU references in the associated struct
> > function * (to allow prototype comparison for the same function in
> > different CUs), we end up with stale CU references and in this case the
> > freed/nulled ptr_table caused an issue. As far as I can see we need to
> > retain CUs until all BTF has been merged from threads.
>  
> > With the fix in place, I'm seeing less then 100msec difference between
> > reproducible/non-reproducible vmlinux BTF generation; that's great!
> 
> Excellent!
> 
> I'll remove it and add a note crediting you with the removal and having
> the explanation about why its not possibe to delete it at that point
> (references to the associated 'struct function').

So I removed that cus__remove + cu__delete and also the other one at the
flush operation, leaving all cleaning up to cus__delete() time:

⬢[acme@toolbox pahole]$ git diff
diff --git a/dwarves.c b/dwarves.c
index fbc8d8aa0060b7d0..1ec259f50dbd3778 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -489,8 +489,12 @@ struct cu *cus__get_next_processable_cu(struct cus *cus)
                        cu->state = CU__PROCESSING;
                        goto found;
                case CU__PROCESSING:
-                       // This will only happen when we get to parallel
-                       // reproducible BTF encoding, libbpf dedup work needed here.
+                       // This will happen when we get to parallel
+                       // reproducible BTF encoding, libbpf dedup work needed
+                       // here. The other possibility is when we're flushing
+                       // the DWARF processed CUs when the parallel DWARF
+                       // loading stoped and we still have CUs to encode to
+                       // BTF because of ordering requirements.
                        continue;
                case CU__UNPROCESSED:
                        // The first entry isn't loaded, signal the
diff --git a/pahole.c b/pahole.c
index 6c7e73835b3e9139..77772bb42bb443ce 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3347,9 +3347,9 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 
                if (conf_load->reproducible_build) {
                        ret = LSK__KEEPIT; // we're not processing the cu passed to this function, so keep it.
-                       // Equivalent to LSK__DELETE since we processed this
-                       cus__remove(cus, cu);
-                       cu__delete(cu);
+                       // Kinda equivalent to LSK__DELETE since we processed this, but we can't delete it
+                       // as we stash references to entries in CUs for 'struct function' in btf_encoder__add_saved_funcs()
+                       // and btf_encoder__save_func(), so we can't delete them here. - Alan Maguire
                }
 out_btf:
                if (!thr_data) // See comment about reproducibe_build above
@@ -3667,9 +3667,6 @@ static int cus__flush_reproducible_build(struct cus *cus, struct btf_encoder *en
                err = btf_encoder__encode_cu(encoder, cu, conf_load);
                if (err < 0)
                        break;
-
-               cus__remove(cus, cu);
-               cu__delete(cu);
⬢[acme@toolbox pahole]$


It ends up taking a bit more time on this 14700K with 32Gb, I'll later
try to remove that need to keep everything in memory and also double
check this hunch that this is due to keeping everyuthing in memory.

Can I take this (with the above patch, that is a bit bigger than yours)
as a Tested-by + Reviewed-by you?

- Arnald

