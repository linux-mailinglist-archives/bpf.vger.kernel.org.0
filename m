Return-Path: <bpf+bounces-30284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162F08CBF13
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 12:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7801F22E58
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 10:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F917823DF;
	Wed, 22 May 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyJSTlv8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BA823CC;
	Wed, 22 May 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372757; cv=none; b=JNCrF2I5m9sBVVst1wZnYMjMn8rr3JtdJ2BLLMTDB+HTqNk5AZuYi+9s2vlj7O0TllM96qj5cfe/biaIeWKyJjpOL1e4/svpJXxpJPkdisYSWLJdHkN28Yl9bQwKecwsTdQims8a8mP54YaUvq+Spl7WxhBYoEK9Ghp5Csv7gu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372757; c=relaxed/simple;
	bh=zUN+VBhM9jve+1Wux5Ig7pljjZl1sHUUAvRjDqaekdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dzUZOCvZGiOQdnXl8SWjGwFcKElGKqTRXy91TkJ6vM/pO2Tiu1JiseYl++NropDswfwbqGkpTyOxG9YunI0V33HRaUy2DauxoFaooM29iHIseULwZpDY0NyRNs+9AMQKuGK3VYcbKeAw78BFK7c5svq/forfWlmzy/kVmvvTXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyJSTlv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62863C32789;
	Wed, 22 May 2024 10:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716372757;
	bh=zUN+VBhM9jve+1Wux5Ig7pljjZl1sHUUAvRjDqaekdM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oyJSTlv8IoGqml7R45INLTNklVGr0WEwmG7SnWGDfZp6lCo/A/3Qi7ATcfdYsUcxR
	 kH1Bv7IVip3ZSIJBQO8ehhQLJVxbE/O3XO277dlDM+NrUt/zz0WfuuYzAzncV1zx3y
	 fjNOWF3a0KjpGMJu2l3DoNH4a5x2Ht9Dwknesm1dWda1Bgw/WXk6tpOJRX71cnS4D+
	 vCk5YmZpQUkEPJTn+zwaCe9+qLBKh2g8/h9OQ3WHKYjhzyQAUR09y4kOCb03he8JYc
	 Rx8DVjprfGeCXSGtZGZ746FY579JqvidoQt5Yp0KbxvjKURf0AMpagg2EEACd5oOGV
	 F8Wk3XrO88c9w==
Message-ID: <ec9b6e588ab9c25e0c4f9d1d8822d91896e87b35.camel@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: test_sockmap, use section names
 understood by libbpf
