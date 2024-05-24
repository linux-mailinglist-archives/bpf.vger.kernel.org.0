Return-Path: <bpf+bounces-30486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52078CE5D0
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139E0B21BE4
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01511272BF;
	Fri, 24 May 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6F6b2Ez"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925986653;
	Fri, 24 May 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556433; cv=none; b=Ma74+dADJA3blyEnaDjb0C9D/day7qvKpIr1LGdlWa3Hv2xpY9m6MRt5EQb+IXJuuJrL+jvltTIkkZVR2YqhrWiDFB7FwVXnxCk+hakST9zpnEAx8efJIyA1zdfDw29dHFUiLXeyGixZzrWQ+fbLH7xenibUewxM6M0sLAu3hMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556433; c=relaxed/simple;
	bh=NpZ/oUZ/qFvfZ9AsuHyWjL6YZrUCcTTtFcnDyD9oIPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcAz6HRjazqSLWDXVnQHeFlo7tcsvKei3+IRJB1RiPzw1F8tCBZkDVeT0hwDwdszvOLPlbQ4anXzUu/vlm7HMbW5ZQq0Iw/pcOSWWwPJmyc9X1RjoRJoK1W4EyO0jShYlq60YD/S+njaPw7YRxXVf4SRvP+NyokJnkcHU04vVkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6F6b2Ez; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f8edff35a0so713741b3a.2;
        Fri, 24 May 2024 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716556431; x=1717161231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MyzfS16StsoZEGeCGtvC6weySmrwWE1DyLms5XkcTk=;
        b=C6F6b2EzQoii8RZXmM9X34KLVBHW+q6JPbPnOlvkCAujNut7JNzBdYmNVwcdRkOzWN
         DJqF9dRVTFEfTrAhUBFHN6flzAOqnBG+6smvKqY006f+SqtJxm0ODjo11G5tl3IWNi/j
         nv3NI39hHilq8ptvlUnaEW2jO6bLXC56ujBU3m+kqYIxwwkqCnwj+Fsq5q77TSN0bKzc
         kFnayj3Kk+FzQKC9uFMIBaKaqC4g4DXFGiSzJvzvEdkor3JysiAAT+eAlQpoKzGS5ZYl
         x5+tSln/l5fYB6Gi3s4Ye2I7hZsBFVCgEvTtNA+/L5rX2m6sGnBmPP8jNyAiUqH1kP7k
         /3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716556431; x=1717161231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MyzfS16StsoZEGeCGtvC6weySmrwWE1DyLms5XkcTk=;
        b=G9J55o7ROyOudZYDy7lCJSSV1LqLIHAKEgjIGXRZruMuT0dLumIUjVqDahLspVk32T
         KEFp79dsUnsJL2mk5Jik3X590OO0b9TkI0YqKuarJoeGSRAiPNINirTDXau5SnccacB1
         /c5niKgmeRCdb2yi3Kc2Syu7zz3t3HsXV4h6iP+I5XdAYBwPHiRUcLIxaSVNOrPYVLAG
         /sp4XNcnvcyDwNnCUCNVsXq5DRLiKHZkscq7wrMVtsLh0oVDLLUBQJuAxydxm7MhoVht
         1J1a2NiNGBVJmVYFyzZ8qaPhHQ8RfLL0lGeZU5b46mXJsVZAgQesKrMJbK95h03gPyG7
         XvLw==
X-Forwarded-Encrypted: i=1; AJvYcCXte+NCPxR0O2O1GfYP77Mp28Io1sWiuzyb3hkXSbPrOkmL4O/L/0IBzVBFSVBaTo3CMNcDmfVE9b3oDVbqEGwL8NHJQF/OJDoPZrqTJT/7SMkqcYRePLz/XuWsg0hVbnouvTxx6sloslww43c68V/gjOkorwM1AZsg/udIJMDW8VNfq2q9
X-Gm-Message-State: AOJu0YxLG5UrvcjM+9sgw4yXXxjODGxhQTao0g0icKbVxmF/yYai/i3D
	BbQBhgFzx1jmijzdYOLSHwsWuz0uQTsL5sKCbdg2W74Rmw486J/o
