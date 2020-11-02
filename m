Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B41B2A347D
	for <lists+bpf@lfdr.de>; Mon,  2 Nov 2020 20:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgKBTpT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 14:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTpS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Nov 2020 14:45:18 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD38C0617A6;
        Mon,  2 Nov 2020 11:45:18 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id x7so16012253wrl.3;
        Mon, 02 Nov 2020 11:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=laqvXkYmnuGd0xSBrvapYqlT+lDWdfEk/TVZWHBUFak=;
        b=Xcu4Fuh7ucz0IyN2Q9r9gVmHTHMRgAt6J3EL40r2hOn8GHpIYVL4F9QyxLZjQjaHKD
         Q23alGe3vdzXDX/NYsmYEGuz0HSN0mD5zpT6OG2cZmZB/2A8rlOp/u5dnPC8jb0L/Zlb
         jQpmd4aLHJM5p1sDQ6+hoS4A8xICctQtmdgp3wMstwZA7wqQvL3nJgQG//zv5ctFG/1U
         75/w69lxjXWSyHtPfNNmL5zudSct3ItMfx6+b01qJhKjAKBWl5o4oqgQQAdl8dDCMltf
         5jHGvTX1xOK8prO/vWr0PsbKEhppDUxNe4DCHwv97Zsyy3tDVIy5yycC1Ep5TCbdOPu2
         mytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=laqvXkYmnuGd0xSBrvapYqlT+lDWdfEk/TVZWHBUFak=;
        b=GR8MIus9DdMdgyuJ0HszrysFz1bPGr7Ti/4sF9C6Bgr7zuohtwQxeuly4s52shr1tq
         DCtSB697ozadC4kAMcvaYeshAo+Ssy+pGkrwXszBlV1x5t0EzVh0+l2+iFtfOSsEicVr
         z5vKyHRiJfGHGeNiduZ0BV1ZixFI+4zYY/Sa9Hm6Ogs8I39r1LitjuLgt6RRM+d7whwx
         5sm+nw9v0pja9OWjTkJWRp+NfHVfeCS0Q8+8XhRZCVP10LsX/6uRZQ9TJSG1QiXQpWdp
         NvCDQG7/pfVjBw9+cn2OFNh63r/dugB87xONTszjFyIdJs8JrKsIOoiNyXNekOBD/q51
         mOSQ==
X-Gm-Message-State: AOAM5325Xgne3M7V5owPyljzVZQa3/rxCM40bqP2WKlDAbCScFqPqPMm
        4/ycN/aWl8sqnNEfL0ybWr4=
X-Google-Smtp-Source: ABdhPJz8m94F40PYPDleJPuNVjP3xxDbSlJfSVCYuiHmiaTZX/Dk9in69mChxicVhbXQrTId1ocsGg==
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr23106131wru.296.1604346317099;
        Mon, 02 Nov 2020 11:45:17 -0800 (PST)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id l11sm21642720wro.89.2020.11.02.11.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 11:45:15 -0800 (PST)
Cc:     mtk.manpages@gmail.com, Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     Sargun Dhillon <sargun@sargun.me>
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <20201029085312.GC29881@ircssh-2.c.rugged-nimbus-611.internal>
 <48e5937b-80f5-c48b-1c67-e8c9db263ca5@gmail.com>
 <20201030202720.GA4088@ircssh-2.c.rugged-nimbus-611.internal>
 <606199d6-b48c-fee2-6e79-1e52bd7f429f@gmail.com>
 <CAMp4zn9AaQ46EyG6QFrF33efpUHnK_TyMYkTicr=iwY5hcKrBg@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <964c2191-db78-ff4d-5664-1d80dc382df4@gmail.com>
Date:   Mon, 2 Nov 2020 20:45:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAMp4zn9AaQ46EyG6QFrF33efpUHnK_TyMYkTicr=iwY5hcKrBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Sargun,

Thanks for your reply!

