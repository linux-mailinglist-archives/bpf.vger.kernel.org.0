Return-Path: <bpf+bounces-6553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AD276B690
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7002819D2
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B3322F08;
	Tue,  1 Aug 2023 14:01:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563B111E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 14:01:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C679F115
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690898476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7WIIC4EmcSMyslcy4PdgRwdrER+lWKYWgkhwMl2vuUk=;
	b=aAujG5fufO1IDBs+Z01JwDZfVRZzuAH/LglzAGTtrZkoOPNw84LJRqTO2gMOE6x3mWhjEe
	SVHb1fsIIfHqtmvGYRKUMudPO2aFOPAMzgqd4XMMCBBh7q9SMVmHZuhyVlaxxeWtTvTR2g
	58M9HTty9ughFR9JrRZQHzmtO1YlAVM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696-Br2tYg1gNg20Cq9TDNc9dw-1; Tue, 01 Aug 2023 10:01:09 -0400
X-MC-Unique: Br2tYg1gNg20Cq9TDNc9dw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EFE7299E767;
	Tue,  1 Aug 2023 14:01:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A723240C1258;
	Tue,  1 Aug 2023 14:01:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <64c903b02b234_1b307829418@willemb.c.googlers.com.notmuch>
References: <64c903b02b234_1b307829418@willemb.c.googlers.com.notmuch> <64c7acd57270c_169cd129420@willemb.c.googlers.com.notmuch> <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch> <20230718160737.52c68c73@kernel.org> <000000000000881d0606004541d1@google.com> <0000000000001416bb06004ebf53@google.com> <792238.1690667367@warthog.procyon.org.uk> <831028.1690791233@warthog.procyon.org.uk> <1401696.1690893633@warthog.procyon.org.uk>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
    syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
    bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
    dsahern@kernel.org, edumazet@google.com,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netdev@vger.kernel.org, pabeni@redhat.com,
    syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: Endless loop in udp with MSG_SPLICE_READ - Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1403252.1690898464.1@warthog.procyon.org.uk>
Date: Tue, 01 Aug 2023 15:01:04 +0100
Message-ID: <1403253.1690898464@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> That getfrag is needed. For non-splice cases, to fill the linear part
> of an skb. As your example shows, it is skipped if all data is covered
> by pagedlen?

Yes, because copy goes negative.  To quote from the previously quoted log:

	==>splice_to_socket() 6630
	udp_sendmsg(8,8)
	__ip_append_data(copy=-1,len=8, mtu=8192 skblen=8189 maxfl=8188)
	pagedlen 9 = 9 - 0
	copy -1 = 9 - 0 - 1 - 9

copy is -(the number of excess bytes).

	length 8 -= -1 + 0

which then gets deducted from the length - but why?  I wonder if copy should
be cleared if we don't call getfrag().  It looks like it's meant to deduct the
amount copied by getfrag(), but that doesn't happen if copy < 0.

Also, note that MSG_ZEROCOPY might see the same maths issue here.

David


