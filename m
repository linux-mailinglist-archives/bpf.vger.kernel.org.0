Return-Path: <bpf+bounces-19708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E001282FF66
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 04:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8981C23C88
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 03:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D453B4;
	Wed, 17 Jan 2024 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yH80jARS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="SQlFVkTh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mLOJ2qbQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3444696
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 03:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705463340; cv=none; b=ad/gf2cKH8ajwpkMI0xU86E6NoSRBBOl6rlvsH2NAqIyEf78xwCj3qq1qepHCR0JOaXETAZfsWMCofUl5dN7aAPHwPKvNN8gsGRfw+yvbvxOW7nxn9apKZKJzhzahKZ7rNfRixkmOCHvbeNWJkX+Kspmxa4yhY6BPsf0s+V/ZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705463340; c=relaxed/simple;
	bh=VxFplyoToX+5xGv60J8MONy6X6rHxKnru1jctRcfLFg=;
	h=Received:DKIM-Signature:X-Mailbox-Line:Received:DKIM-Signature:
	 X-Original-To:Delivered-To:Received:X-Virus-Scanned:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Message-ID:DKIM-Signature:Date:MIME-Version:Content-Language:To:Cc:
	 References:X-Report-Abuse:From:In-Reply-To:X-Migadu-Flow:
	 Archived-At:Subject:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Content-Transfer-Encoding:Content-Type:Errors-To:
	 Sender; b=hA4uw/bKsz0b7Vkfr8T3R9fkdzsGOLVvsmVIA7HkjfVNRuVim/mN8ktyggzMbaUY+el7VVfQE+2LpMXy9X0pvB1HmUD4fslZjAOgndrTk4Qb1F26qpzyJ9xPuY4ngw4VDWN7VcjAevZVov2UwguMMbqFuUrGrjuAnlaBHQoM7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=yH80jARS; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=SQlFVkTh; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mLOJ2qbQ reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 55EB2C18DB94
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 19:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705463338; bh=VxFplyoToX+5xGv60J8MONy6X6rHxKnru1jctRcfLFg=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=yH80jARSXTESyPLa2k1ZUmQ1dYe5LP823D2n3me0ZOsXC4qf5c6gfrxM7sY1ZSEAK
	 7WEASIsTq2cA8/3iFYk6q8QssLYWctC3yhH9HR7eJenIJOWLIyiU0EASmHILbDj0E/
	 xR53pMUQjQRmKwrqU23SQMHplg4omBBZtqNJB/yQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan 16 19:48:58 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E4C73C1519A9;
	Tue, 16 Jan 2024 19:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705463337; bh=VxFplyoToX+5xGv60J8MONy6X6rHxKnru1jctRcfLFg=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=SQlFVkThntU5D1tyYQPz3lvcz5TjDvJn1t90uDW0IFWIN8Ch0uwyo8fciWTlHdGHS
	 LCyMvDuxw83k20wZ1quPMSJgOh9yLr+1RtEGtNobWtH4dcrKyU0KlOMi2+v5LJKs57
	 z9tP+fuu3iJJJ2qJc9lJz9ZXno0hIaSg67JyjkPo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E1BA5C1519A9
 for <bpf@ietfa.amsl.com>; Tue, 16 Jan 2024 19:48:56 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0IggB_NdpnYh for <bpf@ietfa.amsl.com>;
 Tue, 16 Jan 2024 19:48:52 -0800 (PST)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [91.218.175.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4C442C1519A8
 for <bpf@ietf.org>; Tue, 16 Jan 2024 19:48:51 -0800 (PST)
Message-ID: <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1705463329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/zDiCJtc3agPb6f1beZHyOJ+Io71uJUKvXiCzaP7rk=;
 b=mLOJ2qbQDaCnk9bxeczh41ajmg13UhHrrXgbBh9vlA/SvIVE9OUxGxWBTBUH+gQhe92Rt5
 N2OFSRNcD5cWfOh9fCFL+FUvGwKLYh+v6H3seOrawtK1ifF0NbZHSOf8NoyJRDzQYwFMJI
 LwInwD4mq11oRwUy6q8wjHvskQrUqRo=
Date: Tue, 16 Jan 2024 19:48:44 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <095f01da48e8$611687d0$23439770$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/uQiqhURdtxV_ZQOTgjCdm-seh74>
Subject: Re: [Bpf] Sign extension ISA question
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

On 1/16/24 5:56 PM, dthaler1968@googlemail.com wrote:
> Yonghong Song <yonghong.song@linux.dev> wrote:
>>> Is there any semantic difference between the following two instructions?
>>>
>>> {.opcode = BPF_ALU64 | BPF_MOV | BPF_K, .offset = 0, .imm = -1}
>> This is supported. Sign extension of -1 will be put into ALU64 reg.
>>
>>> {.opcode = BPF_ALU64 | BPF_MOVSX | BPF_K, .offset = 32, .imm = -1}
>> This is not supported. BPF_MOVSX only supports register extension.
>> We should make it clear in the doc.
> Is that limitation a Linux-specific implementation statement? (i.e., put into
> linux-notes.txt)
>
> Or that the meaning is undefined for all runtimes and could be used
> for some other purpose in the future?  (i.e., put into instruction-set.rst)
>
> For now I'll interpret it as the latter.

You are right. The
   {.opcode = BPF_ALU64 | BPF_MOVSX | BPF_K, .offset = 32, .imm = -1}
is not supported by bpf ISA. Currently, it will be an illegal encoding
from kernel perspective.

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

