Return-Path: <bpf+bounces-70161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527DFBB1E0B
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B6719C1741
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A65311956;
	Wed,  1 Oct 2025 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SziwmXer"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928051373
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759355604; cv=none; b=gePcLEA/Q5pcJMgYHR/nl3BchHLYl4nSJOSLdwKHovZOHEf3HeAzlNTj/5lY/y7lDWSGwtQ+hkgEPG6TVLzEGFgKfVzSWHzNcfU4rwChmSzYW2IaiWvmFGXWx83xaCxjEKY2RAxIIZHwUdrNk76eRZ+q/I9Fe5nJKIkabIJYvUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759355604; c=relaxed/simple;
	bh=RJIyZTYCABjEeynV8E5NqNw08ZOH/1c9xW+B+hgHjkE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYJV9qUW7Xl83aidekfBttVKfExqxWPfqTCPwQgDaA5GLXv7tDtZ0lIHvSGECNggUZHeItwKRBtlq9EkDIPdtpmpqdD9kX9K8v+UDJ3NC1fVSGfOemghHZpeJtB2KsFVYeG06j4oiY9FPVqQqvqoCGhH+u7I1CUCfjeCskWLdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SziwmXer; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b57bf560703so245955a12.2
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759355603; x=1759960403; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJIyZTYCABjEeynV8E5NqNw08ZOH/1c9xW+B+hgHjkE=;
        b=SziwmXerWok8tbEWKQrnV8tXzp0yBeJVTWE0hoY2r4b7bLIHxaRWzDqqMxzKPTWbe5
         7GySj/3yZQAn6XoiwYVIZIT+1p7DeDTmf29ZBtdCYNRdiiKKLpM42fvCk/Hr2FHl+FSj
         QHZsBpmDHhdPJUJ9NSINFZVKptpLxWdHfJiwV7TrJlPCBCi87AKKuKCnrZhAdDfN7c6c
         tGeIkUtw26gnZQOTJj8Yjl8+wKPnt5hrIfhxaeM1pmEmiaq0RPM45K005JP1qYondQjw
         BgfB79pK7dSFUg7kLpFoxaD5Q9ebWs2vYetmeVCitrbt+BAt2m7eSNgY4ks2iTckcTQa
         L65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759355603; x=1759960403;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJIyZTYCABjEeynV8E5NqNw08ZOH/1c9xW+B+hgHjkE=;
        b=IsDux8gbA5SHuv1WER2VLdJA8fpUPym8dPY3ADVCEYBfsZjhP4sHQUpFW/by1h61OD
         eVnUldHkhW/BcwxA1wxo14yfLKY+NZHTr/KGlpTCtVmwSmEUSVCky03JEbXxJmuoL5uf
         LXTPEIqQAOAb0jAxg58y1bQ9QqWLAAYy/WmZlVJ+xaxN3wuhziYF3ylBQb+eabbxv/ZA
         HINk8CdMEPiKZ8oJdf+O2onGp7XmO3RjKg085dWXWZQkHLmAlREZ8p8QPNKqQm3kYzX2
         Azm+/PIBs7qbPK7TDdbIQn53iZlUOvPHnyXp+Zo2Yfwiw2s6Pz+33T4A3uyNkmHyiv+k
         u5vg==
X-Forwarded-Encrypted: i=1; AJvYcCXVL1lnFzsmEkAV/PiNbwsA2DE8LTKnDtlhRk9KAlicvZSN89U6ToRuBonFAVQXGNAnr1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZWI7RXbYAOTQJSrBtyWnhJ68oscVacslhylUilNl25k9KB9O
	5TJLn2NCKUISH9nTIcnfmsyQF8umxqE4INrtbmTy6Hg4+qz+POg4k1vv8ZhK7nXC6JA=
X-Gm-Gg: ASbGncuM0Znhd4uZELRlr68BaFJ5ZEeEH65+IK+d7Ug9bq5FLgjZGMh1nDtWKtGYUHR
	9KlfSublBQVKI7tuzm3U+zclXMb4QHBKMhylzkCYVKCEXuUkppsdIXQcTq617Ns2mfJ6/HcG+uv
	NS2ioF2ahNbXLRBpkICGtA+Op8P/zh0Xwnr4E6my6c8JGSu/6qxu4VcfOIaMv77zVEYLekv3yo5
	wIMQei1KuD2iki5T56/ei+IfiXWXV1pyvIPy1Yz5IRfeYVwwokBLsWsLklQyubjBfcaCqqWez0D
	y3h0fVII/254Z4D/zTymCH0wWVhNPdQkU+loCPUrcEUWPkH0ba5D8Dmkz5dZQbAl29dcpYp1xwi
	j2KTiPj85B/N+15fXsVxv3isYU/Y2CKmojZk5gX6Dbw7bVooY6qrMK/J3JDWD3lRT9b+42tE=
X-Google-Smtp-Source: AGHT+IExv+Y3qeZOE1ntTqegHKrmJ1L3WWZimzdE19Y4YsQy5J16AoMAlXE8/eqQCG2gOP9dXi31UQ==
X-Received: by 2002:a17:903:2ed0:b0:23f:f96d:7579 with SMTP id d9443c01a7336-28e7f2f7614mr55321785ad.37.1759355602739;
        Wed, 01 Oct 2025 14:53:22 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1e9de2sm5748335ad.121.2025.10.01.14.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:53:22 -0700 (PDT)
Message-ID: <07f665fa1d18e0b8e5ed66364190cfc0224e96e0.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 02/15] bpf: save the start of functions in
 bpf_prog_aux
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 01 Oct 2025 14:53:21 -0700
In-Reply-To: <20250930125111.1269861-3-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-3-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:50 +0000, Anton Protopopov wrote:
> Introduce a new subprog_start field in bpf_prog_aux. This field may
> be used by JIT compilers wanting to know the real absolute xlated
> offset of the function being jitted. The func_info[func_id] may have
> served this purpose, but func_info may be NULL, so JIT compilers
> can't rely on it.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

