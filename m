Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522B868DCA2
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 16:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjBGPMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 10:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjBGPLi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 10:11:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FE934308
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 07:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675782587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GxBfoqI0PHHne7Q8icH0M4s0J6nFlvJqJYlQUhkLb0g=;
        b=NfxRWiampIUkMrM4yRvppGyENZxEr5lslNn5h7r3RvvPiJxBUjysPWWFIo0Crex+9iBavw
        zIp1jl9buZwRjiZYiDDTA26Y2frzI3PKfg8RTbmfl3Ze5cYONVilOvMF8g7R5bxDuSBAAO
        sHgcCXZiQ4/5AfgrKH/OJVKsv3/v05Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-25NjHeWuOEiRldTs_uNVyA-1; Tue, 07 Feb 2023 10:09:42 -0500
X-MC-Unique: 25NjHeWuOEiRldTs_uNVyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A09D180D0F2;
        Tue,  7 Feb 2023 15:09:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72BBE1121314;
        Tue,  7 Feb 2023 15:09:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000003a78a905f4049614@google.com>
References: <0000000000003a78a905f4049614@google.com>
To:     syzbot <syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, bpf@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, hch@lst.de,
        jhubbard@nvidia.com, kuba@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, npiggin@gmail.com, pabeni@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Subject: Re: [syzbot] kernel BUG in process_one_work
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3416442.1675782578.1@warthog.procyon.org.uk>
Date:   Tue, 07 Feb 2023 15:09:38 +0000
Message-ID: <3416443.1675782578@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

#syz dup: [syzbot] general protection fault in skb_dequeue (3)

