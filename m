Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4432CD9EC
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 16:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgLCPMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 10:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbgLCPMO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 10:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607008247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IBftimYBdL+rPRjoBGoNau5FbS8yM8qo7/BB2RqpMY4=;
        b=a1PoymhM7/469CZiCbbrMQ8xZR7IlXKdOprCDvR9ThLPrh1bcaHAV4181s+4aaRAHT3wPt
        nNzu8XP+GbScCwMf4JtN/rX+ofC8XYzdJwTtVRjS+S3f68QVkQVG2suPthh6EfzVoc6vO0
        DGBAgMdkt5T3+xbd/6K0g23k+rRLn3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-WLVmL-oKMzq2YN7CX2rNpQ-1; Thu, 03 Dec 2020 10:10:43 -0500
X-MC-Unique: WLVmL-oKMzq2YN7CX2rNpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3835E1034AF3;
        Thu,  3 Dec 2020 15:10:41 +0000 (UTC)
Received: from krava (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id CFF3719C44;
        Thu,  3 Dec 2020 15:10:38 +0000 (UTC)
Date:   Thu, 3 Dec 2020 16:10:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Fix some error messages
Message-ID: <20201203151037.GC3518322@krava>
References: <20201203102234.648540-1-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203102234.648540-1-jackmanb@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 03, 2020 at 10:22:34AM +0000, Brendan Jackman wrote:
> Add missing newlines and fix polarity of strerror argument.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/bpf/resolve_btfids/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index dfa540d8a02d..e3ea569ee125 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -454,7 +454,7 @@ static int symbols_collect(struct object *obj)
>  			return -ENOMEM;
>  
>  		if (id->addr_cnt >= ADDR_CNT) {
> -			pr_err("FAILED symbol %s crossed the number of allowed lists",
> +			pr_err("FAILED symbol %s crossed the number of allowed lists\n",
>  				id->name);
>  			return -1;
>  		}
> @@ -477,8 +477,8 @@ static int symbols_resolve(struct object *obj)
>  	btf = btf__parse(obj->btf ?: obj->path, NULL);
>  	err = libbpf_get_error(btf);
>  	if (err) {
> -		pr_err("FAILED: load BTF from %s: %s",
> -			obj->path, strerror(err));
> +		pr_err("FAILED: load BTF from %s: %s\n",
> +			obj->path, strerror(-err));
>  		return -1;
>  	}
>  
> 
> base-commit: 97306be45fbe7a02461c3c2a57e666cf662b1aaf
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 

