Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7884229EE09
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 15:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgJ2OTw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 10:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2OTw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 10:19:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE529C0613CF;
        Thu, 29 Oct 2020 07:19:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y12so2967507wrp.6;
        Thu, 29 Oct 2020 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IG7tsLJmeRfHh6RhAZa+dQgZB0okc8aPFoAcBoJ4Rrg=;
        b=rpkj0Jc75yJkzo7xNX6lc0EksZSpF9MeOYniMB45rwEzzLCMwxAQPpDmyY7IhCFbxE
         Zw922+i3sidiSvYnZ8HossRSuxUVSDRMWCCpXsVQHe2OoXQqi4iG3leW8u12iTErdfpO
         4CLcho2aHQTCi9v2z0Pck4m+ZPvbVWvi84YCi4LecEkcnhssZ5HgYhAi35V+MAFaOFVs
         T6hYs4h7BEfZojdm6yKECBuWaieovAhiHKT81+AkM3TyazL4WbZgZz6Y/jlprCTo9giw
         0ZpRCBnS4s6h9Fbxwpr3G4JtQ7C/tlAAHd5PW6x61ySnXZuOsrG01jTjbZf8hhVcFAD1
         G/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IG7tsLJmeRfHh6RhAZa+dQgZB0okc8aPFoAcBoJ4Rrg=;
        b=VXYJqNE56ZWWuWiAsQd6GPyQGOWyCyoopIEvvxDh4RBH2YXAlE3exnxyz+Yee9RDV3
         8l2SRm2sxNVSie0pbgbASwADB7tif8iGYuKCgj1nV+re6kqmapB071+OZAL7J2o6rp6U
         78AZAuGg4JnGIVlMj/zdAZuW6XiBKTTgl8zzloANttJ85V/32k60vcYw6Nb42nKUWZwj
         +UKRE2kaMraV+b8dD3cXf/dPgCHn25/ZxlYs+3AE0NMTRy7NoviXyXwfilQVNcBYHOF1
         7WEm1p45lPa7a7a3Z6GsU/HFUNzmAiuY1M5kybophD/EWplvoQtedke4lky9DtCt87av
         m93A==
X-Gm-Message-State: AOAM533gpEMR0ynf6a/mqQJTdYWGt34mk93EkEn0js2faWaQOR3IPi3b
        W3YdblGPFBAS5XbZRf2CImc=
X-Google-Smtp-Source: ABdhPJySnfrnD0+l5dneed6fFIU3+/0xpO41ctDgfWTaEnqrPyFvDhe+3nU9GLoPc83nDDVqmBg11w==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr5816557wrq.193.1603981190393;
        Thu, 29 Oct 2020 07:19:50 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id x21sm6413570wmi.3.2020.10.29.07.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:19:49 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <0de41eb1-e1fd-85da-61b7-fac4e3006726@gmail.com>
Date:   Thu, 29 Oct 2020 15:19:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Jann,

On 10/29/20 2:42 AM, Jann Horn wrote:
> On Mon, Oct 26, 2020 at 10:55 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>        static bool
>>        getTargetPathname(struct seccomp_notif *req, int notifyFd,
>>                          char *path, size_t len)
>>        {
>>            char procMemPath[PATH_MAX];
>>
>>            snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req->pid);
>>
>>            int procMemFd = open(procMemPath, O_RDONLY);
>>            if (procMemFd == -1)
>>                errExit("\tS: open");
>>
>>            /* Check that the process whose info we are accessing is still alive.
>>               If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performed
>>               in checkNotificationIdIsValid()) succeeds, we know that the
>>               /proc/PID/mem file descriptor that we opened corresponds to the
>>               process for which we received a notification. If that process
>>               subsequently terminates, then read() on that file descriptor
>>               will return 0 (EOF). */
>>
>>            checkNotificationIdIsValid(notifyFd, req->id);
>>
>>            /* Read bytes at the location containing the pathname argument
>>               (i.e., the first argument) of the mkdir(2) call */
>>
>>            ssize_t nread = pread(procMemFd, path, len, req->data.args[0]);
>>            if (nread == -1)
>>                errExit("pread");
> 
> As discussed at
> <https://lore.kernel.org/r/CAG48ez0m4Y24ZBZCh+Tf4ORMm9_q4n7VOzpGjwGF7_Fe8EQH=Q@mail.gmail.com>,
> we need to re-check checkNotificationIdIsValid() after reading remote
> memory but before using the read value in any way. Otherwise, the
> syscall could in the meantime get interrupted by a signal handler, the
> signal handler could return, and then the function that performed the
> syscall could free() allocations or return (thereby freeing buffers on
> the stack).
> 
> In essence, this pread() is (unavoidably) a potential use-after-free
> read; and to make that not have any security impact, we need to check
> whether UAF read occurred before using the read value. This should
> probably be called out elsewhere in the manpage, too...

Thanks very much for pointing me at this!

So, I want to conform that the fix to the code is as simple as
adding a check following the pread() call, something like:

[[
     ssize_t nread = pread(procMemFd, path, len, req->data.args[argNum]);
     if (nread == -1)
        errExit("Supervisor: pread");
 
     if (nread == 0) {
        fprintf(stderr, "\tS: pread() of /proc/PID/mem "
                "returned 0 (EOF)\n");
        exit(EXIT_FAILURE);
     }
 
     if (close(procMemFd) == -1)
        errExit("Supervisor: close-/proc/PID/mem");
 
+    /* Once again check that the notification ID is still valid. The
+       case we are particularly concerned about here is that just
+       before we fetched the pathname, the target's blocked system
+       call was interrupted by a signal handler, and after the handler
+       returned, the target carried on execution (past the interrupted
+       system call). In that case, we have no guarantees about what we
+       are reading, since the target's memory may have been arbitrarily
+       changed by subsequent operations. */
+
+    if (!notificationIdIsValid(notifyFd, req->id, "post-open"))
+        return false;
+
     /* We have no guarantees about what was in the memory of the target
        process. We therefore treat the buffer returned by pread() as
        untrusted input. The buffer should be terminated by a null byte;
        if not, then we will trigger an error for the target process. */
 
     if (strnlen(path, nread) < nread)
         return true;
]]

> Now, of course, **reading** is the easy case. The difficult case is if
> we have to **write** to the remote process... because then we can't
> play games like that. If we write data to a freed pointer, we're
> screwed, that's it. (And for somewhat unrelated bonus fun, consider
> that /proc/$pid/mem is originally intended for process debugging,
> including installing breakpoints, and will therefore happily write
> over "readonly" private mappings, such as typical mappings of
> executable code.)
> 
> So, uuuuh... I guess if anyone wants to actually write memory back to
> the target process, we'd better come up with some dedicated API for
> that, using an ioctl on the seccomp fd that magically freezes the
> target process inside the syscall while writing to its memory, or
> something like that? And until then, the manpage should have a big fat
> warning that writing to the target's memory is simply not possible
> (safely).
> 
>>            if (nread == 0) {
>>                fprintf(stderr, "\tS: pread() of /proc/PID/mem "
>>                        "returned 0 (EOF)\n");
>>                exit(EXIT_FAILURE);
>>            }
> .

I'll think over some changes to the text of the manual page.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
