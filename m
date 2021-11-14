Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D591E44F9FB
	for <lists+bpf@lfdr.de>; Sun, 14 Nov 2021 19:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhKNSq7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Nov 2021 13:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhKNSq6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Nov 2021 13:46:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331AFC061746
        for <bpf@vger.kernel.org>; Sun, 14 Nov 2021 10:44:02 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id o14so12605652plg.5
        for <bpf@vger.kernel.org>; Sun, 14 Nov 2021 10:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=O/AU4xV0e+kE9WGJeArrRLRectMLS+zdUOPUaGEEC8w=;
        b=TpY4P8kVeYst5zazDWLtoXN4/lLpWoc1x/Lj36p6tRTF2AsnzqUXcRBPdwm0ipyJ7J
         gJ6QaCkNc8YL7FuywMZXSlc/xk6lhwHYdU9W8OOXs/0W85ArRRHfaaPi1eY++FYVX041
         lohe8n8tXWWFdO2Dr+Qs967r780EUbR8fKQmnwZDetShJUnGE1YasDCCO6gCRMWaxtKI
         +xZrdiK7YUe7a99Z1Rf8nT5JQZBZIWtkO0Dskpx8VXDuzgFEm/brKWV9VLI5gSeiugtm
         U39EokV0Uio2F9diVp6DOtVK9QmwjNhQ24RAyc6CPg1nwMcmO6BNHPgXG6Lt7Fui7er2
         KMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O/AU4xV0e+kE9WGJeArrRLRectMLS+zdUOPUaGEEC8w=;
        b=M/g5vyDzR1ccwUID/aLCs5qNwu58AGCYUIl/iSv1MaViDbVbiAg/FpW+TosNXC1xsm
         63FqfdWDEjAxM/O1PFZvUUEGfrXJvOUALyJGl7a984ApBcfPjS2//4VoljNbvIV+7CO3
         4XeahuC4JLWyL0vO3sk9QjNtwDPlk80ZEZl7f0SlfXhhQrgvbLwg8fWsMhuUbEnAQWMf
         2hq8h7B+Ukb2Mz8/ajKMCmPx/Q4+72aWenmg4Oj4zGjt9uWNCNEGrklAErq87G5FVtgu
         yo92YHBPzteifz+vU5GmO6yHiAKO0A7NckvA5MySt7pbU7o6JTHqUiIa4wo2kmExIXK8
         Rzeg==
X-Gm-Message-State: AOAM532B3brYXYptl5r5JXCbRPg5JwEEadPBPP/US3OU1uHGeh9psx/c
        KEf8AV3Qc69scNpdtvbJv/1eMP3/dDG5DLLa9jC9KVaT+gs=
X-Google-Smtp-Source: ABdhPJz1tCxcFlgf1idmueth+lhRwKn7q7XJ58t5JX3sPEuLaC3S1ouGu52s3bCKuz6Gb+UURtcFojzF9xWtZmeYIFU=
X-Received: by 2002:a17:90a:17a5:: with SMTP id q34mr56569555pja.122.1636915440983;
 Sun, 14 Nov 2021 10:44:00 -0800 (PST)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 14 Nov 2021 10:43:49 -0800
Message-ID: <CAADnVQKEPYYrr6MUSKL4Fd7FYp0y5MQFoDteU5T++E6fySDADw@mail.gmail.com>
Subject: sockmap test is broken
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        joamaki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_maps is failing in bpf tree:

$ ./test_maps
Failed sockmap recv

and causing BPF CI to stay red.

Since bpf-next is fine, I suspect it is one of John's or Jussi's patches.

Please take a look.
