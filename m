Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0FF22F883
	for <lists+bpf@lfdr.de>; Mon, 27 Jul 2020 20:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgG0SyC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jul 2020 14:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0SyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jul 2020 14:54:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8C8C061794
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 11:54:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id lw1so1592350pjb.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=h3cjF4iSEZv+fTA9U/ic+PIAxJZHp4XClFaXhZXBuH4=;
        b=SQvWXwIwiCPrgZljBHHA3MwrD4TQ/KEfxCwqS0tYnJxO3xCeQo1OALU6TcQbpznAcK
         9CJblvuPzOZfp46mSg0jaQ8SVyM4VRLJNx8PyXqBGxQulAbaigF4mCS32+DmfaHsbaK+
         niiPFjDvrS5GuSDuU1vCEq0U34Q6JMjJzarjagv5JTZj+kLg9kJ7i8miENrIFocfd1Mg
         +0Y9DdpayVA7HFfXFF6jdEJSQ0lmsMRZIWO+CNReWR7GadnRmiznMMjJq5l7lGRjOvAX
         AbET7VwlW5J629JdXUqX6n7akb68ybnMd77VZVVcuL+r/KXUH659hCPued5wNHUS0eM0
         pocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=h3cjF4iSEZv+fTA9U/ic+PIAxJZHp4XClFaXhZXBuH4=;
        b=jmo4JDjT1nNZXgpO0z+Hb53nrKHf0vnEKW6gQHwcd/NMW/2ytCaLLbfN2Wf2MVkvXN
         nJNUKSYPJCPsPyvpRyLWSdZg8vs/mGkKzDvYwW72NrxeeJb7fE+A5yZr7seKXk1GjXGX
         hatmwPCJHhK4kuejdHUveLb+kpb04IWq1qOEsnE3j6a+xegh4pOfwj0UvzEYOxAMG1hI
         T0IImrR/4iWZsvkqDFglnptcBgeFZFDKPYkAFUC9csmfdQRthvN3p67LEcDw6fQTubMu
         PmBihyUYbRk8trVarAVBaNJQvggqbBrI3FA/65De0tfM6iIS5aNltBiG+QKJ7Zzb5GsY
         tApg==
X-Gm-Message-State: AOAM531mEy4U+Pm2hfiFHs399EUWCSeYpz5F1Q8qma3oY/pQVHaUBGYR
        8ZsEzAOx+Ei64T+XB5kqAJAN9ZT9lvNIwQ==
X-Google-Smtp-Source: ABdhPJwE6QninAF6hxAg7h6PTDKWwHAO76b0rc1Z75UksLatFiJbKMtRl5McddIWOUcOANjlgEFjvw==
X-Received: by 2002:a17:902:64:: with SMTP id 91mr20659761pla.62.1595876040641;
        Mon, 27 Jul 2020 11:54:00 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id c3sm15858265pfo.203.2020.07.27.11.54.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 11:54:00 -0700 (PDT)
Date:   Mon, 27 Jul 2020 11:53:57 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     bpf@vger.kernel.org
Subject: Fw: [Bug 208709] New: bpfilter: write fail -22
Message-ID: <20200727115357.1c204951@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Begin forwarded message:

Date: Mon, 27 Jul 2020 18:39:15 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 208709] New: bpfilter: write fail -22


https://bugzilla.kernel.org/show_bug.cgi?id=208709

            Bug ID: 208709
           Summary: bpfilter: write fail -22
           Product: Networking
           Version: 2.5
    Kernel Version: 5.8.0-rc7-1.g786d3ff-default
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: kemal.kemal@unicam.it
        Regression: No

Created attachment 290623
  --> https://bugzilla.kernel.org/attachment.cgi?id=290623&action=edit  
output of dmesg

Hello Folks,

I have openSUSE Tumbleweed with kernel 5.8.0-rc7-1.g786d3ff-default.
During boot, my screen is flooded with these lines and booting process stalls
a minute or so:

...
bpfilter: Loaded bpfilter_umh pid 4425
bpfilter: write fail -22
...

It is specific to kernel 5.8.0-rc* series I believe as my 5.7 kernel on the
same
system does not do anything like that.
As hardware, I got Asus Prime TRX40-Pro + AMD Threadripper 3960x + Intel Wi-Fi
6 AX200 (rev 1a)

Let me know if you need further info.

Thanks...

-- 
You are receiving this mail because:
You are the assignee for the bug.
