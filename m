Return-Path: <bpf+bounces-6749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9781776D849
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 22:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47798281219
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 20:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96F111A0;
	Wed,  2 Aug 2023 19:59:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9911188
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 19:59:56 +0000 (UTC)
Received: from out-106.mta1.migadu.com (out-106.mta1.migadu.com [IPv6:2001:41d0:203:375::6a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81CC2101
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 12:59:55 -0700 (PDT)
Message-ID: <70257605-8ed8-f601-761e-eb84e58b98ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691006394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMjIHatLO9A+UshOoLZyunUSyrW5/An/3G22nH5xizY=;
	b=uI00/t0CNaGtX/6R3BLG1xIRx3Tgm2vTUchs/lUAovuPhVqvgEOr2v4cKoOlOxX6O+eI0E
	QYJKayNJghgVBegxXrwNk068vccA19oqASG8x50ulnazrGu83k3pB7WmtU3q2PBIZtFUuT
	xK3QDvbT/KXJLVJxpPbDVd9O59NtB2w=
Date: Wed, 2 Aug 2023 12:59:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next 2/5] bpf: Provide bpf_copy_from_user() and
 bpf_copy_to_user().
Content-Language: en-US
To: kuifeng@meta.com
Cc: sinquersw@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230722052248.1062582-1-kuifeng@meta.com>
 <20230722052248.1062582-3-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230722052248.1062582-3-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/21/23 10:22 PM, kuifeng@meta.com wrote:
> From: Kui-Feng Lee <kuifeng@meta.com>
> 
> Provide bpf_copy_from_user() and bpf_copy_to_user() to the BPF programs
> attached to cgroup/{set,get}sockopt. bpf_copy_to_user() is a new kfunc to

Allowing bpf_copy_to_user() in setsockopt will then change the "__user *optval". 
I don't think the userspace is expecting any change in the optval passed to 
setsockopt.

