Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE54A2FF784
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 22:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbhAUVoW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 16:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbhAUVnp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 16:43:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6E1C06174A
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 13:43:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id g12so4742591ejf.8
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 13:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2RuMyF4jWinUI0yazJhSDdwE9q4Kg4lEKtFudxWm10=;
        b=cvynqA9FltStjL9Fo3GvH8azLxgNVzGex08j5OrA35hcMScCLYIRdkqPG2y7n793WB
         B8HaDJh5DZ6ly8xOEpNfNmF9Ddb99sMmFFPr4zWX4iQpxx+2gOm3A3dNpHsUa+upqQk/
         Cped6Fh1lmP4Q5MSrqdhvGVXfaLBFQKFwo1CYFeIBsNd8wWplv55vAONMs5xy87j/Ajw
         WF1yCL1TglTLCa6Fbbg8Vs/Eifq7m6VFa+ecr+u6IitN+NERuR0XhPHboAw3rweAN1lt
         YcVKo3NVwmh7gBCd7IxqCoE32aYZ1OAqF737paR0YL3uTQREsgMQSwdQqB7NQgF76T+F
         VZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2RuMyF4jWinUI0yazJhSDdwE9q4Kg4lEKtFudxWm10=;
        b=J/M9Ai8xXoW5gvaxo1nPGoHg9z/y1SF4F3WUm7U1zUAuh83193Gx2PIb9ArZHCox0B
         uW0DANESsHFKQkCcUsELZ7rMpmsEub3Ae7xTfXXpra0FR6Rb1O4OA3mdsDNbIrVhkL6u
         M7p3oyaUffePR74vuk7Z+IZI4ySLdbYz3Zhpb0soh89WDBxy5Gk2O1MLWoRtTdc+edRE
         BcXf6dom1oeTE50+RxNJIQRMj5LCU4JreuEyR8xhye/w9u/5KAfzKchC7dsPsXpgsEaW
         mTTNCFu0uhhXX7XpqJ62tG3q0brANWFw+3Y0AQw+6r+de94ZJvcaOsL/AN2HqLwHXxtc
         9MzQ==
X-Gm-Message-State: AOAM532giX1V8iXriiyIY9ILd7eO2SZngd+7AQX8E7gwj3HClWk8TB0P
        QGY680SJ1OC+rcHsGckYUu6L/URSJ3jCGTieES0=
X-Google-Smtp-Source: ABdhPJyXwlWeV0sTOSfn6NHBA5Ih5L5FyJ8C0pCAQyGvBWsbmjQMFCWSJsarGYBs6CafGOrmr5a33JHxQ6bXhSQBNeE=
X-Received: by 2002:a17:906:704d:: with SMTP id r13mr953054ejj.43.1611265383363;
 Thu, 21 Jan 2021 13:43:03 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3ENW8FV=CsKFmvpqCvbwzz5z2dLmBzrsO9QePVPuyaxXQ@mail.gmail.com>
 <CAEf4Bzbd-_6m=u9m32c0-hZA=JMkNEC2yWgcs_02Nv4fxxmpfQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzbd-_6m=u9m32c0-hZA=JMkNEC2yWgcs_02Nv4fxxmpfQ@mail.gmail.com>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Thu, 21 Jan 2021 23:42:25 +0200
Message-ID: <CANaYP3E5L_Tw3Ra3KDBZr27wr9JAb=KbyGAuwBHDPoKMBHRbQg@mail.gmail.com>
Subject: Re: libbpf ringbuf manager starvation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        assaf.piltzer@cyberark.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 21, 2021 at 9:29 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jan 19, 2021 at 7:51 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> >
> > Hello there,
> >
>
> Hi,
>
> > When playing with the (relatively) new ringbuf api we encountered
> > something that we believe can be an interesting usecase.
> > When registering multiple rinbufs to the same ringbuf manager, one of
> > which is highly active, other ringbufs may starve. Since libbpf
> > (e)polls on all the managed ringbufs at once and then tries to read
> > *as many samples as it can* from ready ringbufs, it may get stuck
> > indefinitely on one of them, not being able to process the other.
> > We know that the current ringbuf api exposes the epoll_fd so that one
> > can implement the epoll logic on his own, but this sounds to us like a
> > not so advanced usecase that may be worth taking care of specifically.
> > Does allowing to specify a maximum number of samples to consume sounds
> > like a reasonable addition to the ringbuf api?
>
> Did you actually run into such a situation in practice? If you have a
> BPF program producing so much data so fast that user-space can't keep
> up, then it sounds like a suboptimal use case for BPF ringbuf.

Yes, we have ran into such a situation. Our userspace is far from
performance-optimal, but currently that is the best we have.


>
> But nevertheless, my advice for you situation is to use two instances
> of libbpf's ring_buffer: one for super-busy ringbuf, and another for
> everything else. Or you can even have one for each. It's very
> flexible.
>

Yes, that what we are doing currently as a workaround. thanks.


> As for having this limit, it's not so simple, unfortunately. The
> contract between kernel, epoll, and libbpf is that user-space will
> always consume all the items until it runs out of more items to
> consume. Internally in kernel BPF ringbuf relies on that to skip
> unnecessary epoll notifications. If you consume not all items and will
> attempt to (e)poll again, you'll never get another notification
> (unless you force-notify from your BPF program, that's an advanced use
> case).
>
> We could do a round-robin across all registered ringbufs within the
> ring_buffer instance in ring_buffer__poll()/ring_buffer__consume(),
> but I think it's over-designing for a quite unusual case.
>

Yes, I agree it is not worth redesigning the entire ringbuf processing
implementation for this usecase. but we thought adding another parameter
will be simpler - thanks for clarifying the difficulties.

>
> >
> > Thanks
