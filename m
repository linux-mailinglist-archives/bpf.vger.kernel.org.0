Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE9119C085
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 13:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbgDBLxN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 07:53:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44287 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387988AbgDBLxM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 07:53:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id m17so3785886wrw.11
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tOh62bwp4xTt7Zdnle1fpPn0gEM2mqpxx6MvJQzhpAs=;
        b=QqCFyDW7MAUPQykavVGpLnrSjJLmXAo0d0GJ7QHFfbeBZe6hbGRPj3ZeTJbI38ReXX
         4q45XVBcP9CVH8TlNHEPPA+yM09sIvl2mgD8FIC3Ll8LxEY15gZBq6wrndILCRcYFEQj
         aYfofOTEha451T3CTm+nnY4Kumg2FasRfMOYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tOh62bwp4xTt7Zdnle1fpPn0gEM2mqpxx6MvJQzhpAs=;
        b=iDAW5b9aY+raiFlrOkSXhbLlsNF04TbhSPCLtPxMjMVX0FSzkRp8mxfwUDCU0VsYZC
         2e14n6gTkBzkKT9F5QL+oSjBZqp2MunqeSx4cW88P7AJp6dG0O2WWfCK5HtekFzwCUB+
         SdzwfSoqo7ag4mfTryrxD7zdYzPG1YorTfjlvfkRA/TcCjnz9TxVz2IZmCHjtxbvqmT0
         Rv9im1yQlHt7XDw+iqT0ySwgMlETWfWbGKvZpf5rIbHEhsRHkSVNaqORRtC66hd2wgsM
         NBUZsVIbyD1/LY8e79FjXQ74t+aP0m6R4V1TDaW5GzL/Yo5hJtCSxwABhD8E2iwmjy+A
         MRZw==
X-Gm-Message-State: AGi0PuZQgjJ9zzDzb0l646bgT+NjxTXHSegOH6NtKdJ7ypZULWhjmbri
        ujiClK9tKahWglA24kmrfSho8A/Wv/PiCw==
X-Google-Smtp-Source: APiQypItujcdhavUxwoGHW7UDEGdwtogxjbESX0TduJaWum74du6jed2DQtRVHS0KfGwhKFd5/dXHQ==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr3200255wrs.202.1585828388880;
        Thu, 02 Apr 2020 04:53:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id c17sm2019430wrp.28.2020.04.02.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 04:53:08 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 2 Apr 2020 13:53:06 +0200
To:     Jann Horn <jannh@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v9 7/8] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
Message-ID: <20200402115306.GA100892@google.com>
References: <20200329004356.27286-1-kpsingh@chromium.org>
 <20200329004356.27286-8-kpsingh@chromium.org>
 <CAADnVQKP3mOTUkkzjWM6Qii+v-dCDwV9Ms_-4ptsbdwyDW1MCA@mail.gmail.com>
 <20200402040357.GA217889@google.com>
 <20200402043037.ltgyptxsf7jaaudu@ast-mbp>
 <CAG48ez3SdOVbzJQgo-p=rhKhPdJxjUdraEE6WK5GP3GdenWAAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3SdOVbzJQgo-p=rhKhPdJxjUdraEE6WK5GP3GdenWAAQ@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks Jann and Alexei,

On 02-Apr 07:15, Jann Horn wrote:
> On Thu, Apr 2, 2020 at 6:30 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu, Apr 02, 2020 at 06:03:57AM +0200, KP Singh wrote:
> > > On 01-Apr 17:09, Alexei Starovoitov wrote:
> > > > > +            unsigned long reqprot, unsigned long prot, int ret)
> > > > > +{

[...]

> >
> > and see exactly the same values as bpf side (at least it was nice to see
> > that all CO-RE logic is working as expected :))
> >
> > [   24.787442] start 523000 39b9000
> >
> > I think it has something to do with the way test_progs is linked.
> > But the problem is in condition itself.
> > I suspect you copy-pasted it from selinux_file_mprotect() ?
> > I think it's incorrect there as well.
> > Did we just discover a way to side step selinux protection?
> > Try objdump -h test_progs|grep bss
> > the number I see in vma->vm_start is the beginning of .bss rounded to page boundary.
> > I wonder where your 55dc6e8df000 is coming from.
> 
> I suspect that you're using different versions of libc, or something's
> different in the memory layout, or something like that. The brk region
> is used for memory allocations using brk(), but memory allocations
> using mmap() land outside it. At least some versions of libc try to
> allocate memory for malloc() with brk(), then fall back to mmap() if
> that fails because there's something else behind the current end of
> the brk region; but I think there might also be versions of libc that
> directly use mmap() and don't even try to use brk().

