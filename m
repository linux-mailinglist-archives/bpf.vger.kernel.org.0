Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087AE2CDA37
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 16:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgLCPje (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 10:39:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726999AbgLCPjd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 10:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607009887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULBglluUyuIEOB7BNpKecY3zhEPHYVqmO8uyMCf0Hg4=;
        b=EXqZUkvpvyxdRFAKEGKE/II9b2eZ5qJmDwF6vzldVIhiPHPggksYZaMqbSshadg3im4LcB
        QiS8X+ZTn+8SZXhYpYKJ27mvVp8T1lDX2gwNilm9Ir0dPnD8ehFJaLOqwGLdP1bACsDgJx
        iF2fQS9plRke1VXKN0VYhX93lAYUyRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-aFUfveudO9-0hbznFJ1QHw-1; Thu, 03 Dec 2020 10:38:05 -0500
X-MC-Unique: aFUfveudO9-0hbznFJ1QHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED41610054FF;
        Thu,  3 Dec 2020 15:38:03 +0000 (UTC)
Received: from krava (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0E58F10013C0;
        Thu,  3 Dec 2020 15:38:01 +0000 (UTC)
Date:   Thu, 3 Dec 2020 16:38:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Fix cold build of test_progs-no_alu32
Message-ID: <20201203153801.GA3612971@krava>
References: <20201203120850.859170-1-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203120850.859170-1-jackmanb@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 03, 2020 at 12:08:50PM +0000, Brendan Jackman wrote:
> This object lives inside the trunner output dir,
> i.e. tools/testing/selftests/bpf/no_alu32/btf_data.o
> 
> At some point it gets copied into the parent directory during another
> part of the build, but that doesn't happen when building
> test_progs-no_alu32 from clean.

looks good

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 894192c319fb..371b022d932c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -378,7 +378,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
>  			     | $(TRUNNER_BINARY)-extras
>  	$$(call msg,BINARY,,$$@)
>  	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> -	$(Q)$(RESOLVE_BTFIDS) --no-fail --btf btf_data.o $$@
> +	$(Q)$(RESOLVE_BTFIDS) --no-fail --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
>  
>  endef
>  
> 
> base-commit: 97306be45fbe7a02461c3c2a57e666cf662b1aaf
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 

