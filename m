Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11EB5B7E01
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2019 17:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbfISPU4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Sep 2019 11:20:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45026 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388060AbfISPUz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Sep 2019 11:20:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id u40so4655624qth.11
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2019 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0T6xN3ksPpSL90JcA8rv4rx/3ITzItUpKS+z4irSomk=;
        b=sm0KW63A/iP6ZjfvQAKNe8Q9DWLXLOwme13EEUD+xBZMilomAalTLcoa0Q3irGqLf3
         9S9yTSIe52Pv2nKbG64B0YcGHnJmysOrIKy9SlJ3nERhvkBFWWupDHCugaYuAWybsTS2
         U1AnIiCDY4EaodxQIvN6z5t8l4km9Eb5N6QDPUqUtGNwicumeDTfCPhXm74xCH5+Jgb/
         mV6lcLPy16ICvX3z3Hd8f828erpGXQr0jkp3VJaamJBaA7oIfgWy+nr3KOGfapO3PwYL
         aPpZjOkR7FMdVDztaFVN+OxEBBvWwFfyrGg3pb4fXwlY6x3VhtewHpOzRPrAtST0OM2m
         8D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0T6xN3ksPpSL90JcA8rv4rx/3ITzItUpKS+z4irSomk=;
        b=qUmf456w1bFcq43iFrnPykJ97FeRrsCXq4TjGj/OYRPwjlqToggAp+InVpDlqZfCZq
         aS8j0sV/HyA099u4fxIya14F+NZm9gJbqv8kStji7/AEfyK6QrFgUNUrQbxrvRHCzC9a
         7XKA4dDhtcNe/FqygJsr62eyXfRif/DHlImStQXK2pR9sRdZeuNBuV7vfqK+YLO2X3nX
         VF9KnA4OyRWBh4RW4FCybGnWH0IMNgI9NCpvXSLnVORjmIT03z/Y16hVX7vnf09sWTDL
         Z9uR+YxePqgwRdvYP70DLXBSMODqlZgr0jjT1LISAqcYoXbQV4P9pyElWlL3zkNr+P1g
         bClw==
X-Gm-Message-State: APjAAAX/HHvGgNH8jNYGZlVQvETdD4PGhX/RdOhVtl/FTDy2LoD4os82
        AY7ssTMQrXUtmFtt1bi6j+LMY2ZlJSpEbT6DlYRrSA==
X-Google-Smtp-Source: APXvYqyu42vyJgiMpYNfoTPRPkEOZeKCr/uEjZy4hreKSUZYahEUEDA5Y2fIhi4vRVGXRn7JDesnMh8l22SntLiEzCY=
X-Received: by 2002:ac8:4a8d:: with SMTP id l13mr3721351qtq.158.1568906454657;
 Thu, 19 Sep 2019 08:20:54 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Sep 2019 17:20:43 +0200
Message-ID: <CACT4Y+YNRgC2HJvH=xpRXMc2PBoXnWMZdoftEx8ZHAs4t1MhRQ@mail.gmail.com>
Subject: bpf syzbot coverage
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I've showed syzbot coverage of the bpf subsystem to you recently, here
are the links I promised to send. If you go to:
https://syzkaller.appspot.com/upstream
coverage reports are in the Instances table in the Coverage column.
Choose a one with more coverage, e.g.:
https://storage.googleapis.com/syzkaller/cover/ci-upstream-linux-next-kasan-gce-root.html
(but be aware it's a 200MB html with whole kernel source code embed).
Then navigate to kernel -> bpf to see coverage on bpf sources.

The most useful things would be to identify parts that are not
currently covered, but can be covered from user-space and extend
syzkaller to cover them:
https://github.com/google/syzkaller/blob/master/sys/linux/bpf.txt

Thanks
