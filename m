Return-Path: <bpf+bounces-61738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13E1AEB12A
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 10:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EA31BC692A
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 08:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0858823B622;
	Fri, 27 Jun 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAx4ZbW3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D86237173
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012529; cv=none; b=JdVjSbQU2euDrXrFIuT6IElbGBiEahqlsNgWBeWputwrw6e43Lv26remjDDbU03dqnAw19ST0pKELosJvYOrgRwMV1acQkUuF+7wDFUMqzvawu0qIeASVlizEv+H4ZM9wtTF3YSfl0It5qScVPKGH0f5XhAuI1wCpj5hHQPqEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012529; c=relaxed/simple;
	bh=7L7gnA+PMqOvFzB9aOAb6Z3I8wPBf+AMV/Vnk3gf7KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHoJzG2V7A523yE4z8i8cqJZozFUVJwYrifKiYlyTq5BqMKcV4pp/IbEY2msWC5Dfd2jtagivijtOHU9Z1sUNF9g/VFnPFj+s7EBJKqhyYxs7c8/KhZy+YYV06+CyzrkviQPe7VxpvkMfbAKMqI9cnloL7c1yYfDAb6u8xdfxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAx4ZbW3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751012527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdhaPmsWFArhsXFsISpX5ZipUl19a5SM0RfIr3emwGI=;
	b=FAx4ZbW3bz7NYQVr3M4cHxGJ6R/2h7vIruX7v0JLdHlw401VdrJJPBcEX6Vq1ungZCyQRB
	34DfPuA3DjglpwFu0pVo/sBs1m0zblPaoyNKXUixAdz/ppEg3TYeCDlvgP3/+0DkBys4bg
	9ZF0tF8OLeJgNMkRS1SqDXpMpXU+rCA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-N5yNf-F2PESd5DwgMD9Vuw-1; Fri, 27 Jun 2025 04:22:05 -0400
X-MC-Unique: N5yNf-F2PESd5DwgMD9Vuw-1
X-Mimecast-MFC-AGG-ID: N5yNf-F2PESd5DwgMD9Vuw_1751012524
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5780e8137so1453324f8f.1
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 01:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751012524; x=1751617324;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdhaPmsWFArhsXFsISpX5ZipUl19a5SM0RfIr3emwGI=;
        b=UN6oN/2OEMcHlz8z/+xgOtNcsJAp69qWhdI93c8GstAse4qJu2aOWboiriWgsmwtZd
         Zsh/xCRVIBqTtcvlLBDG95BF1zyLxynbnn5hkQrCFH7cvMBp9Da0QZUGgUN/PEl+bQOa
         P/LBS6v44LNbrUNKjC8cb1IsS6wkWndqWQ+DBcSXCrXS2vgcmQE1BB8U2daK7CTkoSe+
         rRaXcRCe7bOfzeFPa4k3bij2pBVJKjKi1MFtsO75l2bLV4inKxHwjLd2nnffAyPYMmLH
         w+NGqVYkZB1LLNKgi2aZteEoGhsvcusCaxKoUGdKYcGPMOeN+qHBcMcpSR3TgCBX0LQV
         hsXA==
X-Gm-Message-State: AOJu0Ywbrct/eEUl8TuzCHr0nbH0GJvdeISINicmyueEKlJJPjn1X4Lm
	T8WvgIM/p6GwFZ1sBb9ZuFnzQ1d/mcHFilcE3YDl7H0vJGRUxC/W7Gbjgvr5bObpfbuaXYcMgW3
	yRUE8sya7Ab5ln1esPLiO4YkNOnBHkIkc9pbur03b1FEKmHE2vbOD
X-Gm-Gg: ASbGncsdecXcWxq1EshGxuiA61/V48vsl3yF7pB7usmwTxt1FsdJfYqstNyBan9LsA6
	en7rmTIJEdrGAssqMONdVSY55jGWCrNBKsum5n5sTi0ZhUyqt95hrmSn3j62AAEtkARfMfoQnVB
	gEem6TO8ah2j6CNLrc2q1nnE3dBsQvdoIz/mmijhs1EWlngVxb4SHbTExjxftyTQkbM7cva4ydS
	bNZa5uPtbx4J7llsBSO/YABsk+EoVPT6OiZNZDRIzkUTa8tYLs8b13DAfd2RCu5HgXz3jXbQojf
	AHzwAbzsjTeX23h9EGk63853INVied2q2g5FelVyzT1B4GuVrB8=
X-Received: by 2002:adf:9cc9:0:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3a6f3153609mr4583317f8f.24.1751012523789;
        Fri, 27 Jun 2025 01:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE6kxl77BfW2oseBFkSC1JtOT5bepuvfPux+euP6AbKgN4iSeaZr6ihXIz7XSCpkAgQOS7Lw==
X-Received: by 2002:adf:9cc9:0:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3a6f3153609mr4583297f8f.24.1751012523368;
        Fri, 27 Jun 2025 01:22:03 -0700 (PDT)
Received: from [192.168.1.108] (ip73.213-181-144.pegonet.sk. [213.181.144.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52b9esm2024043f8f.61.2025.06.27.01.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 01:22:02 -0700 (PDT)
Message-ID: <bdca5369-57dd-4db4-82db-a2622d26c550@redhat.com>
Date: Fri, 27 Jun 2025 10:22:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250627174759.3a435f86@canb.auug.org.au>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20250627174759.3a435f86@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 09:47, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bpf-next tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> kernel/bpf/helpers.c:3465: warning: expecting prototype for bpf_strlen(). Prototype was for bpf_strnlen() instead
> kernel/bpf/helpers.c:3557: warning: expecting prototype for strcspn(). Prototype was for bpf_strcspn() instead
> 
> Introduced by commit
> 
>   e91370550f1f ("bpf: Add kfuncs for read-only string operations")

Oh, good catch, thanks for the report.

Just sent a fix to bpf-next [1].

Viktor

[1]
https://lore.kernel.org/bpf/20250627082001.237606-1-vmalik@redhat.com/T/#u


