Return-Path: <bpf+bounces-35484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767D193AE0C
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B85285C48
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 08:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7D14C58A;
	Wed, 24 Jul 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHzKNUBe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5A1C2AD;
	Wed, 24 Jul 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810941; cv=none; b=t0CEqKBVWYW8SxK4pt+t7AFbe93aB04QevEID11Qf1bUruO0qQU3pkIlGT6NQTcCIxD5aMY86simVQy2bvbZbhbt1z/jUGoIoA1O2CpVVfOJ+xmiCG2gWlY4CQPsQ4KYjvtYGx4yfGwW3COAhkxIB3j9GgwX/pmZzZnTVBwWtT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810941; c=relaxed/simple;
	bh=ADNPp4F/VqDkDGRWYoc4J8SaeYXvRxknb7dPg/M+JBA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P+TSFfeBjxF39q1oKYaoiH9JxVPRl3RvEzzL6Z52DWbQkT0CB/g8ZRcJp9lqUNjOdiKnfHqOEbDfgqwYIi9d/eBpvj9m0UGxNV7KY/eXZsvQuuGjEBIbXTcJzQdjHnAY/60BeM1B9dwkbzj/vVUxm0oQYSRfCf/2oVKSj7wpOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHzKNUBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88FEC32782;
	Wed, 24 Jul 2024 08:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721810941;
	bh=ADNPp4F/VqDkDGRWYoc4J8SaeYXvRxknb7dPg/M+JBA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ZHzKNUBePi9xs7fN+QFne7tqCVIdmHRzUJaFm8HPpGPzeKaUDhM3wazic+cRGSBqF
	 OTdNOkEORq9WpisyRulmxgMY0vBa3DSyEmUA0l621rvulzzDVrxd2o1ThKXfkIe4U8
	 m9a6WL6nS2rBOZ9QIBll7CXjHOUAOCdsrOFOsVuOLh6t4we9TU7JMjR3kcLxIQ5rq+
	 9f+akZYcfaygvXiswYW+9CH/S5+47y8UuJQK49TfZulMNwW7uO0Ha6RGTQ3VowxP1c
	 Qz0YPwoxRrSFUyoFoCLkFHE0mxElN2Fv+de/ijNYZAlR0wclTVNNQoY0vuWQR2KDjm
	 mXhA7W24hJr3Q==
Message-ID: <a3c16c68-f6ff-47fd-b074-f42b2dad3b57@kernel.org>
Date: Wed, 24 Jul 2024 09:48:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH] tools/bpf:Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240724064252.5565-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-GB
In-Reply-To: <20240724064252.5565-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-07-23 23:42 UTC-0700 ~ Zhu Jun <zhujun2@cmss.chinamobile.com>
> The unsigned int should use "%u" instead of "%d".
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  tools/bpf/bpftool/xlated_dumper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index 567f56dfd9f1..3efa639434be 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -349,7 +349,7 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
>  
>  		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
>  
> -		printf("% 4d: ", i);
> +		printf("% 4u: ", i);


Thanks! But did you try to compile this? It produces a warning:

	xlated_dumper.c: In function ‘dump_xlated_plain’:
	xlated_dumper.c:352:28: warning: ' ' flag used with ‘%u’ gnu_printf format [-Wformat=]
	  352 |                 printf("% 4u: ", i);
	      |                            ^

Please fix it.

Quentin

