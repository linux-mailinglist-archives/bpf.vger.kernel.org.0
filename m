Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29AFA8A9C0
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2019 23:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfHLVvc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Aug 2019 17:51:32 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:53937 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfHLVvc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Aug 2019 17:51:32 -0400
Received: by mail-qk1-f202.google.com with SMTP id d11so94552547qkb.20
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2019 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0kDIUkQq74jS4s3L5upJ2sLFeJ4SQuXmh/iJl/tNzO8=;
        b=Vd9nPvrNsnO4tVGqvUzBIbfckrBlSRoUQ71ZP+FzvSNKEEhOuE681rboi5PXi4jYKq
         OY9v/yyXkJSEFM/SFETSH27C/UkgCU3JxUKwGMAyYh9yeqjjz6rNOCU2ceXdMw1LXfKW
         g4w1vs3y/w7FDQN3p1HEMS9FL8JXrsYqipn6zsbCxWPVF3CVt2wNKj/vkLmdJN+lktgz
         Us3tD4wd8wXVBIiHWmvQvmYWMeiU0jbuHcm0RVbTzPkoi7lBNBkyEiPNtaHoNNV0G/tW
         XFNS1krIhOH1G3jmt6d25VJw3BxZh00zqfGqlcb2OKw6p8kV57c1U99uFLWS4v8K9ikH
         DoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0kDIUkQq74jS4s3L5upJ2sLFeJ4SQuXmh/iJl/tNzO8=;
        b=OMrE/qLMk/kZBiywsnifAfzQebwuZbEUebp5wddbNVenypykSuYgseNAJ23AdqWE+R
         9EkZA6iElYoLSzzb3TCThoL+TMom5SnZuysKeD4tl2C0asv75QLcckyF0jMDoRr688wy
         jmrMWQ07MeZ5H6QGRZH8sBcbiYYJlLLMYX529Xs9S1NQW5Fmt38kFRb18aaUDJ+PfImq
         biY/V6y5tPyPawLEpslUYG6b3ZuMdZfMSiQq+E56xBmuZouJNcSKrnvElpzzG4Gk+eTL
         Qdoi0eUuQdYiReh8bxMGD4aZSicL5MEhG/IYVtDIA0dE82TRpAVxZU5aGsdKpmp4u/VY
         Fgag==
X-Gm-Message-State: APjAAAWraBotARE/bG4QxT6hTq5YMkfHQu3pK+BSM/gqD96ue2cZEbhP
        qJ+LFBOIrzUgMruMnjJuRn8etGykCnJcEPHKWh8=
X-Google-Smtp-Source: APXvYqzL9xoTa/IdedF1+fdf+8hstnyQibM73dfz4z6AyFXi+Fk60+vxTXikoA1YWpjXQrwItkwSdl3qBiQqejvfMUA=
X-Received: by 2002:a0c:af33:: with SMTP id i48mr31608806qvc.185.1565646691285;
 Mon, 12 Aug 2019 14:51:31 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:35 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-Id: <20190812215052.71840-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 02/16] arc: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arc/include/asm/linkage.h   | 8 ++++----
 arch/arc/include/asm/mach_desc.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arc/include/asm/linkage.h b/arch/arc/include/asm/linkage.h
index a0eeb9f8f0a9..d9ee43c6b7db 100644
--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -62,15 +62,15 @@
 #else	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_ARC_HAS_ICCM
-#define __arcfp_code __attribute__((__section__(".text.arcfp")))
+#define __arcfp_code __section(.text.arcfp)
 #else
-#define __arcfp_code __attribute__((__section__(".text")))
+#define __arcfp_code __section(.text)
 #endif
 
 #ifdef CONFIG_ARC_HAS_DCCM
-#define __arcfp_data __attribute__((__section__(".data.arcfp")))
+#define __arcfp_data __section(.data.arcfp)
 #else
-#define __arcfp_data __attribute__((__section__(".data")))
+#define __arcfp_data __section(.data)
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arc/include/asm/mach_desc.h b/arch/arc/include/asm/mach_desc.h
index 8ac0e2ac3e70..73746ed5b834 100644
--- a/arch/arc/include/asm/mach_desc.h
+++ b/arch/arc/include/asm/mach_desc.h
@@ -53,8 +53,7 @@ extern const struct machine_desc __arch_info_begin[], __arch_info_end[];
  */
 #define MACHINE_START(_type, _name)			\
 static const struct machine_desc __mach_desc_##_type	\
-__used							\
-__attribute__((__section__(".arch.info.init"))) = {	\
+__used __section(.arch.info.init) = {			\
 	.name		= _name,
 
 #define MACHINE_END				\
-- 
2.23.0.rc1.153.gdeed80330f-goog

