Return-Path: <bpf+bounces-47693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01C9FE8E7
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 17:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EC1882E48
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A42D1AA7A6;
	Mon, 30 Dec 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSp8ul+w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0961F95A;
	Mon, 30 Dec 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735574856; cv=none; b=UCAUpk9BRNJqCnZ6czksGY0cnnWv3dViEZ6xjp/hoQzXsFruXjoI2AeNIIBzweXi7+LiF7RtUhm3c+6W41Y0bJx7JTwQPueSxlefx9OSiJ7s9KKCQTxR+gC7vS7exfCDMUtYCrMT2AlWuaD/cd59tBowRGY745+Ctl2RDiESw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735574856; c=relaxed/simple;
	bh=8/QUN9qyRoFklM9Sv8cMQ0k9rtpnBGFbzpt+9qcvc8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSULaUV1FUvmbiKvu5YQNapExLZOQkNwzH9M/tdWY5tpV9oLZmaUz+tgnhtD0FklTwBRnCaMfWNauN3u+DnBBZF1wrn50PO2+pP6lpsdAa3IvAw0Lb0ta5hUX0/FJj92h2mpagbLH83NIsKIPxN9zDw7JLNDYfI/aO0XBnHj6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSp8ul+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50F5C4CED0;
	Mon, 30 Dec 2024 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735574856;
	bh=8/QUN9qyRoFklM9Sv8cMQ0k9rtpnBGFbzpt+9qcvc8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSp8ul+wcT8hQBkz9IikKJVZ6o83WTW2F7KkTf16VFK6X4Ad3hO+R+EkzmoeFYzLB
	 wJOOsa0a19V7jb/aStvsBYLJdTj5S6oSjm1UcIfK8/BOVABZnVHwb/2gdgklz2GQir
	 jQb5XXnCEnZ55FUem80AzlwzqooLS5WEPfTu6x7VYQXG7suIDCez+S9+3JOIbkawIz
	 +toG2sn/0Xob/z3Bl946EFgJ+aqxxVDUeOblEJUe+CGDvJ1jNISYnel3W55yQZtM6c
	 RWKBE9s3zeW4nQyfeEQpt+5qSxdqoYtHb4xLyeDXHPOrq11cezaT7lAOdBjGpfiX7O
	 3k8aYfGisvsKg==
Date: Mon, 30 Dec 2024 13:07:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com,
	andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 7/8] dwarf_loader: multithreading with a
 job/worker model
Message-ID: <Z3LFREHG-8QhoAcc@x1>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
 <20241221012245.243845-8-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221012245.243845-8-ihor.solodrai@pm.me>

On Sat, Dec 21, 2024 at 01:23:38AM +0000, Ihor Solodrai wrote:
> Multithreading is now contained in dwarf_loader.c, and is implemented
> using a jobs queue and a pool of worker threads. As a consequence,
> multithreading-related code is removed from pahole.c.
> 
> A single-thread special case is removed: queueing setup works fine
> with a single worker, which will switch between jobs as appropriate.
> 
> Code supporting previous version of the multithreading, such as
> cu_state, thread_data and related functions, is also removed.
> 
> reproducible_build flag is now moot: the BTF encoding is always
> reproducible with these changes.
> 
> The goal outlined in the RFC [1] - making parallel reproducible BTF
> generation as fast as non-reproducible - is achieved by implementing
> the requirement of ordered CU encoding (stealing) directly in the job
> queue in dwarf_loader.c
> 
> The synchronization in the queue is implemented by a mutex (which
> ensures consistency of queue state) and a job_added condition
> variable. Motivation behind using condition variables is a classic
> one: we want to avoid the threads checking the state of the queue in a
> busy loop, competing for a single mutex.
> 
> In comparison to the previous version of this patch [2], job_taken
> condition variable is removed. The number of decoded CUs in memory is
> now limited by initial JOB_DECODE jobs. The enqueue/dequeue interface
> is changed aiming to reduce locking. See relevant discussion [3].

So I'm running tests/tests after each of these patches and at this point
I got:

root@number:/home/acme/git/pahole# tests/tests
  1: Validation of BTF encoding of functions; this may take some time: grep: /tmp/btf_functions.sh.OgxoO4/dwarf.funcs: binary file matches
ERROR: mismatch : BTF 'bool evtchn_fifo_is_pending(evtchn_port_t);' not found; DWARF ''
Test data is in /tmp/btf_functions.sh.OgxoO4
  2: Default BTF on a system without BTF: Ok
  3: Flexible arrays accounting: Ok
  4: Check that pfunct can print btf_decl_tags read from BTF: Ok
  5: Pretty printing of files using DWARF type information: Ok
  6: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
/home/acme/git/pahole
root@number:/home/acme/git/pahole#

root@number:/home/acme/git/pahole# grep evtchn_fifo_is_pending /tmp/btf_functions.sh.OgxoO4/dwarf.funcs 
bool evtchn_fifo_is_pending(evtchn_port_t);
root@number:/home/acme/git/pahole# grep evtchn_fifo_is_pending /tmp/btf_functions.sh.OgxoO4/btf.funcs 
bool evtchn_fifo_is_pending(evtchn_port_t);
root@number:/home/acme/git/pahole# 

Which seems like a test artifact:

root@number:/home/acme/git/pahole# pfunct -f evtchn_fifo_is_pending /tmp/btf_functions.sh.OgxoO4/vmlinux.btf 
bool evtchn_fifo_is_pending(evtchn_port_t port);
root@number:/home/acme/git/pahole# pfunct -F btf -f evtchn_fifo_is_pending /tmp/btf_functions.sh.OgxoO4/vmlinux.btf 
bool evtchn_fifo_is_pending(evtchn_port_t port);
root@number:/home/acme/git/pahole# 

