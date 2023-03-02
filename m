Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04B6A7EF0
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 10:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCBJy5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 04:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCBJyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 04:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05815CAC
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 01:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677750838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jAanRdQ6lew74x0O2AW3iUiZVFolX1emAfL8FQaMI/4=;
        b=gzdALdWRMqb33PVvMB16FhKgqS4hEYbt8grKWAckL6CvyLN6dpP6UYdSCIaxhIJ+nlzrF1
        xOY65khD392eWjv2syXp32y83CKeH2NgJuLN1LquoXNXmYvcvKMCenM172bo6dtywgvacF
        uCYCO6rWYNHFckmr0E1jVmOtjTGx9XY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-0QVVeEXiPzqMhql61sAzBA-1; Thu, 02 Mar 2023 04:53:57 -0500
X-MC-Unique: 0QVVeEXiPzqMhql61sAzBA-1
Received: by mail-qv1-f71.google.com with SMTP id pv11-20020ad4548b000000b0056e96f4fd64so8585638qvb.15
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 01:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAanRdQ6lew74x0O2AW3iUiZVFolX1emAfL8FQaMI/4=;
        b=NW8CVl12IKo22+l+XggZ2Um4klxW2P3gOUKIw+DLKGdnB2iH/0bvRardibfSJKT8mM
         drTjXxpkoH3HFVLgCkTM0BzgKHV9S96wvkhfKmKZ3em28bQd2BJfEz9ICH4e1lcPAwLH
         k0NblIjevTGwyykSvuYj7YgaG683X4LlXqpwSdhsITsh8rBhq6fX4Nl1a7ajT7nH3fVq
         KIRVGNl2aU7fYosbssmEnVyxU/rpUl4yB4/rMujk3dc9CWC2SKF8Nbz6rI2STtGh/Iwp
         JU2qsJiNGtSsntQTgJspnwyyNqHirU91ejJLb8wbi6lrotqNym2YNibep6eml6uIsKtQ
         ZlTQ==
X-Gm-Message-State: AO0yUKVyV5xisPZMmkCggkr9Rqtah3AQV0tQ8qDsOo4QDkJWwuiYkxpy
        k6SZkkKxYPL8PcTySf8k5IOKt4QU+81Hvk7Phhphk3qk3poyN8QBrTzZvgtJaLfRyDt3uxHvcyA
        zbo3QuSjTgTCK
X-Received: by 2002:ac8:7c4e:0:b0:3bf:c431:ea6e with SMTP id o14-20020ac87c4e000000b003bfc431ea6emr16382395qtv.3.1677750837183;
        Thu, 02 Mar 2023 01:53:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+D27uSWXYnYHncolI/Nj6QVQLpZyQycFGgRCQpd47EnoDoYamAUXMK1mc3+TkNw/RjY6KEew==
X-Received: by 2002:ac8:7c4e:0:b0:3bf:c431:ea6e with SMTP id o14-20020ac87c4e000000b003bfc431ea6emr16382365qtv.3.1677750836940;
        Thu, 02 Mar 2023 01:53:56 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
        by smtp.gmail.com with ESMTPSA id x7-20020ac87007000000b003c00573aaffsm676414qtm.3.2023.03.02.01.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:53:56 -0800 (PST)
Date:   Thu, 2 Mar 2023 10:53:46 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net-next v3 2/3] selftests/bpf: add vsock to vmtest.sh
Message-ID: <20230302095346.rbu6s3os4kz2bnbr@sgarzare-redhat>
References: <20230227-vsock-sockmap-upstream-v3-0-7e7f4ce623ee@bytedance.com>
 <20230227-vsock-sockmap-upstream-v3-2-7e7f4ce623ee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230227-vsock-sockmap-upstream-v3-2-7e7f4ce623ee@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 07:04:35PM +0000, Bobby Eshleman wrote:
>Add vsock loopback to the test kernel.
>
>This allows sockmap for vsock to be tested.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> tools/testing/selftests/bpf/config.aarch64 | 2 ++
> tools/testing/selftests/bpf/config.s390x   | 3 +++
> tools/testing/selftests/bpf/config.x86_64  | 3 +++
> 3 files changed, 8 insertions(+)

I already acked this in the v2, please bring them between versions if 
there are no changes.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

