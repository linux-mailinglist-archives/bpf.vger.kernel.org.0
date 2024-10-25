Return-Path: <bpf+bounces-43150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1278D9AFFCA
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 12:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69FA6B240D3
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CEA1FCC74;
	Fri, 25 Oct 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoXxPioY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5B1D5ABF;
	Fri, 25 Oct 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851104; cv=none; b=r0ehM5U9JvBboOJmKkMTS+F4e6W48t9RNXMjm/6jTXmLL3RAUmypFGAQZe0DQA8naNxXA0pFW64Xsfebko/rR1zCZAePVL4InDcWoaw4vua6tHTk4SJXM6wgrF6roDdKySlM0klMG4Ukr1aoa/SVcPhvmBd4A7uyE9SdktKTGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851104; c=relaxed/simple;
	bh=6Ti/rPa9VPGsl7W96k8PIOoxkRU8dllSjyzxVDqDHSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=onZ++9Dyor/vP4t9LULQu0G4KoMAsFkLCJpoRyi50yqg0fOlzZZULlq5EwGJ70L7NFV7nGHkMkrNwKjYrbDMJswld4cVVYQF3l7XMInCaGENWoJ5xhKbvgSS896q/ku+ZOXxZEPOE7eFSm30ocmd9nOE48/cJZHz/uOF18HtZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoXxPioY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76075C4CEC3;
	Fri, 25 Oct 2024 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729851103;
	bh=6Ti/rPa9VPGsl7W96k8PIOoxkRU8dllSjyzxVDqDHSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GoXxPioYzk31+wt+0+IRRRxkQF6KQCb9P4pFGaCK5JWftl0Tm7oqWs72+onb32YiF
	 v3UQ4dcsXWsw0Z/TSgyBCMKwdaOdpCAhJuVWXhsu3bwE7BOonosEF5HqKCX3lr7EHI
	 G/baMwPa7KAL6mqSjxnwXmb4XhUpmKawhwBRilU8YEmbLT2t+sMIymb9pkSWyhZcOY
	 J+4hqY7Wu8dz/H6sttVzKqaE6IuYatcMCSb+H7OAtC2wUckWwBbBEMUK4+ticQRVpu
	 QuLuYRl97UR9RmBq98gd9QAAtKk1VzwzCaXyZjeoiYSkG6CRSLRo+VzpCYsTHXakWs
	 p50HS9LD45TyA==
From: Puranjay Mohan <puranjay@kernel.org>
To: kernel test robot <lkp@intel.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Eduard Zingerman <eddyz87@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Helge Deller
 <deller@gmx.de>, Jakub Kicinski <kuba@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Abeni <pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>
Cc: oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: bpf_csum_diff: optimize and
 homogenize for all archs
In-Reply-To: <202410251552.LR73LP4V-lkp@intel.com>
References: <20241023153922.86909-3-puranjay@kernel.org>
 <202410251552.LR73LP4V-lkp@intel.com>
Date: Fri, 25 Oct 2024 10:11:11 +0000
Message-ID: <mb61po738bigw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:

