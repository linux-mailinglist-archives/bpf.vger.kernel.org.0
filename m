Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B738B294EBA
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443562AbgJUOeU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443556AbgJUOeT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 10:34:19 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F7BC0613CE
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 07:34:19 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u7so1334834vsq.11
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmRKVQeRsF5XXdxrVGzoz/VPiQ1G/DrEd5eWr/793iM=;
        b=IhHKSipK6sX/mITywnB42dvTSeILc1wMT0ISsC1r4OnOF6ON6M5yEkOw+PaQOM9i2I
         WUdUr89l2WpLNCmW8VRTMoCNBFqXMihiNngIpZ+HiVJdr1jFuGVjjCMEOUifu3pRAAbh
         DFfed1lcby+zWbYVttxksMQHFcR6OQcHEFfWxnTHj5CN5tY0a3w1tTWEhofIwP8N5NNT
         7RIMn4q+dDYJ6Y11WLpE/nUXKyHMeAdB/FvPlfGXD8YDmzS0J5PqWmI1B1VvUPiVwS3S
         1+mQPdhK93QDmCExjEHzN4QTkzwgE/mxWhmWXdkrmMQDSFYh3wrBvfsOlQlbZ4Z31hpD
         M3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmRKVQeRsF5XXdxrVGzoz/VPiQ1G/DrEd5eWr/793iM=;
        b=enmyZ9EDAaCqXoVaOjcDXQHP4MMbcjgfCRWJ6yJwvl6w4IZ+m38tm5Vymy0IA3Q9GQ
         QRZOrGaw9+metcmIZXDuh22968JV/2TDGvU2B16O3BKBmNADiNVqlxBWoVACp/zKMqoO
         PvcZRNTcRJnAxyvB3hyHvjk6DaVNt9Q99gli5dizFzR570Lp18V12RLwNlpF8ss0b+A6
         EHR49jxKEBe0ycLk7697EDrMGEh2qLUy6fEs6OWNXDYUtWCaLqnO83K9v7be+a2QZkfv
         QzMkBfD6UxbzRXuq9G4LcGVqLnpV4NGINbt298YYuBCfPMN4Ks0j3OFTqEyAE9YngNAG
         dnCg==
X-Gm-Message-State: AOAM533zv7BQ4VgmYeKAOViaR+oYyl45z1WOj+bH6HD1dzES69OV17jQ
        h4E/pTrNB5Fi97sHDbQGp/1Ju6IBvgk=
X-Google-Smtp-Source: ABdhPJzPXffYJLQ0jvykwXKIVNTJwdx/wB8E0hy58aQhmckBNdNHJh26wOt/f377SBKYChXjlCgfUA==
X-Received: by 2002:a67:fa50:: with SMTP id j16mr1728563vsq.51.1603290857963;
        Wed, 21 Oct 2020 07:34:17 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id d186sm138374vkd.34.2020.10.21.07.34.13
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:34:15 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id b3so1354339vsc.5
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 07:34:13 -0700 (PDT)
X-Received: by 2002:a67:7704:: with SMTP id s4mr2165928vsc.51.1603290853086;
 Wed, 21 Oct 2020 07:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201021142944.13615-1-mst@redhat.com>
