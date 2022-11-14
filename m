Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7542462872B
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 18:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiKNRe1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 12:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbiKNRe0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 12:34:26 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2152626A
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:34:24 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id h16-20020a170902f55000b001871b770a83so9342581plf.9
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=msz3ozvlPLroWfT8x2NNZs//GvUccXdOW5UK6ZYn4c0=;
        b=BIqlyBz0MDGXETR7a6p1Ndp0XeFZ6GGFRhqNB/OHBLLLurkUXexaaVCWU2W0zoExCG
         hJDRgc9RH9+rdVs8DbClI1j/9ySqOZ1+hJCz/fWIWlg4bnyTmOrbSOiLsXQ2fc9UiSo/
         fhC88erSxjutvBDvF3mcu7xOFyb/UTlWpeOc+GDQOjAoZz7MPzLqmqr8VaydCnWoFJG0
         iFSMqZHw600P8s6hksBteTHJPdRP6hkETdfVtZhRCYsrksBGrYTHL0YsQI2a9/zoXAnD
         ouj6y4Z3c0RmqRxNc1oUsa852ZsLbLpFS8bVnGbFvlqoY8CfR7U6YUvdGndmoaAJ6bbu
         1NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msz3ozvlPLroWfT8x2NNZs//GvUccXdOW5UK6ZYn4c0=;
        b=Mj6wKyhvoXGQCIHZ/F/4EVwlEO7OU/mxCAxqsmbXM7N4+pbrcZ8t+ChUEGTYqiM5Rb
         M0b7wAV/TGZR3TO0ceTrgrRoN6N1Uy260t/xYjpJm4JSdCxJPI/37ArV70qlCDM3nbio
         ncE0x9Svq/EXfnnNXSgYQMWPi/lSvXB8fFPpC2Gn6NdIdWFfHVSRm+6vQ4QyDlQ+Sq59
         DC9P6Ram9pI6P+RJ25V5zvSAP+Zg4BJuXo3wbgjHlzQS7uraO+50FCPQdJ8VqvzUmanZ
         ++iU5tPljOThZQoKnfyUj4jMBvW1POPiKSl1DIIBv6TP3OMoG/PuRBYMR7DP29PPiShF
         qEOQ==
X-Gm-Message-State: ANoB5plBYVHCbYKNBiWxbVNQhjvBPXSjixQoJvZeKYj2N0mm1Z+R9Tzn
        HwkRfgeQf/L0m5EvMeUZ8IASsjc=
X-Google-Smtp-Source: AA0mqf6oV5jBgwVrMG+lgn68FDlvRNY25mg6ElHE/ciQImgwloJgW/4/A2kf7qgGHApYKmXPRJumPnY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:a586:b0:188:5681:4dc7 with SMTP id
 az6-20020a170902a58600b0018856814dc7mr291394plb.97.1668447264478; Mon, 14 Nov
 2022 09:34:24 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:34:23 -0800
In-Reply-To: <1668401942-6309-1-git-send-email-wangyufen@huawei.com>
Mime-Version: 1.0
References: <1668401942-6309-1-git-send-email-wangyufen@huawei.com>
Message-ID: <Y3J8HyIfhm7rgpvI@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix memory leak of lsm_cgroup
From:   sdf@google.com
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, paul@paul-moore.com
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

On 11/14, Wang Yufen wrote:
> kmemleak reports this issue:

> unreferenced object 0xffff88810b7835c0 (size 32):
>    comm "test_progs", pid 270, jiffies 4294969007 (age 1621.315s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      03 00 00 00 03 00 00 00 0f 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000376cdeab>] kmalloc_trace+0x27/0x110
>      [<000000003bcdb3b6>] selinux_sk_alloc_security+0x66/0x110
>      [<000000003959008f>] security_sk_alloc+0x47/0x80
>      [<00000000e7bc6668>] sk_prot_alloc+0xbd/0x1a0
>      [<0000000002d6343a>] sk_alloc+0x3b/0x940
>      [<000000009812a46d>] unix_create1+0x8f/0x3d0
>      [<000000005ed0976b>] unix_create+0xa1/0x150
>      [<0000000086a1d27f>] __sock_create+0x233/0x4a0
>      [<00000000cffe3a73>] __sys_socket_create.part.0+0xaa/0x110
>      [<0000000007c63f20>] __sys_socket+0x49/0xf0
>      [<00000000b08753c8>] __x64_sys_socket+0x42/0x50
>      [<00000000b56e26b3>] do_syscall_64+0x3b/0x90
>      [<000000009b4871b8>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

> The issue occurs in the following scenarios:

> unix_create1()
>    sk_alloc()
>      sk_prot_alloc()
>        security_sk_alloc()
>          call_int_hook()
>            hlist_for_each_entry()
>              entry1->hook.sk_alloc_security
>              <-- selinux_sk_alloc_security() succeeded,
>              <-- sk->security alloced here.
>              entry2->hook.sk_alloc_security
>              <-- bpf_lsm_sk_alloc_security() failed
>        goto out_free;
>          ...    <-- the sk->security not freed, memleak

> The core problem is that the LSM is not yet fully stacked (work is
> actively going on in this space) which means that some LSM hooks do
> not support multiple LSMs at the same time. To fix, skip the
> "EPERM" test when it runs in the environments that already have
> non-bpf lsms installed

> Fixes: dca85aac8895 ("selftests/bpf: lsm_cgroup functional test")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> Cc: Stanislav Fomichev <sdf@google.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 19  
> +++++++++++++++----
>   tools/testing/selftests/bpf/progs/lsm_cgroup.c      |  8 ++++++++
>   2 files changed, 23 insertions(+), 4 deletions(-)

> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c  
> b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> index 1102e4f..a927ade 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> @@ -173,10 +173,14 @@ static void test_lsm_cgroup_functional(void)
>   	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 4, "total prog count");
>   	ASSERT_EQ(query_prog_cnt(cgroup_fd2, NULL), 1, "total prog count");

