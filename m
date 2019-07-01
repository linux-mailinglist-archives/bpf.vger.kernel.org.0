Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D113E5BFDD
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfGAPbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 11:31:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38308 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAPbu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 11:31:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so15082114qtl.5
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9jbxWj6SxeQ3mVgE1kQKY6HJSzByQk2Ta82QUJZf9g=;
        b=K2rDKUnvNV2Dg8FkKQSIHKp05lowzxWX8+I6riLviYSBEd1GbwurP2bzhSfSLe1IOG
         jkXjdgRuPBxrI2b7HqGAe/CHzHY3JDF387o3V73LI1RVf5Mq7ptBFytcgq5svnI9PBGY
         eAvA/I2rOcwXSk1qKzFLxYnuBV5eNVxFYZqI4E/gum2oooh+RyCDengdEvnPUjm3w67N
         DHGcM0APf3U7EHgQY3h7xvn20H0N6CrhEbQNf+DuAEtt4whzSEG2WYOn/nkARcmcZDmt
         ypIKcb/OMxe8ljOz0UGqwjna7Sn0zeYJah3yBgh6kB3ZtjTTlY9JOhSmwxm5OBJfm4pX
         sDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9jbxWj6SxeQ3mVgE1kQKY6HJSzByQk2Ta82QUJZf9g=;
        b=mpP+AVY9hjpczZXRUexkx593yaQ+og1jSMRI1071eq/1mBAyRgEQETXWOYy8jBv13x
         HStvAFwgH84QHcinkmvatV6nCTsXe/S9TIqk5oe6yQKnPGY93TatIxZIiwpV6I+B+VbY
         5xgoctbqyplpYhHPmcx6YPMj+l8XLtPH8yH8dEzZdmBylDJD1zE/EdTzyJMLEQtqWva4
         zH6jxzcpGl/ex6k60476GYkRQe2NK7ZtHUDZQKt2AL8mAyd5NHipajPFWFMqBXaIADAx
         P1eDPD6NQ++BztL2wKEfCekmyxgjB9JJUIwphQ3KA20QKSJfvBEeh0/TQ42lD1uiw6zj
         9RSQ==
X-Gm-Message-State: APjAAAUGVb7RWbKJvv93nqRbs4EqyWDlzWdQSmqTigGlRePrQwbpj0eY
        mb65gxcQwmD78DqDdjctza2h9VXgkEH+6MPJF1zmJ/pPOUo=
X-Google-Smtp-Source: APXvYqxh910T8Lo8ClGAGjG6Xe7F7fUh0qQw8oOFtxNS/ZzOlF+XuwOAVKNxf8xm8DMny0KEYSHEfa/wal+L7uFst3Q=
X-Received: by 2002:ac8:2fb7:: with SMTP id l52mr19800297qta.93.1561995108802;
 Mon, 01 Jul 2019 08:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190627091450.78550-1-iii@linux.ibm.com> <CAPhsuW5ToikpcEbJjC+JsxWSjgUBHKS97=hiTmt1EHmC9HFb8Q@mail.gmail.com>
 <2EA9DD60-A922-4056-8775-3F556B9A0087@linux.ibm.com>
In-Reply-To: <2EA9DD60-A922-4056-8775-3F556B9A0087@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Jul 2019 08:31:37 -0700
Message-ID: <CAEf4Bzb3BKoEcYiM3qQ6uqn+bZZ7kO2ogvZPba7679TWFT4fmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: do not ignore clang failures
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Song Liu <liu.song.a23@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 1, 2019 at 1:56 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> > Am 28.06.2019 um 22:35 schrieb Song Liu <liu.song.a23@gmail.com>:
> >
> > On Thu, Jun 27, 2019 at 2:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> >> index f2dbe2043067..2316fa2d5b3b 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -1,5 +1,6 @@
> >> # SPDX-License-Identifier: GPL-2.0
> >>
> >> +SHELL := /bin/bash
> >
> > I am not sure whether it is ok to require bash. I don't see such requirements in
> > other Makefile's under tools/.
> >
> > Can we enable some fall back when bash is not present?
> >
> > Thanks,
> > Song
>
> I think checking for bash presence would unnecessarily complicate
> things.  What do you think about having separate targets for
> clang-generated bitcode?

Do we still need clang | llc pipeline with new clang? Could the same
be achieved with single clang invocation? That would solve the problem
of not detecting pipeline failures.

But either way, I think .DELETE_ON_ERROR is worth adding nevertheless.

>
> Best regards,
> Ilya
