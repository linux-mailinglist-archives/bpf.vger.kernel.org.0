Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D532A142C
	for <lists+bpf@lfdr.de>; Sat, 31 Oct 2020 09:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgJaIby (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Oct 2020 04:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgJaIbx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Oct 2020 04:31:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD30C0613D5;
        Sat, 31 Oct 2020 01:31:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k21so4792730wmi.1;
        Sat, 31 Oct 2020 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwESmo+bSPSmTJDiKLpcaTLVBvMkudbYKi/iPkEZuo8=;
        b=nkyMxNmlnja8d0utNiobAlC4APn36Pl708MmnUPDMdFITVDcTP0XnCiIKIoA9yzYaU
         wXdw6yDDz4ty8XvOekZa1GvefK8dZWlMygC4GqGlxg/oQgsGuTak+dYWNQcAYNgx/Ba9
         EoMNa6AjxR7UucvurifKIpJABa8QxBHbigOF5Iw+9ENXAFbDHLBGMavfXDh5ckqy+zzo
         vdrYs91S5MTyLvzq9EJ1c8CkntthSXWkhqqojnBJiPYU0B7OkNsK3SiVzFaN0mf3BTP8
         Nti50Bb9ju841uiOilMhCEhjU05s6oDIDuhx1uDOk9Abq0HyhiS6LqkWPm7DnBasEEFm
         0PdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwESmo+bSPSmTJDiKLpcaTLVBvMkudbYKi/iPkEZuo8=;
        b=ZFEwG/UO2dHW2CmCb+kBEcWbMs4mEFR2vdLXMXLxP5OuEZFVaEFQSUdyT3wn149yBO
         EG7JPv8QlrRMy7oL0lOHNPxmwiquqLAPuD1/eB8GnKR+6d2NopEdI64VXP6EYZIgMVjn
         /lzKXrg6Nl54rBRfKu8GUEUev0FUuybCw2iQ/710qPAKYi9ocSepaQU+YAd+hEa7qyhx
         c4TcgdEpInNhXPMjAKhvsToLyN2KhkGgujEvEOz8pzSfKY6yzGTumvf31n9OaumyL+mh
         jZKxGQaAHA+4koydqzdQVtZeWnZj3G8z8kVBmQmFIk3cNmboWd7iLsAXct+3UkoSz4I1
         Exlg==
X-Gm-Message-State: AOAM531s0VgRtFwumfeukNA/yChB+HcE5wXcJOOHyb6tiO7vxc44YLyA
        V9IAiov0WdjWunWKbtAvW136LF5qaQI=
X-Google-Smtp-Source: ABdhPJzI04cLpRhHAbCXpntnIa72kZwXW3SoQdziwX2vZGAsDt8H5Ev+5h0mLvDdEjRUbGa4wcdOtw==
X-Received: by 2002:a1c:8087:: with SMTP id b129mr7036629wmd.10.1604133111490;
        Sat, 31 Oct 2020 01:31:51 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id t12sm14001675wrm.25.2020.10.31.01.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 01:31:50 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.pizza>,
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
To:     Jann Horn <jannh@google.com>
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com>
 <0de41eb1-e1fd-85da-61b7-fac4e3006726@gmail.com>
 <CAG48ez3qKg-ReY4R=S_thQ6tOzv2ZHV=xW5qBxpqs0iSjH_oFQ@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <9f9b8b86-6e49-17ef-e414-82e489b0b99a@gmail.com>
Date:   Sat, 31 Oct 2020 09:31:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez3qKg-ReY4R=S_thQ6tOzv2ZHV=xW5qBxpqs0iSjH_oFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/30/20 8:14 PM, Jann Horn wrote:
> On Thu, Oct 29, 2020 at 3:19 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>> On 10/29/20 2:42 AM, Jann Horn wrote:
>>> On Mon, Oct 26, 2020 at 10:55 AM Michael Kerrisk (man-pages)
>>> <mtk.manpages@gmail.com> wrote:
>>>>        static bool
>>>>        getTargetPathname(struct seccomp_notif *req, int notifyFd,
>>>>                          char *path, size_t len)
>>>>        {
>>>>            char procMemPath[PATH_MAX];
>>>>
>>>>            snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req->pid);
>>>>
>>>>            int procMemFd = open(procMemPath, O_RDONLY);
>>>>            if (procMemFd == -1)
>>>>                errExit("\tS: open");
>>>>
>>>>            /* Check that the process whose info we are accessing is still alive.
>>>>               If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performed
>>>>               in checkNotificationIdIsValid()) succeeds, we know that the
>>>>               /proc/PID/mem file descriptor that we opened corresponds to the
>>>>               process for which we received a notification. If that process
>>>>               subsequently terminates, then read() on that file descriptor
>>>>               will return 0 (EOF). */
>>>>
>>>>            checkNotificationIdIsValid(notifyFd, req->id);
>>>>
>>>>            /* Read bytes at the location containing the pathname argument
>>>>               (i.e., the first argument) of the mkdir(2) call */
>>>>
>>>>            ssize_t nread = pread(procMemFd, path, len, req->data.args[0]);
>>>>            if (nread == -1)
>>>>                errExit("pread");
>>>
>>> As discussed at
>>> <https://lore.kernel.org/r/CAG48ez0m4Y24ZBZCh+Tf4ORMm9_q4n7VOzpGjwGF7_Fe8EQH=Q@mail.gmail.com>,
>>> we need to re-check checkNotificationIdIsValid() after reading remote
>>> memory but before using the read value in any way. Otherwise, the
>>> syscall could in the meantime get interrupted by a signal handler, the
>>> signal handler could return, and then the function that performed the
>>> syscall could free() allocations or return (thereby freeing buffers on
>>> the stack).
>>>
>>> In essence, this pread() is (unavoidably) a potential use-after-free
>>> read; and to make that not have any security impact, we need to check
>>> whether UAF read occurred before using the read value. This should
>>> probably be called out elsewhere in the manpage, too...
>>
>> Thanks very much for pointing me at this!
>>
>> So, I want to conform that the fix to the code is as simple as
>> adding a check following the pread() call, something like:
>>
>> [[
>>      ssize_t nread = pread(procMemFd, path, len, req->data.args[argNum]);
>>      if (nread == -1)
>>         errExit("Supervisor: pread");
>>
>>      if (nread == 0) {
>>         fprintf(stderr, "\tS: pread() of /proc/PID/mem "
>>                 "returned 0 (EOF)\n");
>>         exit(EXIT_FAILURE);
>>      }
>>
>>      if (close(procMemFd) == -1)
>>         errExit("Supervisor: close-/proc/PID/mem");
>>
>> +    /* Once again check that the notification ID is still valid. The
>> +       case we are particularly concerned about here is that just
>> +       before we fetched the pathname, the target's blocked system
>> +       call was interrupted by a signal handler, and after the handler
>> +       returned, the target carried on execution (past the interrupted
>> +       system call). In that case, we have no guarantees about what we
>> +       are reading, since the target's memory may have been arbitrarily
>> +       changed by subsequent operations. */
>> +
>> +    if (!notificationIdIsValid(notifyFd, req->id, "post-open"))
>> +        return false;
>> +
>>      /* We have no guarantees about what was in the memory of the target
>>         process. We therefore treat the buffer returned by pread() as
>>         untrusted input. The buffer should be terminated by a null byte;
>>         if not, then we will trigger an error for the target process. */
>>
>>      if (strnlen(path, nread) < nread)
>>          return true;
>> ]]
> 
> Yeah, that should do the job. 

Thanks.

> With the caveat that a cancelled syscall
> could've also led to the memory being munmap()ed, so the nread==0 case
> could also happen legitimately - so you might want to move this check
> up above the nread==0 (mm went away) and nread==-1 (mm still exists,
> but read from address failed, errno EIO) checks if the error message
> shouldn't appear spuriously.

In any case, I've been refactoring (simplifying) that code a little.
I haven't so far rearranged the order of the checks, but I already
log message for the nread==0 case. (Instead, there will eventually
be an error when the response is sent.)

I also haven't exactly tested the scenario you describe in the
seccomp unotify scenario, but I think the above is not correct. Here 
are two scenarios I did test, simply with mmap() and /proc/PID/mem
(no seccomp involved): 

Scenario 1:
A creates a mapping at address X
B opens /proc/A/mem and and lseeks on resulting FD to offset X
A terminates
B reads from FD ==> read() returns 0 (EOF)

Scenario 2:
A creates a mapping at address X
B opens /proc/A/mem and and lseeks on resulting FD to offset X
A unmaps mapping at address X
B reads from FD ==> read() returns -1 / EIO.

That last scenario seems to contradict what you say, since I
think you meant that in this case read() should return 0 in
that case. Have I misunderstood you?

Thanks,

Michael





-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
