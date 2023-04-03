Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB56D5375
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 23:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjDCVZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjDCVZC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 17:25:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70FD49C9
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 14:24:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so122773830edb.6
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680557066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AU3aKj8KY9i7lO9JxfTf4VhUDMjVTY2SaeW4vbU2Bk=;
        b=YnDGvAZOhkhCG7ploAB3QhjASi9uzK8yTwEevWmL7AQwxKBnT3j6mRaJLYxsr/8vAe
         YIZxBLk/oIuT/ZgPzEtvG1C/Z+nMttSkFBrKpe5u6zg+sl7JTh3KvVWbwXs/3PHSDcA3
         9EncD47hU3mCxOmieqvF1+6zkb+RgoGHOPwKg4EU41eg1r/dNy8kXt0JVhDRw5pq8vSv
         z1j2gLfnmaFe3GD/ALgBRF8KLQPuFKPVS+OggHoLQ2z9tM3oLRPocd+M8Qwr586Gnb/8
         GdoUXReyp+YglcZmJtjOnmN6XvOxCaLihf9/8t3iX0IG8rDpNIEAnBkxAOPd9BqjoMuz
         rTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680557066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AU3aKj8KY9i7lO9JxfTf4VhUDMjVTY2SaeW4vbU2Bk=;
        b=ITSaunSD+ptc3/qSsSh0FwhlH2q34a8uAFdYi0KHa7pYUep7ZfY6t1F2UZE9nNW+m9
         DPGyouGYBZw1l7iyzasYY8BprqQUx99mAUR7T5nMZoUPT9MDMp0u1+6LChfmn2DY9ujA
         YZa2HqFmauYA0CgzCii4cprNoNNHaH9dFJ853MR40I/y19eqIOaN8d9ww0Y0++1lFCXT
         YgdtQ7BVsDNc8MfA5kY3W5CuOMFcMDn9DNyt6WkVFQaBR7nO2h0pDZMvR2r17vQia740
         zQrgrWYl8MOrgs4bt8pKi5BSzgnt5R0ZpM1oG8w/2fm5MHupunGjmAiID3+CtkX5BrDQ
         tyAA==
X-Gm-Message-State: AAQBX9dvAYpGqzdzjdbiLgYm17Obn4qKW/fLUjHxPuYVGoaDCZ1xLLxh
        Bie0psWryHRoU9uUiB7nD8cZuBt8dNPdoA==
X-Google-Smtp-Source: AKy350ajTEgq2vk9IgEjx1SJhGntIogRYz5mxnjTy6lemxBgf70g5ZldfXQJ8KBodEOSIInl0xZlIw==
X-Received: by 2002:a17:906:b42:b0:947:726e:f43a with SMTP id v2-20020a1709060b4200b00947726ef43amr86263ejg.23.1680557065798;
        Mon, 03 Apr 2023 14:24:25 -0700 (PDT)
Received: from krava ([83.240.62.56])
        by smtp.gmail.com with ESMTPSA id g19-20020a170906c19300b0093313f4fc3csm5045791ejz.70.2023.04.03.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:24:25 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 3 Apr 2023 23:24:22 +0200
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add RESOLVE_BTFIDS dependency to
 bpf_testmod.ko
Message-ID: <ZCtEBsPMj48Wwfc/@krava>
References: <20230403172935.1553022-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403172935.1553022-1-iii@linux.ibm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 03, 2023 at 07:29:35PM +0200, Ilya Leoshkevich wrote:
> bpf_testmod.ko sometimes fails to build from a clean checkout:
> 
>     BTF [M] linux/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.ko
>     /bin/sh: 1: linux-build//tools/build/resolve_btfids/resolve_btfids: not found
> 
> The reason is that RESOLVE_BTFIDS may not yet be built. Fix by adding a
> dependency.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 4a8ef118fd9d..febd1dae6c88 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -201,7 +201,7 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
>  		  $< -o $@ \
>  		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
>  
> -$(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
> +$(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
>  	$(call msg,MOD,,$@)
>  	$(Q)$(RM) bpf_testmod/bpf_testmod.ko # force re-compilation
>  	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_testmod
> -- 
> 2.39.2
> 