On 11/2/20 9:07 AM, Sargun Dhillon wrote:
> On Sat, Oct 31, 2020 at 9:27 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> Hello Sargun,
>>
>> Thanks for your reply.
>>
>> On 10/30/20 9:27 PM, Sargun Dhillon wrote:
>>> On Thu, Oct 29, 2020 at 09:37:21PM +0100, Michael Kerrisk (man-pages)
>>> wrote:
>>
>> [...]
>>
>>>>> I think I commented in another thread somewhere that the
>>>>> supervisor is not notified if the syscall is preempted. Therefore
>>>>> if it is performing a preemptible, long-running syscall, you need
>>>>> to poll SECCOMP_IOCTL_NOTIF_ID_VALID in the background, otherwise
>>>>> you can end up in a bad situation -- like leaking resources, or
>>>>> holding on to file descriptors after the program under
>>>>> supervision has intended to release them.
>>>>
>>>> It's been a long day, and I'm not sure I reallu understand this.
>>>> Could you outline the scnario in more detail?
>>>>
>>> S: Sets up filter + interception for accept T: socket(AF_INET,
>>> SOCK_STREAM, 0) = 7 T: bind(7, {127.0.0.1, 4444}, ..) T: listen(7,
>>> 10) T: pidfd_getfd(T, 7) = 7 # For the sake of discussion.
>>
>> Presumably, the preceding line should have been:
>>
>> S: pidfd_getfd(T, 7) = 7 # For the sake of discussion.
>> (s/T:/S:/)
>>
>> right?
> 
> Right.
>>
>>
>>> T: accept(7, ...) S: Intercepts accept S: Does accept in background
>>> T: Receives signal, and accept(...) responds in EINTR T: close(7) S:
>>> Still running accept(7, ....), holding port 4444, so if now T
>>> retries to bind to port 4444, things fail.
>>
>> Okay -- I understand. Presumably the solution here is not to
>> block in accept(), but rather to use poll() to monitor both the
>> notification FD and the listening socket FD?
>>
> You need to have some kind of mechanism to periodically check
> if the notification is still alive, and preempt the accept. It doesn't
> matter how exactly you "background" the accept (threads, or
> O_NONBLOCK + epoll).
> 
> The thing is you need to make sure that when the process
> cancels a syscall, you need to release the resources you
> may have acquired on its behalf or bad things can happen.
> 

Got it. I added the following text:

   Caveats regarding blocking system calls
       Suppose that the target performs a blocking system call (e.g.,
       accept(2)) that the supervisor should handle.  The supervisor
       might then in turn execute the same blocking system call.

       In this scenario, it is important to note that if the target's
       system call is now interrupted by a signal, the supervisor is not
       informed of this.  If the supervisor does not take suitable steps
       to actively discover that the target's system call has been
       canceled, various difficulties can occur.  Taking the example of
       accept(2), the supervisor might remain blocked in its accept(2)
       holding a port number that the target (which, after the
       interruption by the signal handler, perhaps closed  its listening
       socket) might expect to be able to reuse in a bind(2) call.

       Therefore, when the supervisor wishes to emulate a blocking system
       call, it must do so in such a way that it gets informed if the
       target's system call is interrupted by a signal handler.  For
       example, if the supervisor itself executes the same blocking
       system call, then it could employ a separate thread that uses the
       SECCOMP_IOCTL_NOTIF_ID_VALID operation to check if the target is
       still blocked in its system call.  Alternatively, in the accept(2)
       example, the supervisor might use poll(2) to monitor both the
       notification file descriptor (so as as to discover when the
       target's accept(2) call has been interrupted) and the listening
       file descriptor (so as to know when a connection is available).

       If the target's system call is interrupted, the supervisor must
       take care to release resources (e.g., file descriptors) that it
       acquired on behalf of the target.

Does that seem okay?

>>>>> ENOENT The cookie number is not valid. This can happen if a
>>>>> response has already been sent, or if the syscall was
>>>>> interrupted
>>>>>
>>>>> EBADF If the file descriptor specified in srcfd is invalid, or if
>>>>> the fd is out of range of the destination program.
>>>>
>>>> The piece "or if the fd is out of range of the destination program"
>>>> is not clear to me. Can you say some more please.
>>>>
>>>
>>> IIRC the maximum fd range is specific in proc by some sysctl named
>>> nr_open. It's also evaluated against RLIMITs, and nr_max.
>>>
>>> If nr-open (maximum fds open per process, iiirc) is 1000, even if 10
>>> FDs are open, it wont work if newfd is 1001.
>>
>> Actually, the relevant limit seems to be just the RLIMIT_NOFILE
>> resource limit at least in my reading of fs/file.c::replace_fd().
>> So I made the text
>>
>>               EBADF  Allocating the file descriptor in the target would
>>                      cause the target's RLIMIT_NOFILE limit to be
>>                      exceeded (see getrlimit(2)).
>>
>>
> 
> If you're above RLIMIT_NOFILE, you get EBADF.
> 
> When we do __receive_fd with a specific fd (newfd specified):
> https://elixir.bootlin.com/linux/latest/source/fs/file.c#L1086
> 
> it calls replace_fd, which calls expand_files. expand_files
> can fail with EMFILE.
> 
>>>>> EINVAL If flags or new_flags were unrecognized, or if newfd is
>>>>> non-zero, and SECCOMP_ADDFD_FLAG_SETFD has not been set.
>>>>>
>>>>> EMFILE Too many files are open by the destination process.
>>
>> I'm not sure that the error can really occur. That's the error
>> that in most other places occurs when RLIMIT_NOFILE is exceeded.
>> But I may have missed something. More precisely, when do you think
>> EMFILE can occur?
>>
> It can happen if the user specifies a newfd which is too large.

Got it. Thanks! I made the error text:

        EMFILE The file descriptor number specified in newfd  exceeds  the
              limit specified in /proc/sys/fs/nr_open.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
