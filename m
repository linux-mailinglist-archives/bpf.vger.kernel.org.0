Return-Path: <bpf+bounces-8963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594EB78D364
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121D9281379
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 06:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C5B15C8;
	Wed, 30 Aug 2023 06:33:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBBE637
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:33:00 +0000 (UTC)
Received: from out-242.mta1.migadu.com (out-242.mta1.migadu.com [95.215.58.242])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB3D11B
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 23:32:59 -0700 (PDT)
Message-ID: <755913b4-f10d-130c-daf1-30c792f30360@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693377177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyCg8MSojTVbdz7DD8RP+d/FbCn49Hw7w1wgoI6be2Q=;
	b=KSHfox5ow6FJmGajuKtJL7+MMVJxoUgXq+aw06/WN8PG+WUlUgFOLpJV3UQ5JIZentaZqi
	SdC786SL+NMlczevXTnOuH9glxqeG5YR4T1huveyEy3tef4WmGq8S59Wyx0U15tZMFzh3M
	YMOxhZ0CSzqC9xKFp3FX5XXCOg7o7WU=
Date: Tue, 29 Aug 2023 23:32:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 8/9] selftests/bpf: Make sure mount directory
 exists
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: kernel-team@meta.com
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
 <20230829101838.851350-9-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230829101838.851350-9-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/29/23 3:18 AM, Daan De Meyer wrote:
> The mount directory for the selftests cgroup tree might
> not exist so let's make sure it does exist by creating
> it ourselves if it doesn't exist.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   tools/testing/selftests/bpf/cgroup_helpers.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
> index 2caee8423ee0..860043d473fd 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
> @@ -195,6 +195,11 @@ int setup_cgroup_environment(void)
>   
>   	format_cgroup_path(cgroup_workdir, "");
>   
> +	if (mkdir(CGROUP_MOUNT_PATH, 0777)) {
> +		log_err("mkdir mount");

It fails when the path does exist. This failed a lot of cgroup tests:

create_netns:PASS:create netns 0 nsec
(cgroup_helpers.c:199: errno: File exists) mkdir mount
#11 bind_perm: Failed to setup cgroup environment

> +		return 1;
> +	}
> +
>   	if (unshare(CLONE_NEWNS)) {
>   		log_err("unshare");
>   		return 1;