> Hi Puranjay,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/net-checksum-move-from32to16-to-generic-header/20241023-234347
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20241023153922.86909-3-puranjay%40kernel.org
> patch subject: [PATCH bpf-next v2 2/4] bpf: bpf_csum_diff: optimize and homogenize for all archs
> config: i386-randconfig-061-20241025 (https://download.01.org/0day-ci/archive/20241025/202410251552.LR73LP4V-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251552.LR73LP4V-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410251552.LR73LP4V-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    net/core/filter.c:1423:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
>    net/core/filter.c:1423:39: sparse:     expected struct sock_filter const *filter
>    net/core/filter.c:1423:39: sparse:     got struct sock_filter [noderef] __user *filter
>    net/core/filter.c:1501:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
>    net/core/filter.c:1501:39: sparse:     expected struct sock_filter const *filter
>    net/core/filter.c:1501:39: sparse:     got struct sock_filter [noderef] __user *filter
>    net/core/filter.c:2321:45: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] daddr @@     got unsigned int [usertype] ipv4_nh @@
>    net/core/filter.c:2321:45: sparse:     expected restricted __be32 [usertype] daddr
>    net/core/filter.c:2321:45: sparse:     got unsigned int [usertype] ipv4_nh
>    net/core/filter.c:10993:31: sparse: sparse: symbol 'sk_filter_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11000:27: sparse: sparse: symbol 'sk_filter_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11004:31: sparse: sparse: symbol 'tc_cls_act_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11013:27: sparse: sparse: symbol 'tc_cls_act_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11017:31: sparse: sparse: symbol 'xdp_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11029:31: sparse: sparse: symbol 'cg_skb_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11035:27: sparse: sparse: symbol 'cg_skb_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11039:31: sparse: sparse: symbol 'lwt_in_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11045:27: sparse: sparse: symbol 'lwt_in_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11049:31: sparse: sparse: symbol 'lwt_out_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11055:27: sparse: sparse: symbol 'lwt_out_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11059:31: sparse: sparse: symbol 'lwt_xmit_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11066:27: sparse: sparse: symbol 'lwt_xmit_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11070:31: sparse: sparse: symbol 'lwt_seg6local_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11076:27: sparse: sparse: symbol 'lwt_seg6local_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11079:31: sparse: sparse: symbol 'cg_sock_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11085:27: sparse: sparse: symbol 'cg_sock_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11088:31: sparse: sparse: symbol 'cg_sock_addr_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11094:27: sparse: sparse: symbol 'cg_sock_addr_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11097:31: sparse: sparse: symbol 'sock_ops_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11103:27: sparse: sparse: symbol 'sock_ops_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11106:31: sparse: sparse: symbol 'sk_skb_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11113:27: sparse: sparse: symbol 'sk_skb_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11116:31: sparse: sparse: symbol 'sk_msg_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11123:27: sparse: sparse: symbol 'sk_msg_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11126:31: sparse: sparse: symbol 'flow_dissector_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11132:27: sparse: sparse: symbol 'flow_dissector_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11460:31: sparse: sparse: symbol 'sk_reuseport_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:11466:27: sparse: sparse: symbol 'sk_reuseport_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11668:27: sparse: sparse: symbol 'sk_lookup_prog_ops' was not declared. Should it be static?
>    net/core/filter.c:11672:31: sparse: sparse: symbol 'sk_lookup_verifier_ops' was not declared. Should it be static?
>    net/core/filter.c:1931:43: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
>    net/core/filter.c:1931:43: sparse:     expected restricted __wsum [usertype] diff
>    net/core/filter.c:1931:43: sparse:     got unsigned long long [usertype] to
>    net/core/filter.c:1934:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be16 [usertype] old @@     got unsigned long long [usertype] from @@
>    net/core/filter.c:1934:36: sparse:     expected restricted __be16 [usertype] old
>    net/core/filter.c:1934:36: sparse:     got unsigned long long [usertype] from
>    net/core/filter.c:1934:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] new @@     got unsigned long long [usertype] to @@
>    net/core/filter.c:1934:42: sparse:     expected restricted __be16 [usertype] new
>    net/core/filter.c:1934:42: sparse:     got unsigned long long [usertype] to
>    net/core/filter.c:1937:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
>    net/core/filter.c:1937:36: sparse:     expected restricted __be32 [usertype] from
>    net/core/filter.c:1937:36: sparse:     got unsigned long long [usertype] from
>    net/core/filter.c:1937:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
>    net/core/filter.c:1937:42: sparse:     expected restricted __be32 [usertype] to
>    net/core/filter.c:1937:42: sparse:     got unsigned long long [usertype] to
>    net/core/filter.c:1982:59: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
>    net/core/filter.c:1982:59: sparse:     expected restricted __wsum [usertype] diff
>    net/core/filter.c:1982:59: sparse:     got unsigned long long [usertype] to
>    net/core/filter.c:1985:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] from @@     got unsigned long long [usertype] from @@
>    net/core/filter.c:1985:52: sparse:     expected restricted __be16 [usertype] from
>    net/core/filter.c:1985:52: sparse:     got unsigned long long [usertype] from
>    net/core/filter.c:1985:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be16 [usertype] to @@     got unsigned long long [usertype] to @@
>    net/core/filter.c:1985:58: sparse:     expected restricted __be16 [usertype] to
>    net/core/filter.c:1985:58: sparse:     got unsigned long long [usertype] to
>    net/core/filter.c:1988:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
>    net/core/filter.c:1988:52: sparse:     expected restricted __be32 [usertype] from
>    net/core/filter.c:1988:52: sparse:     got unsigned long long [usertype] from
>    net/core/filter.c:1988:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
>    net/core/filter.c:1988:58: sparse:     expected restricted __be32 [usertype] to
>    net/core/filter.c:1988:58: sparse:     got unsigned long long [usertype] to
>>> net/core/filter.c:2023:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int sum @@     got restricted __wsum @@
>    net/core/filter.c:2023:48: sparse:     expected unsigned int sum
>    net/core/filter.c:2023:48: sparse:     got restricted __wsum
>    net/core/filter.c:2026:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int sum @@     got restricted __wsum @@
>    net/core/filter.c:2026:52: sparse:     expected unsigned int sum
>    net/core/filter.c:2026:52: sparse:     got restricted __wsum
>    net/core/filter.c:2029:40: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int sum @@     got restricted __wsum @@
>    net/core/filter.c:2029:40: sparse:     expected unsigned int sum
>    net/core/filter.c:2029:40: sparse:     got restricted __wsum
>    net/core/filter.c:2031:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [usertype] seed @@
>    net/core/filter.c:2031:16: sparse:     expected unsigned long long
>    net/core/filter.c:2031:16: sparse:     got restricted __wsum [usertype] seed
>    net/core/filter.c:2053:35: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [usertype] csum @@
>    net/core/filter.c:2053:35: sparse:     expected unsigned long long
>    net/core/filter.c:2053:35: sparse:     got restricted __wsum [usertype] csum
>
> vim +2023 net/core/filter.c
>
>   2009	
>   2010	BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_size,
>   2011		   __be32 *, to, u32, to_size, __wsum, seed)
>   2012	{
>   2013		/* This is quite flexible, some examples:
>   2014		 *
>   2015		 * from_size == 0, to_size > 0,  seed := csum --> pushing data
>   2016		 * from_size > 0,  to_size == 0, seed := csum --> pulling data
>   2017		 * from_size > 0,  to_size > 0,  seed := 0    --> diffing data
>   2018		 *
>   2019		 * Even for diffing, from_size and to_size don't need to be equal.
>   2020		 */
>   2021	
>   2022		if (from_size && to_size)
>> 2023			return csum_from32to16(csum_sub(csum_partial(to, to_size, seed),
>   2024							csum_partial(from, from_size, 0)));
>   2025		if (to_size)
>   2026			return csum_from32to16(csum_partial(to, to_size, seed));
>   2027	
>   2028		if (from_size)
>   2029			return csum_from32to16(~csum_partial(from, from_size, ~seed));
>   2030	
>   2031		return seed;
>   2032	}
>   2033	

