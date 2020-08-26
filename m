Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A12252934
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 10:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHZI3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 04:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbgHZI3n (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Aug 2020 04:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598430582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8pHXm5c/BCgTt3g3HrHPd46sGFF7DeDZTBb/sMkfQk=;
        b=WVxtQR0pdSZqlBTpnFPeCBInJPfKP9iCj8a/j2PdRjGNZgws92Vasb4yEwXHfQ8df+C4Fi
        iqnV/5s1lWQW3l3OylvLwIymnoLIjX1r1q3o0P80zbgXnbEMjrrmpumCPzY7xSgkECuNZk
        7CrloNlndBoFHNAvcffv63hKo42aPEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-yvIC9TpuOu6G06DxW1Xstg-1; Wed, 26 Aug 2020 04:29:38 -0400
X-MC-Unique: yvIC9TpuOu6G06DxW1Xstg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 901BF189E602;
        Wed, 26 Aug 2020 08:29:37 +0000 (UTC)
Received: from carbon (unknown [10.40.208.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 207917D8AF;
        Wed, 26 Aug 2020 08:29:31 +0000 (UTC)
Date:   Wed, 26 Aug 2020 10:29:30 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        ykaliuta@redhat.com, zsun@redhat.com, vkabatov@redhat.com
Subject: Re: [PATCH bpf] selftests/bpf: Fix massive output from test_maps
Message-ID: <20200826102930.51486b11@carbon>
In-Reply-To: <159842985651.1050885.2154399297503372406.stgit@firesoul>
References: <159842985651.1050885.2154399297503372406.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 Aug 2020 10:17:36 +0200
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> When stdout output from the selftests tool 'test_maps' gets redirected
> into e.g file or pipe, then the output lines increase a lot (from 21
> to 33949 lines).  This is caused by the printf that happens before the
> fork() call, and there are user-space buffered printf data that seems
> to be duplicated into the forked process.
> 
> To fix this fflush() stdout before the fork loop in __run_parallel().
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Fixes: 1a97cf1fe503 ("selftests/bpf: speedup test_maps")

I forgot to add the fixes line to the patch, I hope patchwork[1] will
pick it up for maintainers.

[1] http://patchwork.ozlabs.org/project/netdev/patch/159842985651.1050885.2154399297503372406.stgit@firesoul/
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

