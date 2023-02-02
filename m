Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA768731D
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBBBmO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBBBmN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:42:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE327750D
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:42:12 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so384191pjb.3
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 17:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEUWQcIFypFvmGsLhrzIc9UQlWdveTNsYAoWJAcmc5w=;
        b=OVEoY+w14AwJwy7MDVvhpOaiUp7boXvCyKlJVjk881mNKpBAiwWPsBES/NckQ5Fues
         +bh4aOWMhfNZGQmEVuatZCYkWLDx8py/TR68p7kWe0EvJ/OSaHQtnBp6ikJpr87dq+lt
         3N6+A2IKg0D/8BbA6/sp2+T0KIhuIYKmi8F5Sjuaps+Bh15HkcVlReyPTAC5vaNMTwoU
         DSHNnQj/zPp1mBk3oPcHbJWiJK2/WOkEXR1J9rTMD3wSWOnviuOhhYeQIXwDPWPs8oT1
         aWPYaGidf2GzP1YQ/Uszkei08wNN59qrR7x4ruhLfMztngpHwO6GEdPXk/Zv05lKcpwN
         niMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEUWQcIFypFvmGsLhrzIc9UQlWdveTNsYAoWJAcmc5w=;
        b=G005SWAq541Fh1SXNqdTscmh8X6KM4iwCDiU12DtZhl51Ed8Qo/0br3o8f7KlYEGS4
         diySt+mhL057dvOQ80N0Oi13PwYJpA6kv+13UTQzdqD28ZRrPAtdcsv+NuAigicNja2n
         o1X8/kXesyK1DJ/53x7MVuppFncyhD1wGAqDrgfSMi1sgnBqWyAViVaIYn//cic8a8st
         s0O5p97Sy1LAU31/oXNk+9rxqRviP2xFy+sCueUzjWwdkyKGpGww53XGoXLgeEzT99Bv
         OpHf5gyK3jHpJNnHRulI6ydrWC27+OPQai5UUOnPA5JKe2z/sICphT1eItPsU+sCCJ78
         ihPA==
X-Gm-Message-State: AO0yUKU0anWCQQpgflwZmNFpI0/svEUBqBcoahZS67us419dT5nnh5A/
        jGAiJXuC9pFn+GpuQj5we5w=
X-Google-Smtp-Source: AK7set/8Jbr0DB4NDuS1o52qIhfr6sS9+aXXJdodhq6t7Qxd+CRa+PxZk46WOrJfj8EX23AbWFi/sg==
X-Received: by 2002:a05:6a20:d906:b0:bc:f45f:ecf7 with SMTP id jd6-20020a056a20d90600b000bcf45fecf7mr4748352pzb.2.1675302132057;
        Wed, 01 Feb 2023 17:42:12 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:3f48:5400:4ff:fe4a:8c8b])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm6594205pgd.76.2023.02.01.17.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:42:11 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/7] bpf, mm: bpf memory usage 
Date:   Thu,  2 Feb 2023 01:41:51 +0000
Message-Id: <20230202014158.19616-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently we can't get bpf memory usage reliably. bpftool now shows the
bpf memory footprint, which is difference with bpf memory usage. The
difference can be quite great between the footprint showed in bpftool
and the memory actually allocated by bpf in some cases, for example,

- non-preallocated bpf map
  The non-preallocated bpf map memory usage is dynamically changed. The
  allocated elements count can be from 0 to the max entries. But the
  memory footprint in bpftool only shows a fixed number.
- bpf metadata consumes more memory than bpf element 
  In some corner cases, the bpf metadata can consumes a lot more memory
  than bpf element consumes. For example, it can happen when the element
  size is quite small.

We need a way to get the bpf memory usage especially there will be more
and more bpf programs running on the production environment and thus the
bpf memory usage is not trivial.

This patchset introduces a new map ops ->map_mem_usage to get the memory
usage. In this ops, the memory usage is got from the pointers which is
already allocated by a bpf map. To make the code simple, we igore some
small pointers as their size are quite small compared with the total
usage.

In order to get the memory size from the pointers, some generic mm helpers
are introduced firstly, for example, percpu_size(), vsize() and kvsize(). 

This patchset only implements the bpf memory usage for hashtab. I will
extend it to other maps and bpf progs (bpf progs can dynamically allocate
memory via bpf_obj_new()) in the future.

The detailed result can be found in patch #7.

Patch #1~#4: Generic mm helpers
Patch #5   : Introduce new ops
Patch #6   : Helpers for bpf_mem_alloc
Patch #7   : hashtab memory usage

Future works:
- extend it to other maps
- extend it to bpf prog
- per-container bpf memory usage 

Historical discussions,
- RFC PATCH v1 mm, bpf: Add BPF into /proc/meminfo
  https://lwn.net/Articles/917647/  
- RFC PATCH v2 mm, bpf: Add BPF into /proc/meminfo
  https://lwn.net/Articles/919848/

Yafang Shao (7):
  mm: percpu: fix incorrect size in pcpu_obj_full_size()
  mm: percpu: introduce percpu_size()
  mm: vmalloc: introduce vsize()
  mm: util: introduce kvsize()
  bpf: add new map ops ->map_mem_usage
  bpf: introduce bpf_mem_alloc_size()
  bpf: hashtab memory usage

 include/linux/bpf.h           |  2 ++
 include/linux/bpf_mem_alloc.h |  2 ++
 include/linux/percpu.h        |  1 +
 include/linux/slab.h          |  1 +
 include/linux/vmalloc.h       |  1 +
 kernel/bpf/hashtab.c          | 80 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/memalloc.c         | 70 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c          | 18 ++++++----
 mm/percpu-internal.h          |  4 ++-
 mm/percpu.c                   | 35 +++++++++++++++++++
 mm/util.c                     | 15 ++++++++
 mm/vmalloc.c                  | 17 +++++++++
 12 files changed, 237 insertions(+), 9 deletions(-)

-- 
1.8.3.1