X-Google-Smtp-Source: AGHT+IFRrxATx9NJgczNecyKGG7y0J0O42EKrFRKSSAepsrTmt+PQzg4XPOqPQbYnc9tzWhDRprLsw==
X-Received: by 2002:a05:6a21:3417:b0:1af:d1f0:b350 with SMTP id adf61e73a8af0-1b212dc14d2mr2235146637.22.1716556430763;
        Fri, 24 May 2024 06:13:50 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822635da92sm1127308a12.58.2024.05.24.06.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 06:13:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0D8C419395ACB; Fri, 24 May 2024 20:13:45 +0700 (WIB)
Date: Fri, 24 May 2024 20:13:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Marcel <nitan.marcel@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linux BPF <bpf@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Subject: Re: How to properly fix reading user pointers in bpf in android
 kernel 4.9?
Message-ID: <ZlCSiU-OF4W2Rwii@archie.me>
References: <42DD54A2-D0C2-4A70-B461-7C16D3ECB8D2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CXd7A4sW/FByWJu6"
Content-Disposition: inline
In-Reply-To: <42DD54A2-D0C2-4A70-B461-7C16D3ECB8D2@gmail.com>


--CXd7A4sW/FByWJu6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[also Cc: bpf maintainers and get_maintainer output]

On Thu, May 23, 2024 at 07:52:22PM +0300, Marcel wrote:
> This seems that it was a long standing problem with the Linux kernel in g=
eneral. bpf_probe_read should have worked for both kernel and user pointers=
 but it fails with access error when reading an user one instead.=20
