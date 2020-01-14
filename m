Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7688C139EA8
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 01:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgANA7J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 19:59:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39148 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgANA7J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 19:59:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so10608561qko.6
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2020 16:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ilw5UVn34Wk5ckHaAOdyc8sEVD4lrgJFgFroOO7NKmg=;
        b=TDKaZO9vjZdlJWN/v1eBtIJkzo7OnmKbdilzYPrzn4XO/xY6hTwqyrIsFjwzlKul3S
         IQMJZs2GEpMa8mPrgFbWltZWieRyVXxCMLs/jQ8T8q0Xcqi0GOFn2yudOOiMuHDIvLBH
         Nf9NR/N/7rQ0SVWLVuo45od1MSBguhRMCl2buoHVBL8YnACPbXBhe3a2TMLG2P2tDD+W
         xxion5u6caFnjbUPDS60tyeYxf5S/wRqjOl18Bk171YNmkuqT5L6fPr5L1tKB8ELvPt5
         83jbzv/wEG3uYWE4o7PkMVcAWupsiyFJhS8GHgeR1Ku1a8NcVpVBTsHDZu224FnNykEF
         ZcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ilw5UVn34Wk5ckHaAOdyc8sEVD4lrgJFgFroOO7NKmg=;
        b=t1k65bYhYMF9aYWb8VGtfZio3OuMq0AMLPlmKynKCmxJr9Yz+XPmPSmEuMaycniy2J
         M75DXNQSAAWgeVLqjrQDCRVoAzcpxOc84GqqIKUl/1CyZdOaZY7qSGxJ+vWPAHg3xCcS
         wMjEhPfvoC/e7zPy8QBNfrFpoaGyZv968nUeeBUuFbgtn/f5BX2UD+qk+yaUthuUSAR+
         eqVjWnIVjPkekJMILW0Lh2r+fXtivY5nqLL+4xZPaLsBtjYLdRLXP6lSJIZXH21rTzBN
         09Zjnb+riSfd6/AfEa9kDQCnFeh/CB9CBWK7w5ddkL7Vz0G88g+Xt8zKuEue5UDllZVa
         hVIA==
X-Gm-Message-State: APjAAAUWVmBPS4CQEQtPPZzUeJQkyEqkkd3jpWSG/40ABkSh3bI14UYb
        Td2h9yk61i1jfUJUTw8GT0RbSs64z+5H5dcUC3WQfw==
X-Google-Smtp-Source: APXvYqx6H+XPNah2639NFb6zuZ6+G8W36EguZ4N4UU7D2HlEpUePujvAFzdJzdUUcJ8ZxamqFpfL03zixAManPomphg=
X-Received: by 2002:a37:e408:: with SMTP id y8mr19056376qkf.39.1578963548297;
 Mon, 13 Jan 2020 16:59:08 -0800 (PST)
MIME-Version: 1.0
References: <20200110011557.1949757-1-yhs@fb.com> <20200110011558.1949832-1-yhs@fb.com>
In-Reply-To: <20200110011558.1949832-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Jan 2020 16:58:57 -0800
Message-ID: <CAEf4Bzab0S_cXb3sJNaOFZ7gSrp8u5Y2Q+dmA4BWrqiXmYx7Gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_send_signal_thread() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 9, 2020 at 5:16 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
> added helper bpf_send_signal() which permits bpf program to
> send a signal to the current process.
>
> We found a use case where sending the signal to the current
> thread is more preferable.
>   - A bpf program will collect the stack trace and then
>     send signal to the user application.
>   - The user application will add some thread specific
>     information to the just collected stack trace for
>     later analysis.
>
> If bpf_send_signal() is used, user application will need
> to check whether the thread receiving the signal matches
> the thread collecting the stack by checking thread id.
> If not, it will need to send signal to another thread
> through pthread_kill().
>
> This patch proposed a new helper bpf_send_signal_thread(),
> which sends the signal to the current thread. This way,
> user space is guaranteed that bpf_program execution context
> and user space signal handling context are the same thread.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/uapi/linux/bpf.h | 18 ++++++++++++++++--
>  kernel/trace/bpf_trace.c | 27 ++++++++++++++++++++++++---
>  2 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 52966e758fe5..3320f8bdfe7e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2714,7 +2714,7 @@ union bpf_attr {
>   *
>   * int bpf_send_signal(u32 sig)
>   *     Description
> - *             Send signal *sig* to the current task.
> + *             Send signal *sig* to the process of the current task.
>   *     Return
>   *             0 on success or successfully queued.
>   *
> @@ -2850,6 +2850,19 @@ union bpf_attr {
>   *     Return
>   *             0 on success, or a negative error in case of failure.
>   *
> + * int bpf_send_signal_thread(u32 sig)
> + *     Description
> + *             Send signal *sig* to the current task.


This all makes sense and looks good, but I think it's very unclear why
the distinction between sending signal to process vs thread. Could you
extend bpf_send_signal and bpf_send_signal_thread descriptions
explaining the difference (e.g., that, according to POSIX, when
sending signal to a process, any thread within that process can get
signal delivered, while sending to a specific thread will ensure that
that specific thread will receive desired signal).

[...]