> -	/* AF_UNIX is prohibited. */
> -
>   	fd = socket(AF_UNIX, SOCK_STREAM, 0);
> -	ASSERT_LT(fd, 0, "socket(AF_UNIX)");
> +	if (skel->kconfig->CONFIG_SECURITY_APPARMOR
> +	    || skel->kconfig->CONFIG_SECURITY_SELINUX
> +	    || skel->kconfig->CONFIG_SECURITY_SMACK)

[..]

> +		ASSERT_GE(fd, 0, "socket(AF_UNIX)");

nit: maybe skip this completely instead of having ASSERT_GE+close?

	if (!(skel->kconfig->CONFIG_SECURITY_APPARMOR || _SELINUX || _SMACK)
		/* AF_UNIX is prohibited. */
		ASSERT_LT(fd, 0, "socket(AF_UNIX)");


> +	else
> +		/* AF_UNIX is prohibited. */
> +		ASSERT_LT(fd, 0, "socket(AF_UNIX)");
>   	close(fd);

>   	/* AF_INET6 gets default policy (sk_priority). */
> @@ -233,11 +237,18 @@ static void test_lsm_cgroup_functional(void)

>   	/* AF_INET6+SOCK_STREAM
>   	 * AF_PACKET+SOCK_RAW
> +	 * AF_UNIX+SOCK_RAW if already have non-bpf lsms installed
>   	 * listen_fd
>   	 * client_fd
>   	 * accepted_fd
>   	 */
> -	ASSERT_EQ(skel->bss->called_socket_post_create2, 5, "called_create2");
> +	if (skel->kconfig->CONFIG_SECURITY_APPARMOR
> +	    || skel->kconfig->CONFIG_SECURITY_SELINUX
> +	    || skel->kconfig->CONFIG_SECURITY_SMACK)
> +		/* AF_UNIX+SOCK_RAW if already have non-bpf lsms installed */
> +		ASSERT_EQ(skel->bss->called_socket_post_create2, 6, "called_create2");
> +	else
> +		ASSERT_EQ(skel->bss->called_socket_post_create2, 5, "called_create2");

>   	/* start_server
>   	 * bind(ETH_P_ALL)
> diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c  
> b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> index 4f2d60b..02c11d1 100644
> --- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
> @@ -7,6 +7,10 @@

>   char _license[] SEC("license") = "GPL";

> +extern bool CONFIG_SECURITY_SELINUX __kconfig __weak;
> +extern bool CONFIG_SECURITY_SMACK __kconfig __weak;
> +extern bool CONFIG_SECURITY_APPARMOR __kconfig __weak;
> +
>   #ifndef AF_PACKET
>   #define AF_PACKET 17
>   #endif
> @@ -140,6 +144,10 @@ int BPF_PROG(socket_bind2, struct socket *sock,  
> struct sockaddr *address,
>   int BPF_PROG(socket_alloc, struct sock *sk, int family, gfp_t priority)
>   {
>   	called_socket_alloc++;
> +	/* if already have non-bpf lsms installed, EPERM will cause memory leak  
> of non-bpf lsms */
> +	if (CONFIG_SECURITY_SELINUX || CONFIG_SECURITY_SMACK ||  
> CONFIG_SECURITY_APPARMOR)
> +		return 1;
> +
>   	if (family == AF_UNIX)
>   		return 0; /* EPERM */

> --
> 1.8.3.1

