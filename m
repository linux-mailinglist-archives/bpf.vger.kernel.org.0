Return-Path: <bpf+bounces-13321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1279D7D8403
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 15:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A341C20EF4
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793282E412;
	Thu, 26 Oct 2023 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QdAlcZEz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3CE2E3F5;
	Thu, 26 Oct 2023 13:56:33 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247381AC;
	Thu, 26 Oct 2023 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sMThpqpjcTZ2BuelHwVofI04AeiqSgR0HeOTEnD3g1w=; b=QdAlcZEz5eFS+4jb+7a6UcPNTa
	nX0bYaLWA/pVGF0r1CEvYZRUPPhM8dvn84r89shthdc4SXu+YPieWS9/ZsIAKS6jN1XuyzErR4wbT
	PI4xDXVYOZWDlrxlo0hBvwdX0l7+V6b6Z+ov1Gnk/6+Sau999ghSSJ+TQwruRxYDDeZyTDxY1MgQF
	Q6QmftlyMLaUAvNkxXEipl4OolAgYpGFmofADUPTBqhC05r+hgJjvoUm8PspbUvbfIml5iCeAxujG
	ahC0pUqaP5SUL1YFqNfsr/ROlKRIREZKvSUWiAy02Vwbuljt5mZF0EYiZGh//0ZnO2h7jSa0ihoDS
	zM21ao2A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qw0qK-000CDQ-6P; Thu, 26 Oct 2023 15:56:12 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qw0qJ-0000Iv-CC; Thu, 26 Oct 2023 15:56:11 +0200
Subject: Re: [PATCH bpf-next v6 0/7] add BPF_F_PERMANENT flag for sockmap
 skmsg redirect
To: John Fastabend <john.fastabend@gmail.com>, Liu Jian
 <liujian56@huawei.com>, jakub@cloudflare.com, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20231014121706.967988-1-liujian56@huawei.com>
 <65383d6f3d15c_1969a2084a@john.notmuch>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6e117922-e249-37cf-2327-55355de200e2@iogearbox.net>
Date: Thu, 26 Oct 2023 15:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <65383d6f3d15c_1969a2084a@john.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27073/Thu Oct 26 09:47:53 2023)

On 10/24/23 11:55 PM, John Fastabend wrote:
> Liu Jian wrote:
>> v5->v6: Modified the description of the helper function.
>> v4->v5: Fix one refcount bug caused by patch1.
>> v3->v4: Change the two helpers's description.
>> 	Let BPF_F_PERMANENT takes precedence over apply/cork_bytes.
>>
>> Liu Jian (7):
>>    bpf, sockmap: add BPF_F_PERMANENT flag for skmsg redirect
>>    selftests/bpf: Add txmsg permanently test for sockmap
>>    selftests/bpf: Add txmsg redir permanently test for sockmap
>>    selftests/bpf: add skmsg verdict tests
>>    selftests/bpf: add two skmsg verdict tests for BPF_F_PERMANENT flag
>>    selftests/bpf: add tests for verdict skmsg to itself
>>    selftests/bpf: add tests for verdict skmsg to closed socket
>>
>>   include/linux/skmsg.h                         |   1 +
>>   include/uapi/linux/bpf.h                      |  45 +++++--
>>   net/core/skmsg.c                              |   6 +-
>>   net/core/sock_map.c                           |   4 +-
>>   net/ipv4/tcp_bpf.c                            |  12 +-
>>   tools/include/uapi/linux/bpf.h                |  45 +++++--
>>   .../selftests/bpf/prog_tests/sockmap_basic.c  | 122 ++++++++++++++++++
>>   .../selftests/bpf/progs/test_sockmap_kern.h   |   3 +-
>>   .../bpf/progs/test_sockmap_msg_verdict.c      |  25 ++++
>>   tools/testing/selftests/bpf/test_sockmap.c    |  41 +++++-
>>   10 files changed, 272 insertions(+), 32 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c
>>
> 
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>

Looks like this needs one last rebase, doesn't apply against bpf-next:

Switched to a new branch 'mbox'
Applying: bpf, sockmap: Add BPF_F_PERMANENT flag for skmsg redirect
Applying: selftests/bpf: Add txmsg permanently test for sockmap
Applying: selftests/bpf: Add txmsg redir permanently test for sockmap
Applying: selftests/bpf: Add skmsg verdict tests
error: patch failed: tools/testing/selftests/bpf/prog_tests/sockmap_basic.c:475
error: tools/testing/selftests/bpf/prog_tests/sockmap_basic.c: patch does not apply
Patch failed at 0004 selftests/bpf: Add skmsg verdict tests
hint: Use 'git am --show-current-patch' to see the failed patch

Thanks,
Daniel

