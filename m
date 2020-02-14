Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A412C15EF71
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 18:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbgBNRr4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 12:47:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39214 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389163AbgBNRrz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 12:47:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id c5so7498609qtj.6;
        Fri, 14 Feb 2020 09:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+bcYUOrw2Ec/4DtIbHXNA+UE0pkCSGSt87LCFpCLwo=;
        b=mGUWL5x5/ddWeJndVHUtzpNm4U3UwftZq3hvLy8lPhOLA7bneN33HuW16QXONzF1RZ
         bcO9orAA7CDhhTsxYwVjKtHj+Cm4oZd9C7t0DfgonqYm7iEh7Dhwq7iEzMPTawnDmMr7
         nMGOOQqkE0jfRwwCZVTmxuuPuhlaGfEz2wCyA6cCgvb1SpQ6eqOdZ+PmOSzU3+uUej/b
         QevI9N8IfO7NNBkO8t40aScYabPZRAzrC1lNEVfu7nlRwDqRwSnhDrvbVXEXTuyl+aP+
         s5hhCSZ7pajQhDU4F8XHELnoLqSSTHnQBkp4GUPdybENcwfsDvaz8FqGIGpHiIXFJHmx
         4pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+bcYUOrw2Ec/4DtIbHXNA+UE0pkCSGSt87LCFpCLwo=;
        b=sjxvWTm/nnCsGZKe9/B89Fri7h92ZLXkH0NcHYedc0raOr6TjuMeTs/iL/TmRnovfs
         xJ1EKwMFZ1lH7JrzYHZjPwP8vuRe+k/5wIRwEDq1ie26StFYtVhFimJETHcQ19OvaCLK
         LS61wi0l+KFotIkts4O7Xp6dqjDCRpndKcArtd6Ac4NBsH7OVe9BXwi5aeoJSEoA8lhN
         /lpEJL/SNDcu5HvSUeG/3hi95DGlrEX7379zN7z9fL3rUQS0RB7P6Kw8lqM7oBtdwmua
         qTFyecoETnR6qVqMMQPmXjIbe5vtScJDjav7Lll1nu5a53HrFaLrwW+x4Vvv2EFi8sFD
         kZ/Q==
X-Gm-Message-State: APjAAAXsK4vHf482/y2aG2+bMFNcjcwQ5NdL/8sqSIvPqVMAix4pmSOk
        vdvTPr9o+t3WbLw/NDigzf8OXd9OXsPQuw2y9pU=
X-Google-Smtp-Source: APXvYqzehCXpsoVGV8M2tbw+6jU4FpDwGO7PhmOV64EuR2joOSQ/4HR4OlLBjVv5MgRZM1cs03RZCLRBRMF0AFF8dBY=
X-Received: by 2002:ac8:5457:: with SMTP id d23mr3349919qtq.93.1581702474041;
 Fri, 14 Feb 2020 09:47:54 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZfGXHL36ntjkQsTTEEa9yzqnS=Xs4XCibejpo5AKGpuQ@mail.gmail.com>
 <C0LP269G4WO4.1Q4M8CK4K92SU@dlxu-fedora-R90QNFJV>
In-Reply-To: <C0LP269G4WO4.1Q4M8CK4K92SU@dlxu-fedora-R90QNFJV>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Feb 2020 09:47:43 -0800
Message-ID: <CAEf4Bzb7n+RGfKHP0ik7M6P7WGHke3FzsoLmuUmrEYmzK_Neog@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next RESEND 2/2] selftests/bpf: add
 bpf_read_branch_records() selftest
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 13, 2020 at 11:05 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Tue Feb 11, 2020 at 11:30 AM, Andrii Nakryiko wrote:
> > On Mon, Feb 10, 2020 at 12:09 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> [...]
>
> >
> > > +       /* generate some branches on cpu 0 */
> > > +       CPU_ZERO(&cpu_set);
> > > +       CPU_SET(0, &cpu_set);
> > > +       err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
> > > +       if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
> > > +               goto out_free_pb;
> > > +       /* spin the loop for a while (random high number) */
> > > +       for (i = 0; i < 1000000; ++i)
> > > +               ++j;
> > > +
> >
> >
> > test_perf_branches__detach here?
>
> Yeah, good idea.
>
> [...]
>
> > > +struct fake_perf_branch_entry {
> > > +       __u64 _a;
> > > +       __u64 _b;
> > > +       __u64 _c;
> > > +};
> > > +
> > > +struct output {
> > > +       int required_size;
> > > +       int written_stack;
> > > +       int written_map;
> > > +};
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> > > +       __uint(key_size, sizeof(int));
> > > +       __uint(value_size, sizeof(int));
> > > +} perf_buf_map SEC(".maps");
> > > +
> > > +typedef struct fake_perf_branch_entry fpbe_t[30];
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > > +       __uint(max_entries, 1);
> > > +       __type(key, __u32);
> > > +       __type(value, fpbe_t);
> > > +} scratch_map SEC(".maps");
> >
> >
> > Can you please use global variables instead of array
>
> If you mean `scratch_map`, sure.
>
> > and perf_event_array?
>
> Do you mean replace the perf ring buffer with global variables? I think
> that would limit the number of samples we validate in userspace to a fixed
> number. It might be better to validate as many as the system gives us.
>
> Let me know what you think. I might be overthinking it.

Yeah, I meant get rid of perf_buffer and just use global variables for
outputting data.

re: validating multiple samples in perf_buffer. Given you don't really
control how many samples you'll get and you check nothing specific
about any single sample, I think it's fine to just validate any. They
are not supposed to differ much, right? Checking that size is multiple
of perf_branch_entry size is pretty much the only thing we can check,
no?

>
> > Would make BPF side clearer and userspace simpler.
> > struct output member will just become variables.
>
>
> Thanks,
> Daniel
