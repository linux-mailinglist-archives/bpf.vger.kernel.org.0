Return-Path: <bpf+bounces-26986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB78A6FBB
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 17:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFEA1B25971
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBFE130AC3;
	Tue, 16 Apr 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6jPJ4yk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316012C7FB;
	Tue, 16 Apr 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281082; cv=none; b=hlvdT8gRcJaPFwQ5k9ym01ewE5JeIVUQ3F6O+OzmFLHh/cPPLIi9nreV1dz9fsU6OZ5aY65KuB8o3yyoaS50SnL8ug21M3RH1A+E/PeR/j5uFCotoRa1uFCiMm9qInZKx8BsjkiUD+g49E+BdwLSl8sS/imRlVuJYTzXerJPpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281082; c=relaxed/simple;
	bh=olOAVxrLOL/GrQsE1N2eiJHUaAfQLSU4rd2FxrFcsmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVpMtaJUu/tyC2pcpyClUtfgkpuYuisK6FmeN54JYIKqS3Ma59RMkum2iAGf/bc77+vWLx5y1F6VYrYLpDyKkOw9yUFH/RbwEOe4ptARx0g5aZq4BRBjJm7lHOBokp/7ItL5PsqamrRKXFgxlyKHJerSJwyqneQ0eF0r8sSpe4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6jPJ4yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E7EC113CE;
	Tue, 16 Apr 2024 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713281081;
	bh=olOAVxrLOL/GrQsE1N2eiJHUaAfQLSU4rd2FxrFcsmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6jPJ4ykKZlk9HtSdMEvq5N8CecsKjQ5Tj9zEN82NRVFNo+mS6OZan76pLw6up3t1
	 WxAYntW9HxCuXIYZq3OtRVepb7TVnNsqFPEfPpRnrZeDjaNraosMafvxqdwO8G706W
	 nmLS4jlJP3z8UWzbagccfmsgbKUrzCvRnZCFGFjnW4t7FEWguZJC/VWNVCXKXeJGQZ
	 6LgNtx5voh1aaAuA7VSHS/CaVWSz7Bbs0JVH6+GCbGnc5uQvZnFI6kCl4eyCrJItZB
	 67TwAm3jsV7q92FenM3xQBZM2v6IaxqgKWYzODhKL7XyRoAUPeX5ceSsEOnKIu+K0Z
	 w7l6poQWMjOUA==
Date: Tue, 16 Apr 2024 12:24:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, williams@redhat.com,
	kcarcia@redhat.com, bpf@vger.kernel.org, kuifeng@fb.com,
	linux@weissschuh.net
Subject: Re: [PATCH dwarves 2/3] pahole: add reproducible_build to
 --btf_features
Message-ID: <Zh6YNhBRbhVchv5S@x1>
References: <20240416143718.2857981-1-alan.maguire@oracle.com>
 <20240416143718.2857981-3-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416143718.2857981-3-alan.maguire@oracle.com>

On Tue, Apr 16, 2024 at 03:37:17PM +0100, Alan Maguire wrote:
> ...as a non-standard feature, so it will not be enabled for
> "--btf_features=all"

How did you test this?

⬢[acme@toolbox pahole]$ pahole --btf_features_strict=bgasd
Feature 'bgasd' in 'bgasd' is not supported.  Supported BTF features are:
encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,reproducible_build
⬢[acme@toolbox pahole]$ pahole -j --btf_features=all,reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build-via-btf_features vmlinux
⬢[acme@toolbox pahole]$ bpftool btf dump file vmlinux.btf.parallel.reproducible_build-via-btf_features > output.vmlinux.btf.parallel.reproducible_build-via-btf_features
⬢[acme@toolbox pahole]$ diff -u output.vmlinux.btf.serial output.vmlinux.btf.parallel.reproducible
⬢[acme@toolbox pahole]$ diff -u output.vmlinux.btf.parallel.reproducible_build output.vmlinux.btf.parallel.reproducible_build-via-btf_features | head
--- output.vmlinux.btf.parallel.reproducible_build	2024-04-16 12:20:28.513462223 -0300
+++ output.vmlinux.btf.parallel.reproducible_build-via-btf_features	2024-04-16 12:23:37.792962930 -0300
@@ -265,7 +265,7 @@
 	'target' type_id=33 bits_offset=32
 	'key' type_id=43 bits_offset=64
 [164] PTR '(anon)' type_id=163
-[165] PTR '(anon)' type_id=35751
+[165] PTR '(anon)' type_id=14983
 [166] STRUCT 'static_key' size=16 vlen=2
 	'enabled' type_id=88 bits_offset=0
⬢[acme@toolbox pahole]$

I'm double checking things now...

- Arnaldo
 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  man-pages/pahole.1 | 8 ++++++++
>  pahole.c           | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 2c08e97..64de343 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -310,6 +310,14 @@ Encode BTF using the specified feature list, or specify 'all' for all standard f
>  	                   in different CUs.
>  .fi
>  
> +Supported non-standard features (not enabled for 'all')
> +
> +.nf
> +	reproducible_build Ensure generated BTF is consistent every time;
> +	                   without this parallel BTF encoding can result in
> +	                   inconsistent BTF ids.
> +.fi
> +
>  So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
>  
>  .TP
> diff --git a/pahole.c b/pahole.c
> index 890ef81..38cc636 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1286,6 +1286,7 @@ struct btf_feature {
>  	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true, true),
>  	BTF_FEATURE(optimized_func, btf_gen_optimized, false, true),
>  	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false, true),
> +	BTF_FEATURE(reproducible_build, reproducible_build, false, false),
>  };
>  
>  #define BTF_MAX_FEATURE_STR	1024



