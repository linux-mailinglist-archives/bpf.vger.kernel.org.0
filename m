Return-Path: <bpf+bounces-33775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63749263B2
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD5B1F22F47
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17017C218;
	Wed,  3 Jul 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLj8fLgq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC16A17C9E1;
	Wed,  3 Jul 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017843; cv=none; b=Y1nufaRshes7fL9oA/N8xRp5M1QLV/tcTAODFXoa3ziiw30uqqnY4Lt3VaoDfTwYkNGoVc67gXvnQboFs+7ZX2rstLypHcax6kivKNEbyldJPtrDf7QFB58PHP7uauxDOyFW5kHM7Mg8J26rZl+FDaaGwXkRWlMkeJpd/EVbVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017843; c=relaxed/simple;
	bh=1G6frJaXsWocJBPh35Kgp8PEnF2epctKJ7kFJyEsgqE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk04Facj/Gm2OHwYFyyDgB4I8HNC8Fyryh+2bMq+/OiqUaFyhL+ySqVeMD/dmUXsgjLFm6+T5f6m2e+j/awXlTpz4XbZNf3lDSq3edbuYyU72sAtMbtMmegX9xkdHRTFZKALF+LXTCg4pHoKWw4DT9OlQvisN4z2sRNboIcTR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLj8fLgq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so61516401fa.2;
        Wed, 03 Jul 2024 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720017840; x=1720622640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gu5inwLfdtzDm+TqJtShP6iW74PqsPzGsEBdQ3OlryU=;
        b=FLj8fLgq5KI8LNdGu7LpA3UDgbThyCeayOpeRIPzmfvoqA1rNAnld8m9VX6We98557
         aWI09YF/RJf6JviaifP+y1S6Jh4TJah0DNWxNs9AA2k8Jqt6pFxaB1DJlxGi2ywm4XvE
         +GAhLkpyiMdJ6wb8kx14lr14nQ+Yr9OrtLHrzPARbNHB34Dj6zozgYHwb2m/udR+ZJ2O
         GzaQp9SUOxJBUBxMkclxs/D9zYlVSRb2s7rmPS+f2fYU3TO3WJxgWsI6AwJI0MDDtU+A
         s88CVOg2Fta/IQxITE4s6PGyoq8BQR6mUSE1YTMFwZA3vlaZ5XhAU6LtTm/i4aan2B7l
         O8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720017840; x=1720622640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu5inwLfdtzDm+TqJtShP6iW74PqsPzGsEBdQ3OlryU=;
        b=C7QeR514DaKDN7E3+bYV1cwBo+fxamRxuBeJ4er/tbJ77cG1KIBvcGKs+SaQ4svrew
         hq8B3fIlEPtJjif80ajcj20SQYG1dpTrx7dUnGItVDYf2Bqjt84kViMcTxGJnz1OSgtz
         XYBf5SJSKmwtwFDR64au2wkbvHgusYLIR5vJs/Bz08BZTf6HL2UwOaRbxTJtt0Biv8u5
         a8ucK46eqjz+mEva6l0jMu+PxEWJBadkMqwTOaHKrp+Ct4+KrT+CKy3TTcZkIPYizzjd
         fzLKbTH6utXgjhA6NrYu6tr1LYEb6WzhjSqLja/lEGwsIbHDjEjTpMqjwf95jsvJJ0+4
         MSdg==
X-Forwarded-Encrypted: i=1; AJvYcCVB2GqdXM2Vj67Q36OhYbMnrH4W5VWUn1wDjmZLfGpKnWV8x414QHH5alHQOuraKU4wZzVzWl8n/v0zyBdETyaQd3lFW5umuOeOA34LZ5itXFXse/3iqPNLOqlqrjA0gJZvTxse0b/sKkddudAuXHmhg5aN3XPN7R/GO8RSgRkS
X-Gm-Message-State: AOJu0Yw9Q41r/zYBZjpO4xPnWpG/IC5bc6dzKVGGHE1UYX04pEyFD8wU
	Ouu42AMq5j2LgBX67ATlG3ICJoHRmGqbftYlsS12yZFxTHULvRGN
X-Google-Smtp-Source: AGHT+IHp/n8cTtXiPbhgFfEro1NtKAB/yrkI29MmfkcMOXbZnXVFZfB7kYsztJoYYTPNnThuyKQJqg==
X-Received: by 2002:a05:651c:2c6:b0:2ec:543f:6013 with SMTP id 38308e7fff4ca-2ee5e3acd8dmr67702871fa.13.1720017839725;
        Wed, 03 Jul 2024 07:43:59 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b098b4dsm243609365e9.29.2024.07.03.07.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 07:43:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 16:43:56 +0200
To: Brian Norris <briannorris@chromium.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tools build: Correct libsubcmd fixdep dependencies
Message-ID: <ZoVjrDMg1XM840tT@krava>
References: <20240702215854.408532-1-briannorris@chromium.org>
 <20240702215854.408532-2-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702215854.408532-2-briannorris@chromium.org>

On Tue, Jul 02, 2024 at 02:58:37PM -0700, Brian Norris wrote:
> All built targets need fixdep to be built first, before handling object
> dependencies [1]. We're missing one such dependency before the libsubcmd
> target.
> 
> This resolves .cmd file generation issues such that the following
> sequence produces many fewer results:
> 
>   $ git clean -xfd tools/
>   $ make tools/objtool
>   $ grep "cannot find fixdep" $(find tools/objtool -name '*.cmd')
> 
> In particular, only a buggy tools/objtool/libsubcmd/.fixdep.o.cmd
> remains, due to circular dependencies of fixdep on itself.
> 
> Such incomplete .cmd files don't usually cause a direct problem, since
> they're designed to fail "open", but they can cause some subtle problems
> that would otherwise be handled by proper fixdep'd dependency files.
> 
> [1] This problem is better described in commit abb26210a395 ("perf
> tools: Force fixdep compilation at the start of the build"). I don't
> apply its solution here, because additional recursive make can be a bit
> of overkill.
> 
> Link: https://lore.kernel.org/all/ZGVi9HbI43R5trN8@bhelgaas/
> Link: https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> 
> (no changes since v1)
> 
>  tools/lib/subcmd/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> index b87213263a5e..59b09f280e49 100644
> --- a/tools/lib/subcmd/Makefile
> +++ b/tools/lib/subcmd/Makefile
> @@ -76,7 +76,7 @@ include $(srctree)/tools/build/Makefile.include
>  
>  all: fixdep $(LIBFILE)
>  
> -$(SUBCMD_IN): FORCE
> +$(SUBCMD_IN): fixdep FORCE
>  	@$(MAKE) $(build)=libsubcmd
>  
>  $(LIBFILE): $(SUBCMD_IN)
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 
> 

