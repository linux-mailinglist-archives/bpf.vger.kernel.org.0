Return-Path: <bpf+bounces-26187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA389C73B
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 16:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91B0283A94
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5D113E8A5;
	Mon,  8 Apr 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/e9Ri/r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7EE13CFAF;
	Mon,  8 Apr 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587177; cv=none; b=Bw11ZnRxI/5zdjQMMeNaWJqsX8j7MotfGlljg9wFWmo2AXbuLKFZ5MaBC0k6Iut9gu/5tMqZG7Ai1Mqp/SnsTwd8LjtkkivvypYX69H9qe9dkW4YayRpai7YUpug2mhgYo8th55bn4viblbJvkNv/L9/scaR4qP1s8cTYf57Z+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587177; c=relaxed/simple;
	bh=YAHYNYM/Ph43Uys7D2S+BwnAz/P7Glakx2cICS3+DIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0VpWKgz6oYUt0TAUdnPb7YZlRtmPLqXDKq7ztk3EK34pJu8dGXntO9mlGp3q6bPRIS5+hQxDM34fv2nzzwlg8O5zuXlDk2g1A+YbgSDYPxsY4mAF8VGopfagqSD8HwmnWs4VDCYAoAryKneK66a09035bB+SfI9zpHsvyxqj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/e9Ri/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8902FC433F1;
	Mon,  8 Apr 2024 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712587177;
	bh=YAHYNYM/Ph43Uys7D2S+BwnAz/P7Glakx2cICS3+DIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/e9Ri/rDPlixpIdFmHdnQNmzjkw816mr3crJPZM35SrXtN+258VN8ldSyNmbBUTY
	 tj0fa7QyJ0NzXtPqs9OlGWvChM6saTbH7r0XEICj7hvA6QKByFUd1G6Paqxe2kZMLO
	 3fV7ww0AKWiUrMd59zpH4I9nbxtaID6TeyTtj/CnxCYk8cMSATvMdlBfm+XSY+gCsp
	 ZG5kcFiLUdnV6HSuCfcjLFmyqp+70X+2RLaY8Itfh7M962lmo5zH0vka4LAN4ArX85
	 FmVqkP2HHHaBEjMfnU+WVebD1koqJiQNsedOhCDZ4OeQhqVO6rTsvPbwwgFjUK18Lz
	 rBIJFn2QhQnZQ==
Date: Mon, 8 Apr 2024 11:39:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
Message-ID: <ZhQBpAGIDU_koQnp@x1>
References: <20240402193945.17327-1-acme@kernel.org>
 <d9ebf954-bfac-4819-993b-bbf59c69285a@oracle.com>
 <82928441-d185-4165-85ff-425350953e80@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82928441-d185-4165-85ff-425350953e80@oracle.com>

On Mon, Apr 08, 2024 at 01:00:59PM +0100, Alan Maguire wrote:
> On 04/04/2024 09:58, Alan Maguire wrote:
> > Program terminated with signal SIGSEGV, Segmentation fault.
> > #0  0x00007f8c8260a58c in ptr_table__entry (pt=0x7f8c60001e70, id=77)
> >     at /home/almagui/src/dwarves/dwarves.c:612
> > 612		return id >= pt->nr_entries ? NULL : pt->entries[id];
> > [Current thread is 1 (Thread 0x7f8c65400700 (LWP 624441))]
> > (gdb) print *(struct ptr_table *)0x7f8c60001e70
> > $1 = {entries = 0x0, nr_entries = 2979, allocated_entries = 4096}
> > (gdb)

> > So it looks like the ptr_table has 2979 entries but entries is NULL;
> > could there be an issue where CU initialization is not yet complete
> > for some threads (it also happens very early in processing)? Can you
> > reproduce this failure at your end? Thanks!
 
> the following (when applied on top of the series) resolves the
> segmentation fault for me:
 
> diff --git a/pahole.c b/pahole.c
> index 6c7e738..5ff0eaf 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3348,8 +3348,8 @@ static enum load_steal_kind pahole_stealer(struct
> cu *cu,
>                 if (conf_load->reproducible_build) {
>                         ret = LSK__KEEPIT; // we're not processing the
> cu passed to this function, so keep it.
> -                        // Equivalent to LSK__DELETE since we processed
> this
> -                       cus__remove(cus, cu);
> -                       cu__delete(cu);
>                 }
>  out_btf:
>                 if (!thr_data) // See comment about reproducibe_build above
> 

Yeah, Jiri also pointed out this call to cu__delete() was new, I was
trying to avoid having unprocessed 'struct cu' using too much memory, so
after processing it, delete them, but as you found out there are
references to that memory...

> In other words, the problem is we remove/delete CUs when finished with
> them in each thread (when BTF is generated).  However because the
> save/add_saved_funcs stashes CU references in the associated struct
> function * (to allow prototype comparison for the same function in
> different CUs), we end up with stale CU references and in this case the
> freed/nulled ptr_table caused an issue. As far as I can see we need to
> retain CUs until all BTF has been merged from threads.
 
> With the fix in place, I'm seeing less then 100msec difference between
> reproducible/non-reproducible vmlinux BTF generation; that's great!

Excellent!

I'll remove it and add a note crediting you with the removal and having
the explanation about why its not possibe to delete it at that point
(references to the associated 'struct function').

Perhaps we can save this info in some other way that allows us to free
the CU after having it processed, I'll think about it.

But its good to see that the difference is small, great!

Thanks a lot!

- Arnaldo

