Return-Path: <bpf+bounces-9333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B010793DB1
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 15:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431FC1C20A4E
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB5510782;
	Wed,  6 Sep 2023 13:31:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8A2F5A
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 13:31:19 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E86170E
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 06:31:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-564b6276941so2516464a12.3
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1694007077; x=1694611877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFiIToPJJ6FCujPCd0yAiudON8W0oAyn/p/xhdheEPI=;
        b=TcJBJqViJQH0WUoGZHr2CeYzr6j2F49y85Irz2yRGUj62rcq3qhEISpjxEtMmnTRor
         ssFeCKpBJqcxEInoJyJ9Ye0nO/xCQqHKQOTHI0YF+figRCwMN67HO53l8oqzjmSgXmoF
         AvRSd4rmZ/83T0c9d4LgxWP2Gl0Yb9xaPZLwL8Vn0BHE2L+n5vWP4rdku0BQ4z+/F+qr
         WKVTa9hDPEBCrJCtcLK983/aNFNJ6qXIPahtelLHQ7ZVGMozvJrCVOHqGZcHS5kqidpu
         8heGV735cVM75WnBER7HQQTQxf1/dB2oyuoR7q0PiGH1P6fR++pMSQ8+Zk2R1kI6Bg50
         Lj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007077; x=1694611877;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFiIToPJJ6FCujPCd0yAiudON8W0oAyn/p/xhdheEPI=;
        b=FNzloLSqECMg3wEJr3v/cVJySjSjFGKr10GP8247xNW0CFnE0VDvUKhoE1QZRaAKIc
         aHzOA9oAp0l9KNvIlua0r9nS7OcXnCIB8XczurJPlThqCW8S3I5FJjSBNZYMM3WYooWL
         b8k77B6p+vagTsc44OhXrYs57FNkyiNMtAHSIeq007TGPMtfcRmwM6kMJh27ss6JbuQm
         wYFQ8ljEgSjaRBze66hRpkNy3LyiP42y9YvN0DATOKRMYpx7AhwgxF0gNElqxgUgy44T
         RtMJz3OutvBCtzQ+ZIHEUCEi0IV5RswvQ/j15nv2LGNYveqhGp0x9cs+V7BrISjAej7W
         iYTw==
X-Gm-Message-State: AOJu0YwFAaznfH4IgmTFPdApnEXW0q41mx16PzDQzbr2xrYXhesDxJlJ
	y5Fxc1d9HuLEQIuXbD8QKOW9qA==
X-Google-Smtp-Source: AGHT+IFwZpFgYNDB0gtie9f9xZT1VXEyo52isr74Zc0CNOQ3PnFA6lS5vlwt+yMD++Tx1IPK+2iobg==
X-Received: by 2002:a17:90b:1e4e:b0:268:46fb:df32 with SMTP id pi14-20020a17090b1e4e00b0026846fbdf32mr14983572pjb.34.1694007077128;
        Wed, 06 Sep 2023 06:31:17 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090aeb0500b0026b4d215627sm10973520pjz.21.2023.09.06.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:31:16 -0700 (PDT)
Date: Wed, 06 Sep 2023 06:31:16 -0700 (PDT)
X-Google-Original-Date: Wed, 06 Sep 2023 06:31:13 PDT (-0700)
Subject:     Re: [PATCH bpf-next v4 0/4] bpf, riscv: use BPF prog pack allocator in BPF JIT
In-Reply-To: <169396862749.1987.4994366714692856707.git-patchwork-notify@kernel.org>
CC: puranjay12@gmail.com, linux-riscv@lists.infradead.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, pulehui@huawei.com,
  Conor Dooley <conor.dooley@microchip.com>, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
  song@kernel.org, yhs@fb.com, kpsingh@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: patchwork-bot+linux-riscv@kernel.org
Message-ID: <mhng-b249bbd6-f716-44d4-88b9-2aa1e058641d@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 05 Sep 2023 19:50:27 PDT (-0700), patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
>
> This series was applied to riscv/linux.git (for-next)
> by Palmer Dabbelt <palmer@rivosinc.com>:
>
> On Thu, 31 Aug 2023 13:12:25 +0000 you wrote:
>> Changes in v3 -> v4:
>> 1. Add Acked-by:, Tested-by:, etc.
>> 2. Add the core BPF patch[3] which was earlier sent with ARM64 series to
>>    this series so it can go with this.
>>
>> Changes in v2 -> v3:
>> 1. Fix maximum width of code in patches from 80 to 100. [All patches]
>> 2. Add checks for ctx->ro_insns == NULL. [Patch 3]
>> 3. Fix check for edge condition where amount of text to set > 2 * pagesize
>>    [Patch 1 and 2]
>> 4. Add reviewed-by in patches.
>> 5. Adding results of selftest here:
>>    Using the command: ./test_progs on qemu
>>    Without the series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>    With this series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>
>> [...]
>
> Here is the summary with links:
>   - [bpf-next,v4,1/4] bpf: make bpf_prog_pack allocator portable
>     https://git.kernel.org/riscv/c/063119d90a06
>   - [bpf-next,v4,2/4] riscv: extend patch_text_nosync() for multiple pages
>     https://git.kernel.org/riscv/c/fb81d562ed1f
>   - [bpf-next,v4,3/4] riscv: implement a memset like function for text
>     https://git.kernel.org/riscv/c/f071fe652d73
>   - [bpf-next,v4,4/4] bpf, riscv: use prog pack allocator in the BPF JIT
>     https://git.kernel.org/riscv/c/19ea9d201008
>
> You are awesome, thank you!

Looks like I screwed up the merge a bit here, so these hashes have 
changed a bit.

