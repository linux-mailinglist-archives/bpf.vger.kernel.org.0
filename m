Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDD26E6C59
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjDRSp3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjDRSp3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 14:45:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5B39ED8
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 11:45:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-51b121871ecso1282299a12.3
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681843527; x=1684435527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ObV/lYmOonetRVtIMDoXc7qy2QL0tGml3YAWAsCZCw=;
        b=m9e14SSffC9uejGROINDRurYI6Br7OOjrq+Qelo7oP9u35xZvyJxsv8+K2qUNXi9Kr
         YAu68GsDtIQkMxdBLKWCHC88pgWd5p2HjcvPi8VuHFeGeKWSC9DuxrIehENFQqGPklRc
         7lQPEWJpPHdZtV/79J4pLGOeOKgGss8pVdmuyeqUo1Zd5crRU3HjUtvcOGNgQ73JiGDj
         OoQbY3ZZr2YVUeCF0IkdvtI3ao0izpYK6YYXH7NkdLWWhVb/QXX3BkDdUVnBRo0LUyS8
         h7s7ses1+5WJVa1oITDIRUjybpBAyb6oGmCWpeI7JDjjEll8gErGcVv3MN8w9KbMrypw
         WPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681843527; x=1684435527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ObV/lYmOonetRVtIMDoXc7qy2QL0tGml3YAWAsCZCw=;
        b=iBctv9bQeNeJNPoLj4MhoyuMS9gJenGU9w7rrh+QhfFILKAz4XACeqRwrHkg1+4mOi
         fGE1hlUdSXckrVfzkbf0aCq4KqwNR+xqCL/e3doL2DYQ3ytdEMSdBHuReszWp54NPk1M
         oktk5N71Lw9jbBUiSbiguw0e+Jm4TdjbLNo5YXiB00+ntSaLC3tyzGrvdx64a/fs+5t+
         EZgK332YN1ZcbNQ+4XzOubtftZDHG5bRM/ppHSAet08UZYatpF2hmBJ/dKStSDvyznsR
         RhZ488kX/ypTN0MBx1k4BdKiwoDPaDlUgLBMPdkKZXQPmv9+MXXHBSqE9FLYWql7SGii
         jhtw==
X-Gm-Message-State: AAQBX9dc14IW1Zu5iYk8yfNrY8BII5eSIY6yM9LLVYrg9W9nFQhwCBtW
        xLslEysSTBv4nPJ8OS9028QKXkk=
X-Google-Smtp-Source: AKy350bxWk5m71muKfGcuOrl46mah//fiM88KnXwMqI4Ntp4fYTfQ05+OTMJRmnH+SD8OQ68aPU47Zo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:521d:0:b0:51b:3c11:fb17 with SMTP id
 g29-20020a63521d000000b0051b3c11fb17mr904464pgb.12.1681843527589; Tue, 18 Apr
 2023 11:45:27 -0700 (PDT)
Date:   Tue, 18 Apr 2023 11:45:26 -0700
In-Reply-To: <20230418153148.2231644-7-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com> <20230418153148.2231644-7-aditi.ghag@isovalent.com>
Message-ID: <ZD7lRqlxGfgzggAu@google.com>
Subject: Re: [PATCH 6/7] selftests/bpf: Add helper to get port using getsockname
From:   Stanislav Fomichev <sdf@google.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/18, Aditi Ghag wrote:
> The helper will be used to programmatically retrieve,
> and pass ports in userspace and kernel selftest programs.
> 
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>  tools/testing/selftests/bpf/network_helpers.c | 28 +++++++++++++++++++
>  tools/testing/selftests/bpf/network_helpers.h |  1 +
>  2 files changed, 29 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 596caa176582..7217cac762f0 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -427,3 +427,31 @@ void close_netns(struct nstoken *token)
>  	close(token->orig_netns_fd);
>  	free(token);
>  }
> +
> +int get_socket_local_port(int family, int sock_fd, __u16 *out_port)
> +{
> +	socklen_t addr_len;
> +	int err;

Sorry for keeping bikeshedding this part, but if you're going to do
another respin, we can also drop the family argument:

int get_socket_local_port(int sock_fd, __be16 *out_port)
/*                                       ^^ maybe also do be16? */
{
	struct sockaddr_storage addr; 
	socklen_t addrlen;

	addrlen = sizeof(addr);
	getsockname(sock_fd, (struct sockaddr *)&addr, &addrlen);

	if (addr.ss_family == AF_INET) {
	} else if () {
	}
}

> +
> +	if (family == AF_INET) {
> +		struct sockaddr_in addr = {};
> +
> +		addr_len = sizeof(addr);
> +		err = getsockname(sock_fd, (struct sockaddr *)&addr, &addr_len);
> +		if (err < 0)
> +			return err;
> +		*out_port = addr.sin_port;
> +		return 0;
> +	} else if (family == AF_INET6) {
> +		struct sockaddr_in6 addr = {};
> +
> +		addr_len = sizeof(addr);
> +		err = getsockname(sock_fd, (struct sockaddr *)&addr, &addr_len);
> +		if (err < 0)
> +			return err;
> +		*out_port = addr.sin6_port;
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index f882c691b790..ca4a147b58b8 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -56,6 +56,7 @@ int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
>  int make_sockaddr(int family, const char *addr_str, __u16 port,
>  		  struct sockaddr_storage *addr, socklen_t *len);
>  char *ping_command(int family);
> +int get_socket_local_port(int family, int sock_fd, __u16 *out_port);
>  
>  struct nstoken;
>  /**
> -- 
> 2.34.1
> 
