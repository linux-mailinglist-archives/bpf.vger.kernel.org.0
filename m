Return-Path: <bpf+bounces-9278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAAE792F6A
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 21:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE711C20959
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 19:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B566DF4D;
	Tue,  5 Sep 2023 19:59:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61516DDC5
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 19:59:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422CAC1
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693943965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xG4LB9IAozstQIWCr01koNlUpf5xpaj9G7oEndoa9nM=;
	b=MJ9CWSEmgLyJUu3j2IeDXgqB1qD++i4QNH0Elr4QGL89aqFIQxZecK+2OOlxtIwpUlhz34
	MNtEt6jafwzaMuhnYLkeQjJUUJaqy6CjdLCyAaWLHStVH+vJEDKFn8sjp45ZOMGVi1oGrD
	lt3rGmMhqBleQKBx/mXlvNQcYfIPcQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-QU-CFiYLM0mowc8wKwEGRg-1; Tue, 05 Sep 2023 15:59:23 -0400
X-MC-Unique: QU-CFiYLM0mowc8wKwEGRg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D39E98164F6;
	Tue,  5 Sep 2023 19:59:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.87])
	by smtp.corp.redhat.com (Postfix) with SMTP id 9F805493110;
	Tue,  5 Sep 2023 19:59:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  5 Sep 2023 21:58:31 +0200 (CEST)
Date: Tue, 5 Sep 2023 21:58:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] bpf: task_group_seq_get_next: misc
 cleanups
Message-ID: <20230905195829.GA8002@redhat.com>
References: <20230905154612.GA24872@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905154612.GA24872@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sorry for noise, forgot to mention...

this (hopefully simple) series was only compile-tested.

On 09/05, Oleg Nesterov wrote:
>
> Yonghong,
>
> I am resending 1-5 of 6 as you suggested with your acks included.
>
> The next (final) patch will change this code to use __next_thread when
>
> 	https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
>
> is merged.
>
> Oleg.


