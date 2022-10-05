Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05735F4D0E
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 02:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJEAde (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 20:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJEAdd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 20:33:33 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39D056B82
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 17:33:32 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id o14-20020a056a00214e00b0056238ef46ebso157052pfk.2
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 17:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=QrovsWiOqGDOFHfK48mk4XLnJdCYRM/PUycOApAvGGU=;
        b=c+JeLFdeiGfcHgd3hB6esA7G0gU4xpy0Jy9zKJOrPImZ2AhaA7s7qhAceKuKDxH7if
         qFVIK/wfuBCPDiUmR7eUi0Df6LkES78V4rsjGzMl0cX7Dllam4acVuIPBQIRBv8IxNXE
         21NDvHsJCWy8EgFCqaNVMSKmFRsgxf6/furxwb4XBQGfLKbyAnydCON4c4s4AljXn1Kq
         88oVoV5/iAc6/05LsVYVSkHD37xF542BLFGQq0vZ50Jg66C9ux61ddrbZ+mx7CE9Hq2O
         TpKInHChWjZo02R4RziKHPPXZSN8aPQyiGF6Pjt1F9zn5bVOIQ1aKtKVhq5xvcLXz1c1
         ovMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=QrovsWiOqGDOFHfK48mk4XLnJdCYRM/PUycOApAvGGU=;
        b=IXfW4SMakFji0TBWjFddjpTm30l9GVxbPofoC1hDyWSv1myFlCdnO9MgKZFZZIgqE1
         QGs/x6IxZCyzMuapm7ghR9mkcBXdRy18RORBGeesbJrJN2wXOnk8QzU2hNjrXHDQNg6P
         GpVBFxMix8oMHsQOjBRCy0JkSPyvrYQTbFWR28zKt277vu2X9h2Vzizj+HS7l17xNq6m
         sVHuXrjv7iOEVXWx9oW+h8U/runxJ0CoYEZZgCF3roXEZ8mvfRwHv/ZcYeur9TZKv32n
         ksi5DE1CyKSFL+RTDPVw1WViEkRyDoVNpWZ9vHsHzYzfpQGuPE1p9gRUU1V1gzUA9k4/
         xg2A==
X-Gm-Message-State: ACrzQf1iScYgc/iXhrYSp7aSilJJy2NnxQjzW6tVgAaBLpAqeg+rR03P
        jxle/tmZAOIn7LQlt/EVvzj93PPgKyE/Mlj5UFQI2blVkTPNCyIpjbFwTZGsIEVbeH9+Q6Pv7vg
        n8WCLD/RvGuf5OnD6+A6xfoESj9CXycACalKCeOMusfLFljJpjA==
X-Google-Smtp-Source: AMsMyM5Pj9siN4JvYhnsZYXE829+KDSGC5LGr7fuqkQVrNbb1xoNfx6ZTevSKHpPsnb3xsW68BKK7Po=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:b501:0:b0:557:d887:20ee with SMTP id
 y1-20020a62b501000000b00557d88720eemr30177140pfe.8.1664930012049; Tue, 04 Oct
 2022 17:33:32 -0700 (PDT)
Date:   Tue, 4 Oct 2022 17:33:30 -0700
In-Reply-To: <20221004222725.2813510-1-sdf@google.com>
Mime-Version: 1.0
References: <20221004222725.2813510-1-sdf@google.com>
Message-ID: <YzzQ2mI/srLNazNO@google.com>
Subject: Re: [PATCH bpf] bpf: make DEBUG_INFO_BTF_MODULES selectable independently
From:   sdf@google.com
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/04, Stanislav Fomichev wrote:
> We're having an issue where we have a recent clang that seems
> to generate kind_flag for enums (aka, adding signed/unsigned).
> Trying to install a module on a kernel that doesn't have commit
> 6089fb325cf7 ("bpf: Add btf enum64 support") returns the following:

> [    3.176954] BPF:Invalid btf_info kind_flag

> The enum that it complains about doesn't seem to have anything special
> except having a sign:

> [1721] ENUM 'perf_event_state' encoding=SIGNED size=4 vlen=6
>          'PERF_EVENT_STATE_DEAD' val=-4
>          'PERF_EVENT_STATE_EXIT' val=-3
>          'PERF_EVENT_STATE_ERROR' val=-2
>          'PERF_EVENT_STATE_OFF' val=-1
>          'PERF_EVENT_STATE_INACTIVE' val=0
>          'PERF_EVENT_STATE_ACTIVE' val=1

> We are not currently using CONFIG_DEBUG_INFO_BTF_MODULES and
> don't plan to use module BTF, so it's preferable to be able
> to explicits disable it in the kernel config. Unfortunately,
> because that kconfig option doesn't have a name, it's not
> possible to flip it independently from CONFIG_DEBUG_INFO_BTF.
> Let's add a name to make sure module BTF is user-controllable.

[..]

> (Not sure, but maybe the right fix is to also have a stable patch
>   to relax that "Invalid btf_info kind_flag" check?)

Answering to myself, looks like we do need the following for
non-enum64-compatible older/stable kernels:

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3cfba41a0829..928f4955090a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3301,11 +3301,6 @@ static s32 btf_enum_check_meta(struct  
btf_verifier_env *env,
  		return -EINVAL;
  	}

-	if (btf_type_kflag(t)) {
-		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
-		return -EINVAL;
-	}
-
  	if (t->size > 8 || !is_power_of_2(t->size)) {
  		btf_verifier_log_type(env, t, "Unexpected size");
  		return -EINVAL;

Anything I'm missing? Feels like any pre-6089fb325cf7 ("bpf: Add btf
enum64 support") kernel will have an issue with a recent clang
that puts sign into kflag?


> Fixes: 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled  
> and pahole supports it")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   lib/Kconfig.debug | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c77fe36bb3d8..6336a697c9f5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -326,6 +326,7 @@ config PAHOLE_HAS_SPLIT_BTF
>   	def_bool $(success, test `$(PAHOLE) --version | sed  
> -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "119")

>   config DEBUG_INFO_BTF_MODULES
> +	bool "Generate BTF module typeinfo"
>   	def_bool y
>   	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
>   	help
> --
> 2.38.0.rc1.362.ged0d419d3c-goog

