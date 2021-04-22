Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8465B368417
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 17:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhDVPqf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 11:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbhDVPq0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 11:46:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD41EC061366
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 08:44:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j4so33400876lfp.0
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hyFiUvpnYR/YCt5ur9aidpVEDU1fslnEtXvgoVuBY1o=;
        b=n4QfrB4VrRgFHd1OSFumM7+/5oc9XLrnlT4bRg1Z5MGIlkQ8iTiB/wbHxWm59OqChf
         3P5LvNzK1oI1PMr7nehXD32xwc13T+DZzbqBRKJkNvU3dadsmwRQzgMBY1Z1guOLu2fT
         8PK2qF3TfTA4c12jvyO12XBq41C1IBeeLW45f1Llo3nKhePOOBeu9l4WM5aOAwAdvous
         MqXk7l6AfJfKI507ddyl+n56PU/dC2jx0hlkZjT6bJbC5NaPiN3tv4OW1/WE1BJ9l6xz
         bgYB4rbmHQZUiA1njmAhDY7BV8GVmV1R0ZlRkIXeFU2Kxw/OseR7378y1fJlsnEf3RrI
         PbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hyFiUvpnYR/YCt5ur9aidpVEDU1fslnEtXvgoVuBY1o=;
        b=luOMp2hCqL8n9xb03/uuJcsD2GwgTGKMEQvdN8gfbmTDj/uYbByoJJgURSM6ToFvji
         ooUTjCQzYdru9pCXhIvyCvahx0oIx1JzkBj643TjTodYx/SzW8uj/oxB1ROTWSq6bKeD
         QTaYqvHWLnjWc5uS46+za3Pt27MOru/CA1GiVuTfdkysh+rAcEaOwyscJIvbWJp5yQNa
         4XCctCfR9Pnnnb+ikCKFsO9lm94916TqTFnJTbKKBvkwFJbkB2+n5PCCmAR9i8F5KddY
         FUcIxnc9+c+rDqnLu9CjGTmvbUc0dobzG8GBW/r1/VPnXthFYC3qG4NP6stloCGq1Lgu
         DxWQ==
X-Gm-Message-State: AOAM533cyQgz48/9UuTfF3PCZqsVMXUvk37k1btkVgUXGEEtO7seOtSy
        BU8qNH/LsAZEL+PELiezx35js6hph1FBydxTu8emBHj0Gh1DOtGS
X-Google-Smtp-Source: ABdhPJwfc15F+Noxc9hE4Tzd8vNNjwqlAZ1Da6qggHAXPCca8nEbNkAOoRESus4f+9Hr8Ek2E9P27BvTGdLUkLAReHY=
X-Received: by 2002:a05:6512:3984:: with SMTP id j4mr3094919lfu.38.1619106244012;
 Thu, 22 Apr 2021 08:44:04 -0700 (PDT)
MIME-Version: 1.0
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 22 Apr 2021 11:43:53 -0400
Message-ID: <CAOWid-eY4CHZw01d9w3KC0qpodWmTXfQqLopkNFVNwZhmCYgMQ@mail.gmail.com>
Subject: bpf helper functions from kernel module
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

From https://www.collabora.com/news-and-blog/blog/2019/04/15/an-ebpf-overview-part-2-machine-and-bytecode/
"The BPF-accesible kernel "helper" functions are defined by the kernel
core (not extensible through modules) via an API similar to defining
syscalls"

Has there been interest/discussion around having helper functions from
kernel modules?  Going through the code, I am guessing one of the
obstacles is to have the verifier checking against helper functions
that may or may not be available but I am not an expert of the
subsystem.  What are the current opinions on having helper functions
from kernel modules?

Regards,
Kenny Ho
