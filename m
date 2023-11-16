Return-Path: <bpf+bounces-15165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859017EDE10
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 10:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A901C20A3A
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0BD29427;
	Thu, 16 Nov 2023 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U46HiH70"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AC5E0
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700128549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXY1rZA1LxkMIb59EiEw9jOuJO4zWvPkFM9jnM+8Krc=;
	b=U46HiH70P0qIwzWM/KGqr7lsN0a9xiY2MWri2h099IuBRBbtDIPURXw3ky1/Soz7XAjWm2
	0/GOuMtKW7DJaREcJp2nUOngRwaN/odjWsS+bdLQrBY0LbqCJ6AlYa1x0OcwR12wRTv8vt
	H3il1W2Jqc5lS74uUT3iShh9ZUmGARQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-LgmwkCdWMbaa22VvNbTSRA-1; Thu, 16 Nov 2023 04:55:46 -0500
X-MC-Unique: LgmwkCdWMbaa22VvNbTSRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C829E8007B3;
	Thu, 16 Nov 2023 09:55:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
	by smtp.corp.redhat.com (Postfix) with SMTP id EBD58C27E84;
	Thu, 16 Nov 2023 09:55:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 16 Nov 2023 10:54:42 +0100 (CET)
Date: Thu, 16 Nov 2023 10:54:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/3] bpf: kernel/bpf/task_iter.c: don't abuse
 next_thread()
Message-ID: <20231116095439.GC18748@redhat.com>
References: <20231114163211.GA874@redhat.com>
 <c768aae4-1c41-41ef-895d-33556b99dc15@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c768aae4-1c41-41ef-895d-33556b99dc15@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 11/15, Yonghong Song wrote:
>
> On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> >Compile tested.
> >
> >Every lockless usage of next_thread() was wrong, bpf/task_iter.c is
> >the last user and is no exception.
>
> It would be great if you can give more information in the commit message
> about why the usage of next_thread() is wrong in bpf/task_iter.c.

I tried to explain the problems in the changelogs:

1/3:
	task_group_seq_get_next() can return the group leader twice if it races
	with mt-thread exec which changes the group->leader's pid.

2/3:
	bpf_iter_task_next() can loop forever, "kit->pos == kit->task" can never
	happen if kit->pos execs.

> IIUC, some information is presented in :
>   https://lore.kernel.org/all/20230824143112.GA31208@redhat.com/

Yes, Linus and Eric suggest to simply kill next_thread(). I am not
sure, this needs another discussion.

But as for bpf/task_iter.c... Even _if_ the usage was correct, this
code simply doesn't need the "circular" next_thread(), NULL at the
end simplifies the code.

> Also, please add 'bpf' in the subject tag ([PATCH bpf 0/3]) to
> make it clear the patch should be applied to bpf tree.

OK, will do next time. Or should I resend this series with 'bpf'
in the subject tag?

Thanks,

Oleg.


