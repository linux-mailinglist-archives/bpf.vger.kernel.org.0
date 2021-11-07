Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0B4473D9
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 17:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhKGQhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Nov 2021 11:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKGQhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Nov 2021 11:37:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D56C061570
        for <bpf@vger.kernel.org>; Sun,  7 Nov 2021 08:34:27 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id p17so13038459pgj.2
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e5ViK/GMepA9rWNuZCvCcH/TZSuE7AxWxFaCYbj5zyo=;
        b=ci5Cu2XF4a98cKfgnakUnzwOayVuo9uIxS0hDzRLKiLOo88TPBD+FaDIIVCBEleFPE
         z8uoil/uSZ7qBX36aISDuAjdnMNnlyT2PCWsiJCnCxOzezplZ6yFNAPL1vzlj0TWCDKa
         RK93W5WPy3+WtiVKAdxN4Aj7ld7GItA12y4ym4pW9uFuGfZtUfgOOu2SAeEYRuEaAd6Y
         WWA1EDfqbmqKNZmXS7G6E53j7vZcenlodhy2OL9skqFJ/eaat8108RNuKR28bvAFoeIi
         LyhBSGMJxan0afEafnrJF4RIlHfDWV2lVReyKMr/zQKh+B3JExQyU67nRSZuTYQsglaj
         tcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e5ViK/GMepA9rWNuZCvCcH/TZSuE7AxWxFaCYbj5zyo=;
        b=tPcpo6qK3dEzQ0RaXtlG2Uti/aCdgATz2tbD9dO5Jc9F6tiAe1is9/FryYGC9uZxlZ
         Cwm1eaT10G2XVG1aQfp4L7DWNVItpqlhBgUmMWEeInARKjK4ndCnfeQPqokPNj2R3Hq9
         s9y/JUNCZwQcyWimDF7b+gfWP0iVcpbywTnWmKWZ3xMf0IZ0Kx0EZa3v+0JtOKrOK1z9
         CtmYC3CXKxHk2Nb/7hSSUMgFGTNfOBNUnd2OOjx8CQagsqIzEFKrqlpXA3M/2CKz59Re
         PL4p6vmm1b2k1d6xavEfx64a1GCwY9iYsSuA9EYKThTIn65WwasylQieDzfU6C/gExPg
         8CRg==
X-Gm-Message-State: AOAM532A7v3Wgmogwy5mUSEMAj3dayZWA/kUv6aC4xfdUIPkMAIchQZD
        Pcrr5t4BgYO7EJjF6xcGVdQ=
X-Google-Smtp-Source: ABdhPJzNCl9YSBNhxji0chyFppWbegHIBzahBE9aZdKK2j/Jh4MXe3J/AKcwTxAWnxJ2McOob4TKAQ==
X-Received: by 2002:a65:6158:: with SMTP id o24mr55715992pgv.141.1636302867442;
        Sun, 07 Nov 2021 08:34:27 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.112])
        by smtp.gmail.com with ESMTPSA id h3sm14003545pfi.207.2021.11.07.08.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 08:34:27 -0800 (PST)
Message-ID: <604aa1cc-53fe-631b-42fc-8ff76a2e3010@gmail.com>
Date:   Mon, 8 Nov 2021 00:34:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 4/9] selftests/bpf: free per-cpu values array
 in bpf_iter selftest
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20211107040343.583332-1-andrii@kernel.org>
 <20211107040343.583332-5-andrii@kernel.org>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <20211107040343.583332-5-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii

On 2021/11/7 12:03 PM, Andrii Nakryiko wrote:
> Array holding per-cpu values wasn't freed. Fix that.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 9454331aaf85..71c724a3f988 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -770,6 +770,7 @@ static void test_bpf_percpu_hash_map(void)
>  	bpf_link__destroy(link);
>  out:
>  	bpf_iter_bpf_percpu_hash_map__destroy(skel);
> +	free(val);
>  }
>  
>  static void test_bpf_array_map(void)
> 

The val is allocated at the very beginning of this function,
when bpf_iter_bpf_percpu_hash_map__open failed, the val still
leaked.

So we should have:

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 9454331aaf85..ee6727389ef6 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -686,7 +686,7 @@ static void test_bpf_percpu_hash_map(void)
 {
        __u32 expected_key_a = 0, expected_key_b = 0;
        DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
-       struct bpf_iter_bpf_percpu_hash_map *skel;
+       struct bpf_iter_bpf_percpu_hash_map *skel = NULL;
        int err, i, j, len, map_fd, iter_fd;
        union bpf_iter_link_info linfo;
        __u32 expected_val = 0;
@@ -704,7 +704,7 @@ static void test_bpf_percpu_hash_map(void)
        skel = bpf_iter_bpf_percpu_hash_map__open();
        if (CHECK(!skel, "bpf_iter_bpf_percpu_hash_map__open",
                  "skeleton open failed\n"))
-               return;
+               goto out;
 
        skel->rodata->num_cpus = bpf_num_possible_cpus();
 
@@ -770,6 +770,7 @@ static void test_bpf_percpu_hash_map(void)
        bpf_link__destroy(link);
 out:
        bpf_iter_bpf_percpu_hash_map__destroy(skel);
+       free(val);
 }
 
 static void test_bpf_array_map(void)

Right?

Cheers,
--
Hengqi
