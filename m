Return-Path: <bpf+bounces-19854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE4832268
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60777286882
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA35D1EB38;
	Thu, 18 Jan 2024 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="qvCPp6Lf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="rhOdZvQK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p/wIt5QZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13D71E526
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 23:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705621996; cv=none; b=Z4LFtD/i537m+bnRgZZp7MCaLNoThhTjyZjZwLdpVh/9+llEKhqxJ0qjT9Um1dztKgpyaR43zG4SAZtSjRubobjN5l1/zvNqm1gUER2IrTcWKgFkfmqIdQYpfIJX2E/qPhNPN3DuV6ZGmMm/BjuONF0Vr6kECpqMRQpduSBSYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705621996; c=relaxed/simple;
	bh=JfrLEE9IshdfhmZ6itydh/21p103xvFYgSMmABhZ7rc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=jG2huiBIZYzDcC8MLWAA64L+5im9OxLXFllGMhSmFrBKvCIiHc3dynVMCbEJYdJFj2kxnMK1uO0S8r/qezLHkp6+eRcW1sRGSzoqHxdh07lCMGl4mz8UUnKpV8QXRj6eMMtGbmxBZpDUEZcLk7yFhyr7PsfI4Q+ahmn+EgiM1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=qvCPp6Lf; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=rhOdZvQK; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p/wIt5QZ reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 07132C15108B
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 15:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705621994; bh=JfrLEE9IshdfhmZ6itydh/21p103xvFYgSMmABhZ7rc=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=qvCPp6LfBCRXwLPgRoFDRqlJ+lw+dKHbA1OWBRYoDYTUeo5Pnk2pb3qKppeyV0/gh
	 HwX6U7KZ4r0jk4SBV3mdUtSJM1pk99R0/GqFKb79vto+RfVKgh5zB/jvAauzil1Iep
	 ye6LSWOpCP+JCuYqy56AGXARBna6mhXv8YGNzfxA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jan 18 15:53:13 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B9C18C14F738;
	Thu, 18 Jan 2024 15:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705621993; bh=JfrLEE9IshdfhmZ6itydh/21p103xvFYgSMmABhZ7rc=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=rhOdZvQKqFKDrFosj10hqgMWvQmgkcrdIIdZd1G4orj4TfV2Ndl3ksJD9/CmcUjof
	 L7yBB8E8AhBJxnyb+oEF7eiQhgMKzg0FYjra+9gqPSbpXw0kSzRdKvAotjKKcqCWjf
	 BbQVwsbE8Q8kYB9Pru/OgkwPQm7mnDzfyWVT+av0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 025B5C14F6E4
 for <bpf@ietfa.amsl.com>; Thu, 18 Jan 2024 15:53:12 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVemNnGBE4wG for <bpf@ietfa.amsl.com>;
 Thu, 18 Jan 2024 15:53:07 -0800 (PST)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [95.215.58.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 5CD1CC14F738
 for <bpf@ietf.org>; Thu, 18 Jan 2024 15:53:06 -0800 (PST)
Message-ID: <9fe7008b-2fc2-47ad-879b-53da4d0f9c1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1705621984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xciUpB1EYvV1sOyg2VNkB2I07bZOj6mqEI6iYK8mLGM=;
 b=p/wIt5QZpTvjtsJmjzXzU+QCU23IC9uRt7ST6Verli19H1exTRhlwQUQnl3wCMePDBt+EW
 rrwT5D9QlYoxWd4cFmKPi0gwVQdPJoFdb+L/wjHfxJwtvIpykbZNZch+P7vT/qxy4SwTnP
 QWTo0HYHC2aepqOWvW5/bnZlaQZEdEg=
Date: Thu, 18 Jan 2024 15:53:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
 bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240118232954.27206-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240118232954.27206-1-dthaler1968@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/BcwW1piEsNbzMQgUpUjNaIY9S9g>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify that MOVSX is only for BPF_X not BPF_K
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


On 1/18/24 3:29 PM, Dave Thaler wrote:
> Per discussion on the mailing list at
> https://mailarchive.ietf.org/arch/msg/bpf/uQiqhURdtxV_ZQOTgjCdm-seh74/
> the MOVSX operation is only defined to support register extension.
>
> The document didn't previously state this and incorrectly implied
> that one could use an immediate value.
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

