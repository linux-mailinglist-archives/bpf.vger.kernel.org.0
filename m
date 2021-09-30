Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D2741DE9D
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349034AbhI3QQx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 12:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348103AbhI3QQx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 12:16:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E72BC06176A
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 09:15:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so7143807pjc.3
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4opaJz31k3VyF5DDKCnweC6AvYtIwrmm3urW/RW4mx0=;
        b=WJFMQCR/t/56x66Ve6udg81YCYXEV36vsvjaY1L9K/ytcfkZLCSXDSyFYaJ0FXdDFz
         1XnBntEAmW4qTNBHszirgenDbQea4W958u4ecLon+TXRiC9uJRqVuU0jWxrULxSnfpnD
         R7FraYvaQOwhmBgUnsfSnPogLbjD0dpxka+pWcP/8rSXGHf2JIWj3z2iQJZxtJCWJZNe
         SJH4QtDGCHk1yXA12sxYyJEN7SxHxgvDS2o1uW/sWlz91mF/MXCfVnxJdC2Zoef6Ysj6
         Ps8RsbMdubZ7cOw8QX3J3h1xzg6BUeyM8xZ3x/5LWVFIjSlpXtxGGdyt+84fDqNPpEHF
         WgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4opaJz31k3VyF5DDKCnweC6AvYtIwrmm3urW/RW4mx0=;
        b=lRwMcx7nPl6NhhSoyvrIBZkvMQIifTh4EmmywRIv73RAdsbRXfBFmIpIPhesT9fJ8S
         z0o4OBapNb4yFfxgqPgJAK/GGb5qd/ppw+LIBdxqYFairjtiI8JnKE51IijNI59zL2vx
         IIxjK6tir+9PwSiSwYLy3Qgx8n7/IRZN1FthF3KgdBhIJzhrrZ7ztRsS3gxasJZnsNcz
         YGS4oJ8cwZfa7digUU7L/r7xDG/WrLI6B2ZPIaDy9wTUpDDHrphxbkLK8xoh8AYoZRbU
         SmAimzyELqI94YAN7jSIo0lC4vd5yTG1f+B+WNCZBOos89D43+imcZlKPyff73aOA9pr
         4Z4g==
X-Gm-Message-State: AOAM533WIvq3+BCuYmdi4Fe3ojM6hFq9mSddSZly0QVZOqVzEYsHgic0
        NZxKw20KHTM7OPD7tGPuX0rPf+ftRfMMyQ==
X-Google-Smtp-Source: ABdhPJwDsxw6OGMP3Q+xvwR7l4lELu3BvsFV6a86ExWc+By6PqKhc1DcI15nMGdtEkhOvHuLst7tow==
X-Received: by 2002:a17:902:7d95:b0:13e:1272:884a with SMTP id a21-20020a1709027d9500b0013e1272884amr5108292plm.34.1633018509904;
        Thu, 30 Sep 2021 09:15:09 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id p17sm5278090pjg.54.2021.09.30.09.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 09:15:09 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/2] libbpf: Support uniform BTF-defined key/value specification across all BPF maps
Date:   Fri,  1 Oct 2021 00:14:54 +0800
Message-Id: <20210930161456.3444544-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently a bunch of (usually pretty specialized) BPF maps do not support
specifying BTF types for they key and value. For such maps, specifying
their definition like this:

  struct {
      __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
      __type(key, int);
      __type(value, int);
  } my_perf_buf SEC(".maps");

Would actually produce warnings about retrying BPF map creation without BTF.
Users are forced to know such nuances and use __uint(key_size, 4) instead.
This is non-uniform, annoying, and inconvenient.

This patch set teaches libbpf to recognize those specialized maps and removes
BTF type IDs when creating BPF map. Also, update existing BPF selftests to
exericse this change.

Hengqi Chen (2):
  libbpf: Support uniform BTF-defined key/value specification across all
    BPF maps
  selftests/bpf: Use BTF-defined key/value for map definitions

 tools/lib/bpf/libbpf.c                        | 24 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/kfree_skb.c |  4 ++--
 .../selftests/bpf/progs/perf_event_stackmap.c |  4 ++--
 .../bpf/progs/sockmap_verdict_prog.c          | 12 +++++-----
 .../selftests/bpf/progs/test_btf_map_in_map.c | 14 +++++------
 .../selftests/bpf/progs/test_map_in_map.c     | 10 ++++----
 .../bpf/progs/test_map_in_map_invalid.c       |  2 +-
 .../bpf/progs/test_pe_preserve_elems.c        |  8 +++----
 .../selftests/bpf/progs/test_perf_buffer.c    |  4 ++--
 .../bpf/progs/test_select_reuseport_kern.c    |  4 ++--
 .../bpf/progs/test_stacktrace_build_id.c      |  4 ++--
 .../selftests/bpf/progs/test_stacktrace_map.c |  4 ++--
 .../selftests/bpf/progs/test_tcpnotify_kern.c |  4 ++--
 .../selftests/bpf/progs/test_xdp_bpf2bpf.c    |  4 ++--
 14 files changed, 62 insertions(+), 40 deletions(-)

--
2.30.2
