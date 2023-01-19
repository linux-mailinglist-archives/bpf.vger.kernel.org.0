Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3873F673606
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 11:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjASKuO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 05:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjASKuC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 05:50:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660254A21C
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 02:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674125352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tgsg+jKubTh3yv7ZSKQzF4Qxnk67C2646FcSbn/LaRg=;
        b=deqVDl3O5RY7y/7dCvc3fa2E684cOn/Nt87fSYJx/NekiQVWj+U4aLziAqFj1Z08EG5nVl
        xOgS+9v72VGFL8Qnogzm4wmONep+Ki2+LjVO9NJXFP1fFdwXMr3+afVrNnZP8zCkmbYTmZ
        XRrXhWF6EJYL1IzQaWqrv4asRytM9bY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500--RWUqug8M-Czj7gNAWo2hw-1; Thu, 19 Jan 2023 05:49:11 -0500
X-MC-Unique: -RWUqug8M-Czj7gNAWo2hw-1
Received: by mail-qt1-f199.google.com with SMTP id f23-20020ac84717000000b003b645f1491aso742377qtp.6
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 02:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tgsg+jKubTh3yv7ZSKQzF4Qxnk67C2646FcSbn/LaRg=;
        b=0lVj5TsgAjPeM4aecx2DAsbYCkWLptdsgyYkzEONLxFICjWhAaOmCi73sLe0AmuLtu
         XQdmdyO4as7n3bP0cT4X13WpqthvksxLjNVb9reuFnLBHFjJKkghb3I/ZZ0iZzIGG3X8
         EQ3o/5OMSqdDMQpUR7rmn54lsbk+J1NCVtl7qSfwrxxc94VWvc4uN+iwcHlob1pB2kHd
         yI0QO5c4rpHgWZA//RvYnNpPjM0D61fCrpPcdFVDT7abtmEgceJNZ3DnpECzsRw0S1nD
         IENEiHmiUsJwcPc9VZZxPr4tKFmgwuaL5KcsoJ92N8/uWnVPmPbyJ920X9AbkHh8H0Xl
         Yc+w==
X-Gm-Message-State: AFqh2kqsLM4zdHV9kqK2fhVhSr/sQ7korRw/qySwLH5ToZ82KY9TiSE9
        LdnDVAro5bUR1LKPILQH3thPMrLwYWGR+AfFGZy+NRP33YWnxge9jAHO1B1mDfDbSIrYfXSTCGU
        iz3OQK6D8ykQd
X-Received: by 2002:a05:622a:1e09:b0:3a7:f424:3ef9 with SMTP id br9-20020a05622a1e0900b003a7f4243ef9mr15448763qtb.13.1674125350349;
        Thu, 19 Jan 2023 02:49:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsJI/f+MaH+UXrw024umAES6RkR56bZGB0+a4DzacCjXf+fQdTonSXjzep3SUU/ku7BhybcWw==
X-Received: by 2002:a05:622a:1e09:b0:3a7:f424:3ef9 with SMTP id br9-20020a05622a1e0900b003a7f4243ef9mr15448743qtb.13.1674125350057;
        Thu, 19 Jan 2023 02:49:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-245.retail.telecomitalia.it. [82.57.51.245])
        by smtp.gmail.com with ESMTPSA id q3-20020ac87343000000b003b6464eda40sm2568175qtp.25.2023.01.19.02.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:49:09 -0800 (PST)
Date:   Thu, 19 Jan 2023 11:49:02 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH RFC 0/3] vsock: add support for sockmap
Message-ID: <20230119104902.jxst4eblcuyjvums@sgarzare-redhat>
References: <20230118-support-vsock-sockmap-connectible-v1-0-d47e6294827b@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230118-support-vsock-sockmap-connectible-v1-0-d47e6294827b@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Bobby,

On Wed, Jan 18, 2023 at 12:27:39PM -0800, Bobby Eshleman wrote:
>Add support for sockmap to vsock.
>
>We're testing usage of vsock as a way to redirect guest-local UDS requests to
>the host and this patch series greatly improves the performance of such a
>setup.
>
>Compared to copying packets via userspace, this improves throughput by 221% in
>basic testing.

