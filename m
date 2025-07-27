Return-Path: <bpf+bounces-64461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE63B130EC
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 19:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609AE1895D65
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D80C2206B2;
	Sun, 27 Jul 2025 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WU3f25Wn"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE41D88D0;
	Sun, 27 Jul 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753637404; cv=none; b=L7vqh5PDrfB767jBtItGuaYy7k0MaDJhjMYk8MZzMhPDTH/yNkB+LJwgd4dQKzYMznHOR8sjAoV68vkT2qAupI4zM1VjAuij0TE8E9NC2X/8ylaOjozUMqDeJY8Oi1cDvsTqYsdfKgzhNVGcIPpxScGgPphD7zB0kKZ9MrgmHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753637404; c=relaxed/simple;
	bh=YN4OUMEmYYlsvg3YJWY6SJd2TltixNw6QFJIBCSUVNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewFAfT9vzMvsoJTqIm5J1Hd3LIhRgYqvMsOoyiX+wVR0EL035swTjuAE2KVUSZD2ODtZ6DQX+K1LTgQinAKKnUtSo5T0hUnQ5AOvkccc0gp5r16yiV4YnDXIjOIog1R+xDXL6aIjR6+UoL4raa6I669cROy+cOy3kUFVJBdHS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WU3f25Wn; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LyRwSo6shZlwP9Bgfh1wxu4NA1objl4EP4vyfCXNCPI=; b=WU3f25WniMySsz82S2k2K/Z/lT
	auUGAjSv7EWRJIxDjirhtvu0WDt6OOO24M7iHBIe+J9M6NjCLdiHOvbngsoPQMVofE8YwmuASiZ6Z
	IKTpLS8uLY2MpL6U+T1lWIBo+5yn4wozM0kb9dtGdZu++vqafN20nh5lgUvGHwcLuEBj7azUIRaGP
	yLmPQGzJGvglVSIjvFMeL76BVmGsISyXsW3d6JRdV+IS9x8dOPszy11cczi4eJZnsDS4OYoWeMgmj
	f5qa5PLAq3lrl3D1EbBYcgTozLKfLQlswkcCtDiE9bVcePh40ncichPGLt60BiUwNHBq+0TNcdgrE
	tMcO2v2w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ug5C6-000FGM-1S;
	Sun, 27 Jul 2025 19:29:54 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1ug5C4-000E4z-3D;
	Sun, 27 Jul 2025 19:29:53 +0200
Message-ID: <c3eff304-8dd3-418d-afa9-eaf91020c535@iogearbox.net>
Date: Sun, 27 Jul 2025 19:29:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next 1/1] powerpc64/bpf: Add jit support for
 load_acquire and store_release
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, puranjay@kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Naveen N Rao <naveen@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 lkmm@lists.linux.dev
References: <20250717202935.29018-1-puranjay@kernel.org>
 <20250717202935.29018-2-puranjay@kernel.org> <mb61pfreuy1rm.fsf@kernel.org>
 <aIIKo39dK22ew1T5@linux.ibm.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <aIIKo39dK22ew1T5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27712/Sun Jul 27 10:35:17 2025)

