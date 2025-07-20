Return-Path: <bpf+bounces-63812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9073B0B33A
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 04:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB83189A402
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 02:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EAC189BB0;
	Sun, 20 Jul 2025 02:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nudwt6Y0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1318F6C
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 02:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752979094; cv=none; b=rYeas/WzFEx4kQbqaaofYui/j+E7U1+XHspwdEVhR65etw9bNCZ60h2LH+40sw7aoSP9liJwX/LP2+1azrG6U0yY7FiF1jHCLibAbVhm+PECDgGjA5gpnE28w1NhPAf6n8Tmg9E+5yQkmheR03GaUCzTUTIMFB2wh7LdmiUvP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752979094; c=relaxed/simple;
	bh=yF03xpuSOoou9NLC5lBz2Tyb2HkfAsm4fkuAmAQafhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBBJH1KEcklaw+js2ZBrgL3SEdTIH1kzFGlRodhWwqwZGN9knAJCXZIE8A7E/ozFjC6vmH/MVXheEJNhRsyZO0PAl99hFBauCDeX2clgUh/8dUQM5nspGvWKaf6FubHloX7XcZrdgABWLfjZDYokEzLySVrK2gV11j8fU029ujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nudwt6Y0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so24590701cf.1
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 19:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752979092; x=1753583892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF03xpuSOoou9NLC5lBz2Tyb2HkfAsm4fkuAmAQafhc=;
        b=Nudwt6Y0YDn6YR/elxOQPMJ6xTSkvDilnAXVLOjGJXupF2i5OS1bJXo2FeNzzYumX3
         EaNwOaZdRHI5fDFJOAR70PmWAwWm+bAn2JpwBRJA1T/bxag1P9/7pzDv692KGiMaYZSF
         mhMlJUIVV3/eNe9qf1GsXo6y9HtfwpH5qGs2FIONihgHVuZHDMWSj/pv5eOUxHNiri6x
         YDrRYemM6sMAUElZaUK+GfjfMR0tmZoVhD3DUJDxujQyA9ktvEy3gbU2W/mGqiBB3bXO
         w6I4D6wNgLCvPJndtolJZPwPo2wzQ/au7Aul5VRk+0XoSGdBIE41z7vymkL2alFQQywL
         JHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752979092; x=1753583892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yF03xpuSOoou9NLC5lBz2Tyb2HkfAsm4fkuAmAQafhc=;
        b=MVbW7D7mkLXis6T2jxfB3Gv2lzl258hn7wV5Zz3KLtAtPqhwD8cnGfj7ZV7YqGLkMT
         yJYOcPg8YvyyTsU17UBAt3o815rOV4niiWIaGoWbgYk9vMZS2ZUMgnassPm4jYfmhHSs
         R3U50wSt18cPEf9q1KxLxhPwSbIYya6gnYc/nIHVHwtx+++Y+JX6jF5r9Q6CF7iX4HE8
         5lVfHa2pDeHwrSU+ieNYjnir7oQOldRnQdGqDc2lE+K/jlkmC763ffGpFXcRUU9ymrgL
         l8vPSm9UU+GRowvJ2bDSXEubqxPo+kqOQMY0bmvu2UcPzb/6pXYyY+DrRxGLABVIYaaV
         KVGw==
X-Forwarded-Encrypted: i=1; AJvYcCW2q4mnHJHAn1ATREUYMluRC6m46/AJqaoJm9R71kHfqtArzcfIU1ygav2Ncwa7WPV52Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZCMBq3v3epgAiioQnVvaez3HLwvqWiZ5bfPIqCQG0t5t2mlZ
	mZO7j0wzNKSHkXB4+6wDSB286Cm+g9Nbf5ljcQ69zmN8ubEjOlE+LVHxp61rLHG7D/xecNWrN45
	xrNSpmJ5/o26Akn9/tZX8f4oV0hBSUlE=
X-Gm-Gg: ASbGnctCzrXhRUSmNNDE7gU00aW+6XJyoGuTPIhEcZ5TJ+d6Fr2sR91no9H5OYXvslW
	lHjGPxZiteiCybS1GSqkO0Wx06LIb9l4bFJMqf8/itWh4fmSYtKXQTVQ52oppD2zOSKQeL90mmB
	B9JO5UY6QLzU46dN6LkIWt3MEogHIDY8530UuHOdX/ynIaNzcaJkxZuWQvoEg0gqPC7CcGXzEik
	nXuhZZh
X-Google-Smtp-Source: AGHT+IH0N8N1xY2U+UiK0og+zn9/dYy5EoUw2d16L3MJvCxnXLffYXLd4rqiDHFz/MRXrhBx+oGMQcjIHvzp+E7DIH4=
X-Received: by 2002:ad4:4ea6:0:b0:704:999b:e5a0 with SMTP id
 6a1803df08f44-704f6ad3e7cmr280117146d6.34.1752979091866; Sat, 19 Jul 2025
 19:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <20250608073516.22415-2-laoar.shao@gmail.com>
 <58c82190-e7b7-499b-9463-527312a28a3d@gmail.com>
In-Reply-To: <58c82190-e7b7-499b-9463-527312a28a3d@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 20 Jul 2025 10:37:35 +0800
X-Gm-Features: Ac12FXxMqgfOvyX0tW-DoBRC4l60DBz94py3UG5A4cnl1liihoxjNk3wW6Ld1Pw
Message-ID: <CALOAHbD60k_cHzqKL9aR3RtVBEX4PoPjCWi3ArkKk1qLKemCwA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] mm, thp: use __thp_vma_allowable_orders() in khugepaged_enter_vma()
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 10:48=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 08/06/2025 08:35, Yafang Shao wrote:
> > The order has already been validated in hugepage_pmd_enabled(), so ther=
e's
> > no need to recheck it in thp_vma_allowable_orders().
> >
>
>
> The checks are not equivalent.
>
> hugepage_pmd_enabled just checks if the sysfs entries allow hugification.
> thp_vma_allowable_orders modifies the orders that can be used based on vm=
_flags,
> which is not done in hugepage_pmd_enabled.

Thank you for catching that. I overlooked the vm_flags check.

--=20
Regards
Yafang

