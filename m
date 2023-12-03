Return-Path: <bpf+bounces-16533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3880211C
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 06:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969551C208FE
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 05:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B6E138C;
	Sun,  3 Dec 2023 05:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="i6U+zlgg";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Y+3O8AGh"
X-Original-To: bpf@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDDA129;
	Sat,  2 Dec 2023 21:32:39 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 9C6A6C021; Sun,  3 Dec 2023 06:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701581557; bh=4XeSfoq2jrYwORx7N64kjWetZ9wO0riIgKtZAzPPkSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6U+zlggXxuVgMFX8dXJCjSMuHOuQSznPL/usg5POlNZIGHm4JrEoEXkztU66v73x
	 asx4pNnVByMJGKBkFsTo+HLXYAruP5HcVXzCLBTG25nvEXCnUJYbdOQekl4uAzDOAZ
	 YOsEe7TEdc/XOkth+rebgWlIYLIpeFOQ60rgWjA0Qo9XkWqCXVVmH2Ut9YOmPE9V53
	 3/4C7fejkOzT9G0Qe0q2AbvVRh83TEgcaUo5LLXHmcMd1dIgmnGebLwLdeeHAwJZ6n
	 9P87qxnzFF1I48ePaSJ+RbwIdhAvlgUKEmiz7qOE7cn5i7Z4kX2RMPsFozMfsBSOB7
	 6HwTPDTFhInuA==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 96F04C009;
	Sun,  3 Dec 2023 06:32:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701581556; bh=4XeSfoq2jrYwORx7N64kjWetZ9wO0riIgKtZAzPPkSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+3O8AGhwreueTIV8zNxAtvF7e9/saCRLGlIFbRr3b9T0PDFr4sBHVC3Gg7+5DHzj
	 MLSD0Q+1PupduGZ2J9Z4A2i2PdmlXsm/gyJqiApu6QtaxHdCie9x11amPvxPtfOQve
	 N5ynCV84qeEiALH6iD9WUG0buYhmAzS2CoMUih0pffPtm7WEKaSE2De3GoSV7ZUQlI
	 pFn90tlJB94qUq/YHWrHpRfkrqOBev7dSB/ehN3PzZdZJunFOVqokKeBKbTjFAikAI
	 YkqdBPOirBum9LC2dIxDq00/caKNYy1O1B3ILD4iawhveRijIwJQYutBOH+xW6qKPW
	 ObNmoFCNGg9CA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 620b53e6;
	Sun, 3 Dec 2023 05:32:30 +0000 (UTC)
Date: Sun, 3 Dec 2023 14:32:15 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	JP Kobryn <inwardvessel@gmail.com>, ericvh@kernel.org,
	lucho@ionkov.net, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, v9fs@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Message-ID: <ZWwS3_DGmqc73dxm@codewreck.org>
References: <20231202030410.61047-1-inwardvessel@gmail.com>
 <ZWq0BvPGYMTi-WfC@codewreck.org>
 <1881630.VfuOzHrogK@silver>
 <20231202201409.10223677@rorschach.local.home>
 <ZWva7DYTPUG95xv8@codewreck.org>
 <20231202231524.4ce1d342@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231202231524.4ce1d342@gandalf.local.home>

Steven Rostedt wrote on Sat, Dec 02, 2023 at 11:15:24PM -0500:
> > Also, for custom tracepoints e.g. bpftrace the program needs to know how
> > many bytes can be read safely even if it's just for dumping -- unless
> > dynamic_array is a "fat pointer" that conveys its own size?
> > (Sorry didn't take the time to check)
> 
> Yes, there's also a __get_dynamic_array_len(line) that will return the
> allocated length of the line. Is that what you need?

Yes, thanks! So the lower two bytes of the field are its position in
the entry and the higher two bytes its size; ok.
It doesn't look like bpftrace has any helper for it but that can
probably be sorted out if someone wants to dump data there.


Let's update the event to use a dynamic array and have printk fomrat to
use %*ph with that length.

JP Kobryn, does that sound good to you? I'm not sure what you were
trying to do in the first place.
Do you want to send a v2 or shall I?

-- 
Dominique Martinet | Asmadeus

