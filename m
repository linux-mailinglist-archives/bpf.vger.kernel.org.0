Return-Path: <bpf+bounces-8926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1AB78C99E
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5B7281212
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661A017FFC;
	Tue, 29 Aug 2023 16:27:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF017FE5
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 16:27:29 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFA2A6
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 09:27:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fee5ddc23eso43105025e9.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1693326447; x=1693931247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLJvvswMzWFLkn1QEp0BaamJiRTuLUCR6WYwBkYUwHA=;
        b=Y+7apWu5J3Pk0G1pf7bLexHqNeB9wMnR5eveA/NJYcbKDOzyPId1k8xUtYm324/rKk
         vBRZ+2KylXGqpEWtAAoDGhl3gRvB+1bieeeUprfCiacYrm5IZrAy6+C3cCca0+d/0tat
         pYSELthXT/yXEJ/8A/Knzui0uL4XN97S5JRGubXjuqbQYDnAcpnzBgwPZ95mLZRK2wfi
         fOm3vFUGRBkJgsZYE/Cr1A7zQGJ43uktlotaUves9cyxBYDtPTQE+l0RZd4z7fLwOvsQ
         4jmCbXC0Kg9YIkZFF2n5tK/de9LOkqgrHyfN4DOoq3kXi3eB9d5U9hp1Lp0RfGTREDEF
         n8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693326447; x=1693931247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLJvvswMzWFLkn1QEp0BaamJiRTuLUCR6WYwBkYUwHA=;
        b=jVQQN2++Ky+mjJRGkfhO5E7f8amqsVn6IKuZmydu66o/0gX+jFy5nl7lMwPmwP6dmE
         iPoHgfOTYgodfy+hHBuzs9Wupc+3bC59N9zJUjQsHC6vPp91gsKbyQA8jtqyFLExij7N
         5WYS6erlPAjAFMdCEA+sUUAA/acyFL3ov0flxlqj+1O0EhStV5YkWrbMs2uji9QSVPui
         5hNJiDPINPmQU0WTd/69oU8F1+YnyKfr/h1lVmXwwKQvtRzKREE9EAb+eEMg4+O9OCkc
         zbr7YtT2QCGt8kSFUfy6y/MEvEFtCZSnBgkTC5jE9lKxnNpFaY94Vz3xcZwk6sFM2BDH
         w3ew==
X-Gm-Message-State: AOJu0Yw/EX4V55qI9cb6WuJI2fnyXu9e43GHDzbq1NYvDA8VrO5oOT9P
	rTFe7/P1ZBnjIWPM9kXsY8n0Rg==
X-Google-Smtp-Source: AGHT+IE+LpJAzYp8dfLnifYgBeVqEWftpudPyiSjmgSHu3javhWofTkLnWCvt2zXC1Axps2sr6mJsw==
X-Received: by 2002:a05:600c:2181:b0:3fe:228a:e782 with SMTP id e1-20020a05600c218100b003fe228ae782mr22655003wme.37.1693326446765;
        Tue, 29 Aug 2023 09:27:26 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:716a:ac4c:a6ab:1706? ([2a02:8011:e80c:0:716a:ac4c:a6ab:1706])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b00317b5c8a4f1sm14184441wrv.60.2023.08.29.09.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:27:26 -0700 (PDT)
Message-ID: <a84fda87-87c4-4b04-9007-5181ff7a8bc4@isovalent.com>
Date: Tue, 29 Aug 2023 17:27:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 6/9] bpftool: Add support for cgroup unix
 socket address hooks
Content-Language: en-GB
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, kernel-team@meta.com
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
 <20230829101838.851350-7-daan.j.demeyer@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230829101838.851350-7-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 29/08/2023 11:18, Daan De Meyer wrote:
> Add the necessary plumbing to hook up the new cgroup unix sockaddr
> hooks into bpftool.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  .../bpftool/Documentation/bpftool-cgroup.rst  | 21 ++++++++++++++-----
>  .../bpftool/Documentation/bpftool-prog.rst    | 10 +++++----
>  tools/bpf/bpftool/bash-completion/bpftool     | 14 ++++++-------
>  tools/bpf/bpftool/cgroup.c                    | 17 ++++++++-------
>  tools/bpf/bpftool/prog.c                      |  9 ++++----
>  5 files changed, 44 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> index bd015ec9847b..a2d990fa623b 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> @@ -34,13 +34,16 @@ CGROUP COMMANDS
>  |	*ATTACH_TYPE* := { **cgroup_inet_ingress** | **cgroup_inet_egress** |
>  |		**cgroup_inet_sock_create** | **cgroup_sock_ops** |
>  |		**cgroup_device** | **cgroup_inet4_bind** | **cgroup_inet6_bind** |
> -|		**cgroup_inet4_post_bind** | **cgroup_inet6_post_bind** |
> -|		**cgroup_inet4_connect** | **cgroup_inet6_connect** |
> +|		**cgroup_unix_bind** | **cgroup_inet4_post_bind** |
> +|		**cgroup_inet6_post_bind** | **cgroup_inet4_connect** |
> +|		**cgroup_inet6_connect** | **cgroup_unix_connect** |
>  |		**cgroup_inet4_getpeername** | **cgroup_inet6_getpeername** |
> -|		**cgroup_inet4_getsockname** | **cgroup_inet6_getsockname** |
> -|		**cgroup_udp4_sendmsg** | **cgroup_udp6_sendmsg** |
> +|		**cgroup_unix_getpeername** | **cgroup_inet4_getsockname** |
> +|		**cgroup_inet6_getsockname** | **cgroup_udp4_sendmsg** |

Aren't we missing "cgroup_unix_getsockname" in this list?

Looks all good otherwise, thanks.

> +|		**cgroup_udp6_sendmsg** | **cgroup_unix_sendmsg** |
>  |		**cgroup_udp4_recvmsg** | **cgroup_udp6_recvmsg** |
> -|		**cgroup_sysctl** | **cgroup_getsockopt** | **cgroup_setsockopt** |
> +|		**cgroup_unix_recvmsg** | **cgroup_sysctl** |
> +|		**cgroup_getsockopt** | **cgroup_setsockopt** |
>  |		**cgroup_inet_sock_release** }
>  |	*ATTACH_FLAGS* := { **multi** | **override** }

