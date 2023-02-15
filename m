Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262D7698133
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 17:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBOQrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 11:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBOQru (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 11:47:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4B01F5E1
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 08:47:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f18-20020a7bcd12000000b003e206711347so1046536wmj.0
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWHjfdnMXLnQeONF9Y7BIQMZus7HNyosrdlc0gUe7+g=;
        b=J/jK7AjKWop+Rl0aFS17ZsocQqSdyG1w5Ph6rCrHVj4dfmwrZUj8WVXY9XDg7gZMrA
         vQoxexjnBVZU3MSWcWeLbtkg2EZd+EK5hpBv70HKajGab90wUbTNbtZ4/GxnC+G+f+EG
         zOl45XKkBDDTN2JXq1NTuwEWpb1h3RC5w+bug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWHjfdnMXLnQeONF9Y7BIQMZus7HNyosrdlc0gUe7+g=;
        b=qwt1r4pCVNvKQ9X80ml5RjESCSKl76I8lCZrypp6k8tLshTKKTUy+BPsZSO5nCNj4Y
         Gm6yQfm59h9YCevt2bJeb3V6SWvousYmUAdwGkbPoLSYv70vm4txaN0yqwcCDCpw5a3S
         OCLlFsErtGHqUZzGAuvrU/PZkiyH60yto91ndDh5Z3av0WHpG5zicS3+AKtvciRQxAXI
         L4pjyW12Q5yZTcVsHowQ+Tndhu6u8341I+jHKB7uJGhLb+3YoBIqeedKBTKbEepCp1Qx
         eZObl1q+4QLclbjWToAIjZ2DYL27BtcXhJ6KVny4t2vvVNvD+Q1OnoigxnJ3s7fJw1w2
         r9+w==
X-Gm-Message-State: AO0yUKUQ0Tc0a6TGk3ymMHLL+ielSPY1hyq6+GiffZ9K4K7rnk2rm84E
        dy1vo96SfEWTk/M1j/m6aoOBNk2e5Is+gCVg
X-Google-Smtp-Source: AK7set+MohFiDvkgUEA4Wr16OZCzBJtedjE0Hptcz9oaS3aTwTVVgZk8Ofwc7gmlHvDYCR8plie/NA==
X-Received: by 2002:a05:600c:4747:b0:3dc:4042:5c21 with SMTP id w7-20020a05600c474700b003dc40425c21mr2562744wmo.6.1676479666061;
        Wed, 15 Feb 2023 08:47:46 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::4:270c])
        by smtp.gmail.com with ESMTPSA id he8-20020a05600c540800b003e208cec49bsm566397wmb.3.2023.02.15.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:47:45 -0800 (PST)
Date:   Wed, 15 Feb 2023 16:47:44 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mcgrof@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        llvm@lists.linux.dev, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] module: Remove the unused function within
Message-ID: <Y+0MsMomkcDBdjNI@chrisdown.name>
References: <20230210064243.116335-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230210064243.116335-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiapeng Chong writes:
>The function within is defined in the main.c file, but not called
>elsewhere, so remove this unused function.

Huh? It's used by __module_text_address(), no?

>kernel/module/main.c:3007:19: warning: unused function 'within'.
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4035
>Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>---
> kernel/module/main.c | 5 -----
> 1 file changed, 5 deletions(-)
>
>diff --git a/kernel/module/main.c b/kernel/module/main.c
>index c598f11e7016..062065568b40 100644
>--- a/kernel/module/main.c
>+++ b/kernel/module/main.c
>@@ -3004,11 +3004,6 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
> 	return load_module(&info, uargs, flags);
> }
>
>-static inline int within(unsigned long addr, void *start, unsigned long size)
>-{
>-	return ((void *)addr >= start && (void *)addr < start + size);
>-}
>-
> /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
> char *module_flags(struct module *mod, char *buf, bool show_state)
> {
>-- 
>2.20.1.7.g153144c
>
