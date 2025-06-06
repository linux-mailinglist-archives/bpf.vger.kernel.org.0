Return-Path: <bpf+bounces-59919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662DCAD08C9
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34099174D06
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBDD215073;
	Fri,  6 Jun 2025 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2e58Oiu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0FEBA38;
	Fri,  6 Jun 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749238910; cv=none; b=UlSZHbo2hBFhxt29XsYwGha6CK2p3t7otR4TeigMxWOtjn2jlymmkfhSocV+UaOc8pUbP0We0lNjmReH7i67/0+LlKcADY5he0SRHiGnILuIONqBNKMDlxWIC8SXMfJqdWgA0V801jSDVQlnSYWWFekFkWc4sPGzlMbNAEvMH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749238910; c=relaxed/simple;
	bh=hNFq13chgJOAx0Qr0tqTaosTFslRiZiWn9Awd6gD9gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uA8GivtNEHtSMePJ0WDAo7n4lxsyKhKawaQdjMwloqKm1jAd1GBJlTfCXED3t6NtYUYVNmQ9dUwDCsE8Po0o7LIrnCO0RGdAkKO4NroCoDuW4taImuF7R0bnmaYfNgsFHN5clwYwkhznw6VLs5ZEAifvbGERoVaNWFA13RJZGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2e58Oiu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235a6b89dfaso3881185ad.3;
        Fri, 06 Jun 2025 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749238908; x=1749843708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YUYHncPoaS9j0vjfojPdpXC+NFzSxo0Sd2JGtjKa6I=;
        b=Y2e58OiuwzobPXVuKXjdB9ElX04JTEPSiP7m3N2lH7NfY0uKvERnS9EGoyD0V6RIHU
         dhz15sdhoq4SKbfHUzUvsZhOmiWT68sDuZv66TXGSyMrP7bXgYBGX0PiQsXmem332KRV
         lHywXI+zbNYuEn6StLV3dd4rgAN+UjXogDEsAEDCCiwqw99TiLLssUNGOWH4BStwkqQA
         kUG00GHA4igKDbHYS2NnYbtisDclohQ+koEZ/CSuH3BjvYuN6EtJdyW/GEFYEm9EE5PA
         B6jRJ0id+CwU7rWiUOK16cFTKSg056zcA9vnrEY8tEVsmbbYEHhEphZMh31Gnyn4RL4X
         31yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749238908; x=1749843708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YUYHncPoaS9j0vjfojPdpXC+NFzSxo0Sd2JGtjKa6I=;
        b=KWIcYu83/DF5ESUjuoX5h6qDLpA1XbV43lC630gq1bBsMMoPIEAKe360g3pcGuOWQE
         qx8UlIeEmnfwhHZ6TSsJjM8w7enAZBb1OOHpYBoOFcS9Je3HwOToH43XFDVHL2Cy9B+a
         xNfQD7witT4YqFknj/Bmo6lXhHNaf/DT3sg2yEeOYnk3ggP2mEuQiNDcecs54RIBBnjN
         HLvqt+8DPXhTmPC3kpf9VXNhjEvlpq3rI/Qq6X6ok0TtKVpPcxEpJlIcCSxcHpQ/4+2t
         1FOzfKyy3ziD0gFBD855sdUj2pz0IHoDXoOxL7jUOpy8zfuT1qLGt9E4v2xnlxWL7o4b
         d6wg==
X-Forwarded-Encrypted: i=1; AJvYcCXYFW5YtHoC+w79GyUYn2TCNWcxJoSkkPEn1Rv+BZbbPvIsfZTL2v2RqM44ryskLL2A7r0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZGFeREkOSoGsAaEAxG6/EluXIIMq/WjL8bmMlDPSrAns/w6x
	BIdn1QpS9XsmYKnWC+X16idCrACx5g+hWhWWznLTVzESNx7kO5R+7Wrxupvht6VgcLbruiVvguq
	ZjFzeeGjsj+ryuiPzWtOutYFCcMgngxFWyf3GB38=
X-Gm-Gg: ASbGncs6FdFC0HmPZHB/YHFYzNjHMcz7rHsB4RiY9ZueH5mngKaj/iSAtmI1UgeIYqH
	h05Vuj/ud8lgDn8NhX0lMn2E4gqOPqe1FVtWr3iDXH2wBeJkAWfQeY4F89yIZs1xjKjyC+v/u8N
	EaeU6plEkV6+GG6g64PfVaDr8+wbB735Hsof30OXpu2I0=
X-Google-Smtp-Source: AGHT+IFL3krAt1kSSS2YWi9/onmH0KZ8gRTIUEYyqkzy2cO7P0AI+e+Ep2pxeIR2Wp38saWI4+lba0oNo5TbiACFl1M=
X-Received: by 2002:a17:902:e550:b0:22f:b902:fa87 with SMTP id
 d9443c01a7336-2360407a27fmr19007455ad.10.1749238908498; Fri, 06 Jun 2025
 12:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605181426.2845741-1-andrii@kernel.org>
In-Reply-To: <20250605181426.2845741-1-andrii@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Jun 2025 21:41:36 +0200
X-Gm-Features: AX0GCFuaapmu7JuuV3w6cDicMkPhmn2UwYA1roAybgSu6rqZwaqVqKYDiUhYvQY
Message-ID: <CANiq72n0WYLBdBQCZqg04EcdTFG8RvL3fFo4bSeWAWGD1HFG3A@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: ignore compile_commands.json globally
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, masahiroy@kernel.org, ojeda@kernel.org, 
	nathan@kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 8:14=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
>  # Clang's compilation database file
> -/compile_commands.json
> +compile_commands.json

Should it be removed from `tools/power/cpupower/.gitignore` then?

Thanks!

Cheers,
Miguel

