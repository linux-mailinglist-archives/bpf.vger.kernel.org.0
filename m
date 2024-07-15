Return-Path: <bpf+bounces-34866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C57931DD3
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E786B212A8
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA2143892;
	Mon, 15 Jul 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e745A8uz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995C1E890
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087750; cv=none; b=RtHFhkMzqRdyyfScvZ3jE/KEdHCl4Ox75yegI3oFCUU/9aRhDdFu/ZhDHQDq80WX8MDNClY/gBmII3QpywDXAwtF1IKKvfuMjm2YGfy0+FGi8pXXkG8ptY0MNXoNOfZpX36VBBAw2etJtfDlQP1Xpr4dRRVZxnpbjzP8mynWIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087750; c=relaxed/simple;
	bh=Ie+GpugXhMedyalTyQuUCMwpFXJ5/yLRZ9OJEGI7WoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lea2vmVJdz6ryCQdZM6MPSs34GFP/ArCTCq9m88Ci8b/ggxXDP3HGtXEcY2IifjrlnAVyKBKbZs617A5MwlUcqR+E6Sg1DZkK0poZoLyMPP5ouoNuMQsDVcYtEVjWHB9tTLSRQJChKAfrmYKRAOA2fnLdUl8JBoogq5XJ5ExcFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e745A8uz; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-795d2aa4ba4so172325a12.3
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721087748; x=1721692548; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oriqLV0ynz58BFDLv4p0WSUWoGsw4FrgoSPv9lgBI5I=;
        b=e745A8uzCQ/f+CTWzc7NB4t3qSBIOROvyPmF78RqDgNH0IsudzVFvdvkV4VuQ82Sef
         YarJWZ7vNAKQgvkdJvS9MyJrWFY1U/6gYX/Jz5Al3RXtNAunOhsut1IHfOkJdK04O7xw
         O0U8IwebAKFH33HmV1ggq4bqLvMTEDBC9ORzpvZuQQDmWOVygRXHneCLy2swPZH6ecbs
         AWnFiS8sDl6lgs66o0P0rxJ9IeW++Na7+pPBpZKfKNr29vIpsv1StzmzbKEcLGSzZ4oP
         UdDke74RwJNCcdx7IUFVLXTe4fNT8AgBQ/vvDal6CTqVb7n71D0zNFkom+mGecDaUd/0
         k9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721087748; x=1721692548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oriqLV0ynz58BFDLv4p0WSUWoGsw4FrgoSPv9lgBI5I=;
        b=sA/T/IAlKy5T6QIa+uq8AZZwYUJeH0vmj6X1Vwd9F1S+Yp1nAwgLzM1/VbG02cnT5Y
         Oe8xImz+hs3LWXV2N2BnfQI0NWAvexuX5amavClxTcgbHjve7+D3d+6kq5HVWYPhUSmM
         iswEcJkFxLg6fM5cLFjq/A6egFWE/trljc+1zO7fsv4yNZ4p/bIPl1smA4V12YuD3nFV
         1P7spZQei8Tp9pUt67oCUa0ueqGK2kIBiv1isi+al8xHa5JIoZF+v7OqSWo2Je2lAPYs
         owic5ZbnYfcJRNNdU6eaeTGFvk9xdvQEHqKi6Cl6dDB5dxfv90/rLzZFKJtixuiC+xw0
         0Msg==
X-Forwarded-Encrypted: i=1; AJvYcCVdG7mPo8AgPGRlsnhCW6OADF0AcYw3DbcAO9zuwA83H9FiYOAY3pAF5f81+vUran2Db8ma8a2QsH3P158dMOi3Tr7n
X-Gm-Message-State: AOJu0YyHfG1lREOfxQFGKnSJYr/5zQlURxXYTBt++B+Yt4BtJHppLynp
	4hTnfeIc/IP/yNJB5W6hMG3ejYcjUvRlSWmPfMOeVfJ6xrvfCeqw
X-Google-Smtp-Source: AGHT+IHkh1yzDOemy+xWek82YAOW6mjaN0uLkZ/NHkHmcvIlp2CSqWo257HBW3mgShGTtwHReqA51g==
X-Received: by 2002:a05:6a21:32a3:b0:1bd:1d6e:d444 with SMTP id adf61e73a8af0-1c3f12037c1mr611475637.2.1721087748193;
        Mon, 15 Jul 2024 16:55:48 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bba45ccsm46443005ad.82.2024.07.15.16.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:55:47 -0700 (PDT)
Message-ID: <3594134da3dd50a5e7fca62d9843c47a8b47ce9a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Get better reg range with ldsx and
 32bit compare
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Mon, 15 Jul 2024 16:55:42 -0700
In-Reply-To: <20240712234359.287698-1-yonghong.song@linux.dev>
References: <20240712234359.287698-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-12 at 16:43 -0700, Yonghong Song wrote:

[...]

> This patch fixed the issue by adding additional register deduction after =
32-bit compare
> insn. If the signed 32-bit register range is non-negative then 64-bit smi=
n is
> in range of [S32_MIN, S32_MAX], then the actual 64-bit smin/smax should b=
e the same
> as 32-bit smin32/smax32.

[...]

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +	 * Now, suppose that register range is in fact tighter:
> +	 *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
> +	 * Also suppose that it's 32-bit range is positive,
> +	 * meaning that lower 32-bits of the full 64-bit register
> +	 * are in the range:
> +	 *   [0x0000_0000, 0x7fff_ffff] (W)
> +	 *
> +	 * It this happens, then any value in a range:
           ^^
Sorry, one more typo, should be "If".
Maybe could be changed when the patch would be applied.

[...]

