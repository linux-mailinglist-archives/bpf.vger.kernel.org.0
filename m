Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD1597859
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbiHQU4A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbiHQUz7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 16:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F7EA74E6
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 13:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660769757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UCPQMtqG0VB+k5U8mjKK0NLp4lpMVU6Bz0wA0P8dEHU=;
        b=ThBBCF9EQKJQ7+2UcNvffsTBnI27jjgJcFAJwvsTnon9OGP33k6qQ/PSngdfcEYVVzzQLo
        Tawq+SPghwQRcnZo5c7UQcB4t/itYNuJfSgq1u0TTaq1kmmxna0z55mmE5EytWICxVmpFG
        3m5VvBol15AmvwYnS4smsJdxzMOQudQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-bPj_UI21ODiyJxAyER130Q-1; Wed, 17 Aug 2022 16:55:53 -0400
X-MC-Unique: bPj_UI21ODiyJxAyER130Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B45B6802E5D;
        Wed, 17 Aug 2022 20:55:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A05EAC15BB3;
        Wed, 17 Aug 2022 20:55:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220816164435.0558ef94@kernel.org>
References: <20220816164435.0558ef94@kernel.org> <20220816103452.479281-1-yin31149@gmail.com> <166064248071.3502205.10036394558814861778.stgit@warthog.procyon.org.uk> <804153.1660684606@warthog.procyon.org.uk>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dhowells@redhat.com, Hawkins Jiawei <yin31149@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bpf@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH] net: Fix suspicious RCU usage in bpf_sk_reuseport_detach()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3974012.1660769749.1@warthog.procyon.org.uk>
Date:   Wed, 17 Aug 2022 21:55:49 +0100
Message-ID: <3974013.1660769749@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> I like your version because it documents what the lock protecting this
> field is. 
> 
> In fact should we also add && sock_owned_by_user(). Martin, WDYT? Would
> that work for reuseport? Jakub S is fixing l2tp to hold the socket lock
> while setting this field, yet most places take the callback lock...

So how do you want to proceed?  My first version of the patch with
sock_owned_by_user()?

David

