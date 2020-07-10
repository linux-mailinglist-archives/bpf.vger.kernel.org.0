Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD621BCB3
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 20:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgGJSCJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 14:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGJSCJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jul 2020 14:02:09 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0508EC08C5DC
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 11:02:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 80so6131596qko.7
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yxdaYmWJ0NOnnWA41QhRZei2OHy9OJlGdk0eX4KhIqY=;
        b=A+xitfHqgRcALn30pGssizM+A0fU8PUkNc1jPHW9yiekcEEkn2mg2h8qAcmgSSSGvP
         vEvqOj7EAGlXGl8hilNqYlmMtP+cSeoO04WHU9ZsxfpBJPEOD9tXJ6L90nJ8cWJA96tD
         oyIpbr+qO6LWVyw0j4nkDDKV7I4m1t8u4v1DNwOwew3G/TxWbda1mHMF80LoZwm5QciT
         VC62HJMXDBaTuFWs1J9mQUPFEuBGuZfe9bO4Fl5iKPPfll6G0CvPFMYHcGwnln9FgjQB
         KWYfOwJzyGstO6JFZ743/VP+qgbz8c4UippRscT4oGuXXZEQiqyBSJxdgc1BGX5zaN9s
         47gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yxdaYmWJ0NOnnWA41QhRZei2OHy9OJlGdk0eX4KhIqY=;
        b=CQ+5gMNws1+SnzxlGlkDhjJEmOPujXfyjjwQ49lZnehhRvT8/OdtaPttR9HbEyy+dx
         KTcrLOab2pcG9yilw8th258+efWx49E2eLmufIIfgbeB+hdW2yYmYprZe3YjcKLdjLNz
         mXLvoUol6jkx8CoTLv8ggoEPbveJky3pzt2G4DfPDTzoZRrUiGi4kOYGtfOagT3tLJ9N
         P3X1aZy+VWP+9+Nygmv+8hR22YWJIDC725vtdIFdv2W1m1FLhmIh17qh6zz6XyRiT33B
         3VSH1H8300t9lqqbp1+G8GZP7as1HtpQOX3OIvQGnmLNEbZCGK2lqytoe7LskUgQlTLx
         Q7ww==
X-Gm-Message-State: AOAM531/u8O3DngcMzeVUOxR3QnYMp2QPkOoaZWU91WPCt2fGogNU/6D
        wVhNeW45REaXJdvtkQHNo1VfSrW+k4etWYUCYkQYG2Ez7Uk=
X-Google-Smtp-Source: ABdhPJyqsV2rVO5ZPvJNVMZnhV/ul/MKOpsRteyPoUY+1vpMwP/RhctFl40Qf+F02qInDTt8XCCYFyPbwbJuaheb4j0=
X-Received: by 2002:a05:620a:1666:: with SMTP id d6mr71887405qko.449.1594404128242;
 Fri, 10 Jul 2020 11:02:08 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Jul 2020 11:01:57 -0700
Message-ID: <CAEf4BzY0-bVNHmCkMFPgObs=isUAyg-dFzGDY7QWYkmm7rmTSg@mail.gmail.com>
Subject: Occasionally hanging sockopts selftests
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Stanislav,

I've noticed that on 5.5 kernel libbpf Travis CI test runs
occasionally fail due to selftests hanging indefinitely. It seems like
it always happens after sockopt tests succeed, and while
sockopt_inherit test is running. Doesn't seem like the latest kernel
is affected (I haven't found hangs for the latest kernel in recent
history).

This is the latest version of selftests, but running on an older (5.5)
version of kernel. So whatever fixes went into selftests are there
already. So I wonder if there were any kernel bugs that were fixed
already but could cause hangs on 5.5?

I can disable that specific test for 5.5, but though I should bring
this up first, just in case there are still some bugs in selftests.

Thanks for checking!

Two most recent failures (not that they are helpful, because there is
no output until tests completes, but still):

  - https://travis-ci.com/github/libbpf/libbpf/jobs/359067538
  - https://travis-ci.com/github/libbpf/libbpf/jobs/359784775
