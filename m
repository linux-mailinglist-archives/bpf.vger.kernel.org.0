Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD4429A80
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 02:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhJLAqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 20:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhJLAqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 20:46:01 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2FBC061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 17:44:01 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id j38so6348548vkd.10
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 17:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=R7tSCUVUkdOEctX0mNgFXuCKEni9Mp0Z7q6/shj5S6w=;
        b=JfiNEldoVX/avB2TxXufej0pDfgKlPESKOAD+9UDoaQxn50jqfEkAxdLiZ3KwpWi5U
         uADMAXPS9lMiiUKJ7/MMpZr9ctcz01bpE1G9Dv3Qu/WcP1egrQ8bedLxYtvHYRTyr5eh
         GsV3VB4ZbeFoV1HRZSbgpCrpu/XHEp+imuNt07KckyNCZUhLEyc3U7b4aZvR4s5X5fvV
         f58IVsDtJVkzeM+m4hgRBOUzcGnOBqCueQduLqsFHB9X0MKFNIUjPo9qglA9bDZtgd4I
         B9n2Bt7pVhxK60OSm8/R1UEzyCSzP8QAltJVTeYcnvxukszFyPq3W5iKdxZYSIeUbZ03
         CZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=R7tSCUVUkdOEctX0mNgFXuCKEni9Mp0Z7q6/shj5S6w=;
        b=CL0EfiUYmG+8MRfwFwL20qIpiCo/2zqtkerUBhThx5VLaSRTaWDyC8rrA1jxdHtCd8
         N0qAGhnq97fFSzIJZb+QJLI5QTSX8moZcJzgOI46PpV0Hb6iQiduAPKHcFckgo5DTHZC
         w2GLrNx79y3lqSn1Pzo2vSgdJr48cGSN6yrdDnL7A9l7Fv08DZVCrVKmUOhljnl2t4QK
         /FJScOdgPuJzfBmMI1ayJzfoCvHYRt0OodThHBHzB4vDJ6brnH81B3U1DRh4b+dw0k0Z
         7/Rd+kcYvqsniiI0l+P+DYwcwK7uyzSOEFN1FcLpJboGgr2y0GFL/ekTocS7DWuQCGJn
         VuOA==
X-Gm-Message-State: AOAM533HGkz8+CKTxuDM7FYlV7x0G8KFGKArPJXUQsRjPIBfWbhFiOs3
        xERpfYPilEF33BHYiPdQK+Xvs+7dKDUIELu3HuUzbA4Y/L0=
X-Google-Smtp-Source: ABdhPJxaDfNqshEevvAjjvoLuNzGBQOie0VoOy4jQCtjlH1nJPEIB2mAETxydFMvEe+nf32FcklCPZ0HWfKEDRUvtv8=
X-Received: by 2002:a67:edd7:: with SMTP id e23mr26795326vsp.14.1633999440127;
 Mon, 11 Oct 2021 17:44:00 -0700 (PDT)
MIME-Version: 1.0
From:   Mohan Parthasarathy <mposdev21@gmail.com>
Date:   Mon, 11 Oct 2021 17:43:49 -0700
Message-ID: <CAL2pN58BAoThG1kjoyDxkrXGsAakNpJ6=qFb_2RHu7L1na9Ssw@mail.gmail.com>
Subject: Error during load: Arg#1 type is not a struct
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

My XDP program was working fine with older version of clang/llvm (10)
and when I moved to ubuntu 21.04, I ended up using version 12 and
started seeing the problem during load:

Validating xyz() func#1...
arg#1 type is not a struct
Arg#1 type PTR in xyz() is not supported yet.

I can see it is coming from btf_get_prog_ctx_type, but not able to
find the reason. The argument is a "void *".  What am I missing ?

Thanks
Mohan
