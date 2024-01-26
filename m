Return-Path: <bpf+bounces-20377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC4A83D3F6
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 06:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A95C286CD6
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 05:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD69BA57;
	Fri, 26 Jan 2024 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wgMuTF18"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C448820
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706247265; cv=none; b=MTZZ5vmJIFTRfPkYZLVrkFoVArL5/0G6dRQ345xwhycZ8f2sy1Xt+0K4RiweWQgNWKmna0KESLU5cJLwZPlFRVikUQru/iOjWBQyIh7dTUwxNdaqa+OL9mY7jPBXSdq7EBzDyAsF8YwH5zPRiKzboCPMR4xV6easf2DKZySUQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706247265; c=relaxed/simple;
	bh=1AEUHJt6JdqLU9k2Vd/5lX/PGAVTjP+enuTeCuMbL9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXqOkMqIYN5iyoCnszhwcfCx6KcVfX/Hvat23B+fkqWvmavUKc5NPf0H9YTuOEDWNHXlQ5fPAy7uQOPVW6WKX+Ab9YaS/2CFy0NWRFeq8zWgEUhOXL+B++b7G4muCdDaiA0MrYb1Xl+KCFzyo4MOCpFUeS7777tYlUl8ri/70fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wgMuTF18; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc839efe-2382-440d-bcf6-b9ddc252f35e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706247260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CA59L9GtSGgO1jYtOLfxOapEWrvCPTs90D+n++NKfLk=;
	b=wgMuTF183vWKZtGQvgEYciYidqlptXcFMMUoYDuEUMe8wXDwhSvl0XPSaLnL1ugA398BJx
	aRyvnMyeAB7NJe4RCSb7uYha0CMd7sx3QJOPj/Kg/bJJXUnonwR9afgxNOdhAk/SNS45zo
	JJgVmJjDB9VGowTC2Sgt3fPxzrjHC1w=
Date: Thu, 25 Jan 2024 21:34:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 64-bit immediate instructions clarification
Content-Language: en-GB
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
 <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
 <095f01da48e8$611687d0$23439770$@gmail.com>
 <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
 <1fc001da4e6a$2848cad0$78da6070$@gmail.com>
 <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev>
 <259a01da4ff4$adfe9c50$09fbd4f0$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <259a01da4ff4$adfe9c50$09fbd4f0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/25/24 5:12 PM, dthaler1968@googlemail.com wrote:
> The spec defines:
>> As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
>> instruction uses a 64-bit immediate value that is constructed as follows.
>> The 64 bits following the basic instruction contain a pseudo instruction
>> using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
>> and imm containing the high 32 bits of the immediate value.
> [...]
>> imm64 = (next_imm << 32) | imm
> The 64-bit immediate instructions section then says:
>> Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
>> encoding defined in `Instruction encoding`_, and use the 'src' field of the
>> basic instruction to hold an opcode subtype.
> Some instructions then nicely state how to use the full 64 bit immediate value, such as
>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64                                integer      integer
>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
> Others don't:
>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                       map fd       map
>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer
>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)                       integer      code pointer
>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)                      map index    map
> How is next_imm used in those four?  Must it be 0?  Or can it be anything and it's ignored?
> Or is it used for something?

The other four must have next_imm to be 0. No use of next_imm in thee four insns kindly implies this.
See uapi bpf.h for details (search BPF_PSEUDO_MAP_FD).

>
> Dave
>

