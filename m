Return-Path: <bpf+bounces-19707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C551F82FF65
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 04:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF1B289356
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 03:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0E46BB;
	Wed, 17 Jan 2024 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mLOJ2qbQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0479C2
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 03:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705463335; cv=none; b=r3Ug3AUfNW9vvHPR1uiCqR09aqO9qoSCoujQVNSvyXV3xCRiz54UC+DF2Ab8Ss4kKvdwuc/hTbdvQdoJRurn3aMVuO7/gYra655KE1hMS+0mRZg2DaARSQC/dde1nVh2NxDMk3BO6KjQiX0h/HJGZRdrxRgaSZtd2XdsnIMGWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705463335; c=relaxed/simple;
	bh=73c30lGsKeKW2GGkmQpZ6mLA21gmk2S/qb622YPOchg=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=Pfn3ieTw8+hwUiAyzUXAzrYcLk7Sqjly0Q2tWF6AiE9qhUZpojVLRG/7jrIqnqPbHaVdqoSW/qvJUz/tb5huuBW/xTTZRSQ7mLISKEQfyUd9SXlvchP7oG6S6CP7HRYSl4DIo5dwRQ2eW9TeFlY8HgBokLB5ssAsSqpCKGSNBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mLOJ2qbQ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
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
Subject: Re: Sign extension ISA question
Content-Language: en-GB
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
 <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
 <095f01da48e8$611687d0$23439770$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <095f01da48e8$611687d0$23439770$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

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


