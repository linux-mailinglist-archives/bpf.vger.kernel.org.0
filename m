Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE76E4D99
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjDQPtD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjDQPsp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 11:48:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C753CC09;
        Mon, 17 Apr 2023 08:48:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o2so26125750plg.4;
        Mon, 17 Apr 2023 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681746498; x=1684338498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzwNPovO934/64aRBZe++yk+dNmk1JTc3kyHlCW2thM=;
        b=EtvJ8wzzGeIKNvCSRVQyBRs0///s9z59xSvbgIBRPTP1pfha9sUxogoFUVO0c0db+g
         M0COUsSWzkRLMZ+BDmNpjNjihYBldeUy7CY+ea/XG6e5FC5qNvtB+ZpwGFQXDIXu8NmX
         64xY4XB80LHkLvy+SfsRjM+m/8d1gweexpJpB3NblaNolg9oxMkQfNwiF+8FvZ8JM2zW
         HDzq/NK8MLfgTR9LMciv9ceCAK9TtdmoA4kd/QYe1ZddwdaGqEjucKQNjx8tgVFk6+DH
         mHGoEyEqZrq9qahzLy0G/E8FMAHx6sLdPtSlzL4L4nx8V2W6JapPUI1wGfB4yMUNmmHB
         XrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746498; x=1684338498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzwNPovO934/64aRBZe++yk+dNmk1JTc3kyHlCW2thM=;
        b=fzEs6b4m7P0M3A8Qfym+mkaSXOol0fiXFsSzY8rWOdvI7T6C7HJnWy6QDAf1gaxnNx
         /GpRfbTS7QIX2STu8Szb1YBn5NXzwZSavVLxNHimwbVnwi+S1/0zQw8UwByXoQFgsfoj
         f5Xo3c78+3H0HufoEmUIt6To9HGk4JGT2C5/KItcxkmTbr/kk7BwLfEcpK2aUfbW85uA
         Ph7HaNRmodLNlPHXJHse4UE+Hkhc3APC/tbIBrUsQaGfLCw9V8HHGlCJA5KEBTIw93Ag
         oaa3Dk1+VUWQULC8PCRN5qcmzvU8xJULtHAXQxAheEqaJxRGHM/D36nSHySzVskwZfpz
         pc+A==
X-Gm-Message-State: AAQBX9fuEF4wEvFvB/ovbpfLu08RuOPTtD97KuCZ1hoBDwqZp+8ZGIlO
        acWMsaaI6tjTqyknuqeBA10=
X-Google-Smtp-Source: AKy350Ztle8natRSMegaDwypqIor50+pRLxLEDw9RI/thoOaMOAwGj0hmhhdVjUJTgHAFxDO1bxoCQ==
X-Received: by 2002:a17:902:eac2:b0:1a1:b440:3773 with SMTP id p2-20020a170902eac200b001a1b4403773mr12088320pld.27.1681746497891;
        Mon, 17 Apr 2023 08:48:17 -0700 (PDT)
Received: from vultr.guest ([2401:c080:3800:263c:5400:4ff:fe66:d27f])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001a6b308fcaesm4437513plb.153.2023.04.17.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:48:17 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 6/6] bpf: Remove some denied functions from the btf id deny list
Date:   Mon, 17 Apr 2023 15:47:37 +0000
Message-Id: <20230417154737.12740-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230417154737.12740-1-laoar.shao@gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the generic tracing recursion prevention mechanism applied, it is
safe to trace migrate_{disable,enable} and preempt_count_{sub,add}. So
we can remove them from the deny list.
However we can't remove rcu_read_unlock_strict and
__rcu_read_{lock,unlock}, because they are used in rcu_read_unlock() or
rcu_read_lock().

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 83fb94f..40f6b2c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18634,17 +18634,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
 BTF_SET_START(btf_id_deny)
 BTF_ID_UNUSED
-#ifdef CONFIG_SMP
-BTF_ID(func, migrate_disable)
-BTF_ID(func, migrate_enable)
-#endif
 #if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
 BTF_ID(func, rcu_read_unlock_strict)
 #endif
-#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
-BTF_ID(func, preempt_count_add)
-BTF_ID(func, preempt_count_sub)
-#endif
 #ifdef CONFIG_PREEMPT_RCU
 BTF_ID(func, __rcu_read_lock)
 BTF_ID(func, __rcu_read_unlock)
-- 
1.8.3.1

