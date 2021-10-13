Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA74942C67E
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhJMQht (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 12:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhJMQhs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Oct 2021 12:37:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A032EC061570
        for <bpf@vger.kernel.org>; Wed, 13 Oct 2021 09:35:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id g5so2234068plg.1
        for <bpf@vger.kernel.org>; Wed, 13 Oct 2021 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uzqPuPvEqfPnm1dmi3ANZcURtm2bYDvFZQ4aiz6LF9o=;
        b=IdLe+ElX0ohjfpgDjE6qWmaOsu/q8/rQK7A7Gq/IcBHCbcoJiePQvlBTG01vszVEhQ
         8Du4bq4f/wBEwoPVNfvkH6UssGWc27YoQNImoO0IcCG8v8I/BF06pwpxzN30f8AI2asu
         UqigVCNa/+binStzgOcfk3IAJpXyTLcW65YbPl0MyaWcWlmAAVpVC0sIIxkr1KOS0Ipo
         dB+vfgplddL20APBvc1LwTLh1kl/MjNFXhG96TpKyX3oPlEb1qO5tZeqpbkcwg7ALhqR
         g2SXE61T+f+wiSvtv2/zkdp9udsZ07390dX7ZSWgVpVvWEj11YYiyOilgdBUSQiZI1oZ
         lrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uzqPuPvEqfPnm1dmi3ANZcURtm2bYDvFZQ4aiz6LF9o=;
        b=iQfKiHcQlWkHUKjNPnFPrK5kaN4KJyWu7v3sfprvEnxD/2IZAobbJ/BE9FAriJjxF/
         ew9rPrak4nRi29yEhk50H7GwL9ZlxJaMgH2oyMESkO5Kqd3T5AgySn4QrKQuoiD1yl0p
         3k9l76nNCYnSrVvE6SbdIgV0Fr8sx9QDhVxijsKif01BlFaHY1qJgMptenlqX26npvaY
         3Ms3/6DOSJvmrYioZflEls5iF6VcBIvd3BRf7cQYVhmrEVKkQiwbMQTXoPXoHGfA2UtF
         dYiJ+JuAY3AipI7879F4I65smkhBNX938cdykjiZu9nTMlyHdQFh27kaaBBVsZ1HyRpP
         egYA==
X-Gm-Message-State: AOAM530Cflz7HRhhimNlknf4BadTGqkKecQ9szxk7oIK28HiCs1LvPy+
        aG7YOYgqaK9PWagh8q2dCx48EkfZUfec5A==
X-Google-Smtp-Source: ABdhPJxynzcGbcGK2kFO2nyNkNGt9N7HAI1kjmxoYKLq3PZwFqfjy56Ehk6jW0Zbi4qSbQUqeXqQ0g==
X-Received: by 2002:a17:90a:193:: with SMTP id 19mr14663179pjc.164.1634142945033;
        Wed, 13 Oct 2021 09:35:45 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id p31sm34268pfw.201.2021.10.13.09.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 09:35:44 -0700 (PDT)
To:     bpf <bpf@vger.kernel.org>
Cc:     alan.maguire@oracle.com
From:   Hengqi Chen <hengqi.chen@gmail.com>
Subject: BUG: Ksnoop tool failed to pass the BPF verifier with recent kernel
 changes
Message-ID: <800ce502-8f63-8712-7ed4-d3124a5fd6fb@gmail.com>
Date:   Thu, 14 Oct 2021 00:35:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, BPF community,


I would like to report a possible bug in bpf-next,
hope I don't make any stupid mistake. Here is the details:

I have two VMs:

One has the kernel built against the following commit:

0693b27644f04852e46f7f034e3143992b658869 (bpf-next)

The ksnoop tool (from BCC repo) works well on this VM.


Another has the kernel built against the following commit:

5319255b8df9271474bc9027cabf82253934f28d (bpf-next)

On this VM, the ksnoop tool failed with the following message:


libbpf: load bpf program failed: Permission denied

libbpf: -- BEGIN DUMP LOG ---

libbpf: 

R1 type=ctx expected=fp

; return ksnoop(ctx, false);

0: (b7) r2 = 0

1: (85) call pc+2

caller:

 R10=fp0

callee:

 frame1: R1=ctx(id=0,off=0,imm=0) R2_w=invP0 R10=fp0

; static int ksnoop(struct pt_regs *ctx, bool entry)

4: (7b) *(u64 *)(r10 -168) = r2

5: (bf) r9 = r1

; task = bpf_get_current_task();

6: (85) call bpf_get_current_task#35

; task = bpf_get_current_task();

7: (7b) *(u64 *)(r10 -16) = r0

8: (bf) r2 = r10

; 

9: (07) r2 += -16

; func_stack = bpf_map_lookup_elem(&ksnoop_func_stack, &task);

10: (18) r1 = 0xffff8c70353f3c00

12: (85) call bpf_map_lookup_elem#1

13: (bf) r7 = r0

; if (!func_stack) {

14: (55) if r7 != 0x0 goto pc+35

 frame1: R0=invP0 R7_w=invP0 R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-168=00000000

15: (b7) r1 = 0

; struct func_stack new_stack = {};

16: (7b) *(u64 *)(r10 -24) = r1

17: (7b) *(u64 *)(r10 -32) = r1

18: (7b) *(u64 *)(r10 -40) = r1

19: (7b) *(u64 *)(r10 -48) = r1

20: (7b) *(u64 *)(r10 -56) = r1

21: (7b) *(u64 *)(r10 -64) = r1

22: (7b) *(u64 *)(r10 -72) = r1

23: (7b) *(u64 *)(r10 -80) = r1

24: (7b) *(u64 *)(r10 -88) = r1

25: (7b) *(u64 *)(r10 -96) = r1

26: (7b) *(u64 *)(r10 -104) = r1

27: (7b) *(u64 *)(r10 -112) = r1

28: (7b) *(u64 *)(r10 -120) = r1

29: (7b) *(u64 *)(r10 -128) = r1

30: (7b) *(u64 *)(r10 -136) = r1

31: (7b) *(u64 *)(r10 -144) = r1

32: (7b) *(u64 *)(r10 -152) = r1

; new_stack.task = task;

33: (79) r1 = *(u64 *)(r10 -16)

; new_stack.task = task;

34: (7b) *(u64 *)(r10 -160) = r1

35: (bf) r7 = r10

; struct func_stack new_stack = {};

36: (07) r7 += -16

37: (bf) r3 = r10

38: (07) r3 += -160

; bpf_map_update_elem(&ksnoop_func_stack, &task, &new_stack,

39: (18) r1 = 0xffff8c70353f3c00

41: (bf) r2 = r7

42: (b7) r4 = 1

43: (85) call bpf_map_update_elem#2

; func_stack = bpf_map_lookup_elem(&ksnoop_func_stack, &task);

44: (18) r1 = 0xffff8c70353f3c00

46: (bf) r2 = r7

47: (85) call bpf_map_lookup_elem#1

48: (bf) r7 = r0

49: (15) if r7 == 0x0 goto pc+483

 frame1: R0_w=map_value(id=0,off=0,ks=8,vs=144,imm=0) R7_w=map_value(id=0,off=0,ks=8,vs=144,imm=0) R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=mmmmmmmm fp-120=mmmmmmmm fp-128=mmmmmmmm fp-136=mmmmmmmm fp-144=mmmmmmmm fp-152=mmmmmmmm fp-160=mmmmmmmm fp-168=00000000

; stack_depth = func_stack->stack_depth;

50: (71) r6 = *(u8 *)(r7 +136)

 frame1: R0_w=map_value(id=0,off=0,ks=8,vs=144,imm=0) R7_w=map_value(id=0,off=0,ks=8,vs=144,imm=0) R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=mmmmmmmm fp-120=mmmmmmmm fp-128=mmmmmmmm fp-136=mmmmmmmm fp-144=mmmmmmmm fp-152=mmmmmmmm fp-160=mmmmmmmm fp-168=00000000

; if (stack_depth > FUNC_MAX_STACK_DEPTH)

51: (25) if r6 > 0x10 goto pc+481

 frame1: R0_w=map_value(id=0,off=0,ks=8,vs=144,imm=0) R6_w=invP(id=0,umax_value=16,var_off=(0x0; 0xff),s32_max_value=255,u32_max_value=255) R7_w=map_value(id=0,off=0,ks=8,vs=144,imm=0) R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=mmmmmmmm fp-120=mmmmmmmm fp-128=mmmmmmmm fp-136=mmmmmmmm fp-144=mmmmmmmm fp-152=mmmmmmmm fp-160=mmmmmmmm fp-168=00000000

; if (entry) {

52: (79) r1 = *(u64 *)(r10 -168)

53: (15) if r1 == 0x0 goto pc+74

; if (stack_depth == 0 || stack_depth >= FUNC_MAX_STACK_DEPTH)

128: (15) if r6 == 0x0 goto pc+404

 frame1: R0=map_value(id=0,off=0,ks=8,vs=144,imm=0) R1=invP0 R6=invP(id=0,umax_value=16,var_off=(0x0; 0x1f)) R7=map_value(id=0,off=0,ks=8,vs=144,imm=0) R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=mmmmmmmm fp-120=mmmmmmmm fp-128=mmmmmmmm fp-136=mmmmmmmm fp-144=mmmmmmmm fp-152=mmmmmmmm fp-160=mmmmmmmm fp-168=00000000

129: (25) if r6 > 0xf goto pc+403

 frame1: R0=map_value(id=0,off=0,ks=8,vs=144,imm=0) R1=invP0 R6=invP(id=0,umax_value=15,var_off=(0x0; 0x1f),s32_max_value=16,u32_max_value=16) R7=map_value(id=0,off=0,ks=8,vs=144,imm=0) R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=mmmmmmmm fp-120=mmmmmmmm fp-128=mmmmmmmm fp-136=mmmmmmmm fp-144=mmmmmmmm fp-152=mmmmmmmm fp-160=mmmmmmmm fp-168=00000000

130: (b7) r1 = 0

; if (stack_depth > 0)

131: (15) if r6 == 0x0 goto pc+2

 frame1: R0=map_value(id=0,off=0,ks=8,vs=144,imm=0) R1_w=invP0 R6=invP(id=0,umax_value=15,var_off=(0x0; 0xf)) R7=map_value(id=0,off=0,ks=8,vs=144,imm=0) R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=mmmmmmmm fp-120=mmmmmmmm fp-128=mmmmmmmm fp-136=mmmmmmmm fp-144=mmmmmmmm fp-152=mmmmmmmm fp-160=mmmmmmmm fp-168=00000000

132: (bf) r1 = r6

133: (07) r1 += -1

; ip = func_stack->ips[stack_depth];

134: (bf) r2 = r1

135: (57) r2 &= 255

136: (67) r2 <<= 3

; last_ip = func_stack->ips[last_stack_depth];

137: (bf) r3 = r7

138: (07) r3 += 8

; ip = func_stack->ips[stack_depth];

139: (bf) r4 = r3

140: (0f) r4 += r2

; last_ip = func_stack->ips[last_stack_depth];

141: (67) r6 <<= 3

142: (0f) r3 += r6

; ip = func_stack->ips[stack_depth];

143: (79) r2 = *(u64 *)(r4 +0)

 frame1: R0=map_value(id=0,off=0,ks=8,vs=144,imm=0) R1_w=invP(id=4,smin_value=-1,smax_value=14) R2_w=invP(id=0,umax_value=2040,var_off=(0x0; 0x7f8)) R3_w=map_value(id=0,off=8,ks=8,vs=144,umax_value=120,var_off=(0x0; 0x78)) R4_w=map_value(id=0,off=8,ks=8,vs=144,umax_value=2040,var_off=(0x0; 0x7f8)) R6_w=invP(id=0,umax_value=120,var_off=(0x0; 0x78)) R7=map_value(id=0,off=0,ks=8,vs=144,imm=0) R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=mmmmmmmm fp-120=mmmmmmmm fp-128=mmmmmmmm fp-136=mmmmmmmm fp-144=mmmmmmmm fp-152=mmmmmmmm fp-160=mmmmmmmm fp-168=00000000

invalid access to map value, value_size=144 off=2048 size=8

R4 max value is outside of the allowed memory range

processed 65 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 2



libbpf: -- END LOG --

libbpf: failed to load program 'kprobe_return'

libbpf: failed to load object 'ksnoop_bpf'

libbpf: failed to load BPF skeleton 'ksnoop_bpf': -4007

Error: Could not load ksnoop BPF: Unknown error 4007
