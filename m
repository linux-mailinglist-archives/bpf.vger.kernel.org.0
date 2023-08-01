Return-Path: <bpf+bounces-6564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9293176B7B5
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C14028113E
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1D26B0C;
	Tue,  1 Aug 2023 14:32:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3561D9B2
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 14:32:12 +0000 (UTC)
Received: from out-75.mta0.migadu.com (out-75.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7752D60
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:31:44 -0700 (PDT)
Message-ID: <5ed5587d-42a7-2198-87e5-46fef29f456c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690900296; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+w+FSd7s8EE58j0TKVIP/CqJbQQREo9FqWabF+IQblc=;
	b=Rdet7/P40BLaqeVygCUZVKaZyY1BvNeeSZW8Auvf5R+XJmcEZDwlEcz6AiJ9GyoWCPwwX3
	kIQ+umV6OlV+vq2DJD0FNgVOygLhSwNrT2uvKzyY3QFNLh+hDFAAcdaX9s3AH0xxCgbqP+
	eGM9U8lw9R4qnumdsD/BPAkWhMnd214=
Date: Tue, 1 Aug 2023 07:31:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3] tracing: perf_call_bpf: use struct
 trace_entry in struct syscall_tp_t
To: Yauheni Kaliuta <ykaliuta@redhat.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org
References: <20230728142740.483431-1-ykaliuta@redhat.com>
 <20230801075222.7717-1-ykaliuta@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801075222.7717-1-ykaliuta@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 12:52 AM, Yauheni Kaliuta wrote:
> bpf tracepoint program uses struct trace_event_raw_sys_enter as
> argument where trace_entry is the first field. Use the same instead
> of unsigned long long since if it's amended (for example by RT
> patch) it accesses data with wrong offset.
> 
> Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

