Return-Path: <bpf+bounces-8231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F7D78404B
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E001C20AF9
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411551C298;
	Tue, 22 Aug 2023 12:06:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A49457
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:06:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0861ED1
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692705998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPF8JSm19Cq9ksmWlhIY7DVRMliMR17aW+7Sp8f/dzE=;
	b=S/xogCV7lBWnrxExOsJOzJHqVAmVmblPTCwkXPnljk6Xuaypn2eprh7SvPPQZ2BQ0FQn8F
	BLUmajynoKe4aWDZuhAKFDzuj7DHrlQAieJOx/4nle2WELRXIpvgGEzKZp8p9CddY8Y6/K
	+6vfjwBn5k+op8f6p79JRO0OgbqoDpc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-6-V0eKxgMWay5v_zX-ymFg-1; Tue, 22 Aug 2023 08:06:32 -0400
X-MC-Unique: 6-V0eKxgMWay5v_zX-ymFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEEE3185A78B;
	Tue, 22 Aug 2023 12:06:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by smtp.corp.redhat.com (Postfix) with SMTP id E9CA364687;
	Tue, 22 Aug 2023 12:06:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 22 Aug 2023 14:05:45 +0200 (CEST)
Date: Tue, 22 Aug 2023 14:05:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Yonghong Song <yhs@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 get/put_task_struct
Message-ID: <20230822120542.GA535@redhat.com>
References: <20230821150909.GA2431@redhat.com>
 <20230821200311.GA22497@redhat.com>
 <88ba3052-9e09-af0d-347e-2a8e8b043617@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ba3052-9e09-af0d-347e-2a8e8b043617@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/21, Yonghong Song wrote:
>
>
> On 8/21/23 1:03 PM, Oleg Nesterov wrote:
> >get_pid_task() makes no sense, the code does put_task_struct() soon after.
> >Use find_task_by_pid_ns() instead of find_pid_ns + get_pid_task and kill
> >kill put_task_struct(), this allows to do get_task_struct() only once
>
> remove the duplicated 'kill' in the above.

Done,

> LGTM.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thanks, I'll send V2 with your ack included in a minute.

Oleg.


