Return-Path: <bpf+bounces-7826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA0D77CF82
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177722813DB
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50C1548E;
	Tue, 15 Aug 2023 15:48:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BDD11CB7
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 15:48:23 +0000 (UTC)
Received: from out-26.mta0.migadu.com (out-26.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D9819BF
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 08:48:10 -0700 (PDT)
Message-ID: <cea059d7-4b57-0a55-2493-f99b2831e019@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692114488; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6ff+5HkDo1buXu0AUWuXbsUie/nqbNVjdcTgFD9Nnk=;
	b=ILWuSZM8S8QycOG3+h7/WX86YK315y6KWhkFe3WLD/5q0UjSRL2uKZg9jfbMa6w82Y+8Ko
	mf5zhBWVz3SfJ5UclWEYsJpAYyUYu751lJ/sIH2ZYsr5BJpIvzHFbx53QyeCWS8EaUeWCc
	uvZRSQ1LOPQ/mqCAc4q7/ke/2CaSp7M=
Date: Tue, 15 Aug 2023 08:48:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: Can eBPF programs call kfuncs of out-of-tree modules?
Content-Language: en-US
To: Shuyi Cheng <chengshuyi@linux.alibaba.com>, bpf <bpf@vger.kernel.org>
References: <45060ec9-d68a-dc6c-908d-649394f48dcb@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <45060ec9-d68a-dc6c-908d-649394f48dcb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/15/23 3:01 AM, Shuyi Cheng wrote:
> Hello.
> 
> Recently we found that eBPF can call kernel functions, but we don’t know 
> whether it is possible to call register_btf_kfunc_id_set in the 
> out-of-tree module, and enable eBPF programs of types such as kprobe and 
> tracepoint to call functions defined in out-of-tree modules.

Never tried but I think it is possible. register_btf_kfunc_id_set()
can be used in modules.

btf.c:EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set);

> 
> Thanks in advance!
> 

