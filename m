Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6590A6F70F1
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEDRdw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 13:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDRdv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 13:33:51 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1F240CF
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 10:33:51 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64115ef7234so9511801b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683221630; x=1685813630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVU7iT+IxnD//jxQyJGnc0IbgmGhs3gwIVs0ILBHlC4=;
        b=HOm4wNcJbhD9RojK1hKMcmf/iDDXNbDWcJM+ELOcbe/Y09GT1Y5RLWjrBeixvL/LVO
         SfMnM7YNTlKO5x0oDlEuldx4sAcw1rIa49YLW2gtc06TgTshb2CZWIWRogn5L5QrP+WO
         lWclFVRWb5KELDmH5wU4Loj+0UKYLZazxmPZZPEfhjusCKuqbuO9UqHqWToEiPQ87KMb
         wFoKsTFZmKcOnx/EOlvBvwkNUOcyY30roAXRz/yBDBjaxWvx2+WAdkIQorK7UiDqS3+n
         5cc+/BEJQAYrZ0l+oBWMVEa1nnXnitLVUFEUqU87VQpJGHQqkHYCLSBkaUv6weZ7E3pi
         kXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683221630; x=1685813630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVU7iT+IxnD//jxQyJGnc0IbgmGhs3gwIVs0ILBHlC4=;
        b=QJEZQvquuEEajhOBjMF9isrCXdUx53lRhMQ3Z65J+bTu3+lGXDZ8LFZJY3tGF3Sw8x
         DCrwCR0G0Gf4meHJEMqalilsL62nZRqCTM4JIHn1TgvkO9ev0eMdnvrT/rzLLdZnfdIY
         lMlWN6zcQdL+t4XnMxd7iyYpAbeK1qqxxdYWiT4sd4MAbZvPAg8u3mXWpFcMiqfqdein
         YpQkZIdkeJVFnzSHuEUM1Td4HplgLKFQ8KRfAwDQcWY+MaX8QZK23povrZa+7k8d3TZc
         DjAFxszqOmY7bTnuUtQjlzqiY/vskRYAo/iKlB71cHGeyjp4grfU7wjZ0WxqqViMMAXI
         kiwA==
X-Gm-Message-State: AC+VfDwGaPoJHpUH8+ucmpV3ev8b48w2rzs6VC3InQ/Zb86USXJmn1QN
        vyFbtjc4JBODp/uY9DrURJt1llE=
X-Google-Smtp-Source: ACHHUZ7Cz6o+nzL2hMvni+FXGnFRdN4a/d12fHW59ht8TZZmg7vUTtbYdD+uNqkdGpZBqfdUusPxPyw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:57c9:0:b0:521:70e7:a8b with SMTP id
 q9-20020a6557c9000000b0052170e70a8bmr120958pgr.1.1683221630608; Thu, 04 May
 2023 10:33:50 -0700 (PDT)
Date:   Thu, 4 May 2023 10:33:49 -0700
In-Reply-To: <20230503225351.3700208-8-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com> <20230503225351.3700208-8-aditi.ghag@isovalent.com>
Message-ID: <ZFPsfT6LVQcgBvFR@google.com>
Subject: Re: [PATCH v7 bpf-next 07/10] selftests/bpf: Add helper to get port
 using getsockname
From:   Stanislav Fomichev <sdf@google.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/03, Aditi Ghag wrote:
> The helper will be used to programmatically retrieve,
> and pass ports in userspace and kernel selftest programs.
> 
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Looks great, thank you!

> ---
>  tools/testing/selftests/bpf/network_helpers.c | 23 +++++++++++++++++++
>  tools/testing/selftests/bpf/network_helpers.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 596caa176582..a105c0cd008a 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -427,3 +427,26 @@ void close_netns(struct nstoken *token)
>  	close(token->orig_netns_fd);
>  	free(token);
>  }
> +
> +int get_socket_local_port(int sock_fd)
> +{
> +	struct sockaddr_storage addr;
> +	socklen_t addrlen = sizeof(addr);
> +	int err;
> +
> +	err = getsockname(sock_fd, (struct sockaddr *)&addr, &addrlen);
> +	if (err < 0)
> +		return err;
> +
> +	if (addr.ss_family == AF_INET) {
> +		struct sockaddr_in *sin = (struct sockaddr_in *)&addr;
> +
> +		return sin->sin_port;
> +	} else if (addr.ss_family == AF_INET6) {
> +		struct sockaddr_in6 *sin = (struct sockaddr_in6 *)&addr;
> +
> +		return sin->sin6_port;
> +	}
> +
> +	return -1;
> +}
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index f882c691b790..694185644da6 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -56,6 +56,7 @@ int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
>  int make_sockaddr(int family, const char *addr_str, __u16 port,
>  		  struct sockaddr_storage *addr, socklen_t *len);
>  char *ping_command(int family);
> +int get_socket_local_port(int sock_fd);
>  
>  struct nstoken;
>  /**
> -- 
> 2.34.1
> 
