Return-Path: <bpf+bounces-8721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128EF789222
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 00:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F5128165D
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 22:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A21AA65;
	Fri, 25 Aug 2023 22:57:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168318B1B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:57:43 +0000 (UTC)
Received: from out-253.mta1.migadu.com (out-253.mta1.migadu.com [IPv6:2001:41d0:203:375::fd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A99B1FC3;
	Fri, 25 Aug 2023 15:57:42 -0700 (PDT)
Message-ID: <50453723-813b-4d2b-2d83-3e2c57355230@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693004260; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNM3SuBZFH5nvdXhOSjFkO0GstPDo1DaGZ2GX7IY/7s=;
	b=VUWmpO7iqHEbNeCModTEKBilPXWZpFRE4jk7GAug/3XZuZNp+4uqmvxxcx+S/udPnXEru+
	AjORqhGJmxt1smumGmBfqI0ftgzoXOqdPR1BmMJCHu4WT/BvucKeSgq6yQ+sofetI7gUS9
	TWnH+2nlVwMP8La98vvEg7yl4W58DZs=
Date: Fri, 25 Aug 2023 15:57:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH 5/6] bpf: task_group_seq_get_next: simplify the "next tid"
 logic
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825161954.GA16886@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230825161954.GA16886@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/25/23 9:19 AM, Oleg Nesterov wrote:
> Kill saved_tid. It looks ugly to update *tid and then restore the
> previous value if __task_pid_nr_ns() returns 0. Change this code
> to update *tid and common->pid_visiting once before return.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

