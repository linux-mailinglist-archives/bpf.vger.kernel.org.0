Return-Path: <bpf+bounces-13644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A98C7DC368
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 01:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04F11C20B72
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 00:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57441C3B;
	Tue, 31 Oct 2023 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pfrFjRJ6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18691C2E
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 00:05:28 +0000 (UTC)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [IPv6:2001:41d0:203:375::af])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28BC6
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 17:05:27 -0700 (PDT)
Message-ID: <ca7e896b-328b-454e-ad97-fc824df562af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698710723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/YUjq1v69MBLsAc5IX6Uscalj2TK70GIPvMUidDUkw=;
	b=pfrFjRJ68So5jnONDwQJKQzDbl38uRRn22GM28vZHeJGYafl0iPOc7u/K50dFRPNWWWfz/
	I17S4TY+z9kmhpIkuWRZI6uuKjiMQe5fk6oC4e1u9b0i5eEaj/0U5K7ySPG4jGmF0pA9Hs
	yJ46wkUraXIBSLg/4OPoaVdyhtk+Vnc=
Date: Mon, 30 Oct 2023 17:05:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Relax allowlist for css_task iter
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org
References: <20231025075914.30979-1-zhouchuyi@bytedance.com>
 <20231025075914.30979-2-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231025075914.30979-2-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/25/23 12:59 AM, Chuyi Zhou wrote:
> The newly added open-coded css_task iter would try to hold the global
> css_set_lock in bpf_iter_css_task_new, so the bpf side has to be careful in
> where it allows to use this iter. The mainly concern is dead locking on
> css_set_lock. check_css_task_iter_allowlist() in verifier enforced css_task
> can only be used in bpf_lsm hooks and sleepable bpf_iter.
>
> This patch relax the allowlist for css_task iter. Any lsm and any iter
> (even non-sleepable) and any sleepable are safe since they would not hold
> the css_set_lock before entering BPF progs context.
>
> This patch also fixes the misused BPF_TRACE_ITER in
> check_css_task_iter_allowlist which compared bpf_prog_type with
> bpf_attach_type.
>
> Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator kfuncs")
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


