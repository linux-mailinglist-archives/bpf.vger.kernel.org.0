Return-Path: <bpf+bounces-20362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83A83D1E9
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 02:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D471F25BEB
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 01:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E060D816;
	Fri, 26 Jan 2024 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GSJ3x6sf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="jIqQJxQA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jdCq6F4g"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DCEC3
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231543; cv=none; b=dOwL550qz8BHZLhqfKo2v4w+bkZVmLBqufPfKegppdcyzCC9K1WsuaTqSPG59C8RpMHERtR4NxaRAJ3e1s7N+Gn0a8PkW8ZVRZ6sEQuVeYnCMS08/f3s7xf/Dby8QpbwIHrWhbQtkZZQy0e97TJnYzVN5bZrb44cjNiy9G3SzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231543; c=relaxed/simple;
	bh=QlugC674/rwJ2gGnTBgHgoBMzyw8qRZUPIdQTtSMfOI=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=n772zs2Yha57A9g3ndG3cW7xAgBzuadhSPfXNaMTvofSENuSvCaI3wdt3c7e4ADHkulQkTtC5aa0JZrkgZbYCZVbXNeiUiLHCRU2dA2P4ro1GC0rAivl5MDf9i98GjBCDv4nT/kywaUsPxO5sxzOlDoquPXF6amQmKpCQRdbyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GSJ3x6sf; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=jIqQJxQA reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jdCq6F4g reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id F1705C14F739
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 17:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706231534; bh=QlugC674/rwJ2gGnTBgHgoBMzyw8qRZUPIdQTtSMfOI=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GSJ3x6sfz9Zw3RznmqmOAcX3IPGuJ1iYHGjahSUw5XvnhVCiHdbUC24C/+zCRSSeu
	 nZpLljU6ZwwsQakNp6PcqYZgh+HI18cvLIcaM9Ea+iSbyMDMyBBd8f7Q3TfAWdm1o3
	 x32Xad51vucFWjkGmhQJpQXf7V7c3t65nbpnn6CY=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id C6449C14F68B;
 Thu, 25 Jan 2024 17:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706231534; bh=QlugC674/rwJ2gGnTBgHgoBMzyw8qRZUPIdQTtSMfOI=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=jIqQJxQAAJJYN59nyjQck2yl9gnLqFMK7kN8vLPwh2MqGHbjKDk4AeVGoCqqNJd3q
 wgOWfwOSk0777aU4VQ7z3bVh9xrZLBsVMTDfEIgxFrZxWl0OicYnaHWZarFwmT5TRB
 1km8uGYGsKpWLa8ZA3flWSz/jBctqY20iD3CrhwA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C3530C14F68B
 for <bpf@ietfa.amsl.com>; Thu, 25 Jan 2024 17:12:13 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -5.456
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wXPamH2_fpM1 for <bpf@ietfa.amsl.com>;
 Thu, 25 Jan 2024 17:12:09 -0800 (PST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id EE9B2C14F60A
 for <bpf@ietf.org>; Thu, 25 Jan 2024 17:12:09 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6dddee3ba13so63998b3a.1
 for <bpf@ietf.org>; Thu, 25 Jan 2024 17:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706231529; x=1706836329; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8/LRa5c0xfQcPoEI3iLfcaoTA9F5YlClSHNNttrrjsM=;
 b=jdCq6F4ghzA992LnR0JQiORb0atN/y0GC8w+5OXIdnm9Fv2rb163YYM7n04mqy4Chq
 OnJ+4WrtPSfOqIqeptCG1eGT31UTk+QS/snthAjr2aWoM4Z9muaKFRr9sqs9Zbm6wUab
 cavVB8h3sJdX4LtFaVWf6AQDOvaek0iobLFNd3u/tTKFFxgzyhwcCCAlSNoJTpXTVrfA
 phbX1S6/8VhzakIceJI1TeBnXnSz5vZEgQSSVrKsXgR2bw9fy1XmdULvpDhESHlLW3BI
 0/J1dwQDV0QiDiuDZXRsMjKA8KmVZNAet7l9pIQ1HjeuKaK4aJOl0N5ars2mitXo3HOo
 0ATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706231529; x=1706836329;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8/LRa5c0xfQcPoEI3iLfcaoTA9F5YlClSHNNttrrjsM=;
 b=UoZ0dEZ1sG1QVZAvhXTHu6rmGBd2JpdnfefpDVFWZiHAeDgj2FaMzH6+zR0womEFk4
 4Otw1fkCgrpuByQhoNFENp71s50hxBrvTvgLXacex60VUcnz+QFMV6vuVx7eeE4zCmO6
 lEolGfYKTF39MSEgpU549sYcmgbf9/Xj2pNuaOdTkbBN9tO2tHQwL/xiKl7xedyTVf3H
 MUawkQMOXZePefYRlvUFBbursZtBfFAaPtsuWBb184BINPdpp2X8ScDNZyudlLpTxQES
 p/q/vJJU5LVu1RNvF61F6AZzAadETBWAEl9CgP6sPiWy4qzwa5ZvcL5zYUgubWnZz/fp
 boXQ==
X-Gm-Message-State: AOJu0Yz7Ty+B8pF7qjw5YbFFVuWCpR9FtwZJ8ev1YjnOon4dVRUJiWzc
 VME4zBpYy/eViryEoxhsJbXJvWF9nMm04diUYxYrxqMD1IIUY81Pn4zBOokNUAE=
X-Google-Smtp-Source: AGHT+IHzEz+JTEOln91glJ8FbdhNkrzxT+c1Upo2SxzYjgolCXfJTg036g84IbwqMEakq0S+S0g1eA==
X-Received: by 2002:a05:6a20:8e04:b0:19b:435a:a265 with SMTP id
 y4-20020a056a208e0400b0019b435aa265mr547317pzj.52.1706231528651; 
 Thu, 25 Jan 2024 17:12:08 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 pq11-20020a17090b3d8b00b0028e01ddb6c2sm154964pjb.12.2024.01.25.17.12.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jan 2024 17:12:08 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
 <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
 <095f01da48e8$611687d0$23439770$@gmail.com>
 <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
 <1fc001da4e6a$2848cad0$78da6070$@gmail.com>
 <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev>
In-Reply-To: <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev>
Date: Thu, 25 Jan 2024 17:12:05 -0800
Message-ID: <259a01da4ff4$adfe9c50$09fbd4f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpP87ojFjdXkSD3TMCG8PsKBCFdrw==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/a3mPMDnp6Y_yREfRj6OMtvFJy3o>
Subject: [Bpf] 64-bit immediate instructions clarification
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

The spec defines:
> As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
> instruction uses a 64-bit immediate value that is constructed as follows.
> The 64 bits following the basic instruction contain a pseudo instruction
> using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
> and imm containing the high 32 bits of the immediate value.
[...]
> imm64 = (next_imm << 32) | imm

The 64-bit immediate instructions section then says:
> Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
> encoding defined in `Instruction encoding`_, and use the 'src' field of the
> basic instruction to hold an opcode subtype.

Some instructions then nicely state how to use the full 64 bit immediate value, such as
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64                                integer      integer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer

Others don't:
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                       map fd       map
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)                       integer      code pointer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)                      map index    map

How is next_imm used in those four?  Must it be 0?  Or can it be anything and it's ignored?
Or is it used for something?

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

