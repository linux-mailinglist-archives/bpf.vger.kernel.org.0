Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871BE6D0DFA
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 20:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjC3Sl5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 14:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjC3Sls (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 14:41:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B9F74E
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:41:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-545e529206eso138063197b3.9
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680201685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yJ2Sxu/FmxkSDNncbKBCk+c82WFxW8lxZQCLGGz4NKQ=;
        b=gix6LDtZdhUDjR6yjAXlwATUz9a815WgaMA2SB4D7b3+N1M1PbG4L8ber9P67yFbPJ
         y/r1MvOXBzexH6pNdI1r+3LOhn49LLm1m+/beSQzrc4tYTqHuCS4SSAvYPVZfvmSah4Z
         xmIEUy7E3XSB1nqAduy6I9hYMpnhfXH0RZPlhBY4t3/xscXVi7Qdnwnya+9fkTODb54c
         gJ2XBCyuykBZxXOl/qOiyl2ctdUYco9/E/3VkjAJeMbJkiCS+c9n3HHwxA9QEILYZ+jJ
         by816WWx0qm4313Vhczbpo/fZZdtACOCSzUGf2uQ5IoEBUE4+tllr+ornkgSGwn5+Zs4
         TzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJ2Sxu/FmxkSDNncbKBCk+c82WFxW8lxZQCLGGz4NKQ=;
        b=r2igMd+9cEpUek3XbDDz9OZg7jgYr+Ch8+oB5mDO1SIauawiUYWnrFgrLkVTUoQZo7
         X8Z2nZeyixkx3uJ0D2yV9kW3IAleJBeMiuI4O23p1RCXuq8XTsXr9yNVitS54VCe03Dz
         EOrSgf3dPBqHHz/5TKKmhyu2y8lb8k1W/aMvm1RvYaDFA8bnmux9cc18CCOcGn8p6ZV4
         JuGn+MvO4m20nS5b/ovPAVusrg1xK978qOXRFnxDPdSbUr4uu2h/AEhqvOxibbpbbXx0
         V3xgCzBh0csg7xLQD6Wz94s3fmO6a5n9UQ6rJko1h64TE0I3x/rAbP04BXc5ChFCvn5+
         HCyw==
X-Gm-Message-State: AAQBX9cpPqEMstqWnaYHYdx7STLszsJP6esTsoq5hmscfjvTRRKfQv1D
        JbcMfMRSC3VUSAHHbXAUARdC+gc=
X-Google-Smtp-Source: AKy350bgfAlihorY1xQ8XDxYJoEYiCr2xrX/+Neg1OJlU4ctO/D7zh3CRu1srY4Dh1xybHSznNaiugo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:120d:b0:b6f:dcd:6cd2 with SMTP id
 s13-20020a056902120d00b00b6f0dcd6cd2mr13036411ybu.10.1680201685850; Thu, 30
 Mar 2023 11:41:25 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:41:24 -0700
In-Reply-To: <20230330151758.531170-7-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230330151758.531170-1-aditi.ghag@isovalent.com> <20230330151758.531170-7-aditi.ghag@isovalent.com>
Message-ID: <ZCXX1LF5FXpT1ALr@google.com>
Subject: Re: [PATCH v5 bpf-next 6/7] selftests/bpf: Add helper to get port
 using getsockname
From:   Stanislav Fomichev <sdf@google.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/30, Aditi Ghag wrote:
> The helper will be used to programmatically retrieve,
> and pass ports in userspace and kernel selftest programs.

> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 14 ++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |  1 +
>   2 files changed, 15 insertions(+)

> diff --git a/tools/testing/selftests/bpf/network_helpers.c  
> b/tools/testing/selftests/bpf/network_helpers.c
> index 596caa176582..4c1dc7cf7390 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -427,3 +427,17 @@ void close_netns(struct nstoken *token)
>   	close(token->orig_netns_fd);
>   	free(token);
>   }
> +
> +int get_sock_port6(int sock_fd, __u16 *out_port)
> +{
> +	struct sockaddr_in6 addr = {};
> +	socklen_t addr_len = sizeof(addr);
> +	int err;
> +
> +	err = getsockname(sock_fd, (struct sockaddr *)&addr, &addr_len);
> +	if (err < 0)
> +		return err;
> +	*out_port = addr.sin6_port;

The rest of the helpers don't usually care about v4 vs v6.
Making it work for both v4 and v6 seems trivial, so maybe let's do it?

> +
> +	return err;
> +}
> diff --git a/tools/testing/selftests/bpf/network_helpers.h  
> b/tools/testing/selftests/bpf/network_helpers.h
> index f882c691b790..2ab3b50de0b7 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -56,6 +56,7 @@ int fastopen_connect(int server_fd, const char *data,  
> unsigned int data_len,
>   int make_sockaddr(int family, const char *addr_str, __u16 port,
>   		  struct sockaddr_storage *addr, socklen_t *len);
>   char *ping_command(int family);
> +int get_sock_port6(int sock_fd, __u16 *out_port);

>   struct nstoken;
>   /**
> --
> 2.34.1