On 7/24/25 12:27 PM, Saket Kumar Bhaskar wrote:
[...]
> Thanks for the patch. I applied the patch and tested it.
> 
> Before this patch:
> 
> # ./test_progs -a \
>    verifier_load_acquire,verifier_store_release,atomics
> #11/1    atomics/add:OK
> #11/2    atomics/sub:OK
> #11/3    atomics/and:OK
> #11/4    atomics/or:OK
> #11/5    atomics/xor:OK
> #11/6    atomics/cmpxchg:OK
> #11/7    atomics/xchg:OK
> #11      atomics:OK
> #528/1   verifier_load_acquire/Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support load-acquire, use a dummy test:OK
> #528     verifier_load_acquire:OK
> #565/1   verifier_store_release/Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support store-release, use a dummy test:OK
> #565     verifier_store_release:OK
> Summary: 3/9 PASSED, 0 SKIPPED, 0 FAILED
> 
> After this patch:
> 
> # ./test_progs -a \
>    verifier_load_acquire,verifier_store_release,atomics
> #11/1    atomics/add:OK
> #11/2    atomics/sub:OK
> #11/3    atomics/and:OK
> #11/4    atomics/or:OK
> #11/5    atomics/xor:OK
> #11/6    atomics/cmpxchg:OK
> #11/7    atomics/xchg:OK
> #11      atomics:OK
> #529/1   verifier_load_acquire/load-acquire, 8-bit:OK
> #529/2   verifier_load_acquire/load-acquire, 8-bit @unpriv:OK
> #529/3   verifier_load_acquire/load-acquire, 16-bit:OK
> #529/4   verifier_load_acquire/load-acquire, 16-bit @unpriv:OK
> #529/5   verifier_load_acquire/load-acquire, 32-bit:OK
> #529/6   verifier_load_acquire/load-acquire, 32-bit @unpriv:OK
> #529/7   verifier_load_acquire/load-acquire, 64-bit:OK
> #529/8   verifier_load_acquire/load-acquire, 64-bit @unpriv:OK
> #529/9   verifier_load_acquire/load-acquire with uninitialized src_reg:OK
> #529/10  verifier_load_acquire/load-acquire with uninitialized src_reg @unpriv:OK
> #529/11  verifier_load_acquire/load-acquire with non-pointer src_reg:OK
> #529/12  verifier_load_acquire/load-acquire with non-pointer src_reg @unpriv:OK
> #529/13  verifier_load_acquire/misaligned load-acquire:OK
> #529/14  verifier_load_acquire/misaligned load-acquire @unpriv:OK
> #529/15  verifier_load_acquire/load-acquire from ctx pointer:OK
> #529/16  verifier_load_acquire/load-acquire from ctx pointer @unpriv:OK
> #529/17  verifier_load_acquire/load-acquire with invalid register R15:OK
> #529/18  verifier_load_acquire/load-acquire with invalid register R15 @unpriv:OK
> #529/19  verifier_load_acquire/load-acquire from pkt pointer:OK
> #529/20  verifier_load_acquire/load-acquire from flow_keys pointer:OK
> #529/21  verifier_load_acquire/load-acquire from sock pointer:OK
> #529     verifier_load_acquire:OK
> #566/1   verifier_store_release/store-release, 8-bit:OK
> #566/2   verifier_store_release/store-release, 8-bit @unpriv:OK
> #566/3   verifier_store_release/store-release, 16-bit:OK
> #566/4   verifier_store_release/store-release, 16-bit @unpriv:OK
> #566/5   verifier_store_release/store-release, 32-bit:OK
> #566/6   verifier_store_release/store-release, 32-bit @unpriv:OK
> #566/7   verifier_store_release/store-release, 64-bit:OK
> #566/8   verifier_store_release/store-release, 64-bit @unpriv:OK
> #566/9   verifier_store_release/store-release with uninitialized src_reg:OK
> #566/10  verifier_store_release/store-release with uninitialized src_reg @unpriv:OK
> #566/11  verifier_store_release/store-release with uninitialized dst_reg:OK
> #566/12  verifier_store_release/store-release with uninitialized dst_reg @unpriv:OK
> #566/13  verifier_store_release/store-release with non-pointer dst_reg:OK
> #566/14  verifier_store_release/store-release with non-pointer dst_reg @unpriv:OK
> #566/15  verifier_store_release/misaligned store-release:OK
> #566/16  verifier_store_release/misaligned store-release @unpriv:OK
> #566/17  verifier_store_release/store-release to ctx pointer:OK
> #566/18  verifier_store_release/store-release to ctx pointer @unpriv:OK
> #566/19  verifier_store_release/store-release, leak pointer to stack:OK
> #566/20  verifier_store_release/store-release, leak pointer to stack @unpriv:OK
> #566/21  verifier_store_release/store-release, leak pointer to map:OK
> #566/22  verifier_store_release/store-release, leak pointer to map @unpriv:OK
> #566/23  verifier_store_release/store-release with invalid register R15:OK
> #566/24  verifier_store_release/store-release with invalid register R15 @unpriv:OK
> #566/25  verifier_store_release/store-release to pkt pointer:OK
> #566/26  verifier_store_release/store-release to flow_keys pointer:OK
> #566/27  verifier_store_release/store-release to sock pointer:OK
> #566     verifier_store_release:OK
> Summary: 3/55 PASSED, 0 SKIPPED, 0 FAILED
> 
> Tested-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>

Michael/Madhavan, I presume you'll pick this patch up?

Thanks,
Daniel

