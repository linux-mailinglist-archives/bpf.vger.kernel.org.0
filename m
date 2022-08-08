Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1293058CB0F
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbiHHPOp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbiHHPOo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:14:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4E6CE31;
        Mon,  8 Aug 2022 08:14:43 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id k12so14121329ybk.6;
        Mon, 08 Aug 2022 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3HgE3/632x1k0MtSqNgva1QuxG/bXv3/l3QcDRfIKGo=;
        b=XTebna0ZoDS8BXAWbhYJ8X/NQdfNLDl8rBT4BSaT9Q6cMLwqTSKleWU89PoygN2tQW
         b5iL8Oi/kDLhqiVjnW6dNMuQBZEMhdEn6KCNv2QOc/RgW6eWBtjK7zpfGyQmWxxxB2SE
         jVZvi/QuLmGtFSTsc5B+sc8ADBjKNzAAXGAS/cCAvxa3YE9gr8nuzdtWJvj4Haact2X9
         cty4N0/+bWQZd74geComDvXkKPx6ASFcKQPWMpys30x2IYrzS+OAWHvKVaCyPGlI7CDY
         PYQ8OtyjZJ0zWmQjV6M7Z8fI/EFh4MPH1v2Lwkddxky0E5/g+hEnM10QfkuwHdJFSraP
         zFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3HgE3/632x1k0MtSqNgva1QuxG/bXv3/l3QcDRfIKGo=;
        b=KQdyS22YXvBVUOi3L4I/Pc2urFyRUPftU9GVnYpE+wL5pF0GFw5KsX/5hyyMwehIYm
         xE2i4l3NctPA0A/T65wwJjtHtsquENafTmm52tJAoldX+ql0WQzLAKTlvhN9YnWXHWCl
         3bz4JTwzyKdatE/aYrMGM+i7hPTIuF0aqNXyOyOQXSI6uZ9acjgLzVtiK4NlNAZMURlM
         ZY8kN6UbF19RzGQ1xZlHhxYChhxLUbLCNsTHwn+N1JnuGs78gF4y7mnWWBnwF7VDiVo6
         EGjz5W86Ffu9JmtZr88ohxJM6Xx1UWa8eZAwm0dW1CdGwoSMQ3Q1xFB8mH1M74Q5YWKF
         G18g==
X-Gm-Message-State: ACgBeo32CLQpx/vXDCdA1jkmmYIWU39+yq1Qm1B21kkUvVid3eSU0381
        Yx/iCzKgGwahm56dbOiJZwApvbYx3y1RB6cef3M=
X-Google-Smtp-Source: AA6agR5z3JNzZdR3zqZcIVK6XyuUPGjHt5FNwaFhN95fS/yKOrV7McCa756y962mO6Srxn0/neTJA00KOw6h5AffB9w=
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr17614676ybu.310.1659971682978; Mon, 08
 Aug 2022 08:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+khW7iknv0hcn-D2tRt8HFseUnyTV7BwpohQHtEyctbA1k27w@mail.gmail.com>
 <20220729224254.1798-1-liulin063@gmail.com> <CA+khW7iLeSZPweZEz_tfP+LRtpvZbfvstZWgUbNrEDK-Ntxyxw@mail.gmail.com>
 <ccafa637-d986-b4e3-73e0-03721a940ce1@iogearbox.net> <CANdZH3U7axKg6zDY+iswF2d1fBYY1Xo2jeVsbgMYMoJfd1AYJg@mail.gmail.com>
In-Reply-To: <CANdZH3U7axKg6zDY+iswF2d1fBYY1Xo2jeVsbgMYMoJfd1AYJg@mail.gmail.com>
From:   Kuee k1r0a <liulin063@gmail.com>
Date:   Mon, 8 Aug 2022 23:14:31 +0800
Message-ID: <CANdZH3V64LdfYpWrX9teQQU8LGj10_ecXpupRfnyKQ47gvtOoQ@mail.gmail.com>
Subject: Fwd: [PATCH bpf] bpf: Do more tight ALU bounds tracking
To:     haoluo@google.com
Cc:     Alexei Starovoitov <ast@kernel.org>, john.fastabend@gmail.com,
        Andrii Nakryiko <andrii@kernel.org>, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---------- Forwarded message ---------
