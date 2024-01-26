Return-Path: <bpf+bounces-20378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28A83D3F7
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 06:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985361F236C7
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 05:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0060BA57;
	Fri, 26 Jan 2024 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="FmHDacoy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="iBpVrQfy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wgMuTF18"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A529BA33
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706247272; cv=none; b=gnvvBzjZWkpmXA6Yyyyfowvbo33jAjezteGvqlNLhnb0ZM6dqZwqhlj3+96BbsxNM0rbAw7bNnOC+Q+gEPH1xxdQDSqklHZpk0j8oP4AAUGJTaBrajkVR5f4u5P4DZjBOGzr/mTRjc4mEGcIWZOW17ZCoNN5G6AhKNa0C6XgPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706247272; c=relaxed/simple;
	bh=HsruK93yxnVLp/qpTKktGNMID2pd0sid9uhjWXpSHwY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=aTk9g+HYZ6KgGuGUNWN8bh29f/P4Y8l9U0npsYP33zwmC+VPMl3kQZL5pOAFxLLDpqOtuLUurURspr5KmYP1JQQ/39Rpb3Yh94tHYXVJjVBELaA1K4weijq5ipd7W9lGYR+jVZ27ORpZlqwUgt/kIC1TMjqRiC2LLyzdq1Z4yeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=FmHDacoy; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=iBpVrQfy; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wgMuTF18 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0D44FC14F74E
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 21:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706247270; bh=HsruK93yxnVLp/qpTKktGNMID2pd0sid9uhjWXpSHwY=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=FmHDacoyvKfTXxNYjDZ6C2eG0RYdrEwvFFvBMiMx2iHP2bks3++A5cuktwF2eGebn
	 J8QFKNTvpVDFUvCjup544Kdda257yiqM2N5d1miewAMae+LCfXTsPbP4srM+gspFs3
	 f+XkIHpvhkP5ZdM6lSFkerkfKs/3V1/POeKeI+Ps=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jan 25 21:34:30 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D320CC14F5FE;
	Thu, 25 Jan 2024 21:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706247269; bh=HsruK93yxnVLp/qpTKktGNMID2pd0sid9uhjWXpSHwY=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=iBpVrQfydnP8iIxXREnwXSCwZyUfrmR73M5jVKxXTZFc5Oz/3eiE2I82Sm+da5VLo
	 UfNUAilCtd6SA+qa32JsU2T+elfT4bAizbKWMDKN4b9FEDgk6cUt8tqeCaCM8qLIc7
	 0iOvnqd3Xr2xQXE4XvP4/LI6HDmJ24/IwXFqGORI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6C84DC14F5FE
 for <bpf@ietfa.amsl.com>; Thu, 25 Jan 2024 21:34:28 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QPAT-d6JX9Ua for <bpf@ietfa.amsl.com>;
 Thu, 25 Jan 2024 21:34:24 -0800 (PST)
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id EFDA0C14F5E4
 for <bpf@ietf.org>; Thu, 25 Jan 2024 21:34:23 -0800 (PST)
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <259a01da4ff4$adfe9c50$09fbd4f0$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/pwc5s9Exl-GIzgQzbDbiELjmRX8>
Subject: Re: [Bpf] 64-bit immediate instructions clarification
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

