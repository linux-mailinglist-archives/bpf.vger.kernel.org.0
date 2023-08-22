Return-Path: <bpf+bounces-8202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB14783735
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 03:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80E9280F96
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA6710FA;
	Tue, 22 Aug 2023 01:07:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FE10E9
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 01:07:06 +0000 (UTC)
Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [IPv6:2001:41d0:1004:224b::15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8113D
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 18:07:00 -0700 (PDT)
Message-ID: <88ba3052-9e09-af0d-347e-2a8e8b043617@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692666418; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57xPwBg/RZutLMRYrXA0pEFYLV8BOzmSCdB6PB/RU30=;
	b=Wf00TOXdBv3SQo3aZPTQAriuEdYW9tHXRzzFqGroEGPwj1y1aYNgF8sULURZaweBtgakrq
	MnZxH9tRhTDJsxVI9+LctQUsKMjPGdARyCr2rleR0PW6WELgmBhGfXQlJDVg3ZXqF61cvH
	P6+lHqBFjlpKcdyVncqJJi1cXh0V3zw=
Date: Mon, 21 Aug 2023 18:06:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 get/put_task_struct
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>, Yonghong Song <yhs@fb.com>,
 Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230821150909.GA2431@redhat.com>
 <20230821200311.GA22497@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230821200311.GA22497@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 1:03 PM, Oleg Nesterov wrote:
> get_pid_task() makes no sense, the code does put_task_struct() soon after.
> Use find_task_by_pid_ns() instead of find_pid_ns + get_pid_task and kill
> kill put_task_struct(), this allows to do get_task_struct() only once

remove the duplicated 'kill' in the above.

> before return.
> 
> While at it, kill the unnecessary "if (!pid)" check in the "if (!*tid)"
> block, this matches the next usage of find_pid_ns() + get_pid_task() in
> this function.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

