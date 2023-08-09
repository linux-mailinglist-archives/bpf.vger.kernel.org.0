Return-Path: <bpf+bounces-7384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E190A776563
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19F61C212AD
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2451BB4A;
	Wed,  9 Aug 2023 16:48:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4B18AE4
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:48:49 +0000 (UTC)
Received: from out-87.mta0.migadu.com (out-87.mta0.migadu.com [IPv6:2001:41d0:1004:224b::57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A561BFE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:48:46 -0700 (PDT)
Message-ID: <78958b12-81c9-e2a5-9eb2-e9fa5278b0e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691599723; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hRlSliTVvm1iDwXwYO9ccmg9k/tF0gzrcC4rP1dy2g=;
	b=M1T4Wm/QZYObnQ1xILaHJ5uPKNVPMZ0FYpRl4Y3X5vOUHpFC2sxrooguubvnwbluO56C6z
	mau03TKBDgPZeRfzYuUdlw3Er7hW3toaUzvMpXQioToj011+EZWYiKMOu/6GPmyTVHRO9K
	SR+UNMwuznH5lZXZK/kbPRthsShOqxc=
Date: Wed, 9 Aug 2023 09:48:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv7 bpf-next 06/28] bpf: Add bpf_get_func_ip helper support
 for uprobe link
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20230809083440.3209381-1-jolsa@kernel.org>
 <20230809083440.3209381-7-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230809083440.3209381-7-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/9/23 1:34 AM, Jiri Olsa wrote:
> Adding support for bpf_get_func_ip helper being called from
> ebpf program attached by uprobe_multi link.
> 
> It returns the ip of the uprobe.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>

