Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839883BD4C1
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 14:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhGFMRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245112AbhGFMM1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 08:12:27 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A16C08EC23
        for <bpf@vger.kernel.org>; Tue,  6 Jul 2021 04:56:21 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i13so20327919ilu.4
        for <bpf@vger.kernel.org>; Tue, 06 Jul 2021 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MgMduQFyj2+3I/MiKDJaPgLQZIvIl4Pjf9M0dRhRxd0=;
        b=ARpdgP+Uisj4uBKSSFlaA6j8SPoQvVmnEDQhF1jjov8wZJtDN8VdCKIdzwi9/r6tbg
         ApeJlxBgLE6R3JGkn7XURwJdnaOFm0zHzvlccNgk7FMtosW5dVRHeFL5goKh/i0+JVds
         LaZeOFtMICCt/KAwCfBWPPM0SseDKJWEl9oWC9oJ3iGZ0Ld4lEmorXHLL+3Gi+LEba64
         onPSEvJyiGPqZx2dIiELtgRzMN1wo0hfTNgkJX8WTjqp+afVh+a7EjAM+l+NIRv0OiNY
         BIXGKVJMYRj0LeZ3Pri+mI8FdEIuVC9Oyn7yS3Jla2DXBksRvvc7GHRwB+xPd+2G/ucb
         y5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MgMduQFyj2+3I/MiKDJaPgLQZIvIl4Pjf9M0dRhRxd0=;
        b=DdAsYc7IlRd6aCHk9fiFZi/qXmqhEDthD3Mt/pA4MM8O8eZ1qPctCJzQg9PLvfpXZR
         yZ5+8ybT+aG60l9BGfgk0TM54XKMB6qXSC2GnSKe50zm+ppS9JkEhjZak+8E2M5GqjCL
         ffmEUIanjJXyLc+7TBs+vdHE830uiSNJi60f5/kKYOQSGlt4QKd5SWrImgO3Srxny+Ly
         eCakIczzc9dkilbFUybpIY61cX0cbHF/upZN0Id3UVIPcVHcRYQ8626VOhMPkgzJWrhH
         HLFc9OcmrH7hPWTbItY1Mt3zuzRAL5TMGDN1vy7oPjeg87kS8I/lvsQaOc6YkVN7T2EZ
         Uzug==
X-Gm-Message-State: AOAM531s1LBDAc1PRJtKeOMO7w1RfC4Fn+CI8uJWdpxt8ekvXkJ2J+1r
        I8Wpo9t0M4tNo9B/L1BBMoOC9AEGoKUQY5dT9C5705E+474=
X-Google-Smtp-Source: ABdhPJw/FLqih/FWzZfan50tlDRyAlrp/KN1+zrCRo5gTgqq8PCROnK1DXcKCFLpel6KOVfRsk/NZXh0+KMKh/jI2d8=
X-Received: by 2002:a92:b004:: with SMTP id x4mr14718899ilh.121.1625572580238;
 Tue, 06 Jul 2021 04:56:20 -0700 (PDT)
MIME-Version: 1.0
From:   asaf eitani <eitaniasaf@gmail.com>
Date:   Tue, 6 Jul 2021 14:56:09 +0300
Message-ID: <CAAihumD0AOem=UhqRBDULQ6ZDL=n2vhn-3rLJq+mOm5-q2Wfjw@mail.gmail.com>
Subject: Failed to attach to kprobe (non blacklisted)
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi BPF experts,

I'm having issues to attach to certain kprobes and kretprobes that are
not in the blacklist, like ftrace_modify_all_code.
There are kernel modules that are capable of attaching to those
kprobes and kretprobes but I could not attach them using libbpf.

I tried using both tracee(https://github.com/aquasecurity/tracee) and
bpftrace(https://github.com/iovisor/bpftrace) to attach to those
kprobes, which to my understanding uses libbpf, but both of them
returned an "Invalid argument" error.

As the blacklist doesn't seem to cover all the functions which are not
attachable to kprobes, is there a way to get/compile such a list?
Also, what is the specific problem with attaching to this function
(ftrace_modify_all_code)?

Thanks.
