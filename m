Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45203550BED
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiFSPup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFSPuo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:50:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40495BC94
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c205so1487910pfc.7
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhdaJmZLa4lgn0vywCQI5gQdzVYdyrnEzxNVG21VKeE=;
        b=LmsDr227lZ2D8Vs3vBOAaTIHp2Dn8RCvzoyFeLXh4aFHgLPVfXm7oMygok1pAUnkwR
         HFyJoSmU/ttiuhM8Px7e3LsXQA1OsT3beaiqVqZL4kPhp6mf+P07O5Fq+BeghRuek/1L
         fImHmGMi1LCshDjSTdC7absqS5/PKu0rccTeW4/4Xy1wB5TuxVGnOKPRVP0CynswbDvU
         oy4PAON0zHiXvElvBezy3hJlsojPkY93SgzxCySujvbeyv02OsHpG7letyIu9rM4G6QF
         4buL1QQ/6yXdvUD11j+UVD/5mBDBuj02GFzTlgwuYM3/dKKR1FrL8o3yXUS23gBcsKfn
         zcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhdaJmZLa4lgn0vywCQI5gQdzVYdyrnEzxNVG21VKeE=;
        b=rAxcM0a3VC/4lXEBrpxefgD+DgGHqU920J8WGPemYF1zByUNzRWEg5wjW9pgkUzGz3
         8oO9o3eSNyZBm6cSks+aDpcxsNI8Kawq5gPj2wAB0qVi+WkgtrgtS5S8K0QR2k9/ncZK
         moqS485wPhXxu8wuQltpGsWUhwdbT72rdLkCWiBM3fx7lpQW1AQT79nP3M/2pKNEvkQT
         fSg6lcqogl7Zv0R4WmE/oqV3YyIVwU2hKeUd9fXGzx9V4gEUnzOI4bRMXPHZRZ0g6Xd0
         fwuyGwYPdq8HUFMKmSXo3GBzUkgBHURrtb3f7qC7b5GLy/WJbWlz8rkTZGnzWWDCAUfg
         EiJA==
X-Gm-Message-State: AJIora/bpBw0+dinbCFLXZveITG54WSFUpAZLgV9iGN5Ncn4Ft+TfqBC
        1ahwKRRA9ZABVFd76uC19KQ=
X-Google-Smtp-Source: AGRyM1tx4Q4QjDwW+wVu6B4Vc2cBVjRf26HbWz0WoxKexcw52/rxTjw1238jYtKU8fRsHjIdL5fzlQ==
X-Received: by 2002:a05:6a00:1941:b0:50d:807d:530b with SMTP id s1-20020a056a00194100b0050d807d530bmr20146343pfk.17.1655653842609;
        Sun, 19 Jun 2022 08:50:42 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:50:41 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 00/10] bpf, mm: Recharge pages when reuse bpf map 
Date:   Sun, 19 Jun 2022 15:50:22 +0000
Message-Id: <20220619155032.32515-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After switching to memcg-based bpf memory accounting, the bpf memory is
charged to the loader's memcg by default, that causes unexpected issues for
us. For instance, the container of the loader may be restarted after
pinning progs and maps, but the bpf memcg will be left and pinned on the
system. Once the loader's new generation container is started, the leftover
pages won't be charged to it. That inconsistent behavior will make trouble
for the memory resource management for this container.

In the past few days, I have proposed two patchsets[1][2] to try to resolve
this issue, but in both of these two proposals the user code has to be
changed to adapt to it, that is a pain for us. This patchset relieves the
pain by triggering the recharge in libbpf. It also addresses Roman's
critical comments.

The key point we can avoid changing the user code is that there's a resue
path in libbpf. Once the bpf container is restarted again, it will try
to re-run the required bpf programs, if the bpf programs are the same with
the already pinned one, it will reuse them.

