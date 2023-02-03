Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45EF688CBB
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 02:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBCBqc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 20:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCBqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 20:46:32 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA3722790
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 17:46:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id r8so3842787pls.2
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 17:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCTVznR/Z6iVGI5wkRvFfdY817X97d89E27+UHNclfA=;
        b=nKB2qFU/f3hLtQJmM0OxHtgqfPX1qKKe+WDtRl1G/Y9LZJ4AnZvqFUGUDc9lfToyAk
         7T4or2xHXg1U+DzhSq92YChJRHFnwMV40L+I6BPz1WJWJZobNuixLe4p/VMX8Ttjt9ye
         l7H10ljFygBb0/r3ER/FOBCMYcISTBgA3iWokQz2qQEt9M6GRSBoDOJzZQjwRc0DMVbu
         TQWw82uk7onkxcPACc944Gxkk7CAHxLtK9y6as9THTANRlnPNw8sBQ2o0uAsNBN6AuKs
         3JhqdAmvZEPmXic/Y7i6sXgSfR+Z4bN9cJugv8TAsxis2gLQl5Nabu/kVc8QvC4P2dgI
         rnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LCTVznR/Z6iVGI5wkRvFfdY817X97d89E27+UHNclfA=;
        b=WhpixlplrI43EgD5aeNGFJuoKkwsUodmjslSsSQRAUopwltSJrQPG+llzZ6AEXLMdZ
         9lJyfCj7X//kJu03NYZwNLPI3HsUox2I76wC6aKlNpnt1MUAVQqLLC+Aco5AgXQpeYYH
         KBzaMnow/o0iB0Ju4fJAqLPVkUkysoJDM6HFu79N6Z97w/oc2Ver4Er3kcmtB3TH0Ghy
         PD/7qNrLiZ7ciFiD+2giM+f+2PjTIVaiKt1oiDigKDNiSBAFtOeBdkTxdw+oBqB2fFcI
         rd2vieA4I+2H86sxhKReEaOLKAB7q5uek7GwfSZbIq2nqlcyhN+lIYBYuOl0ZL9/4028
         Lfew==
X-Gm-Message-State: AO0yUKW/y6ghRYMpUb8Olx1jGxMsC1YJBsZ3+H4qs0ieTRoeO6Ku0O6g
        riicEpiZk84K3dbRmQJfpsI=
X-Google-Smtp-Source: AK7set/M5B7h2kngRDz/gRZmWSFtS5edL5vjGkSGwI7VHakkd+8MHNa7w1bxcS2VNpmOqA6dPQ6/WA==
X-Received: by 2002:a05:6a20:b1a6:b0:a3:7d0b:5dcb with SMTP id ee38-20020a056a20b1a600b000a37d0b5dcbmr2929315pzb.15.1675388790952;
        Thu, 02 Feb 2023 17:46:30 -0800 (PST)
Received: from localhost ([2600:100f:b113:593d:7db1:b09c:17d4:f975])
        by smtp.gmail.com with ESMTPSA id q7-20020a63ae07000000b004da5d3a8023sm392384pgf.79.2023.02.02.17.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 17:46:30 -0800 (PST)
Date:   Thu, 02 Feb 2023 17:46:25 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     tong@infragraf.org, bpf@vger.kernel.org, quentin@isovalent.com,
        daniel@iogearbox.net
Cc:     Tonghao Zhang <tong@infragraf.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Message-ID: <63dc6771a8400_688f120896@john.notmuch>
In-Reply-To: <20230202131701.29519-1-tong@infragraf.org>
References: <20230202131701.29519-1-tong@infragraf.org>
Subject: RE: [bpf-next v3] bpftool: profile online CPUs instead of possible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tong@ wrote:
> From: Tonghao Zhang <tong@infragraf.org>
> 
> The number of online cpu may be not equal to possible cpu.
> "bpftool prog profile" can not create pmu event on possible
> but on online cpu.
> 
> $ dmidecode -s system-product-name
> PowerEdge R620
> $ cat /sys/devices/system/cpu/possible
> 0-47
> $ cat /sys/devices/system/cpu/online
> 0-31
> 
> Disable cpu dynamically:
> $ echo 0 > /sys/devices/system/cpu/cpuX/online
> 
> If one cpu is offline, perf_event_open will return ENODEV.
> To fix this issue:
> * check value returned and skip offline cpu.
> * close pmu_fd immediately on error path, avoid fd leaking.
> 
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Signed-off-by: Tonghao Zhang <tong@infragraf.org>

Acked-by: John Fastabend <john.fastabend@gmail.com>
