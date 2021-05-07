Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97F83763FE
	for <lists+bpf@lfdr.de>; Fri,  7 May 2021 12:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhEGKlR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 06:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235438AbhEGKk7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 May 2021 06:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620383997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/V0T7J+D7gJHV9Sw8CtPQMeUoUeDSF0VImP7afgGT4=;
        b=Wj8p4leGEm5UZJWhW9WHB9Z56SjHAhe8s13lrztU+cktT0xSwSaDwn+3+uAM2uGJlbyzXp
        8xKJqy/M7kowmk20FyiPdEeO2s3PlkPs2tNhYVZb4s3Sy2AgoAiCyfOyu6ObceBBBtH8Jj
        VW78RduXIfBXHs1P8rUfUimZ5M8e4Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-jZRuEafkMGqrejuhHTJgfw-1; Fri, 07 May 2021 06:39:55 -0400
X-MC-Unique: jZRuEafkMGqrejuhHTJgfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A9AE80ED91;
        Fri,  7 May 2021 10:39:54 +0000 (UTC)
Received: from krava (unknown [10.40.195.98])
        by smtp.corp.redhat.com (Postfix) with SMTP id F3D1A687C7;
        Fri,  7 May 2021 10:39:52 +0000 (UTC)
Date:   Fri, 7 May 2021 12:39:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        kernel-team@fb.com, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 dwarves] btf: Remove ftrace filter
Message-ID: <YJUY+OvPLWwpj6oA@krava>
References: <20210506205622.3663956-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506205622.3663956-1-kafai@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 06, 2021 at 01:56:22PM -0700, Martin KaFai Lau wrote:
> BTF is currently generated for functions that are in ftrace list
> or extern.
> 
> A recent use case also needs BTF generated for functions included in
> allowlist.  In particular, the kernel
> commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> allows bpf program to directly call a few tcp cc kernel functions. Those
> kernel functions are currently allowed only if CONFIG_DYNAMIC_FTRACE
> is set to ensure they are in the ftrace list but this kconfig dependency
> is unnecessary.
> 
> Those kernel functions are specified under an ELF section .BTF_ids.
> There was an earlier attempt [0] to add another filter for the functions in
> the .BTF_ids section.  That discussion concluded that the ftrace filter
> should be removed instead.
> 
> This patch is to remove the ftrace filter and its related functions.
> 
> Number of BTF FUNC with and without is_ftrace_func():
> My kconfig in x86: 40643 vs 46225
> Jiri reported on arm: 25022 vs 55812
> 
> [0]: https://lore.kernel.org/dwarves/20210423213728.3538141-1-kafai@fb.com/
> 
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
> v2: Remove sym_sec_idx, last_idx, and sh. (Jiri Olsa)

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