>=20
> I know there's a patch upstream that fixes this by introducing new helper=
s for reading kernel and userspace pointers and I tried to back port them b=
ack to my kernel but with no success. Tools like bcc fail to use them and i=
nstead they report that the arguments sent to the helpers are invalid. I as=
sume this is due to the arguments ARG_CONST_STACK_SIZE and ARG_PTR_TO_RAW_S=
TACK handle data different in the 4.9 android version and the upstream vers=
ion but I'm not sure that this is the cause. I left the patch I did below a=
nd with a link to the kernel I'm working on and maybe someone can take a lo=
ok and give me an hand (the patch isn't applied yet)

What upstream patch? Has it already been in mainline?

>=20
> <https://github.com/nitanmarcel/android_kernel_oneplus_sdm845-bpf>
>=20
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 744b4763b80e..de94c13b7193 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -559,6 +559,43 @@ enum bpf_func_id {
>     */
>     BPF_FUNC_probe_read_user,
> =20
> +   /**
> +   * int bpf_probe_read_kernel(void *dst, int size, void *src)
> +   *     Read a kernel pointer safely.
> +   *     Return: 0 on success or negative error
> +   */
> +   BPF_FUNC_probe_read_kernel,
> +
> +	/**
> +	 * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
> +	 *     Copy a NUL terminated string from user unsafe address. In case t=
he string
> +	 *     length is smaller than size, the target is not padded with furth=
er NUL
> +	 *     bytes. In case the string length is larger than size, just count=
-1
> +	 *     bytes are copied and the last byte is set to NUL.
> +	 *     @dst: destination address
> +	 *     @size: maximum number of bytes to copy, including the trailing N=
UL
> +	 *     @unsafe_ptr: unsafe address
> +	 *     Return:
> +	 *       > 0 length of the string including the trailing NUL on success
> +	 *       < 0 error
> +	 */
> +	BPF_FUNC_probe_read_user_str,
> +
> +	/**
> +	 * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
> +	 *     Copy a NUL terminated string from unsafe address. In case the st=
ring
> +	 *     length is smaller than size, the target is not padded with furth=
er NUL
> +	 *     bytes. In case the string length is larger than size, just count=
-1
> +	 *     bytes are copied and the last byte is set to NUL.
> +	 *     @dst: destination address
> +	 *     @size: maximum number of bytes to copy, including the trailing N=
UL
> +	 *     @unsafe_ptr: unsafe address
> +	 *     Return:
> +	 *       > 0 length of the string including the trailing NUL on success
> +	 *       < 0 error
> +	 */
> +	BPF_FUNC_probe_read_kernel_str,
> +
>  	__BPF_FUNC_MAX_ID,
>  };
> =20
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a1e37a5d8c88..3478ca744a45 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -94,7 +94,7 @@ static const struct bpf_func_proto bpf_probe_read_proto=
 =3D {
>  	.arg3_type	=3D ARG_ANYTHING,
>  };
> =20
> -BPF_CALL_3(bpf_probe_read_user, void *, dst, u32, size, const void *, un=
safe_ptr)
> +BPF_CALL_3(bpf_probe_read_user, void *, dst, u32, size, const void  __us=
er *, unsafe_ptr)
>  {
>  	int ret;
> =20
> @@ -115,6 +115,27 @@ static const struct bpf_func_proto bpf_probe_read_us=
er_proto =3D {
>  };
> =20
> =20
> +BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size, const void *, =
unsafe_ptr)
> +{
> +	int ret;
> +
> +	ret =3D probe_kernel_read(dst, unsafe_ptr, size);
> +	if (unlikely(ret < 0))
> +		memset(dst, 0, size);
> +
> +	return ret;
> +}
> +
> +static const struct bpf_func_proto bpf_probe_read_kernel_proto =3D {
> +	.func		=3D bpf_probe_read_kernel,
> +	.gpl_only	=3D true,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_RAW_STACK,
> +	.arg2_type	=3D ARG_CONST_STACK_SIZE,
> +	.arg3_type	=3D ARG_ANYTHING,
> +};
> +
> +
>  BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
>  	   u32, size)
>  {
> @@ -487,6 +508,69 @@ static const struct bpf_func_proto bpf_probe_read_st=
r_proto =3D {
>  	.arg3_type	=3D ARG_ANYTHING,
>  };
> =20
> +
> +
> +BPF_CALL_3(bpf_probe_read_user_str, void *, dst, u32, size,
> +	   const void __user *, unsafe_ptr)
> +{
> +	int ret;
> +
> +	/*
> +	 * The strncpy_from_unsafe() call will likely not fill the entire
> +	 * buffer, but that's okay in this circumstance as we're probing
> +	 * arbitrary memory anyway similar to bpf_probe_read() and might
> +	 * as well probe the stack. Thus, memory is explicitly cleared
> +	 * only in error case, so that improper users ignoring return
> +	 * code altogether don't copy garbage; otherwise length of string
> +	 * is returned that can be used for bpf_perf_event_output() et al.
> +	 */
> +	ret =3D strncpy_from_unsafe_user(dst, unsafe_ptr, size);
> +	if (unlikely(ret < 0))
> +		memset(dst, 0, size);
> +
> +	return ret;
> +}
> +
> +static const struct bpf_func_proto bpf_probe_read_user_str_proto =3D {
> +	.func		=3D bpf_probe_read_user_str,
> +	.gpl_only	=3D true,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_RAW_STACK,
> +	.arg2_type	=3D ARG_CONST_STACK_SIZE,
> +	.arg3_type	=3D ARG_ANYTHING,
> +};
> +
> +
> +BPF_CALL_3(bpf_probe_read_kernel_str, void *, dst, u32, size,
> +	   const void *, unsafe_ptr)
> +{
> +	int ret;
> +
> +	/*
> +	 * The strncpy_from_unsafe() call will likely not fill the entire
> +	 * buffer, but that's okay in this circumstance as we're probing
> +	 * arbitrary memory anyway similar to bpf_probe_read() and might
> +	 * as well probe the stack. Thus, memory is explicitly cleared
> +	 * only in error case, so that improper users ignoring return
> +	 * code altogether don't copy garbage; otherwise length of string
> +	 * is returned that can be used for bpf_perf_event_output() et al.
> +	 */
> +	ret =3D strncpy_from_unsafe(dst, unsafe_ptr, size);
> +	if (unlikely(ret < 0))
> +		memset(dst, 0, size);
> +
> +	return ret;
> +}
> +
> +static const struct bpf_func_proto bpf_probe_read_kernel_str_proto =3D {
> +	.func		=3D bpf_probe_read_kernel_str,
> +	.gpl_only	=3D true,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_RAW_STACK,
> +	.arg2_type	=3D ARG_CONST_STACK_SIZE,
> +	.arg3_type	=3D ARG_ANYTHING,
> +};
> +
>  static const struct bpf_func_proto *tracing_func_proto(enum bpf_func_id =
func_id)
>  {
>  	switch (func_id) {
> @@ -500,8 +584,14 @@ static const struct bpf_func_proto *tracing_func_pro=
to(enum bpf_func_id func_id)
>  		return &bpf_probe_read_proto;
>  	case BPF_FUNC_probe_read_user:
>  		return &bpf_probe_read_user_proto;
> +	case BPF_FUNC_probe_read_kernel:
> +		return &bpf_probe_read_kernel_proto;
>  	case BPF_FUNC_probe_read_str:
>  		return &bpf_probe_read_str_proto;
> +	case BPF_FUNC_probe_read_user_str:
> +		return &bpf_probe_read_user_str_proto;
> +	case BPF_FUNC_probe_read_kernel_str:
> +		return &bpf_probe_read_kernel_proto;
>  	case BPF_FUNC_ktime_get_ns:
>  		return &bpf_ktime_get_ns_proto;
>  	case BPF_FUNC_tail_call:
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 155ce25c069d..91d5691288a7 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -522,7 +522,44 @@ enum bpf_func_id {
>     *     Return: 0 on success or negative error
>     */
>     BPF_FUNC_probe_read_user,
> +
> +   /**
> +   * int bpf_probe_read_kernel(void *dst, int size, void *src)
> +   *     Read a kernel pointer safely.
> +   *     Return: 0 on success or negative error
> +   */
> +   BPF_FUNC_probe_read_kernel,
>  =09
> +	/**
> +	 * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
> +	 *     Copy a NUL terminated string from user unsafe address. In case t=
he string
> +	 *     length is smaller than size, the target is not padded with furth=
er NUL
> +	 *     bytes. In case the string length is larger than size, just count=
-1
> +	 *     bytes are copied and the last byte is set to NUL.
> +	 *     @dst: destination address
> +	 *     @size: maximum number of bytes to copy, including the trailing N=
UL
> +	 *     @unsafe_ptr: unsafe address
> +	 *     Return:
> +	 *       > 0 length of the string including the trailing NUL on success
> +	 *       < 0 error
> +	 */
> +	BPF_FUNC_probe_read_user_str,
> +
> +	/**
> +	 * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
> +	 *     Copy a NUL terminated string from unsafe address. In case the st=
ring
> +	 *     length is smaller than size, the target is not padded with furth=
er NUL
> +	 *     bytes. In case the string length is larger than size, just count=
-1
> +	 *     bytes are copied and the last byte is set to NUL.
> +	 *     @dst: destination address
> +	 *     @size: maximum number of bytes to copy, including the trailing N=
UL
> +	 *     @unsafe_ptr: unsafe address
> +	 *     Return:
> +	 *       > 0 length of the string including the trailing NUL on success
> +	 *       < 0 error
> +	 */
> +	BPF_FUNC_probe_read_kernel_str,
> + =20
>    __BPF_FUNC_MAX_ID,
>  };

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--CXd7A4sW/FByWJu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZlCSfgAKCRD2uYlJVVFO
o4ZtAP9CLCSopm2A/OMtr8IyOqduKGxy0srvZwaoVfXgEeQvhAEA2PKsvM9UK2hk
B9BbhKmtv2QFUlMjOHkiqPBdWXEIeQk=
=ggPr
-----END PGP SIGNATURE-----

--CXd7A4sW/FByWJu6--

