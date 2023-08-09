Return-Path: <bpf+bounces-7382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F177654D
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCE6281D54
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834191AA7A;
	Wed,  9 Aug 2023 16:45:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9B18C2E
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:45:11 +0000 (UTC)
Received: from out-120.mta1.migadu.com (out-120.mta1.migadu.com [IPv6:2001:41d0:203:375::78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42961BFE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:45:09 -0700 (PDT)
Message-ID: <afec6cf3-1188-5b93-0431-260a4f5d6473@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691599508; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bbu6gxQXwfy0xs1hpq9QVwouLOMv6Ac0YRXhoz5mcwU=;
	b=pF5BkF5BkzC64CkCtqfH/seM9ze7qQkIwnXISl/l4ZrFlAPYdjfTTgcJcRTnLHHF32mca0
	6q/3WOVPRO6KYF1B1ctMnTpxfkwmBKiWYJOfhd9vZzz3oXSTEQ9KX70ABO23fxSS7n+O3M
	Fw4/LagKhEnwoNT6d6h9a9XjCX4JIqE=
Date: Wed, 9 Aug 2023 09:45:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv7 bpf-next 05/28] bpf: Add pid filter support for
 uprobe_multi link
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
References: <20230809083440.3209381-1-jolsa@kernel.org>
 <20230809083440.3209381-6-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230809083440.3209381-6-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/9/23 1:34 AM, Jiri Olsa wrote:
> Adding support to specify pid for uprobe_multi link and the uprobes
> are created only for task with given pid value.
> 
> Using the consumer.filter filter callback for that, so the task gets
> filtered during the uprobe installation.
> 
> We still need to check the task during runtime in the uprobe handler,
> because the handler could get executed if there's another system
> wide consumer on the same uprobe (thanks Oleg for the insight).
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

