Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B45C1E851D
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 19:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgE2Rho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgE2Rhl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 13:37:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5BC08C5CB
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 10:28:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so74394pfd.6
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lD0hXFyWKhZ6W5LcbqmMvVt0Vx29w4b18D1aGpFG7Y8=;
        b=fHFrtQ81saDSd65LwEzP9UDbpXKadcBC320p/BfajoBqPn9vtoAogT4bfOVHI9QbW7
         6Tj2b/qzJ4ofCFkApb8ZpVBXlFxnh/BmtuOlcINhTgTJIIkELixi1aKTAg78/5nYK5ha
         s7EKfyEc2ujmj9KHalGx/+9e+KXWuKh1msiuro2VK0Gi7++6NWOO+13Ag+NbEf6TUdS7
         50TaZ+V31tsg9FkGb+7BRbQyXFeazCMNYAUBHX7cq5oG9YKESNv1bHJIOtwj/uk9zMYg
         ue1JPMkkPOfIm1ZPhs5XApWyLVwIBPDcJcfb8g5Q97E/uR1JEPMkkjvcnz4J+fEw/E0I
         ueww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=lD0hXFyWKhZ6W5LcbqmMvVt0Vx29w4b18D1aGpFG7Y8=;
        b=sTMRht0eKzWx7ze5AS3Hx1Olc6AruVxcVbWxjULQQJPk1pZ2zPWXoJPIlxOuLAdAAE
         h6vg7mfoEGA2Bxp3zWn9e9oDSxGdoIw8cwdAmMX6SYzHX2MoCnnqnlQLe/QsjTouAYj+
         3AlzqXnHGdA75f+xxW/NNo/7s7/Dlf57uUjKkYr7LOeV/m5dQqxzpkbdbqbbmrag+IPF
         gF5bHCCajHJGS49tD2hVZwP9ewsKhm95ik9Db+uEW+/LhKttr0zNEND0RYqQmkjbvkVx
         orEA79haQlSA96uupjSsvZvb9HGvU9CVllSD6Alm75OVQFQORnuCA5/C1x1Xsd2S5FPa
         YC+g==
X-Gm-Message-State: AOAM530FrcvHJu0boc5hEpWc0+iLAFW4MQw5ZsN+99GBemrPS7dSrtHI
        l+g+eIU2wNaNcumN8ZjXK7g=
X-Google-Smtp-Source: ABdhPJwe4AVkJtUgK9h2MyK3OsNEt8L2qAlGES9M0mDnD+mYy//wdwkDyq8vCNuyN//kTQ80N/9okw==
X-Received: by 2002:a63:7a52:: with SMTP id j18mr9027907pgn.295.1590773313715;
        Fri, 29 May 2020 10:28:33 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id j7sm7773721pfh.154.2020.05.29.10.28.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 10:28:32 -0700 (PDT)
Subject: [bpf PATCH 0/3] verifier fix for assigning 32bit reg to 64bit reg
From:   John Fastabend <john.fastabend@gmail.com>
To:     yhs@fb.com, alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, john.fastabend@gmail.com, kernel-team@fb.com
Date:   Fri, 29 May 2020 10:28:21 -0700
Message-ID: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These add a fix for 32 bit to 64 bit assignment introduced with
latest alu32 bounds tracking. The initial fix was proposed by
Yonghong and then I updated it slightly and added a test fix.

@Yonghong feel free to add your signed-off-by back if you want
or at minimal a ACK would be good.

---

John Fastabend (3):
      bpf: fix a verifier issue when assigning 32bit reg states to 64bit ones
      bpf, selftests: verifier bounds tests need to be updated
      bpf, selftests: add a verifier test for assigning 32bit reg states to 64bit ones


 kernel/bpf/verifier.c                         |   10 +++--
 tools/testing/selftests/bpf/verifier/bounds.c |   46 +++++++++++++++++--------
 2 files changed, 37 insertions(+), 19 deletions(-)

--
Signature
