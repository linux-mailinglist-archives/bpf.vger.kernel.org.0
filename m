Return-Path: <bpf+bounces-34650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE4492FC64
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF131C227EC
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF841171641;
	Fri, 12 Jul 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksmJ0qGd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7C8F58
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793998; cv=none; b=CMZw5uUzmZizb9ivwL1ZNK0cCXgmSw1NxdOwr00k2Vyqa0zJrfyq0g0R8MDzf8vTRp9TmNxrI1bmPrgYzqBpJNUTLIVF+Ri9mhIBq1FIXQnABrMkhGgxlA+3azZVTQpnNkWbNTe0bIlyAZzSvqpCEeE6MBfUxbf1c+8P2K4AW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793998; c=relaxed/simple;
	bh=i6hRnEj3EyRcoUHZcX5Xr/RQfO3DDJik760VoHmXiio=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=eIowdigfuiw94hGI/0434YeUlvNKvQxoHfkFDyfWqAc0nvDOzVQp9KhDH+AhZNsB+39xum4QuYuaEZGDaBPZBwtvR72h7WZGcjKEYOds361iynVuUFC5CL6doj831EOuHWM30A+UO1IdgyjK+8EJVICPT/qKZUeCXi2hdqEOh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksmJ0qGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BE2C32782;
	Fri, 12 Jul 2024 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720793997;
	bh=i6hRnEj3EyRcoUHZcX5Xr/RQfO3DDJik760VoHmXiio=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=ksmJ0qGdix+KDtDC+llkNmC8zDF30cCNRIzw7F/OyZVikfualrwxPZDUUUZhEnGsy
	 XdLKyjqLThCw0KpaVl7kP5Hy+X1sHQK+TB0ceu/VlUyBW0cFqz4iyF8tJtKABfk9sf
	 EaFZhZkcmOidlRTjOONoWybykZhVijc/3RbtXkxUBI445uAy3BXFE4XQ9Iwin+HDzi
	 xyimeiJIdJa2HPcJzkBgPBAaYbVvKAO/eRcd96TRR7SWR+f6NIotK8XY+0789o7zRF
	 kSNDglRS2089BuBYrAUcWWdCjM867IPwPzuy/Ih9iz+z3M4HL2z2Aa+gYJb/DYADht
	 PdE+5XTds6oIg==
Message-ID: <83163d7e8162988e5235cca5d79ef3dba2d54565.camel@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] libbpf: handle ENOTSUPP in
 libbpf_strerror_r
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org
In-Reply-To: <2437275bb988da5c187b4d0223e5c0c9843fdc76.1720778831.git.tanggeliang@kylinos.cn>
References: <cover.1720778831.git.tanggeliang@kylinos.cn>
	 <2437275bb988da5c187b4d0223e5c0c9843fdc76.1720778831.git.tanggeliang@kylinos.cn>
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
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jul 2024 22:10:13 +0800
User-Agent: Evolution 3.52.0-1build2 
Content-Transfer-Encoding: 8bit

On Fri, 2024-07-12 at 18:14 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The errno 95 (ENOTSUP or EOPNOTSUPP) can be recognized by
> strerror_r(),
> but 524 (ENOTSUPP) can't:
> 
>  prog 'basic_alloc3': BPF program load failed: Operation not
> supported
>  prog 'basic_alloc3': failed to load: -95
>  failed to load object 'verifier_arena'
>  FAIL:unexpected_load_failure unexpected error: -95 (errno 95)
> 
>  prog 'inner_map': BPF program load failed: unknown error (-524)
>  prog 'inner_map': failed to load: -524
>  failed to load object 'bloom_filter_map'
>  failed to load BPF skeleton 'bloom_filter_map': -524
>  FAIL:bloom_filter_map__open_and_load unexpected error: -524
> 
> This patch fixes this by handling ENOTSUPP in libbpf_strerror_r().
> With
> this change, the new error string looks like:
> 
>  prog 'inner_map': BPF program load failed: Operation not supported
> (-524)
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/lib/bpf/str_error.c | 11 +++++++----
>  tools/lib/bpf/str_error.h |  4 ++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
> index 5e6a1e27ddf9..10597d5124cd 100644
> --- a/tools/lib/bpf/str_error.c
> +++ b/tools/lib/bpf/str_error.c
> @@ -23,10 +23,13 @@ char *libbpf_strerror_r(int err, char *dst, int
> len)
>  	if (ret == -1)
>  		ret = errno;
>  	if (ret) {
> -		if (ret == EINVAL)
> -			/* strerror_r() doesn't recognize this
> specific error */
> -			snprintf(dst, len, "unknown error (%d)", err
> < 0 ? err : -err);
> -		else
> +		if (ret == EINVAL) {
> +			if (err == ENOTSUPP)

Shouldn't use "err" directly here, should use "err < 0 ? -err : err"
instead. I prefer to add an unsigned variable "no" in v2:

	unsigned int no = err < 0 ? -err : err;

And use "switch-case" for future expansion:
	
	switch (no) {
	case ENOTSUPP:

> +				snprintf(dst, len, "Operation not
> supported (%d)", -err);

No need to use "Operation not supported (-524)" here, just "Operation
not supported" is better.

		snprintf(dst, len, "Operation not supported");

> +			else
> +				/* strerror_r() doesn't recognize
> this specific error */
> +				snprintf(dst, len, "unknown error
> (%d)", err < 0 ? err : -err);

Then here:

		snprintf(dst, len, "unknown error (-%u)", no);

Changes Requested.

Will send a v2 soon.

Thanks,
-Geliang

> +		} else
>  			snprintf(dst, len, "ERROR:
> strerror_r(%d)=%d", err, ret);
>  	}
>  	return dst;
> diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
> index 626d7ffb03d6..c41f6ba133cf 100644
> --- a/tools/lib/bpf/str_error.h
> +++ b/tools/lib/bpf/str_error.h
> @@ -4,6 +4,10 @@
>  
>  #define STRERR_BUFSIZE  128
>  
> +#ifndef ENOTSUPP
> +#define ENOTSUPP 524
> +#endif
> +
>  char *libbpf_strerror_r(int err, char *dst, int len);
>  
>  #endif /* __LIBBPF_STR_ERROR_H */


