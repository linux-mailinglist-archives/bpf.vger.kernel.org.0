Return-Path: <bpf+bounces-10189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A67A2B25
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 02:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E131C20C1C
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 00:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80A643;
	Sat, 16 Sep 2023 00:05:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577C367
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 00:05:36 +0000 (UTC)
Received: from out-225.mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307112102
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:05:35 -0700 (PDT)
Message-ID: <414e9f49-ad34-5282-6c05-882876440f34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694822733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TlaScHzBzr/qbRBTyCtySTJ6nxP2kkLx+DKw2O6/ew=;
	b=v4F7SWCeg57uZ0aEu3OhKqfez3Jq49RRAGiDVpzuLnOW4SBcHCzNzsuRftu/IshKFKc4Wp
	7/auE3prA0/rTI07dJHjvcmmEuc6Z7AoZNwiV5mRP8SpUM73UwpNmvf8yIT4qZNBt9sucF
	iyInqUaOLCla6WevU25fVXNF2AOLlv4=
Date: Fri, 15 Sep 2023 17:05:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v2 2/9] bpf: add register and unregister functions
 for struct_ops.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230913061449.1918219-1-thinker.li@gmail.com>
 <20230913061449.1918219-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230913061449.1918219-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/12/23 11:14 PM, thinker.li@gmail.com wrote:
> +int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod)
> +{
> +	struct bpf_struct_ops *st_ops = mod->st_ops;
> +	struct bpf_verifier_log *log;
> +	struct btf *btf;
> +	int err;
> +
> +	if (mod->st_ops == NULL ||
> +	    mod->owner == NULL)
> +		return -EINVAL;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
> +	if (!log) {
> +		err = -ENOMEM;
> +		goto errout;
> +	}
> +
> +	log->level = BPF_LOG_KERNEL;
> +
> +	btf = btf_get_module_btf(mod->owner);

Where is btf_put called?

It is not stored anywhere in patch 2, so a bit confusing. I quickly looked at 
the following patches but also don't see the bpf_put.

> +	if (!btf) {
> +		err = -EINVAL;
> +		goto errout;
> +	}
> +
> +	bpf_struct_ops_init_one(st_ops, btf, log);
> +	err = add_struct_ops(st_ops);
> +
> +errout:
> +	kfree(log);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(register_bpf_struct_ops);
> +
> +int unregister_bpf_struct_ops(struct bpf_struct_ops_mod *mod)

It is not clear to me why the subsystem needs to explicitly call 
unregister_bpf_struct_ops(). Can it be done similar to the module kfunc support 
(the kfunc_set_tab goes away with the btf)?

Related to this, does it need to maintain a global struct_ops array for all 
kernel module? Can the struct_ops be maintained under its corresponding module 
btf itself?

> +{
> +	struct bpf_struct_ops *st_ops = mod->st_ops;
> +	int err;
> +
> +	err = remove_struct_ops(st_ops);
> +	if (!err && st_ops->uninit)
> +		err = st_ops->uninit();
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(unregister_bpf_struct_ops);



