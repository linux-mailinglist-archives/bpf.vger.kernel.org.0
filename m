Return-Path: <bpf+bounces-15779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522027F691F
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 23:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4346CB20E7D
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 22:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE9F3399F;
	Thu, 23 Nov 2023 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="iYFYrfax"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A0D50
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 14:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2c3wg12LhdiVkH+Q+2pqlFM5vGeT5lV3abSHoh4IGPI=; b=iYFYrfax34tgT9bW7uvjmzKcAS
	6Rp4Hvh/AYtC0idTsYAhIsNVpFH7c7Z8JHnR7IU+q8AU7sxy4onDTOXWlRxcEs3TWaXrYKd0KdDpQ
	5CSoFFIyKswum/jww5GS/z8onkpGVoAksg1YVdRxkAp1no+s9EWSjqW+g1EnHp+BbZ8Pjt8/epN27
	9PoNz/bw9Mkv+iyFFIGWCKBlxrRi4zhLIYEcWQRpgiY9ma3YFwERjZwnDHJGZqSuRMADQylYv8eSD
	a8EQjHs3OIUGIwp0D68rneqIDDHBwVgz04C0VBBefcC3l8yiJD5arXCkn70tDzSlei2HGXQBAFYcy
	AODdpdTA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r6IUP-000IHQ-PA; Thu, 23 Nov 2023 23:48:05 +0100
Received: from [178.197.249.24] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r6IUP-000GEb-5K; Thu, 23 Nov 2023 23:48:05 +0100
Subject: Re: [PATCH bpf-next 0/3] Verify global subprogs lazily
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20231122213112.3596548-1-andrii@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0117ddb8-4251-c4a1-1bb0-ca19769bd6b3@iogearbox.net>
Date: Thu, 23 Nov 2023 23:48:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231122213112.3596548-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27102/Thu Nov 23 09:42:42 2023)

On 11/22/23 10:31 PM, Andrii Nakryiko wrote:
> See patch #2 for justification. In few words, current eager verification of
> global func prevents BPF CO-RE approaches to be applied to global functions.
> 
> Patch #1 is just a nicety to emit global subprog names in verifier logs.
> 
> Patch #3 adds selftests validating new lazy semantics.
> 
> Andrii Nakryiko (3):
>    bpf: emit global subprog name in verifier logs
>    bpf: validate global subprogs lazily
>    selftests/bpf: add lazy global subprog validation tests
> 
>   include/linux/bpf.h                           |  2 +
>   kernel/bpf/verifier.c                         | 88 ++++++++++++++----
>   .../selftests/bpf/prog_tests/verifier.c       |  2 +
>   .../selftests/bpf/progs/test_global_func12.c  |  4 +-
>   .../bpf/progs/verifier_global_subprogs.c      | 92 +++++++++++++++++++
>   .../bpf/progs/verifier_subprog_precision.c    |  4 +-
>   6 files changed, 168 insertions(+), 24 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_subprogs.c

Series looks good to me, ACK. It needs a rebase however after the fast
forward of the bpf-next tree from today.

 > With BPF CO-RE approach, the natural way would be to still compile BPF
 > object file once and guard calls to this global subprog with some CO-RE
 > check or using .rodata variables. That's what people do to guard usage
 > of new helpers or kfuncs, and any other new BPF-side feature that might
 > be missing on old kernels.

I was wondering for selftests, could we also add something similar to the
above to guard calls via co-re? Just to have this use-case covered in CI.
Also perhaps one global_bad function which is dead-code would be nice to
have.

Thanks,
Daniel

