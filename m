Return-Path: <bpf+bounces-8653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E181C788D32
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844792817F9
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3864317743;
	Fri, 25 Aug 2023 16:27:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E92571
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:27:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8538619A0
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692980827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C65PDvEXcsTG7PIa3FWZcNnBTNeabNjEFiPeIkAY0VQ=;
	b=hLlj3Jtnb820qHr8cndh0tj83HopvOZiQJHxcPzv6QeagoN50F6PD/+zJQmyi6hoWcPZF0
	IiPRiILDVDL2XDL2yKuShsNB+iftcUO5Z/yXDXb7lxvffEw0OaHKieRR4punb8r1W0WGuj
	YRomriPUUhJQL5dm3InG/1STH2YVt0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-LyT7mH5rMpqg-ppyz34pSg-1; Fri, 25 Aug 2023 12:27:01 -0400
X-MC-Unique: LyT7mH5rMpqg-ppyz34pSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D09C8D40A1;
	Fri, 25 Aug 2023 16:27:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0F29EC1602B;
	Fri, 25 Aug 2023 16:26:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 25 Aug 2023 18:26:14 +0200 (CEST)
Date: Fri, 25 Aug 2023 18:26:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Yonghong Song <yhs@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] bpf: task_group_seq_get_next: cleanup the usage of
 get/put_task_struct
Message-ID: <20230825162611.GA10654@redhat.com>
References: <20230821150909.GA2431@redhat.com>
 <20230822120549.GA22091@redhat.com>
 <05c66b19-d083-57df-b1ee-73035613df36@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c66b19-d083-57df-b1ee-73035613df36@iogearbox.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/25, Daniel Borkmann wrote:
>
> Could you rebase this against bpf-next tree so this can run through our BPF
> CI? Right now the CI cannot pick the patch up due to merge conflict [0].
>
> Thanks,
> Daniel
>
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20230822120549.GA22091@redhat.com/

The merge failed because this patch depends on

	[PATCH] bpf: task_group_seq_get_next: cleanup the usage of next_thread()

in this thread. But please forget.

I've sent the new series. It would be nice if you can test at least 1-5,
the last 6/6 depends on

	[PATCH 1/2] introduce __next_thread(), fix next_tid() vs exec() race
	https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/

which was not merged yet.

Oleg.


