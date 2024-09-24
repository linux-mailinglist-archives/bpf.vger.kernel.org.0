Return-Path: <bpf+bounces-40261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5D98480E
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 16:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD5F1F21922
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB01AB6C3;
	Tue, 24 Sep 2024 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TFiKW8rh"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DBC1AB531
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189590; cv=none; b=hO7fsq8FJkMcrZvqvhFtUBGgfduvdbGnqBrKP5dWmwvh7sSCQ9VSmSKpKh3cvz+LU+6rRPdkj2HHvZZfDcJD5AkUQrAQ1bDYeflmvO4ku9H0MmrTOf4EXVTbMFrohLu6Bk03sIk+XDqodPhlMU6X/X3iAI5rbjGawb6FDcvTdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189590; c=relaxed/simple;
	bh=CubQclvvGkbM0d/57YfqiAOxGFsqdMKqbn/8WacHJJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uxuOWHF9AqUsxR+Z/O/C6CdZQhbQSkMb9O3eYfJ1icU4BQH4nss351S91zTo7hcSwyrNTqYl7EsRDAdKsCZLav3sz29l8ROqGGO7sAyQKWihOI1n4r8SNBpybzAgDbcJM0xT0/ykT3PDWzeB0hWNgvfWeBbN3ZgLFdlyzRCTUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=TFiKW8rh; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=e1CDiktRKpFgo8y6t/bkMNT7v8iVO1WEgVLL0z0y5LU=; b=TFiKW8rhjL6pd0QBV9W7HrS5X7
	sd+NikhDPXRgz+X4kDGqRK2D+yk/7QV9Ubvisal7Q+PO+kdhz33fSR1V9MsP9alPRQfjF8wljzIt7
	QwMNhrRQ7sV5qOahRsHuzHxcwkpR3iORJp6cUxVfNTz3sBdls7Fpa9zUHvAad7b7hVlV2MmFrp9//
	e/L5Ek8yZrRypkBHUocTtEbYh1j/MhGxDAyedi4NQtUl0zkIxNhuCIyYPRIZArqZbh1Rt3Cbt2W3u
	HlAVyV2SF5QbQJtKYV9iaC9J37M5M/r2JqwSGR45RxhqqK3bvS4CXTyYDbeYHAV2gCwK7k8Ej/syb
	3WWyZVKA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1st6uW-000BzX-SK; Tue, 24 Sep 2024 16:53:04 +0200
Received: from [178.197.249.54] (helo=[192.168.1.114])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1st6uW-000MiZ-1m;
	Tue, 24 Sep 2024 16:53:04 +0200
Message-ID: <a3eb28eb-42b3-4ac8-bffb-551422eba96e@iogearbox.net>
Date: Tue, 24 Sep 2024 16:53:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Good first-time BPF tasks
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
References: <3xru56ozvb4mrphuqt53tvbsiv3n3wfcknme663zcxefayx3re@oq5xnb3o3fec>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <3xru56ozvb4mrphuqt53tvbsiv3n3wfcknme663zcxefayx3re@oq5xnb3o3fec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27408/Tue Sep 24 10:34:28 2024)

On 9/21/24 8:41 PM, Shung-Hsi Yu wrote:
> A topic that came up several times off-list at LPC was how to start
> contributing to the BPF subsystem. One of the thing that would probably help
> is to have a list of todos that are nice to have and can be implemented in a
> relatively self-contained set of patches. Here's things that I've gathered.
>
> On the more concrete task sides (easy to hard):
>
> - Check return value of btf__align_of() in btf_dump_emit_struct_def()
> - Replace open-coded & PTR_MAYBE_NULL checks with type_may_be_null()
> - Implement tnum_scast(), and use that to simply var_off induction in
>    coerce_reg_to_size_sx()
> - Better error message when BTF generation failed, or at least fail earlier
> - Refactor to use list_head to create a linked-list of bpf_verifier_state
>    instead of using bpf_verifier_state_list
>
> On the more general side of things:
>
> - Improve the documentation
>    - add the missing pieces (e.g. document all BPF_PROG_TYPE_*)
>    - update the out-date part (admittedly quite hard)
> - Improve the BPF selftests coverage
>    - add test for fixes that have been merged but does not come with a
>      corresponding test case to prevent regression
Great list, thanks for compiling! I'd also add:

- Triaging & fixing open syzbot issues: 
https://syzkaller.appspot.com/upstream/s/bpf
- Converting BPF selftests into test_progs style for tests which 
currently can only
   be run standalone. Once converted, the old ones can be removed.
- Converting BPF samples to BPF selftests into test_progs style. Same, 
once converted
   the old BPF samples should be removed.
> I want to keep the list from being too verbose, so I won't go into too
> much detail in this email. But feel free to reply to this thread and
> ask. You might want to use https://github.com/sjp38/hackermail to reply
> if you're not familiar with mailing lists.
> (I know mailing list don't have the best UX, is a scary place, and also
> not the best issue tracker, we'll see how this works out and change if
> needed)
>
> Also If anyone has other things they want to add to the list that will
> be great.
>
> The most probably outcome is nobody replies, and I stop doing this after
> a few months. But still, worth a try and the only thing that gets hurt
> in this process is my ego ;)
>
> ---
>
> Expectations
>
>    You should have a relatively solid idea about C (pointers, memory
>    layout, undefined behavior, etc.). That is not to say you cannot make
>    any mistake (we all do), just that mailing list is not the best place
>    to receive an entire lecture on C.
>
>    Personally I would also recommend to familiar yourself on open source
>    contribution, elsewhere first.
>
>    You will be doing 99% of the work and have to spend a great deal of
>    time reading code to try understand how things works before you can
>    write you first line of code, and at that point you're probably only
>    10% done.
>
> Disclaimer
>
>    Maintainers have the final say on whether things gets merged or not.
>    And Sometimes things that seems like a good idea at first may turnout
>    to be undesired; so there's no guarantee that all the hard work you
>    poured in will land. Additionally the task may turned out to have
>    hidden complexity, making it a not so good first time task, but only
>    to be know afterwards.
>
> Resources
>
> - Introduction to BPF selftests
>    https://lore.kernel.org/bpf/62b54401510477eebdb6e1272ba4308ee121c215.camel@gmail.com/
>

