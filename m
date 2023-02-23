Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2346A1248
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 22:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBWVsu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 16:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBWVst (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 16:48:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E519F0C
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:48:46 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536be78056eso147849087b3.1
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/L9TEX9XsEMWWJyWpQrFp+fDijsMJCN1rjqPVwskjXQ=;
        b=G1BhUDRpFuygxI4yGTiPHmcN4YT/xW/KM0IkziZxSo2kcv9fzRQMBEc3UTiIYolelW
         oFor8FkfEVOQes3kX5MqKiPYwdGuBRAkXQIGhzdX4ym7Cdk8eENi4v28zVLQ0B3Mx9dB
         CVtpTEcWGgeIqnjQQNE75647ckJG2F0Td0Wn7xOoPcLM6Ma+tNFDI0ZiG7jQQmxlse/8
         XFOzOKZ1ovyVenhu75AgdnIcplund/6STvoiSnwBiwlGTTyDVdNjhlBYo811ywUrQAkG
         n2fizUbnH4rPCDaxxEV0UB/BhJY5UQ6SNxHpXYZHrvF0WODUyas1ZktG9S4FvBju2rhy
         yELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/L9TEX9XsEMWWJyWpQrFp+fDijsMJCN1rjqPVwskjXQ=;
        b=a1/DoO3KYhwj4HVu49lIO0WTXFxr8Mm/xGWbL/R6cqCrk1GcLXo042mtkR3HNSqhPI
         BNT3cU4277QkEx3PTIFq4Gu/u91TkNsdGIjAtspcHyPlrw84KbNU6zGDMNDIBfObNqF1
         ASJ3BNaKTpCbzqu/C/HkXHHG6pazbeZJTqxMeW8BK/UJ8JbKXxjHTREFnkgdnStLWQ14
         FmhyuMPY9RkjnmTlYZTghoKsyfa7U52iIOSO4kAgbejDAV4iCG4EjcKZZAJI+bW4KHHO
         9palrh6Bcz/gj2oyqu6eJpCOq7LYKqeotpd0vNlyZCvn1qSlpZCgQZRqD9KGnV/PawZV
         nt3A==
X-Gm-Message-State: AO0yUKXta32xKVhn4NSCXRSz4T8I7Hy7edUNqr0oWVp2HgRJ7kidX9UE
        SGbR1TVKQYFi1f0jt6IQAz8oKZk=
X-Google-Smtp-Source: AK7set/7XPlW51SXtM3DgrBAF+nuZpiAZ4WF6G92bY2Tbi5zHTa8oHsBwOvFtM8coT3dLe3fGr6yVOo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1449:b0:a06:538f:265f with SMTP id
 a9-20020a056902144900b00a06538f265fmr3414489ybv.4.1677188925571; Thu, 23 Feb
 2023 13:48:45 -0800 (PST)
Date:   Thu, 23 Feb 2023 13:48:44 -0800
In-Reply-To: <20230223030717.58668-5-alexei.starovoitov@gmail.com>
Mime-Version: 1.0
References: <20230223030717.58668-1-alexei.starovoitov@gmail.com> <20230223030717.58668-5-alexei.starovoitov@gmail.com>
Message-ID: <Y/ffPMRzRANCZS+1@google.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftests/bpf: Tweak cgroup kfunc test.
From:   Stanislav Fomichev <sdf@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, void@manifault.com, davemarchevsky@meta.com,
        tj@kernel.org, memxor@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/22, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>

> Adjust cgroup kfunc test to dereference RCU protected cgroup pointer
> as PTR_TRUSTED and pass into KF_TRUSTED_ARGS kfunc.

> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h  | 2 +-
>   tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c | 2 +-
>   tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c | 7 ++++++-
>   3 files changed, 8 insertions(+), 3 deletions(-)

> diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h  
> b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
> index 50d8660ffa26..eb5bf3125816 100644
> --- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
> +++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
> @@ -10,7 +10,7 @@
>   #include <bpf/bpf_tracing.h>

>   struct __cgrps_kfunc_map_value {
> -	struct cgroup __kptr * cgrp;
> +	struct cgroup __kptr_rcu * cgrp;
>   };

>   struct hash_map {
> diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c  
> b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
> index 4ad7fe24966d..d5a53b5e708f 100644
> --- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
> +++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
> @@ -205,7 +205,7 @@ int BPF_PROG(cgrp_kfunc_get_unreleased, struct cgroup  
> *cgrp, const char *path)
>   }

>   SEC("tp_btf/cgroup_mkdir")
> -__failure __msg("arg#0 is untrusted_ptr_or_null_ expected ptr_ or  
> socket")
> +__failure __msg("bpf_cgroup_release expects refcounted")
>   int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgroup *cgrp, const  
> char *path)
>   {
>   	struct __cgrps_kfunc_map_value *v;
> diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c  
> b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
> index 0c23ea32df9f..37ed73186fba 100644
> --- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
> +++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
> @@ -61,7 +61,7 @@ int BPF_PROG(test_cgrp_acquire_leave_in_map, struct  
> cgroup *cgrp, const char *pa
>   SEC("tp_btf/cgroup_mkdir")
>   int BPF_PROG(test_cgrp_xchg_release, struct cgroup *cgrp, const char  
> *path)
>   {
> -	struct cgroup *kptr;
> +	struct cgroup *kptr, *cg;
>   	struct __cgrps_kfunc_map_value *v;
>   	long status;

> @@ -80,6 +80,11 @@ int BPF_PROG(test_cgrp_xchg_release, struct cgroup  
> *cgrp, const char *path)
>   		return 0;
>   	}


[..]

> +	kptr = v->cgrp;
> +	cg = bpf_cgroup_ancestor(kptr, 1);
> +	if (cg)
> +		bpf_cgroup_release(cg);

I went through the series, it all makes sense, I'm assuming Kumar
will have another look eventually? (since he did for v1).

One question here, should we have something like the following?

if (cg) {
	bpf_cgroup_release(cg);
} else {
	err = 4;
	return 0;
}

Or are we just making sure here that the verifier is not complaining
about bpf_cgroup_ancestor(v->cgrp) and don't really care whether
bpf_cgroup_ancestor returns something useful or not?

> +
>   	kptr = bpf_kptr_xchg(&v->cgrp, NULL);
>   	if (!kptr) {
>   		err = 3;
> --
> 2.30.2

