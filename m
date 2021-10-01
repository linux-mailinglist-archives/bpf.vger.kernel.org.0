Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0034241F67F
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355332AbhJAUy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 16:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJAUy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 16:54:27 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E5FC061775
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 13:52:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r1so23118014ybo.10
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snHtR47WE8WLLA/m4Td/dwllZFtHni45N5EMrA+Cvjs=;
        b=SwDfNLWEAKrvsomwRD/T3R4+QTZ7v49ImHguMSWW+UfLBJQ9REnTJBenrPaS1+PPfC
         +mo6/ZrgmpIe769gxJx88be9Ea8MR7nIDNARK1cXjpYf/vcVBGOYsyfYyCcbwWriaoMm
         +axQM/6FVozcVSGSsrxsf4RnXqayCcos7KtB8lQQPAYOHC8a7xbki7I2O8qrF5m4jD6b
         d0nGKFmd3UmojBAvMHi4UWXVYYOxX+gHOZFrmjNJxdULcMgducKlNU3ZRdQME9dhJXX1
         2hI4yQDS768QCkO+4f8bPmb9cAYx+fzRpsO5hpZeL1jffIgU44BJb3CpurdneVuoU9n5
         b5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snHtR47WE8WLLA/m4Td/dwllZFtHni45N5EMrA+Cvjs=;
        b=PBhNCLsN7uePwxkwoVq//6QGDqzICZ3S3lQ9bekIRhLQ/oAcuxqDBkLKgq+YoFSGjv
         XSGt49DfaNvjXmC+cPIGTC8tTuBWrr203dN4V/JoU/9r5J9gacKisJnKb5bwQfFoitIp
         PXr4VTCZfcDnOYevHDN4vQ20jFrzOOXTIM3tKGI6Jy/+j8HY3MJTQXRxqinuzEbskgeL
         H0MpZKqUP0b4QDZsXZSiFyks8dKUsDS9Ykv8bnL5l0ksJR2oVipxRwxDlzWhkTBhyBm8
         aPIjFtktM1dOxAywa3trUvHzb8qzIX/ijo2H8wMm6Fr0QAfpOi48x5Y6wvWDx/I0uAu4
         AjWg==
X-Gm-Message-State: AOAM531CzErHh2itQwV70+W9cRFk5ajZNfb/cQDuT57+3k4n4CVHYLEa
        5B2om6e83vZ+JvTwV1Tykae38J9FLC27ePa7wLYZd+litsY=
X-Google-Smtp-Source: ABdhPJyfV9amQsnzZ71Tc0yHJ5kfFIsz1K1s4s8HQEuNhqyLRKk2SodIWzpG9grtNkKXq3k9CArt211T/lQWGDVvKjo=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr8899569ybc.225.1633121562326;
 Fri, 01 Oct 2021 13:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <d79d7eb8-98da-da02-24ad-130c6f88fe87@linux.alibaba.com>
In-Reply-To: <d79d7eb8-98da-da02-24ad-130c6f88fe87@linux.alibaba.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 1 Oct 2021 13:52:31 -0700
Message-ID: <CAEf4BzYX7FB-hpn4doNTuW0HtH+c0fmACEYe9Otn1_ge80OPYw@mail.gmail.com>
Subject: Re: How to attach a single bpf_program multiple times?
To:     Shuyi Cheng <chengshuyi@linux.alibaba.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 2:54 AM Shuyi Cheng
<chengshuyi@linux.alibaba.com> wrote:
>
> Hi, everyone!
>
> When the ebpf program is the same, but attach to a different kprobe
> function, I have to recompile the entire program. If the kprobe function
> of bpf_program attach can be specified dynamically, then there is no
> need to modify the original program.

With libbpf you can attach the same bpf_program to multiple kprobes.
Use bpf_program__attach_kprobe() API multiple times with the same
program instance, but different target functions.


>
> Thanks!