In-Reply-To: <20201021142944.13615-1-mst@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 21 Oct 2020 10:33:37 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdG=mPvSWpGLqoQ1YB0duQQvOkkV+KPW3BBTHGStS5_Qg@mail.gmail.com>
Message-ID: <CA+FuTSdG=mPvSWpGLqoQ1YB0duQQvOkkV+KPW3BBTHGStS5_Qg@mail.gmail.com>
Subject: Re: [PATCH v4] Revert "virtio-net: ethtool configurable RXCSUM"
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 21, 2020 at 10:30 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This reverts commit 3618ad2a7c0e78e4258386394d5d5f92a3dbccf8.
>
> When control vq is not negotiated, that commit causes a crash:
>
> [   72.229171] kernel BUG at drivers/net/virtio_net.c:1667!
> [   72.230266] invalid opcode: 0000 [#1] PREEMPT SMP
> [   72.231172] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc8-02934-g3618ad2a7c0e7 #1
> [   72.231172] EIP: virtnet_send_command+0x120/0x140
> [   72.231172] Code: 00 0f 94 c0 8b 7d f0 65 33 3d 14 00 00 00 75 1c 8d 65 f4 5b 5e 5f 5d c3 66 90 be 01 00 00 00 e9 6e ff ff ff 8d b6 00
> +00 00 00 <0f> 0b e8 d9 bb 82 00 eb 17 8d b4 26 00 00 00 00 8d b4 26 00 00 00
> [   72.231172] EAX: 0000000d EBX: f72895c0 ECX: 00000017 EDX: 00000011
> [   72.231172] ESI: f7197800 EDI: ed69bd00 EBP: ed69bcf4 ESP: ed69bc98
> [   72.231172] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [   72.231172] CR0: 80050033 CR2: 00000000 CR3: 02c84000 CR4: 000406f0
> [   72.231172] Call Trace:
> [   72.231172]  ? __virt_addr_valid+0x45/0x60
> [   72.231172]  ? ___cache_free+0x51f/0x760
> [   72.231172]  ? kobject_uevent_env+0xf4/0x560
> [   72.231172]  virtnet_set_guest_offloads+0x4d/0x80
> [   72.231172]  virtnet_set_features+0x85/0x120
> [   72.231172]  ? virtnet_set_guest_offloads+0x80/0x80
> [   72.231172]  __netdev_update_features+0x27a/0x8e0
> [   72.231172]  ? kobject_uevent+0xa/0x20
> [   72.231172]  ? netdev_register_kobject+0x12c/0x160
> [   72.231172]  register_netdevice+0x4fe/0x740
> [   72.231172]  register_netdev+0x1c/0x40
> [   72.231172]  virtnet_probe+0x728/0xb60
> [   72.231172]  ? _raw_spin_unlock+0x1d/0x40
> [   72.231172]  ? virtio_vdpa_get_status+0x1c/0x20
> [   72.231172]  virtio_dev_probe+0x1c6/0x271
> [   72.231172]  really_probe+0x195/0x2e0
> [   72.231172]  driver_probe_device+0x26/0x60
> [   72.231172]  device_driver_attach+0x49/0x60
> [   72.231172]  __driver_attach+0x46/0xc0
> [   72.231172]  ? device_driver_attach+0x60/0x60
> [   72.231172]  bus_add_driver+0x197/0x1c0
> [   72.231172]  driver_register+0x66/0xc0
> [   72.231172]  register_virtio_driver+0x1b/0x40
> [   72.231172]  virtio_net_driver_init+0x61/0x86
> [   72.231172]  ? veth_init+0x14/0x14
> [   72.231172]  do_one_initcall+0x76/0x2e4
> [   72.231172]  ? rdinit_setup+0x2a/0x2a
> [   72.231172]  do_initcalls+0xb2/0xd5
> [   72.231172]  kernel_init_freeable+0x14f/0x179
> [   72.231172]  ? rest_init+0x100/0x100
> [   72.231172]  kernel_init+0xd/0xe0
> [   72.231172]  ret_from_fork+0x1c/0x30
> [   72.231172] Modules linked in:
> [   72.269563] ---[ end trace a6ebc4afea0e6cb1 ]---
>
> The reason is that virtnet_set_features now calls virtnet_set_guest_offloads
> unconditionally, it used to only call it when there is something
> to configure.
>
> If device does not have a control vq, everything breaks.
>
> Revert the original commit for now.
>
> Cc: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Fixes: 3618ad2a7c0e7 ("virtio-net: ethtool configurable RXCSUM")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks Michael.
