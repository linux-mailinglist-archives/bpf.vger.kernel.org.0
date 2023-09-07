Return-Path: <bpf+bounces-9422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA667976CF
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCF81C20B46
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2E134C3;
	Thu,  7 Sep 2023 16:16:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83144134B0
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:16:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FFF1FD9
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694103319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7BPhunbYKy/PqHGz+TE8xRAQAb9MKTZwa32GIZ7N0FU=;
	b=P9lsgAN2UAaOZd8lEYOmJZvUf+ll977y+XKS1+xwp/Qt5BEJsZ6aK4xz0EpUeiPRUCUWmL
	Kvgc3CQyns/hMhBqac7/TCKqhwDrNuTWfexl4/vGe3q+jB+5wR57Z5Z7hEklctZ2HOgbY0
	lz/auzZlZXDVfHYGztHJvu/m7X3Mcqs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-yMENIZIVMpOtCscWFvjJFQ-1; Thu, 07 Sep 2023 02:45:34 -0400
X-MC-Unique: yMENIZIVMpOtCscWFvjJFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C8D538157B7;
	Thu,  7 Sep 2023 06:45:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.108])
	by smtp.corp.redhat.com (Postfix) with SMTP id E399F200BABC;
	Thu,  7 Sep 2023 06:45:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  7 Sep 2023 08:44:43 +0200 (CEST)
Date: Thu, 7 Sep 2023 08:44:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kui-Feng Lee <sinquersw@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: task_group_seq_get_next: misc
 cleanups
Message-ID: <20230907064440.GA352@redhat.com>
References: <20230905154612.GA24872@redhat.com>
 <20230905195829.GA8002@redhat.com>
 <CAADnVQJw81i+Qe0fveT07K39YkMA4xocQGZBmu=FbT+17sjxdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJw81i+Qe0fveT07K39YkMA4xocQGZBmu=FbT+17sjxdg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09/06, Alexei Starovoitov wrote:
>
> On Tue, Sep 5, 2023 at 12:59 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > The next (final) patch will change this code to use __next_thread when
> > >
> > >       https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
> > >
> > > is merged.
>
> The patch set looks fine.
> What is the next step?
> Should we merge it now in bpf-next and then during the next merge window
> you'll follow up with __next_thread clean up?

Thanks, works for me.

Oleg.


