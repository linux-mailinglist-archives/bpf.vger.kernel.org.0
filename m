Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A63491086
	for <lists+bpf@lfdr.de>; Mon, 17 Jan 2022 19:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiAQS5K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jan 2022 13:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiAQS5K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jan 2022 13:57:10 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44AC061574
        for <bpf@vger.kernel.org>; Mon, 17 Jan 2022 10:57:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d3so61093936lfv.13
        for <bpf@vger.kernel.org>; Mon, 17 Jan 2022 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=p4+ifsKtrSTkHTpLkWcmY2OfN5Ym/bKgcmz1lLUBtYM=;
        b=DTwI5XgzGarM9ok8xQpMm8BtFl5faZMvXUHNjdd+w3c6+gEXhaGftYbZ3ZbugOUlaI
         o1yyj/pfLiLYIpIHW+osyPrPj2hSJSovN+ad0fVZTfxSi3+PVEwleqtpmBOqbxTPBm1C
         4qzKTPPWLlB/+2dtvTpQZoLzk4Ys6VMU0+85o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=p4+ifsKtrSTkHTpLkWcmY2OfN5Ym/bKgcmz1lLUBtYM=;
        b=XdzIQd/ExGRHYmLKdvy7tsO1rLs/qMilvzRVJKkZsAWnCT92LsOjGBS1pq+Mm+tLSU
         43Dn7XNwIX1GhnSzMCfr1by/KBK6xfn9+r+pKmTR9N1zBBbgEegDCUddsIVo3zrjbe2f
         a0+b1m38P4gQpUfr4T/5rTpzkeGJtG6cmhdhJtcLoSKUNGU/fv1Y2yGAyns3XWk7UB3J
         yaq3gNGCjkf26Kllb27USPh6PWDUHPl9ARjYqj6bDbrJyNPjoDrtgBrHQGk7c0qBakh9
         hoysroFuc+p6EUoVymPDdnPsh428F77aaZxrFo1vrZyH4ZZGgRkNLXCq+CPi41rse+Ez
         SBxA==
X-Gm-Message-State: AOAM532M9yorGVJorHKaQ1pDMESNLlDtVLBqaPu/FDZ0dnpvOyn4y6em
        2w0CRhd2TSoi6+vkduBQIS7JcZRgr6WIug==
X-Google-Smtp-Source: ABdhPJzy4SdEGN9DXWUz6Szo0jfSSPltNNIgbksq4c+3xuwAmzMEWx29IE8TBRNUMQR68c3CRJvR+g==
X-Received: by 2002:a2e:86c7:: with SMTP id n7mr14091387ljj.102.1642445828162;
        Mon, 17 Jan 2022 10:57:08 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id s18sm1051702lfs.23.2022.01.17.10.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 10:57:07 -0800 (PST)
References: <20220117140728.167736-1-fmaurer@redhat.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Felix Maurer <fmaurer@redhat.com>
Cc:     bpf@vger.kernel.org, sdf@google.com, kafai@fb.com, ast@kernel.org
Subject: Re: [PATCH bpf] selftests: bpf: Fix bind on used port
In-reply-to: <20220117140728.167736-1-fmaurer@redhat.com>
Date:   Mon, 17 Jan 2022 19:57:07 +0100
Message-ID: <87zgnunqbg.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 17, 2022 at 03:07 PM CET, Felix Maurer wrote:
> The bind_perm BPF selftest failed when port 111/tcp was already in use
> during the test. To fix this, the test now runs in its own network name
> space.
>
> To use unshare, it is necessary to reorder the includes. The style of
> the includes is adapted to be consistent with the other prog_tests.
>
> Fixes: 8259fdeb30326 ("selftests/bpf: Verify that rebinding to port < 1024 from BPF works")
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---
>  .../selftests/bpf/prog_tests/bind_perm.c      | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
> index d0f06e40c16d..cbd739d36e4d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bind_perm.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
> @@ -1,13 +1,26 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <test_progs.h>
> -#include "bind_perm.skel.h"
> -
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <stdlib.h>
>  #include <sys/types.h>
>  #include <sys/socket.h>
>  #include <sys/capability.h>
>  
> +#include "test_progs.h"
> +#include "bind_perm.skel.h"
> +
>  static int duration;
>  
> +static int create_netns(void)
> +{
> +	if (CHECK(unshare(CLONE_NEWNET), "create netns",
> +		  "unshare(CLONE_NEWNET): %s (%d)",
> +		  strerror(errno), errno))

CHECK() macro is deprecated. See [1].

[1] https://lore.kernel.org/bpf/20220107221115.326171-2-toke@redhat.com/

[...]
