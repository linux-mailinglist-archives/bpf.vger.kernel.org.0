Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E45C1BE198
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 16:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgD2OuB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2OuA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Apr 2020 10:50:00 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF40C03C1AD
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 07:50:00 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w14so1484807lfk.3
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=p0OnKApBgwQXBDePxncUckERzuw4qkE84UKaLYHlRM8=;
        b=rkgCnqM4/zGQl94l2VbFwrLbMopMVfO8JyIppy1IcEtihKPmuQocfd9zCdz+MPJcis
         MuGdIjoBfmRGk/RERBl/Xvr8Mxv/YMZtdkzIuVakipzQYfink62TKc4jiRxmuD8fVIAA
         yaSkIttyb72/eRqft++v8yF/3LbXKX8AZ0IJaDD6sldQ3GlzMrNWp/JlwkSVX+2Rsaxs
         5nKrRsJMmtwUcsohYTWySeTGR7E5vlgHRfhtMaFn/jlO4wOMoxaaVcljYaTIj4CkNJ/e
         GkhOF9tm8QB7YET403UN7nie6SQrI5hgbwKhk71KesICOHFtAKB2kLpIcYgD6mXw4WrE
         3wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p0OnKApBgwQXBDePxncUckERzuw4qkE84UKaLYHlRM8=;
        b=nU3TL//MC/JHc8ciY0PWJtXJST1jF7Gkm8ykDrebupcjLgAzr/6Yn+go6LtuVRCmn5
         3afIN+vzsBkRpn00bxSrnrHVG1J7cCZZ8OJRq77y4AZKJ8//g5RQtK7AKV2WP/YhgOp0
         pAkf/wV2eq3FAhsy8Uzre0PEoTrgbArCp5Zh6L4LZV48PEAzAqsKaVRkNiQeqKFWNDbB
         XE7DINCcTzjYJoJsMhuvsUirm6DAUIkgRKHL99KPpQZYxz7brDPxmPK3rbvQEzt/ThZT
         C0+vPX+jvl8TsWHebyrmLrWVCa4zEyMN592KcypJty+UMha2nG+5n0op7DRPnwoTIAE9
         HnAQ==
X-Gm-Message-State: AGi0Pubvid0Ao9N3N4s3Sa1Pcda2ryfCAUPfLtviCnugL1wVa0M6WQ9Q
        e+csEpYbjCIGXdLV1J9uDdtRra3Ww7MY4taGkV8Cpi5d9F0=
X-Google-Smtp-Source: APiQypKvx+IVKvB2Pf6s5uq9l7WbsQdkHlP7cMkA9PYC5n8wXttsI7+nu1cx7Lapz/BwkIYJp6hPM1FFMvzmj4/6w7E=
X-Received: by 2002:a05:6512:74:: with SMTP id i20mr23036233lfo.104.1588171798686;
 Wed, 29 Apr 2020 07:49:58 -0700 (PDT)
MIME-Version: 1.0
From:   Giulia <giulia.frascaria@gmail.com>
Date:   Wed, 29 Apr 2020 16:49:48 +0200
Message-ID: <CAFcc1YgBxQUKa=ySQ+XTOk1EkMwLKHc1yECLxuWnVTHoLoYMFg@mail.gmail.com>
Subject: bpf_override_return out of order execution?
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I'm experimenting with the bpf_override_return() helper for the
copyout function (using kernel 5.4) to the whitelist. (
https://elixir.bootlin.com/linux/v5.4/source/lib/iov_iter.c#L138 )
My goal is to avoid the buffer copy from kernel to user that happens
in copyout, so I'm calling  bpf_override_return with return value 0 in
a kprobe.

It works most of the times, but when I test the function with
relatively many iterations of a read from file I find that sometimes
the copyout is actually executed with the buffer being copied.

Below is an execution output with sample parameters and with the kinds
of numbers I usually find

The numbers match with debug printks in the copyout function that I
find in dmesg, so I'm quite positive that the function actually gets
called.

The counter in the bpf kprobe arrives to 10000 executions which is
what I am expecting, so the only explanation I have for now is that
the kprobe execution is reordered and executed while the copyout is
already triggered, and the instruction pointer does not get
effectively diverted on time in the bpf_override_return. Could this be
the case? Is there any potential security implication also for cases
outside of mine?

Any insight will be highly appreciated! Thank you for your time,
Giulia

---------------------------------------------------------
read size: 4096
iters: 10000

success: 9725
fail: 275

kprobe executed 10000 times
---------------------------------------------------------
