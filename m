Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B4F20339C
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 11:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgFVJkw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgFVJku (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 05:40:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2432AC061795
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 02:40:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q2so13508301wrv.8
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tOdN8Os3uQ1Vbd/a4os7DGJTbk++99An6ASi1Ba/kec=;
        b=CloD2p5IV2JOh6H0z15M5xN+pD/IFDVTRV8gwJl6o7iAUEs0z0BMsK9Y5PhuZBHZgo
         Jvx5hRyJQjVAPdvCcMHLuWk+B3NsTiMoujvQhr6npjcQFct7Fn62NI0gKd7ElDGwsMZY
         cdIfF9paZXIQtJkvcczi0uEGFSKGYf/n1atUAZzId1B9uylH5bKpJnLyrSfZqVTys0co
         +iIPqy9B6m8P/M3NP88RoESotaaTBmKgwFIkok59t0pG4M+r82DP+S64LlgOxem77Tov
         LIxXDcNa1Ia+nbcdoFc/07QpFoM0HEJ2WXmxuDUs58pwx7YfHmPw4WeG5oZMeui15g6T
         xaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tOdN8Os3uQ1Vbd/a4os7DGJTbk++99An6ASi1Ba/kec=;
        b=LdU52qA8fYJ8TcGjsDK9eEt4YFXtO1UwdaF0GWbNWTEmAiNCfk/WXQP1ysw6LbHDKx
         w0hYjqx6afdTX7avsWh7JMBf8SfZ23kucz36cy9TVx16P9xDtpl3eKgXl5fm3XbjG0zK
         YKuRexs318lCDJTWDuFAUuzO7vjhE/Hp++bARG1YpgUrGCLGo8cqubBtHpXMFG/BsOp9
         T5gWMFJk1mt/QEsx9mGlSCPwHoReoFDhDEEvjdz8Wc4kskML3dLQy9xbpVySbPGiB0CN
         wvf+E1dgDQq7eYwdJaL4QS/BHpNE8ebhbKUATRda7//NJaPaQYRv8s/WbsRYnxWdnL+a
         2lTg==
X-Gm-Message-State: AOAM531aGHiLk76wDNNaPBkmjPpVgIlxFeymLnMcNPhiXS8WdNGeqP1l
        i29MsF66zhOojbDCIdqIzpYh4g==
X-Google-Smtp-Source: ABdhPJx0NL1GSWefd73+pLmzg/cyxn/QzWJMXWk6+Zx1EZmeNfOg2s3SOiG4GF/5Nh84Z5r7vCnAKg==
X-Received: by 2002:a5d:4f01:: with SMTP id c1mr17311626wru.190.1592818847834;
        Mon, 22 Jun 2020 02:40:47 -0700 (PDT)
Received: from [192.168.1.12] ([194.53.184.240])
        by smtp.gmail.com with ESMTPSA id g18sm16038083wme.17.2020.06.22.02.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 02:40:47 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Implement bpf_local_storage for
 inodes
To:     KP Singh <kpsingh@chromium.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-3-kpsingh@chromium.org>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <1bb2c24c-bedd-50b4-3d81-3cbb9507ed86@isovalent.com>
Date:   Mon, 22 Jun 2020 10:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617202941.3034-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-06-17 22:29 UTC+0200 ~ KP Singh <kpsingh@chromium.org>
> From: KP Singh <kpsingh@google.com>
> 
> Similar to bpf_local_storage for sockets, add local storage for inodes.
> The life-cycle of storage is managed with the life-cycle of the inode.
> i.e. the storage is destroyed along with the owning inode.
> 
> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
> security blob which are now stackable and can co-exist with other LSMs.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c5fac8068ba1..e8fbafb3e87b 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -49,6 +49,7 @@ const char * const map_type_name[] = {
>  	[BPF_MAP_TYPE_STACK]			= "stack",
>  	[BPF_MAP_TYPE_SK_STORAGE]		= "sk_storage",
>  	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
> +	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
>  };
>  
>  const size_t map_type_name_size = ARRAY_SIZE(map_type_name);

Thanks for the update on bpftool map types, could you also change the
relevant help message, man page and bash completion please? (See below.)

Best regards,
Quentin

------

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 31101643e57c..a9cd15ed7187 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -49,7 +49,7 @@ MAP COMMANDS
 |		| **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_maps**
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
-|		| **queue** | **stack** | **sk_storage** | **struct_ops** }
+|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **inode_storage** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 25b25aca1112..34cadc081a78 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -688,7 +688,8 @@ _bpftool()
                                 lru_percpu_hash lpm_trie array_of_maps \
                                 hash_of_maps devmap devmap_hash sockmap cpumap \
                                 xskmap sockhash cgroup_storage reuseport_sockarray \
-                                percpu_cgroup_storage queue stack' -- \
+                                percpu_cgroup_storage queue stack sk_storage \
+                                struct_ops inode_storage' -- \
                                                    "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c5fac8068ba1..f1b48a97b378 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1590,7 +1590,7 @@ static int do_help(int argc, char **argv)
 		"                 lru_percpu_hash | lpm_trie | array_of_maps | hash_of_maps |\n"
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
-		"                 queue | stack | sk_storage | struct_ops }\n"
+		"                 queue | stack | sk_storage | struct_ops | inode_storage }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, argv[-2]);
