Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6319B95F
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 02:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbgDBAJg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Apr 2020 20:09:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35836 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbgDBAJg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 20:09:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id k21so1401717ljh.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2020 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2zCDanlb805Hy1usViRfiz/uoZcbCtBK51goo7ofEA=;
        b=H2uI99HxfayEM1VzmvS0pNKItcm1B3S7FhxfKSaU3wUoYEGk8K/qw3OZDGWE0oIYct
         OtjQkuCrNnWXUA7O6xNaPKC6dLeAKOh8BGWYvONIL0NA+EbSaZOPqviD9uMYo2BBQpv3
         wHsbbKhinW6zJEM4bL0zHUwLw6S2A1PHkN7K92YGomD3ldPmyvkrUutgd5woYsyYQF83
         JVSsApSCP6TW0RZ1y0vUVeZM4dXoL6D5wvh3fdqaMxKqCVusq+zOCGbIMGASNmGHcp4w
         5ir481tyS2QFp0WjpwIZ73AixtRg9I00pZnlqcnJPvrSSQgweGJ3VP1xHhkfxbaoTc5A
         y8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2zCDanlb805Hy1usViRfiz/uoZcbCtBK51goo7ofEA=;
        b=jvr9SZRUdeWGrZH4e482RVFhN7n+oPbsyjmZ4He0TlTFxG4/C21FqSYa3HkfW3Vqgp
         0DdW9I09etEz26yOHeDkDOqoOGMJMKALNSmUI801I0CxtCoXQumA9A7vl8PERvC46zKl
         cnE3XR4RhCR6vaDPo4vFAUW1ejVag96t5ALfIwmPReZnWVBCMYrYWvL8XJVXJlpRemzo
         gzMANUQmtqQARPwAWMvkZv5slKscR9LHjamlpQjpKMLRROsP8TkFP9cSPxYfqZtpdcBz
         oAPZxwIblKHAaUYrVI+JBByNoqv0XXy9+8ZEOBY60USdvlJ9FWCg1SG2g//GQcKagO5R
         FjmQ==
X-Gm-Message-State: AGi0PuaDAZVQX8Cp2+bjzRL8q4xHuoyg9FykexpNyxenBQqBZJgX+uie
        VBNJPnLstdNafA+dVeAlhi4jmcJWU0B+yItZIwA=
X-Google-Smtp-Source: APiQypKCsuzpjVvgrzVB8hgCBqV6F17jxwD5shDsH1nVfuTJa7PfQfan+kVQSHU/yt3oET8L9UmeXfEOlp8ZzOHcypo=
X-Received: by 2002:a2e:5ce:: with SMTP id 197mr425204ljf.234.1585786174547;
 Wed, 01 Apr 2020 17:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200329004356.27286-1-kpsingh@chromium.org> <20200329004356.27286-8-kpsingh@chromium.org>
In-Reply-To: <20200329004356.27286-8-kpsingh@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Apr 2020 17:09:23 -0700
Message-ID: <CAADnVQKP3mOTUkkzjWM6Qii+v-dCDwV9Ms_-4ptsbdwyDW1MCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 7/8] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 28, 2020 at 5:44 PM KP Singh <kpsingh@chromium.org> wrote:
> +int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
> +            unsigned long reqprot, unsigned long prot, int ret)
> +{
> +       if (ret != 0)
> +               return ret;
> +
> +       __u32 pid = bpf_get_current_pid_tgid() >> 32;
> +       int is_heap = 0;
> +
> +       is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> +                  vma->vm_end <= vma->vm_mm->brk);

This test fails for me.
I've added:
        bpf_printk("start %llx %llx\n", vma->vm_start, vma->vm_mm->start_brk);
        bpf_printk("end %llx %llx\n", vma->vm_end, vma->vm_mm->brk);
and see
cat /sys/kernel/debug/tracing/trace_pipe
            true-2285  [001] ...2   858.717432: 0: start 7f66470a2000 607000
            true-2285  [001] ...2   858.717440: 0: end 7f6647443000 607000
            true-2285  [001] ...2   858.717658: 0: start 7f6647439000 607000
            true-2285  [001] ...2   858.717659: 0: end 7f664743f000 607000
            true-2285  [001] ...2   858.717691: 0: start 605000 607000
            true-2285  [001] ...2   858.717692: 0: end 607000 607000
            true-2285  [001] ...2   858.717700: 0: start 7f6647666000 607000
            true-2285  [001] ...2   858.717701: 0: end 7f6647668000 607000
      test_progs-2283  [000] ...2   858.718030: 0: start 523000 39b9000
      test_progs-2283  [000] ...2   858.718033: 0: end 39e0000 39e0000

523000 is not >= 39b9000.
523000 is higher than vm_mm->end_data, but lower than vm_mm->start_brk.
No idea why this addr is passed into security_file_mprotect().
The address user space is passing to mprotect() is 0x39c0000 which is correct.
Could you please help debug?
