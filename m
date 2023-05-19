Return-Path: <bpf+bounces-951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E3E70919D
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 10:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA031C21253
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C465671;
	Fri, 19 May 2023 08:25:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866920F7
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 08:25:56 +0000 (UTC)
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [91.218.175.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A076BE52
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 01:25:54 -0700 (PDT)
Message-ID: <93530368-5ef2-4f88-3ed2-ceb88b23935d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1684484752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSPuftV+do2EwYEGH8UH/yiiczhQgd8YeISgTkSNgsU=;
	b=PidDfXdHhNf6A3tcMUyIJ+3LFFtOlchN7bVFPPH2ML+UOgl/brWLUxmC3HQmuIrjvwSepk
	eDSRMVXb55K4tQ8/P99pSRYVqaCiEHIDCFFuwBTPfgW7xqjaFPiKO4/UqBoM8lGLWQnpB1
	XtHeX2eOOqGQEtwewLEkmPY56cFBnBg=
Date: Fri, 19 May 2023 01:25:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 bpf-next 09/10] bpf: Add kfunc filter function to
 'struct btf_kfunc_id_set'
Content-Language: en-US
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: sdf@google.com, void@manifault.com,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230517175942.528375-1-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230517175942.528375-1-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/17/23 10:59 AM, Aditi Ghag wrote:
>   static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
> -				  struct btf_id_set8 *add_set)
> +				  const struct btf_kfunc_id_set *kset)
>   {
> +	struct btf_kfunc_hook_filter *hook_filter;
> +	struct btf_id_set8 *add_set = kset->set;
>   	bool vmlinux_set = !btf_is_module(btf);
> +	bool add_filter = !!kset->filter;
>   	struct btf_kfunc_set_tab *tab;
>   	struct btf_id_set8 *set;
>   	u32 set_cnt;
> @@ -7737,6 +7747,20 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
>   		return 0;
>   
>   	tab = btf->kfunc_set_tab;
> +
> +	if (tab && add_filter) {
> +		int i;
> +
> +		hook_filter = &tab->hook_filters[hook];
> +		for (i = 0; i < hook_filter->nr_filters; i++) {
> +			if (hook_filter->filters[i] == kset->filter)
> +				add_filter = false;

Just noticed that this missed a "break;" that can save some unnecessary loops.

It seems it needs to respin one more time to clarify the patch 1 commit message. 
Please also move patch 9 before patch 6 adding the 'bpf: Add bpf_sock_destroy 
kfunc'. Patch 6 requires patch 9 to be safe. Then the patch 10 selftests can be 
combined with patch 8 selftests as the last patch of the set.

Others lgtm.

> +		}
> +
> +		if (add_filter && hook_filter->nr_filters == BTF_KFUNC_FILTER_MAX_CNT)
> +			return -E2BIG;
> +	}
> +
>   	if (!tab) {
>   		tab = kzalloc(sizeof(*tab), GFP_KERNEL | __GFP_NOWARN);
>   		if (!tab)


