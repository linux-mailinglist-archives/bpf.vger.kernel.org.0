Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9DA6D85A1
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 20:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjDESE3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjDESEL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 14:04:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D2872B6
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 11:03:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-500349a5139so3292469a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpHAcs27Ve484lak5oLy20kAuFVSzKVSzNbCBJeOX60=;
        b=mKjwIREtHBsNCDOBhb/4/dCRQzhPrOOUbkWBd+Kh0/u1J7+OYcB2YhT00wYdzn8ITu
         L3EnoTUg2cLRqpew1YcFjqBMK/zgfXcNvok3XD8qSazQ+Ykf5Ie/nLVkT1Pow0V4b6PX
         PJzRQq0mftA/3j4yBYl2h5ei2QpQdDBTkwla4QC1SAkYncAYjJmmqHgWgljZw1la6P/b
         TTELvdLFqPAFCm3XM3Hq6p2UHjQxP6mrn6+lm3WRCuZWlaeDvEIfVVQfDBTQQatPUt7p
         CKnqFaK1YXKOYtGGAGyEmq23OZ8mX8+Lb1FMw3P/o4mD4e4VzJDWVXvZG+x4uF4oW4ml
         ESsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpHAcs27Ve484lak5oLy20kAuFVSzKVSzNbCBJeOX60=;
        b=o2r6byripcuieAPf0PTsvRshF5UlGsAjaes2P8SuteN+wc3o60ow820f3xZyAOIdTg
         Q6dFioQ9QNweIcVtBACnxrzX260TRg0VyBRH9Himh10vUfRV6gXjVte+RzUn7nZ7hRyM
         gIb3bWCWiqggAy4jjLZ2WMW6aCleleqEGu36CJFuSc4P4PNPt9KiUzXU2Gz3IwC3Tysr
         B8+qjEY7zlYR/+tQZQAT9CUvNsh/1voD7KU+lk+X+WxKhZk/qp4jwCAyCL0qgXxaElNA
         hgq9yD+j4it9x6manPfx0FKQmDJsRWvafsvbHb1s8kqsA/EJPamghcqHYRpmxFq4pE9i
         3jDA==
X-Gm-Message-State: AAQBX9cafstivoSWeG1mJdcBhoNBD53jboBBhYAHe+khuygfuijFlN1h
        rlNEoX1OEt3aGnjaCX+MYTt72xqtRi/4mN27qi8=
X-Google-Smtp-Source: AKy350b1JqLdoAmYMIQLzU+15eVOnfK0pnGi7wOJW63vdZ9WKuvlNP+8wXqap9Y7Jc8axElsc7B3dOKwwp1iQ9VXJck=
X-Received: by 2002:a05:6402:2744:b0:502:6e58:c820 with SMTP id
 z4-20020a056402274400b005026e58c820mr1946706edd.1.1680717792458; Wed, 05 Apr
 2023 11:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-4-andrii@kernel.org>
 <CAN+4W8jj9AJ785pO3zPh7_n7USdDjvjLgW1EgQ39MBpx08M_1w@mail.gmail.com>
 <CAEf4BzYOYVF1PZYnZUvTWkKTXVChvOjt6jCRBFBWhMDP4f295w@mail.gmail.com> <CAN+4W8hNvpuw-DhF5Eg+ZA98JwA6jGa9mGwUv9cUb+30M=GbOA@mail.gmail.com>
In-Reply-To: <CAN+4W8hNvpuw-DhF5Eg+ZA98JwA6jGa9mGwUv9cUb+30M=GbOA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Apr 2023 11:03:00 -0700
Message-ID: <CAEf4BzZBK_0V-djZBP=4nOmd6YmoEKwaHDAHWvzTJGGJ8RS-vw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 10:29=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> On Thu, Mar 30, 2023 at 9:48=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > So I'm preserving the original behavior, but I also think the original
> > behavior makes sense, as it tries to keep valid string contents at all
> > times. At least I don't really see much problem with it, do you?
>
> Like I said I find offset calculations hard to follow and they are a
> great source of bugs, especially in C. I believe terminating at the
> end of the syscall would be easier to understand and less bug prone.

I mean, form my POV there are no complications to always sending full
strings with zero termination. But I'll check your code and see where
the simplification comes from.

>
> What is the argument for keeping valid string contents during the
> syscall? Peeking at the buffer while the syscall is ongoing? How would

I don't know. This actually helps during debugging kernel itself, as
we know that contents forms valid C string, so debug-dumping this
would be a bit easier. I'm past that point, thankfully, but still.

Another benefit is that even if we forget to finalize properly in one
of the error handling code paths, we still end up with valid C string.
But again, I'll take a look at your code.

> that work with a rotating log, where it's not clear where the start
> and the end is? Another observation is that during finalization the
> buffer is going to be in all sorts of wonky states due to the shuffle
> trick, so we're really not losing much. I'll send a prototype of what
> I mean.

I'll take a look at your prototype, thanks. Not that I'm looking
forward to redoing this part of the code, of course, but oh well, have
to do my due diligence.

>
> > Hm... start_pos definitely is necessary due to bpf_vlog_reset() at
> > least. Similarly, end_pos can go back on log reset. But second patch
> > set simplifies this further, as we keep track of maximum log content
> > size we ever reach, and that could be straightforwardly compared to
> > log->len_total.
>
> Now that I fiddled with the code more I understand start_pos, sorry
> for the noise.
>

No worries, this is part of the reviewing process.

> > I'm not following. bpf_vlog_append() would have to distinguish between
> > BPF_LOG_FIXED and rotating mode, because in rotating mode you have to
> > wrap around the physical end of the buffer.
>
> My idea is to prevent rotation by never appending more than what is
> "unused". This means you have to deal with signalling truncation
> separately, but your max_len makes that nice. Again I'll try and send
> something to illustrate what I mean.
>

Ok.

> > It's more verbose, so BPF_LOG_FIXED seems more in line with existing
> > constants names. But note that this is not part of UAPI, user-space
> > won't see/have "BPF_LOG_FIXED" constant.
>
> Ah! How come we don't have UAPI?
>

Historical reasons? I'm the wrong person to ask.


> > > This isn't really kbuf specific, how about just reverse_buf?
> >
> > kbuf as opposed to ubuf. Kernel-space manipulations, which don't
> > require copy_from_user. I wanted to emphasize this distinction and
> > keep symmetry with bpf_vlog_reverse_ubuf().
>
> Ah, right. I think due to naming I assumed that it reverses log->kbuf,
> due to symmetry with bpf_vlog_reverse_ubuf.
>
> > Hm.. no, it is the rotation in place. Even if it was in the kernel
> > buffer and we wanted to rotate this without creating a second large
> > copy of the buffer, we'd have to do this double rotation.
>
> I said that because in kernel space we could do
> https://cplusplus.com/reference/algorithm/rotate/

Yep, byte-by-byte makes it easier. Blocks make it significantly harder
due to no common alignment.

>
> > So each rotation reads each byte once and writes each byte once. So
> > two copies. And then the entire buffer is rotated twice (three
> > rotating steps, but overall contents is rotated twice), so two reads
> > and two writes for each byte, 4 memory copies altogether. Would you
> > like me to clarify this some more?
>
> I think explaining it in terms of copies (instead of read / write)
> would make it easier to understand!

Yep, I adjusted this comment in last version, mentioning number of
copies, thanks.
