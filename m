Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E69624AC6
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 20:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKJThf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 14:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKJThd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 14:37:33 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8653710FE1
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 11:37:32 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2688115pjk.1
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 11:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e82WZn+PdIOTq2ivRn4vNcmVczMFWHVdc+EZkRphALY=;
        b=cdn1crSnEOEcfHcOTY5rNP958blGA4/YI4a2S2Xpvp9BRuZVrgHJuKwFPVLl1NIVSH
         Lq372plgciYVj47x1U1YF2P00Tx6TJh69KvhAOl5USLmCCyAd3Rww/J8AfV7DDOt3Kux
         Km9/WebAcQ0CWPBUIXSAdZwN2HCRIpz+zbIDintYY0bGWtOmmy5+jAF/ylNsXB7d1bV4
         89OznTNRMJna2IFvESs3ri0tKulAU2celxJ9Z3DnULFfJ7krlMB5zlH4rdSGQTZEkjo1
         PJt3b/4sIpxSN7rEEJ4ZHXicz+HaQth0ydS6DSTcFKWDe0Yy0QqWew+m1QwqZ4C0Sis2
         lAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e82WZn+PdIOTq2ivRn4vNcmVczMFWHVdc+EZkRphALY=;
        b=fv46euqH5Nd0Z7DMZ8CPLwD57k5i7UdTc9ZnImi8zaGL9gWTUvr05cYNeC8zvdF9K5
         14GsH+ED7SYuzTz+DmKAQVgkcF5BjuojK3hDcoa5+tJx+Z5A2Ov7VSJgyObxHT28j2L3
         l/8PenT2yOTaV89H7T7nnvA5un363jF9yrxx7VLG6SwNOawGg3P1odu55V0mDkvR/qQM
         ecKkC6n2Xb+kc3XOvSDJwVr2xo3VKDU/yPZnUdvh8GJc8uwz1IufPP2fT+HX4IUuRbVa
         xPETesfbdPwcYv/edJ/31ylibNIQ1VixoEdF2CosmjOK8UvQW+NHF5E3RvmqGtmmYOm6
         iHUg==
X-Gm-Message-State: ACrzQf1J9yGL9o2GxgT9vNOKmB5T+rw9sVvYK3hXeBHePcPKyx3GzhSK
        v3+Z9JhjMN9cgD/6DPBD2Ro=
X-Google-Smtp-Source: AMsMyM7bFCZPI+Hdqn2TkrMdGR/U4VndB3V4l9ZT7HrhiL8LYYgxbQEuv6fCXnwJl6LPzmYMub+8bw==
X-Received: by 2002:a17:90b:48c7:b0:212:a14e:b8b0 with SMTP id li7-20020a17090b48c700b00212a14eb8b0mr1792339pjb.39.1668109051562;
        Thu, 10 Nov 2022 11:37:31 -0800 (PST)
Received: from surya ([2600:1700:3ec2:2011:c158:5e42:f39d:8e0c])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709027e0800b00174d9bbeda4sm43357plm.197.2022.11.10.11.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:37:30 -0800 (PST)
Date:   Thu, 10 Nov 2022 11:37:15 -0800
From:   Manu Bretelle <chantr4@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v4 7/7] selftests/bpf: Add rcu_read_lock test to
 s390x deny list
Message-ID: <Y21S6+9rfmwA8R8S@surya>
References: <20221110180124.913882-1-yhs@fb.com>
 <20221110180201.917531-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110180201.917531-1-yhs@fb.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 10, 2022 at 10:02:01AM -0800, Yonghong Song wrote:
> The new rcu_read_lock test will fail on s390x with the following error message:
> 
>   ...
>   test_rcu_read_lock:PASS:join_cgroup /rcu_read_lock 0 nsec
>   test_local_storage:PASS:skel_open 0 nsec
>   libbpf: prog 'cgrp_succ': failed to find kernel BTF type ID of '__s390x_sys_getpgid': -3
>   libbpf: prog 'cgrp_succ': failed to prepare load attributes: -3
>   libbpf: prog 'cgrp_succ': failed to load: -3
>   libbpf: failed to load object 'rcu_read_lock'
>   libbpf: failed to load BPF skeleton 'rcu_read_lock': -3
>   test_local_storage:FAIL:skel_load unexpected error: -3 (errno 3)
>   ...
> 
> So add it to the s390x deny list.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> index be4e3d47ea3e..dd5db40b5a09 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -41,6 +41,7 @@ module_attach                            # skel_attach skeleton attach failed: -
>  mptcp
>  netcnt                                   # failed to load BPF skeleton 'netcnt_prog': -7                               (?)
>  probe_user                               # check_kprobe_res wrong kprobe res from probe read                           (?)
> +rcu_read_lock                            # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)

This also seems to fail on aarch64:
```
2022-11-10T18:39:39.2406543Z test_rcu_read_lock:PASS:join_cgroup /rcu_read_lock 0 nsec
2022-11-10T18:39:39.2409781Z test_local_storage:PASS:skel_open 0 nsec
2022-11-10T18:39:39.2413002Z test_local_storage:PASS:skel_load 0 nsec
2022-11-10T18:39:39.2418758Z libbpf: prog 'cgrp_succ': failed to attach: ERROR: strerror_r(-524)=22
2022-11-10T18:39:39.2422765Z libbpf: prog 'cgrp_succ': failed to auto-attach: -524
2022-11-10T18:39:39.2428250Z test_local_storage:FAIL:skel_attach unexpected error: -524 (errno 524)
2022-11-10T18:39:39.2431555Z #145/1   rcu_read_lock/local_storage:FAIL
2022-11-10T18:39:39.2435392Z #145/2   rcu_read_lock/runtime_diff_rcu_tag:OK
2022-11-10T18:39:39.2439296Z #145/3   rcu_read_lock/negative_tests_region:OK
2022-11-10T18:39:39.2443876Z #145/4   rcu_read_lock/negative_tests_rcuptr_misuse:SKIP
2022-11-10T18:39:39.2446212Z #145     rcu_read_lock:FAIL
```

Can you add the test to DENYLIST.aarch64 also?


>  recursion                                # skel_attach unexpected error: -524                                          (trampoline)
>  ringbuf                                  # skel_load skeleton load failed                                              (?)
>  select_reuseport                         # intermittently fails on new s390x setup
> -- 
> 2.30.2
> 
