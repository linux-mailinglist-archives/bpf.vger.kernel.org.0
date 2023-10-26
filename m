Return-Path: <bpf+bounces-13322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04F77D8428
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53B6B21301
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED46D2E41C;
	Thu, 26 Oct 2023 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JNuBljLi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F602E3EE;
	Thu, 26 Oct 2023 14:02:12 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F68C0;
	Thu, 26 Oct 2023 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UuBw2RdVYRecygxz7mCtFVaE9apscBTPNEdR2uAJE/o=; b=JNuBljLiMmdBtW7b9VEBgFXZOC
	zYOPY4tGIcTtPSUYukjwRJrLwBUH+4rNRQsRhi5giGgGjtviXttaM0C5/MkcCX9gzZ8Dl2fZ5NkIj
	7Rqs5tOzaFRY7suA1blT1Ojl/3tOnMtf6wFMHIYNUNAelLjyekn9ZtYTTcDw906Yr64+O8gFaj/j4
	c+6wcIeqUZD8bTTtT3f+AZ3Df0O1X5qgV0ZJoJwOptd2k5v0C2HUlSDSA0MslsIgb3G0mlvNgyV+4
	efsYnTCoNeB3AbVytJABGza0rpwJaGDjUzECwcz0mmyHYfVVbGcxz3HzE1BoWnFkGBEo3wukWvIuA
	/+Bajtcg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qw0w0-000CyV-GU; Thu, 26 Oct 2023 16:02:04 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qw0w0-000ClJ-4i; Thu, 26 Oct 2023 16:02:04 +0200
Subject: Re: [PATCH bpf-next 2/2] selftests: bpf: crypto skcipher algo
 selftests
To: Vadim Fedorenko <vadfed@meta.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20231026015938.276743-1-vadfed@meta.com>
 <20231026015938.276743-2-vadfed@meta.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d7f21ccf-a866-53e1-4de9-e1cc972edaed@iogearbox.net>
Date: Thu, 26 Oct 2023 16:02:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231026015938.276743-2-vadfed@meta.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27073/Thu Oct 26 09:47:53 2023)

On 10/26/23 3:59 AM, Vadim Fedorenko wrote:
> Add simple tc hook selftests to show the way to work with new crypto
> BPF API. Some weird structre and map are added to setup program to make
> verifier happy about dynptr initialization from memory. Simple AES-ECB
> algo is used to demonstrate encryption and decryption of fixed size
> buffers.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>   tools/testing/selftests/bpf/config            |   1 +
>   .../selftests/bpf/prog_tests/crypto_sanity.c  | 129 +++++++++++++++
>   .../selftests/bpf/progs/crypto_common.h       |  98 +++++++++++
>   .../selftests/bpf/progs/crypto_sanity.c       | 154 ++++++++++++++++++
>   4 files changed, 382 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
>   create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
>   create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 02dd4409200e..2a5d6339831b 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -14,6 +14,7 @@ CONFIG_CGROUP_BPF=y
>   CONFIG_CRYPTO_HMAC=y
>   CONFIG_CRYPTO_SHA256=y
>   CONFIG_CRYPTO_USER_API_HASH=y
> +CONFIG_CRYPTO_SKCIPHER=y
>   CONFIG_DEBUG_INFO=y
>   CONFIG_DEBUG_INFO_BTF=y
>   CONFIG_DEBUG_INFO_DWARF4=y

Quick note: for upstream CI side, more config seems missing, see the GHA failure:

https://github.com/kernel-patches/bpf/actions/runs/6654055344/job/18081734522

Notice: Success: 435/3403, Skipped: 32, Failed: 1
Error: #64 crypto_sanity
   Error: #64 crypto_sanity
   test_crypto_sanity:PASS:skel open 0 nsec
   test_crypto_sanity:PASS:ip netns add crypto_sanity_ns 0 nsec
   test_crypto_sanity:PASS:ip -net crypto_sanity_ns -6 addr add face::1/128 dev lo nodad 0 nsec
   test_crypto_sanity:PASS:ip -net crypto_sanity_ns link set dev lo up 0 nsec
   test_crypto_sanity:PASS:crypto_sanity__load 0 nsec
   open_netns:PASS:malloc token 0 nsec
   open_netns:PASS:open /proc/self/ns/net 0 nsec
   open_netns:PASS:open netns fd 0 nsec
   open_netns:PASS:setns 0 nsec
   test_crypto_sanity:PASS:open_netns 0 nsec
   test_crypto_sanity:PASS:if_nametoindex lo 0 nsec
   test_crypto_sanity:PASS:crypto_sanity__attach 0 nsec
   test_crypto_sanity:PASS:skb_crypto_setup fd 0 nsec
   test_crypto_sanity:PASS:skb_crypto_setup 0 nsec
   test_crypto_sanity:PASS:skb_crypto_setup retval 0 nsec
   test_crypto_sanity:FAIL:skb_crypto_setup status unexpected error: -95 (errno 2)
   libbpf: Kernel error message: Parent Qdisc doesn't exists
   close_netns:PASS:setns 0 nsec
Test Results:
              bpftool: PASS
  test_progs-no_alu32: FAIL (returned 1)
             shutdown: CLEAN
Error: Process completed with exit code 1.

