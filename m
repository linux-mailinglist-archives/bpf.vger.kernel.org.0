Return-Path: <bpf+bounces-5767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A87760210
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4372813FD
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28BE125A5;
	Mon, 24 Jul 2023 22:15:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E702FB6;
	Mon, 24 Jul 2023 22:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65425C433C8;
	Mon, 24 Jul 2023 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690236908;
	bh=5xU8tBKog8sD1JT305O0sYBJ6mz8EHv0yDqZFATvuNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dr7Xp5wnxDZjFEfx+9tLIR9i1MgWSC/hswijslOzxPFHq9W87Z22xM9hkc0K3vLAP
	 535QD2ZHp8H6dMsCMjtoKd7buT93O2EG0PYYq5oP7PzSYdR9F06z2WV33nxLLK+tRe
	 YyxFhBZdYX4f/GfwsfYB1BnUwCRMjtwmb+E+dppsrvTJeNKzCpvo5c9oxr2lA8VVCg
	 qKxUa2v/dRoWOUMsZ2WQgV7hwUnYdoCAB+1yjRpTnFPSAaxRIoyjH6TimHB8X6Zuq4
	 DlwzGY69RwYl19StgzX/UPl0XyknSrEtRWV0cV4R9Ar4sm0NYIA/F+yUJmvGES3+Vt
	 x9dudg89G0hqw==
Date: Mon, 24 Jul 2023 15:15:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ast@kernel.org, martin.lau@kernel.org, yhs@fb.com, andrii@kernel.org,
 void@manifault.com, houtao1@huawei.com, laoar.shao@gmail.com,
 inwardvessel@gmail.com, kuniyu@amazon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Message-ID: <20230724151507.6b725396@kernel.org>
In-Reply-To: <20230723075452.3711158-1-linma@zju.edu.cn>
References: <20230723075452.3711158-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jul 2023 15:54:52 +0800 Lin Ma wrote:
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index d4172534dfa8..6f1afbb394a6 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -511,6 +511,11 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
>  		if (nla_type(nla) != SK_DIAG_BPF_STORAGE_REQ_MAP_FD)
>  			continue;
>  
> +		if (nla_len(nla) < sizeof(map_fd)) {
> +			err = -EINVAL;
> +			goto err_free;
> +		}

You can move this check earlier, when the attributes are getting
counted. That way we can avoid the alloc/free on error.

