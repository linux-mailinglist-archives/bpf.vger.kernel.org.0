Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE7A61A704
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 03:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKECwa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 22:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKECw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 22:52:28 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F213F06C
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 19:52:27 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id mi9so4639329qvb.8
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 19:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCxoN6ChgDmmemcuz37gCvFaemxJyQ9HSvlBAAP7JaU=;
        b=Knez7Hwb0qj9NP8+cMkRu09v3XcaTT/OuAB32+CgReZn9N6VuUDh5A7MQnYd0QYlyq
         sp4nR+UWrN9ZQ0UnOb3uUhABMcgDHku50dFtVXLS1fR4Jjb2FGobmqsSemV7tRIuPSuj
         LLgId/2ET+lNwnPjlilXkO7Mrv7qA5OTmHnKncWQVSFWga2m8tbk9TYvkTGIuSxV0Lcq
         zBxUO4Tt4d8Rszj/H5ZncVG3mq/tBwI3LAk6IpTvI65p6RqE0ZVYAkom/OJV7UKDqaW6
         zYvWy+t8C4d7k5nyj6w59YMItGnaC44wAgREV+33Cr4oukyfobzKYvSlMx8CQJNGmrm3
         IY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCxoN6ChgDmmemcuz37gCvFaemxJyQ9HSvlBAAP7JaU=;
        b=ChVQJcK1OlnYS6sGtbgFc29oHqkdI2LDI7TffoOOTMv469uws9HV1Zu1nPxRKkNRQv
         gaGBKSGJxPsPdz9bWQ+47sYOAWpR7qSfr/Q6FMK+P42myLS5vztjXrzKM1R1CN0k15TL
         l2CbzUv4fd6+OonP4rZJrIMn2kEahP2QeyoOW9QZjFFQLaLbkF1Fy/VuFCRod2tMMVd6
         qwlJbQLieOFxR+9LubNB1ZiTl9WqXwGqngM3xpsozxdFvBsuZPu/oBqXuOAT54cJsk1s
         0jn5/zM83i8Jv2tuRzGh8qNke4IGTNFKlVpxreSfBgrz9I5qLbk3sJVFAw0frTPeldw/
         Gbpg==
X-Gm-Message-State: ACrzQf2v7JO5XYcDNepF/aVvJ5jcWzWvOHiObnIUTJfcc0j22p8hwjNu
        wvHe7bMMP39bgtizlf5kqTZTaw==
X-Google-Smtp-Source: AMsMyM4ctHoEVWbAHu4jYCHa+grjBWnoHI2F2RZoHtqG5w/u5hIltFKx/Hp46ujqIz/N2RnPzMf73w==
X-Received: by 2002:a0c:e2d4:0:b0:4bb:5902:922c with SMTP id t20-20020a0ce2d4000000b004bb5902922cmr34764425qvl.57.1667616746264;
        Fri, 04 Nov 2022 19:52:26 -0700 (PDT)
Received: from 192-168-53-12.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05620a178e00b006bb366779a4sm805905qkb.6.2022.11.04.19.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 19:52:25 -0700 (PDT)
From:   "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Hao Xiang <hao.xiang@bytedance.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Xiaoning Ding <xiaoning.ding@bytedance.com>,
        bpf@vger.kernel.org
Cc:     Ho-Ren Chuang <horenc@vt.edu>,
        Ho-Ren Chuang <horenchuang@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH bpf-next v1 0/4] Add BPF htab map's used size for monitoring
Date:   Sat,  5 Nov 2022 02:51:42 +0000
Message-Id: <20221105025146.238209-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,

We have prepared patches to address an issue from a previous discussion.
The previous discussion email thread is here: https://lore.kernel.org/all/CAADnVQLBt0snxv4bKwg1WKQ9wDFbaDCtZ03v1-LjOTYtsKPckQ@mail.gmail.com/

This patch series adds a new field "used_entries" to struct bpf_map_info
and keeps tracking the "count" field in bpf_htab in both the preallocated
and non-preallocated cases.

bpftool is modified to report the newly added "used_entries" field in
struct bpf_map_info and to mark pre-allocated htab maps with "*".
These make it easier to view the current memory situation of a hashmap.

We have added a new interface function map_get_used_elem in bpf_map_ops
to provide an abstraction layer so that other map type implementations can
support the "used_entries" attribute in a future change.

A concurrency testing for pre-allocated and dynamically allocated
htab maps is introduced to test the correctness and performance of
htab map's used size.

Existing unit tests are integrated to test the correctness of
htab map's used size.

Thank you,

Ho-Ren (Jack) Chuang (4):
  bpf: Support reporting BPF htab map's used size for monitoring
  bpftool: Add tools support to show BPF htab map's used size
  samples/bpf: Add concurrency testing for BPF htab map's used size
  selftests/bpf: Add unit tests for BPF htab map's used size

 include/linux/bpf.h                     |   1 +
 include/uapi/linux/bpf.h                |   1 +
 kernel/bpf/hashtab.c                    |  19 +++
 kernel/bpf/syscall.c                    |   2 +
 samples/bpf/Makefile                    |   4 +
 samples/bpf/test_map_used_kern.c        |  65 ++++++++
 samples/bpf/test_map_used_user.c        | 204 ++++++++++++++++++++++++
 tools/bpf/bpftool/map.c                 |   9 +-
 tools/include/uapi/linux/bpf.h          |   1 +
 tools/testing/selftests/bpf/test_maps.c |  74 ++++++++-
 10 files changed, 377 insertions(+), 3 deletions(-)
 create mode 100644 samples/bpf/test_map_used_kern.c
 create mode 100644 samples/bpf/test_map_used_user.c

-- 
Ho-Ren (Jack) Chuang

