Return-Path: <bpf+bounces-7165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B604C77267B
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 15:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DF31C20C41
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349910946;
	Mon,  7 Aug 2023 13:48:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F76107A0;
	Mon,  7 Aug 2023 13:48:46 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E510E2;
	Mon,  7 Aug 2023 06:48:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so5874706a12.2;
        Mon, 07 Aug 2023 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691416122; x=1692020922;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPIx8EZcuvxWfdbA6NbH4db5tWSFzcsuDpYZ0i60n1A=;
        b=NwKzhFHHrGTkbH/+TvGBsJJlbF0T2UWM3/oO6ClLad1Jn5ohFvrfZIccwTNX0kNIuq
         2pYWCkNiNs+mGcNPKnYr6NEJzaVqMx6mah3WpzblJr9O7DYng7AWHmEEzQEG07rRM/n0
         CUycTDsW38N6ov/EAcFrMNpKa/BGxZGcVMRWdKWhs7ZkycqefKV6Z/HqZRyTB82pDbNG
         HrH9GZsVMBLwtZtvrLw5RQvDA9wSgWgLUC8ZO84GHwBRIMwSED+3ITajmx7AqE2UCG7Z
         Uw2ZZOe1L7Rm2xtIV0emhn43EWg43vC3+eA9V+yLmvhCkWVpF+4zPilDkbUH98qDPeAw
         JrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416122; x=1692020922;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IPIx8EZcuvxWfdbA6NbH4db5tWSFzcsuDpYZ0i60n1A=;
        b=ANPS6AphClrxiAPRo/1Y83sKCRJJyVgRuBGJey4E6DlOTWRqTCa08A6rPS+GDEPeCG
         0OCTcbaH2GiETKFGcG5BElEDZz1MYWU8vbLbVhNqwm1qmpYz2vkDE4yqhdrY67VkIyFa
         Dr2i7BQLZbId0uJdpzH6i/mY5hoY8L2i0qof7GNnFNgCbvq4AeOrADQSHtVDFDP+xyds
         c6mr1AY8H8za9UO4FDflWSVyCPM3Y1e8kMA0XmgNU8/4t+boAPPUSLIfAtTMvl+bfRb/
         +aRpAeJKl21DxSYScO9qjPlSu0QwgA21ZUynLMLozWogBUwAtGSdcHKcYC72SE8oXS9P
         vNBQ==
X-Gm-Message-State: AOJu0YwEdMV/yJ1GH9ACSfabDT+qHxqVEeNTX7Oqp45fOtBPHgZ2zHfd
	yUq0rryMJNrOl6U0t15txK4=
X-Google-Smtp-Source: AGHT+IEhZLlO7uV4KSBWNATjPjlNnWvOVhucZAbCmZZ2qeKkD3T1f0puZTLTGrcqTw0jTVhyzsGmFA==
X-Received: by 2002:a50:ef0c:0:b0:523:9c4:544f with SMTP id m12-20020a50ef0c000000b0052309c4544fmr7546875eds.31.1691416122229;
        Mon, 07 Aug 2023 06:48:42 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7c2cd000000b0051df54c6a27sm5195834edp.56.2023.08.07.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:48:41 -0700 (PDT)
Message-ID: <74c9a88d79b7c65e2fdc2dc1609e13590225cb60.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in
 ieee802154_subif_start_xmit
From: Eduard Zingerman <eddyz87@gmail.com>
To: yonghong.song@linux.dev, syzbot
 <syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com>, andrii@kernel.org,
  ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 davem@davemloft.net,  haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org,  kpsingh@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,  martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
 syzkaller-bugs@googlegroups.com
Date: Mon, 07 Aug 2023 16:48:40 +0300
In-Reply-To: <9c8f04a0bf90db4bb8e6192824ab71f58244b74b.camel@gmail.com>
References: <0000000000002098bc0602496cc3@google.com>
	 <d520bd6c-bfd3-47f1-c794-ab451905256b@linux.dev>
	 <9c8f04a0bf90db4bb8e6192824ab71f58244b74b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-08-07 at 16:11 +0300, Eduard Zingerman wrote:
[...]
>   $ bpftool prog dump jited id <some-id>
>   bpf_prog_ebeed182d92b487f:
>      0: nopl    (%rax,%rax)
>      5: nop
>      7: pushq   %rbp
>      8: movq    %rsp, %rbp
>      b: subq    $8, %rsp
>     12: movl    $553656332, -8(%rbp)
>     19: movswq  %bp, %rdi            ; <---- Note movswq %bp !
>     1d: addq    $-8, %rdi
>     21: movl    $3, %esi
>     26: cmpq    %rdi, %rsi
>     29: jbe 0x2b
>     2b: callq   0xffffffffe11c484c
>     30: xorl    %eax, %eax
>     32: leave
>     33: retq
>=20
> Note jit instruction #19 corresponding to BPF instruction #1, which
> loads truncated and sign-extended value of %rbp's first byte as an
> address of format string.

Correction: sign-extended value of %rbp's first *two* bytes,
disassembly with opcodes:

  19:	movswq	%bp, %rdi
    48 0f bf fd=20

[...]

