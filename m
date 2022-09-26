Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587365EA1DE
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 12:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiIZK7v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiIZK6h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 06:58:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EA85005C
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 03:30:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cc5so9490936wrb.6
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/qpA/s9So4CQym0XN6SnVSyJUxmnB/g87o+5oKKKYAE=;
        b=Djoce0K1Val6lrU3JnXu7eoz7V3AO4okZ9E8UAFwyrH5W0kq/vMN/fUcTUlg8aZhNk
         k8EjCwZw5P5cGoimHtn0fHYegpf8sCWCwlNMCitvKe1jeAbqpaEK7Ft1nJw9y2fs8dk3
         UEljwXGJ9Jud53F1mIfsRjhfNWdaDRWfHoWZARnym+WVXHLxFWnogWViwqqvANMM3CJ5
         //i9OFW8FjfVEtOxJsqjf2KkEXr70rCUrq0zkqJ7JKYbwNL9Jglr2qcb/FOgW9Huma8W
         78kTBHR2ltVI0Qmn5ZMu5grEt/GrRJ16vxmkahgsg2oCkjtzDKBh8swvVdjrv09QwNzV
         BfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/qpA/s9So4CQym0XN6SnVSyJUxmnB/g87o+5oKKKYAE=;
        b=Zrn5xSUGQx3c3KHsmjqk7utijmMXgbhe2sXScdd0BkhsaQNtQRn/ZSYKvk8uWgNOxL
         7ki53rfDxJBMe6YqxdEjImpZlaenP+mOPNHZpvs8qHNEQ1Hy+aioOQZKN9uETBTTvoJT
         iViXyYGhQ7k5D43Y8GPM88SgIOyZl/jr8Kk9XnIFRYvpRdV7Sp2bCVW+yzJHje65fRk7
         yyJ5FKyGCZa5AcWUr/hnxGXTLzpu6701X7QfMlLAyzvK8G7S8BtNUKlKTs4mvkxsZ71w
         TcADHQP/ZVT79E7OKEIfxMrDmXtN4WBA1v/tdhgABPE4utwJvjL46mCfT31Nw82EYU0F
         XW+A==
X-Gm-Message-State: ACrzQf0XtVD+zKBmschB+EuSHQof0MavLd+zq6WUO6t1BUy6qmDCb9Y7
        s1Dg/XGJxgp+0jYwgMflQVAf6xrh3p+SzQ==
X-Google-Smtp-Source: AMsMyM4v6QhxR4DmvYmx3ZtP8/RN/ddZiv2aKJCzYQIFSx69j8OmxeuHOVKdW/HxPGmLijbFIzLyTg==
X-Received: by 2002:a05:6000:1ac9:b0:22a:cc07:9cfe with SMTP id i9-20020a0560001ac900b0022acc079cfemr12703558wry.186.1664188130374;
        Mon, 26 Sep 2022 03:28:50 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id z21-20020a05600c0a1500b003b47a99d928sm10887566wmp.18.2022.09.26.03.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 03:28:49 -0700 (PDT)
Message-ID: <b093e394-b655-bac2-f2a6-bcf2f3846b21@isovalent.com>
Date:   Mon, 26 Sep 2022 11:28:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] bpftool: Fix error prompt of strerror
Content-Language: en-GB
To:     Tianyi Liu <i.pear@outlook.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
References: <SY4P282MB1084B61CD8671DFA395AA8579D539@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <SY4P282MB1084B61CD8671DFA395AA8579D539@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sun Sep 25 2022 17:18:32 GMT+0100 ~ Tianyi Liu <i.pear@outlook.com>
> strerror() excepts a posivite errno, however libbpf_get_error()

s/excepts/expects/

> or variable err will never be positive when an error occurs.
> This causes bpftool to output too many "unknown error", even a simple
> "file not exist" error can't get an accurate prompt.

“prompt” (here and in commit title) sounds a bit odd to me in that
context, I'd say error string/message.

> This patch fixed all "strerror(err)" patten in bpftool.

s/patten/patterns/

> 
> Signed-off-by: Tianyi Liu <i.pear@outlook.com>
> ---
>  tools/bpf/bpftool/btf.c           | 6 +++---
>  tools/bpf/bpftool/gen.c           | 4 ++--
>  tools/bpf/bpftool/map_perf_ring.c | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 0744bd115..ac586c0e5 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -643,7 +643,7 @@ static int do_dump(int argc, char **argv)
>  		if (err) {
>  			btf = NULL;
>  			p_err("failed to load BTF from %s: %s",
> -			      *argv, strerror(err));
> +			      *argv, strerror(errno));
>  			goto done;
>  		}
>  		NEXT_ARG();
> @@ -689,7 +689,7 @@ static int do_dump(int argc, char **argv)
>  		btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
>  		err = libbpf_get_error(btf);
>  		if (err) {
> -			p_err("get btf by id (%u): %s", btf_id, strerror(err));
> +			p_err("get btf by id (%u): %s", btf_id, strerror(errno));
>  			goto done;
>  		}
>  	}
> @@ -825,7 +825,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
>  				      u32_as_hash_field(id));
>  		if (err) {
>  			p_err("failed to append entry to hashmap for BTF ID %u, object ID %u: %s",
> -			      btf_id, id, strerror(errno));
> +			      btf_id, id, strerror(-err));
>  			goto err_free;
>  		}
>  	}
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 7070dcffa..0783069f6 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1594,14 +1594,14 @@ static int do_object(int argc, char **argv)
>  
>  		err = bpf_linker__add_file(linker, file, NULL);
>  		if (err) {
> -			p_err("failed to link '%s': %s (%d)", file, strerror(err), err);
> +			p_err("failed to link '%s': %s (%d)", file, strerror(errno), err);

Here and below, it would look more consistent to me to pass "errno" as
the last argument as well.

>  			goto out;
>  		}
>  	}
>  
>  	err = bpf_linker__finalize(linker);
>  	if (err) {
> -		p_err("failed to finalize ELF file: %s (%d)", strerror(err), err);
> +		p_err("failed to finalize ELF file: %s (%d)", strerror(errno), err);
>  		goto out;
>  	}
>  
> diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
> index 6b0c41015..1650b7127 100644
> --- a/tools/bpf/bpftool/map_perf_ring.c
> +++ b/tools/bpf/bpftool/map_perf_ring.c
> @@ -198,7 +198,7 @@ int do_event_pipe(int argc, char **argv)
>  	err = libbpf_get_error(pb);
>  	if (err) {
>  		p_err("failed to create perf buffer: %s (%d)",
> -		      strerror(err), err);
> +		      strerror(errno), err);
>  		goto err_close_map;
>  	}
>  
> @@ -213,7 +213,7 @@ int do_event_pipe(int argc, char **argv)
>  		err = perf_buffer__poll(pb, 200);
>  		if (err < 0 && err != -EINTR) {
>  			p_err("perf buffer polling failed: %s (%d)",
> -			      strerror(err), err);
> +			      strerror(errno), err);
>  			goto err_close_pb;
>  		}
>  	}

Thanks a lot for the fix, but please see Andrii's comment on the other
thread [0]: now that bpftool relies on libbpf 1.0, the correct update
for these error checks would be to remove the calls to
libbpf_get_error() and to check directly for NULL values/errno, so we
won't need to check "err" and won't get the confusion about what
variable to use for the error messages.

[0]:
https://lore.kernel.org/bpf/CAEf4Bzaskw74UeufRgKSbGtk5eybD9J+4keAPYb-u=jb5myLjw@mail.gmail.com/
