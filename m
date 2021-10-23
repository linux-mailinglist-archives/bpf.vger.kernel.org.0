Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F5043839A
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 14:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhJWMHR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Oct 2021 08:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230301AbhJWMHQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 23 Oct 2021 08:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634990697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WJ7OqKyeNGLyX08QkZ4hXW8FK+z+RePlGaRNyyYTfto=;
        b=WKTzcglJxUbYkVoyK/OwECk33/JbmzHXZGv4xB1AVi1Y6DHOPSuYC38mA7GMIng1E89Pn1
        a904ryb9nbI8TO44Otkl0dLaMcDv8coS0aNhVp2AbxgiNlH+X5HLeqzV/Gx3NVIuwfsf9w
        jpCxHopv4WTYa9/Cw+sFtHi7bGQ1dbQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-VWInN_1XNQi9_VWoyIIkUQ-1; Sat, 23 Oct 2021 08:04:55 -0400
X-MC-Unique: VWInN_1XNQi9_VWoyIIkUQ-1
Received: by mail-ed1-f70.google.com with SMTP id i15-20020a056402054f00b003dd1e94a359so2489368edx.22
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 05:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJ7OqKyeNGLyX08QkZ4hXW8FK+z+RePlGaRNyyYTfto=;
        b=ZVZGCSJ5+KV4S3WzDCTee/45Gw6TfN1oSXXVcMqW8M2WQO13DF4fs7DVHlH1alg9+6
         8b3tvQC/GfTz5qYnKHoS/MjDIubCINVRUcpnExUZUN0WNbIcndytM/fAY9aEmlf5jpsu
         28BxEC6mzhHPpH4jcSMj7pY+XLoudnPz7qlZ/rpVJKoWNmazuDpDjHKzBX5Sfv5SXD6N
         lIcT9sM5S8TG3JOtHSm0yxIZzShm1qNjEaPhJvqxYDuD7ouqJ4LvULi0a529byAShWn/
         yNkvIC4KVG6BIDk2rOu5roNZdLgk98oTEvkNJTIRP+Kx9i9ciMT5Xf+oLEtDeIxwQFRn
         tWlg==
X-Gm-Message-State: AOAM532sCrPYr4ZJh/nFJ9bUzocHk9MtXa+KeFQ/AiSIQ71zrkJekyOG
        UdE1H86cJZMPB5kT5vwmPiDByKcMP8Eics5FvMGpCT/JynznOgcZ83TwxS63FCAsJU1pqI32ejv
        kSHjHX23nYikl
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr8120006edd.129.1634990694717;
        Sat, 23 Oct 2021 05:04:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTnrkfuISB6s8UrcrnxDhWe7LRw2byylqlFuZxr5TZkQkliWOBCzwqrIVsgzO+5iK7CcdmgQ==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr8119975edd.129.1634990694487;
        Sat, 23 Oct 2021 05:04:54 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id f3sm5034882ejl.77.2021.10.23.05.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 05:04:54 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [RFC bpf-next 0/2] bpf: Fix BTF data for modules
Date:   Sat, 23 Oct 2021 14:04:50 +0200
Message-Id: <20211023120452.212885-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
I'm trying to enable BTF for kernel module in fedora,
and I'm getting big increase on modules sizes on s390x arch.

Size of modules in total - kernel dir under /lib/modules/VER/
from kernel-core and kernel-module packages:

               current   new
      aarch64      60M   76M
      ppc64le      53M   66M
      s390x        21M   41M
      x86_64       64M   79M

The reason for higher increase on s390x was that dedup algorithm
did not detect some of the big kernel structs like 'struct module',
so they are duplicated in the kernel module BTF data. The s390x
has many small modules that increased significantly in size because
of that even after compression.

First issues was that the '--btf_gen_floats' option is not passed
to pahole for kernel module BTF generation.

The other problem is more tricky and is the reason why this patchset
is RFC ;-)

The s390x compiler generates multiple definitions of the same struct
and dedup algorithm does not seem to handle this at the moment.

I put the debuginfo and btf dump of the s390x pnet.ko module in here:
  http://people.redhat.com/~jolsa/kmodbtf/

Please let me know if you'd like to see other info/files.

I found code in dedup that seems to handle such situation for arrays,
and added 'some' fix for structs. With that change I can no longer
see vmlinux's structs in kernel module BTF data, but I have no idea
if that breaks anything else.

thoughts? thanks,
jirka


---
Jiri Olsa (2):
      kbuild: Unify options for BTF generation for vmlinux and modules
      bpf: Add support to detect and dedup instances of same structs

 Makefile                  |  3 +++
 scripts/Makefile.modfinal |  2 +-
 scripts/link-vmlinux.sh   | 11 +----------
 scripts/pahole-flags.sh   | 20 ++++++++++++++++++++
 tools/lib/bpf/btf.c       | 12 ++++++++++--
 5 files changed, 35 insertions(+), 13 deletions(-)
 create mode 100755 scripts/pahole-flags.sh

