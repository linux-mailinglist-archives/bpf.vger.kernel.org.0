Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960D0203C36
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgFVQI2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFVQI2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 12:08:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6D3C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 09:08:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r18so8326776pgk.11
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=nwcou3MEs51lcRUW6H0Q5+j+k4cv1O6Eg8DPqVQAwSE=;
        b=R29M2ivGtVoipuZJxzUU1tt43eW8f26kkOktlCqY2CQwmRITQpN6sk0KocOVeKYkXx
         HHvVOcadgbXnMb24WenQzrEUisLm/qX/kP+w3X6/YwpiewQtyDOz1yWbITIEAv0V4XH8
         Gy5HLUSml/CKyAR6/tins+zsWSIaI5qTgvLLtq5ZK5ZG3Dy2pa/YAZ3V0yniGIuS20yz
         jaHFym4lz8tVFFauqeb/JonbhVMhDRi7vjrRNex/zLfqjdUVLzvVpH1lTtBoWb4AuoNK
         fBCCMS+ydAkTmv5CtoGmAsLKyonBr4P2dfmHvNJ8Ode997nQBtgZh7+ANfE83OOwr4En
         pqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=nwcou3MEs51lcRUW6H0Q5+j+k4cv1O6Eg8DPqVQAwSE=;
        b=bKddX07eAVYQB1xMLGajtY4hJmA6lXTLL85dRN6Wrvmt2Lcj+dNEEpSS1LchuSgu1b
         YvIsVsnw3ptB6CbpTXb0PaYKf4lcPtlCUdi9mDZP0Mxofi6XU82DpyR41OALgmRpi8Z1
         Vx9xwjIiOGyo3UhI66E0NQ0QjLYypKLzuFPGvegDGDHMlFVEWMy7wvC64U6GVmxuaH3T
         8e1xYai8F0qNuLQpqN75WGVHa4Fq+8JmbHym1BVkhu8GwNqTHy/5lP5U4+4V8OQjK2vB
         tAmtaFeszO270IS5P6Ek/GVEWrKo1ba+D1KY1hR6R+CBUorVnekJxWdkZizTkAzLrnAj
         STHA==
X-Gm-Message-State: AOAM533uMGfDYxXoahYr37HZEZx8+lmCeAjgbEV4aiqWG6W7M+VZt6Kd
        4rSM3C6WV4DYnj4nuMoxNGKDjw==
X-Google-Smtp-Source: ABdhPJxctp8yykVAH5m77mguBFeHwzX7L5NM4zae/H4TZ6naIDUbOu73XE1mL1v2bEfTgRcPiUsZVA==
X-Received: by 2002:a63:ab0d:: with SMTP id p13mr8248724pgf.327.1592842107791;
        Mon, 22 Jun 2020 09:08:27 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id o8sm4484095pgb.23.2020.06.22.09.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:08:27 -0700 (PDT)
Date:   Mon, 22 Jun 2020 09:08:24 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     bpf@vger.kernel.org
Subject: Fw: [Bug 208275] New: kernel hang occasionally while running the
 sample of xdpsock
Message-ID: <20200622090824.41cff8a3@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Begin forwarded message:

Date: Mon, 22 Jun 2020 10:13:52 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 208275] New: kernel hang occasionally while running the sample of xdpsock


https://bugzilla.kernel.org/show_bug.cgi?id=208275

            Bug ID: 208275
           Summary: kernel hang occasionally while running the sample of
                    xdpsock
           Product: Networking
           Version: 2.5
    Kernel Version: 5.7.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: goodluckwillcomesoon@gmail.com
        Regression: No

Distribution:
5.7.0-1.el7.centos.x86_64

Hardware Environment:
Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.1.7 06/16/2016

Software Environment:


Problem Description:
kernel hang occasionally while running the sample of xdpsock

Steps to reproduce:

I want to test the rx performace of AF_XDP. I change the nic to 4 queues by cmd
`ethtool -L p6p1 combined 4`, then I will create 1 socket for every queue.

for ((i=0; i<4; i++));
do 
./xdpsock -r -z -i p6p1 -m -q $i &
done

I run the xdpsock in samples/bpf using the shell command above.
And occasionally the kernel hang, so I have to power off and on.

Additonal information:

-- 
You are receiving this mail because:
You are the assignee for the bug.
