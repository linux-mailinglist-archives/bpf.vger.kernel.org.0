Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4608A9F6
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2019 23:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfHLVwq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Aug 2019 17:52:46 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55429 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfHLVwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Aug 2019 17:52:45 -0400
Received: by mail-pf1-f202.google.com with SMTP id 22so3119580pfn.22
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2019 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G35OOE0sSfMuupCpgKQ0U4p9HFNylMt7P/lVbiGjqC0=;
        b=qCcbdR00iqgqZ/gG+jyOtF9Vncm844UkTWidc/xDIrreYwf0T8fY8OG5dIQRuiIxUe
         FzmJOT/4MTg94OWbw0D9mWByCs1880fYzbD8pk0R6AkDeFsG731eVhxBT+J45lFhFbwf
         mlOlBZtSLGRqW7vKpUirVuKzaLN7Rjm4AfAx434gpgHK8OnXp1izWDswYuMTZaX7/v+k
         E5rmfQINbPC0sfjRL04ILiNYMQYE/0nCRU4hiRjda6N7E6/6+GyHD0Ng7d2h3RK1UWj6
         dgszycG/x5ZESFf+qAorMsQgsHnfLzNx5F9k2KWcorwNp2pin4MzhBg34i9DY6K23R8/
         UIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G35OOE0sSfMuupCpgKQ0U4p9HFNylMt7P/lVbiGjqC0=;
        b=hRl3WFQfKmOA28E3t2ayttUM512W5WT34CJgF9+Yy8PjHtNcyFdAv9gdv1+t9umxL6
         IPc6UvH4uHBHiRWlq4sGhQ3cXIvYForIIfg0/qeg9/akd4831J93NpUI7BC76iWxaSyj
         2hwHJMlWuvME71UdM+nmRl1F+yLdugeVpCT2Pt0ZgDw6ajV00XP63rikY77o9KPy4tBy
         MvaPTelcxtb1b9052k89wsDg6o8CmGcNbEILVsHvC1t7waKCMwg1ePn7/gzGG7GCGnT3
         bQ58DcPa0LyweTeL64zGTUsyLFntTK5gjK55ywtJeYVzMOd7Go3YOVPc8QAlHyxKD9Xt
         yF8Q==
X-Gm-Message-State: APjAAAXtm/1JCkwBYC6avd1KN+upt1nDy3cCRZk06XyEDa/idjTx+SkC
        /uTJYLFnOIDCF8AuEOvTc6GMIB+W3bvGHDAnuA4=
X-Google-Smtp-Source: APXvYqxLWMFYSVfr9/WeBe4JYuK0mMWVB3QFQmdMAe16b4tQpW2+ajfgokDvaDbjaNDG0XIPT7kh9+HxxjG7h46tDzs=
X-Received: by 2002:a65:6114:: with SMTP id z20mr32341554pgu.141.1565646764247;
 Mon, 12 Aug 2019 14:52:44 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:45 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-Id: <20190812215052.71840-12-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 12/16] arm64: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/include/asm/cache.h     | 2 +-
 arch/arm64/kernel/smp_spin_table.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 64eeaa41e7ca..43da6dd29592 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -78,7 +78,7 @@ static inline u32 cache_type_cwg(void)
 	return (read_cpuid_cachetype() >> CTR_CWG_SHIFT) & CTR_CWG_MASK;
 }
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 static inline int cache_line_size_of_cpu(void)
 {
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 76c2739ba8a4..c8a3fee00c11 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -19,7 +19,7 @@
 #include <asm/smp_plat.h>
 
 extern void secondary_holding_pen(void);
-volatile unsigned long __section(".mmuoff.data.read")
+volatile unsigned long __section(.mmuoff.data.read)
 secondary_holding_pen_release = INVALID_HWID;
 
 static phys_addr_t cpu_release_addr[NR_CPUS];
-- 
2.23.0.rc1.153.gdeed80330f-goog

