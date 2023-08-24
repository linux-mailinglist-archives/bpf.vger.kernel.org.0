Return-Path: <bpf+bounces-8425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBED878644B
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 02:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46012813A4
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 00:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7BB15C1;
	Thu, 24 Aug 2023 00:42:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B767F
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 00:42:44 +0000 (UTC)
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A49CED
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:42:42 -0700 (PDT)
Message-ID: <05db092d-6b5d-7e27-ce6a-b4fd022f2d89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692837760; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6zhZy9ceCdy9ixsPHIByC0ik2vi8ZHH3mW1IhPBKyI=;
	b=BH8LFLNDEWgid3qvoKrD3UN6tPvSeOsdpYGYdJ0mnqVXPNHG0cPu8oGfkpE5a/efKlSDw1
	qBZPwk8f4MItsGhqcwpy0RU4XhKyUspA39Q7BZxmxCJ3OhYez5svOdA9b/mgfPKrW1yb3S
	axAbl5G2u5M2GNR9B9Uoi0ivSsYOrY0=
Date: Wed, 23 Aug 2023 17:42:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: add uprobe_multi test binary
 to .gitignore
Content-Language: en-US
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20230824000016.2658017-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230824000016.2658017-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/23 5:00 PM, Andrii Nakryiko wrote:
> It seems like it was forgotten to add uprobe_multi binary to .gitignore.
> Fix this trivial omission.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

I actually noticed this problem as well. Thanks for the fix!

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 110518ba4804..f1aebabfb017 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -44,6 +44,7 @@ test_cpp
>   /bench
>   /veristat
>   /sign-file
> +/uprobe_multi
>   *.ko
>   *.tmp
>   xskxceiver

