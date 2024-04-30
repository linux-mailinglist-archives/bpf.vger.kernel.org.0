Return-Path: <bpf+bounces-28288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA228B8012
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0F1282A04
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 18:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A082194C70;
	Tue, 30 Apr 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVG5XhKC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20971184139
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502892; cv=none; b=s0zp7OyjAZJyt3ByrQ+uqRzwzl7LRDz7/w1Ea3LY5/g/CdL+0u6kZCtrAxTtxvCxb9Kns8N1lyiyqc8HwUM5Jbc7jC32Z3oWq9xN4M5Zim8FJmoKGjx95cEWF9dIu3NUcDfZCUy3WWfKu2s+6QPetEVHxmk5VMfn30vTrN8Eiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502892; c=relaxed/simple;
	bh=qAVEeVEdRlb1S72MgCl70BliF2Yd7tS1gWFhYtq/0u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rO50N5rO3vAX/9sVPID6a/4h5JdddJL2bglaheypxqzgWJUtp+HcBOamYK9NWD0oH6qjG3BELjAFyI2Q8KCOza+tgHEp7RCsmEejOUqxG5x4S+LfDQ/PApQfE8iULYNVp2FjGdjayYLJH9T+n0/INtzbClJsfcdbws3bDwSnwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVG5XhKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBBDC4AF18;
	Tue, 30 Apr 2024 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714502891;
	bh=qAVEeVEdRlb1S72MgCl70BliF2Yd7tS1gWFhYtq/0u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVG5XhKCzlOd6fi9OccXq8ldrh3nCTDoQIlnnrXhQyC63GDEqrlXO75yyfanhCOrJ
	 rNAOmyyRZyKtwc38o1hH8W8QHUmF6JMQvmfIfaZ80GHAnoP3RW+yqO0N3SmKjDp8Jh
	 OhCnq4N8/ShrLrucfaXhuALkjrA9jaJjxW1EtZ/b62iQgDxG8Zk9SoSflQKLTemIeS
	 qWrLsYIZkReSKIftUaanZGAzkk9coluXMh0wNuiYg0DUo9JmTN0FsWFtoeZr4gRmBm
	 qzBtiVBziSKcwscqI6FkNzii19ag8tuV+FSr05sxJf7Z17Txvl9QVHTW2OReFmGDyA
	 sVRIHorYW5t3w==
Date: Tue, 30 Apr 2024 15:48:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: jolsa@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v9 2/3] pahole: Add --btf_feature=decl_tag_kfuncs
 feature
Message-ID: <ZjE85q0SJ1sve25u@x1>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <6d69d6dce917475ffe9c1bd7bc53358904f60915.1714430735.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d69d6dce917475ffe9c1bd7bc53358904f60915.1714430735.git.dxu@dxuuu.xyz>

On Mon, Apr 29, 2024 at 04:45:59PM -0600, Daniel Xu wrote:
> Add a feature flag to guard tagging of kfuncs. The next commit will
> implement the actual tagging.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Also 'decl_tag_kfuncs' is not enabled when using --btf_features=default,
right? as:

        BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),

And that false is .default_enabled=false.

So I added:

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index be04f1c617291e21..f0605935a9f1b4dc 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -308,7 +308,6 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
 	                   in some CUs and not others, or when the same
 	                   function name has inconsistent BTF descriptions
 	                   in different CUs.
-	decl_tag_kfuncs    Inject a BTF_KIND_DECL_TAG for each discovered kfunc.
 .fi
 
 Supported non-standard features (not enabled for 'default')
@@ -317,6 +316,7 @@ Supported non-standard features (not enabled for 'default')
 	reproducible_build Ensure generated BTF is consistent every time;
 	                   without this parallel BTF encoding can result in
 	                   inconsistent BTF ids.
+	decl_tag_kfuncs    Inject a BTF_KIND_DECL_TAG for each discovered kfunc.
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.


----

Please ack. Alan, please check if your Reviewed-by stands with the above
change.

Thanks,

- Arnaldo

> ---
>  btf_encoder.c      | 2 ++
>  dwarves.h          | 1 +
>  man-pages/pahole.1 | 1 +
>  pahole.c           | 1 +
>  4 files changed, 5 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 5ffaf5d..f0ef20a 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -76,6 +76,7 @@ struct btf_encoder {
>  			  verbose,
>  			  force,
>  			  gen_floats,
> +			  tag_kfuncs,
>  			  is_rel;
>  	uint32_t	  array_index_id;
>  	struct {
> @@ -1661,6 +1662,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->force		 = conf_load->btf_encode_force;
>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
>  		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
> +		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->verbose	 = verbose;
>  		encoder->has_index_type  = false;
>  		encoder->need_index_type = false;
> diff --git a/dwarves.h b/dwarves.h
> index dd35a4e..7d566b6 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -94,6 +94,7 @@ struct conf_load {
>  	bool			btf_gen_floats;
>  	bool			btf_encode_force;
>  	bool			reproducible_build;
> +	bool			btf_decl_tag_kfuncs;
>  	uint8_t			hashtable_bits;
>  	uint8_t			max_hashtable_bits;
>  	uint16_t		kabi_prefix_len;
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index e3c58e0..4769b58 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -308,6 +308,7 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
>  	                   in some CUs and not others, or when the same
>  	                   function name has inconsistent BTF descriptions
>  	                   in different CUs.
> +	decl_tag_kfuncs    Inject a BTF_KIND_DECL_TAG for each discovered kfunc.
>  .fi
>  
>  Supported non-standard features (not enabled for 'default')
> diff --git a/pahole.c b/pahole.c
> index 750b847..954498d 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1289,6 +1289,7 @@ struct btf_feature {
>  	BTF_DEFAULT_FEATURE(enum64, skip_encoding_btf_enum64, true),
>  	BTF_DEFAULT_FEATURE(optimized_func, btf_gen_optimized, false),
>  	BTF_DEFAULT_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
> +	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
>  	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
>  };
>  
> -- 
> 2.44.0

