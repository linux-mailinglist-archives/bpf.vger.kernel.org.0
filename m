Return-Path: <bpf+bounces-2145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE1728906
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 21:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A872817BD
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5942D244;
	Thu,  8 Jun 2023 19:52:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F71F187
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 19:52:21 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2904210D
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 12:52:19 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-78a065548e3so406546241.0
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686253938; x=1688845938;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZSrkXUCvZWA/pSkR306E5n/eGUCjotvwFy9oD8Cc8s=;
        b=EuQ3Xn9N90s87cuss++kjEaQTuo+AbhtLu3P7SNEFvPkP8cYmrgCmUflylANOohcQz
         izkUjjfzAxToXKSX8fXY5fiESxAJiL9pPEFUP3csYZ84f3NUDu7fAafCxTO0KJe+Gx1Q
         c0tNkTkKvuYRtuJjujiBNarBLBRdgS183vjLSjgC1AumNQ/KnF/4xBHgh4Z7HhrILoLO
         x4LYlh0DMb7VAsnjHiDnVJbWhxwu9yfQRdv/82ZtSqiD7krlFAQfFRq7n0rSROkeClvS
         Nh8SOI4ftN1bdJ7zj4nXCBGbh4s8o2nHIS/W7RWZ8A6Vv8OTeNXUzy/fVBJ/euJ33lWI
         /PAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253938; x=1688845938;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZSrkXUCvZWA/pSkR306E5n/eGUCjotvwFy9oD8Cc8s=;
        b=FWURjHPCe0PQ1SJNNmEBETuixuqyuk/+r2P+FIO+qewCgPk4NjXcKKnIUU/BUoHNXO
         Ijx6bo0sD9DNv8LJ3ufSo4DIFdwZME9ILrmiFbbQs0xkj4SWOJ6WZDelfhwGjogBhyj8
         TnzXptzTT8taM3SszaUbtsXzuLKk1TEMp3g5jQF81RBGq4/NnZRapsj1KHdun96fU8m8
         m9LBlkN/FPkHcnGOnjCdb069fMQxpjZXJHv/t3NtNMJIOPmUqVQI353Xh7Ylwh5oxW8H
         Yoiyy0mJBECC0V1o6XLCcpApIRjU7gtivHIjpduAceybeZwCyGs1D3yORWprd5AaNwJz
         DLnA==
X-Gm-Message-State: AC+VfDwKvPLdWEFBwnOAghD48xy0C2wSUAANlNhYRRE4e1bz5ndQ/Cve
	8mZtNpJgyGJfp0D+QhljEpn8R3hBGxUZHJQh0D5vycLWq0c=
X-Google-Smtp-Source: ACHHUZ7hSnTBZ00ZNDVidvUIpRZ5GaMcfS+Dt29AaOCJJ9b89YiriODMTlzAQtuQipnpfQTgBvgpVqq7xpj9qjxeFZ0=
X-Received: by 2002:a67:cd91:0:b0:43b:3cf8:bead with SMTP id
 r17-20020a67cd91000000b0043b3cf8beadmr3371872vsl.0.1686253938481; Thu, 08 Jun
 2023 12:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Date: Fri, 9 Jun 2023 03:52:07 +0800
Message-ID: <CAFmV8NeH2zLhSY1RMos18OMEnU81ieCMG0aNtN14BGh_Y7Nzwg@mail.gmail.com>
Subject: [BUG] optimizations for branch cause bpf verification to fail
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,  everyone.

Recently, I've been doing some work using eBPF techniques. A situation was
encountered in which a program was rejected by the verifier.

Iterate over different maps under different conditions. It should be a good idea
to use map-of-maps when there are lots of maps. I use if cond for a quick test.

It looks like this:

int foo(struct xdp_md *ctx)
{
   void *data_end = (void *)(long)ctx->data_end;
   void *data = (void *)(long)ctx->data;
   struct callback_ctx cb_data;

   cb_data.output = 0;

   if (data_end - data > 1024) {
       bpf_for_each_map_elem(&map1, cb, &cb_data, 0);
   } else {
       bpf_for_each_map_elem(&map2, cb, &cb_data, 0);
   }

   if (cb_data.output)
       return XDP_DROP;

   return XDP_PASS;
}

Compile by clang-15 with optimization level O2:

0000000000000000 <foo>:
;     void *data = (void *)(long)ctx->data;
0:       61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
;     void *data_end = (void *)(long)ctx->data_end;
1:       61 13 04 00 00 00 00 00 r3 = *(u32 *)(r1 + 4)
;     if (data_end - data > 1024) {
2:       1f 23 00 00 00 00 00 00 r3 -= r2
3:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
5:       65 03 02 00 00 04 00 00 if r3 s> 1024 goto +2 <LBB0_2>
6:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
0000000000000040 <LBB0_2>:
8:       b7 02 00 00 00 00 00 00 r2 = 0
;     cb_data.output = 0;
9:       63 2a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) = r2
10:       bf a3 00 00 00 00 00 00 r3 = r10
11:       07 03 00 00 f8 ff ff ff r3 += -8
12:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
14:       b7 04 00 00 00 00 00 00 r4 = 0
15:       85 00 00 00 a4 00 00 00 call 164
16:       b7 00 00 00 02 00 00 00 r0 = 2
;     if (cb_data.output)
17:       61 a1 f8 ff 00 00 00 00 r1 = *(u32 *)(r10 - 8)
; }
18:       15 01 01 00 00 00 00 00 if r1 == 0 goto +1 <LBB0_4>
19:       b7 00 00 00 01 00 00 00 r0 = 1
00000000000000a0 <LBB0_4>:
; }
20:       95 00 00 00 00 00 00 00 exit

When loading the prog, the verifier complained "tail_call abusing map_ptr".
The Compiler's optimizations look fine, so I took a quick look at the code of
the verifier.

The function record_func_map called by check_helper_call will ref the current
map in bpf_insn_aux_data of current insn. After the current branch ends,
pop stack and enter another branch, but the relevant state is not cleared.
This time, record_func_map set BPF_MAP_PTR_POISON as the map state.
At the start of set_map_elem_callback_state, poisoned state causing EINVAL.

I'm not very familiar with BPF. If it is designed like this, it is
customary to add
options on the compiler side to avoid it, then please let me know.

Thanks,
Zhongqiu

