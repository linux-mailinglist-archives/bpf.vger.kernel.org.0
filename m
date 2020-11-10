Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56FE2AD8B6
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbgKJOZ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 09:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730850AbgKJOZ1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Nov 2020 09:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605018326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+qK/pebV9lfCTzD2UyXhbkhPqVjurjoRr6IFVLA9HE=;
        b=MaglAjC/5Ne0B9pH16d02RBafR3oNTRFkvZenBpeySAjYOs7f3F8dUbQfxulZm1+lvr5PW
        XERPcJcLk8L5U3gWLUiyupbQtVeCoodJCXUPJkFZNnoESptan+am78U92e83+bAJQ0Rxkt
        XEXNQ8bkDs8eLHfcyFhxrHtu01zOY9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-FaQ_K7evPU-J5TI-pK-ihA-1; Tue, 10 Nov 2020 09:25:22 -0500
X-MC-Unique: FaQ_K7evPU-J5TI-pK-ihA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E1336D246;
        Tue, 10 Nov 2020 14:25:20 +0000 (UTC)
Received: from carbon (unknown [10.36.110.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C99DB75135;
        Tue, 10 Nov 2020 14:25:11 +0000 (UTC)
Date:   Tue, 10 Nov 2020 15:25:10 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>, brouer@redhat.com,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf-next] samples/bpf: add xdp_redirect_map with
 xdp_prog support
Message-ID: <20201110152510.2a7fa65c@carbon>
In-Reply-To: <20201110124639.1941654-1-liuhangbin@gmail.com>
References: <20201110124639.1941654-1-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 10 Nov 2020 20:46:39 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> This patch add running xdp program on egress interface support for
> xdp_redirect_map sample. The new prog will change the IP ttl based
> on egress ifindex.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  samples/bpf/xdp_redirect_map_kern.c | 74 ++++++++++++++++++++++++++++-
>  samples/bpf/xdp_redirect_map_user.c | 21 ++++----

Hmmm... I don't think is it a good idea to modify xdp_redirect_map this way.

The xdp_redirect_map is used for comparative benchmarking and
mentioned+used in scientific articles.  As far as I can see, this
change will default slowdown xdp_redirect_map performance, right?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