From: Kuee k1r0a <liulin063@gmail.com>
Date: Mon, Aug 8, 2022 at 11:11 PM
Subject: Re: [PATCH bpf] bpf: Do more tight ALU bounds tracking
To: Daniel Borkmann <daniel@iogearbox.net>


On Mon, Aug 8, 2022 at 9:25 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/30/22 12:48 AM, Hao Luo wrote:
> > On Fri, Jul 29, 2022 at 3:43 PM Youlin Li <liulin063@gmail.com> wrote:
> >>
> >> In adjust_scalar_min_max_vals(), let 32bit bounds learn from 64bit bounds
> >> to get more tight bounds tracking. Similar operation can be found in
> >> reg_set_min_max().
> >>
> >> Also, we can now fold reg_bounds_sync() into zext_32_to_64().
> >>
> >> Before:
> >>
> >>      func#0 @0
> >>      0: R1=ctx(off=0,imm=0) R10=fp0
> >>      0: (b7) r0 = 0                        ; R0_w=0
> >>      1: (b7) r1 = 0                        ; R1_w=0
> >>      2: (87) r1 = -r1                      ; R1_w=scalar()
> >>      3: (87) r1 = -r1                      ; R1_w=scalar()
> >>      4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
> >>      5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0xffffffff))  <--- [*]
> >>      6: (95) exit
> >>
> >> It can be seen that even if the 64bit bounds is clear here, the 32bit
> >> bounds is still in the state of 'UNKNOWN'.
> >>
> >> After:
> >>
> >>      func#0 @0
> >>      0: R1=ctx(off=0,imm=0) R10=fp0
> >>      0: (b7) r0 = 0                        ; R0_w=0
> >>      1: (b7) r1 = 0                        ; R1_w=0
> >>      2: (87) r1 = -r1                      ; R1_w=scalar()
> >>      3: (87) r1 = -r1                      ; R1_w=scalar()
> >>      4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
> >>      5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0x3))  <--- [*]
> >>      6: (95) exit
> >>
> >> Signed-off-by: Youlin Li <liulin063@gmail.com>
> >
> > Looks good to me. Thanks Youlin.
> >
> > Acked-by: Hao Luo <haoluo@google.com>
>
> Thanks Youlin! Looks like the patch breaks CI [0] e.g.:
>
>    #142/p bounds check after truncation of non-boundary-crossing range FAIL
>    Failed to load prog 'Permission denied'!
>    invalid access to map value, value_size=8 off=16777215 size=1
>    R0 max value is outside of the allowed memory range
>    verification time 296 usec
>    stack depth 8
>    processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>
> Please take a look. Also it would be great to add a test_verifier selftest to
> assert above case from commit log against future changes.
>
> Thanks,
> Daniel
>
>    [0] https://github.com/kernel-patches/bpf/runs/7696324041?check_suite_focus=true

This test case fails because the 32bit boundary information is lost
after the 11th instruction is executed:
Before:
    11: (07) r1 += 2147483647             ;
R1_w=scalar(umin=70866960383,umax=70866960638,var_off=(0x1000000000;
0xffffffff),u32_min=2147483647,u32_max=-2147483394)
After:
    11: (07) r1 += 2147483647             ;
R1_w=scalar(umin=70866960383,umax=70866960638,var_off=(0x1000000000;
0xffffffff))

This may be because, in previous versions of the code, when
__reg_combine_64_into_32() was called, the 32bit boundary was
completely deduced from the 64bit boundary, so there was a call to
__mark_reg32_unbounded() in __reg_combine_64_into_32().

But now, before adjust_scalar_min_max_vals() calls
__reg_combine_64_into_32() , the 32bit bounds are already calculated
to some extent, and __mark_reg32_unbounded() will eliminate these
information.

Simply copying a code without __mark_reg32_unbounded() should work,
perhaps it would be more elegant to introduce a flag into
__reg_combine_64_into_32()?

Sorry for not completing the tests because I did not 'make selftests'
successfully, and uploaded the code that caused the error.
