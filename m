Return-Path: <bpf+bounces-28293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B48BD8B80EF
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 21:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BCAB24657
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3E199E95;
	Tue, 30 Apr 2024 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgIVpXOP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10554174EF1
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507051; cv=none; b=LNZcS4+tlV3NAG0G4ESl43xLf3WgtJ+iJ0434oMWW7sByzTcb4WFL4qK5JAsKCunQlibxM9jt3/cY7jnI5kJv5pjPgeStITokyn874fCODhtQ4zRxycD8OAVIyB3gE0ZeBqRApo4h7lgDKI0ecYnAZYuL94Xb3R6FP4H5wrDY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507051; c=relaxed/simple;
	bh=iTz5UoQlUF2obHwoHDhnsEQ5y4ie0Ikbr+4WlQKIw2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN7CA246EbmnyaLLOZKdC74vq3NJTxV49sGxh5dqmVZBs9FEiLQRAS7QAzQ4fST0iqM46Te9kX6Fd7EOayEyeNsVDKn3AhGze13lL2NCW3wLt+Rbs8OdlEFKY+vn48D1GmuoVAhg+QF0qQ+ojaVh2nMg8hDFmMNUKS8rNQk1r8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgIVpXOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0231C2BBFC;
	Tue, 30 Apr 2024 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714507050;
	bh=iTz5UoQlUF2obHwoHDhnsEQ5y4ie0Ikbr+4WlQKIw2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgIVpXOP0K9+Y4EoX62HYRk6hRrk/W4GwBWqL2JhecLku4DiXIIsdCU661dHobfXk
	 wLTqh/EvPDHgKdHSE9BqW1X505yeps9/L7w53wv8OpR6MIWY6UOHWKsXgjyf4YkzGg
	 +bSi5I/bdyl4hdW2HZb4OqjJOn8d9Wkg8DnPQzAvO+TBpVyCgliVsQ8NXpGfxAGkSf
	 m/eLw1w8VYrU3dW8drWIrO4gQ/MnPstMlDVj0ekLF3t7WH5fI7Saku82Q9RW0pGvKb
	 hB3eQ5prqrwqXMl4i4ibUmorfL7zjCP8qZxYUY+g/ULoNrdxcSrls1nu2/oE5fNKfh
	 O2TqtkHxjxo7g==
Date: Tue, 30 Apr 2024 16:57:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: jolsa@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v9 3/3] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZjFNJmfq-DKQYx9K@x1>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <26ec519a00aa47f25bc6b4c7e4e15e5191ba4d45.1714430735.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ec519a00aa47f25bc6b4c7e4e15e5191ba4d45.1714430735.git.dxu@dxuuu.xyz>

On Mon, Apr 29, 2024 at 04:46:00PM -0600, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
>         121
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
>         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Tested-by: Jiri Olsa <jolsa@kernel.org>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Here I needed this to avoid an strdup possibly followed by a free and
then checking the strdup result, please Ack/revalidate tags. I'm
dropping them as there are changes.

- Arnaldo

diff --git a/btf_encoder.c b/btf_encoder.c
index e9d82e0af0e178fd..c2df2bc7a374447b 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1434,11 +1434,13 @@ static char *get_func_name(const char *sym)
 		return NULL;
 
 	/* Strip prefix and handle malformed input such as  __BTF_ID__func___ */
-	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
-	if (!strstr(func, "__")) {
-                free(func);
+	const char *func_sans_prefix = sym + sizeof(BTF_ID_FUNC_PFX) - 1;
+	if (!strstr(func_sans_prefix, "__"))
                 return NULL;
-        }
+
+	func = strdup(func_sans_prefix);
+	if (!func)
+		return NULL;
 
 	/* Strip suffix */
 	end = strrchr(func, '_');