This file has a lot of such sparse warnings. Specifically, to fix the
warning introduced by me, I can apply the following diff:

--- >8 ---

diff --git a/net/core/filter.c b/net/core/filter.c
index e00bec7de9ed..b94037f29b2a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2019,16 +2019,18 @@ BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_size,
         * Even for diffing, from_size and to_size don't need to be equal.
         */

+       __wsum ret = seed;
+
        if (from_size && to_size)
-               return csum_from32to16(csum_sub(csum_partial(to, to_size, seed),
-                                               csum_partial(from, from_size, 0)));
+               ret = csum_sub(csum_partial(to, to_size, seed), csum_partial(from, from_size, 0));
+
        if (to_size)
-               return csum_from32to16(csum_partial(to, to_size, seed));
+               ret =  csum_partial(to, to_size, seed);

        if (from_size)
-               return csum_from32to16(~csum_partial(from, from_size, ~seed));
+               ret = ~csum_partial(from, from_size, ~seed);

-       return seed;
+       return csum_from32to16((__force unsigned int)ret);
 }

--- 8< ---

If others feel that fixing these warnings is useful, I can send another
version with above diff. I will then also send a separate patch to fix
all other such warnings in this file.


Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZxtuwBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nfkyAP4imd310ZR1kDuVxB4CsHRlzISGXk8D
YIv2XeoC6q7YkQEAr854TBZtq4tB7ZjChtXhWWuntX12z/pN6VJ2Jpru1gA=
=CR+Q
-----END PGP SIGNATURE-----
--=-=-=--

