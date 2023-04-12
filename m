Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40416DFD69
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDLSYk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 14:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDLSYk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 14:24:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56117273F
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:24:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so625211a12.1
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681323878; x=1683915878;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=twvA5hfpOp6xtSv34s4W17pWwb8SiU+eK1gg2pCTrU4=;
        b=TdnyrNivmvZnmk+BtjlTnH4B+XWEloSSbfRrCL00GoNhOExwJR1V+oRHhEUmClIbG+
         npuN23sueFZh8YVv4+4CrnlOB1g6bnb4qEy82rO8TNjIMLofYnVxxiFrN2Yoybgh8+CG
         doLIZ+bfmwagRHS5of9OzTccLBP+NEOWUIuto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323878; x=1683915878;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twvA5hfpOp6xtSv34s4W17pWwb8SiU+eK1gg2pCTrU4=;
        b=VlyCepzXud6vdAcoJObzHF8D5ZX4Iy47wi/7ny+tiXSvv9IU7lg7GGwqBGow4LUfGm
         dWl4HvNN6G4gY7gVxN641sPvFtNmAg9vOixmnpYNy1bZeoEQEd/pNucybu7T2jEZSxKY
         xW1JF9IC9dt7mtzxw4XSV4KZTHeSXiPgwlMM4ODBEmI+uUzqCckkPfRqdi12aqlvnYuJ
         c5uvSAXmz01iAK0YpOXIPTyMo5nfZ26Fug4vMyi6OLqVHQ0/2eEiQeTL3Qv0FbJUN0KM
         UqsKI83N5jnqCtZrKq0YqQbAUdX5NhDkl/Ov4OaUKN6SO44k0Zk5rkE4SLnmjcNkOenB
         /wow==
X-Gm-Message-State: AAQBX9eDLzQm2sxNWJSDPiFxd2mkRyX1wGqcpqYr59z1E1+jFNH2nU2U
        XsTiyFV5zs/6BrMeU8ifP+rz3g==
X-Google-Smtp-Source: AKy350aDkKeBLxBImYkD4qYDxoK/yC60VBJYFjcSOtkpHmW1tdLb3bAHkzODPu9CS3obT8xq7cjeOA==
X-Received: by 2002:aa7:843a:0:b0:63a:e959:1499 with SMTP id q26-20020aa7843a000000b0063ae9591499mr8478501pfn.20.1681323878353;
        Wed, 12 Apr 2023 11:24:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n4-20020aa78a44000000b006338e0a9728sm8361316pfa.109.2023.04.12.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:24:37 -0700 (PDT)
Message-ID: <6436f765.a70a0220.1091d.f714@mx.google.com>
X-Google-Original-Message-ID: <202304121124.@keescook>
Date:   Wed, 12 Apr 2023 11:24:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 6/8] bpf: drop unnecessary bpf_capable() check
 in BPF_MAP_FREEZE command
References: <20230412043300.360803-1-andrii@kernel.org>
 <20230412043300.360803-7-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412043300.360803-7-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 11, 2023 at 09:32:58PM -0700, Andrii Nakryiko wrote:
> Seems like that extra bpf_capable() check in BPF_MAP_FREEZE handler was
> unintentionally left when we switched to a model that all BPF map
> operations should be allowed regardless of CAP_BPF (or any other
> capabilities), as long as process got BPF map FD somehow.
> 
> This patch replaces bpf_capable() check in BPF_MAP_FREEZE handler with
> writeable access check, given conceptually freezing the map is modifying
> it: map becomes unmodifiable for subsequent updates.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Is this patch stand-alone? It seems like this could be taken separately,
or at least just be the first patch in the series?

> ---
>  kernel/bpf/syscall.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7d1165814efc..42d8473237ab 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2001,6 +2001,11 @@ static int map_freeze(const union bpf_attr *attr)
>  		return -ENOTSUPP;
>  	}
>  
> +	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
> +		err = -EPERM;
> +		goto err_put;
> +	}
> +
>  	mutex_lock(&map->freeze_mutex);
>  	if (bpf_map_write_active(map)) {
>  		err = -EBUSY;
> @@ -2010,10 +2015,6 @@ static int map_freeze(const union bpf_attr *attr)
>  		err = -EBUSY;
>  		goto err_put;
>  	}
> -	if (!bpf_capable()) {
> -		err = -EPERM;
> -		goto err_put;
> -	}
>  
>  	WRITE_ONCE(map->frozen, true);
>  err_put:
> -- 
> 2.34.1
> 

-- 
Kees Cook
