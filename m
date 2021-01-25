Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD16C302CFE
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 21:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbhAYUwx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 15:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732356AbhAYUwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 15:52:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD05C061574
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 12:51:52 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id w1so19952121ejf.11
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 12:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=LTBh5JmS5pDh7Ty7v5crv6w7oym5llV9+JtbW/BkYTY=;
        b=BAEO0e5qhUJDB54NWUkHUDBTiso3A5ZhM9tyGYZBRhNuhSu73uVzOoyiIDDWTpQ0RP
         rOg1idZLILP1Zr13tjzLgRcloyBV8Mo7ClwOqx/Q/RzYQgk99dNrdnbWg5lqmEIXd5QA
         77FCM39Cmj1Cc+eP+thm6oQu1C274BDFppEGYxhQTMwwKr7qF/rwLgMd63869sHA0W+t
         N73Pj3mUCy7QhKQFE2/QggKhuEKqN/6gbjh/ZOpGssOWla8IdGuuxHtNFz0ZYtityZc1
         dFEwoSCyiBJzifBlz4z0fiKVHA6vvL/RbiK3mcv1MhvvYMEmRxaYph24zBmv3r5+bdso
         xqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LTBh5JmS5pDh7Ty7v5crv6w7oym5llV9+JtbW/BkYTY=;
        b=JAj8H0wodjAinBShjDlRPQ8eheJwHbF9sOpFmm6hAmyg0eurO2ruEUsgGJa4tKFjob
         20PWPugZJDCAOv5PO9OH+JYYL/mi86QTzfVRINJMJvO+GKyIFgDhH+RfcGrYMS6/8Bt5
         UAKcIVkZD6agMJxVWKrEj9sGSTauiPBpZef42VCH2uEA55jBtxTuz1IzfbTTeyaAdBsN
         cEcwOV04xcKCTexLPntpZ3DDOVqoV43LBzbJm5FMD1qc6acL2YDmg5o1MbQW2Q3VLbqC
         rEeNoNYS/OqiC8dfAnK5+sIjHQXfj8ygUaEMdran2k+gKtLzcKJHp5BTLyuuGDR4s3QF
         ArhA==
X-Gm-Message-State: AOAM532B8X4O3+udyUij2uncL9gnmphtH8qYwhyJg3WWppc5uc4hVF3U
        1NuxUOmsezm5D94AkfdRgUAbC/ujTAcPmNHbGkbYA7CkOqC0KkA=
X-Google-Smtp-Source: ABdhPJzeRLETZGpFHr7f5iZtL+u/MQPLigYbJ9Lyo7SGzIlJ8iLD6DAGm287CHreozIDobtMyk+EQv5tTNyu/PBTm1w=
X-Received: by 2002:a17:907:c01:: with SMTP id ga1mr1426271ejc.488.1611607910323;
 Mon, 25 Jan 2021 12:51:50 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Jan 2021 15:51:39 -0500
Message-ID: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
Subject: selftest/bpf/test_verifier_log fails on v5.11-rc5
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello all,

My apologies if this has already been reported, but I didn't see
anything obvious with a quick search through the archives.  I have a
test program that behaves very similar to the existing
selftest/bpf/test_verifier_log test that has started failing this week
with v5.11-rc5; it ran without problem last week on v5.11-rc4.  Is
this a known problem with a fix already, or is this something new?

% uname -r
5.11.0-0.rc5.134.fc34.x86_64
% pwd
/.../linux/tools/testing/selftests/bpf
% git log --oneline | head -n 1
6ee1d745b7c9 Linux 5.11-rc5
% make test_verifier_log
  ...
  BINARY   test_verifier_log
% ./test_verifier_log
Test log_level 0...
Test log_size < 128...
Test log_buff = NULL...
Test oversized buffer...
ERROR: Program load returned: ret:-1/errno:22, expected ret:-1/errno:13

-- 
paul moore
www.paul-moore.com
