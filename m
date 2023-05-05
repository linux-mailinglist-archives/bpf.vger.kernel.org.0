Return-Path: <bpf+bounces-160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2E6F8C0A
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 00:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EEE1C21A26
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 22:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DE101DD;
	Fri,  5 May 2023 22:00:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB9C8C5
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 22:00:12 +0000 (UTC)
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395A270C
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 15:00:07 -0700 (PDT)
Message-ID: <2e88749b-cbd0-af1c-9a73-44947e53b486@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1683324005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6StPLmcmNd/vW/9wKSSAh4dUH0ZtXMjKu3OXsX8MtA=;
	b=coOUA7/SXyqvgZkh2BzELsdpUOaRdBUIXg4iQeLTcmUzKePGXtDaChrkH6UETHzgQtmM1e
	0LxvAKw/piPNUijNcI+HeV+QZux5xbqx6TW5OfJG5Vd4mOM4mhFbJOdOT0b+xiDuueRa1H
	QWfns3I0XIcpy45sEb4eS/vBFYpWRDk=
Date: Fri, 5 May 2023 15:00:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Don't EFAULT for {g,s}setsockopt
 with wrong optlen
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org
References: <20230504184349.3632259-1-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230504184349.3632259-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/4/23 11:43 AM, Stanislav Fomichev wrote:
> optval larger than PAGE_SIZE leads to EFAULT if the BPF program
> isn't careful enough. This is often overlooked and might break
> completely unrelated socket options. Instead of EFAULT,
> let's ignore BPF program buffer changes. See the first patch for
> more info.
> 
> In addition, clearly document this corner case and reset optlen
> in our selftests (in case somebody copy-pastes from them).

Looks good. A respin is needed to address the selftest issues. The bpf CI will 
help to confirm that.

Looking forward to v5. Thanks.

