Return-Path: <bpf+bounces-40967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E0990A0F
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DC42841A9
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D11D9A6B;
	Fri,  4 Oct 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="imGIFoWZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTXGtJBp"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD01D9A6A
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062509; cv=none; b=UVOIcnmLl84J9m/UNWRLsN1e2J9pXv7ERcvIWS2Nh52/49TOjUOUrO6CVoheK7hT92+nahrqGnTwKM7ZxeM6hawt1NUr0+xZp9EGUcFYmrlE6xunB/NX5PZPmeQnK+b2bdNP+j7VvT5NYbB2eRrOFP8BgAWDtDwg5ZZZ5s9hJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062509; c=relaxed/simple;
	bh=xk9mWsy/nPV09vPn+40g/xnwQMh535+BnYfH/J3Splo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAWtAwVGWsVcYVabCdu1JnOs9bjV0WS4W0Liakys2O1WfbGQ3wW/luHxb+UOS7iRJt8tY2ivCaimEPdLYUAuf6PckyEwxx2B3PXUuHeDektkoRtFZ3DDi7ZYSz1e3IehfTTvnX7qvuzO66nPgWKya4gIqb6V0CZ5cnttio+2B8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=imGIFoWZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTXGtJBp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EFC011380217;
	Fri,  4 Oct 2024 13:21:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 04 Oct 2024 13:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728062506; x=1728148906; bh=ApPvOqqdtz
	vE/knOZ1yEFTnfGSZiHSKGXQcfWrNlIaA=; b=imGIFoWZQe7C/cjBW+Tb7/0EB3
	11VHKrwyanDi8g6MKHExA0q+lHMDmWcp9N4dQSuwk/bmMkTSCTs1fpbJyCh7OzwW
	tveFI96TEp4dldebGvJRW8F75jxImzRFMxQTFDk4eZymlkDvWOzGBORpSXTUnHFK
	jhhOMe3pZfH8H0f5XpOlYk9MGQ5phkhBNdSuv0u/GtvfuWwnpgDO/k5yOxs56jHW
	3h/koCoowZMq3bkuoWPjul5DXbtAE260Qt316+gaQMYtFcn5vDMhb92XPpSwQS6R
	0Bg9hOgPRfB3YNc+GnMpGf4KT5BWrhu6vmvQXwufyFyk/KfBKOYP9LkSp1IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728062506; x=1728148906; bh=ApPvOqqdtzvE/knOZ1yEFTnfGSZi
	HSKGXQcfWrNlIaA=; b=RTXGtJBpXAG37xUjd525pLi6JJo+EX5QDFxptL8KKyq7
	AavGKStWGP4Ot8gu055RYXMWH/fvXQxiMc+E1V+NZJWy+se8wVtYW1RLTac7ZtvC
	mev+PwNt6nKmdBIphpwQZqFraFoeIxNcNla1wR8aeotkzu8G9Uaw8OGCUUu7pEUv
	D3qmmkuKOpoMA4c6nTUrF7f9cbajVD0JqNeLCyXS278JPw7vLApEfJLdD3TrKvVG
	1H+jllcjyjStrXtvvkrVpF1Xq95QP+cXXJdD0zMIA9fJWK4pPe+OC0g3rXEuzcbT
	J93oMDyyGRiOeS662DMvwPYB2Xzx+c2HY1PYbt/xdw==
X-ME-Sender: <xms:KiQAZ4Bod3yEYoxu7XZo3-7xoeUjoS54v44n7wvQaMoBcMJRv74a8Q>
    <xme:KiQAZ6iasORw-icSYyg6nAk8RDfNYQPGW5PFSUwXvq9VlkweaqQjPjLyV31tVJSLC
    9GYBrLx7hiXh1V9Og>
X-ME-Received: <xmr:KiQAZ7khZUS548Lj9uFexkcAwbN3Vu2bEqtj11fhuOhO3jL15mNzsPu_qH2AOPcUxoToreBhnA0JtGIAZdHuPrnrYNbPyen9vSfmh9AG0dAIVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffk
    fhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeff
    keeuudekheduffduffffgfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvugguhiiikeejse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurh
    hiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgs
    ohigrdhnvghtpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpd
    hrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohephiho
    nhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehtohhnhidrrg
    hmsggrrhgurghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KiQAZ-z9ysTAJKt1-2QjwimuIn4qIQscgnhWjAU7LATlDDoxU2I4PA>
    <xmx:KiQAZ9TpYyR39pPeDcwH9mtcjWeM2KVTw1IEpPIyfnULgdeWDO0TxA>
    <xmx:KiQAZ5aj9SqmvL-2i6waShT-8yJrBYOuZQ0YfvVHNrAuaN6vB0eEOA>
    <xmx:KiQAZ2T8dFBsJ3bB7mQQxPOy49qWsF-Rv7skRkIQ-dJHvISbPsMrLA>
    <xmx:KiQAZ69xizm4doMZcjo3okRGgehRiSXKVr8kHJOib789BkfXGGiJT5PY>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 13:21:45 -0400 (EDT)
