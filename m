Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E7660002
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 13:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjAFMLO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 07:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjAFMLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 07:11:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414072886
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 04:11:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m7so1084865wrn.10
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 04:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lqgBvH3cRWcsX4rNdTLeZsM5ZhRSoVlfNbnRO4xtLI=;
        b=NZzkWPIrVRiIAbnulSI1cGlv5xPVkOdI81R1Hqf6gUFNEShJAT2R4vqKoDP2f9sr7y
         AlGlqkHwl/9UhifWe2VXw9qjYvU4SX4062Q4sHjhy8+4mb5ZuucpQU9XAWOGgHu4Kvyt
         diAbNMYp4WOeG5FlQkmd8ewwyitIMAVoEQAH6Mc1ZOov1nAxKYZg7XP5UyxitVpAcK2L
         QRhpdbjs5dlEsHphEstaP68MOESUgnHv6W3obyCjSVAp4XR5co+6glvCcbWZ7M7rLw2c
         uDC/SXVLNrI4lTNRWvfNTLazN6FbjQ2z3zBvD+FCCdDsBWnzhl2Y6o735P/pwbKeCvKk
         eqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lqgBvH3cRWcsX4rNdTLeZsM5ZhRSoVlfNbnRO4xtLI=;
        b=7JThE+fM2YlvPyyRzHVjK5Oo7JTNud0pMyEiCfp26uqqN/O5MNmiuge0CskMv9J34A
         1H//O7hU5gVtA7csP7G2xphNl/ezHqY+tl3ba6/mVFcPyzsuYqrYXSdpdf81LsIJqm7F
         G6L8USdV1UI0uy6lRPQJ0R6v6jy9Ly4lgnABsp8rR1tqXC+fj3HDB2USTThzKw3iXtuE
         nZNE+6KLKRzPb9+zA3g6yeVGy87NZzy4Tg3A6N5SwBIEWn4n9e8m6KGveqEQbjBPtR7k
         kTXHn8vnhJnvGsYG09qZDQNf7Ifyu+zBxmcyd3f6GpUtDXcrIUrbadkcvISe21KwYUmT
         aCKQ==
X-Gm-Message-State: AFqh2kpspjjECGjCjeQysqExWEBBMevaEUfOWzezRN98ZVHTL7vjp0LA
        Wr2mnU4O3Tolrmn6i4UeDZ0yYQ==
X-Google-Smtp-Source: AMrXdXsaPD2VrM67v81G5TB98BeNHs/8LMkyC5/h4SIxf1gMu6Awu2u2ZZwi6ee4WbsO3QPCIt8txQ==
X-Received: by 2002:a5d:564e:0:b0:27d:59a5:28bc with SMTP id j14-20020a5d564e000000b0027d59a528bcmr26183768wrw.35.1673007064688;
        Fri, 06 Jan 2023 04:11:04 -0800 (PST)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n5-20020adfe785000000b00281eab50380sm1098766wrm.117.2023.01.06.04.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:11:04 -0800 (PST)
Message-ID: <c8020dc5-e911-e9a1-a269-5fbcb682f346@isovalent.com>
Date:   Fri, 6 Jan 2023 12:11:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] bpf_doc: Fix build error with older python versions
Content-Language: en-GB
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20230106114037.25036-1-msuchanek@suse.de>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230106114037.25036-1-msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-01-06 12:40 UTC+0100 ~ Michal Suchanek <msuchanek@suse.de>
> + make -j48 -s -C /dev/shm/kbuild/linux.33946/current ARCH=powerpc HOSTCC=gcc CROSS_COMPILE=powerpc64-suse-linux- clean
> TypeError: '_sre.SRE_Match' object is not subscriptable
> 
> Fixes: 8a76145a2ec2 ("bpf: explicitly define BPF_FUNC_xxx integer values")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  scripts/bpf_doc.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index e8d90829f23e..38d51e05c7a2 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -271,7 +271,7 @@ class HeaderParser(object):
>              if capture:
>                  fn_defines_str += self.line
>                  helper_name = capture.expand(r'bpf_\1')
> -                self.helper_enum_vals[helper_name] = int(capture[2])
> +                self.helper_enum_vals[helper_name] = int(capture.group(2))
>                  self.helper_enum_pos[helper_name] = i
>                  i += 1
>              else:

Thanks, the change looks good.

Acked-by: Quentin Monnet <quentin@isovalent.com>

Would be nice to have a bit more context in the commit log: As I
understand, Match objects have been scriptable since Python 3.6 (2016).

Reference: https://docs.python.org/3/whatsnew/3.6.html#re
