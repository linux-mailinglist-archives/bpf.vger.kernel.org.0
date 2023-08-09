Return-Path: <bpf+bounces-7376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686D07764C0
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720951C20A06
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA581C9F2;
	Wed,  9 Aug 2023 16:11:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB88919BB4
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:11:41 +0000 (UTC)
Received: from out-89.mta0.migadu.com (out-89.mta0.migadu.com [IPv6:2001:41d0:1004:224b::59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9001BD9
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:11:40 -0700 (PDT)
Message-ID: <09a30d5f-079b-8a06-30da-796c4d31fcaa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691597497; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbZ/4YNtr+s/QM7TMmeM5c8ZG+5GxifjWZ9ZX374PtA=;
	b=D+19mZ6JvixOeYYBTQGrRr5rqwxOU+RFO62epkk+O6hpIzXgFdWGWIMRvxhHTEw4/YKA4I
	P6MDmQDKAYjkjJFFVTRS6NoS/dt38PXHWsw7OQX7JDSgLUlP58i8sJHTLUmrr/ur7ZQGDw
	Y5IkmYluWHaWgySw4SABZuMFNpayDDg=
Date: Wed, 9 Aug 2023 09:11:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv7 bpf-next 02/28] bpf: Add attach_type checks under
 bpf_prog_attach_check_attach_type
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20230809083440.3209381-1-jolsa@kernel.org>
 <20230809083440.3209381-3-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230809083440.3209381-3-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/9/23 1:34 AM, Jiri Olsa wrote:
> Add extra attach_type checks from link_create under
> bpf_prog_attach_check_attach_type.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

