Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245F16C3D9F
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 23:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjCUWTt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 18:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCUWTs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 18:19:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B5CA22
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 15:19:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x15so6534679pjk.2
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679437187;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/TpkUMD5hQniyxkQ5iQ9wzvZsOPC2/DtxjxkhNOwPM=;
        b=B7zQqkoClBfUQ3+/Iy/DzFG5jhZWXMvzjMW1iWrYvrht5x8od9trUdbfOO1S/sPGSf
         L3qGAAsNpJdPha9cP6z26eOSW6hHPxlebC7/W4anQObv1ijYsY4ONIf/H+r2R+FWhLbc
         7YBykQsoFPh5+ADlqXz9Druyzq1mj8nHO1DwN+if/92b6TYLwcd9sbsZQr53GJO44MDY
         XzcJ1g0v3KARNrmqJ2Ut9QSNJnaMXGOEH9DqEXl2QVqaBf7+pBoGlb0VxBd8eVOQY7Sm
         nQBPvVx1Mr+my1VKaqsyXV3hqWz3+DiDywF3lQThEyJdcyhzzAR0LslNUyiPOEvAIdNA
         zxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679437187;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N/TpkUMD5hQniyxkQ5iQ9wzvZsOPC2/DtxjxkhNOwPM=;
        b=oNYlnFYKE/IeqAcxM2Uw9xyrpYHzueKkgWlNYVNDK3y7Xr28YHtp9WKMgrDqMoOTBl
         2h0BqGIl++V3hIhcQIdbNhYqU8VzyXmVsuhXOzUWWs5eiLevbVlGy0hDMdYnFV5/M6bo
         gLC2y1VTLrwRTKOQS0BrCkaWsULqjbpYSlQfuvCqVzTS9wuaeUKzhKZHafM4J7JGhe6z
         HKXp0H7piFNV6UwG39xfkLpOfW03gTYa05GHSfe1PG8jrmSgKk+dasJxFV5QzNakv8/O
         pXeiBnwh087zocnzC2JiDcN5VKwMauItIzHx8yp4LXdwuQ+ve4/4ZwWyTsTt9oxTC0r5
         ZF3Q==
X-Gm-Message-State: AAQBX9dgY8HC7r5CcV3yZoDLDEv4VM6f5zmKBTQycCWiAn1rG45dD0Ob
        PETeachyNnBjw0FceaCsEKZolz6zkv4=
X-Google-Smtp-Source: AKy350avBC01vLuegkRLeDPG/2yCUYkMTz2sPlr01E4OeL0mvWZ5SpV16Hkaiz5gTmzfFUtvAnctSA==
X-Received: by 2002:a17:903:41cf:b0:19c:ff5d:1fd2 with SMTP id u15-20020a17090341cf00b0019cff5d1fd2mr132619ple.8.1679437186619;
        Tue, 21 Mar 2023 15:19:46 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id jk23-20020a170903331700b001a19bde435fsm9268175plb.65.2023.03.21.15.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:19:46 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:19:44 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Message-ID: <641a2d807e5a2_80a24208ec@john.notmuch>
In-Reply-To: <20230321193354.10445-1-daniel@iogearbox.net>
References: <20230321193354.10445-1-daniel@iogearbox.net>
Subject: RE: [PATCH bpf-next 1/2] bpf: Fix __reg_bound_offset 64->32 var_off
 subreg propagation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann wrote:
