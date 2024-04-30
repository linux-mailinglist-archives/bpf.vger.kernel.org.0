Return-Path: <bpf+bounces-28286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B3D8B7FF0
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3481D1C223E0
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F155819DF51;
	Tue, 30 Apr 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI2AzxV2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73901199EA1
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502466; cv=none; b=JNmiXlepxogo8hJcxrd3DXvqgsPZP8gmedhQ4Z7hiXngtREsTwSY5akv2xs1vkR4d98tIyoB4kAn+2Tk26+fav9nELkh/vdmdQgcJnTkCdXSoymcWSY/rjQs4rNz1OpkJnJnky4BTwFWvaZufS4NrZz9/0leah3FYPgvD0Of9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502466; c=relaxed/simple;
	bh=HmON3sbiUOKgL1fwstYhTYWvynHxPbwhZXOPd/eEYYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Arx3nIUZ/9n87JglUGX/Kn/jJqOTGc1dPKN5jmSlJy7rgAumgHOZhsF8+kDSIRAwmb8RMxmmIFFMNhrvsKWgD0q5+eRc7f5k2MCVKPRrdKS2MKPWgwmTitwTR6h6OsC3qBSsau7VzKA/ZnqXIcvfYVSbWtAzYoVowQwKWlHrdcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI2AzxV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8CDC2BBFC;
	Tue, 30 Apr 2024 18:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714502466;
	bh=HmON3sbiUOKgL1fwstYhTYWvynHxPbwhZXOPd/eEYYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AI2AzxV27W4l+JqY2ixG1pnMmcUOQHpu6YyFfoCdu72U4CSYTLjKUQSJFlPOfkzSw
	 xGeIZpQlqrovqW5xnCT99TrUKSQlFIky4p6awurgVnL47vAnWd6jgV+0y3f60+dqDS
	 0760Q9qpV5q0l7/t9G4S3ay4WIzZbUjJSWe7x1Lu5EUk/7bESnSOu97u8HER+/lUsa
	 xnM31/cSoWV0FMiAMFXskXmGrbAxFsQI+XXTxWTGTvjX5kXK0FPDxrlgdICDziK4Gj
	 NrcoICxMLD2QqBjevN5wz9AFXLB8KWIlqTQrZG7iu7RayJDf9Ij4s2AVva8SUnrayX
	 cJD7jOuBCBIhg==
Date: Tue, 30 Apr 2024 15:41:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: jolsa@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v9 1/3] pahole: Save input filename separate from
 output
Message-ID: <ZjE7PUSvpHRJGNgK@x1>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <1728b8d941d2658b310457b6c59d97f102aaf66d.1714430735.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728b8d941d2658b310457b6c59d97f102aaf66d.1714430735.git.dxu@dxuuu.xyz>

On Mon, Apr 29, 2024 at 04:45:58PM -0600, Daniel Xu wrote:
> During detached BTF encoding, the input file is not necessarily the same
> as the output file. So save them separately. This matters when we need
> to look at the input file again, such as for kfunc tagging.

You forgot to check a strdup(), I added this on top of this patch:


diff --git a/btf_encoder.c b/btf_encoder.c
index 5ffaf5d969c9bc49..8aa2a7709dc1555f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1651,7 +1651,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->raw_output = detached_filename != NULL;
 		encoder->source_filename = strdup(cu->filename);
 		encoder->filename = strdup(encoder->raw_output ? detached_filename : cu->filename);
-		if (encoder->filename == NULL)
+		if (encoder->source_filename == NULL || encoder->filename == NULL)
 			goto out_delete;
 
 		encoder->btf = btf__new_empty_split(base_btf);
 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  btf_encoder.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 19e9d90..5ffaf5d 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -64,6 +64,7 @@ struct btf_encoder {
>  	struct btf        *btf;
>  	struct cu         *cu;
>  	struct gobuffer   percpu_secinfo;
> +	const char	  *source_filename;
>  	const char	  *filename;
>  	struct elf_symtab *symtab;
>  	uint32_t	  type_id_off;
> @@ -1648,6 +1649,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  
>  	if (encoder) {
>  		encoder->raw_output = detached_filename != NULL;
> +		encoder->source_filename = strdup(cu->filename);
>  		encoder->filename = strdup(encoder->raw_output ? detached_filename : cu->filename);
>  		if (encoder->filename == NULL)
>  			goto out_delete;
> @@ -1730,6 +1732,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	btf_encoders__delete(encoder);
>  	__gobuffer__delete(&encoder->percpu_secinfo);
>  	zfree(&encoder->filename);
> +	zfree(&encoder->source_filename);
>  	btf__free(encoder->btf);
>  	encoder->btf = NULL;
>  	elf_symtab__delete(encoder->symtab);
> -- 
> 2.44.0

