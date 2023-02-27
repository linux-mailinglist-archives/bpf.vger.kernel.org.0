Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762306A480E
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 18:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjB0Rck (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 12:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjB0Rcj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 12:32:39 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539DB241D5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 09:31:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ec43so28914577edb.8
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 09:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W+cBFXKUwfunYXOrk3L68gNpI6YeA4YkXLzftie5DiA=;
        b=mImuUyOyRDQmz7NqOkrAh6KCKVhzzjkbSA0UyaAmC3BUYW8Z+i2amDoI+r7MJtt4P+
         +uqCX+TPqiorMR38a3J833JPnwOUxoB/u43g8+0mbksO5IMlbNZakM4w6W4nJjqYksJV
         Ktgx099FH4P46hGzvF1gwmWakVvRe/npZ+rbc3ZdY5mhd8A0AOhmnoO6uLZfsBMeI5Op
         StRRfCgY0XLM05KLQyTacbezP5KH8dLEWME7TjNOkHnhvxhdUlLVb7k8abaNnFf/S2xi
         OWIbfhMDP2ydgCr/qDm2poKlFmhKn8vb6U3vHzzXAzl6dVTtBkUHmla2KjNuxeUerbuD
         1qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+cBFXKUwfunYXOrk3L68gNpI6YeA4YkXLzftie5DiA=;
        b=7E750GIQYK0h/2xTWtDUxk+EOjQMnoZNel3QMrOaLPL2j+RmBBC7kTw3K+y8EUUqJQ
         fSAez9+k9hSGcY6eEMTgl0FkAAjpdd+o8KSPGuohASA2IG76istLp7gQxKiZabJobCz7
         QdMjO5G28M+eIxGnPr0nI3DencHHHbgpVHj+Rj8LqjRyvr0+cyofFbpZPsFDEMU7Glh1
         r9802PjWPY1f6KYdSkLXYQc33n4UkRAHVSRqWhVM8eXV5IMY3Cx6TDctkfww4ZjZ5RVz
         F34CmCpqwQzwrdoi5Kx9/EFLBUCKQKdsbSIWpwX2vYWu+nrKbrsveHFCUU+MRfzqlGL0
         4zGQ==
X-Gm-Message-State: AO0yUKWgdlMGce3oObmI+F4yQkRQ0DOXrPbZNuQuSJ+9sT900hXddCHI
        zwz9tUi8T0WHf0+nafa8a7FhSMO6JvkaG3YQ4QE=
X-Google-Smtp-Source: AK7set/oDriCx4h98iNf9IAH5KNEiCyuMRbsIsFTJQQHSv0X5EZr1bZT77lpow4H54RFuqfI92nG57SaZjQISosbN/U=
X-Received: by 2002:a17:906:938b:b0:8a5:c8bd:4ac4 with SMTP id
 l11-20020a170906938b00b008a5c8bd4ac4mr14688967ejx.15.1677519110117; Mon, 27
 Feb 2023 09:31:50 -0800 (PST)
MIME-Version: 1.0
References: <Y/P1yxAuV6Wj3A0K@google.com> <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
 <Y/czygarUnMnDF9m@google.com> <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
 <Y/hLsgSO3B+2g9iF@google.com> <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
 <Y/p0ryf5PcKIs7uj@google.com> <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
 <693dffd9571073a47820653fd2de863010491454.camel@gmail.com>
In-Reply-To: <693dffd9571073a47820653fd2de863010491454.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 09:31:37 -0800
Message-ID: <CAEf4BzYaiD27y=Y85xhrj+VOvJY_5q1oVtg-4vYmFZFEpmW+nQ@mail.gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org,
        andrii@kernel.org, acme@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 6:17 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Sun, 2023-02-26 at 03:03 +0200, Eduard Zingerman wrote:
> > On Sat, 2023-02-25 at 20:50 +0000, Matt Bobrowski wrote:
> > > Sorry Eduard, I replied late last night although the email bounced due
> > > to exceeding the mail char limit. Let's try attaching a compressed
> > > variant of the requested files, which includes the compiled kernel's
> > > BTF and the kernel's config.
> >
> > Hi Matt,
> >
> > I tried using your config but still can't reproduce the issue.
> > Will try to do it using debian 12 chroot tomorrow or on Monday.
>
> Hi Matt,
>
> Short update:
> I've reproduced the issue with multiple STRUCT 'linux_binprm' BTF IDs
> in Debian testing chroot, thank you for providing all details.
> Attaching the instructions in the end of the email.
> Need some time to analyze pahole behavior.
>

Try using [0] to pinpoint what actually is different between any two
linux_binprm definitions. I've hacked up this "tool" last time I had
to pinpoint where two BTF types diverge, maybe it will save you a bit
of time as well. I'd like to put this functionality into btfdump
([1]), but I didn't get to it yet, unfortunately.

  [0] https://github.com/libbpf/libbpf-bootstrap/tree/btfdiff-hack
  [1] https://github.com/anakryiko/btfdump


> Thanks,
> Eduard
>
> --
>
> host root:
>   mkdir bookworm
>   sudo debootstrap testing bookworm/ http://deb.debian.org/debian/
>   sudo mount -t proc proc bookworm/proc/
>   sudo mount -t sysfs sys bookworm/sys/
>   sudo chroot bookworm/ /bin/bash
>

[...]
