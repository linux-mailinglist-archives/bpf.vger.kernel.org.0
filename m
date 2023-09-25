Return-Path: <bpf+bounces-10754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD27AD836
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 14:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 304101C2082F
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64D618C30;
	Mon, 25 Sep 2023 12:45:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758C11C8B
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 12:45:54 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E76107
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 05:45:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32008e339adso5942967f8f.2
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1695645951; x=1696250751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pS4hHTm1EEOcrv+PR/KnXKIpI3hRXOYngc1s51PQAk=;
        b=Pgt0RnsfwZc9XX8YYhXlwMSqUBjeAmuAGIAeqB8s/0HSxiyNS7p0fJRZw6bgZ/fMCI
         64qv7gBLpsG22VMUcD6WSUmL2Dkd5mOctCPcQMJ9T3q6ev09CzSmVMkz84gZMvi4XBkl
         eyxS28Ei4rKC/4zMwkTudGOv7FRMjfP9Zbxnf0Fwvw1ObWMxVWsTbXCD+e+EfsYVKfJZ
         P7bZGARbuAZGEXc2Ojfp/23i8DIYF+h+nKcTlzmMeCb2t2U1jL3dj+WgegTfjhfORP5x
         IXmOouqDeM/j5jlheYgOZ3kT3XqsrK4wR5e8DFb++SG03mWutimTJKi5zRoGfBfxBNHi
         GjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695645951; x=1696250751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pS4hHTm1EEOcrv+PR/KnXKIpI3hRXOYngc1s51PQAk=;
        b=uQUFykOwlOhCBcwEsw0zjTDAL4Nln63A4JxJ3djD+9gCIyU75okKZnylpET2EOUWJi
         HRUgCTQ6uNx/HeMqv3p5u40aRTCkSN2DC7cV893XhxuMH39aXMKu+POkn9nO5aA8VwGF
         bDXob3jbRfcBxqA+pKGG4gJ5S9e4rahVgl41FQRsq2rohKpGPUmZNJP02b1kxovQWDEo
         A3KDc0y26NAPes3yHngcEO1cxBLbBUGbMwUqZ1UudbayRTHQl2qEFwpXxESzI6wBvd34
         XtR5lwrfSh/h0ix8KHNYBIYFiyoIFfrleDblIq9bVNHmzRkX982ahQiH/K1FVNBuQYIC
         t0wA==
X-Gm-Message-State: AOJu0YzdrGWHsLJd3qvCRntrShLHxNl1uiW2NL1mhv3WkawUDr20uLcC
	r8efC2NXuXg08u2QcPJ+GDnySAftPlWtFd1g6RG7NA==
X-Google-Smtp-Source: AGHT+IEaLT8rq2bcnfmKUTttqEPiHDTNiTGKY/UxUoDMKH8UtTQA9rcR8OrNiwySdZlgrNIpaqpyKw==
X-Received: by 2002:a05:6000:185:b0:321:8d08:855e with SMTP id p5-20020a056000018500b003218d08855emr5391088wrx.24.1695645950778;
        Mon, 25 Sep 2023 05:45:50 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:b095:3966:9c75:5de? ([2a02:8011:e80c:0:b095:3966:9c75:5de])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0031fba0a746bsm11823765wrl.9.2023.09.25.05.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 05:45:50 -0700 (PDT)
Message-ID: <0ac77924-ee79-4a41-8737-2aa88a0d7ba1@isovalent.com>
Date: Mon, 25 Sep 2023 13:45:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 6/9] bpftool: Add support for cgroup unix
 socket address hooks
Content-Language: en-GB
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, kernel-team@meta.com, netdev@vger.kernel.org
References: <20230921120913.566702-1-daan.j.demeyer@gmail.com>
 <20230921120913.566702-7-daan.j.demeyer@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230921120913.566702-7-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/09/2023 13:09, Daan De Meyer wrote:
> Add the necessary plumbing to hook up the new cgroup unix sockaddr
> hooks into bpftool.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-cgroup.rst | 16 +++++++++++++---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  8 +++++---
>  tools/bpf/bpftool/bash-completion/bpftool        | 14 +++++++-------
>  tools/bpf/bpftool/cgroup.c                       | 16 +++++++++-------
>  tools/bpf/bpftool/prog.c                         |  7 ++++---
>  5 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> index bd015ec9847b..3e4f5ff24208 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> @@ -102,21 +105,28 @@ DESCRIPTION
>  		  **post_bind6** return from bind(2) for an inet6 socket (since 4.17);
>  		  **connect4** call to connect(2) for an inet4 socket (since 4.17);
>  		  **connect6** call to connect(2) for an inet6 socket (since 4.17);
> +		  **connectun** call to connect(2) for a unix socket (since 6.3);
>  		  **sendmsg4** call to sendto(2), sendmsg(2), sendmmsg(2) for an
>  		  unconnected udp4 socket (since 4.18);
>  		  **sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an
>  		  unconnected udp6 socket (since 4.18);
> +		  **sendmsgun** call to sendto(2), sendmsg(2), sendmmsg(2) for
> +		  an unconnected unix socket (since 6.3);
>  		  **recvmsg4** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
>  		  an unconnected udp4 socket (since 5.2);
>  		  **recvmsg6** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
>  		  an unconnected udp6 socket (since 5.2);
> +		  **recvmsgun** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
> +		  an unconnected unix socket (since 6.3);
>  		  **sysctl** sysctl access (since 5.2);
>  		  **getsockopt** call to getsockopt (since 5.3);
>  		  **setsockopt** call to setsockopt (since 5.3);
>  		  **getpeername4** call to getpeername(2) for an inet4 socket (since 5.8);
>  		  **getpeername6** call to getpeername(2) for an inet6 socket (since 5.8);
> +		  **getpeernameun** call to getpeername(2) for a unix socket (since 6.3);
>  		  **getsockname4** call to getsockname(2) for an inet4 socket (since 5.8);
>  		  **getsockname6** call to getsockname(2) for an inet6 socket (since 5.8).
> +		  **getsocknameun** call to getsockname(2) for a unix socket (since 6.3);

Same comment as for v4 - please update the kernel version (6.3) for the
new entries.

Bpftool changes look good otherwise.

Acked-by: Quentin Monnet <quentin@isovalent.com>

