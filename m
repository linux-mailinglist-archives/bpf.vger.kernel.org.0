Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907EB325B53
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 02:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhBZBbc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 20:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBZBba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 20:31:30 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09ABC061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 17:30:49 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id f20so8035596ioo.10
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 17:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nCkwlzJxFxKgZpI7tDN0eGwTDeNKvVAapM2daIrekJo=;
        b=pKtnlGgV5tu3g7GQyv5YU6y2NgF/hkoS+qgxEUUyrb3ea3u1ufhW++qUSf4Rz4MM9z
         MkCGTzQj3HY9X54tCBKUb4ABR9FtDeyJtBGN951LkGgLneu2CVg8DYQhQ8AHmqqGVJ/B
         rYXdAiF82FwMZImvD3kt5BLtM/o85qLTOdDmsVDG8ZbntLRXb/3rBvh9S3EgiM7rKCU6
         1DZHUk0pnxxeqN2IdgTJ1/t1sXs5RCd70wuoCCVF+gKcfxSFaRC6E9qKeY6XGmwI87Ve
         6aETBX/nZctemnFHXfFITrnIfZ4aGnBml8uW+ZHamcgEeykI+Bw9EcqrCGXHNzUn3lib
         UutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nCkwlzJxFxKgZpI7tDN0eGwTDeNKvVAapM2daIrekJo=;
        b=O78q+r1wPUKjNWh0xdtQ9limPY1ZmK85RtjaOGRRDA0R4Y0DtxKg842I7IUdzXMIpb
         MYwDxz2cgj05URFvkZF04nyvB3ArRml7KN2+IkS3nJ4kPX2HASaUMIpZp9giNlyuO4gs
         hWtuXtZO1OOjeSU8QX06txCp1aYgDxZA4v9qYEeh0xslO+s7ybS3xcJCZsn0R43J+xya
         qoTeLAMoPvdSfValZky//KVrQHgKeknCX/W+HXT6o03QFKqF0blmw9fjWPz7WGvEm7X7
         YJJtvVTa6KQzW8GX9FPerIAJtd8Q7Krv0ZFo3jtn8sFO+GRb3fvxFuwKZAhL3lna4icu
         LgMg==
X-Gm-Message-State: AOAM532QLinPIDzLOoGjy9vsvELi1BlOJPxbvlm+pf6WcTLqwF5L9pJw
        WFBSeVtzuVfuZ4rVPXWzkmQ=
X-Google-Smtp-Source: ABdhPJzjp0iFsEAq6xVD1ltzLG0j0J08B/i6jwWsAjjFeHHcgkl+WD+ANssZwXXErEfJN6l4hlf/uA==
X-Received: by 2002:a05:6638:35ac:: with SMTP id v44mr581312jal.103.1614303048736;
        Thu, 25 Feb 2021 17:30:48 -0800 (PST)
Received: from localhost ([172.243.146.206])
        by smtp.gmail.com with ESMTPSA id y5sm4020281ilh.24.2021.02.25.17.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:30:48 -0800 (PST)
Date:   Thu, 25 Feb 2021 17:30:38 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <60384f3e68e80_5c31208ed@john-XPS-13-9370.notmuch>
In-Reply-To: <20210224234535.106970-4-iii@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
 <20210224234535.106970-4-iii@linux.ibm.com>
Subject: RE: [PATCH v6 bpf-next 3/9] libbpf: Add BTF_KIND_FLOAT support
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich wrote:
> The logic follows that of BTF_KIND_INT most of the time. Sanitization
> replaces BTF_KIND_FLOATs with equally-sized empty BTF_KIND_STRUCTs on
> older kernels, for example, the following:
> 
>     [4] FLOAT 'float' size=4
> 
> becomes the following:
> 
>     [4] STRUCT '(anon)' size=4 vlen=0
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---

[...]

> @@ -2445,6 +2450,10 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>  		} else if (!has_func_global && btf_is_func(t)) {
>  			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
>  			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
> +		} else if (!has_float && btf_is_float(t)) {
> +			/* replace FLOAT with an equally-sized empty STRUCT */
> +			t->name_off = 0;

Can we keep the name_off from btf__add_float()? Or just explain why
we zero it here, its not obvious to me at least.

> +			t->info = BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 0);
>  		}
>  	}
>  }
> @@ -3882,6 +3891,18 @@ static int probe_kern_btf_datasec(void)
