Return-Path: <bpf+bounces-51583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78900A3659F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DF2189466F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00901268C45;
	Fri, 14 Feb 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2gEnU4A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784836FC5
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557172; cv=none; b=VRAU4GMdeCoY1WpLhi9N0mkPjcKnKsb6JMErK8WiCONWEcC6Tib6dv1z2O+5m5ciJ2yC8yka32XhucuS9W4MQDKx/LXDDo/kNV8LOGvTIBjUwCYAIng4PqXvyzD6zB6uFp36BVe4hTqv8YuzWiu5QPnpy266oRi7s7ArsVBsulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557172; c=relaxed/simple;
	bh=gaW3JTzjB+cccj+oTV9GRAHnhsrffAC4Rz6Q8vLJBiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfbX4eke9U1E64FbotdVTOsOb6LKYCpzObrK7GmMkS+Ap8SxhRM/f5NcGtFjm+ujOSvm4ae+CMDzTDT8lAwnQeez85v4QGLuc8nsuSDMwaPJjhHChEf5Vk1tOsNGaCusFyCir6pwRP4LuoVnlc5/tuqcYMCv7bzl8Eyf7U03+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2gEnU4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54612C4CED1;
	Fri, 14 Feb 2025 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739557171;
	bh=gaW3JTzjB+cccj+oTV9GRAHnhsrffAC4Rz6Q8vLJBiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2gEnU4AEgmfrQpeHHEyUw2P59011ccgjQAJ9Hy+tDJBPoE0TKmixQ4kMjJ9cgS9I
	 PXKEF/10lIdZysj/r7Cq5PeEiYzjlraKJqihl1VWocGMPHpK1u9wFUcGQ1cS8a6u6c
	 yA2sUFRtyxHwkGwdLJqqVj7UnjruwPZSaTGqvht8Dp1rHuGLYXCz5eR2YW1ChFyJYV
	 +U1SCoEL05/D8IVRpXz7zWGQz5JIATAFCqjbD8Ybo127rQoUpdmv/7hrjWp35MMCGq
	 YGHfblGZVmII8poRH8Z6kCFKwx9esoJbIgPrVf+wu3Rp/otE4iiJ8zmDZhaniGrHY8
	 kBCzwB1gJPhWg==
Date: Fri, 14 Feb 2025 10:19:29 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common
 location
Message-ID: <20250214181929.byldjbifehp3gcxm@jpoimboe>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
 <20250211023359.1570-2-laoar.shao@gmail.com>
 <50d8dd8af3822f63f1a13230e6fa77998f0b713d.camel@gmail.com>
 <20250211161122.ncnrwinacslvyn6k@jpoimboe>
 <20250214104800.GI21726@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214104800.GI21726@noisy.programming.kicks-ass.net>

On Fri, Feb 14, 2025 at 11:48:00AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 11, 2025 at 08:11:22AM -0800, Josh Poimboeuf wrote:
> 
> > Also, for objtool we could use something based on your program to
> > autogenerate noreturns.h.  Only problem is, objtool doesn't currently
> > have a dependency on CONFIG_DEBUG_INFO.  Another option we've considered
> > is compiler annotations (or compiler plugins).
> 
> But we don't need to re-generate the file on every build, right? We can
> have every DBUG_INFO build verify the file is still complete.

Hm, yeah we could do that.  It's still not ideal, as a human now has to
go fix those warnings...

But it's probably better than the current situation.

-- 
Josh

