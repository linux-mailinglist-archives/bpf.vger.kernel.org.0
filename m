Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4055234D98
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 00:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGaWfb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 18:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaWfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 18:35:31 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F81C06174A
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 15:35:30 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c16so14807667ils.8
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bQ64CYDodSF5firOyksgLfTvEnVMFt7MI5TMmURHiNw=;
        b=sDRSZ/OqMs4jm5mOfpusjR3M6GtK3xytHCiQy1LwZnPPKgINkfMuzgPiwDWloPlU7I
         4zCKcAKKBPWHFM6V2rJMRIaXGY967KjaKuznvI8IGuZJNyqr+BGYtnXKjv5wLfvWDaQX
         eCqMKTqwQmCUCxEpfWbErwxTKcjs2pjC+lT0b2bz4PeQKMpFa0aIRcZkzNlh7WLf9lUQ
         WZocBsQobGBZlvJ7gchAPNgK33mBHfF0ohfW2m3iJexRearjNJcjLFU2+qdl+iSR7/tL
         qHqfBRRsyNmwcwcsaabZkL0cPVSVxjQWgZJojlQEcJ0bK9mBy6VBsBEzNBCVWholZiQK
         qQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=bQ64CYDodSF5firOyksgLfTvEnVMFt7MI5TMmURHiNw=;
        b=bCcUt6wy9muZ2xI33UttqYeIb4ccTfix2WGcuxjDjgHW1uEVAI/p+XBK5tOg5/WXwk
         w+3Y8lPaOO4cBWsI7Ly/cm8zdoqBurhfuiYG7OrK8RIR5I7aW9aJQtfPzHynWuH3RZHf
         w0FAsFJwll5oaPxXPWTF1jqKkVu91lf2benSiaECWtCBYJZsNcqhPD66VUx98zeoQG5N
         fawn2brN3OeJRuwgBBMOGJytumFmpTzJ6Vb80WBeePEZiOvlAv491CbjHMErumURuN3q
         m3J8VkF1Xos3Q4svTmw1MX1C6nLxXiznbDpCW4HvsbMG6JFitFhO+vt7swwWyPpbWdHu
         9xVQ==
X-Gm-Message-State: AOAM533TrALTLwIW52IVknuBtQciMjvwv5qDptLeg5eX9kqVlel1cNkO
        hwTaX/2yBFTsAQ4KGZSPY70=
X-Google-Smtp-Source: ABdhPJzvxvFOWN8qWQWCUHL26jtCX9Pt0vhN5YXLC6Qt3k4okE84fzq/6Z7M0zGr0js3D4RKb19JJg==
X-Received: by 2002:a92:340d:: with SMTP id b13mr6177332ila.78.1596234930136;
        Fri, 31 Jul 2020 15:35:30 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id t17sm2818356ilq.69.2020.07.31.15.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:35:29 -0700 (PDT)
Subject: [bpf-next PATCH] bpf: Add comment in bpf verifier to note
 PTR_TO_BTF_ID can be null
From:   John Fastabend <john.fastabend@gmail.com>
To:     yhs@fb.com, john.fastabend@gmail.com, ast@kernel.org,
        daniel@iogearbox.net
Cc:     bpf@vger.kernel.org
Date:   Fri, 31 Jul 2020 15:35:17 -0700
Message-ID: <159623491781.20514.14371382768486033310.stgit@john-XPS-13-9370>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier contains both types PTR_TO_BTF_ID and PTR_TO_BTF_ID_OR_NULL.
For all other type pairs PTR_TO_foo and PTR_TO_foo_OR_NULL we follow the
convention to use PTR_TO_foo_OR_NULL for pointers that may be null and
PTR_TO_foo when the ptr value has been checked to ensure it is _not_ NULL.

For PTR_TO_BTF_ID this is not the case though. It may be still be NULL
even though we have the PTR_TO_BTF_ID type.

Improve the comment here to reflect the current state and change the reg
type string to indicate it may be null.  We should try to avoid this in
future types, but its too much code churn to unwind at this point.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 include/linux/bpf.h   |    2 +-
 kernel/bpf/verifier.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 40c5e206ecf2..b9c192fe0d0f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -352,7 +352,7 @@ enum bpf_reg_type {
 	PTR_TO_TCP_SOCK_OR_NULL, /* reg points to struct tcp_sock or NULL */
 	PTR_TO_TP_BUFFER,	 /* reg points to a writable raw tp's buffer */
 	PTR_TO_XDP_SOCK,	 /* reg points to struct xdp_sock */
-	PTR_TO_BTF_ID,		 /* reg points to kernel struct */
+	PTR_TO_BTF_ID,		 /* reg points to kernel struct or NULL */
 	PTR_TO_BTF_ID_OR_NULL,	 /* reg points to kernel struct or NULL */
 	PTR_TO_MEM,		 /* reg points to valid memory region */
 	PTR_TO_MEM_OR_NULL,	 /* reg points to valid memory region or NULL */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6ccfce3bf4c..d657efcad47b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -501,7 +501,7 @@ static const char * const reg_type_str[] = {
 	[PTR_TO_TCP_SOCK_OR_NULL] = "tcp_sock_or_null",
 	[PTR_TO_TP_BUFFER]	= "tp_buffer",
 	[PTR_TO_XDP_SOCK]	= "xdp_sock",
-	[PTR_TO_BTF_ID]		= "ptr_",
+	[PTR_TO_BTF_ID]		= "ptr_or_null_",
 	[PTR_TO_BTF_ID_OR_NULL]	= "ptr_or_null_",
 	[PTR_TO_MEM]		= "mem",
 	[PTR_TO_MEM_OR_NULL]	= "mem_or_null",

