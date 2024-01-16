Return-Path: <bpf+bounces-19690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2082FD36
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C767A1C28FB9
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B7E208AE;
	Tue, 16 Jan 2024 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="qFo2ccrY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="qFo2ccrY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ifCR5QY1"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79820327
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444500; cv=none; b=P+nuY0Mjf6uR23+/jE9BRSFm1aU2xhazW5EkS8x7qMFMDvl5aBqTYFBxNoKuBL6G+Fbbsup8nPMLoKHlokYJnXph+SecWuyi0oKeevpKa8ybwG8rUUJx7kgpsKhgR3eWAlWOhOS+BhB0ZKyAcoI8/V8pDBpyNJZlJCwLqQv6ghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444500; c=relaxed/simple;
	bh=2Jp8Tfu3Xgenajb6b5CDcpqZiSU4nF0sudrLJCthzzE=;
	h=Received:DKIM-Signature:X-Mailbox-Line:Received:DKIM-Signature:
	 X-Original-To:Delivered-To:Received:X-Virus-Scanned:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Message-ID:DKIM-Signature:Date:MIME-Version:Content-Language:To:
	 References:X-Report-Abuse:From:In-Reply-To:X-Migadu-Flow:
	 Archived-At:Subject:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Content-Transfer-Encoding:Content-Type:Errors-To:
	 Sender; b=KrVtvVhqtoNoiXRv6xIN9Q8SojdULF8L27kWDtrP6FT1ByV7rhI7zlX6ktTF+dmUQT76NkkMvVUlPXfAwuS56J6cLPbdcc6MYVMRqHl7XnaGV4GICuu7pd/MqSEumhTD8VSd4DK84z3PLhWpTEjqFVCYxahtGrTc1LbGrzT+//Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=qFo2ccrY; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=qFo2ccrY; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ifCR5QY1 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 86F07C1519B6
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 14:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705444495; bh=2Jp8Tfu3Xgenajb6b5CDcpqZiSU4nF0sudrLJCthzzE=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=qFo2ccrYlHpZwQ8SC2Ld3Y45BPR0uVnOQWljtNXJv5+EKFNtEE198YCGQ3ctIKuKp
	 D8vJQi2/Gb8YH9qs+TQZ0VrmprEDMNKIwTwn885vyJ6T6DRqDHU0xYj8oLG0venSoy
	 9ulhopxdu+5TsECuNmEewTgRq7c8a4RSVlbRMOLY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan 16 14:34:55 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5C4DBC14F6B6;
	Tue, 16 Jan 2024 14:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705444495; bh=2Jp8Tfu3Xgenajb6b5CDcpqZiSU4nF0sudrLJCthzzE=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=qFo2ccrYlHpZwQ8SC2Ld3Y45BPR0uVnOQWljtNXJv5+EKFNtEE198YCGQ3ctIKuKp
	 D8vJQi2/Gb8YH9qs+TQZ0VrmprEDMNKIwTwn885vyJ6T6DRqDHU0xYj8oLG0venSoy
	 9ulhopxdu+5TsECuNmEewTgRq7c8a4RSVlbRMOLY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 273CFC14F6B6
 for <bpf@ietfa.amsl.com>; Tue, 16 Jan 2024 14:34:54 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EW22fkXbIoSM for <bpf@ietfa.amsl.com>;
 Tue, 16 Jan 2024 14:34:50 -0800 (PST)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D7C6EC14F6B2
 for <bpf@ietf.org>; Tue, 16 Jan 2024 14:34:49 -0800 (PST)
Message-ID: <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1705444487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tD7mYbb36coY16gdm3pTDas+pwkT1RfWonfbtkgowcE=;
 b=ifCR5QY1nc65IDFVJ+MtyctFO5P+rpD/2lOGmvMiX+aXzWurlAsZm4zoADOmQ8C9mfT/uv
 2b7YLjt4N9MVosj6F+QW8QwzrJtLmMJhYitioFnYwU4v0U58XpiZdptuPI9A/54p+gG2ZZ
 ygtmHM6fM1Pc5Ry32ohxkxKeyniZY70=
Date: Tue, 16 Jan 2024 14:34:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: dthaler1968@googlemail.com, bpf@ietf.org, bpf@vger.kernel.org
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <08ab01da48be$603541a0$209fc4e0$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Ct8YTfSYGBC1OwQPT6rWzEJ8TSo>
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


On 1/16/24 12:55 PM, dthaler1968@googlemail.com wrote:
> (Resending since a spam filter seems to have blocked the first attempt.)
>
> Is there any semantic difference between the following two instructions?
>
> {.opcode = BPF_ALU64 | BPF_MOV | BPF_K, .offset = 0, .imm = -1}

This is supported. Sign extension of -1 will be put into ALU64 reg.

>
> {.opcode = BPF_ALU64 | BPF_MOVSX | BPF_K, .offset = 32, .imm = -1}

This is not supported. BPF_MOVSX only supports register extension.
We should make it clear in the doc.

>
>  From my reading both of them treat imm as a signed 32-bit number and
> sign-extend it to 64 bits.
>
> Dave
>
>

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

