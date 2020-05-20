Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC621DAB88
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgETHGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 03:06:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725998AbgETHGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 03:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589958361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12r6Pw0ocdRXl1n2t8Xeq4Bd0G+JXCXMNugfD9+yIIQ=;
        b=NOt9W0hOKDK7e8QGESH6DZCdCQOpOe9KPpiOrLTLqEb8AbTyn4MEtkpIJ9OyJVe1lsKuEg
        zT9Oy/K8HYemGkLAYQaDxBlUNS8tHIMyNFLzs0QRxCxsqgdOLBnol8G42vf72m2GFhJyeT
        kgmtrHNso22M5+9z8Pm4voY3Mqb/77s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-hp6Vo_v5MlSkVVNrj1qJlQ-1; Wed, 20 May 2020 03:05:57 -0400
X-MC-Unique: hp6Vo_v5MlSkVVNrj1qJlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 536AD107ACF2;
        Wed, 20 May 2020 07:05:55 +0000 (UTC)
Received: from krava (unknown [10.40.194.155])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6F14F5D9CA;
        Wed, 20 May 2020 07:05:52 +0000 (UTC)
Date:   Wed, 20 May 2020 09:05:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, mark.rutland@arm.com, guohanjun@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        wangnan0@huawei.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bpf-loader: Add missing '*' for key_scan_pos
Message-ID: <20200520070551.GC110644@krava>
References: <20200520033216.48310-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520033216.48310-1-bobo.shaobowang@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 11:32:16AM +0800, Wang ShaoBo wrote:
> key_scan_pos is a pointer for getting scan position in
> bpf__obj_config_map() for each BPF map configuration term,
> but it's misused when error not happened.
> 
> Fixes: 066dacbf2a32 ("perf bpf: Add API to set values to map entries in a bpf object")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  tools/perf/util/bpf-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 10c187b8b8ea..460056bc072c 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -1225,7 +1225,7 @@ bpf__obj_config_map(struct bpf_object *obj,
>  out:
>  	free(map_name);
>  	if (!err)
> -		key_scan_pos += strlen(map_opt);
> +		*key_scan_pos += strlen(map_opt);

seems good, was there something failing because of this?

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>  	return err;
>  }
>  
> -- 
> 2.17.1
> 

