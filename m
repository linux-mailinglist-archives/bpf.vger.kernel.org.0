Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0296F57FDEC
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 12:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiGYKzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 06:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiGYKzR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 06:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA8B9637D
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658746515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73TJkuj66rI8i79ddEyS/Vt1Sy1WWMqNacac5Cb+Gx0=;
        b=Qj7+bXqcyrKd+/VGlYaxEQGuN6W90DGZrk8XWo1hJ42MGNMwIY2v5DJbprovbQkRDkGfae
        qmH/LWJLcsxNXDhfYlWwfCdzmfsx9pn6YgGd/jowRn/8tWzXvRkwA917AUQJJ+sSacZucR
        IM1NwDXHdPhpRjcYAp5pMo46kwNINk4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-qR4FMCCrNXuPS6LJvhdcnQ-1; Mon, 25 Jul 2022 06:55:11 -0400
X-MC-Unique: qR4FMCCrNXuPS6LJvhdcnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02DDA8032FB;
        Mon, 25 Jul 2022 10:55:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6FDEC28118;
        Mon, 25 Jul 2022 10:55:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv>
References: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv> <20220721015605.20651-1-slark_xiao@163.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     dhowells@redhat.com, corbet@lwn.net,
        Slark Xiao <slark_xiao@163.com>, vgoyal@redhat.com,
        dyoung@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        william.gray@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: [PATCH v2] docs: Fix typo in comment
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2778503.1658746506.1@warthog.procyon.org.uk>
Date:   Mon, 25 Jul 2022 11:55:06 +0100
Message-ID: <2778505.1658746506@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Baoquan He <bhe@redhat.com> wrote:

> sed -i "s/the the /the /g" `git grep -l "the the "`

You might want to clarify the first "the" with a preceding boundary marker.
There are some English words ending in "the" that can be used as verbs, though
I'm not sure you'd find any of them here - clothe for example.

David

