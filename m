Return-Path: <bpf+bounces-9018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB0778E38B
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 01:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5453228122A
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3AF8F4D;
	Wed, 30 Aug 2023 23:55:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E658C13
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 23:55:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45ADCC
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 16:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693439756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dvpKwAUlH7l/3d38zTbznxnCgwvMBWdLNFevAQq2bAM=;
	b=LVXKM4pvrJqriiMyf5iXCkKeiIyymX5Gtw955WJdnsmAxpedPhMW3qYCQzjkrTnKs3h9n/
	wGdFoZIZwc3Egy9vcgwgtGKi3l+dNKEoKeMfT7QRbkzaS6CzQ5eLEkM5MUHQCRVwSjm14w
	EIa+/qU9bEWUpiCmR/6/U7dTyxmQKqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-J_nW4K65N_eTtTQT6BXufA-1; Wed, 30 Aug 2023 19:55:52 -0400
X-MC-Unique: J_nW4K65N_eTtTQT6BXufA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0E1080027F;
	Wed, 30 Aug 2023 23:55:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.26])
	by smtp.corp.redhat.com (Postfix) with SMTP id 1E0979A;
	Wed, 30 Aug 2023 23:55:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 31 Aug 2023 01:55:02 +0200 (CEST)
Date: Thu, 31 Aug 2023 01:54:59 +0200
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
Message-ID: <20230830235459.GA3570@redhat.com>
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com>
 <20230825170406.GA16800@redhat.com>
 <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
 <20230827201909.GC28645@redhat.com>
 <ac60ff18-22b0-0291-256c-0e0c3abb7b62@linux.dev>
 <20230828105453.GB19186@redhat.com>
 <25be098a-dc41-7907-5590-1835308ebe28@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25be098a-dc41-7907-5590-1835308ebe28@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/28, Yonghong Song wrote:
>
> On 8/28/23 3:54 AM, Oleg Nesterov wrote:
> >
> >Could you review 6/6 as well?
>
> I think we can wait patch 6/6 after
>    https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
> is merged.

OK.

> >Should I fold 1-5 into a single patch? I tried to document every change
> >and simplify the review, but I do not want to blow the git history.
>
> Currently, because patch 6, the whole patch set cannot be tested by
> bpf CI since it has a build failure:
>   https://github.com/kernel-patches/bpf/pull/5580

Heh. I thought this is obvious. I thought you can test 1-5 without 6/6
and _review_ 6/6.

I simply can't understand how can this pull/5580 come when I specially
mentioned

	> 6/6 obviously depends on
	>
	>	[PATCH 1/2] introduce __next_thread(), fix next_tid() vs exec() race
	>	https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
	>
	> which was not merged yet.

in 0/6.

> I suggest you get patch 1-5 and resubmit with tag like
>   "bpf-next v2"
>   [Patch bpf-next v2 x/5] ...
> so CI can build with different architectures and compilers to
> ensure everything builds and runs fine.

I think we can wait for

	https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/

as you suggest above, then I'll send the s/next_thread/__next_thread/
oneliner without 1-5. I no longer think it makes sense to try to cleanup
the poor task_group_seq_get_next() when IMHO the whole task_iter logic
needs the complete rewrite. Yes, yes, I know, it is very easy to blame
someone else's code, sorry can't resist ;)

The only "fix" in this series is 3/6, but this code has more serious
bugs, so I guess we can forget it.

Oleg.


