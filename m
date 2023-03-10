Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7829E6B3BB9
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 11:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjCJKID (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 05:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCJKHo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 05:07:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5D010DE57
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 02:07:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e13so4498989wro.10
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 02:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678442853;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LEA8J3CxZf7m0eMQ8FY0KmhPPxE1639BPszB//ULgxw=;
        b=l0yziffo4u7wtXVCTeesTCX3Cy/GUwGRRnAXl3CyMUp9Lp1z76mGYMbHCV5XnZFeVU
         rIaPIlpCmsMEdx2NFhQg6vyVaVSpsI8znRp3eaxb0P0vNbhWDt6qO5Ml/+W1bwehErEb
         AKU2M8R2Qn2K4W7VjWBV9VFG6ffdOphmXgEwPkCZlQgyrFZ4+3+BAksonYtNTRf0rwIb
         +P5RTUTXti63NUYkPi0d7aX6PFXPckmtdESELHzWcAUdX6/0E9ME/n3hhsZrQa5sjjPd
         Eopf2DC84V8W41ft6IPn6vocRGb/cBexzNg98iPxYDpI+26imF2s72Wdzt4W1A9uknFb
         Ab5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678442853;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEA8J3CxZf7m0eMQ8FY0KmhPPxE1639BPszB//ULgxw=;
        b=wAk0XcKfWyc4p1MjlVJN4PSjQSpvJd/4BOkZ3ULmbbqbj+lgcW9ALdmGoMJV/QrhWZ
         VjZ0bPBvgHLS7XGT32C8IwWH+NriRUN8sIa4YYg56uZBjWAxv/kFaMIjg3XwwxJS+ag+
         BA3YzgEEGmFXoQhY451BYe39SwIXjhJFKN0wFnUK518lSIQGX9fYIMeaY8qV7AxopUbZ
         amdSyyxAFnjUuG5StX0mE20a1BsGCXWOpdDft2FUY8b8aHcGVAF403Xe2kQmykXzGGwb
         t1uC+e9nfUu7kfTEw7zcEQuZp53iFTljI3lSEzfrlwA0lau4sznZfy6gP7m2tHW+oX1D
         GCnA==
X-Gm-Message-State: AO0yUKWgKohTBnZpcD7OGdrXwALP0vjFZFR/WDLdw1UcVAwU7KZ162n+
        hVZkMJRGG5Vq2v6Lbhmzb72YS23lBZy7Ig==
X-Google-Smtp-Source: AK7set/txBRAwbug3gdo15yFm0daJ5nvSnc8XshO2OOp57bf+R5vuOGbS7wMy+hPTxF11P1hh6WQ+w==
X-Received: by 2002:a5d:6a03:0:b0:2c7:169b:c571 with SMTP id m3-20020a5d6a03000000b002c7169bc571mr14587173wru.5.1678442853103;
        Fri, 10 Mar 2023 02:07:33 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d6081000000b002c6e8cb612fsm1653585wrt.92.2023.03.10.02.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 02:07:32 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 10 Mar 2023 11:07:30 +0100
To:     acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org
Subject: [RFC dwarves] syscall functions in BTF
Message-ID: <ZAsBYpsBV0wvkhh0@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
with latest pahole fixes we get rid of some syscall functions (with
__x64_sys_ prefix) and it seems to fall down to 2 cases:

- weak syscall functions generated in kernel/sys_ni.c prevent these syscalls
  to be generated in BTF. The reason is the __COND_SYSCALL macro uses
  '__unused' for regs argument:

        #define __COND_SYSCALL(abi, name)                                      \
               __weak long __##abi##_##name(const struct pt_regs *__unused);   \
               __weak long __##abi##_##name(const struct pt_regs *__unused)    \
               {                                                               \
                       return sys_ni_syscall();                                \
               }

  and having weak function with different argument name will rule out the
  syscall from BTF functions

  the patch below workarounds this by using the same argument name,
  but I guess the real fix would be to check the whole type not just
  the argument name.. or ignore weak function if there's non weak one

  I guess there will be more cases like this in kernel


- we also do not get any syscall with no arguments, because they are
  generated as aliases to __do_<syscall> function:

        $ nm ./vmlinux | grep _sys_fork
        ffffffff81174890 t __do_sys_fork
        ffffffff81174890 T __ia32_sys_fork
        ffffffff81174880 T __pfx___x64_sys_fork
        ffffffff81174890 T __x64_sys_fork

  with:
        #define __SYS_STUB0(abi, name)                                          \
                long __##abi##_##name(const struct pt_regs *regs);              \
                ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);                 \
                long __##abi##_##name(const struct pt_regs *regs)               \
                        __alias(__do_##name);

  the problem seems to be that there's no DWARF data for aliased symbol,
  so pahole won't see any __x64_sys_fork record
  I'm not sure how to fix this one

  technically we can always connect to __do_sys_fork, but we'd need to
  have special cases for such syscalls.. would be great to have all with
  '__x64_sys_' prefix


thoughts?

thanks,
jirka


---
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index fd2669b1cb2d..e02dab630577 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -80,8 +80,8 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	}
 
 #define __COND_SYSCALL(abi, name)					\
-	__weak long __##abi##_##name(const struct pt_regs *__unused);	\
-	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
+	__weak long __##abi##_##name(const struct pt_regs *regs);	\
+	__weak long __##abi##_##name(const struct pt_regs *regs)	\
 	{								\
 		return sys_ni_syscall();				\
 	}
