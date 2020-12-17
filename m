Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CE2DCC6A
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 07:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgLQGSF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 01:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgLQGSF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Dec 2020 01:18:05 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8147C061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 22:17:24 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b8so8578617plx.0
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 22:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=90pfmTmsHuz+5sB2VdF6YFhU+G9KnTtl0fTDewKtiIE=;
        b=Cw2IwRCFWbKMxx7VYJr/RZn21FfznRqtP1d5DJSvXpCaCodmEz1t9PIsgHbtiN6EA1
         1w6ZTWAqvEkbCY6ZSfRlNa9sMbTklDdgXST59ET0qJwj6+TwY0Lbkr77ofXD5NC3DDre
         sCF2eTxYkWnLMGm6nGO4tjmuIHnctv1beomt4RntpZAXcZKBZLGpUX4ss4zP6baVRHQQ
         l6EZgeKYRpJvSZfY4y/RfnnLJqSHV7atC0ikE1crIRnXTYxHaI1OXbie8K1PQY5JIPFA
         k2DOtshpYj/UKcqxLK07GIlTunCibq3klGcM1glb2ScEC9THIUyMNtF6nhT6z8MU63ig
         Wljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=90pfmTmsHuz+5sB2VdF6YFhU+G9KnTtl0fTDewKtiIE=;
        b=EL4FPj3qzJwO5neO0081iDGHy1w5DY9DFR4SYJ177lwKeGaMywjXgmJO0BPVB/5gko
         +efTq2I6lIxgtY0tGzfkG+jZohIwwbzbe8GuElgIRuy8TOfdvyTJo24KGIC/7r7+QWsT
         2W1ryx/CLJOs+eAlWhdAzRhI8wLJx8XU9gGN4cN5NNOgWIwnXbRpQMLTGaggL8sD6eTN
         n1YaoBVMmmpNk6DTdVVLcLsYUtSkw9+y1MyssMAzxN5UNkfbPoLWngGT3KzmyBLcjIQ5
         yxQmPwfxJPn65nMKIC7E8zBpWgrk4SevmZDAuCQrhF1zVaveHxY89AoF8evAyF7Efiwv
         X5pw==
X-Gm-Message-State: AOAM533Qfl9eJSUEdJWJ01c55chpbexo91UfeBKZLLhacw20j02F1w+n
        F4pmK/3TDq8q7mBg7j8S2i8=
X-Google-Smtp-Source: ABdhPJxQIGLDrqIQYxIiKSOZ+A6HrLUFNf/aMd52eE2gS1vC2MUqOstIS6h41kJQttJQLV/WfMrTaQ==
X-Received: by 2002:a17:902:9896:b029:dc:2749:ba14 with SMTP id s22-20020a1709029896b02900dc2749ba14mr374420plp.41.1608185844440;
        Wed, 16 Dec 2020 22:17:24 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:5c8d])
        by smtp.gmail.com with ESMTPSA id 92sm3698081pjv.15.2020.12.16.22.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 22:17:23 -0800 (PST)
Date:   Wed, 16 Dec 2020 22:17:21 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, rdna@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Factor out nullable reg type conversion
Message-ID: <20201217061721.hr5xubmcyekmzjae@ast-mbp>
References: <cover.1607973529.git.me@ubique.spb.ru>
 <0ff8927166f6e18e72adab8a94cb6d694c610cc0.1607973529.git.me@ubique.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff8927166f6e18e72adab8a94cb6d694c610cc0.1607973529.git.me@ubique.spb.ru>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 14, 2020 at 11:52:48PM +0400, Dmitrii Banshchikov wrote:
> +	} else if (reg->type == PTR_TO_SOCKET_OR_NULL) {
> +		reg->type = PTR_TO_SOCKET;
> +	} else if (reg->type == PTR_TO_SOCK_COMMON_OR_NULL) {
> +		reg->type = PTR_TO_SOCK_COMMON;
> +	} else if (reg->type == PTR_TO_TCP_SOCK_OR_NULL) {
> +		reg->type = PTR_TO_TCP_SOCK;
> +	} else if (reg->type == PTR_TO_BTF_ID_OR_NULL) {
> +		reg->type = PTR_TO_BTF_ID;
> +	} else if (reg->type == PTR_TO_MEM_OR_NULL) {
> +		reg->type = PTR_TO_MEM;
> +	} else if (reg->type == PTR_TO_RDONLY_BUF_OR_NULL) {
> +		reg->type = PTR_TO_RDONLY_BUF;
> +	} else if (reg->type == PTR_TO_RDWR_BUF_OR_NULL) {
> +		reg->type = PTR_TO_RDWR_BUF;
> +	} else {
> +		return -EINVAL;

In other places we've converted such sequences of if-s into switch
statements. Probably makes sense to do it here as well.
