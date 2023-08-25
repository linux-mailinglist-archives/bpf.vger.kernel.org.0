Return-Path: <bpf+bounces-8582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2138788906
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC3228187F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2533FFBE9;
	Fri, 25 Aug 2023 13:51:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFEF7495
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 13:51:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88BD2136
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692971495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jK3xSjb/lOjMclM2a5gGdxu3MOziRDE5NpOq8r8JMtM=;
	b=KgHEBe9trpsaaDl/1a4v0yngyuPCcsAMmgrM5T3g7IE8+NIivEA0OLcyhHXFJbQSxqOwiN
	Vww8JDyQdhad5aFnvoY5aHu0hy+NHhgRqLPxUByECTkFHT++WPPRj6vbw4AqGZzmS+kmhu
	0XYBImYnuY1ZA3G21NKyJlY7HCDcv/4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-JswWGrA4MAKKuN7zNtcX5A-1; Fri, 25 Aug 2023 09:51:31 -0400
X-MC-Unique: JswWGrA4MAKKuN7zNtcX5A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03CB21C07593;
	Fri, 25 Aug 2023 13:51:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id 38406492C18;
	Fri, 25 Aug 2023 13:51:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 25 Aug 2023 15:50:44 +0200 (CEST)
Date: Fri, 25 Aug 2023 15:50:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yonghong Song <yhs@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 next_thread()
Message-ID: <20230825135041.GB29260@redhat.com>
References: <20230821150909.GA2431@redhat.com>
 <20230825124115.GA13849@redhat.com>
 <87fs47qm5u.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs47qm5u.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/25, Eric W. Biederman wrote:
>
> For the record I find this code confusing, and wrong.

Oh, yes...

> and has
> a built in race condition which means it could wind up iterating through
> a different process.

Yes, common->pid and/or common->pid_visiting can be reused

but I am not going to try to fix this ;)

> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks!

Oleg.


