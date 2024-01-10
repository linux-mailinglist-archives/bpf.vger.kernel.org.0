Return-Path: <bpf+bounces-19315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E18294E6
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 09:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433A6B237D3
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6C3E478;
	Wed, 10 Jan 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSTX9FCY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA43C47B
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704874498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGG/2geE26TRJsrsVr6H+l4Msp6AEXHSx5RkZnJct/Y=;
	b=LSTX9FCY/Rk22LV1X87GeOBXWhqNlrnWUyhn2MyJqao3GmCtzeCaV85hK8SP3T4gOByNgy
	sOw+uixyw+swmwWZlqNs9OfRKTTwdgUHkXvXL+vuhE9ks5rFahbzhGNFtyle+XEVaVDUMR
	WpRi61rKtC6ROwhPMwEk19wy/r7OJGI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-Sa_Xnn_eOqS4KaK6Q35JPQ-1; Wed,
 10 Jan 2024 03:14:55 -0500
X-MC-Unique: Sa_Xnn_eOqS4KaK6Q35JPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7724A1C0514A;
	Wed, 10 Jan 2024 08:14:54 +0000 (UTC)
Received: from wtfbox.lan (unknown [10.45.225.130])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 24DA140C6EB9;
	Wed, 10 Jan 2024 08:14:53 +0000 (UTC)
Date: Wed, 10 Jan 2024 09:14:51 +0100
From: Artem Savkov <asavkov@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: fix potential premature unload
 in bpf_testmod
Message-ID: <ZZ5R-3FAHNoDStqc@wtfbox.lan>
References: <20240109164317.16371-1-asavkov@redhat.com>
 <82f55c0e-0ec8-4fe1-8d8c-b1de07558ad9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82f55c0e-0ec8-4fe1-8d8c-b1de07558ad9@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Tue, Jan 09, 2024 at 11:40:38AM -0800, Yonghong Song wrote:
> 
> On 1/9/24 8:43 AM, Artem Savkov wrote:
> > It is possible for bpf_kfunc_call_test_release() to be called from
> > bpf_map_free_deferred() when bpf_testmod is already unloaded and
> > perf_test_stuct.cnt which it tries to decrease is no longer in memory.
> > This patch tries to fix the issue by waiting for all references to be
> > dropped in bpf_testmod_exit().
> > 
> > The issue can be triggered by running 'test_progs -t map_kptr' in 6.5,
> > but is obscured in 6.6 by d119357d07435 ("rcu-tasks: Treat only
> > synchronous grace periods urgently").
> > 
> > Fixes: 65eb006d85a2a ("bpf: Move kernel test kfuncs to bpf_testmod")
> 
> Please add your Signed-off-by tag.

Thanks for noticing. Will resend with signed-off-by and your ack.

> I think the root cause is that bpf_kfunc_call_test_acquire() kfunc
> is defined in bpf_testmod and the kfunc returns some data in bpf_testmod.
> But the release function bpf_kfunc_call_test_release() is in the kernel.
> The release func tries to access some data in bpf_testmod which might
> have been unloaded. The prog_test_ref_kfunc is defined in the kernel, so
> no bpf_testmod btf reference is hold so bpf_testmod can be unloaded before
> bpf_kfunc_call_test_release().
> As you mentioned, we won't have this issue if bpf_kfunc_call_test_acquire()
> is also in the kernel.
> 
> I think putting bpf_kfunc_call_test_acquire() in bpf_testmod and
> bpf_kfunc_call_test_release() in kernel is not a good idea and confusing.
> But since this is only for tests, I guess we can live with that. With that,

Correct. 65eb006d85a2a ("bpf: Move kernel test kfuncs to bpf_testmod")
also mentions why bpf_kfunc_call_test_release() is not in the module and
states that this is temporary. I'll add a comment in v2 so the wait can
be removed once the functions are re-united.
 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
> > ---
> >   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 91907b321f913..63f0dbd016703 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -2,6 +2,7 @@
> >   /* Copyright (c) 2020 Facebook */
> >   #include <linux/btf.h>
> >   #include <linux/btf_ids.h>
> > +#include <linux/delay.h>
> >   #include <linux/error-injection.h>
> >   #include <linux/init.h>
> >   #include <linux/module.h>
> > @@ -544,6 +545,9 @@ static int bpf_testmod_init(void)
> >   static void bpf_testmod_exit(void)
> >   {
> > +	while (refcount_read(&prog_test_struct.cnt) > 1)
> > +		msleep(20);
> > +
> >   	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
> >   }
> 

-- 
Regards,
  Artem


