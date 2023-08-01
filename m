Return-Path: <bpf+bounces-6537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E3476AA47
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 09:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981771C20DCD
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1769C1EA99;
	Tue,  1 Aug 2023 07:50:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF638611B
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:50:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A046CE48
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690876200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T51+NUzcv3rzLoanETGgPnSGfB2Fqi/wbHHP0bRQKsY=;
	b=ArhDagm6xCoJl/F7NXm3L5IavYhm2SrfwUGBP3ru0Ow+Af5ubtDE5i0EipDqfApoP0q5Dy
	Sv4J1yg/ynKrHVulS38L8lgb0V5cU6Yp5Fr4MmaVksoSlBjDpKnvREGXpne5pbwFctHQDb
	Y1G3KpPkKtaEZsnvTNRq+8HsX1xUgvY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-BVZAQ3gYP_SdYMkSValKcQ-1; Tue, 01 Aug 2023 03:49:57 -0400
X-MC-Unique: BVZAQ3gYP_SdYMkSValKcQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4203C185A794;
	Tue,  1 Aug 2023 07:49:57 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.193.192])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 647E6401DA9;
	Tue,  1 Aug 2023 07:49:56 +0000 (UTC)
From: Yauheni Kaliuta <ykaliuta@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,  andrii@kernel.org,  ast@kernel.org
Subject: Re: [PATCH bpf-next v2] tracing: perf_call_bpf: use struct
 trace_entry in struct syscall_tp_t
References: <33b93245-6740-e2e7-3a2a-6a9375d7ddc4@linux.dev>
	<20230728142740.483431-1-ykaliuta@redhat.com>
	<225ed430-dfd1-bf0b-8481-58f5f0d3f7eb@linux.dev>
	<xunytttky04r.fsf@redhat.com>
	<200cfb02-38ea-ecb4-c8f1-8ee557184c41@linux.dev>
Date: Tue, 01 Aug 2023 10:49:52 +0300
In-Reply-To: <200cfb02-38ea-ecb4-c8f1-8ee557184c41@linux.dev> (Yonghong Song's
	message of "Mon, 31 Jul 2023 11:20:55 -0700")
Message-ID: <xunyjzuf19sv.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, Yonghong!

>>>>> On Mon, 31 Jul 2023 11:20:55 -0700, Yonghong Song  wrote:


 >> >> +
 >> >> +	/* __bpf_prog_run() requires *regs as the first parameter */
 >> > This comment is not correct.
 >> > static __always_inline u32 __bpf_prog_run(const struct bpf_prog
 >> *prog,
 >> >                                           const void *ctx,
 >> >                                           bpf_dispatcher_fn dfunc)
 >> > {
 >> > 	...
 >> > }
 >> > The first parameter is 'prog'.
 >> > Also there is no __bpf_prog_run() referenced in this function
 >> > so this comment may confuse readers. So I suggest removing
 >> > this comment. The same for perf_call_bpf_exit() below.
 >> Again, in [1] we agreed that it's better to have the comment
 >> since it's even more confusing.
 >> Could you help to formulate it?
 >> "__bpf_prog_run() requires *regs as the first argument for bpf
 >> prog" or something?
 >> But yes, I can remove it of course.

 > You could have a comment like below:
 > 	/* bpf prog requires 'regs' to be the first member in the ctx
 > 	(a.k.a. &param) */


Thanks!


-- 
WBR,
Yauheni Kaliuta


