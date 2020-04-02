Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B65219BB1D
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 06:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDBEan (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 00:30:43 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51362 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgDBEan (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 00:30:43 -0400
Received: by mail-pj1-f68.google.com with SMTP id w9so1044453pjh.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2020 21:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Ipk7kDxp1AXDVnPYq/YmXF2z/X0a263eBu1rJD9k9Y=;
        b=rcSHxrnGNYuokmND2ayb3hJ8dI8o9uuK8WsdANAvMl5pITbIQz9+n8YqZ2Hg/dZfa9
         MkLD6Z2pgxDdw1ktXBHY65tN+f3wDd1kU93fjolpvrgG6n/IcYMlFBY5PdMUpXLcu3Xn
         u/WR2gFsTPZtmzXBJYCtRiJYrNqd41kz+wt91lmtOAz0z/RQLr8qM9XUp++OFamwSc97
         27dhtHKSAnZa26kQaXBRrXBtsZqKuuz5JcAtCvtbUhTwkAQuHXndD5If9ZBIE/tcQNZz
         a1e7VYa9hzDPOnHbb02ozDbGUXWNsZbBd0weJ7sPxQV2yC+snbOkAwfzhvedFngIS0tU
         5xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Ipk7kDxp1AXDVnPYq/YmXF2z/X0a263eBu1rJD9k9Y=;
        b=pkJZZPwwNPfaLkyAT6F7tWvAPOLXCXExpAKz3qSZPmxv8h8dV983FW+zbXrT4Xx3S4
         /LkOrxXBZh8U/5ZEsAXO8E/uMlpIV9qO+8pIU0zslGYerh3QPVpfgD7lXoV4ChSXs7EH
         Rrbl2f1cwTjBNq8F5cjz0NmqpHEaJfhJt3IbIN7CvEIveImDzIee3Dr3q7bRZE216Tof
         OHpNtJuS2N2xylt15gUvypAHIaNiooq4DK270Tn+yY5KYeM6LsHMi3tOWXto56sGbX+9
         G+THdmaKsHIM3kIxw8OuYRZ/XXav/HIp4GV9swpsF3+3AfVLn5q+IrqE6bKjsqIKfR9v
         qsWw==
X-Gm-Message-State: AGi0PuaQoF/PCp2TokP5ZLbJTeMJr2ZghKy57TRK9CJb5g0x/eTEWdl0
        h8MQYHm4ahG22f6GMSD/6i+gjlko
X-Google-Smtp-Source: APiQypIhqPbKIENqVwr5pWyjTF5YwEUIDFsZbzGv6E1zvuclBHLqXiwGwQ4dc7dgG+/gcgYQ9UbTiA==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr1215440pls.324.1585801841644;
        Wed, 01 Apr 2020 21:30:41 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:c29f])
        by smtp.gmail.com with ESMTPSA id x13sm1955828pfj.185.2020.04.01.21.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 21:30:40 -0700 (PDT)
Date:   Wed, 1 Apr 2020 21:30:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Subject: Re: [PATCH bpf-next v9 7/8] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
Message-ID: <20200402043037.ltgyptxsf7jaaudu@ast-mbp>
References: <20200329004356.27286-1-kpsingh@chromium.org>
 <20200329004356.27286-8-kpsingh@chromium.org>
 <CAADnVQKP3mOTUkkzjWM6Qii+v-dCDwV9Ms_-4ptsbdwyDW1MCA@mail.gmail.com>
 <20200402040357.GA217889@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402040357.GA217889@google.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 02, 2020 at 06:03:57AM +0200, KP Singh wrote:
> On 01-Apr 17:09, Alexei Starovoitov wrote:
> > On Sat, Mar 28, 2020 at 5:44 PM KP Singh <kpsingh@chromium.org> wrote:
> > > +int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
> > > +            unsigned long reqprot, unsigned long prot, int ret)
> > > +{
> > > +       if (ret != 0)
> > > +               return ret;
> > > +
> > > +       __u32 pid = bpf_get_current_pid_tgid() >> 32;
> > > +       int is_heap = 0;
> > > +
> > > +       is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> > > +                  vma->vm_end <= vma->vm_mm->brk);
> > 
> > This test fails for me.
> 
> Trying this from bpf/master:
> 
>   b9258a2cece4 ("slcan: Don't transmit uninitialized stack data in padding")
> 
> also from bpf-next/master:
> 
>  1a323ea5356e ("x86: get rid of 'errret' argument to __get_user_xyz() macross")
> 
> and I am unable to reproduce the failure (the output when using bpf/master):
..
> 
> Also, I am wondering if this happens just in the BPF program or also
> in the kernel as the other variable I can think of is the compiled
> bpf program itself which might be reading a different value thinking
> it's vm->vma_start, possible something to do with BTF / CO RE due to a
> compiler bug:

I don't think it's anything to do with clang/btf or core.
I think that condition is simply incorrect.
I've added:
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 311c0dadf71c..16ae0ada34ba 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -577,6 +577,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
                        goto out;
                }

+               printk("start %llx %llx\n", vma->vm_start, vma->vm_mm->start_brk);
                error = security_file_mprotect(vma, reqprot, prot);

and see exactly the same values as bpf side (at least it was nice to see
that all CO-RE logic is working as expected :))

[   24.787442] start 523000 39b9000

I think it has something to do with the way test_progs is linked.
But the problem is in condition itself.
I suspect you copy-pasted it from selinux_file_mprotect() ?
I think it's incorrect there as well.
Did we just discover a way to side step selinux protection?
Try objdump -h test_progs|grep bss
the number I see in vma->vm_start is the beginning of .bss rounded to page boundary.
I wonder where your 55dc6e8df000 is coming from.
