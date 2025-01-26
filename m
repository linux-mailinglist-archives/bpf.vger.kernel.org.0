Return-Path: <bpf+bounces-49818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC7A1C653
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 05:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FE918884CC
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 04:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512BA481C4;
	Sun, 26 Jan 2025 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvae7TS1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23081EB39;
	Sun, 26 Jan 2025 04:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737867372; cv=none; b=cpJ+JMSsaZy21Qf1fFR29z+4oLCeJlZkAq+ntHvTkZSM/1ZDwd/42ewcaZ0rUQqWCGvn5DGKNn2nh6kMrZFhGeOk4GWfC8ejVoym+N7yYBXqIvqU1sA/VHZ7bxAb1XSA8Xish7gAWIl7Izog2M5GLzR1UQaj7SAfyZnAozhX7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737867372; c=relaxed/simple;
	bh=YaFs4XEau74Wuo2Chx2Jcd3DQFCoQMxFkkF3xSgmIfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXQPZN1fX8AStkQNR+IGeKNIAAQm19k5+pXLT0wo3enJTfyOUBHpmTmGLGfuk/TudpovrvW/MkoO3pTsnohXz5cxYvWHfo4GwCCfoZgkq/OS0/PoBKPLSPKyph6IIGczcB264+KVcu7SIWD4LQ2vtymed5ZzRdEbMvsngdjXJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvae7TS1; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51c7b5f3b8bso1102744e0c.2;
        Sat, 25 Jan 2025 20:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737867369; x=1738472169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZfSaostHchJQJlmbzdS38jlzTEJN0CBdqQ1dysCyyg=;
        b=mvae7TS1iHmIHpBddiCE6ekIzk+Sg6uevwg4dq1ZPBzuqlvHFGj6VfrFGn8ZHEE8B4
         sMt51tA55fOlsYAepXAuL0Xn3fvjRDryQN92JAboTBTAH+4B3G/C0d5ko1ceQ55NX3Cf
         Pbyw+U1mNO1lqjGSCL5ypbJvBeRckA0VD729yfJZws3ZhmZGxvYbamobTh+EJT6s4g+Z
         OpRwvravGmvpxezmPW5parBE0Ek2EN+Hnj7+xaR//wLDhP6jOsrWzywdUY8246H+OrPy
         x2kEGGWVhBFUkp4C9p7uidxwI5oehCQmY01Ksh5Ji07bS0kf2pZxUIvPtFVAbdZdaeXY
         yaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737867369; x=1738472169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZfSaostHchJQJlmbzdS38jlzTEJN0CBdqQ1dysCyyg=;
        b=KEN/ID94vVWWPNcioeJoTQ2F3V4V7/j1PTNIvz7J2BciPxeMGx/BwWTmveo1sjLEsG
         P0PPVXTCWCDoEOJ3dTLBBgN8+WfucDAefHjnMZItkX12UZFK5rugDv3K8EHoY/eeyHiM
         IsC3E3mkeLzb9KpEB2qrc2Cs65WVKtgF8AplRXexf5gW8ihuxHONLWXw3/xDSf4uOF29
         WFEaL3o65RosqLp0DcH1LwnhdZL7tLn2WkNQWnMOwn47ZIm/DR66YxkWNh8hYzw6ZRmR
         q+LQMI5LlkfuWYKRGdkQM1YQ5fIMMeFh5/fNojLsD2iuxviY2F6Dd4DuCYnAbmM3ctIy
         VwTw==
