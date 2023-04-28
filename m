Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D579C6F20C8
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 00:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345675AbjD1W2L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 18:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjD1W2K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 18:28:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB082137
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 15:28:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64115e652eeso15793962b3a.0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682720889; x=1685312889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5eq3iaKn56ebev9iYACeLOdV8uokj5PNwWdyD9KkHpA=;
        b=GhAdwRcVP2GlyQuUI3YEDp2FOTFwYRsQrovr8HBDApX0sKUlMiHlSIFKyW83M85Q9W
         vEcHSrsMwxc/F9aHlT03XYay84dRbGpG4A0O7Pntrf8HYRKoqcbMiWQa1lqfH8VURm6k
         Oft0ST6YMV63idgBmPaKeRY7W/UdEP6rauQIkFmQWM6xMEE9q8VvNKwL+OJocLNGCP+N
         bwAuqXINlurXmISyua44ktbluzr8a2GC3RAJAmcpR2lhGpbiw2Di3a5RMbfqd+YM/qN3
         iduOnURdXTTSAkt4kmijfSDFtRCdCAQkrdWwq5JNIhopbqhVyFKMH8RYZucNzn2V47zd
         deCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682720889; x=1685312889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eq3iaKn56ebev9iYACeLOdV8uokj5PNwWdyD9KkHpA=;
        b=ksqDcKE5K7Z1VllmrZVQj1MMPmNJ1f5bmn1yf0ufWQMaVGpa/NpgR4E/5LjnrttQ/b
         hDJsB2EpXNIrzMO+uuhyX0Rk1k51u3qN7YzgvAQ5UdjiBKp7BoxwReH1R8OGWHLvgCh4
         D29+GAecGd5irbv/7/uFsSo2hB2gQ+zCgASjTY/Q04GCAprKPA1O/kOxAE6HJqc/nsEi
         tDudBhKxwd11Ui6+iDL6xN+cKxCR8mdII/WYpCp41EBsYGcfD5RKGdmxq/h+RusxGhtv
         KPO3rjEj4ZZjmxED3qFHUvz0g/y2wH/eLDro8HxBctbDz/UhIz7M9ttbU7LQI9JIfFvF
         bQiw==
X-Gm-Message-State: AC+VfDxs/FTEC/KHUiX7h49WL/GcpbffUvgZSEJPcV4EOeOSc0Fh4HCr
        gXyTf2eTRt9/e5vLePxUaZX+VN2fLH0=
X-Google-Smtp-Source: ACHHUZ4qM6AgkH7U9PLjWZzuzh6Eguk2w/8opunkrvM09WxxOm5PnOpVdoVqEhq+hORHGmDgX+7qkw==
X-Received: by 2002:a17:903:24e:b0:1a9:581b:fbb1 with SMTP id j14-20020a170903024e00b001a9581bfbb1mr8142658plh.32.1682720889290;
        Fri, 28 Apr 2023 15:28:09 -0700 (PDT)
Received: from toolbox.. ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id ba11-20020a170902720b00b001a63ba28052sm10465738plb.69.2023.04.28.15.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:28:08 -0700 (PDT)
From:   JP Kobryn <inwardvessel@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     kernel-team@meta.com, inwardvessel@gmail.com
Subject: [PATCH bpf-next 0/2] libbpf: capability for resizing datasec maps
Date:   Fri, 28 Apr 2023 15:27:52 -0700
Message-Id: <20230428222754.183432-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.40.0
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

In a bpf_object, the datasec maps like .data, .bss, .rodata cannot be
resized with bpf_map__set_value_size() like normal maps can. This patch
series offers a way to allow the resizing of datasec maps.

The thought behind this is to allow for use cases where a given datasec
needs to scale to for example the number of CPU's present. A bpf program
can have a global array in a custom data section with an initial length
and before loading the bpf program, the array length could be extended to
match the CPU count. The selftests included in this series perform this
scaling to an arbitrary value to demonstrate how it can work.

JP Kobryn (2):
  add capability for resizing datasec maps
  selftests for resizing datasec maps

 tools/lib/bpf/libbpf.c                        | 138 +++++++++++++
 .../bpf/prog_tests/global_map_resize.c        | 187 ++++++++++++++++++
 .../bpf/progs/test_global_map_resize.c        |  33 ++++
 3 files changed, 358 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_map_resize.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_map_resize.c

-- 
2.40.0

