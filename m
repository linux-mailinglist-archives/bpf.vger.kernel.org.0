Return-Path: <bpf+bounces-38297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B87962E7D
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB761C21A36
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F059B1A4F1F;
	Wed, 28 Aug 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Fa/VYNpy"
X-Original-To: bpf@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EE13C8E8
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866157; cv=none; b=Lmx8gkRkI3RiQbIyqViMbTuUokBnpIdU7d4wqkvXn9S8fCVoVE8W0TGyfjt090fY+nig/9H7AARwWO45W8+gdaGnI7ljwSPxda9+f96875LtdBm1HrBAXV7RIz546Qt5OnOax2/ykgeawvgs9Mdk8DA4YWjNKfWDcxu6vWuPwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866157; c=relaxed/simple;
	bh=5stywCFynSdmVXFZ9+R+kgdCoZN4IvbWmEKe8u6DSqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLUFV8RdkiHze75JX50t2xrK/x+4HwWnhFFzNluzy+75qZ/gUhztLV/HJQwB/uaBSPSekCr8+qGpUGc++UUVfUf0jbgzNDTzo3IhbPTdDl3M104M/t4quqbavmUB0rLSbD4rBItCdZsLU8kRakbHFCIY4OWgbviR8oNyc8x0lyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Fa/VYNpy; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4304E240104
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 19:29:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1724866147; bh=5stywCFynSdmVXFZ9+R+kgdCoZN4IvbWmEKe8u6DSqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=Fa/VYNpyw/gbn38EhaXWk+de2b9pF7uT824Ms3uPGzxcSA5o8bsTxU9qG6exYoIQ6
	 UYoTNNQXMlArlz2Zwyy+wDVjislLM6BVk0Yd8EUsDs0Mplj4RtA0qxm7IkrDC83m5F
	 9GQ0hGJTpKBFZ2JqCRqXJDnv3poRpRaBhxEspqQpi5s0FQIeZXokq/LWISLx0Og2/9
	 6se47p8Yz5tXmwwH/UZ+Vs5oLZQi7i2O07hLTWr7/awVLG4ETPMMZ+QjXnJ6hDHlHe
	 3njh7BFGUqbI0tLZB8PjSHT6SkLSHmbH2TfKM+X8+p1zURHjMdXjUGpJDpBAfOzN/E
	 ugLRKh8TsTjFQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WvBGn0lNgz6twd;
	Wed, 28 Aug 2024 19:29:04 +0200 (CEST)
Date: Wed, 28 Aug 2024 17:28:39 +0000
From: Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] libbpf: fix bpf_object__open_skeleton()'s
 mishandling of options
Message-ID: <ktql72figcdzhjtu56mnjyxqvma4s7wf3g65ygd4kdsjovsbwl@4zltm7wh237q>
References: <20240827203721.1145494-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827203721.1145494-1-andrii@kernel.org>

On Tue, Aug 27, 2024 at 01:37:21PM GMT, Andrii Nakryiko wrote:
> We do an ugly copying of options in bpf_object__open_skeleton() just to
> be able to set object name from skeleton's recorded name (while still
> allowing user to override it through opts->object_name).
> 
> This is not just ugly, but it also is broken due to memcpy() that
> doesn't take into account potential skel_opts' and user-provided opts'
> sizes differences due to backward and forward compatibility. This leads
> to copying over extra bytes and then failing to validate options
> properly. It could, technically, lead also to SIGSEGV, if we are unlucky.
> 
> So just get rid of that memory copy completely and instead pass
> default object name into bpf_object_open() directly, simplifying all
> this significantly. The rule now is that obj_name should be non-NULL for
> bpf_object_open() when called with in-memory buffer, so validate that
> explicitly as well.
> 
> We adopt bpf_object__open_mem() to this as well and generate default
> name (based on buffer memory address and size) outside of bpf_object_open().
> 
> Fixes: d66562fba1ce ("libbpf: Add BPF object skeleton support")
> Reported-by: Daniel Müller <deso@posteo.net>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 52 +++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e55353887439..d3a542649e6b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13761,29 +13763,13 @@ static int populate_skeleton_progs(const struct bpf_object *obj,
>  int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
>  			      const struct bpf_object_open_opts *opts)
>  {
> -	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, skel_opts,
> -		.object_name = s->name,
> -	);
>  	struct bpf_object *obj;
>  	int err;
>  
> -	/* Attempt to preserve opts->object_name, unless overriden by user
> -	 * explicitly. Overwriting object name for skeletons is discouraged,
> -	 * as it breaks global data maps, because they contain object name
> -	 * prefix as their own map name prefix. When skeleton is generated,
> -	 * bpftool is making an assumption that this name will stay the same.
> -	 */
> -	if (opts) {
> -		memcpy(&skel_opts, opts, sizeof(*opts));
> -		if (!opts->object_name)
> -			skel_opts.object_name = s->name;
> -	}
> -
> -	obj = bpf_object__open_mem(s->data, s->data_sz, &skel_opts);
> -	err = libbpf_get_error(obj);
> -	if (err) {
> -		pr_warn("failed to initialize skeleton BPF object '%s': %d\n",
> -			s->name, err);
> +	obj = bpf_object_open(NULL, s->data, s->data_sz, s->name, opts);
> +	if (IS_ERR(obj)) {
> +		err = PTR_ERR(obj);
> +		pr_warn("failed to initialize skeleton BPF object '%s': %d\n", s->name, err);

Ideally we'd do the same dance here for the name that we do in
bpf_object_open, right? Otherwise the warning may be mildly confusing if
  > pr_debug("loading object '%s' from buffer\n", obj_name)
earlier refers to a potentially different name?

Seems minor, though. Thanks for the fix.

Reviewed-by: Daniel Müller <deso@posteo.net>

