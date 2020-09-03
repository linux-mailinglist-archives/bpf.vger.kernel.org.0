Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B3925C90F
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 21:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgICTEA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 15:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbgICTDy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 15:03:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A92A5208FE;
        Thu,  3 Sep 2020 19:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599159832;
        bh=jMsS9s3JXZ5jBcNkxMfVH5KGVdkLZBPZSBaXJ+aFf/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etuQ0TO6/MGAEYKDoC3PIED6/OTXHLxf0MyK0e1KYxPDYlMWqLmOp5pzODSi342zw
         UfVJePa1hNAuhiKhAcHTq2MjIbqnN3gQ8ijYP8yqtCRADj4zpsi1dONOD0p6jq6140
         3/xiULuU4YWl6WyIhfG5Xujto2nivk1G2aWpw9Do=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D776240D3D; Thu,  3 Sep 2020 16:03:50 -0300 (-03)
Date:   Thu, 3 Sep 2020 16:03:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] tools build feature: cleanup feature files on make clean
Message-ID: <20200903190350.GI3495158@kernel.org>
References: <159851841661.1072907.13770213104521805592.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159851841661.1072907.13770213104521805592.stgit@firesoul>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Aug 27, 2020 at 10:53:36AM +0200, Jesper Dangaard Brouer escreveu:
> The system for "Auto-detecting system features" located under
> tools/build/ are (currently) used by perf, libbpf and bpftool. It can
> contain stalled feature detection files, which are not cleaned up by
> libbpf and bpftool on make clean (side-note: perf tool is correct).
> 
> Fix this by making the users invoke the make clean target.
> 
> Some details about the changes. The libbpf Makefile already had a
> clean-config target (which seems to be copy-pasted from perf), but this
> target was not "connected" (a make dependency) to clean target. Choose
> not to rename target as someone might be using it. Did change the output
> from "CLEAN config" to "CLEAN feature-detect", to make it more clear
> what happens.

Since this mostly touches BPF, should it go via the BPF tree?

- Arnaldo
 
> This is related to the complaint and troubleshooting in link:
> Link: https://lore.kernel.org/lkml/20200818122007.2d1cfe2d@carbon/
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  tools/build/Makefile |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 8462690a039b..02c99bc95c69 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -176,7 +176,11 @@ $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
>  $(OUTPUT)%.o: %.c
>  	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
>  
> -clean: $(LIBBPF)-clean
> +feature-detect-clean:
> +	$(call QUIET_CLEAN, feature-detect)
> +	$(Q)$(MAKE) -C $(srctree)/tools/build/feature/ clean >/dev/null
> +
> +clean: $(LIBBPF)-clean feature-detect-clean
>  	$(call QUIET_CLEAN, bpftool)
>  	$(Q)$(RM) -- $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
>  	$(Q)$(RM) -- $(BPFTOOL_BOOTSTRAP) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 727050c40f09..722f1700d96a 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -38,6 +38,8 @@ clean:
>  	$(call QUIET_CLEAN, fixdep)
>  	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>  	$(Q)rm -f $(OUTPUT)fixdep
> +	$(call QUIET_CLEAN, feature-detect)
> +	$(Q)$(MAKE) -C feature/ clean >/dev/null
>  
>  $(OUTPUT)fixdep-in.o: FORCE
>  	$(Q)$(MAKE) $(build)=fixdep
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index bf8ed134cb8a..bbb89551468a 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -269,10 +269,10 @@ install: install_lib install_pkgconfig install_headers
>  ### Cleaning rules
>  
>  config-clean:
> -	$(call QUIET_CLEAN, config)
> +	$(call QUIET_CLEAN, feature-detect)
>  	$(Q)$(MAKE) -C $(srctree)/tools/build/feature/ clean >/dev/null
>  
> -clean:
> +clean: config-clean
>  	$(call QUIET_CLEAN, libbpf) $(RM) -rf $(CMD_TARGETS)		     \
>  		*~ .*.d .*.cmd LIBBPF-CFLAGS $(BPF_HELPER_DEFS)		     \
>  		$(SHARED_OBJDIR) $(STATIC_OBJDIR)			     \
> 
> 

-- 

- Arnaldo
