Return-Path: <bpf+bounces-73558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9530C33B17
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 02:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7733A189F705
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 01:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA7127453;
	Wed,  5 Nov 2025 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmiXKcbl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8D125B2
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307120; cv=none; b=g4XI1NTmg7zqZKfUNZVT7BYcvmfv0VSUkBrd42ACYEIqH63g37MdlmTKXa2D0vDGMk2LO3553afx2ZxMRCiwJImqVirohHG5cvsK9ZmSjGw+jo65Mr/VtB27OxrPAJJxbeO1F6lTwqYvehW3OCYdXc6iwAgexszSYfZ/nSPHYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307120; c=relaxed/simple;
	bh=+fMeu6S6+hdh2AO7AJ7kBbTO3lR3XOXXCyxIrAl2zvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dl+fKcf4/jvC/zF4CGBNYUFdYMkIpOQj170Bj6tuDLdUqXMAKQPgbp2y51Y6lvllfhp96WjgyYg3txWUATIGsqCyOx3r69aniQHQIdmwfiUa2nSJwDi765+d2zVm5LqC88MakSuAHj1WtEN33ntxUeD4P1wH/CqHlmaUoqNDL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmiXKcbl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2953b321f99so45168725ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 17:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762307119; x=1762911919; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KxZDxh7I7x4eGax46NKR/v6t63M0OZYsUiQcPaev0EI=;
        b=DmiXKcblimxTQf1teNsOcDPLWpN8uP9El5v3YEBXwYyflNk61fi8iu4OpQDGQw7y1Q
         sn1anS0BDr2mEQ7RGAw0jzMCQ9h32CMFgkQVTtkJcN1sRC2nnoxy7Hsn/YOqDSA02ISq
         pOLvOiATnrCp27sWcgXfB5l+bkWl4d/VBx99ID3+CSn7fYkTCgebBOvZG+CAqQdjuHoT
         XkSPbrq2fTrgvNNom5mkhiIJ4RExQMl98oXIsJqPwwh8mMYl0YnDXYC7LqYgxCIdCl51
         8PC23yHDNKJm5o+qdOR1EMcGcHu7veDYf2lW/YB7nB+5dBTe42Tt8H/i1wTRmYRGfsCs
         f0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762307119; x=1762911919;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxZDxh7I7x4eGax46NKR/v6t63M0OZYsUiQcPaev0EI=;
        b=VBpYDTu8ystSy7CynQF6qptzS9uYA/m06M0dISVl0NEB2s8tT0S/O4zpvX9uZeOQKY
         PDvWdpL5s5YAqEkzCqKDqQhtbAU0hofBiZYiD05N7LthxPXjVtgrkrGJaYR5bnwwxkiH
         dmpYf4oKuT8jtPo3bs0kQh8TurP35XRNAWOPLQtov55Mb3kFKIYoPbu7lAx9cU3PKeum
         euxn+vRplTuS4TBuM1a6qmRSYjnUKUfxpYLivUG0aXI7PpPPN9Uw3k13ro7V5pTy63kU
         G2Bwo/qjDZxyNYCdRDARp0qMyjwmeuRtVE3EXJubHBtMSYxR3imQEV+qIxcCfbo+rQrg
         WMfA==
X-Gm-Message-State: AOJu0YzTZTSe32BzDw94j0TFRbPdX/R2UJ76FdKxNWPxqbvJZsAsipQC
	A7oTpthHK4g3nLgDQI7682CLmZiB6q7DCvXwG3WC+cCPhawRU6Lih8vW
X-Gm-Gg: ASbGncsO23QF1AdxLkL7aEosSTHQp0rVyXrD021SSqhs+J0lDyE7KRUZNiVurr1/iFy
	REDJ4CllR/XdR+AtiGzTQQnq2UbX+H9YjsX38Fa+V/3bJ0OZGoc4H2FxB1DzEXmSyB1X8QV3tkq
	shEBqi8o0HklwVcRKRWbfLyA2BX3Iz21T92+k+TLfSIQ40S7wclRNTizP5mYRJpkcJcsLZ6+ZMk
	+KZb5sRbOP/Whz2/uiEvmw1T4rtNJd5Tu7y+cMn+647zKxVgc0ZwueIn8UAunbRldwxCQJpMprN
	s47JprNluwnACitGY6PX73s1EJY0maQzNymzCCy+blJ8glP9LQe1C8Gapg6Ho4+BLKSwO17kZ6b
	DlZI9/DV/pwUEQZKLAB872LXalrPBBg4k6+S3mDEf6WkAEQ4YzxyCDeg80gJoJHE1dguHu1P1Qw
	+HQIzsngCq1QrOSu5k53fcpjip48hMBoc6qg==
X-Google-Smtp-Source: AGHT+IHeEavZBNwuat1kGcSsAB0eRT2oAHDkUWWx0WOQQf7szc8HSJbJ/29q+YDY7xjS5ULKOclaog==
X-Received: by 2002:a17:902:f644:b0:295:5945:2920 with SMTP id d9443c01a7336-2962ada6848mr20749405ad.34.1762307118679;
        Tue, 04 Nov 2025 17:45:18 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a61418sm41376615ad.96.2025.11.04.17.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:45:18 -0800 (PST)
Message-ID: <09e212d8cec59ed6de637b62dd974c88fd33a3b0.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/2] btf_encoder: refactor
 btf_encoder__add_func_proto
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	alan.maguire@oracle.com, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 kernel-team@meta.com
Date: Tue, 04 Nov 2025 17:45:16 -0800
In-Reply-To: <20251104233532.196287-2-ihor.solodrai@linux.dev>
References: <20251104233532.196287-1-ihor.solodrai@linux.dev>
	 <20251104233532.196287-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 15:35 -0800, Ihor Solodrai wrote:
> btf_encoder__add_func_proto() essentially implements two independent
> code paths depending on input arguments: one for struct ftype and the
> other for struct btf_encoder_func_state.
>=20
> Split btf_encoder__add_func_proto() into two variants:
>   * btf_encoder__add_func_proto_for_ftype()
>   * func_state__add_func_proto()
>=20
> And factor out common btf_encoder__emit_func_proto() subroutine.
>=20
> No functional changes.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

No changes in generated BTF for my test kernel.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

