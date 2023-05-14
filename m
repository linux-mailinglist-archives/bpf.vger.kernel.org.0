Return-Path: <bpf+bounces-467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C2701AE7
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 02:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA161C20A14
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 00:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C654ED3;
	Sun, 14 May 2023 00:08:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA6173
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 00:08:26 +0000 (UTC)
Received: from out-19.mta1.migadu.com (out-19.mta1.migadu.com [IPv6:2001:41d0:203:375::13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218A268E
	for <bpf@vger.kernel.org>; Sat, 13 May 2023 17:08:24 -0700 (PDT)
Message-ID: <a5a9c29b-dd95-bbdf-2fd3-303527edac51@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1684022901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAM4s7xsYLHqKD9QuhIYmBnepBj3RJDvm6FiXx7Bc6k=;
	b=wOAtjIAqfD2WM8ZJCaVYFI1AasQ2+qMSYT/xAa7UrQVBH2SqZ9+dxjipPoXkjUonGC9UWM
	+VD98XTNuelUrkiRffIzTPkD2lBQCitV2oFfTm7HrHmmNpQY0wAPh7okGcyDHbpHIybKs7
	usdzZL7wkOcGaPoMnpikcg/aL2USj9Q=
Date: Sat, 13 May 2023 17:08:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/4] selftests/bpf: Update EFAULT
 {g,s}etsockopt selftests
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org
References: <20230511170456.1759459-1-sdf@google.com>
 <20230511170456.1759459-3-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230511170456.1759459-3-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/11/23 10:04 AM, Stanislav Fomichev wrote:
> @@ -946,6 +1030,9 @@ static int run_test(int cgroup_fd, struct sockopt_test *test)
>   			goto free_optval;
>   		}
>   
> +		if (optlen > sizeof(test->get_optval))
> +			optlen = sizeof(test->get_optval);
> +

Applied with this if statement removed. It is no longer needed. Let me know if 
the removal was a mistake. Thanks.

