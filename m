Return-Path: <bpf+bounces-31006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E048D5E69
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5363287D22
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4528E13DDC0;
	Fri, 31 May 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1420IEJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD785270
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148076; cv=none; b=n71o2IqS0vyxnNGCweiQd3zSginPnk8sC/JDiFlVS//fV8bjUeuhn1aV5+KiYKg5/ozZp5IgY4NT8Vkle8vXEkamgCvgclFGfgONuwkK1HXZ419udTsRyHf6BZOfCDSxonF9CtLoHYngZqBTVlhnutmmgaX/Z9Zi9Qdeqh6W8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148076; c=relaxed/simple;
	bh=w9QIw+f3UP8mDZzt6vX2BsXPfpxrSsAae4mhKrCaxoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PsEQAm/D4J3AXWZeSRucDfEHxnP0L0ogTzT4mOoSZtZxYAyFo1OnziXCcr7zEwS3fNNKd9fYBKKJd9NqKLvdU4WTvBVe+8W/hWZjgUN4LH1u3DUxpj96Li942lfiguxuWZ5dmRgP3X5BTEmNEeIf1SS5kRPa5oShbkNULt08Mys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1420IEJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2bf9753a00fso1343330a91.3
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717148075; x=1717752875; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lIjreXl1tfJJnA4Zc2IZNcWwtPLqMQm6mNS2Wh1dEws=;
        b=P1420IEJrwJVlGoMEcSu4NfwvGMAlBkqOc3U2j1m7b+fwrW/FEXF3xHYMSogg5o5zu
         E6peI+FJ3U6fdvZsqSFBGd19Y258gMRs28GAOCQasQcE1ec2orntyE9DUBTDHKSRDtOW
         u2q98kBS3pgYnvIkRVVvgQfrV5xjEVraepbZB2DVlmCH6pjLXAFsfbkNQugu8qN17XIS
         T0BHMm1pOFa0r6MjgHVwsRq91lsp8oCaEz+/DLqq0GP0gwRF0QSmgsnPsn0HwzfdSJi3
         APgQOwVLZvIaKZRneJwCYa1wtILsMql9k7uqVK5zeVA4j+n9WASmCy+8/zvAs6uq1Jce
         C/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717148075; x=1717752875;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIjreXl1tfJJnA4Zc2IZNcWwtPLqMQm6mNS2Wh1dEws=;
        b=wV3rfAdwNa/if9yWaxcSH+aaETGXDgvwUFvyovJNCpW32L+fdcRn0DH86VNaon3TPM
         4hmVhfmb4IBXQwmr6tVQ8ul1TcRLlbqL5fQ7TKU2cpLu3zAywp090WZ+UvTFDhyONG5r
         Q5iPluMQlLoNl3OacoyYsGSmd+jZGac8MWByoB3f1ZVmdxmWzmZyzdY77Ppi5iFy14AM
         VEv0g21ZmuLrAPbLUk8HoWAVEPmad/sho5xMSm3vzxDvs9tjYAbFHKYFd3TPBizHk1oC
         RabRUBOvCyxmkP+9QXLrj2KNW3alxwxgD2zCZZrw0G7hd6C1Ayv/7+5w3+Oi7c6HUQIw
         xbMA==
X-Forwarded-Encrypted: i=1; AJvYcCUyyjSHhYH5g1LhVPTU3yiFAsjyfYCeRn1ce9hSXbDlS9LpSb/x+p/FlWqc9SOh9y5++pT2InzQPmj9O8ketk1sLZZ3
X-Gm-Message-State: AOJu0Yz2F9XOUK2+UlAV1EiFLc+GU3i7q5G5nyli6l2sJqX8Jby4sbz1
	YfrWCAKFXiACz72ls7ojKQ8tj5kR/b1SH/VJqgbRwQqJvkdJi/BW
X-Google-Smtp-Source: AGHT+IFMARo44BQ1UzCEbq7X7IUy+cT/f7WeCxB1Hk3Dj+4HnvHv9LPoinFQQ/p8gSQJY4d9MKRS2A==
X-Received: by 2002:a17:90a:c7cf:b0:2bd:f1ce:db77 with SMTP id 98e67ed59e1d1-2c1dc57dbb9mr1277003a91.15.1717148074757;
        Fri, 31 May 2024 02:34:34 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a775d5cfsm3066742a91.2.2024.05.31.02.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:34:34 -0700 (PDT)
Message-ID: <13fd222ca9f31055b35c55b4ebd2b8b578b741b1.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 8/9] libbpf,bpf: share BTF relocate-related
 code with kernel
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Fri, 31 May 2024 02:34:33 -0700
In-Reply-To: <20240528122408.3154936-9-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
	 <20240528122408.3154936-9-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 13:24 +0100, Alan Maguire wrote:
> Share relocation implementation with the kernel.  As part of this,
> we also need the type/string visitation functions so add them to a
> btf_common.c file that also gets shared with the kernel. Relocation
> code in kernel and userspace is identical save for the impementation
> of the reparenting of split BTF to the relocated base BTF and
> retrieval of BTF header from "struct btf"; these small functions
> need separate user-space and kernel implementations.
>=20
> One other wrinkle on the kernel side is we have to map .BTF.ids in
> modules as they were generated with the type ids used at BTF encoding
> time. btf_relocate() optionally returns an array mapping from old BTF
> ids to relocated ids, so we use that to fix up these references where
> needed for kfuncs.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

I think we also need a test or a few tests to verify that ID sets are
converted correctly.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

