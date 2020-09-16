Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1F26CA31
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 21:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgIPTuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 15:50:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35041 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbgIPTro (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 15:47:44 -0400
Received: from mail-oo1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kIdOy-0002qJ-BL
        for bpf@vger.kernel.org; Wed, 16 Sep 2020 19:47:36 +0000
Received: by mail-oo1-f69.google.com with SMTP id p15so3466652oop.22
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 12:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9DTlUMQXUmYJrnQP6eQ/0rjf2Cvpn5CNN8DUo3rzLVw=;
        b=ZFEIXiq5IlbmOgLTpd7YnEn+Yhrpy+hTbTYBl7gj0FRpBqA3vNwk8GZu5X2BTJ4GGx
         sG/LwgxoH7AQeDfHtMF8FS2AmCzt47wXanfQ6W3dHGu1HKZHV+YrQtmJa32XsvKDOsZz
         RqHHj4zhLzXw94xoCuPHJKVRye/VH8hUY/b/fOVZ8QjlhpaCNlIRTk+k3oueMnecUiFQ
         fTtFhjp8ETRaojnKqrvie5DbpZLXDP+d1MklIpNPQXaG8StR0gS/W4FWTDb0G5GBHoJt
         vOPjpZliT2nnAiCzEO+C8cz5blXa4T0RxABf2VF6gVN6HUtTy1nbhQPa0NboEyLSevX3
         HGVA==
X-Gm-Message-State: AOAM533Z9Wr4LxbWZgH8ZnttKnDPcr3LJchF4swfH7FdX7TB/n+qUJWX
        fJFm88EcGmikbI5rki7DTwp+L7atQ/72NdI0CFl/5DV6c+fu5Pk7Bq2BwuEcVVROfhx1ipNtuEC
        63RbbpodSGSVWpygm33BcfLmyj/wstQ==
X-Received: by 2002:a05:6808:8c1:: with SMTP id k1mr4373481oij.92.1600285655137;
        Wed, 16 Sep 2020 12:47:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKw+wXmBG1oNv0ozyloHVqvmTAv80Lf/litTjvvMwgITJt/qOwX4GwXGPYo9+4OovuahX0Gw==
X-Received: by 2002:a05:6808:8c1:: with SMTP id k1mr4373469oij.92.1600285654807;
        Wed, 16 Sep 2020 12:47:34 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:2228:e36:da90:6c9])
        by smtp.gmail.com with ESMTPSA id x21sm8777870oie.49.2020.09.16.12.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:47:34 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:47:33 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: resolve_btfids breaks kernel cross-compilation
Message-ID: <20200916194733.GA4820@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The requirement to build resolve_btfids whenever CONFIG_DEBUG_INFO_BTF
is enabled breaks some cross builds. For example, when building a 64-bit
powerpc kernel on amd64 I get:

 Auto-detecting system features:
 ...                        libelf: [ [32mon[m  ]
 ...                          zlib: [ [32mon[m  ]
 ...                           bpf: [ [31mOFF[m ]
 
 BPF API too old
 make[6]: *** [Makefile:295: bpfdep] Error 1

The contents of tools/bpf/resolve_btfids/feature/test-bpf.make.output:

 In file included from /home/sforshee/src/u-k/unstable/tools/arch/powerpc/include/uapi/asm/bitsperlong.h:11,
                  from /usr/include/asm-generic/int-ll64.h:12,
                  from /usr/include/asm-generic/types.h:7,
                  from /usr/include/x86_64-linux-gnu/asm/types.h:1,
                  from /home/sforshee/src/u-k/unstable/tools/include/linux/types.h:10,
                  from /home/sforshee/src/u-k/unstable/tools/include/uapi/linux/bpf.h:11,
                  from test-bpf.c:3:
 /home/sforshee/src/u-k/unstable/tools/include/asm-generic/bitsperlong.h:14:2: error: #error Inconsistent word size. Check asm/bitsperlong.h
    14 | #error Inconsistent word size. Check asm/bitsperlong.h
       |  ^~~~~

This is because tools/arch/powerpc/include/uapi/asm/bitsperlong.h sets
__BITS_PER_LONG based on the predefinied compiler macro __powerpc64__,
which is not defined by the host compiler. What can we do to get cross
builds working again?

Thanks,
Seth