> Xu reports that after commit 3f50f132d840 ("bpf: Verifier, do explicit ALU32
> bounds tracking"), the following BPF program is rejected by the verifier:
> 
>    0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
>    1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
>    2: (bf) r1 = r2
>    3: (07) r1 += 1
>    4: (2d) if r1 > r3 goto pc+8
>    5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
>    6: (18) r0 = 0x7fffffffffffff10
>    8: (0f) r1 += r0                      ; R1_w=scalar(umin=0x7fffffffffffff10,umax=0x800000000000000f)
>    9: (18) r0 = 0x8000000000000000
>   11: (07) r0 += 1
>   12: (ad) if r0 < r1 goto pc-2
>   13: (b7) r0 = 0
>   14: (95) exit
> 
> And the verifier log says:
> 
>   func#0 @0
>   0: R1=ctx(off=0,imm=0) R10=fp0
>   0: (61) r2 = *(u32 *)(r1 +0)          ; R1=ctx(off=0,imm=0) R2_w=pkt(off=0,r=0,imm=0)
>   1: (61) r3 = *(u32 *)(r1 +4)          ; R1=ctx(off=0,imm=0) R3_w=pkt_end(off=0,imm=0)
>   2: (bf) r1 = r2                       ; R1_w=pkt(off=0,r=0,imm=0) R2_w=pkt(off=0,r=0,imm=0)
>   3: (07) r1 += 1                       ; R1_w=pkt(off=1,r=0,imm=0)
>   4: (2d) if r1 > r3 goto pc+8          ; R1_w=pkt(off=1,r=1,imm=0) R3_w=pkt_end(off=0,imm=0)
>   5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff)) R2_w=pkt(off=0,r=1,imm=0)
>   6: (18) r0 = 0x7fffffffffffff10       ; R0_w=9223372036854775568
>   8: (0f) r1 += r0                      ; R0_w=9223372036854775568 R1_w=scalar(umin=9223372036854775568,umax=9223372036854775823,s32_min=-240,s32_max=15)
>   9: (18) r0 = 0x8000000000000000       ; R0_w=-9223372036854775808
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775807
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775807 R1_w=scalar(umin=9223372036854775568,umax=9223372036854775809)
>   13: (b7) r0 = 0                       ; R0_w=0
>   14: (95) exit
> 
>   from 12 to 11: R0_w=-9223372036854775807 R1_w=scalar(umin=9223372036854775810,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff)) R2_w=pkt(off=0,r=1,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775806
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775806 R1_w=scalar(umin=9223372036854775810,umax=9223372036854775810,var_off=(0x8000000000000000; 0xffffffff))
>   13: safe
> 
>   [...]
> 
>   from 12 to 11: R0_w=-9223372036854775795 R1=scalar(umin=9223372036854775822,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff)) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775794
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775794 R1=scalar(umin=9223372036854775822,umax=9223372036854775822,var_off=(0x8000000000000000; 0xffffffff))
>   13: safe
> 
>   from 12 to 11: R0_w=-9223372036854775794 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff)) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775793
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>   13: safe
> 
>   from 12 to 11: R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff)) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775792
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775792 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>   13: safe
> 
>   [...]
> 
> The 64bit umin=9223372036854775810 bound continuously bumps by +1 while
> umax=9223372036854775823 stays as-is until the verifier complexity limit
> is reached and the program gets finally rejected. During this simulation,
> the umin also eventually surpasses umax. Looking at the first 'from 12
> to 11' output line from the loop, R1 has the following state:
> 
>   R1_w=scalar(umin=0x8000000000000002 (9223372036854775810),
>               umax=0x800000000000000f (9223372036854775823),
>           var_off=(0x8000000000000000;
>                            0xffffffff))
> 
> The var_off has technically not an inconsistent state but it's very
> imprecise and far off surpassing 64bit umax bounds whereas the expected
> output refining bits in var_off should have been like:
> 
>   R1_w=scalar(umin=0x8000000000000002 (9223372036854775810),
>               umax=0x800000000000000f (9223372036854775823),
>           var_off=(0x8000000000000000;
>                                   0xf))
> 
> In the above log, var_off stays as var_off=(0x8000000000000000; 0xffffffff)
> and does not converge into a narrower mask where more bits become known,
> eventually transforming R1 into a constant upon umin=9223372036854775823,
> umax=9223372036854775823 case where the verifier would have terminated and
> let the program pass.
> 
> The __reg_combine_64_into_32() marks the subregister unknown and propagates
> 64bit {s,u}min/{s,u}max bounds to their 32bit equivalents iff they are within
> the 32bit universe. The question came up whether __reg_combine_64_into_32()
> should special case the situation that when 64bit {s,u}min bounds have
> the same value as 64bit {s,u}max bounds to then assign the latter as
> well to the 32bit reg->{s,u}32_{min,max}_value. As can be seen from the
> above example however, that is just /one/ special case and not a /generic/
> solution given above example would still not be addressed this way and
> remain at an imprecise var_off=(0x8000000000000000; 0xffffffff).
> 
> The improvement is needed in __reg_bound_offset() to refine var32_off with
> the updated var64_off instead of the prior reg->var_off. The reg_bounds_sync()
> code first refines information about the register's min/max bounds via
> __update_reg_bounds() from the current var_off, then in __reg_deduce_bounds()
> from sign bit and with the potentially learned bits from bounds it'll
> update the var_off tnum in __reg_bound_offset(). For example, intersecting
> with the old var_off might have improved bounds slightly, e.g. if umax
> was 0x7f...f and var_off was (0; 0xf...fc), then new var_off will then
> result in (0; 0x7f...fc). The intersected var64_off holds then the
> universe which is a superset of var32_off. The point for the latter is
> not to broaden, but to further refine known bits based on the intersection
> of var_off with 32 bit bounds, so that we later construct the final var_off
> from upper and lower 32 bits. The final __update_reg_bounds() can then
> potentially refine bounds if more bits became known from new var_off.
> 
> After the improvement, we can see R1 converging successively:
> 
>   func#0 @0
>   0: R1=ctx(off=0,imm=0) R10=fp0
>   0: (61) r2 = *(u32 *)(r1 +0)          ; R1=ctx(off=0,imm=0) R2_w=pkt(off=0,r=0,imm=0)
>   1: (61) r3 = *(u32 *)(r1 +4)          ; R1=ctx(off=0,imm=0) R3_w=pkt_end(off=0,imm=0)
>   2: (bf) r1 = r2                       ; R1_w=pkt(off=0,r=0,imm=0) R2_w=pkt(off=0,r=0,imm=0)
>   3: (07) r1 += 1                       ; R1_w=pkt(off=1,r=0,imm=0)
>   4: (2d) if r1 > r3 goto pc+8          ; R1_w=pkt(off=1,r=1,imm=0) R3_w=pkt_end(off=0,imm=0)
>   5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff)) R2_w=pkt(off=0,r=1,imm=0)
>   6: (18) r0 = 0x7fffffffffffff10       ; R0_w=9223372036854775568
>   8: (0f) r1 += r0                      ; R0_w=9223372036854775568 R1_w=scalar(umin=9223372036854775568,umax=9223372036854775823,s32_min=-240,s32_max=15)
>   9: (18) r0 = 0x8000000000000000       ; R0_w=-9223372036854775808
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775807
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775807 R1_w=scalar(umin=9223372036854775568,umax=9223372036854775809)
>   13: (b7) r0 = 0                       ; R0_w=0
>   14: (95) exit
> 
>   from 12 to 11: R0_w=-9223372036854775807 R1_w=scalar(umin=9223372036854775810,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2_w=pkt(off=0,r=1,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775806
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775806 R1_w=-9223372036854775806
>   13: safe
> 
>   from 12 to 11: R0_w=-9223372036854775806 R1_w=scalar(umin=9223372036854775811,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2_w=pkt(off=0,r=1,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775805
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775805 R1_w=-9223372036854775805
>   13: safe
> 
>   [...]
> 
>   from 12 to 11: R0_w=-9223372036854775798 R1=scalar(umin=9223372036854775819,umax=9223372036854775823,var_off=(0x8000000000000008; 0x7),s32_min=8,s32_max=15,u32_min=8,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775797
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775797 R1=-9223372036854775797
>   13: safe
> 
>   from 12 to 11: R0_w=-9223372036854775797 R1=scalar(umin=9223372036854775820,umax=9223372036854775823,var_off=(0x800000000000000c; 0x3),s32_min=12,s32_max=15,u32_min=12,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775796
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775796 R1=-9223372036854775796
>   13: safe
> 
>   from 12 to 11: R0_w=-9223372036854775796 R1=scalar(umin=9223372036854775821,umax=9223372036854775823,var_off=(0x800000000000000c; 0x3),s32_min=12,s32_max=15,u32_min=12,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775795
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775795 R1=-9223372036854775795
>   13: safe
> 
>   from 12 to 11: R0_w=-9223372036854775795 R1=scalar(umin=9223372036854775822,umax=9223372036854775823,var_off=(0x800000000000000e; 0x1),s32_min=14,s32_max=15,u32_min=14,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775794
>   12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775794 R1=-9223372036854775794
>   13: safe
> 
>   from 12 to 11: R0_w=-9223372036854775794 R1=-9223372036854775793 R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
>   11: (07) r0 += 1                      ; R0_w=-9223372036854775793
>   12: (ad) if r0 < r1 goto pc-2
>   last_idx 12 first_idx 12
>   parent didn't have regs=1 stack=0 marks: R0_rw=P-9223372036854775801 R1_r=scalar(umin=9223372036854775815,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
>   last_idx 11 first_idx 11
>   regs=1 stack=0 before 11: (07) r0 += 1
>   parent didn't have regs=1 stack=0 marks: R0_rw=P-9223372036854775805 R1_rw=scalar(umin=9223372036854775812,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2_w=pkt(off=0,r=1,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
>   last_idx 12 first_idx 0
>   regs=1 stack=0 before 12: (ad) if r0 < r1 goto pc-2
>   regs=1 stack=0 before 11: (07) r0 += 1
>   regs=1 stack=0 before 12: (ad) if r0 < r1 goto pc-2
>   regs=1 stack=0 before 11: (07) r0 += 1
>   regs=1 stack=0 before 12: (ad) if r0 < r1 goto pc-2
>   regs=1 stack=0 before 11: (07) r0 += 1
>   regs=1 stack=0 before 9: (18) r0 = 0x8000000000000000
>   last_idx 12 first_idx 12
>   parent didn't have regs=2 stack=0 marks: R0_rw=P-9223372036854775801 R1_r=Pscalar(umin=9223372036854775815,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
>   last_idx 11 first_idx 11
>   regs=2 stack=0 before 11: (07) r0 += 1
>   parent didn't have regs=2 stack=0 marks: R0_rw=P-9223372036854775805 R1_rw=Pscalar(umin=9223372036854775812,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2_w=pkt(off=0,r=1,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
>   last_idx 12 first_idx 0
>   regs=2 stack=0 before 12: (ad) if r0 < r1 goto pc-2
>   regs=2 stack=0 before 11: (07) r0 += 1
>   regs=2 stack=0 before 12: (ad) if r0 < r1 goto pc-2
>   regs=2 stack=0 before 11: (07) r0 += 1
>   regs=2 stack=0 before 12: (ad) if r0 < r1 goto pc-2
>   regs=2 stack=0 before 11: (07) r0 += 1
>   regs=2 stack=0 before 9: (18) r0 = 0x8000000000000000
>   regs=2 stack=0 before 8: (0f) r1 += r0
>   regs=3 stack=0 before 6: (18) r0 = 0x7fffffffffffff10
>   regs=2 stack=0 before 5: (71) r1 = *(u8 *)(r2 +0)
>   13: safe
> 
>   from 4 to 13: safe
>   verification time 322 usec
>   stack depth 0
>   processed 56 insns (limit 1000000) max_states_per_insn 1 total_states 3 peak_states 3 mark_read 1
> 
> Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
> Reported-by: Xu Kuohai <xukuohai@huaweicloud.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Link: https://lore.kernel.org/bpf/20230314203424.4015351-2-xukuohai@huaweicloud.com
> ---
>  kernel/bpf/verifier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d517d13878cf..d66e70707172 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1823,9 +1823,9 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
>  	struct tnum var64_off = tnum_intersect(reg->var_off,
>  					       tnum_range(reg->umin_value,
>  							  reg->umax_value));
> -	struct tnum var32_off = tnum_intersect(tnum_subreg(reg->var_off),
> -						tnum_range(reg->u32_min_value,
> -							   reg->u32_max_value));
> +	struct tnum var32_off = tnum_intersect(tnum_subreg(var64_off),
> +					       tnum_range(reg->u32_min_value,
> +							  reg->u32_max_value));
>  
>  	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
>  }
> -- 
> 2.27.0
> 

LGTM this was just an oversight in the original patch.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
