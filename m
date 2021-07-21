Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5B03D1978
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhGUVRj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 17:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229921AbhGUVRi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Jul 2021 17:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626904694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Siz/P5D/M03bAys99ZaIKAlUV73f5y7wfF/yizEdY04=;
        b=UCBaOOXR7K3P9tqA24seebQDA7NIuvSMMYKe6O/rKnP6PrnOpbHGBlRthvuSuXkoWRXYtW
        ow9tppzZAMsPJDjCKVhWUMO8sugk/WRWJ1oKUlHJLvBdTCgPBJLpd2dhH1N082WJxo0V/H
        6Wn+8n32PgC2lz997EqRBcL8iIW65tQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-RH4wUb0CMf6uPb6m6jXUug-1; Wed, 21 Jul 2021 17:58:12 -0400
X-MC-Unique: RH4wUb0CMf6uPb6m6jXUug-1
Received: by mail-ej1-f70.google.com with SMTP id rl7-20020a1709072167b02904f7606bd58fso1296315ejb.11
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 14:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Siz/P5D/M03bAys99ZaIKAlUV73f5y7wfF/yizEdY04=;
        b=PUG7030Q09gVs2gUdAglEPhDFRTH2l6eHPTES1iLRkEzV0vJKs4VYHXQyJ8bsL59JD
         Hy9NhUjMaJ/OBwN/abBJn02zoO2toL0KVNTuzAgrJ8gZ3HYId6GmzZJog8n/OBLLMvws
         rGvUBeeBfUAIBsOI7TtImgbMAroXRt/0ZlVPswIuXfKlvFFng3cR0rPzh9GfZiRvAWRa
         zy47j5lDhtqPdMhu3RO8iSUGybyhLEAYAHsw1xyJaVk1iXXSYCy2DPnuTMYnXtsUCVXz
         6vfbIJl4e52GbLaPxp/9Pqy2osrR+pG3USZaohPHPaTmC/5tGtylB6JOH0g4YyF3Thp9
         17DQ==
X-Gm-Message-State: AOAM530t7izVvSNGybUtx3wQzS8enJUksguK9qW01RaOshqyzZI761Q3
        O2hA4ePdcqs2td4m8LvNnU8O8ESbVytYZw7v1nvPP+esbcxefswZHgX846bW6zd1vLwZp+VaZt8
        D7zHYJL1bysHl
X-Received: by 2002:a05:6402:1396:: with SMTP id b22mr24377552edv.380.1626904691575;
        Wed, 21 Jul 2021 14:58:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzITIPYeAo63PJ0MDgStSYALzx9ZaL9PNYQW33NTSP+hHHmPMbJx43mSxQAcRshbyH8THRzfA==
X-Received: by 2002:a05:6402:1396:: with SMTP id b22mr24377531edv.380.1626904691430;
        Wed, 21 Jul 2021 14:58:11 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.60.59])
        by smtp.gmail.com with ESMTPSA id kb12sm8763228ejc.35.2021.07.21.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:58:11 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/3] libbpf: Export bpf_program__attach_kprobe_opts function
Date:   Wed, 21 Jul 2021 23:58:07 +0200
Message-Id: <20210721215810.889975-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
making bpf_program__attach_kprobe_opts function exported,
and other fixes suggested by Andrii in recent review [1][2].

thanks,
jirka


[1] https://lore.kernel.org/bpf/CAEf4BzYELMgTv_RhW7qWNgOYc_mCyh8-VX0FUYabi_TU3OiGKw@mail.gmail.com/
[2] https://lore.kernel.org/bpf/CAEf4Bzbk-nyenpc86jtEShset_ZSkapvpy3fG2gYKZEOY7uAQg@mail.gmail.com/

---
Jiri Olsa (3):
      libbpf: Fix func leak in attach_kprobe
      libbpf: Allow decimal offset for kprobes
      libbpf: Export bpf_program__attach_kprobe_opts function

 tools/lib/bpf/libbpf.c                                    | 34 +++++++++++++++++++---------------
 tools/lib/bpf/libbpf.h                                    | 14 ++++++++++++++
 tools/lib/bpf/libbpf.map                                  |  1 +
 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c |  2 ++
 tools/testing/selftests/bpf/progs/get_func_ip_test.c      | 11 +++++++++++
 5 files changed, 47 insertions(+), 15 deletions(-)

