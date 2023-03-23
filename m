Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8C86C70CA
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 20:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjCWTKQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCWTKF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 15:10:05 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF812C642
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 12:09:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p203so26050865ybb.13
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679598585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLtQVw9Q3r/EIfGHaHQqJXqtgGhueRqlggc/xqxY+5U=;
        b=iWmN5qdQNSjpgISH3j2kib5cc+h8AoBaK9c2AaVVVURUW5rI9o8n06FvmV1M+bBFfX
         YNubq65NBM6w9TNZeohFGxGQHBSYpmJ2MVCGqXlkjI0pG66JFFF6zyIvXaCtVFAsMNFh
         hXEcIALahsRpm5ULADGvB6dWEK8Cco4UeMk/PeV198/yaHKWNMbjOkpRw/jOeaVEUa88
         WYew6Gts30zeIuE6WLRNasfDpPaC4wq9Q+TgniIJZLVp7q+T9A9NqwNBf4mhube6dHtB
         lKvNpdpZCmdXI0XAsx+tbsEVIpm8bgaFMld59t1NK22AG0oMOtTQgmguJ9Zy1dAlKVSJ
         vknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679598585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLtQVw9Q3r/EIfGHaHQqJXqtgGhueRqlggc/xqxY+5U=;
        b=frT6fqME1+We0mkoBrv6jNnFVJZtocs5QyC9PEnGpbtIyzrd6c+6CNOPtXjfWuxJz+
         FAXk7pPKAHtu/AXZESeZxeel8nFF0mjMt0MlBpXGXku1fQV25G01HWwxIgxbMzssSGDw
         Bd1RVsvZ/JwDoRKawAw8BEaLsC+VIdkSzs+72+xvDbeb7ttDm9sMrbijA+HkvrK3dpib
         vWGGQERtlAtm6i9Ev2juiv8girJO/tVTXTUH80/JrKG+la78cKeeZv8t1A+VyUsqbFss
         EyHe6IX5ISCv6Hp1o4FvSN6dzTth6kVse6x0t+u8fG3ySvA0p11ecp0TPsWXudWgC5Zt
         dx6g==
X-Gm-Message-State: AAQBX9euKuhtrNJQbF4jvkcbuFrnHGjloQ7Cjxp/h24qI6cY9a7VVnMh
        o13t9q6aGMGXp0ogofy3hCxkCLWfCMGpQLWVGMeSfg==
X-Google-Smtp-Source: AKy350akUM/9iIf8a3thcZVFCFca2DEXgqBqR2kjsnCDm5WKBJDwjnFCzpyD3JyTXxOLuZxXO5ARoUIWjEn4MKy8lr8=
X-Received: by 2002:a25:a28f:0:b0:a99:de9d:d504 with SMTP id
 c15-20020a25a28f000000b00a99de9dd504mr2809088ybi.12.1679598584842; Thu, 23
 Mar 2023 12:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
 <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
 <CALvZod5GT=bZsLXsG500pNkEJpMB1o2KJau4=r0eHB-c8US53A@mail.gmail.com>
 <CAJD7tkY6Wf2OWja+f-JeFM5DdMCyLzbXxZ8KF0MjcYOKri-vtA@mail.gmail.com>
 <CALvZod5mJBAQ5adym7UNEruL-tOOOi+Y_ZiKsfOYqXPmGVPUEA@mail.gmail.com>
 <CAJD7tkYWo_aB7a4SHXNQDHwcaTELonOk_Vd8q0=x8vwGy2VkYg@mail.gmail.com>
 <CALvZod7f9Rejb_WrZ+Ajegz-NsQ7iPQegRDMdk5Ya0a0w=40kg@mail.gmail.com>
 <CALvZod7-6F84POkNetA2XJB-24wms=5q_s495NEthO8b63rL4A@mail.gmail.com>
 <CAJD7tkbGCgk9VkGdec0=AdHErds4XQs1LzJMhqVryXdjY5PVAg@mail.gmail.com>
 <CALvZod7saq910u4JxnuY4C7EwiK5vgNF=-Bv+236RprUOQdkjw@mail.gmail.com>
 <CAJD7tkb8oHoK5RW96tEXjY9iyJpMXfGAvnFw1rG-5Sr+Mpubdg@mail.gmail.com>
 <CALvZod5USCtNtnPuYRbRv_psBCNytQWWQ592TFsJLfrLpyLJmw@mail.gmail.com> <CAJD7tkad5NbqjXZ1qLaNx1g-FYsrv-BVLcNinycFStG_Bu0_zw@mail.gmail.com>
In-Reply-To: <CAJD7tkad5NbqjXZ1qLaNx1g-FYsrv-BVLcNinycFStG_Bu0_zw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 Mar 2023 12:09:33 -0700
Message-ID: <CALvZod4n+_zo7fkn=NfRSKeShHbarUPWL3D=uScZmg9aiKkP-w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 23, 2023 at 9:52=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
>
> Sure, I can do that in the next version. I will include a patch that
> adds an in_task() check to mem_cgroup_usage() before this one. Since
> BUG_ON() is discouraged and VM_BUG_ON() is mm specific, I guess we are
> left with WARN_ON_ONCE() for the rstat core code, right?
>
> Thanks Shakeel. Any other thoughts I should address for the next version?

This is all for now (at least for this patch).
