Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C72548E58
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 18:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386354AbiFMPCr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243063AbiFMPCH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 11:02:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4DA51338
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 05:08:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i17-20020a7bc951000000b0039c4760ec3fso3984789wml.0
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N7rruoIsMJ3RkeCWCy171/3t1oq0KgMw8VchdIork7A=;
        b=EnV/axKj6VN3b9oEKk50eyG5ILm0c8Rlr6okYx0UglOSle2KwPXhwUFOPsSa2TyNNz
         mnTG8QJE9LAbEPla6EqD5tsgq3SVIkzVDMPrlW+v6BnXMsVghttsoRSZJVbeS7Oy2SYp
         XxutAS2uGY1XhHNALo/IrcmZ/zNdYdOen6vLJQCbUev/XQ5LcccYyBJLFgR06/HsJfu8
         ErgH9i8AOhnHdGDW0Lo15HkBM+rh5cg+7yIJ6PIFGX+IMtM/SUUmKflp5iwoH9yNWzxU
         YpUHGgMAWOOdtICMAKR0iBDzyw+g/TiodBlk+rF3ev6A01HTF/6Gvw490Jb+GFYLWfG6
         TDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N7rruoIsMJ3RkeCWCy171/3t1oq0KgMw8VchdIork7A=;
        b=jeDNHUNKe/VdPfUJiOT0+ItLg4GNaWxNvSWZdFAHXpbxjq8hgGAUuDdg69x3DqcBbX
         vcgNnfR4jnh9mVUAI07vL1QE1fT9K/BvoPsnadlRS+Po3AdrbwFIELbhcpDujCJNgQig
         DEDEzNkMvGfb/7Ai5jFSalnW6mCsxSXElY2QY7l0YBwB9LYKAQ1ua/ZboI/P4pmWAVMo
         9tr5OAnOeJfB0S5e/+wYYAHfKPr81yDd9/JCjaU/M1q5VZ2EpfP4Gm1K238+yJyA1Y0e
         BUVCaWcxPV5pnvWbqR5IGl4dmJaltpAoxjSAmmV1co4YYGmpO/hid4cz/YD7ALqPD8f+
         zE8Q==
X-Gm-Message-State: AOAM533U2d9aA0i82NuEaIw+NxxE77gxAGxCFzylolwEyiOH8qndaJR3
        YfZXLof7MBK/uaG8J/ehg5fXnw==
X-Google-Smtp-Source: ABdhPJxZHfPQbqgUOWITj1lZaV6sQW6adOheR+e3UEyTwf4fUO4vsScxcoVC2XQnP9V1goOSaJ8gNA==
X-Received: by 2002:a05:600c:1d9b:b0:39c:7e00:6b7c with SMTP id p27-20020a05600c1d9b00b0039c7e006b7cmr14109866wms.50.1655122081015;
        Mon, 13 Jun 2022 05:08:01 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d58ee000000b0020fc6590a12sm8492187wrd.41.2022.06.13.05.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 05:08:00 -0700 (PDT)
Message-ID: <a0ebf40e-6c21-435e-0d87-bca7a2113241@isovalent.com>
Date:   Mon, 13 Jun 2022 13:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH bpf-next v9 09/10] bpftool: implement cgroup tree for
 BPF_LSM_CGROUP
Content-Language: en-GB
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20220610165803.2860154-1-sdf@google.com>
 <20220610165803.2860154-10-sdf@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220610165803.2860154-10-sdf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-06-10 09:58 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> $ bpftool --nomount prog loadall $KDIR/tools/testing/selftests/bpf/lsm_cgroup.o /sys/fs/bpf/x
> $ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_alloc
> $ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_bind
> $ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_clone
> $ bpftool cgroup attach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_post_create
> $ bpftool cgroup tree
> CgroupPath
> ID       AttachType      AttachFlags     Name
> /sys/fs/cgroup
> 6        lsm_cgroup                      socket_post_create bpf_lsm_socket_post_create
> 8        lsm_cgroup                      socket_bind     bpf_lsm_socket_bind
> 10       lsm_cgroup                      socket_alloc    bpf_lsm_sk_alloc_security
> 11       lsm_cgroup                      socket_clone    bpf_lsm_inet_csk_clone
> 
> $ bpftool cgroup detach /sys/fs/cgroup lsm_cgroup pinned /sys/fs/bpf/x/socket_post_create
> $ bpftool cgroup tree
> CgroupPath
> ID       AttachType      AttachFlags     Name
> /sys/fs/cgroup
> 8        lsm_cgroup                      socket_bind     bpf_lsm_socket_bind
> 10       lsm_cgroup                      socket_alloc    bpf_lsm_sk_alloc_security
> 11       lsm_cgroup                      socket_clone    bpf_lsm_inet_csk_clone
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

The changes for bpftool look good to me, thanks!
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

> ---
>  tools/bpf/bpftool/cgroup.c | 80 +++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index 42421fe47a58..6e55f583a62f 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c

> @@ -542,5 +577,6 @@ static const struct cmd cmds[] = {
>  
>  int do_cgroup(int argc, char **argv)
>  {
> +	btf_vmlinux = libbpf_find_kernel_btf();
>  	return cmd_select(cmds, argc, argv, do_help);
>  }

This is not required for all "bpftool cgroup" operations (attach/detach
don't need it I think), but should be inexpensive, right?

Quentin