root@number:/home/acme/git/pahole# pfunct -F btf -f evtchn_fifo_is_pending /lib/modules/6.13.0-rc2/build/vmlinux
bool evtchn_fifo_is_pending(evtchn_port_t port);
root@number:/home/acme/git/pahole# pfunct -F dwarf evtchn_fifo_is_pending /lib/modules/6.13.0-rc2/build/vmlinux
bool evtchn_fifo_is_pending(evtchn_port_t port);
bool evtchn_fifo_is_pending(evtchn_port_t port);
root@number:/home/acme/git/pahole# 

Maybe because DWARF has two such functions? Alan?

But:

root@number:/home/acme/git/pahole# readelf -wi /lib/modules/6.13.0-rc2/build/vmlinux | grep -B2 -A12 evtchn_fifo_is_pending
 <2><946502d>: Abbrev Number: 0
 <1><946502e>: Abbrev Number: 128 (DW_TAG_subprogram)
    <9465030>   DW_AT_name        : (indirect string, offset: 0x39779e): evtchn_fifo_is_pending
    <9465034>   DW_AT_decl_file   : 1
    <9465034>   DW_AT_decl_line   : 206
    <9465035>   DW_AT_decl_column : 13
    <9465036>   DW_AT_prototyped  : 1
    <9465036>   DW_AT_type        : <0x9456abf>
    <946503a>   DW_AT_low_pc      : 0xffffffff81b6d330
    <9465042>   DW_AT_high_pc     : 0x65
    <946504a>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <946504c>   DW_AT_call_all_calls: 1
    <946504c>   DW_AT_sibling     : <0x946517a>
 <2><9465050>: Abbrev Number: 81 (DW_TAG_formal_parameter)
    <9465051>   DW_AT_name        : (indirect string, offset: 0x3abde1): port
root@number:/home/acme/git/pahole#

I.e. there is just one, but when pfunct prints it must be seeing some
other usage that refers back to 946502e...

root@number:/home/acme/git/pahole# readelf -wi /lib/modules/6.13.0-rc2/build/vmlinux | grep -w -B2 -A12 0x946502e
 <4><9464825>: Abbrev Number: 60 (DW_TAG_call_site)
    <9464826>   DW_AT_call_return_pc: 0xffffffff81b6d4f5
    <946482e>   DW_AT_call_origin : <0x946502e>
    <9464832>   DW_AT_sibling     : <0x946483d>
 <5><9464836>: Abbrev Number: 13 (DW_TAG_call_site_parameter)
    <9464837>   DW_AT_location    : 1 byte block: 55 	(DW_OP_reg5 (rdi))
    <9464839>   DW_AT_call_value  : 2 byte block: 7f 0 	(DW_OP_breg15 (r15): 0)
 <5><946483c>: Abbrev Number: 0
 <4><946483d>: Abbrev Number: 60 (DW_TAG_call_site)
    <946483e>   DW_AT_call_return_pc: 0xffffffff81b6d590
    <9464846>   DW_AT_call_origin : <0x9463caa>
    <946484a>   DW_AT_sibling     : <0x946485d>
 <5><946484e>: Abbrev Number: 13 (DW_TAG_call_site_parameter)
    <946484f>   DW_AT_location    : 1 byte block: 55 	(DW_OP_reg5 (rdi))
    <9464851>   DW_AT_call_value  : 2 byte block: 7f 0 	(DW_OP_breg15 (r15): 0)
--
    <9464f6b>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <9464f6d>   DW_AT_call_all_calls: 1
    <9464f6d>   DW_AT_sibling     : <0x946502e>
 <2><9464f71>: Abbrev Number: 81 (DW_TAG_formal_parameter)
    <9464f72>   DW_AT_name        : (indirect string, offset: 0x3abde1): port
    <9464f76>   DW_AT_decl_file   : 1
    <9464f76>   DW_AT_decl_line   : 212
    <9464f77>   DW_AT_decl_column : 44
    <9464f78>   DW_AT_type        : <0x9463263>
    <9464f7c>   DW_AT_location    : 0x181ea81 (location list)
    <9464f80>   DW_AT_GNU_locviews: 0x181ea79
 <2><9464f84>: Abbrev Number: 64 (DW_TAG_variable)
    <9464f85>   DW_AT_name        : (indirect string, offset: 0x9f2cd): word
    <9464f89>   DW_AT_decl_file   : 1
    <9464f89>   DW_AT_decl_line   : 214
root@number:/home/acme/git/pahole#

Not really :-\

root@number:/home/acme/git/pahole# pfunct --decl_info -F dwarf evtchn_fifo_is_pending /lib/modules/6.13.0-rc2/build/vmlinux
/* Used at: /home/acme/git/linux/drivers/xen/events/events_fifo.c */
/* <946502e> /home/acme/git/linux/drivers/xen/events/events_fifo.c:206 */
bool evtchn_fifo_is_pending(evtchn_port_t port);
/* Used at: /home/acme/git/linux/drivers/xen/events/events_fifo.c */
/* <946502e> /home/acme/git/linux/drivers/xen/events/events_fifo.c:206 */
bool evtchn_fifo_is_pending(evtchn_port_t port);
root@number:/home/acme/git/pahole#

So far I couldn't find an explanation for this oddity... Lets see if
after applying all patches we get past this.

- Arnaldo

