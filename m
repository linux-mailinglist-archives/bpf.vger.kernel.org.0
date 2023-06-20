Return-Path: <bpf+bounces-2913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFCF736C1B
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 14:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F9281291
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64F614286;
	Tue, 20 Jun 2023 12:40:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F733101DE
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 12:40:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C7172B
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 05:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687264849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOKHZIrT87chu9Ugpdr9zOqxqCRpXBBMpwiWAcuoiSc=;
	b=NDt1o3t+68/ts9iHOv4pKuWV6t4HFbGrPr/SChCZ3+zdtdRlM1NFx2mTBS1uWi/MDUAa8t
	w6l6w/kFND6NsV6nkRhr6//pVJy4r+/VL2NOYjo2y2cq4j/ozOBkfJV5cSjeEOYWY4X3Vg
	jmS6XwFHU3mInbudtkHvzbizEFfa9Z8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-jv0UMSSgMvqcIKULfrIiTQ-1; Tue, 20 Jun 2023 08:40:42 -0400
X-MC-Unique: jv0UMSSgMvqcIKULfrIiTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94ADD3815EE3;
	Tue, 20 Jun 2023 12:40:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.178])
	by smtp.corp.redhat.com (Postfix) with SMTP id 233A840C2070;
	Tue, 20 Jun 2023 12:40:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 20 Jun 2023 14:40:14 +0200 (CEST)
Date: Tue, 20 Jun 2023 14:40:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 03/24] bpf: Add pid filter support for
 uprobe_multi link
Message-ID: <20230620124010.GA10037@redhat.com>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620083550.690426-4-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/20, Jiri Olsa wrote:
>
> We still need to check the task during runtime in the uprobe handler,
> because the handler could get executed if there's another system
> wide consumer on the same uprobe (thanks Oleg for the insight).

... or link->task's sub-thread hits this uprobe.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


