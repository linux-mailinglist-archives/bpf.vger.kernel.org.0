Return-Path: <bpf+bounces-9049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6FB78ECBF
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AA31C20ADF
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7DF111AB;
	Thu, 31 Aug 2023 12:07:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07663CC
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 12:07:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0885E59
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693483625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7eGUrly/T+TjsJyEQHXY9eqJPI+TtQe0WPaN+ZPx0ps=;
	b=MTGVaksYvcZTgO40Uc29ibSE+AO2YfLbRHJv/RmyZwnfnbozznKlpqH3cCmGtDV+ApkJLE
	Q2isRKiIVoDrwmA5pQQAOT/IrtiMIUDsdHiPPu/TDYWcxVjjcq/CxQuyue5W0o7oc/0OSc
	8Jug+hHW39DAObZQBFEcVc1xxs8R9nc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-yb90YrfiO9aEe350LgVBCA-1; Thu, 31 Aug 2023 08:07:00 -0400
X-MC-Unique: yb90YrfiO9aEe350LgVBCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97C213C0F697;
	Thu, 31 Aug 2023 12:06:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.26])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0E47F1121315;
	Thu, 31 Aug 2023 12:06:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 31 Aug 2023 14:06:10 +0200 (CEST)
Date: Thu, 31 Aug 2023 14:06:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Message-ID: <20230831120606.GA6998@redhat.com>
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com>
 <20230825170406.GA16800@redhat.com>
 <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
 <20230827201909.GC28645@redhat.com>
 <ac60ff18-22b0-0291-256c-0e0c3abb7b62@linux.dev>
 <20230828105453.GB19186@redhat.com>
 <25be098a-dc41-7907-5590-1835308ebe28@linux.dev>
 <20230830235459.GA3570@redhat.com>
 <0261d27e-f9b5-c0fe-1bae-2b76062e7386@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0261d27e-f9b5-c0fe-1bae-2b76062e7386@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/31, Yonghong Song wrote:
>
> On 8/30/23 7:54 PM, Oleg Nesterov wrote:
> >
> >I simply can't understand how can this pull/5580 come when I specially
> >mentioned
> >
> >	> 6/6 obviously depends on
> >	>
> >	>	[PATCH 1/2] introduce __next_thread(), fix next_tid() vs exec() race
> >	>	https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
> >	>
> >	> which was not merged yet.
> >
> >in 0/6.
>
> The process in CI for testing is fully automated,

Ah, OK, sorry then.

> >>I suggest you get patch 1-5 and resubmit with tag like
> >>   "bpf-next v2"
> >>   [Patch bpf-next v2 x/5] ...
> >>so CI can build with different architectures and compilers to
> >>ensure everything builds and runs fine.

OK, will do when I have time.

Thanks,

Oleg.


