Return-Path: <bpf+bounces-20861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FD7844769
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31EB292E12
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42AB210FD;
	Wed, 31 Jan 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WTSfpNK7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WTSfpNK7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O2d1AaLc"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890832134F
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726717; cv=none; b=Y7+fsbwDiGhNe+bvsUITH1HShL0qvSqcB7XE7vozdEFOJlwGdi24LrRKtnW1E+KiW1hi+icwvNoQAHO8CQiPxQzOQVVyV1uRoF/qm7FKdBTqOdZ6EiyPmuxBlQELYLF+zZl4k6uaahgOFNLBax+jfyZbB+FOl+UzW1XROSn6JVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726717; c=relaxed/simple;
	bh=ziLgTL6+ljL0yXBxD1Dh9ma91bNvLCJVi0Doq48XoJM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=OnB3N7khhCZVAW999oTD8tlPtyU6DIsZxhCdDohofcWtbn/yP/V61unSyRhwdtR2tjYdyuf2/+OCWVy/wc5L0xJHYBj89v0eTA70YDDkEjadQcxLMgvhspxjtr+bQM+dqn3sGgtvtmXSC6B5e4aIdkaBJN89inRnMvKPtsgdrzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=WTSfpNK7; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=WTSfpNK7; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O2d1AaLc reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E4901C14F749
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 10:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706726709; bh=ziLgTL6+ljL0yXBxD1Dh9ma91bNvLCJVi0Doq48XoJM=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=WTSfpNK783o3efvfruT9yUpeQtjKVAMKxX2psPYzI8TIbjWrLsaz3BtMTgt7A6A9r
	 btp+hnArHJF6J27u1RhEjrRDyAdA4uPrnFKia5O2oFHFFDwUO4vTIT7DPcL3TRenpn
	 AndkrocWEIYIJPegHDysiO6PDYhfJAHLBl6hHlF4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Jan 31 10:45:09 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B1A74C14F694;
	Wed, 31 Jan 2024 10:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706726709; bh=ziLgTL6+ljL0yXBxD1Dh9ma91bNvLCJVi0Doq48XoJM=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=WTSfpNK783o3efvfruT9yUpeQtjKVAMKxX2psPYzI8TIbjWrLsaz3BtMTgt7A6A9r
	 btp+hnArHJF6J27u1RhEjrRDyAdA4uPrnFKia5O2oFHFFDwUO4vTIT7DPcL3TRenpn
	 AndkrocWEIYIJPegHDysiO6PDYhfJAHLBl6hHlF4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 17B43C14F694
 for <bpf@ietfa.amsl.com>; Wed, 31 Jan 2024 10:45:09 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E6jT5OBc5bza for <bpf@ietfa.amsl.com>;
 Wed, 31 Jan 2024 10:45:04 -0800 (PST)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 3216BC14F68D
 for <bpf@ietf.org>; Wed, 31 Jan 2024 10:45:02 -0800 (PST)
Message-ID: <ba254346-ec4b-442a-94cb-c9250d97913e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1706726699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSlRMppf4pD7dGbBJ4Xcpz4Z0gJW3xl5EDEUPITxqYk=;
 b=O2d1AaLcX4SevoZYz7DYakyZvS+BQkPiQWBvHEu2c2FU2wH+eZnf1ZUSfBv89MjwjzrGGu
 42Y6+pUJOp8ekZ5M3LbX5rVORLXzA0s4sUAPyI+qHdNFfVZ903R6Dm5atzK3EZJEvi0MVz
 okUoK2d1ovkAnY8jp6ddj1vy+4SVbUs=
Date: Wed, 31 Jan 2024 10:44:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240131033759.3634-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240131033759.3634-1-dthaler1968@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/HcC7k9feY2sh_1X7ywbQ8DNU1bw>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify which legacy packet instructions existed
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


On 1/30/24 7:37 PM, Dave Thaler wrote:
> As discussed in mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/5LnnKm093cGpOmDI9TnLQLBXyys/
> this patch updates the "Legacy BPF Packet access instructions"
> section to clarify which instructions are deprecated (vs which
> were never defined and so are not deprecated).
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