X-Forwarded-Encrypted: i=1; AJvYcCW/xBVzG9ZBmbLHzwnMt2fcnyeYJZMEw80UzbT3JEOd3+cG5+C3wjtDnjj/2mv2UVQJULw=@vger.kernel.org, AJvYcCX7QH8AF2BjJQXtC93M9jk9bUwdgqOwOS0jKhCedkfiQTod9pqz4hjAJ7ncnixX/NLF4cIK+cd/Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbyHNr55IbPy3KQRddXvGCKcK7ci3hfuz/3j4XDxQ9DPJ3Jo7f
	bQw/yUcLVdsnKa+WvgnRUd5tLtkWnqHO/Z5iEpdpPSlcWChOwE+JEpTFQcqSBiEp52xSGGfza8q
	XCc9RctgwyschqKH/zHLc/G28U/c=
X-Gm-Gg: ASbGncv4bS9ZGyJXNQmnAw7AK1/RaLWgrr4dYyEjSBnMRqbv5uf2zBca+XfsPyc3uGp
	ndV6zEHJXwd4W0/tdBgkGuje6Vuk3UpuD82WWmKj0Af3E8yF/jCKo+i2ZHucbXS5AVNMZOGhnmq
	hmKLMgM6y+b4HQWeXDk6Y=
X-Google-Smtp-Source: AGHT+IHpB7d/vgD0A/dRO7P1xThm/oIl8vJWWLCs5rX0lvGkDYt4n2SHy/LpBYs4mvEWMe3HpdSYkW6d6UazjqjWZms=
X-Received: by 2002:a05:6102:50a5:b0:4af:e99e:b41b with SMTP id
 ada2fe7eead31-4b690c8894fmr33387918137.19.1737867369451; Sat, 25 Jan 2025
 20:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217103629.2383809-1-alan.maguire@oracle.com>
In-Reply-To: <20241217103629.2383809-1-alan.maguire@oracle.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 25 Jan 2025 20:55:58 -0800
X-Gm-Features: AWEUYZls6b0XXxS3bkQDDFQgq5BeAL7NM4SN_u0XoRzbPuPnPgbqtGMAZFjVH0c
Message-ID: <CAM_iQpXGzy5ESZ3ZE0Wo_p_pkXYbgMe3L8stbBcBCo+oJuWimw@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: verify 0 address DWARF variables are
 really in ELF section
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, yonghong.song@linux.dev, dwarves@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com, 
	stephen.s.brennan@oracle.com, laura.nao@collabora.com, ubizjak@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Tue, Dec 17, 2024 at 2:36=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> We use the DWARF location information to match a variable with its
> associated ELF section.  In the case of per-CPU variables their
> ELF section address range starts at 0, so any 0 address variables will
> appear to belong in that ELF section.  However, for "discard" sections
> DWARF encodes the associated variables with address location 0 so
> we need to double-check that address 0 variables really are in the
> associated section by checking the ELF symbol table.
>
> This resolves an issue exposed by CONFIG_DEBUG_FORCE_WEAK_PER_CPU=3Dy
> kernel builds where __pcpu_* dummary variables in a .discard section
> get misclassified as belonging in the per-CPU variable section since
> they specify location address 0.

It is _not_ your patch's fault, but I got this segfault which prevents me f=
rom
testing this patch. (It also happens after reverting your patch.)

  INSTALL libsubcmd_headers
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  KSYMS   .tmp_vmlinux0.kallsyms.S
  AS      .tmp_vmlinux0.kallsyms.o
  LD      .tmp_vmlinux1
  BTF     .tmp_vmlinux1.btf.o
Segmentation fault (core dumped)
  NM      .tmp_vmlinux1.syms
  KSYMS   .tmp_vmlinux1.kallsyms.S
  AS      .tmp_vmlinux1.kallsyms.o
  LD      .tmp_vmlinux2
  NM      .tmp_vmlinux2.syms
  KSYMS   .tmp_vmlinux2.kallsyms.S
  AS      .tmp_vmlinux2.kallsyms.o
  LD      vmlinux
  BTFIDS  vmlinux
libbpf: failed to find '.BTF' ELF section in vmlinux
FAILED: load BTF from vmlinux: No data available
make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 255
make[2]: *** Deleting file 'vmlinux'

Thanks!

