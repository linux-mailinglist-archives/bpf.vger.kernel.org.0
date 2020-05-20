Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8851DB033
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 12:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgETKaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 06:30:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726720AbgETKaO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 May 2020 06:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589970613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGTpfrIIrUndkAVZ2N+k9ch+ZMAMk2llwppj8ZkxQsA=;
        b=eOqHqyKaQZd28mxeMDb3uJLEKaoLjIwCpg2ObiNRJUAU+eI5j3Oic9TFGZionyKD4h2Kmb
        nxI1YKCHxM5eZ5JciCc1xIlmygb7TlVFoXEKFDwgm+UpNjtJYx6cp6oqADGJqJb+mSJb6o
        6AMD+IpbYFaV4nltjrHHhovMY47eqgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-HjzYvl8oOT65HFROhg83fg-1; Wed, 20 May 2020 06:30:11 -0400
X-MC-Unique: HjzYvl8oOT65HFROhg83fg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C84FB1800D42;
        Wed, 20 May 2020 10:30:09 +0000 (UTC)
Received: from krava (unknown [10.40.193.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 408F960BEC;
        Wed, 20 May 2020 10:30:06 +0000 (UTC)
Date:   Wed, 20 May 2020 12:30:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, mark.rutland@arm.com, guohanjun@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        wangnan0@huawei.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bpf-loader: Add missing '*' for key_scan_pos
Message-ID: <20200520103006.GA157452@krava>
References: <20200520033216.48310-1-bobo.shaobowang@huawei.com>
 <20200520070551.GC110644@krava>
 <ac38c44e-ebce-28eb-37f5-bf05572b9232@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac38c44e-ebce-28eb-37f5-bf05572b9232@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 06:22:12PM +0800, Wangshaobo (bobo) wrote:
> 
> 在 2020/5/20 15:05, Jiri Olsa 写道:
> > On Wed, May 20, 2020 at 11:32:16AM +0800, Wang ShaoBo wrote:
> > > key_scan_pos is a pointer for getting scan position in
> > > bpf__obj_config_map() for each BPF map configuration term,
> > > but it's misused when error not happened.
> > > 
> > > Fixes: 066dacbf2a32 ("perf bpf: Add API to set values to map entries in a bpf object")
> > > Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> > > ---
> > >   tools/perf/util/bpf-loader.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > > index 10c187b8b8ea..460056bc072c 100644
> > > --- a/tools/perf/util/bpf-loader.c
> > > +++ b/tools/perf/util/bpf-loader.c
> > > @@ -1225,7 +1225,7 @@ bpf__obj_config_map(struct bpf_object *obj,
> > >   out:
> > >   	free(map_name);
> > >   	if (!err)
> > > -		key_scan_pos += strlen(map_opt);
> > > +		*key_scan_pos += strlen(map_opt);
> > seems good, was there something failing because of this?
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > thanks,
> > jirka
> 
>   I found this problem when i checked this code, I think it is
> 
>   an implicit question, but if we delete the two line,  the problem
> 
>   also no longer exists.

and what's the actual problem, what's broken?

jirka

> 
>   thanks,
> 
>   Wang ShaoBo
> 
> 

