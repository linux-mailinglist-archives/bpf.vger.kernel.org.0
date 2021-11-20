Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB97457F93
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhKTQpO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 11:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbhKTQpO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Nov 2021 11:45:14 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A91C061574;
        Sat, 20 Nov 2021 08:42:10 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id bu11so9343104qvb.0;
        Sat, 20 Nov 2021 08:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=t8r7bKcKFHRPqOVzgDbxjDzzRnS35ClMkrkGRCFzA8I=;
        b=Ldw75VmXkqfRKtsYnMtC871Va6WGsWQoBLtT9za89s2ZxpatbQKIJCShGZLfhpTwcF
         kUhF4rXxJ+/XTPVWIcN7qvkBrK0HYmCuXiYSzqQLPPlDTdJowtxMmSqLpt2/RRL6up2y
         RyWZnJeVfhQV/1hG1OE1djDJwBn3SkPzLEvw/pP6Ox9Jejf0Cu+o3d4fYB5rJRQklB8R
         v6injLpPVCdQaBrWFB74BuVHNTLCnSaiNSAGjyVY/B28zvnzbj7XumiOxBOeTcW11qY3
         FcRm18lKt4xlS5SHu8LOLaLKBCi9NQPk88b/tk1AhVCyZN1l/YnGE0GqiYlvar4xfrAP
         kxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=t8r7bKcKFHRPqOVzgDbxjDzzRnS35ClMkrkGRCFzA8I=;
        b=Dnvx1vc4mqtHm9fMM3xGFq7ZcngHXKCGr5L+vnuw0WIQZCV8MNTA0WBhvYhAzo8kgG
         eI+X6j8Ls7yw/sHnYJGP6lOdIKwtaVqsDu9/8FqV7tNRkn9bJP4DkyD37N9fAapogqqC
         tR94mh1Zh6kC9RCIcLdSSmBcM7LEUKH51KgAy0dLK0Ath+uptyyUmOlzzPBqnnBmHNOd
         E7vVWDhT+yoqIQbWOyEoNt7zj9rt4PBUVlcoZQlMCLHFphBlBkwlnRX22g3TH0X5V7EU
         NROQNsD9gRmVXv+W1vVWwbVo9qkHZh6Iw/jhRcAO8/xWOQ2LZCTRe3JiWjtu9WJvz45n
         n//g==
X-Gm-Message-State: AOAM531Hiso8RxfZI53qAeeRV8E3RVLG8BB/5lToxibQxlJs7pSmylL3
        42dRfARcRT7xRjO1GiA3rYpnPPB/8tKp+iCNZVs=
X-Google-Smtp-Source: ABdhPJxJi2XzIGEQCQtLIrdvwnPS+Skoe9aTKAltDA3g7jhXl/+cTnV6ECXlqLYm6lalV+fVbwy0e3RB60tzSUPtlZU=
X-Received: by 2002:a05:6214:e83:: with SMTP id hf3mr85096014qvb.52.1637426529756;
 Sat, 20 Nov 2021 08:42:09 -0800 (PST)
MIME-Version: 1.0
From:   Hui-Chun Feng <foxhoundsk.tw@gmail.com>
Date:   Sun, 21 Nov 2021 00:41:59 +0800
Message-ID: <CAFbkdV1y8xHQs7eUj1cM1hPNM9at1rA+FoWUuLTXKXj3D=VX5w@mail.gmail.com>
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
To:     guro@fb.com
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi list,

Is there any reason why this patch only got a few comments so far?

IMHO, by using static keys, the patch should add barely observable overhead
to sched when no BPF progs loaded. Or is it because of the point that Yousef
mentioned earlier? I.e. sched BPF may encourage people to fix sched problems
with BPF progs instead of fixing sched directly.

Thanks!