Yeah missed this that heap can also be allocated using mmap:

Quoting the manual:

"""
Normally, malloc() allocates memory from the heap, and adjusts the
size of the heap as required, using sbrk(2).   When  allocating blocks
of  memory larger than MMAP_THRESHOLD bytes, the glibc malloc()
implementation allocates the memory as a private anonymous mapping
using mmap(2).  MMAP_THRESHOLD is 128 kB by default, but is adjustable
using mallopt(3).  Prior to Linux  4.7  allocations performed  using
mmap(2) were unaffected by the RLIMIT_DATA resource limit; since Linux
4.7, this limit is also enforced for allocations performed using
mmap(2).
"""

So it seems like we might have separate MMAP_THRESHOLD or resource
limits.

I updated my test case to check for mmaps on the stack instead:

diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index 1e4c258de09d..64c13c850611 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -15,8 +15,13 @@
 
 char *CMD_ARGS[] = {"true", NULL};
 
-int heap_mprotect(void)
+#define PAGE_SIZE 4096
+#define GET_PAGE_ADDR(ADDR)                                    \
+       (char *)(((unsigned long) ADDR) & ~(PAGE_SIZE-1))
+
+int stack_mprotect(void)
 {
+
        void *buf;
        long sz;
        int ret;
@@ -25,12 +30,9 @@ int heap_mprotect(void)
        if (sz < 0)
                return sz;
 
-       buf = memalign(sz, 2 * sz);
-       if (buf == NULL)
-               return -ENOMEM;
-
-       ret = mprotect(buf, sz, PROT_READ | PROT_WRITE | PROT_EXEC);
-       free(buf);
+       buf = alloca(PAGE_SIZE * 3);
+       ret = mprotect(GET_PAGE_ADDR(buf + PAGE_SIZE), PAGE_SIZE,
+                      PROT_READ | PROT_WRITE | PROT_EXEC);
        return ret;
 }
 
@@ -73,8 +75,8 @@ void test_test_lsm(void)
 
        skel->bss->monitored_pid = getpid();
 
-       err = heap_mprotect();
-       if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
+       err = stack_mprotect();
+       if (CHECK(errno != EPERM, "stack_mprotect", "want err=EPERM, got %d\n",
                  errno))
                goto close_prog;
 
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index a4e3c223028d..b4598d4bc4f7 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -23,12 +23,12 @@ int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
                return ret;
 
        __u32 pid = bpf_get_current_pid_tgid() >> 32;
-       int is_heap = 0;
+       int is_stack = 0;
 
-       is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
-                  vma->vm_end <= vma->vm_mm->brk);
+       is_stack = (vma->vm_start <= vma->vm_mm->start_stack &&
+                   vma->vm_end >= vma->vm_mm->start_stack);
 
-       if (is_heap && monitored_pid == pid) {
+       if (is_stack && monitored_pid == pid) {
                mprotect_count++;
                ret = -EPERM;
        }

and the the logic seems to work for me. Do you think we could use
this instead?

- KP

> 
> So yeah, security checks based on the brk region aren't exactly
> useful; but e.g. in SELinux, both cases have appropriate checks. The
> brk region gets SECCLASS_PROCESS:PROCESS__EXECHEAP, anonymous mmap
> allocations get SECCLASS_PROCESS:PROCESS__EXECMEM in
> file_map_prot_check() instead. (This makes *some* amount of sense -
> although not a lot - because for the brk region you know that it comes
> from something like malloc(), while an anonymous mmap() allocation
> might reasonably be used for JIT executable memory.)
> 
> In other words, you may want to pick something different as test case,
> since the behavior here depends on libc.
