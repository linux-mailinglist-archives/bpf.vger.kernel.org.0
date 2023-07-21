Return-Path: <bpf+bounces-5594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F323E75C229
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 10:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5BE28212D
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A614F7B;
	Fri, 21 Jul 2023 08:55:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21214F70
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 08:55:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A9A30F2
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689929712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxi4yw6Y1R2HQXNktH409rn6m0545/xFCZYHCFbDF08=;
	b=UMZCiMEgwGH1zcPX8RZzAXHTJ0LrrK7YBf7vpMffxOXvH1QHIZpwS/jjLa9o0a/8/ETT6s
	5rIOPVhdpOppST0a0bJeZsLrUvgg1IrUAotXpncnJ5orj9PIegoDp6sd9mJA1ETEl7FOrV
	EQvHaOgD72haM8jMXzszBa2qj5tZ1sY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-MIqcbXVIOqSpVGOxeqoJvA-1; Fri, 21 Jul 2023 04:55:08 -0400
X-MC-Unique: MIqcbXVIOqSpVGOxeqoJvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4798800962;
	Fri, 21 Jul 2023 08:55:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with SMTP id A89CD40C206F;
	Fri, 21 Jul 2023 08:55:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 21 Jul 2023 10:54:30 +0200 (CEST)
Date: Fri, 21 Jul 2023 10:54:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv4 bpf-next 05/28] bpf: Add pid filter support for
 uprobe_multi link
Message-ID: <20230721085426.GA10987@redhat.com>
References: <20230720113550.369257-1-jolsa@kernel.org>
 <20230720113550.369257-6-jolsa@kernel.org>
 <CALOAHbB3_qTzi+2_0=pFjyDXFUh_MGMJt6gz7eh0Z=He4guPow@mail.gmail.com>
 <20230721083140.GA10521@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721083140.GA10521@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sorry for noise, apparently I haven't woken up yet,

On 07/21, Oleg Nesterov wrote:
>
> Or. We can simply kill uprobe_multi_link_filter(). In this case uprobe_register()
> can touch CLONE_VM'ed mm's we are not interested in, but everything should work
> correctly.

please ignore CLONE_VM'ed above, I have no idea why did I say this...

Yes, everything should work "correctly", but if you add a probe into (say) libc.so,
every task will be penalized, so I don't think this is a good option.

Oleg.


