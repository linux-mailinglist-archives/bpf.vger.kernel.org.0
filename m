Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF381107773
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2019 19:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfKVShv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Nov 2019 13:37:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37500 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVShu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Nov 2019 13:37:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so6250323lfp.4
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2019 10:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NitHMqVMZzGkU6OL65RAGhyW8Cw9TGp4WDAn7alazzw=;
        b=XCNa0N7anqQXlD+o/bM0xoBTLWwjdbJJkcTVFLHYVoGRzBJwh4UKOyiUEHlBCggNy1
         086ihaRi4bK0f2kpYnHVx5BSW/0RBOl7lrCvRiOmSdwul7Mdr5a7ZeDznbxlH0Y2qfHm
         PJFpUg0qJXu7cvRIVAi0wgYBoEyVyly3xrUPlQn5zxxj1C/IsD2qJX+Z/qvFRzU/Gb2u
         7IBWbuYwevgqLa+syaXEi59eLiLDnDGdekkuvL3yDBmtdKzyd4N83QfGCa2GIVnQbTJq
         hghcw3IrdGhU6Kmrba0ztWXPFFj0QLl/Ph0rlJbU2LjYJWYBopPT8h2T+8O9J2FvTjTx
         vGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NitHMqVMZzGkU6OL65RAGhyW8Cw9TGp4WDAn7alazzw=;
        b=aPeDKSho06pqDaaI+jRgONCevdHeldFkKPv2eG+pLmT+Ci4tjhEmi9xz+kpYGrUKUM
         F8GxwR0P6NxaPiernu2o+Ob1Lr72iS82qxkWp0XOzwVZM3E74yFgVlQ6sH0BKSVo1yv9
         OjZenJDE230FIi9xdWYQDpztQ2QzqoGZZcb0ilmEsBllJfJTx6w7lIOybwRp12DJhDyp
         GzeY0Qd5R7aCvdqzwAnl/hA+NlXG0faDabwfBTrCOnxxAlS/QTOo5ErecG7PvZKPSdFA
         1nu30MIoozAgrWBi4SOVahaGYYGsLwqVG/vQkg9cpswzspKCJq3AjJSb1AW3oj6Gv06A
         CuHA==
X-Gm-Message-State: APjAAAVfisor/LCAhZELihfusptrA159a99zMzxBp/26qTxu0oSbaBwp
        G8V5PSJE3YQampbjB1gIqfVEViCpWePkaJL3kCfkDQ==
X-Google-Smtp-Source: APXvYqwFrewNREjvBZpIVuCu5dDzI6c5Kkq0ZCs0JHwdYk/rLSSIU2VAiF35rxmJmGi51XWMuzVpI5ifX6G0Ug/d4Ys=
X-Received: by 2002:a19:9149:: with SMTP id y9mr13404336lfj.15.1574447868658;
 Fri, 22 Nov 2019 10:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20191121170650.448973-1-yhs@fb.com>
In-Reply-To: <20191121170650.448973-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 22 Nov 2019 10:37:37 -0800
Message-ID: <CAADnVQJWAvjMsGA2GrdZv1ZCh1z_yeHky-hpy7K5E4XAeyEntQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: provide better register bounds after
 jmp32 instructions
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 21, 2019 at 9:08 AM Yonghong Song <yhs@fb.com> wrote:
>
> With latest llvm, bpf selftest test_progs, which has +alu32 enabled, failed for
> strobemeta.o and a few other subtests. The reason is due to that
> verifier did not provide better var_off.mask after jmp32 instructions.
> This patch set addressed this issue and after the fix, test_progs passed
> with alu32.
>
> Patch #1 provided detailed explanation of the problem and the fix.
> Patch #2 added three tests in test_verifier.
>
> Changelog:
>   v1 -> v2:
>     - do not directly manipulate tnum.{value,mask} in __reg_bound_offset32(),
>       using tnum_lshift/tnum_rshift functions instead
>     - do __reg_bound_offset32() after regular 64bit __reg_bound_offset()
>       since the latter may give a better upper 32bit var_off, which can
>       be inherited by __reg_bound_offset32().

I fixed white space damage and adjusted subject line of patch 2.
And applied to bpf-next. Thanks
