Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5073F60E606
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiJZRBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiJZRBg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 13:01:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD34836CA
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 10:01:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y10so10695534wma.0
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osd/ToLJFfys40j/JfyzguanefKjmQgln74CBIsuJE0=;
        b=GCcJXujoXBxvT+l+xU5w06G1Tw07cX9AV+f/WJp/cNiTf7QBSGrT4kJy282ks1VYWK
         VdrTzGQnBRvv50Yg3m9p5M07AuTmMyO8+DqqYwPksTga4QKyk78aiwj1MWlOW5aAuhyP
         7AOUyJERVNHd5ETBFxBGE/jCojmecWm43w4jMdQyJkfecx/NfOFg6N/GYNo5z+gPKj+P
         +QNOKdD1TKPGV1pIgBchLJLohl98VuzGE1vND31jZR2wt4BMrcxgno0Sj2sb/SU/ZmU8
         zrFwWyqcbrQyfrP40V6iMCfAoAZxzk7nQAp6FrCmfVL2KCK7YEYnwoTT9BJfkCuzn0a/
         7AFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osd/ToLJFfys40j/JfyzguanefKjmQgln74CBIsuJE0=;
        b=tam/N6qa6gcA9xYMshaCCXyHhEkKrzJGDdIEuEWe1Wk6Wj1UOvLXZrKwMi4JzExQEd
         esIdeDzfLcPyERfJE0iJPaiKXvIVkYl54jHsz6Wpd58MThbM9IXV5sh2AbMLvFX2IcD/
         Yk+VeOlePdGjZn42r5TR0x2W4WU1rQA5EsRqqb50VIhusGXMEzmFUn8dc0pQ8vl9cZ6s
         az2IAaKuwmmGAmkzxHjTFDhRFYXA6UHkomhALoXIg557+zXOm1lyRoqY7LB+y1nv+ee+
         +FL3wY+Q+xjf0wOqZUVVqft7fNWqX479KTSMAHanWZkjw/onhIzN2VSVJus7USIeAZ2c
         X/3Q==
X-Gm-Message-State: ACrzQf1VhOrLQFFN9dBi5FNsAy5wh0350ZnbQZsPklPIUZSe2xCUcVuH
        Eap6kTMFJ4fLUD0R+bm6CDl+/Q==
X-Google-Smtp-Source: AMsMyM6PHGF1AfRLCoOIw3omIQBkLDPZXFtHB9jUe1YgGkOOlLn9NS4l0JQlc9a2I2Nxz+XIMptaEw==
X-Received: by 2002:a05:600c:4fc4:b0:3c6:fb81:ab55 with SMTP id o4-20020a05600c4fc400b003c6fb81ab55mr3141215wmq.60.1666803692569;
        Wed, 26 Oct 2022 10:01:32 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h6-20020adfa4c6000000b002206203ed3dsm6050818wrb.29.2022.10.26.10.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 10:01:32 -0700 (PDT)
Message-ID: <317f559d-7533-7c50-09cf-9095524a8fa9@isovalent.com>
Date:   Wed, 26 Oct 2022 18:01:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix bpftool synctypes checking
 failure
Content-Language: en-GB
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20221026163014.470732-1-yhs@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20221026163014.470732-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-10-26 09:30 UTC-0700 ~ Yonghong Song <yhs@fb.com>
> kernel-patches/bpf failed with error:
>   Running bpftool checks...
>   Comparing /data/users/ast/net-next/tools/include/uapi/linux/bpf.h (bpf_map_type) and
>             /data/users/ast/net-next/tools/bpf/bpftool/map.c (do_help() TYPE):
>             {'cgroup_storage_deprecated', 'cgroup_storage'}
>   Comparing /data/users/ast/net-next/tools/include/uapi/linux/bpf.h (bpf_map_type) and
>             /data/users/ast/net-next/tools/bpf/bpftool/Documentation/bpftool-map.rst (TYPE):
>             {'cgroup_storage_deprecated', 'cgroup_storage'}
> The selftests/bpf/test_bpftool_synctypes.py runs checking in the above.
> 
> The failure is introduced by Commit c4bcfb38a95e("bpf: Implement cgroup storage available
> to non-cgroup-attached bpf progs"). The commit introduced BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED
> which has the same enum value as BPF_MAP_TYPE_CGROUP_STORAGE.
> 
> In test_bpftool_synctypes.py, one test is to compare uapi bpf.h map types and
> bpftool supported maps. The tool picks 'cgroup_storage_deprecated' from bpf.h
> while bpftool supported map is displayed as 'cgroup_storage'. The test failure
> can be fixed by explicitly replacing 'cgroup_storage_deprecated' with 'cgroup_storage'
> in uapi bpf.h map types.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/test_bpftool_synctypes.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> index a6410bebe603..9fe4c9336c6f 100755
> --- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> +++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> @@ -501,6 +501,14 @@ def main():
>      source_map_types = set(bpf_info.get_map_type_map().values())
>      source_map_types.discard('unspec')
>  
> +    # BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED and BPF_MAP_TYPE_CGROUP_STORAGE
> +    # share the same enum value and source_map_types picks
> +    # BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED/cgroup_storage_deprecated.
> +    # Replace 'cgroup_storage_deprecated' with 'cgroup_storage'
> +    # so it aligns with what `bpftool map help` shows.
> +    source_map_types.remove('cgroup_storage_deprecated')
> +    source_map_types.add('cgroup_storage')
> +
>      help_map_types = map_info.get_map_help()
>      help_map_options = map_info.get_options()
>      map_info.close()

It does fix the script. Thanks!

If anyone wonders about the difference about .discard() (used just
above) and .remove(), the latter returns an error if the element to
remove is not present in the set. Here we do expect to find it, so
.remove() looks good.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
