Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB074470F2
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 00:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhKFXUy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Nov 2021 19:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhKFXUx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Nov 2021 19:20:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37648C061570
        for <bpf@vger.kernel.org>; Sat,  6 Nov 2021 16:18:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c126so3907337pfb.0
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KA7psG7HBAZzMlq6d02Rq13qEhDqHzUzLpTfP7j+OBQ=;
        b=NxnQF3LLFzugm1w7n7aIiqvOnU2FDR5owmBVkXsOt8xVOSWtepN4Tt1dT5qh5w0ofS
         WrrEwWLrzeSWst8AIkFcxtXskma/ZDTB+SHeGTTdg3gMljhNqvoEExNsm/wyXjKAJ/Xd
         zuivOTMzjsZ1wjyIsOPc77vmnbYNTbcmO69BU9ws7Kv482DTuRVrFj8ChNRUMiGQKOhb
         aRvvIBG3WT8kErSniEHH8AtcvpxkLSJMUmxwvN5EboVd/2ztDZTYWAqz5HYXRAzCVKzR
         Phf8/J/Am6n9McXHNZZ1iPODAxGhEVwybvo7BmuEPVcREV6BqZCPtvBJ3opBRnmLZBVS
         fvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KA7psG7HBAZzMlq6d02Rq13qEhDqHzUzLpTfP7j+OBQ=;
        b=K9FAi31QHIAiD4K2+xBxh+tKa1MT2GND9TIH5MHxUfgX6YEKdOwwwEniuwIcHMgKSN
         MbOSsriewnRfDs2mlfQkq0YS1c/cRK9LoERfxnozn0sG/5NwmAX/OQAOb/F7dW+Twl4q
         FBD/Rp4cW2AcXP/D0sQbE2iNacoQ13oZtALD05zvN6ZgGLNE4GnUZto24rQ324K8zO56
         WQp4Edf56sBe4mnwjntpeqHFrlejvtcZg7W5Od1KhsRFIysQHNAxeDOQiXdyqXBbCzXK
         VSnHE3KfO9HILnyOngnIgIB9bfjcimdAg90YXOZMJTu2PU3crII2opqPTNdfZ3vdKCVV
         kHZg==
X-Gm-Message-State: AOAM530J98Fdgzp6Tg5hJ3foip+76bJV1Mb4BSC5NdmOWc4k/fcxKgb0
        Gy3/SScfLBQxjcDCXv5xhilWklZikIxXfJZpBoM=
X-Google-Smtp-Source: ABdhPJytfIVR4nJO+/5KJcKvAnWq/IJMvXwaxVl05tVV6Yle43zUoh6Q8Tlz4Jt4jYlS7CvlZXkBUnPXusAJRHpKLCg=
X-Received: by 2002:aa7:8b56:0:b0:44c:10a:4ee9 with SMTP id
 i22-20020aa78b56000000b0044c010a4ee9mr70546397pfd.46.1636240691711; Sat, 06
 Nov 2021 16:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211105191055.3324874-1-andrii@kernel.org> <CAADnVQJ6REFCJZYCLzk0NNqo5p9C5KpOmko9REaF1KYkBEaa9w@mail.gmail.com>
 <CAEf4BzaehmbFQ50tZrZYtC+cTe+XTPBs2KBEXsjnmsSHWBYoUg@mail.gmail.com>
In-Reply-To: <CAEf4BzaehmbFQ50tZrZYtC+cTe+XTPBs2KBEXsjnmsSHWBYoUg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 6 Nov 2021 16:18:00 -0700
Message-ID: <CAADnVQKRWwak8_T=UjD=aw3e5TB-bpg-4wd7mc0S=_DwZYOY-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix non-C89 loop variable declaration in gen_loader.c
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 6, 2021 at 12:56 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Nov 6, 2021 at 9:38 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 5, 2021 at 12:11 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > Fix the `int i` declaration inside the for statement. This is non-C89
> > > compliant. See [0] for user report breaking BCC build.
> > >
> > >   [0] https://github.com/libbpf/libbpf/issues/403
> >
> > I'd prefer to fix bcc and/or its derivatives instead.
> > It's year 2021.
>
> Fixing BCC and derivatives is a separate topic. This is the only
> instance of non-C89 compliant for() loop in libbpf and I'd prefer to
> fix it at the very least for style consistency.

Fair enough. Applied.
