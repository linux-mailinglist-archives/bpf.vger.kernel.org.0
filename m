Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F858493E
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 03:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiG2BIl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 21:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbiG2BIk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 21:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E19D94BD26
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 18:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659056919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UjK8WA9LgJeF558MQ4KdA6R8ULeQdKQ4U739a03eHPA=;
        b=M6RoQhtMwQGRPCrsSfJHCyJimfv2Ol5hgW6kjON40NVbn2i6x1cc+ZMHs4MHC1QLJZJdjM
        GT7XF8Q3eaRqXs1UkV3tlf/R5FkN87pmxl2wW05R8AtXaTNG+sFkN4fpQpBkv2wNKrOnue
        7Y4CIgow4mW1H8hIJXqJ8FXBmVlIR64=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-KERh3ai6P0WoM82ksuelGw-1; Thu, 28 Jul 2022 21:08:33 -0400
X-MC-Unique: KERh3ai6P0WoM82ksuelGw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39BCA85A588;
        Fri, 29 Jul 2022 01:08:32 +0000 (UTC)
Received: from localhost (ovpn-13-195.pek2.redhat.com [10.72.13.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13655492C3B;
        Fri, 29 Jul 2022 01:08:31 +0000 (UTC)
Date:   Fri, 29 Jul 2022 09:08:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     David Howells <dhowells@redhat.com>, corbet@lwn.net,
        vgoyal@redhat.com, dyoung@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, william.gray@linaro.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, tglx@linutronix.de, bigeasy@linutronix.de,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: [PATCH v2] docs: Fix typo in comment
Message-ID: <YuMzClsPIl47Ox5/@MiWiFi-R3L-srv>
References: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv>
 <20220721015605.20651-1-slark_xiao@163.com>
 <2778505.1658746506@warthog.procyon.org.uk>
 <Yt6bVIoRa0nIvxei@MiWiFi-R3L-srv>
 <55d366e4.486.1823808de32.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d366e4.486.1823808de32.Coremail.slark_xiao@163.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/26/22 at 09:04am, Slark Xiao wrote:
> At 2022-07-25 21:32:04, "Baoquan He" <bhe@redhat.com> wrote:
> >On 07/25/22 at 11:55am, David Howells wrote:
> >> Baoquan He <bhe@redhat.com> wrote:
> >> 
> >> > sed -i "s/the the /the /g" `git grep -l "the the "`
> >> 
> >> You might want to clarify the first "the" with a preceding boundary marker.
> >> There are some English words ending in "the" that can be used as verbs, though
> >> I'm not sure you'd find any of them here - clothe for example.
> >
> >Right. I plan to split this big one into patches corresponding to
> >different component as Jonathan suggested, and will consider how to mark
> >the first 'the' as you suggested, and wrap Slark's pathces which
> >includes typo fix of "then the".
> >
> >Thanks
> >Baoquan
> 
> Actually I have committed all changes which were listed in your previous list.
> I committed it one by one and checked if any other typo is included.
> If possible, you can try other double typo issue like "and and " or "or or" or something else.

That's good, I take leave this week to be babysitter, please go ahead to
handle all of them you found out.

