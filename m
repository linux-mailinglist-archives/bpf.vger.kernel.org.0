Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45026D84F3
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjDER3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDER3m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:29:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9F5BA1
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:29:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fi11so19442131edb.10
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680715774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdn8KMrSiB1IgemH3puwTQP9Sqw2F3CzslIzumoikiI=;
        b=STWtczUfuNAkoz9WGgqQprT4iysKcoY/+aMePsFCJRARd2v3NChTqvPVFk96mrbsS2
         eulB/BVaLfg75ky7gy8VNC24TblVgwhsyqvahMdS2M/UtR18YP9m8hUf5R8E00zizeUE
         5kHzoRViEfQnxk57l4uHQSCIjILnfqu91xfG0I8gkOw0x+cnZ0VziOZTX5hgktEC8DF0
         k6mfB3OTxgPGJLXwxlyqBkuBkqUURI+18/hbS3iRngHj0feN1y7SJKcnJApR/CS4raYQ
         92xMt1h/ckmmgzFXh3UH0UvghrvHMS17RBJ1WtYt51kVZyiHy71mHU7EFnW/tDA55jcD
         P6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdn8KMrSiB1IgemH3puwTQP9Sqw2F3CzslIzumoikiI=;
        b=jCqUdlxJdu4OSl2ztIl+EYanGagurWrjmm3HtUaCvmWe71lCwgkisZBIlD+ljhB8nX
         Z4qt+W378U3PFRUcNQ8ETsS1hbTI44IGnLeLHxriGkkkti1/jAGpy2fOgsBRPAh4m+zd
         kyLW6FyDEY8XW2eHv7gVzXlBXMEGAIE3snKY4wKp9ml6OVLoP/rQpT0d4Wbvya26en27
         OIsqRRt2xR2rONMN3rYhrmS0vqCmwCDV2vkqh2twqiwT+mBfS1ANNiQu3FRXsXNFgF0o
         eYqtNcVPv9nswHe3l/MUpa4Ak2KdMwjKTh41uas0iiyjXtd3ez8SvyO146KGSxzoqRQC
         TDPw==
X-Gm-Message-State: AAQBX9fpyZubdjzH7KJcNUo27crEWxs31fMbq02Lvtoq0sSDq/NVwQ5E
        tXUJSAoZTf2OdsUtACWBVq8nzy1ER8TIin4ah2vIZA==
X-Google-Smtp-Source: AKy350bWLoEmmYq/KNF+XU/SqKZk1XsnuOPE4MQt1fDk+wSbPefBIjdNYuu3ZylwqAfCYYR1BBurcIi3mlysHb4mubU=
X-Received: by 2002:a17:906:950a:b0:8e6:266c:c75e with SMTP id
 u10-20020a170906950a00b008e6266cc75emr2086247ejx.14.1680715774342; Wed, 05
 Apr 2023 10:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-4-andrii@kernel.org>
 <CAN+4W8jj9AJ785pO3zPh7_n7USdDjvjLgW1EgQ39MBpx08M_1w@mail.gmail.com> <CAEf4BzYOYVF1PZYnZUvTWkKTXVChvOjt6jCRBFBWhMDP4f295w@mail.gmail.com>
In-Reply-To: <CAEf4BzYOYVF1PZYnZUvTWkKTXVChvOjt6jCRBFBWhMDP4f295w@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 5 Apr 2023 18:29:23 +0100
Message-ID: <CAN+4W8hNvpuw-DhF5Eg+ZA98JwA6jGa9mGwUv9cUb+30M=GbOA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 30, 2023 at 9:48=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> So I'm preserving the original behavior, but I also think the original
> behavior makes sense, as it tries to keep valid string contents at all
> times. At least I don't really see much problem with it, do you?

Like I said I find offset calculations hard to follow and they are a
great source of bugs, especially in C. I believe terminating at the
end of the syscall would be easier to understand and less bug prone.

What is the argument for keeping valid string contents during the
syscall? Peeking at the buffer while the syscall is ongoing? How would
that work with a rotating log, where it's not clear where the start
and the end is? Another observation is that during finalization the
buffer is going to be in all sorts of wonky states due to the shuffle
trick, so we're really not losing much. I'll send a prototype of what
I mean.

> Hm... start_pos definitely is necessary due to bpf_vlog_reset() at
> least. Similarly, end_pos can go back on log reset. But second patch
> set simplifies this further, as we keep track of maximum log content
> size we ever reach, and that could be straightforwardly compared to
> log->len_total.

Now that I fiddled with the code more I understand start_pos, sorry
for the noise.

> I'm not following. bpf_vlog_append() would have to distinguish between
> BPF_LOG_FIXED and rotating mode, because in rotating mode you have to
> wrap around the physical end of the buffer.

My idea is to prevent rotation by never appending more than what is
"unused". This means you have to deal with signalling truncation
separately, but your max_len makes that nice. Again I'll try and send
something to illustrate what I mean.

> It's more verbose, so BPF_LOG_FIXED seems more in line with existing
> constants names. But note that this is not part of UAPI, user-space
> won't see/have "BPF_LOG_FIXED" constant.

Ah! How come we don't have UAPI?

> > This isn't really kbuf specific, how about just reverse_buf?
>
> kbuf as opposed to ubuf. Kernel-space manipulations, which don't
> require copy_from_user. I wanted to emphasize this distinction and
> keep symmetry with bpf_vlog_reverse_ubuf().

Ah, right. I think due to naming I assumed that it reverses log->kbuf,
due to symmetry with bpf_vlog_reverse_ubuf.

> Hm.. no, it is the rotation in place. Even if it was in the kernel
> buffer and we wanted to rotate this without creating a second large
> copy of the buffer, we'd have to do this double rotation.

I said that because in kernel space we could do
https://cplusplus.com/reference/algorithm/rotate/

> So each rotation reads each byte once and writes each byte once. So
> two copies. And then the entire buffer is rotated twice (three
> rotating steps, but overall contents is rotated twice), so two reads
> and two writes for each byte, 4 memory copies altogether. Would you
> like me to clarify this some more?

I think explaining it in terms of copies (instead of read / write)
would make it easier to understand!
