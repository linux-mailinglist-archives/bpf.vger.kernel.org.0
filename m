Return-Path: <bpf+bounces-66841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57013B3A5C3
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B435560A34
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E629AB1A;
	Thu, 28 Aug 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBkOCxCL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D41FF1D1
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397412; cv=none; b=kHU6qDGiA2+luwbZ1h8FmEbWH5Cis1/06JostLce8TX3YdkIsjounUKDKXbK2kdOzF+pkNJel5xjIGf4Cp8E1fv+m/yUJ3e6U6ZIg/HROiJaPhSdhznh8kcG6TmH7k9mclxhcZitUdNlV8eKgDzRSSFHzxFgQyAIJgYXP8m6rhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397412; c=relaxed/simple;
	bh=aIo3qz9pM50gNz0Qnysivk4oUANmfmxniiTUtbeTIzs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kk/KmZiV+k9T/OckB+9OaNbYsShrupAXlTkDBYL9RcaehdUqlD5mpZNOdkjbKshI/gasQcnGxIlOpDM0WjuYlOG84kztHH+ufo8V5qZzDcR4fAzdApNpy9XG9VPnHXZUYsYJlhdfdJh8+0Ny2uZvx47rmH9jGk5LEwrxEZ9Ut/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBkOCxCL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-248ff68356aso1135455ad.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756397410; x=1757002210; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oliGOxy01u2kZ+UZqlSZySLYnH1LC0fPBjtw3Gt/fZM=;
        b=OBkOCxCL2ojAx3QneaxOvuQFHKI5RuXn/M8MBT+q6v3aMUzCVo5RlUzMGQDMv8htqe
         EW+QQgFu/Qim0E3Q0g6rF9TZNtXr2F3HxUOhF++FWu5CGzsDHp5I5SdlCsiRbN+Ru1Ac
         UMurMbODHKBYvq07xswseHvqFui/S90uh1Hed2gmOERBmCJKinck30E8oBs0ofnJpXTd
         CSEm2OT71SjksrQoi6oCvY7FjidcBXljHmLnHHb7bZ/v59/HXUSNaK7tn0e94rmzLI7v
         niF9JsfK6KcROgrD+YyLbMNNbfBrcZwtPDbVIx50to3PPuDnxIuUVrW+GdVzkAJT23mC
         mb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397410; x=1757002210;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oliGOxy01u2kZ+UZqlSZySLYnH1LC0fPBjtw3Gt/fZM=;
        b=sUJMpb/xljIYAf3Hna3F09RVbaj5hLndvrTNL8tABOWSCXTwyG9ceYPNj6e7CmfNUu
         zXSgGKVqTW2qaaYLiG2moBMiidfp+kphoAV5qu0NKoiB7ECTSIMp2J1WAz36NIuyirFh
         A53L57CBy0cPLzF6Ay0zEuObKtxLmHRSiTO42/NBbc8w7Yt2i0pGiu88gVD3M1anTC3f
         23eXdmNw9OHRF87rOY2KGCE7Nwj1Mk+9h4trXnGW7DtyTs4cS24cpkwf4GYzdXn0dXCJ
         /cS6F9l4kVVr5utUFFO3myVzz0Ghq1uH60vt6/+nO1vMsMi9eFQkb2ncSy7uF90XLn/v
         zMdg==
X-Gm-Message-State: AOJu0YyIlXVoSTdb0KZ3eryzzSQfkDU3FfqoJByvJquPMzGDXAAyYbux
	9p5cHJUwL3ramVW6aTjw/aXbV8o2MBHFhp6iBVhrS3QmBDqUQhR/RGej
X-Gm-Gg: ASbGncvCcvu0hmPF9WGT74AztU5YXyetGh7Ch11Ed4dz2hlioFSVdpOMWd34BH1bz+x
	eDiudpEyP9PZ8jUzDnRemdJDV3ygLo7HbuhyfwVwbA3SmyUqSqgyl05/BM5TBDFNdRtiMPtQTjh
	Orerp/jccA+bKbxI0Otx2p3BLz8g+QO+NMo6lonv4PRJyV5MuOLJgKXH+VOjVkcPNH6+R/alM+u
	u6W/1Ytf/Wfx3XlcCs2TK9xYfSZAHy/uvE4aMPrIMccc218SXwcT60hvwGfyQ8SCRr1ZEyuqRXy
	nCBkcGEMzHFUzFoeTunpktK/HZ2A1Bj/xe2AUIFwjTiJf6jVDw+tFTlo+uB00XEY73Am5mtF/eQ
	IzT7KoMx2WHj4aF4M9FpUJ6+0xNHUNsyaXzAgj71JAS7Ze2qJa4AuaxY=
X-Google-Smtp-Source: AGHT+IHGhN1TgpS7T1tnQjBs+ri0teTCt6czsoFrsGQ0goQx1Z8avHRgXoq6kaiwLPn16mCDmtcrUA==
X-Received: by 2002:a17:903:11c7:b0:246:a8c3:99fe with SMTP id d9443c01a7336-248753a2794mr104503455ad.9.1756397409883;
        Thu, 28 Aug 2025 09:10:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:92b8:1b31:4fe2:f? ([2620:10d:c090:500::5:b3bf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466887198dsm154359855ad.110.2025.08.28.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:10:09 -0700 (PDT)
Message-ID: <a559d7be6950e4ea6d8d7574bfd1291335b6bbc6.camel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 08/11] bpf, x86: add support for indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 28 Aug 2025 09:10:07 -0700
In-Reply-To: <aLBkbzahReym9UXm@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
	 <20250816180631.952085-9-a.s.protopopov@gmail.com>
	 <506e9593cf15c388ddfd4feaf89053c1e469b078.camel@gmail.com>
	 <aLAoUK22+PpuAbhy@mail.gmail.com> <aLBkbzahReym9UXm@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 14:15 +0000, Anton Protopopov wrote:

[...]

> So, insn_successors() actually returns two values: a pointer and a
> number elements. This is the same value as "struct bpf_jt" (struct jt
> in the sent patch). Wdyt about=20
>=20
>      struct bpf_jt *insn_successors(struct bpf_verifier_env *env, u32 ins=
n_idx)
>=20
> ? (Maybe bpf_jt is not right name here, "insn_array" is already used
> in the map, maybe smth with "successors"?)

Yes, that's an option.
It can also be returned by value, if that would be convenient.

