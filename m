Return-Path: <bpf+bounces-7523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1C778771
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 08:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15691C21197
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 06:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA161865;
	Fri, 11 Aug 2023 06:28:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA8184C
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 06:28:14 +0000 (UTC)
Received: from out-124.mta0.migadu.com (out-124.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C712330E7
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 23:28:06 -0700 (PDT)
Message-ID: <528b748b-6893-016c-a921-a37748213bbe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691735285; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3dKqQ1un52a26x1Av3iyV3GFf/z3vO0ORpeOdAlDbA=;
	b=X7KZKBDQd8kjEyYO8yGnNY8kjiC+xNppblAYbRkbTJVuaL19S6ZTLHnfSxfUnTx/h3Pyrw
	aK3vEGbLed0c+ot8b49mh1sqIMkLjOrw3pBaasYnG0DbSs2TAD8zvPr+RWyEama63PrXyh
	q0uItQP2/0zgkjOzWGgZ4tsz+agJsC4=
Date: Thu, 10 Aug 2023 23:27:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [RFC bpf-next v2 2/6] bpf: Prevent BPF programs from access the
 buffer pointed by user_optval.
Content-Language: en-US
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, sdf@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20230811043127.1318152-1-thinker.li@gmail.com>
 <20230811043127.1318152-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230811043127.1318152-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/10/23 9:31 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <kuifeng@meta.com>
> 
> Since the buffer pointed by ctx->user_optval is in user space, BPF programs
> in kernel space should not access it directly.  They should use
> bpf_copy_from_user() and bpf_copy_to_user() to move data between user and
> kernel space.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

You probably only want
    Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
since it matches email 'From'. Also,
    From: Kui-Feng Lee <kuifeng@meta.com>
is different from email 'From'. Strange.

[...]

