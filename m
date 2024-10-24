Return-Path: <bpf+bounces-43001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B909ADA18
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84433B221E9
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3AE1534EC;
	Thu, 24 Oct 2024 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OSgkoW2j"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665042A93
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737987; cv=none; b=fNELWJrWHDbDlFZw6lSYx7mAG78oymtkFmXevF20iCCpwoLN+qieGhdkiZ+WynL9D56xfhqY0BzU9KgwU2rXQlEL3ZeLMJ2JXA8Q6A1193hqWsu6rWJd3jlGiKIkK70j7LqaJO1HLbugKTG0juOCiSi+bBhAo+vb3va9ht5XnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737987; c=relaxed/simple;
	bh=gUxpCsx1FJYQ35TxTUCTzSHnfoj11eiYmuwuBfD+S5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RV9/CJqsy4d+J6b+nJM+6xfx2tHln0UKenMFyasLl8r5X/JlptjXbL/7awmgc6hjrHAAD5sl5ktMKuZmjFVnYzIZN6buPKJ+beUB3fGxfekVEwkg+6mYNQrzX1hEse1hglgaBQIfQErjENkZK4tVCJO+WjcojraBGJzUDeVUUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OSgkoW2j; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4f9b0a96-a72c-4977-982b-3da21204b81e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729737983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUxpCsx1FJYQ35TxTUCTzSHnfoj11eiYmuwuBfD+S5A=;
	b=OSgkoW2jfaJ1SdJmzkcmnC+TOG525g3L7eXwHLg0OPXGx5v32FHEBA7BGzPq1t6BWoP28/
	LJeeLbam/MRIOWo8hE3jtJNGxiV4mP5MIJkz/+FYuLfap6UT2/riBgW2tx1Bz2TRKbfO7j
	U+fUqG8JBjRec4LiRXUTaNJDNrZJe68=
Date: Wed, 23 Oct 2024 19:46:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpf, verifier: Check trampoline target is
 tail_call_reachable subprog
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 jolsa@kernel.org, eddyz87@gmail.com, kernel-patches-bot@fb.com
References: <20241021133929.67782-1-leon.hwang@linux.dev>
 <20241021133929.67782-3-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241021133929.67782-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/21/24 6:39 AM, Leon Hwang wrote:
> In the x86_64 JIT, tailcall info is propagated through the trampoline when
> the target program is tail_call_reachable. However, this propagation is
> unnecessary if the target is a main prog, or a subprog that is not
> tail_call_reachable.
>
> Since the verifier can determine if a subprog is tail_call_reachable, it
> should only propagate tailcall info when the target is subprog and the
> subprog is actually tail_call_reachable.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Looks correct to me.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


