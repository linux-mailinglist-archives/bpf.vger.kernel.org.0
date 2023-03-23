Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D243A6C666B
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 12:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCWLUQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 07:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCWLUP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 07:20:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5581C420E
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 04:20:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w9so84913086edc.3
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679570413;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz4AK/13/8ZJIP9HjSHztDp0bLQ6grKDoEelg0z8QUo=;
        b=OeUuijq4iX1ovc96Ebf+Ond6zOQNWiTqaQmqAY9VvS77AsJ1SwLe5sn+yws0RrZLSo
         74OtJqb9CRLtfV9eifuPQzrePvrrOBsm6ZOPjelhnXp6BDpnWHUsm5Z2dw65fpjqELwW
         U9WGFDZNFYe3aBUs9/HAMzK0Oa26d8AkPNTPfEPaMw8Dmp8apEe4huNGxCDtD/vpGQNZ
         hyPoF3UWo86dieX/YQhlz7x56+BBcT15FhnjNcZv1XXJWCFQQ7UkbTkIVfk7Sa9vEizw
         c2L6a4pfUbRa8EPod9n/JZFEVEld51vfVS2JcowZ1sAwtSC97SAP+xWY7D2ng2kLMm20
         Me8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679570413;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gz4AK/13/8ZJIP9HjSHztDp0bLQ6grKDoEelg0z8QUo=;
        b=HcTGbD/VIFZ5WCs1haRx/HZS0F+AWt11iKDGClkd1v2cJ8+IwuLjZ1a0ux+E9eSM/M
         BmQJSRDle83Q7GSkw/USZOZySFzm+HHSj7UXwq60xDJ8HxpEP9yXTaYTGW8+anNzxN22
         wtuhhh0mLSd9hLEl8iazemBQI/dV9XC2fJ8GVp3RbBH2o30pg7nUwvYsB+5n6jGSKTRW
         kgELkRrk6DFg+4su6osrh85FwgRok8o3RRkzKPUL34+/D9F0OmxR5tqIYMGw7dQcgj0u
         KB7hhqQnWuLV3UB/xaNBT21xLf3tBHn8qIzO5UaxGnSgMwBkWMZnWNtH6ccjXVBemmHd
         AjZA==
X-Gm-Message-State: AO0yUKXnfl0rEhbblNxyS3VhNKEA5SwEdoF0t8auU25EkiQ4ilHYmsoe
        noLYMmKw70l6Tty1OmZKqMY=
X-Google-Smtp-Source: AK7set+ep1fSC9asM5YXzb9pSzeYYD7SEZx//pT9jaUGbBJFm3vOwkQm44TpZEJHS6wjnijAZQ7HJQ==
X-Received: by 2002:a05:6402:54b:b0:4fb:6357:f393 with SMTP id i11-20020a056402054b00b004fb6357f393mr10338717edx.1.1679570412594;
        Thu, 23 Mar 2023 04:20:12 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k19-20020a508ad3000000b00501c0eaf10csm6108579edk.40.2023.03.23.04.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 04:20:12 -0700 (PDT)
Message-ID: <e184fc97a5afcf05c7c627b79163060c86f59f90.camel@gmail.com>
Subject: Re: How to avoid race conditions in older kernel where spinlock is
 unavailable
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     =?UTF-8?Q?=E5=88=98=E7=95=85?= <fluency0726@gmail.com>,
        bpf@vger.kernel.org
Date:   Thu, 23 Mar 2023 13:20:11 +0200
In-Reply-To: <CA+hefuS341OjUuWnxwVXj6QPMLcJLxvr+OREb_nEYrnt5kuBsQ@mail.gmail.com>
References: <CA+hefuS341OjUuWnxwVXj6QPMLcJLxvr+OREb_nEYrnt5kuBsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-03-23 at 14:53 +0800, =E5=88=98=E7=95=85 wrote:
> Hi all
>=20
> I'm developing an ebpf program to capture all descendant processes of
> a specific process (e.g., a shell process), so I use kretprobe to
> monitor the return of _do_fork() function in kernel. I maintained a
> pid_map (BPF_MAP_TYPE_ARRAY) to store the PIDs of the descendant
> processes and a ptr_map  (BPF_MAP_TYPE_ARRAY with only 1 element) as a
> pointer which points to the first empty element in the pid_map.
> Everytime the ebpf program is triggered, it will traverse all PIDs
> stored in the pid_map to see whether the current process is a
> descendant of the initial process, if so, the PID of the newly created
> process will be added to the pid_map and the ptr_map is also updated.
> Then I realized there are data races, because on an SMP system, ebpf
> programs that run on different CPU cores may access the ptr_map
> simultaneously. To solve this problem, I searched related docs and
> found that spinlock is available in the newest kernel. However, I'm
> working on 4.19 kernel which doesn't support spinlock, I wonder if
> there is any synchronization mechanism that I can use to solve this
> race condition. I'd be appreciate if anyone can help me :)

Hi Chang,

If all you need is to bump a counter you can probably use
__sync_fetch_and_add() intrinsic.
Looking trough BPF samples I see it used in the code from 2015,
e.g. in samples/bpf/sockex3_kern.c.
However, I'm not sure why not simply inspect `struct task_struct::parent` f=
ield?

Thanks,
Eduard

>=20
> Thank you!
>=20
> Chang Liu

