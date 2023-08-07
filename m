Return-Path: <bpf+bounces-7180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6DF772A05
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462AA281494
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8B11C83;
	Mon,  7 Aug 2023 16:02:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DA10957
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 16:02:52 +0000 (UTC)
Received: from out-88.mta1.migadu.com (out-88.mta1.migadu.com [IPv6:2001:41d0:203:375::58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D820AE76
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 09:02:49 -0700 (PDT)
Message-ID: <13089360-7f62-04ba-a6ec-26f5e43465df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691424168; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5NXems8D0saHhNLLJ2niiR+pLfo6lhGhYaJOTgUqfY=;
	b=g8mPyAXQyEsZqNDlGFQ0xyNG8CZI92OeJyPsFXrIouRwt0rysI+Qp41KWTlg3/rqubH6ue
	Apx6xsRP77bB7w/2u+vhV4M65nRJrT+aZp2iZsSbAx3Z6ICfssIECF+BDVCoCNhpAEB47i
	9Fu/r0TLclGm3eiYHn7/WufJVkpJWWs=
Date: Mon, 7 Aug 2023 09:02:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv3 bpf-next 3/3] selftests/bpf: Add bpf_get_func_ip test
 for uprobe inside function
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
 <20230807085956.2344866-4-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230807085956.2344866-4-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/7/23 1:59 AM, Jiri Olsa wrote:
> Adding get_func_ip test for uprobe inside function that validates
> the get_func_ip helper returns correct probe address value.
> 
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

