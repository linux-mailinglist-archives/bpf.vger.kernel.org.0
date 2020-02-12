Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEF96159F2C
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 03:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBLCps (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 21:45:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46838 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgBLCps (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 21:45:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id k29so432490pfp.13;
        Tue, 11 Feb 2020 18:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4XsJvZXSh2poOw0ny0DD0U8QzL/E8gANM6N3f870hLw=;
        b=R7Q3Gvd2nDYBCLMXNS1vwZ0+M9mzlo3zCghlPUswvarbQvL30kk6zl6inWgVLGyASy
         eVE3HnI/MR/yKUvTyIqbpIOXDNFZpzmDOsXsaraq46Y0ecARv15XKiYROhmCVf38+kbU
         FqaCxMb6unzp+gUAcoTWEfXdhUWey/OHj7oHwZAEn5fyH3PJzuCT+va3rZJCQAk70XJk
         H90ouN0z8TEFkBICvIVZDA8O6Szz9IYyzSECSzq0aWShDdMcQ+/7BWlS8SGwkULYjSvu
         LMKAThnpVFBe5nBAqPejEM0WvRq8Rx2wGL1PslOQtJ6MBeeHQt2Y+kaWPQvRNqRJH2Z0
         KSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4XsJvZXSh2poOw0ny0DD0U8QzL/E8gANM6N3f870hLw=;
        b=gqT7VBKWeygWIsPiNB9zMW7Xj5cdqP+vKkAJYtBOsb17aaLHlBTw2jbTa6EGPPZiMR
         QG4k7BX/89VgIXFlllvAXeBoq2sqCjEPmoLBZVSqSwCIag/dAhvU2Q7r2DqC62Kz87eV
         L0e/HnWTeESZnS+ifgpsIjVEmnjAnzLOSiP0sQakF88+rRoG2VHwzKaftWCEzAIScFKX
         Z36tfuM968ddfy7ItlfzHudDbmCow3rwpdGXKnrYZZfrqakZKCbmfIqrdjZkwMPhaH2A
         bj19bT6yYsORRsJyCExbzfQW8HhRG10X74lKZ87OgHRytgAg+p6AB/iFzQoSVl0aCIK4
         T5mg==
X-Gm-Message-State: APjAAAUPNALH/tggHKw04v7PD/sqqtjlFrZ52j9wCTwzs5obpCckoi7n
        nU4ck7wm52eUcJex4168yYY=
X-Google-Smtp-Source: APXvYqzqpZ6Ew8o6WvQIBZA0g9+/hsicYC2YDFE69RecwXpDRWIymv7bvw6BB65CPLE2HrNCYaDdcQ==
X-Received: by 2002:a63:74b:: with SMTP id 72mr9804384pgh.162.1581475547125;
        Tue, 11 Feb 2020 18:45:47 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::1:aeb4])
        by smtp.gmail.com with ESMTPSA id c10sm5449516pgj.49.2020.02.11.18.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 18:45:46 -0800 (PST)
Date:   Tue, 11 Feb 2020 18:45:44 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jann Horn <jannh@google.com>, KP Singh <kpsingh@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
Message-ID: <20200212024542.gdsafhvqykucdp4h@ast-mbp>
References: <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
 <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp>
 <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp>
 <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
 <20200211213819.j4ltrjjkuywihpnv@ast-mbp>
 <CAADnVQLsiWgSBXbuxmpkC9TS8d1aQRw2zDHG8J6E=kfcRoXtKQ@mail.gmail.com>
 <1cd10710-a81b-8f9b-696d-aa40b0a67225@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd10710-a81b-8f9b-696d-aa40b0a67225@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 12, 2020 at 01:09:07AM +0100, Daniel Borkmann wrote:
> 
> Another approach could be to have a special nop inside call_int_hook()
> macro which would then get patched to avoid these situations. Somewhat
> similar like static keys where it could be defined anywhere in text but
> with updating of call_int_hook()'s RC for the verdict.

Sounds nice in theory. I couldn't quite picture how that would look
in the code, so I hacked:
diff --git a/security/security.c b/security/security.c
index 565bc9b67276..ce4bc1e5e26c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/string.h>
 #include <linux/msg.h>
 #include <net/flow.h>
+#include <linux/jump_label.h>

 #define MAX_LSM_EVM_XATTR      2

@@ -678,12 +679,26 @@ static void __init lsm_early_task(struct task_struct *task)
  *     This is a hook that returns a value.
  */

+#define LSM_HOOK_NAME(FUNC) \
+       DEFINE_STATIC_KEY_FALSE(bpf_lsm_key_##FUNC);
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK_NAME
+__diag_push();
+__diag_ignore(GCC, 8, "-Wstrict-prototypes", "");
+#define LSM_HOOK_NAME(FUNC) \
+       int bpf_lsm_call_##FUNC() {return 0;}
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK_NAME
+__diag_pop();
+
 #define call_void_hook(FUNC, ...)                              \
        do {                                                    \
                struct security_hook_list *P;                   \
                                                                \
                hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
                        P->hook.FUNC(__VA_ARGS__);              \
+               if (static_branch_unlikely(&bpf_lsm_key_##FUNC)) \
+                      (void)bpf_lsm_call_##FUNC(__VA_ARGS__); \
        } while (0)

 #define call_int_hook(FUNC, IRC, ...) ({                       \
@@ -696,6 +711,8 @@ static void __init lsm_early_task(struct task_struct *task)
                        if (RC != 0)                            \
                                break;                          \
                }                                               \
+               if (RC == IRC && static_branch_unlikely(&bpf_lsm_key_##FUNC)) \
+                      RC = bpf_lsm_call_##FUNC(__VA_ARGS__); \
        } while (0);                                            \
        RC;                                                     \
 })

The assembly looks good from correctness and performance points.
union security_list_options can be split into lsm_hook_names.h too
to avoid __diag_ignore. Is that what you have in mind?
I don't see how one can improve call_int_hook() macro without
full refactoring of linux/lsm_hooks.h
imo static_key doesn't have to be there in the first set. We can add this
optimization later.
