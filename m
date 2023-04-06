Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A0E6DA482
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 23:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbjDFVN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 17:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDFVN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 17:13:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20D67ED8;
        Thu,  6 Apr 2023 14:13:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r7-20020a17090b050700b002404be7920aso40072862pjz.5;
        Thu, 06 Apr 2023 14:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815605; x=1683407605;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCVxELTrTSpy+imTMqTFnISjchyfQpqhQ55LHn6jdbg=;
        b=P9D31KMZRx3CWKpYsg2NNvmH2mCLl2uppn2ugSQSjGU4vqInWkmyu1Wi32rbp5tK9u
         0GKxvf3Uvk7GnT8cFt4iNuLCYJ9lOcgfU6q3u1/sGlLLFWfAIz4hz3eB4ZUs4USQJlew
         p9FjACPWwwb6AldUPasIkdMD0etPiPfAAT1u9v4ISWc0V72Pa/kgZ53GmitlH4jQ71Ab
         +Okrf47Tk75ucVsLd0dAZEZjK+Kg6hF80mjaN8Nc/pnRkrv9dV//C/EdABsy+tnqcf5E
         s708xfpxKZlIsYnjy/MmALz8tXNyAdL/7HBdFaSuUOTcNiORwr/Lng1ILyxOHPFDEBFS
         JuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815605; x=1683407605;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZCVxELTrTSpy+imTMqTFnISjchyfQpqhQ55LHn6jdbg=;
        b=BEf5gy+sjfBp97MfB4EYpwXV+Hvl+PLnOltVHqccsbaCnnyMCt8cIuE9xBsGulS1bJ
         tCwnsgdnmxc5NSc6P3P3PgcmX3k0/z5iGgZ2h1IoOV+daGA5FNi9Wzp1XqDB+35AB+8z
         0SQhUGuWq3UMckIN0qgbzGksjdFiuGEVc/KNVTuX4rUCoZ6mfcKt2kK1sOReAG5pQ3qA
         r2YAViGmHfEoyRBi3t/YLRQbM4qgTh27R2evMbeV+CDUUa7Fv66YODPI2oNl6fmN9Hko
         tSbYONL1gRoORexuq+fulkqIvKNx6rIKDTxB8W9K6+txwcFJFVSEkzYt0SZVqN/oy7Gi
         eliQ==
X-Gm-Message-State: AAQBX9cf1kOvW5EYkX51ibcacJIr8u0t3/gG69RBW2Fye5tn8MtPJ4MG
        WJ7EGFvkag49C16sXziDPSw=
X-Google-Smtp-Source: AKy350bCNbW4udGWvvxKY/H8/KCHVbh8qEweSTRFs1xww/19WFZ+7Qjc3Ib1wuNseDFh42n12fqeuw==
X-Received: by 2002:a17:90b:4f48:b0:22c:59c3:8694 with SMTP id pj8-20020a17090b4f4800b0022c59c38694mr12486611pjb.44.1680815605163;
        Thu, 06 Apr 2023 14:13:25 -0700 (PDT)
Received: from localhost ([67.170.148.130])
        by smtp.gmail.com with ESMTPSA id n32-20020a17090a2ca300b00227223c58ecsm1567684pjd.42.2023.04.06.14.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:13:24 -0700 (PDT)
Date:   Thu, 06 Apr 2023 14:13:23 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Xin Liu <liuxin350@huawei.com>, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, hsinweih@uci.edu,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, liuxin350@huawei.com,
        zhangmingyi5@huawei.com
Message-ID: <642f35f3881ee_6e3a2085@john.notmuch>
In-Reply-To: <20230406122622.109978-1-liuxin350@huawei.com>
References: <20230406122622.109978-1-liuxin350@huawei.com>
Subject: RE: [PATCH bpf-next] bpf, sockmap: fix deadlocks in the sockhash and
 sockmap
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Xin Liu wrote:
> When huang uses sched_switch tracepoint, the tracepoint
> does only one thing in the mounted ebpf program, which
> deletes the fixed elements in sockhash ([0])
> 
> It seems that elements in sockhash are rarely actively
> deleted by users or ebpf program. Therefore, we do not
> pay much attention to their deletion. Compared with hash
> maps, sockhash only provides spin_lock_bh protection.
> This causes it to appear to have self-locking behavior
> in the interrupt context.
> 
>   [0]:https://lore.kernel.org/all/CABcoxUayum5oOqFMMqAeWuS8+EzojquSOSyDA3J_2omY=2EeAg@mail.gmail.com/
> 
> Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: Xin Liu <liuxin350@huawei.com>

Yeah even if we delete entries we do it from a sockops. Thanks for the
fix.

Acked-by: John Fastabend <john.fastabend@gmail.com>
