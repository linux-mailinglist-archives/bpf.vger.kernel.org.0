Return-Path: <bpf+bounces-8836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851678AE12
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAAC280D44
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE811C91;
	Mon, 28 Aug 2023 10:56:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168F5667
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 10:56:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C1268F
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693220150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CDS5fHYB73gNpd3JPwWKsT/4mQsPDNUXrtDTPKScZC0=;
	b=Xs3fTHEgFsp4S4W9gT6IruzHr2CKyNnE6mChqfi+Phu3JL27IbAEmbsYvYxB93JPZ1TW4d
	Xc1gyhjv3LlFVPeOMLJgLfKdghWUoZOY7gQdKZL8Jea1ZOzzYZ/8TiLxecS+r6lveLQA4G
	5c9sTa9RFtH9BrRvyxxxMSXL/+0bo2I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-7Ut3NBFGP7OOUFeewqOryQ-1; Mon, 28 Aug 2023 06:55:45 -0400
X-MC-Unique: 7Ut3NBFGP7OOUFeewqOryQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F75E857A84;
	Mon, 28 Aug 2023 10:55:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.176])
	by smtp.corp.redhat.com (Postfix) with SMTP id 9089A40C6F4E;
	Mon, 28 Aug 2023 10:55:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 28 Aug 2023 12:54:57 +0200 (CEST)
Date: Mon, 28 Aug 2023 12:54:54 +0200
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
Message-ID: <20230828105453.GB19186@redhat.com>
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com>
 <20230825170406.GA16800@redhat.com>
 <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
 <20230827201909.GC28645@redhat.com>
 <ac60ff18-22b0-0291-256c-0e0c3abb7b62@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac60ff18-22b0-0291-256c-0e0c3abb7b62@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/27, Yonghong Song wrote:
>
> On 8/27/23 1:19 PM, Oleg Nesterov wrote:
> >
> >But. if the group leader M exits then M->files == NULL. And in this case
> >task_seq_get_next() will need to "inspect" all the sub-threads even if they all
> >have the same ->files pointer.
>
> That is correct. I do not have practical experience on how much
> possibility this scenario may happen. I assume it should be very low.

Yes. I just tried to explain why the ->files check looks confusing to me.
Nevermind.

Could you review 6/6 as well?

Should I fold 1-5 into a single patch? I tried to document every change
and simplify the review, but I do not want to blow the git history.

Oleg.


