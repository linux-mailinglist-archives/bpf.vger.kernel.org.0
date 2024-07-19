Return-Path: <bpf+bounces-35094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1439937A1A
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F071C217F3
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C37145B00;
	Fri, 19 Jul 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="YJr1nOSo"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56F2CA6;
	Fri, 19 Jul 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403938; cv=none; b=ETIK53DIAUvFqnguk6tIMJAG2SX6IOKtZMqW9LovpvF20xRL/UkRxE+HBu1R56NuCUSmwtLrpRHkjx4h+355IiwaczfgjvOxenKIwBDnHUIN8S3q55bpXmXOMoO/tS5YBQKig6dEqQL6Bf1GzTFzCspQDwdj8NQgi1DCAKpnO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403938; c=relaxed/simple;
	bh=aWfH3R4MiL++K3YzagkgVbHuFbEmc/MzPp6wHWjOh98=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Af1lziM46A83UTFEwBR99WuSHV0cCkAdXELVpITtt/fYcWxYbbbVuDZyGFeFpTTUuu6WT5K0HLX9lE3N4PmpMWIyORQjrMr6tYdn3d647sObVPg49w3N3KbXRz7E5Wt7+ZvddAazanhJx+pbwUOoXtUzzNLbjfn0bMQ7VNKn8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=YJr1nOSo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mfYFf7GE5z0Tq9AF/8xA+3g4U54Lu6kBPGvQaa7IoLA=; b=YJr1nOSoFS+j+VYwjxtuDmeUA4
	dWYtwB5iO3nfKF+1wDA5KCIJRCCsCZ2t0kYlvMqW1yKHySTF1e2lh/l9/liUoPGKVDTfH76wUqn4B
	fjKTxK/X6m6S6XUjitzU0Ea03tiKapoo0MV44HfStBotk4rJ6doxdxrPpoN1fFbsfpYg4mXfE9imQ
	q2Lf/t4Ykd7jC4EaGRqcpX1VfPpqxAjwTu+gY40mRsPujp6bX3pBBCVe7w1idiFTzLkhsCJWG5j4E
	9QX1H1XKD2z1AL2S7eGMMRc9DBR15OYTmdDqSEIqUAo0KEHQQVHmpDQ2JfqSAil7BjLpdcQPtPkOT
	7x/69MHA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUpnY-0009X3-8z; Fri, 19 Jul 2024 17:45:32 +0200
Received: from [178.197.248.43] (helo=linux-2.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUpnX-000HQA-1F;
	Fri, 19 Jul 2024 17:45:31 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: fix compilation failure when
 CONFIG_NET_FOU!=y
To: Artem Savkov <asavkov@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240718143122.2230780-1-asavkov@redhat.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <005ef8ac-d48e-304f-65c5-97a17d83fd86@iogearbox.net>
Date: Fri, 19 Jul 2024 17:45:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240718143122.2230780-1-asavkov@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27341/Fri Jul 19 10:28:50 2024)

Hi Artem,

On 7/18/24 4:31 PM, Artem Savkov wrote:
> Without CONFIG_NET_FOU bpf selftests are unable to build because of
> missing definitions. Add ___local versions of struct bpf_fou_encap and
> enum bpf_fou_encap_type to fix the issue.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>

This breaks BPF CI, ptal:

https://github.com/kernel-patches/bpf/actions/runs/9999691294/job/27641198557

   [...]
     CLNG-BPF [test_maps] btf__core_reloc_existence___wrong_field_defs.bpf.o
     CLNG-BPF [test_maps] verifier_bswap.bpf.o
     CLNG-BPF [test_maps] test_core_reloc_existence.bpf.o
     CLNG-BPF [test_maps] test_global_func8.bpf.o
     CLNG-BPF [test_maps] verifier_bitfield_write.bpf.o
     CLNG-BPF [test_maps] local_storage_bench.bpf.o
     CLNG-BPF [test_maps] verifier_runtime_jit.bpf.o
     CLNG-BPF [test_maps] test_pkt_access.bpf.o
   progs/test_tunnel_kern.c:39:5: error: conflicting types for 'bpf_skb_set_fou_encap'
      39 | int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
         |     ^
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107714:12: note: previous declaration is here
    107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap, int type) __weak __ksym;
           |            ^
   progs/test_tunnel_kern.c:41:5: error: conflicting types for 'bpf_skb_get_fou_encap'
      41 | int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
         |     ^
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107715:12: note: previous declaration is here
    107715 | extern int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap) __weak __ksym;
           |            ^
     CLNG-BPF [test_maps] verifier_typedef.bpf.o
     CLNG-BPF [test_maps] user_ringbuf_fail.bpf.o
     CLNG-BPF [test_maps] verifier_map_in_map.bpf.o
   progs/test_tunnel_kern.c:782:35: error: incompatible pointer types passing 'struct bpf_fou_encap___local *' to parameter of type 'struct bpf_fou_encap *' [-Werror,-Wincompatible-pointer-types]
     782 |         ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE___local);
         |                                          ^~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107714:83: note: passing argument to parameter 'encap' here
    107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap, int type) __weak __ksym;
           |                                                                                   ^
   progs/test_tunnel_kern.c:819:35: error: incompatible pointer types passing 'struct bpf_fou_encap___local *' to parameter of type 'struct bpf_fou_encap *' [-Werror,-Wincompatible-pointer-types]
     819 |         ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_FOU___local);
         |                                          ^~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107714:83: note: passing argument to parameter 'encap' here
    107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap, int type) __weak __ksym;
           |                                                                                   ^
   progs/test_tunnel_kern.c:841:35: error: incompatible pointer types passing 'struct bpf_fou_encap___local *' to parameter of type 'struct bpf_fou_encap *' [-Werror,-Wincompatible-pointer-types]
     841 |         ret = bpf_skb_get_fou_encap(skb, &encap);
         |                                          ^~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107715:83: note: passing argument to parameter 'encap' here
    107715 | extern int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap) __weak __ksym;
           |                                                                                   ^
   5 errors generated.
     CLNG-BPF [test_maps] verifier_bounds_deduction.bpf.o
     CLNG-BPF [test_maps] test_netfilter_link_attach.bpf.o
     CLNG-BPF [test_maps] verifier_jeq_infer_not_null.bpf.o
   make: *** [Makefile:654: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/test_tunnel_kern.bpf.o] Error 1
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

