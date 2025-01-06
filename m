Return-Path: <bpf+bounces-47979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358C7A02DA0
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195C7167216
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC311DC759;
	Mon,  6 Jan 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ado/jRdy"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F3148316
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180368; cv=none; b=gfKAkvPs2R4xbMZY8sxBoKz7X3bao/QGYrcCIdDV2SmCnOdNtZjeCym8fScQ3Z1gSWujMcd9jx6tC2ADg0nFg+ipOUyhOsSgVbYvBzRlgp6zSyMQvovad5dZDL9OV5r3EKNuAkGZkLxwtilYieP5hfoo4rUssSQDAV3oKZQm5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180368; c=relaxed/simple;
	bh=EeDQ4RNOtH3K6faNsiclo3sW9GHA0bFobaDmyktUK/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuV98BbxmgqQmri5mD79fVUY8BJ0Vyq9PkNocrwiRvcRWazIhb33GD5z8helbS7WMqW44j40mxdvQ6nY9UlJQEnzAaEYKP6Q0Uo2i83sl04EjKBiz5SG6t6hNSk3GmhHGPYX++UWAmG+8pa+xJ8MbpkB18GBUA6jH4/mVCgTSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ado/jRdy; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uurdLwiYxeGfKFzCjTXYYNVPJvKCw1qvrF34bjdacrM=; b=ado/jRdytkskMGkViygoOaNJJW
	WrjAGG4vmRTiiVvirXVOlRxYhOl14sMtG8fO8qZB1MTddBNMdWSzQlHqpQUiGBztO9E3ifAGacj69
	m7DpPXRN5HUNR5A/qQIw50PRfmgLDHmOW8nHIZls+rnPBqsaq+La392roidk9tusDXtlMoIDHYHgf
	DTKEt7IEpETayaWmtvLYH9xk0oAVMTZqn26NCI8hgcxYm96OpLToKXMXdK/JrE98ZNQWkRpNJk2a0
	uyTrGl4rxf1XGJXQxNNT41fbtivIry8rLFeik1WFsqs+emilix4iznX9l2ethzCNS+LJOnxaH4mUh
	fb6vDk6g==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tUpp5-0009VB-3X; Mon, 06 Jan 2025 17:19:23 +0100
Received: from [178.197.248.26] (helo=[192.168.1.114])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1tUpp4-000IvY-2F;
	Mon, 06 Jan 2025 17:19:22 +0100
Message-ID: <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net>
Date: Mon, 6 Jan 2025 17:19:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] expose number of map entries to userspace
To: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>,
 aspsk2@gmail.com
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27510/Mon Jan  6 10:45:39 2025)

On 1/6/25 3:53 PM, Charalampos Stylianopoulos wrote:
> This patch series provides an easy way for userspace applications to
> query the number of entries currently present in a map.
> 
> Currently, the number of entries in a map is accessible only from kernel space
> and eBPF programs. A userspace program that wants to track map utilization has to
> create and attach an eBPF program solely for that purpose.
> 
> This series makes the number of entries in a map easily accessible, by extending the
> main bpf syscall with a new command. The command supports only maps that already
> track utilization, namely hash maps, LPM maps and queue/stack maps.

An earlier attempt to directly expose it to user space can be found here [0], which
eventually led to [1] to only expose it via kfunc for BPF programs in order to avoid
extending UAPI.

Perhaps instead add a small libbpf helper (e.g. bpf_map__current_entries to complement
bpf_map__max_entries) which does all the work to extract that info via [1] underneath?

Thanks,
Daniel

   [0] https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/
   [1] https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/
       https://lore.kernel.org/bpf/20230719092952.41202-1-aspsk@isovalent.com/

> Charalampos Stylianopoulos (4):
>    bpf: Add map_num_entries map op
>    bpf: Add bpf command to get number of map entries
>    libbpf: Add support for MAP_GET_NUM_ENTRIES command
>    selftests/bpf: Add tests for bpf_map_get_num_entries
> 
>   include/linux/bpf.h                           |  3 ++
>   include/linux/bpf_local_storage.h             |  1 +
>   include/uapi/linux/bpf.h                      | 17 +++++++++
>   kernel/bpf/devmap.c                           | 14 ++++++++
>   kernel/bpf/hashtab.c                          | 10 ++++++
>   kernel/bpf/lpm_trie.c                         |  8 +++++
>   kernel/bpf/queue_stack_maps.c                 | 11 +++++-
>   kernel/bpf/syscall.c                          | 32 +++++++++++++++++
>   tools/include/uapi/linux/bpf.h                | 17 +++++++++
>   tools/lib/bpf/bpf.c                           | 16 +++++++++
>   tools/lib/bpf/bpf.h                           |  2 ++
>   tools/lib/bpf/libbpf.map                      |  1 +
>   .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
>   tools/testing/selftests/bpf/test_maps.c       | 35 +++++++++++++++++++
>   14 files changed, 171 insertions(+), 1 deletion(-)
> 