From: Geliang Tang <geliang@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Date: Wed, 22 May 2024 18:12:31 +0800
In-Reply-To: <20240522080936.2475833-1-jakub@cloudflare.com>
References: <20240522080936.2475833-1-jakub@cloudflare.com>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBGWKTg4BEAC/Subk93zbjSYPahLCGMgjylhY/s/R2ebALGJFp13MPZ9qWlbVC8O+X
 lU/4reZtYKQ715MWe5CwJGPyTACILENuXY0FyVyjp/jl2u6XYnpuhw1ugHMLNJ5vbuwkc1I29nNe8
 wwjyafN5RQV0AXhKdvofSIryqm0GIHIH/+4bTSh5aB6mvsrjUusB5MnNYU4oDv2L8MBJStqPAQRLl
 P9BWcKKA7T9SrlgAr0VsFLIOkKOQPVTCnYxn7gfKogH52nkPAFqNofVB6AVWBpr0RTY7OnXRBMInM
 HcjVG4I/NFn8Cc7oaGaWHqX/yHAufJKUsldieQVFd7C/SI8jCUXdkZxR0Tkp0EUzkRc/TS1VwWHav
 0x3oLSy/LGHfRaIC/MqdGVqgCnm6wapUt7f/JHloyIyKJBGBuHCLMpN6n/kNkSCzyZKV7h6Vw1OL5
 18p0U3Optyakoh95KiJsKzcd3At/eftQGlNn5WDflHV1+oMdW2sRgfVDPrYeEcYI5IkTc3LRO6ucp
 VCm9/+poZSHSXMI/oJ6iXMJE8k3/aQz+EEjvc2z0p9aASJPzx0XTTC4lciTvGj62z62rGUlmEIvU2
 3wWH37K2EBNoq+4Y0AZsSvMzM+CcTo25hgPaju1/A8ErZsLhP7IyFT17ARj/Et0G46JRsbdlVJ/Pv
 X+XIOc2mpqx/QARAQABtCVHZWxpYW5nIFRhbmcgPGdlbGlhbmcudGFuZ0BsaW51eC5kZXY+iQJUBB
 MBCgA+FiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBY
 CAwECHgECF4AACgkQfnvtNTGKqCmS+A/9Fec0xGLcrHlpCooiCnNH0RsXOVPsXRp2xQiaOV4vMsvh
 G5AHaQLb3v0cUr5JpfzMzNpEkaBQ/Y8Oj5hFOORhTyCZD8tY1aROs8WvbxqvbGXHnyVwqy7AdWelP
 +0lC0DZW0kPQLeel8XvLnm9Wm3syZgRGxiM/J7PqVcjujUb6SlwfcE3b2opvsHW9AkBNK7v8wGIcm
 BA3pS1O0/anP/xD5s5L7LIMADVB9MqQdeLdFU+FFdafmKSmcP9A2qKHAvPBUuQo3xoBOZR3DMqXIP
 kNCBfQGkAx5tm1XYli1u3r5tp5QCRbY5LSkntMNJJh0eWLU8I+zF6NWhqNhHYRD3zc1tiXlG5E0ob
 pX02Dy25SE2zB3abCRdAK30nCI4lMyMCcyaeFqvf6uhiugLiuEPRRRdJDWICOLw6KOFmxWmue1F71
 k08nj5PQMWQUX3X2K6jiOuoodYwnie/9NsH3DBHIVzVPWASFd6JkZ21i9Ng4ie+iQAveRTCeCCF6V
 RORJR0R8d7mI9+1eqhNeKzs21gQPVf/KBEIpwPFDjOdTwS/AEQQyhB+5ALeYpNgfKl2p30C20VRfJ
 GBaTc4ReUXh9xbUx5OliV69iq9nIVIyculTUsbrZX81Gz6UlbuSzWc4JclWtXf8/QcOK31wputde7
 Fl1BTSR4eWJcbE5Iz2yzgQu0IUdlbGlhbmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPokCVAQTA
 QoAPhYhBGYinflYXRnXKLAXGn577TUxiqgpBQJlqclXAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAg
 MBAh4BAheAAAoJEH577TUxiqgpaGkP/3+VDnbu3HhZvQJYw9a5Ob/+z7WfX4lCMjUvVz6AAiM2atD
 yyUoDIv0fkDDUKvqoU9BLU93oiPjVzaR48a1/LZ+RBE2mzPhZF201267XLMFBylb4dyQZxqbAsEhV
 c9VdjXd4pHYiRTSAUqKqyamh/geIIpJz/cCcDLvX4sM/Zjwt/iQdvCJ2eBzunMfouzryFwLGcOXzx
 OwZRMOBgVuXrjGVB52kYu1+K90DtclewEgvzWmS9d057CJztJZMXzvHfFAQMgJC7DX4paYt49pNvh
 cqLKMGNLPsX06OR4G+4ai0JTTzIlwVJXuo+uZRFQyuOaSmlSjEsiQ/WsGdhILldV35RiFKe/ojQNd
 4B4zREBe3xT+Sf5keyAmO/TG14tIOCoGJarkGImGgYltTTTM6rIk/wwo9FWshgKAmQyEEiSzHTSnX
 cGbalD3Do89YRmdG+5eP7HQfsG+VWdn8IH6qgIvSt8GOw6RfSP7omMXvXji1VrbWG4LOFYcsKTN+d
 GDhl8LmU0y44HejkCzYj/b28MvNTiRVfucrmZMGgI8L5A4ZwQ3Inv7jY13GZSvTb7PQIbqMcb1P3S
 qWJFodSwBg9oSw21b+T3aYG3z3MRCDXDlZAJONELx32rPMdBva8k+8L+K8gc7uNVH4jkMPkP9jPnV
 Px+2P2cKc7LXXedb/qQ3MuQINBGWKTg4BEADJxiOtR4SC7EHrUDVkp/pJCQC2wxNVEiJOas/q7H62
 BTSjXnXDc8yamb+HDO+Sncg9SrSRaXIh+bw9G3rvOiC2aQKB6EyIWKMcuDlD7GbkLJGRoPCA5nSfH
 Szht2PdNvbDizODhtBy8BOQA6Vb21XOb1k/hfD8Wy6OnvkA4Er61cf66BzXeTEFrvAIW+eUeoYTBA
 eOOc2m4Y0J28lXhoQftpNGV5DxH9HSQilQZxEyWkNj8oomVJ6Db7gSHre0odlt5ZdB7eCJik12aPI
 dK5W97adXrUDAclipsyYmZoC1oRkfUrHZ3aYVgabfC+EfoHnC3KhvekmEfxAPHydGcp80iqQJPjqn
 eDJBOrk6Y51HDMNKg4HJfPV0kujgbF3Oie2MVTuJawiidafsAjP4r7oZTkP0N+jqRmf/wkPe4xkGQ
 Ru+L2GTknKtzLAOMAPSh38JqlReQ59G4JpCqLPr00sA9YN+XP+9vOHT9s4iOu2RKy2v4eVOAfEFLX
 q2JejUQfXZtzSrS/31ThMbfUmZsRi8CY3HRBAENX224Wcn6IsXj3K6lfYxImRKWGa/4KviLias917
 DT/pjLw/hE8CYubEDpm6cYpHdeAEmsrt/9dMe6flzcNQZlCBgl9zuErP8Cwq8YNO4jN78vRlLLZ5s
 qgDTWtGWygi/SUj8AUQHyF677QARAQABiQI7BBgBCgAmFiEEZiKd+VhdGdcosBcafnvtNTGKqCkFA
 mWKTg4CGwwFCRLMAwAACgkQfnvtNTGKqCkpsw/2MuS0PVhl2iXs+MleEhnN1KjeSYaw+nLbRwd2Sd
 XoVXBquPP9Bgb92T2XilcWObNwfVtD2eDz8eKf3e9aaWIzZRQ3E5BxiQSHXl6bDDNaWJB6I8dd5TW
 +QnBPLzvqxgLIoYn+2FQ0AtL0wpMOdcFg3Av8MEmMJk6s/AHkL8HselA3+4h8mgoK7yMSh601WGrQ
 AFkrWabtynWxHrq4xGfyIPpq56e5ZFPEPd4Ou8wsagn+XEdjDof/QSSjJiIaenCdDiUYrx1jltLmS
 lN4gRxnlCBp6JYr/7GlJ9Gf26wk25pb9RD6xgMemYQHFgkUsqDulxoBit8g9e0Jlo0gwxvWWSKBJ8
 3f22kKiMdtWIieq94KN8kqErjSXcpI8Etu8EZsuF7LArAPch/5yjltOR5NgbcZ1UBPIPzyPgcAmZl
 AQgpy5c2UBMmPzxco/A/JVp4pKX8elTc0pS8W7ne8mrFtG7JL0VQfdwNNn2R45VRf3Ag+0pLSLS7W
 OVQcB8UjwxqDC2t3tJymKmFUfIq8N1DsNrHkBxjs9m3r82qt64u5rBUH3GIO0MGxaI033P+Pq3BXy
 i1Ur7p0ufsjEj7QCbEAnCPBTSfFEQIBW4YLVPk76tBXdh9HsCwwsrGC2XBmi8ymA05tMAFVq7a2W+
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

