Return-Path: <bpf+bounces-14938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2D87E910F
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 14:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1BF1F20FDB
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EFF11736;
	Sun, 12 Nov 2023 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dof85J40"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6411170B
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 13:57:51 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4982688;
	Sun, 12 Nov 2023 05:57:50 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-da37522a363so3627370276.0;
        Sun, 12 Nov 2023 05:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699797470; x=1700402270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JmCML6DZIUdBN5mPM3vPCSjxreYY8475kZT74cg09ZM=;
        b=Dof85J40uhF18r0PF/wDPOiTALVOldvE+S/+lmiZhWGzU/aNvahfmga4wzRh7nOg61
         fnoUgrure/Q6MIE0+nbXrtg6dEfxcJUUKo/eCRWFIvD3K0kcF+Dag5sQzAl3z3UDf012
         iRiL5SS/i4ER41mGkqo4J9sSmx52YtcweWsPMaipo5qSRTgoOtGtUFc0Z3KKumYmu+kO
         YkC2LDRSlTMpItv276Twwi5wrqkB7sd79BAd2IbR6g60poGCNvJLKbShL8NDzUbj/wRi
         UZ1bjfbC8TYoESzBbaa0GtMWWdancSOi610M+OYogu1efRM420hqeSJAH83skFV+FBEf
         7uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699797470; x=1700402270;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmCML6DZIUdBN5mPM3vPCSjxreYY8475kZT74cg09ZM=;
        b=hH1bpgBtRz/Ofq3JOXk4Z7QnzIPB6vsB9SkOUMg9p9dv2EsySxwmNarV4wjiUTHSUS
         u2if9JN1R0PzFd/ybeBlYZnDkzE1qJKGT50Tk2a/HwQxEZdX9EfuHA7BX9cApiRnZzUP
         TxeKoFA+4XzWxtjUX4RJJ3oUxbEouXQsy02eWp/Y4LICPIplLDs+IihFJ2PzgTUYXMbn
         RzH+U6f4EC82+cSZVoDqYFwJtjkwmONiS/lHmiHmkxOnAXK4TjQqwTMQBbJyZJK2t1sQ
         Ur5GhpP4CtnEctknmOqMNJDLceAN0NNssPs64oIMBfD9CkDZJ2QOyUPtUDY//hUf96wI
         aRVg==
X-Gm-Message-State: AOJu0YzGjlUxnjKUvWIjk8yHf20XfaOZOtbAqudaeawXG2i+iqWrWuDY
	/NsPGet4yttdwWFrs9ll6C58lJMa3XOGuSbhJw==
X-Google-Smtp-Source: AGHT+IE9UI8wy4prJU4pUug/dOOJf0nqcm2wJNui7UWrQGi05G0q/HD0ephlqdD8h4lH5zzNgDTkcmax7RAR4KgYvpE=
X-Received: by 2002:a25:4c81:0:b0:daf:5d7b:bd4f with SMTP id
 z123-20020a254c81000000b00daf5d7bbd4fmr2300827yba.49.1699797469995; Sun, 12
 Nov 2023 05:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hao Sun <sunhao.th@gmail.com>
Date: Sun, 12 Nov 2023 14:57:38 +0100
Message-ID: <CACkBjsbUytfJS1ns0pp=o=Lk5qbQ5weD4_f8bPFrW5oV0tCXZw@mail.gmail.com>
Subject: bpf: incorrect stack_depth after var off stack access causes OOB
To: Andrei Matei <andreimatei1@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

The verifier allows stack access with var off, but the stack depth is
only updated
with `fix` off. For the following program, the verifier incorrectly
marks stack_depth
as 221, yet the smin of r8 is -12 and is overlooked, and thus the interpreter
incorrectly calls `__bpf_prog_run224`, leading to the OOB:

(bf) r6 = r10                      ; R6_w=fp0 R10=fp0
(bc) w8 = w6                       ; R6_w=fp0
R8_w=scalar(smin=0,smax=umax=429496729)
(47) r8 |= -12                     ;
R8_w=scalar(smin=smin32=-12,smax=smax32=-1,umin)
(0f) r8 += r10
(72) *(u8 *)(r8 -221) = -19       ;
R8_w=fp(off=0,smin=smin32=-12,smax=smax32=-1,..
(95) exit

verification time 231 usec
stack depth 221
processed 12 insns (limit 1000000) max_states_per_insn 0 total_states
0 peak_states 0 m0

This C program can cause a stack OOB access:
C Repro: https://pastebin.com/raw/5ReUbCar
OOB: https://pastebin.com/raw/DzVz3NDn

Andrei, you added support for stack access with var off in
`01f810ace9ed3`, in which only
`allocated_stack` is updated, should we also update stack depth?

Best
Hao Sun