To make sure we either recharge all of them successfully or don't recharge
any of them. The recharge prograss is divided into three steps:
  - Pre charge to the new generation 
    To make sure once we uncharge from the old generation, we can always
    charge to the new generation succeesfully. If we can't pre charge to
    the new generation, we won't allow it to be uncharged from the old
    generation.
  - Uncharge from the old generation
    After pre charge to the new generation, we can uncharge from the old
    generation.
  - Post charge to the new generation
    Finnaly we can set pages' memcg_data to the new generation. 
In the pre charge step, we may succeed to charge some addresses, but fail
to charge a new address, then we should uncharge the already charged
addresses, so another recharge-err step is instroduced.
 
This pachset has finished recharging bpf hash map. which is mostly used
by our bpf services. The other maps hasn't been implemented yet. The bpf
progs hasn't been implemented neither.

The prev generation and the new generation may have the same parant,
that can be optimized in the future.

In the disccussion with Roman in the previous two proposals, he also
mentioned that the leftover page caches have similar issue.  There're key
differences between leftover page caches and leftover bpf programs:
  - The leftover page caches may not be reused again
    Because once a container exited, it may be deployed on another host
    next time for better resource management. That's why we fix leftover
    page caches by _trying_ to drop all its page caches when it is exiting.
    But regarding the bpf conatainer, it will always be deployed on the
    same host next time, that's why bpf programs are pinned.
 - The lefeover page caches can be reclaimed, but bpf memory can't.
   It means the leftover page caches can be accepted while the leftover bpf
   memory can't.
Regardless of these differences, we can also extend this method to
recharge leftover page caches if we need it, for example when we 'reuse' a
leftover inode, we recharge all its page caches to the new generation. But
unforunately there's no such a clear reuse path in page cache layer, so we
must build a resue path for it first:

      page cache's reuse path(X)           bpf's reuse path 
          |                                    |
   ------------------                   -------------
   | page cache layer|                  | bpf layer |
   ------------------                   -------------
      \                                     /
    page cache's recharge handler(X)     bpf's recharge handler
       \                                   /
       ------------------------------------
       |        Memcg layer               |
       |----------------------------------|

[1] https://lwn.net/Articles/887180/
[2] https://lwn.net/Articles/888549/


Yafang Shao (10):
  mm, memcg: Add a new helper memcg_should_recharge()
  bpftool: Show memcg info of bpf map
  mm, memcg: Add new helper obj_cgroup_from_current()
  mm, memcg: Make obj_cgroup_{charge, uncharge}_pages public
  mm: Add helper to recharge kmalloc'ed address
  mm: Add helper to recharge vmalloc'ed address
  mm: Add helper to recharge percpu address
  bpf: Recharge memory when reuse bpf map
  bpf: Make bpf_map_{save, release}_memcg public
  bpf: Support recharge for hash map

 include/linux/bpf.h            |  23 ++++++
 include/linux/memcontrol.h     |  22 ++++++
 include/linux/percpu.h         |   1 +
 include/linux/slab.h           |  18 +++++
 include/linux/vmalloc.h        |   2 +
 include/uapi/linux/bpf.h       |   4 +-
 kernel/bpf/hashtab.c           |  74 +++++++++++++++++++
 kernel/bpf/syscall.c           |  40 ++++++-----
 mm/memcontrol.c                |  35 +++++++--
 mm/percpu.c                    |  98 ++++++++++++++++++++++++++
 mm/slab.c                      |  85 ++++++++++++++++++++++
 mm/slob.c                      |   7 ++
 mm/slub.c                      | 125 +++++++++++++++++++++++++++++++++
 mm/util.c                      |   9 +++
 mm/vmalloc.c                   |  87 +++++++++++++++++++++++
 tools/bpf/bpftool/map.c        |   2 +
 tools/include/uapi/linux/bpf.h |   4 +-
 tools/lib/bpf/libbpf.c         |   2 +-
 18 files changed, 609 insertions(+), 29 deletions(-)

-- 
2.17.1