On Wed, 2024-05-22 at 10:09 +0200, Jakub Sitnicki wrote:
> libbpf can deduce program type and attach type from the ELF section
> name.
> We don't need to pass it out-of-band if we switch to libbpf
> convention [1].
> 
> [1] https://docs.kernel.org/bpf/libbpf/program_types.html
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Thanks for this patch, it works well. But ...

> ---
>  .../selftests/bpf/progs/test_sockmap_kern.h   | 17 +++++-----
>  tools/testing/selftests/bpf/test_sockmap.c    | 31 -----------------
> --
>  2 files changed, 9 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
> b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
> index 99d2ea9fb658..3dff0813730b 100644
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
> @@ -92,7 +92,7 @@ struct {
>  	__uint(value_size, sizeof(int));
>  } tls_sock_map SEC(".maps");
>  
> -SEC("sk_skb1")
> +SEC("sk_skb/stream_parser")
>  int bpf_prog1(struct __sk_buff *skb)
>  {
>  	int *f, two = 2;
> @@ -104,7 +104,7 @@ int bpf_prog1(struct __sk_buff *skb)
>  	return skb->len;
>  }
>  
> -SEC("sk_skb2")
> +SEC("sk_skb/stream_verdict")
>  int bpf_prog2(struct __sk_buff *skb)
>  {
>  	__u32 lport = skb->local_port;
> @@ -151,7 +151,7 @@ static inline void bpf_write_pass(struct
> __sk_buff *skb, int offset)
>  		memcpy(c + offset, "PASS", 4);
>  }
>  
> -SEC("sk_skb3")
> +SEC("sk_skb/stream_verdict")
>  int bpf_prog3(struct __sk_buff *skb)
>  {
>  	int err, *f, ret = SK_PASS;
> @@ -233,7 +233,7 @@ int bpf_sockmap(struct bpf_sock_ops *skops)
>  	return 0;
>  }
>  
> -SEC("sk_msg1")
> +SEC("sk_msg")
>  int bpf_prog4(struct sk_msg_md *msg)
>  {
>  	int *bytes, zero = 0, one = 1, two = 2, three = 3, four = 4,
> five = 5;
> @@ -263,7 +263,7 @@ int bpf_prog4(struct sk_msg_md *msg)
>  	return SK_PASS;
>  }
>  
> -SEC("sk_msg2")
> +SEC("sk_msg")
>  int bpf_prog6(struct sk_msg_md *msg)
>  {
>  	int zero = 0, one = 1, two = 2, three = 3, four = 4, five =
> 5, key = 0;
> @@ -308,7 +308,7 @@ int bpf_prog6(struct sk_msg_md *msg)
>  #endif
>  }
>  
> -SEC("sk_msg3")
> +SEC("sk_msg")
>  int bpf_prog8(struct sk_msg_md *msg)
>  {
>  	void *data_end = (void *)(long) msg->data_end;
> @@ -329,7 +329,8 @@ int bpf_prog8(struct sk_msg_md *msg)
>  
>  	return SK_PASS;
>  }
> -SEC("sk_msg4")
> +
> +SEC("sk_msg")
>  int bpf_prog9(struct sk_msg_md *msg)
>  {
>  	void *data_end = (void *)(long) msg->data_end;
> @@ -347,7 +348,7 @@ int bpf_prog9(struct sk_msg_md *msg)
>  	return SK_PASS;
>  }
>  
> -SEC("sk_msg5")
> +SEC("sk_msg")
>  int bpf_prog10(struct sk_msg_md *msg)
>  {
>  	int *bytes, *start, *end, *start_push, *end_push,
> *start_pop, *pop;
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c
> b/tools/testing/selftests/bpf/test_sockmap.c
> index 4499b3cfc3a6..ddc6a9cef36f 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -1783,30 +1783,6 @@ char *map_names[] = {
>  	"tls_sock_map",
>  };
>  
> -int prog_attach_type[] = {
> -	BPF_SK_SKB_STREAM_PARSER,
> -	BPF_SK_SKB_STREAM_VERDICT,
> -	BPF_SK_SKB_STREAM_VERDICT,
> -	BPF_CGROUP_SOCK_OPS,
> -	BPF_SK_MSG_VERDICT,
> -	BPF_SK_MSG_VERDICT,
> -	BPF_SK_MSG_VERDICT,
> -	BPF_SK_MSG_VERDICT,
> -	BPF_SK_MSG_VERDICT,
> -};

prog_attach_type is still used by my commit:

https://lore.kernel.org/bpf/e27d7d0c1e0e79b0acd22ac6ad5d8f9f00225303.1716372485.git.tanggeliang@kylinos.cn/T/#u

Please review it for me.

If my commit is acceptable, this patch will conflict with it. It's a
bit strange to delete this prog_attach_type in your patch and then add
it back in my commit. So could you please rebase this patch on my
commit in that case. Sorry for the trouble.

Anyway please add my tag:

Acked-and-tested-by: Geliang Tang <geliang@kernel.org> 

Thanks,
-Geliang

> -
> -int prog_type[] = {
> -	BPF_PROG_TYPE_SK_SKB,
> -	BPF_PROG_TYPE_SK_SKB,
> -	BPF_PROG_TYPE_SK_SKB,
> -	BPF_PROG_TYPE_SOCK_OPS,
> -	BPF_PROG_TYPE_SK_MSG,
> -	BPF_PROG_TYPE_SK_MSG,
> -	BPF_PROG_TYPE_SK_MSG,
> -	BPF_PROG_TYPE_SK_MSG,
> -	BPF_PROG_TYPE_SK_MSG,
> -};
> -
>  static int populate_progs(char *bpf_file)
>  {
>  	struct bpf_program *prog;
> @@ -1825,13 +1801,6 @@ static int populate_progs(char *bpf_file)
>  		return -1;
>  	}
>  
> -	bpf_object__for_each_program(prog, obj) {
> -		bpf_program__set_type(prog, prog_type[i]);
> -		bpf_program__set_expected_attach_type(prog,
> -						     
> prog_attach_type[i]);
> -		i++;
> -	}
> -
>  	i = bpf_object__load(obj);
>  	i = 0;
>  	bpf_object__for_each_program(prog, obj) {


