Return-Path: <bpf+bounces-7177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC527729F9
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF731C20BE3
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A6D111B8;
	Mon,  7 Aug 2023 16:00:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA311196
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 16:00:04 +0000 (UTC)
Received: from out-82.mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81849E74
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 09:00:02 -0700 (PDT)
Message-ID: <18cee522-3f88-5b81-fe6f-8ce212ab7cbc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691424000; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vc2iQvybqVlFD8zfRndMA5ECJ4KNg++YYKTGqjO0rc8=;
	b=A1l+BRItkEwjaEqqM7wxwRnqT9DaIDxKsLPlUe9YQ8/Oe5Y/yeMb7aJ6WT98fm3SnWQ2lD
	9Dd5v3FYbQ4Mwo5SbnnlpCjFqKam5IdgCVFrWs8S2PvclOK6ZG1aCJn0X+c7c5iBT786GQ
	V0jamAstjezP6yF6tSiLMRB5Dp8i5I0=
Date: Mon, 7 Aug 2023 08:59:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv3 bpf-next 2/3] selftests/bpf: Add bpf_get_func_ip tests
 for uprobe on function entry
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20230807085956.2344866-1-jolsa@kernel.org>
 <20230807085956.2344866-3-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230807085956.2344866-3-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/7/23 1:59 AM, Jiri Olsa wrote:
> Adding get_func_ip tests for uprobe on function entry that
> validates that bpf_get_func_ip returns proper values from
> both uprobe and return uprobe.
> 
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