Date: Fri, 4 Oct 2024 11:21:44 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Tony Ambardar <tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix backtrace printing for selftests
 crashes
Message-ID: <wt42qzhzt3xzoxj56h7g3qkqg7cgyouufkilztmfaqrrsocqjm@pbxsgl5uvp5b>
References: <20241003210307.3847907-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003210307.3847907-1-eddyz87@gmail.com>

On Thu, Oct 03, 2024 at 02:03:07PM GMT, Eduard Zingerman wrote:
> test_progs uses glibc specific functions backtrace() and
> backtrace_symbols_fd() to print backtrace in case of SIGSEGV.
> 
> Recent commit (see fixes) updated test_progs.c to define stub versions
> of the same functions with attriubte "weak" in order to allow linking
> test_progs against musl libc. Unfortunately this broke the backtrace
> handling for glibc builds.
> 
> As it turns out, glibc defines backtrace() and backtrace_symbols_fd()
> as weak:
> 
>   $ llvm-readelf --symbols /lib64/libc.so.6 \
>      | grep -P '( backtrace_symbols_fd| backtrace)$'
>   4910: 0000000000126b40   161 FUNC    WEAK   DEFAULT    16 backtrace
>   6843: 0000000000126f90   852 FUNC    WEAK   DEFAULT    16 backtrace_symbols_fd
> 
> So does test_progs:
> 
>  $ llvm-readelf --symbols test_progs \
>     | grep -P '( backtrace_symbols_fd| backtrace)$'
>   2891: 00000000006ad190    15 FUNC    WEAK   DEFAULT    13 backtrace
>  11215: 00000000006ad1a0    41 FUNC    WEAK   DEFAULT    13 backtrace_symbols_fd
> 
> In such situation dynamic linker is not obliged to favour glibc
> implementation over the one defined in test_progs.
> 
> Compiling with the following simple modification to test_progs.c
> demonstrates the issue:
> 
>   $ git diff
>   ...
>   \--- a/tools/testing/selftests/bpf/test_progs.c
>   \+++ b/tools/testing/selftests/bpf/test_progs.c
>   \@@ -1817,6 +1817,7 @@ int main(int argc, char **argv)
>           if (err)
>                   return err;
> 
>   +       *(int *)0xdeadbeef  = 42;
>           err = cd_flavor_subdir(argv[0]);
>           if (err)
>                   return err;
> 
>   $ ./test_progs
>   [0]: Caught signal #11!
>   Stack trace:
>   <backtrace not supported>
>   Segmentation fault (core dumped)
> 
> Resolve this by hiding stub definitions behind __GLIBC__ macro check
> instead of using "weak" attribute.
> 
> Fixes: c9a83e76b5a9 ("selftests/bpf: Fix compile if backtrace support missing in libc")
> 
> CC: Tony Ambardar <tony.ambardar@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 7846f7f98908..005ff506b527 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -20,20 +20,23 @@
>  
>  #include "network_helpers.h"
>  
> +/* backtrace() and backtrace_symbols_fd() are glibc specific,
> + * use header file when glibc is available and provide stub
> + * implementations when another libc implementation is used.
> + */
>  #ifdef __GLIBC__
>  #include <execinfo.h> /* backtrace */
> -#endif
> -
> -/* Default backtrace funcs if missing at link */
> -__weak int backtrace(void **buffer, int size)
> +#else
> +int backtrace(void **buffer, int size)
>  {
>  	return 0;
>  }
>  
> -__weak void backtrace_symbols_fd(void *const *buffer, int size, int fd)
> +void backtrace_symbols_fd(void *const *buffer, int size, int fd)
>  {
>  	dprintf(fd, "<backtrace not supported>\n");
>  }
> +#endif /*__GLIBC__ */
>  
>  int env_verbosity = 0;
>  
> -- 
> 2.46.1
> 
> 

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

