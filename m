Return-Path: <bpf+bounces-8426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC82978644C
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 02:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198FC1C20D2B
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 00:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9B915C1;
	Thu, 24 Aug 2023 00:44:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A877F
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 00:44:04 +0000 (UTC)
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C539ECED
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:44:02 -0700 (PDT)
Message-ID: <79a8ddfe-e7db-4831-3a67-3818a1c2143a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692837841; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcW1N7syhUyTdGge9h7C1SMam3q+rY91aXxbdFlmXZI=;
	b=D3pacwYvySa1kDBt+qStgJD4jme82RoQnSN6YBdYLioKMj75sE/Jg9aPZZJqvMtbh6t2hW
	KzHhseGhR2LNXAe6z5phKQpQhUqub3ViW+aK+2dNKCbtNyzYvupG3AoN78yGMEwGPsQ12L
	JK6YAgf861GpNvBoUpWYf5y7Uw7J04c=
Date: Wed, 23 Aug 2023 17:43:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 2/2] libbpf: fix signedness determination in
 CO-RE relo handling logic
Content-Language: en-US
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Lorenz Bauer <lmb@isovalent.com>
References: <20230824000016.2658017-1-andrii@kernel.org>
 <20230824000016.2658017-2-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230824000016.2658017-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/23 5:00 PM, Andrii Nakryiko wrote:
> Extracting btf_int_encoding() is only meaningful for BTF_KIND_INT, so we
> need to check that first before inferring signedness.
> 
> Closes: https://github.com/libbpf/libbpf/issues/704
> Reported-by: Lorenz Bauer <lmb@isovalent.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

