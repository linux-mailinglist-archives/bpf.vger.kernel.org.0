Return-Path: <bpf+bounces-6591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B376BA22
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 18:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504AF1C20FC7
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3252150A;
	Tue,  1 Aug 2023 16:57:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E121ADE8
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 16:57:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA423E5C
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 09:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690909067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKlr7hPRFIg1XM1Mg6RUtTCl8BMjdJxudj9aZC6n25E=;
	b=gbEC7L20YggNALVmCH0RohDd0QzvwdQKuAcEZmErRhgbPwulpa4rJbGWc/rXmkdXQOm20m
	3a3wLvb44+sBuIoRLKPl1RIPZgE4pqrvXSeGJO8loQV5m3CwPOPVJxc+5rSJQROIT7L79j
	I8d6dZwH9ON4tfE/RGHXn63Z1jQvftw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-z-DU3XkbPMy31HetIn3hYg-1; Tue, 01 Aug 2023 12:57:44 -0400
X-MC-Unique: z-DU3XkbPMy31HetIn3hYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36A678007CE;
	Tue,  1 Aug 2023 16:57:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 743114024F83;
	Tue,  1 Aug 2023 16:57:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <64c93109c084e_1c5e3529452@willemb.c.googlers.com.notmuch>
References: <64c93109c084e_1c5e3529452@willemb.c.googlers.com.notmuch> <1420063.1690904933@warthog.procyon.org.uk>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com,
    bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
    dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
    pabeni@redhat.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
    linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] udp: Fix __ip_append_data()'s handling of MSG_SPLICE_PAGES
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1481563.1690909060.1@warthog.procyon.org.uk>
Date: Tue, 01 Aug 2023 17:57:40 +0100
Message-ID: <1481564.1690909060@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> copy -= -fraggap definitely seems off. You point out that it even can
> turn length negative?

Yes.  See the logging I posted:

	==>splice_to_socket() 6630
	udp_sendmsg(8,8)
	__ip_append_data(copy=-1,len=8, mtu=8192 skblen=8189 maxfl=8188)
	pagedlen 9 = 9 - 0
	copy -1 = 9 - 0 - 1 - 9
	length 8 -= -1 + 0

Since datalen and transhdrlen cancel, and fraggap is unsigned, if fraggap is
non-zero, copy will be negative.

> The WARN_ON_ONCE, if it can be reached, will be user triggerable.
> Usually for those cases and when there is a viable return with error
> path, that is preferable. But if you prefer to taunt syzbot, ok. We
> can always remove this later.

It shouldn't be possible for length to exceed msg->msg_iter.count (assuming
there is a msg) coming from userspace; further, userspace can't directly
specify MSG_SPLICE_PAGES.

> __ip6_append_data probably needs the same.

Good point.  The arrangement of the code is a bit different, but I think it's
substantially the same in this regard.

David