Cool, nice series!

>
>Tested as follows.
>
>Setup: guest unix dgram sender -> guest vsock redirector -> host vsock server
>Threads: 1
>Payload: 64k
>No sockmap:
>- 76.3 MB/s
>- The guest vsock redirector was
>  "socat VSOCK-CONNECT:2:1234 UNIX-RECV:/path/to/sock"
>Using sockmap (this patch):
>- 168.8 MB/s (+221%)

Assuming the absolute value is correct, there is a typo here, it would 
be +121% right?

>- The guest redirector was a simple sockmap echo server,
>  redirecting unix ingress to vsock 2:1234 egress.
>- Same sender and server programs
>
>Only the virtio transport has been tested.

I think is fine for now.

>The loopback transport was used in
>writing bpf/selftests, but not thoroughly tested otherwise.

I did a quick review mainly for vsock stuff.
Hoping others can take a better look at net/vmw_vsock/vsock_bpf.c, since 
I'm not very familiar with that subsystem.

FYI I will be off the next two weeks (till Feb 7) with limited internet 
access.

Thanks,
Stefano

>
>This series requires the skb patch.
>
>To: Stefan Hajnoczi <stefanha@redhat.com>
>To: Stefano Garzarella <sgarzare@redhat.com>
>To: "Michael S. Tsirkin" <mst@redhat.com>
>To: Jason Wang <jasowang@redhat.com>
>To: "David S. Miller" <davem@davemloft.net>
>To: Eric Dumazet <edumazet@google.com>
>To: Jakub Kicinski <kuba@kernel.org>
>To: Paolo Abeni <pabeni@redhat.com>
>To: Andrii Nakryiko <andrii@kernel.org>
>To: Mykola Lysenko <mykolal@fb.com>
>To: Alexei Starovoitov <ast@kernel.org>
>To: Daniel Borkmann <daniel@iogearbox.net>
>To: Martin KaFai Lau <martin.lau@linux.dev>
>To: Song Liu <song@kernel.org>
>To: Yonghong Song <yhs@fb.com>
>To: John Fastabend <john.fastabend@gmail.com>
>To: KP Singh <kpsingh@kernel.org>
>To: Stanislav Fomichev <sdf@google.com>
>To: Hao Luo <haoluo@google.com>
>To: Jiri Olsa <jolsa@kernel.org>
>To: Shuah Khan <shuah@kernel.org>
>Cc: linux-kernel@vger.kernel.org
>Cc: kvm@vger.kernel.org
>Cc: virtualization@lists.linux-foundation.org
>Cc: netdev@vger.kernel.org
>Cc: bpf@vger.kernel.org
>Cc: linux-kselftest@vger.kernel.org
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>---
>Bobby Eshleman (3):
>      vsock: support sockmap
>      selftests/bpf: add vsock to vmtest.sh
>      selftests/bpf: Add a test case for vsock sockmap
>
> drivers/vhost/vsock.c                              |   1 +
> include/linux/virtio_vsock.h                       |   1 +
> include/net/af_vsock.h                             |  17 ++
> net/vmw_vsock/Makefile                             |   1 +
> net/vmw_vsock/af_vsock.c                           |  59 ++++++-
> net/vmw_vsock/virtio_transport.c                   |   2 +
> net/vmw_vsock/virtio_transport_common.c            |  22 +++
> net/vmw_vsock/vsock_bpf.c                          | 180 +++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c                     |   2 +
> tools/testing/selftests/bpf/config.x86_64          |   4 +
> .../selftests/bpf/prog_tests/sockmap_listen.c      | 163 +++++++++++++++++++
> tools/testing/selftests/bpf/vmtest.sh              |   1 +
> 12 files changed, 447 insertions(+), 6 deletions(-)
>---
>base-commit: f12f4326c6a75a74e908714be6d2f0e2f0fd0d76
>change-id: 20230118-support-vsock-sockmap-connectible-2e1297d2111a
>
>Best regards,
>-- 
>Bobby Eshleman <bobby.eshleman@bytedance.com>
>

