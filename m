Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB325F0279
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 03:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiI3B4L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 21:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiI3B4H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 21:56:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F65012167D
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 18:56:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d1-20020a17090a6a4100b002095b319b9aso1720431pjm.0
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date;
        bh=uW+tHp6KxRAoZ82sCMbBt30ExZ8fW/x4+fdshVCTrk0=;
        b=h46mfvJCH8OV+FOKSYQDyfc+bVn+gXh6VUsiSoE7AqwIT+vMloV2K7aPdndJS6yURw
         Ul+4H8nI8VEsD5tzK3vJqC96iwkeek9hOmV/D3P0en2/9GtFHpFNvoXALYJF+60wAZlg
         LTN8JbTgxNzAiuVdwTo3sSFVeGWPg/rkoV4rbc1UwMT0S7iNND7Jzus5EsRUPvDIwIvo
         SsdzMxAPdzNmwCQSz/CPJC90fR+PoD0rRQHEXwIWKYPWGmp1PfBxgm+3GCghfIo3f5Ir
         t0ewpWixwfO6/ILVIRUJ7/7mPL3pYSDQSHA331c4VL1ZT7BUAGnGua9PvFGjZGk2WuEo
         dIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uW+tHp6KxRAoZ82sCMbBt30ExZ8fW/x4+fdshVCTrk0=;
        b=T6f3t5XQ47Bd1qVa0E3aJyQkEEWYclM87A3zb1XwMKf08X9E1ptv/22mY4AJDKDVqb
         y8b9oVGQAkDMkX7TLYxdJ66b0r5aMRd9TUzBTEsZzR4XvAiR4Zl1eS+0XJ5P71vJ9bIF
         gQJzdTCCjaFs1s3MfiIfvPAaG/9v1rGJ/OxKp0+3P0wNt6lkxThjmppq3+LMZtoov8Kz
         uBSd0Ea1Awhiy2dvmjvmUAhy2hvw6cybbmHizuePyDDs/7R1ntvuTwjn2SegH5eBb55o
         gaD4wROjw7fyyeUUI9P9udM8wvn7m+JsB1WboUWKguqxja+kqWbCKovu21nM5PQZb1/R
         t2Uw==
X-Gm-Message-State: ACrzQf3iNC0RmzPHFnebAbuXyRyhHr01ULBei6z9U7RUyXb19CaEfKAG
        bxY3ZVpSaO/e3xyWqx7zdVE=
X-Google-Smtp-Source: AMsMyM4K4tQ607loRxZ4y8TDamHKmYv4/EEB2uYAbzrFjSFmrTckmgJH7EFuuC+nUjuderP1xnUfnA==
X-Received: by 2002:a17:90b:33c5:b0:202:fa60:3769 with SMTP id lk5-20020a17090b33c500b00202fa603769mr6892347pjb.60.1664502965811;
        Thu, 29 Sep 2022 18:56:05 -0700 (PDT)
Received: from localhost ([98.97.42.14])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b001728ac8af94sm547918plh.248.2022.09.29.18.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 18:56:04 -0700 (PDT)
Date:   Thu, 29 Sep 2022 18:56:03 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Yuan Can <yuancan@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org
Message-ID: <63364cb325f98_233df2084d@john.notmuch>
In-Reply-To: <fa36f8bf-f111-152d-6a8a-c50be49f1e72@isovalent.com>
References: <20220928090440.79637-1-yuancan@huawei.com>
 <fa36f8bf-f111-152d-6a8a-c50be49f1e72@isovalent.com>
Subject: Re: [PATCH 0/2] tools: bpftool: Remove unused struct
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

Quentin Monnet wrote:
> Wed Sep 28 2022 10:04:38 GMT+0100 (British Summer Time) ~ Yuan Can
> <yuancan@huawei.com>
> > This series contains two cleanup patches, remove unused struct.
> > 
> > Yuan Can (2):
> >   tools: bpftool: Remove unused struct btf_attach_point
> >   tools: bpftool: Remove unused struct event_ring_info
> > 
> >  tools/bpf/bpftool/btf.c           | 5 -----
> >  tools/bpf/bpftool/map_perf_ring.c | 7 -------
> >  2 files changed, 12 deletions(-)
> > 
> 
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> 
> Thanks for the clean-up.
> Quentin

lgtm

Acked-by: John Fastabend <john.fastabend@gmail.com>
