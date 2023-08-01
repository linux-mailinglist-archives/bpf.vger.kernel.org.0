Return-Path: <bpf+bounces-6536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDEC76AA3F
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 09:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4093B1C20D30
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 07:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE40C1EA97;
	Tue,  1 Aug 2023 07:47:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CD611B
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:47:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5255E48
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690876067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fr3C+UyA3RRBD/kfZAlkA+cHPdjSroXf6vhyShW1as0=;
	b=Wlqntbsa7j06GCAOQvQwSEc2O3awSiVdVph8CfaEUiWiaN+HumYigH/0+arMyVbqqh722N
	3E685zpRWvJoU0nF4xGvMmQa1IcgWqxCvykV9m/0+ME7tBGQpD5zYH3mghSEWVzN9yEJUl
	DcncFUzyrM7Yu1sy+koAr3+xJnxmI0A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-YQHCn5bpPjSVlx_Yym5-Qg-1; Tue, 01 Aug 2023 03:47:41 -0400
X-MC-Unique: YQHCn5bpPjSVlx_Yym5-Qg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D21953815EEA;
	Tue,  1 Aug 2023 07:47:40 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C8C56492CAC;
	Tue,  1 Aug 2023 07:47:37 +0000 (UTC)
Date: Tue, 1 Aug 2023 09:47:35 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: Ast@kernel.org, Daniel@iogearbox.net, Andrii@kernel.org,
	Martin.lau@linux.dev, Song@kernel.org, Yonghong.song@linux.dev,
	John.fastabend@gmail.com, Kpsingh@kernel.org, Sdf@google.com,
	Haoluo@google.com, Jolsa@kernel.org, Mykolal@fb.com,
	Shuah@kernel.org, Benjamin.tissoires@redhat.com, Memxor@gmail.com,
	Iii@linux.ibm.com, Colin.i.king@gmail.com, Awkrail01@gmail.com,
	Rdunlap@infradead.org, Joannelkoong@gmail.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next v2] selftests/bpf: replace fall through comment by
 fallthrough pseudo-keyword
Message-ID: <20230801074735.GA571679@alecto.usersys.redhat.com>
References: <20230801065447.3609130-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801065447.3609130-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Tue, Aug 01, 2023 at 02:54:47PM +0800, Ruan Jinjie wrote:
> Replace the existing /* fall through */ comments with the
> new pseudo-keyword macro fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - Update the subject and commit message.

I think what Alexei meant was subject-prefix which needs to be
'PATCH bpf-next'. You can read more about patch submission rules
in Documentation/bpf/bpf_devel_QA.rst.

-- 
 Artem


