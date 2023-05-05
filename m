Return-Path: <bpf+bounces-72-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353806F7A0F
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B7D280F36
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46E510E9;
	Fri,  5 May 2023 00:28:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D09ED1
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:28:38 +0000 (UTC)
Received: from out-38.mta0.migadu.com (out-38.mta0.migadu.com [IPv6:2001:41d0:1004:224b::26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776A12496
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 17:28:37 -0700 (PDT)
Message-ID: <115f1109-589f-4d16-bf5a-12866aa135c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1683246515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQAFFIGObVZsF2BRkhlptuVDddqNe9XpcPTNu6cklhw=;
	b=eQiEnsN2+ikWVx+9tDn2+VITl0ShNBXjovCqOBknQdRMr6/VOc9n2lvg4MNfVcQnYLn+HI
	LLRXcHzR1Pbhkn6aQguzCVtOI20CPlGO3PDewnsKKQNUSQEcpl04qJElOn6DVdJXGUc6HB
	taJGUoijY3TfV5Qs+7oyhyjBQqCjGt4=
Date: Thu, 4 May 2023 17:28:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 09/10] bpf: Add a kfunc filter function to
 'struct btf_kfunc_id_set'
Content-Language: en-US
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: sdf@google.com, David Vernet <void@manifault.com>, bpf@vger.kernel.org
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
 <20230503225351.3700208-10-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230503225351.3700208-10-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/3/23 3:53 PM, Aditi Ghag wrote:
> This commit adds the ability to filter kfuncs to certain BPF program
> types, and thereby limits bpf_sock_destroy kfunc to progras with attach

s/progras/program/

> type 'BPF_TRACE_ITER'.
> Previous patches introduced 'bpf_sock_destroy kfunc' that can only be
> called from BPF (sockets) iterator type programs.  The reason being, the
> kfunc requires lock_sock to be done from the BPF context prior to
> calling the kfunc.
> To that end, the patch adds a callback filter to 'struct
> btf_kfunc_id_set'.  The filter has access to the prog construct
> including other properties of the prog.  For the bpf_sock_destroy case,
> the `expected_attached_type` property of a prog construct is used to
> allow access to the kfunc in the provided callback filter.

Please also cc "David Vernet <void@manifault.com>" in the next respin.



