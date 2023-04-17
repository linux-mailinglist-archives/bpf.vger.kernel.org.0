Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC0F6E4D8C
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 17:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDQPr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 11:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQPr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 11:47:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF76FB0;
        Mon, 17 Apr 2023 08:47:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d8so912519plg.2;
        Mon, 17 Apr 2023 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681746474; x=1684338474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OULnICdYHOAOBZgGzZH4pNXiLKXoIP2AAPrDpC3Es1Q=;
        b=MbsretE2GcIGceLNQIgzbDZAtx/EMTEEcrC47j5Zpe1K6RWuaROAD+mun174uT12Ow
         dgWqdJbCNho1H/WNFwkmE8aPCtA5S2dre0w4+EwqSiZ4cN47v8GF4AodXyA3cvEf2r2+
         SPM7z8uwQIkgwKYChhXS29JJkS2vhM2ImOUaTi/R95MPc8RY8S/uOxtKZS6CY4eNTXe2
         Cb28LgfA758G0nzkWMlf5OvRavEtZ3tn4/5umeJ1RsndKAZVnYbuSY2ikXvkCLkZTRZX
         QMx713+nhSFxVCHLt/m2Gieef/nKeph2w6t23hdopxh28dy+90sXdnnnZDkqJaDvY0fi
         +ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746474; x=1684338474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OULnICdYHOAOBZgGzZH4pNXiLKXoIP2AAPrDpC3Es1Q=;
        b=PUz7zhezHYOHTQDyYZwcW+/nV4WRgIymQXtNoSf6PGIcib3F+pFmo9I7T0RF3zqOQa
         Habks/q86JeD/qMUBjEoEChIygA/qVB9hcJiAGSLG7LqIGUc3k9lxc1G1jjgqfMlQ++k
         j6mzoGtarqWpB3wwfrfG6lNptDQNocxpson71NKvem9qkYWLotpeaqenGDRCbFaIGScu
         EOa4YLjFZNUaSW4nWTxHP0lk3H+Q2eoeGW6UMTCJNwXiVrH0zWng89co+oWXdQTGyJ51
         Hrwnb5/Kd6rles2l3GDK/4H+qQ3Rxaygy5/Uxd0017uYUbVbE93aUGB6prZYCH+c9NgD
         EwRQ==
X-Gm-Message-State: AAQBX9fjh9/rtAXOJ09cslM7omIsOPsWwY+kzQ9Zdjjj50FPvHqwXxSD
        ecZ/+IVKiQbV5nrZ8XtQdBU=
X-Google-Smtp-Source: AKy350bokXXTKLgGTQTsy58AVJVbkvNw4Hl9PBMwfbi34k5ByMLkxkAgE8hrNv9/27xSdpWpqLIbuw==
X-Received: by 2002:a17:902:fa0d:b0:1a5:2b7b:57e8 with SMTP id la13-20020a170902fa0d00b001a52b7b57e8mr11845625plb.26.1681746474104;
        Mon, 17 Apr 2023 08:47:54 -0700 (PDT)
Received: from vultr.guest ([2401:c080:3800:263c:5400:4ff:fe66:d27f])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001a6b308fcaesm4437513plb.153.2023.04.17.08.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:47:53 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/6] bpf: Tracing recursion prevention mechanism improvement 
Date:   Mon, 17 Apr 2023 15:47:31 +0000
Message-Id: <20230417154737.12740-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Currently we use prog->active to prevent tracing recursion, but it has
some downsides,

- It can't identify different contexts
  That said, if a process context is interrupted by a irq context and
  the irq context runs the same code path, it will be considered as
  recursion. For example,
    normal:
      this_cpu_inc_return(*(prog->active)) == 1 <- OK

      irq:
        this_cpu_inc_return(*(prog->active)) == 1 <- FAIL!
        [ Considered as recusion ]

- It has to maintain a percpu area
  A percpu area will be allocated for each prog when the prog is loaded
  and be freed when the prog is destroyed.

Let's replace it with the generic tracing recursion prevention mechanism,
which can work fine with anything. In the above example, the irq context
won't be considered as recursion again,
  normal:
    test_recursion_try_acquire() <- OK

    softirq:
      test_recursion_try_acquire() <- OK

      irq:
        test_recursion_try_acquire() <- OK

Note that, currently one single recursion in process context is allowed
due to the TRACE_CTX_TRANSITION workaround, which can be fixed in the
future. That said, below behavior is expected currently,
  normal:
    test_recursion_try_acquire() <- OK
    [ recursion happens ]        <- one single recursion is allowed
    test_recursion_try_acquire() <- OK
    [ recursion happens ]
    test_recursion_try_acquire() <- RECURSION!

To adapt to this behavior, the bpf recursion selftest is changed.

Steven Rostedt (Google) (1):
  tracing: Add generic test_recursion_try_acquire()

Yafang Shao (5):
  bpf: Add __rcu_read_{lock,unlock} into btf id deny list
  tracing: Add the comment for allowing one single recursion in process
    context
  selftests/bpf: Allow one single recursion in fentry recursion test
  bpf: Improve tracing recursion prevention mechanism
  bpf: Remove some denied functions from the btf id deny list

 include/linux/bpf.h                                |  2 +-
 include/linux/trace_recursion.h                    | 49 ++++++++++++++++------
 kernel/bpf/core.c                                  | 10 -----
 kernel/bpf/trampoline.c                            | 44 ++++++++++++++-----
 kernel/bpf/verifier.c                              | 10 ++---
 kernel/trace/bpf_trace.c                           | 12 +++---
 kernel/trace/ftrace.c                              |  2 +
 tools/testing/selftests/bpf/prog_tests/recursion.c |  7 +++-
 tools/testing/selftests/bpf/test_progs.h           | 19 +++++++++
 9 files changed, 107 insertions(+), 48 deletions(-)

-- 
1.8.3.1

