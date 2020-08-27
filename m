Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7244254538
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgH0Mpn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 08:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729066AbgH0Mo7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Aug 2020 08:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598532297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vr70ALb4ZjXi9RcX6VvF0ywgFtWFCx5BiJCk7jKQduQ=;
        b=OAbozbBvUAfFr4jXnJ5IO8YB/1H94u/YruOvS64QP0RSAJ6PNRp9NGtB9kd5WxTcwl8F51
        69tof1iSIlC/PhRHpZ7G7Z77BweJatSIksKP4jZOmchfbVm5KU40HkleEg46hNyc20aWqd
        wRSXVgKREs7RI+R6hskXtUauriJ1ke8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-rgIfL0zhNvOAoxeX1uhPyQ-1; Thu, 27 Aug 2020 08:44:54 -0400
X-MC-Unique: rgIfL0zhNvOAoxeX1uhPyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02A7C420E7;
        Thu, 27 Aug 2020 12:44:53 +0000 (UTC)
Received: from krava (unknown [10.40.195.119])
        by smtp.corp.redhat.com (Postfix) with SMTP id 94EEB19936;
        Thu, 27 Aug 2020 12:44:48 +0000 (UTC)
Date:   Thu, 27 Aug 2020 14:44:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] tools build feature: cleanup feature files on make clean
Message-ID: <20200827124447.GA77089@krava>
References: <159851841661.1072907.13770213104521805592.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159851841661.1072907.13770213104521805592.stgit@firesoul>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 27, 2020 at 10:53:36AM +0200, Jesper Dangaard Brouer wrote:
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
> 
> This is related to the complaint and troubleshooting in link:
> Link: https://lore.kernel.org/lkml/20200818122007.2d1cfe2d@carbon/

sry, I forgot about this one.. the change looks good to me

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

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

