Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD212473A12
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 02:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbhLNBMu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 20:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhLNBMu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 20:12:50 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC88C061574
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 17:12:50 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id q74so42535801ybq.11
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 17:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfJW/MI2En+5uFbUb0eEjuKXdmdcZKwYB0v+moGQOto=;
        b=l8UAY1Lb+YHAQ+WXN8DwtTMwhS6i06ClBhQnrYFaALfeTaNwnGqHCBAFQFCiNIZba+
         CWIiwrIaD1TWceb0wbKeY8iDVhimt8igGj8CXeZpEdcErzwhIlWZ3EMVggd1CKqTmZGM
         YzHyTvZYNwcm/NkS4hh+fOg9SJsNuG0rN7AAHu9xXF2nvTNnv4BE8sDXh6+VC7cnYPo8
         ItcPY1ey0QCMSYK53u1CregWvztWuc+ydtiVNeqWTIcoqco5YQiSdCV3Z7BCi/mL/Jcx
         ie3Et0AJ+A8GhJUkXJ/DvlbtzuxdNJ+P46RN+nvz9OazPG/E/0IM9M9n3dJ3uoX6BCJh
         gN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfJW/MI2En+5uFbUb0eEjuKXdmdcZKwYB0v+moGQOto=;
        b=SQ4abt534AxrSw2/QrCd/rxwFy1dwb9gH0zQ2q2ndykY7e0P68OspvK9WwUwSPmmSX
         x3Qz8vn/DzO9PwKyOk+1GEXWrzndKAgQ9ffZ/posv4KTTVis+cKvEuj4vI2BhpuroYqC
         yZK8Z3m1wLiSYsi1s+ZC26BdLPbxn/XAcQTeY7Ury4XygfNu5o7EblmUYGVobhE1hqo8
         XxfSY/AeCP7rkMxqD6lxSbbW7O6MU/cLPdj5rrMYsgpW8c6WPimeop4BbId5XMQchHxK
         5uYGSgFe5AtiKXNg5JuAkaBMycmH0WQXpbBOINTHjJIxUM1n/09uKUYeRanp/jw5Idhh
         Wxww==
X-Gm-Message-State: AOAM531GauT71hjIVFNRqvGkLhRwO2VgyPWR2DjVhW17JWYbDjb2XzDf
        e+Fc3DLs7e79em/tvbsQU+FuOAY3tweOjVo9qlg=
X-Google-Smtp-Source: ABdhPJwTg7FTzLCKKXcHOXoq2TFY52hojsBMhSp5nFwxgHRSZJv0NTKCCLmsF6+jbkMhDFOxDSNM67QF+Zd50Aw4Kjg=
X-Received: by 2002:a25:e406:: with SMTP id b6mr2378544ybh.529.1639444369163;
 Mon, 13 Dec 2021 17:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20211213182117.682461-1-christylee@fb.com> <20211213182117.682461-3-christylee@fb.com>
In-Reply-To: <20211213182117.682461-3-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Dec 2021 17:12:37 -0800
Message-ID: <CAEf4BzZNc6RuhX278OTL4y6VDE16A-TtFXfOyo9tVJ=6hCrcsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] Right align verifier states in verifier logs
To:     Christy Lee <christylee@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 13, 2021 at 10:21 AM Christy Lee <christylee@fb.com> wrote:
>
> Make the verifier logs more readable, print the verifier states
> on the corresponding instruction line. If the previous line was
> not a bpf instruction, then print the verifier states on its own
> line.
>
> Before:
>
> Validating test_pkt_access_subprog3() func#3...
> 86: R1=invP(id=0) R2=ctx(id=0,off=0,imm=0) R10=fp0
> ; int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
> 86: (bf) r6 = r2
> 87: R2=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 87: (bc) w7 = w1
> 88: R1=invP(id=0) R7_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 88: (bf) r1 = r6
> 89: R1_w=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 89: (85) call pc+9
> Func#4 is global and valid. Skipping.
> 90: R0_w=invP(id=0)
> 90: (bc) w8 = w0
> 91: R0_w=invP(id=0) R8_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 91: (b7) r1 = 123
> 92: R1_w=invP123
> 92: (85) call pc+65
> Func#5 is global and valid. Skipping.
> 93: R0=invP(id=0)
>
> After:
>
> Validating test_pkt_access_subprog3() func#3...
> 86: R1=invP(id=0) R2=ctx(id=0,off=0,imm=0) R10=fp0
> ; int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
> 86: (bf) r6 = r2               ; R2=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 87: (bc) w7 = w1               ; R1=invP(id=0) R7_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 88: (bf) r1 = r6               ; R1_w=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 89: (85) call pc+9
> Func#4 is global and valid. Skipping.
> 90: R0_w=invP(id=0)
> 90: (bc) w8 = w0               ; R0_w=invP(id=0) R8_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 91: (b7) r1 = 123              ; R1_w=invP123
> 92: (85) call pc+65
> Func#5 is global and valid. Skipping.
> 93: R0=invP(id=0)

This is a huge improvement, makes the log so much more useful. But if
it's not available in log_level = 1 most people will never get to
enjoy the benefits. I think we should absolutely do this for all
log_levels. It might increase the size of the log for log_level in
terms of number of bytes emitted into the log, but the clarity of
what's going on is totally worth it.

But I'm also confused why it's not available with log_level = 2 for
successfully verified programs. Do you have any idea. Running sudo
./test_progs -t log_buf -v, I get this for "GOOD_PROG" case (which
uses log_level 2):

=================
GOOD_PROG LOG:
=================
func#0 @0
arg#0 reference type('UNKNOWN ') size cannot be determined: -22
0: R1=ctx(id=0,off=0,imm=0) R10=fp0
; a[0] = (int)(long)ctx;
0: (18) r2 = 0xffffc90000572000
2: R2_w=map_value(id=0,off=0,ks=4,vs=16,imm=0)
2: (63) *(u32 *)(r2 +0) = r1
 R1=ctx(id=0,off=0,imm=0) R2_w=map_value(id=0,off=0,ks=4,vs=16,imm=0)

from 2 to 3:
; return a[1];
3: (61) r0 = *(u32 *)(r2 +4)
 R2_w=map_value(id=0,off=0,ks=4,vs=16,imm=0)

from 3 to 4:
; return a[1];
4: (95) exit
processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0


No right alignment :( What am I missing?


Also, your changes broke lots of test_progs, please see [0] and fix
them. Thanks.

  [0] https://github.com/kernel-patches/bpf/runs/4513474703?check_suite_focus=true

>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  include/linux/bpf_verifier.h                  |   2 +
>  kernel/bpf/verifier.c                         |  26 ++-
>  .../testing/selftests/bpf/prog_tests/align.c  | 196 ++++++++++--------
>  3 files changed, 131 insertions(+), 93 deletions(-)
>

[...]
