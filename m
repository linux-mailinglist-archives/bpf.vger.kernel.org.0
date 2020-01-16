Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14DB13FB99
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 22:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgAPVcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 16:32:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43319 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388928AbgAPVcI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 16:32:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so24214340ljm.10
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 13:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pgfrlKWCSye7BCAkvG0/EhbwJql3BERc4KUSd7jQy2c=;
        b=NmFAQ03/6oGpywExVe4tRPqmo5hTEBsQ9qAXTNUL4148AFTXKb43mbFEL6DC4Ptlz2
         eWxo6Exx/T0HvrwCz+MFNcaiPxbM69O1fT4kKuKD9NVa/6KcAnY7CG+Xc8AVmn4EfG8N
         yOgewat/hsYHKFXFy7AskTuBfTiNSC2MsTDxAFgLH3ytgdJ5F6b86Gw7fDWTAx4s2Ca3
         Z1jo5WZVVTzbZjoSwZN7r+17NCiqDoSZuNkbG4J+kgTCKH0zlQ3mQ+sOMAR0f+g7eOLd
         Z2Cc09G9n5hs9LQ3rTZw4jr9f233FVzE6iGYn/FNE8JWiNNsyrdhLDJ0NFC1ea/knFiy
         tm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pgfrlKWCSye7BCAkvG0/EhbwJql3BERc4KUSd7jQy2c=;
        b=TYRV4Qvpzb7KJggtiMkyAC19cP3UA5CH7szRZ70WvbZ+P95sXimzwc+tM8UXlthbhY
         /faZUxns0X4kTu875e3r+Td4698Tac1GJ870GbTSDrZcfu+1FPRZRlhmawWhd387iXys
         9mh7YRaqzUwGBYfsvYt6VnWbczhv8Otvlaiqzqa2PWPirST8Tbq3iW1lLLHfeaZzU/JV
         QQzDbQrXWV+ItkpjbrckrA3ta6nbhLYUuqeq9ZNlC56wKNQis5DBdIn6YupUW/+cGJsB
         8Umbdcwl49T7guJWKGPAmsN447rbkBuFiBN4sT+gkkG6q+x/c+h5H2IgS+4pRFYmueRv
         JxZg==
X-Gm-Message-State: APjAAAXcjQICQDiuMF62oMefhy95g3WoNjsS6e15aNIWtIOwgMdP72f2
        fgu6JYpZiL97C2hu1DKSBpLwzRRcyCIDgNA31wI=
X-Google-Smtp-Source: APXvYqyXyDaX0SVEwrtwBSwNwK8yn5qQoat+dbBIXYT/B8flXVxZYDjDLu432+hgtgPPU8BfoKAsQ8iwZMGXakk1LXE=
X-Received: by 2002:a2e:8016:: with SMTP id j22mr3393143ljg.24.1579210325840;
 Thu, 16 Jan 2020 13:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20200116174004.1522812-1-yhs@fb.com> <CAEf4Bzbi0T5P=Dnja=pz3Nj0jhO9S+q_q1U4vfBwYP8enX+Zag@mail.gmail.com>
In-Reply-To: <CAEf4Bzbi0T5P=Dnja=pz3Nj0jhO9S+q_q1U4vfBwYP8enX+Zag@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Jan 2020 13:31:54 -0800
Message-ID: <CAADnVQJRD1Wb6rhwfx1Te6oyAfpAk_A8fuM7T5FPicv9Z7mckA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix test_progs send_signal
 flakiness with nmi mode
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 16, 2020 at 10:25 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 16, 2020 at 10:06 AM Yonghong Song <yhs@fb.com> wrote:
> >
> > Alexei observed that test_progs send_signal may fail if run
> > with command line "./test_progs" and the tests will pass
> > if just run "./test_progs -n 40".
> >
> > I observed similar issue with nmi subtest failure
> > and added a delay 100 us in Commit ab8b7f0cb358
> > ("tools/bpf: Add self tests for bpf_send_signal_thread()")
> > and the problem is gone for me. But the issue still exists
> > in Alexei's testing environment.
> >
> > The current code uses sample_freq = 50 (50 events/second), which
> > may not be enough. But if the sample_freq value is larger than
> > sysctl kernel/perf_event_max_sample_rate, the perf_event_open
> > syscall will fail.
> >
> > This patch changed nmi perf testing to use sample_period = 1,
> > which means trying to sampling every event. This seems fixing
> > the issue.
> >
> > Fixes: ab8b7f0cb358 ("tools/bpf: Add self tests for bpf_send_signal_thread()")
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
>
> Good not to have to rely on arbitrary timeout!

Indeed.
Applied. Thanks
