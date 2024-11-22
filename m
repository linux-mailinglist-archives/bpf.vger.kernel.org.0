Return-Path: <bpf+bounces-45478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ACB9D6406
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 19:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A1F282148
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B711DF74F;
	Fri, 22 Nov 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqCItfBy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524F5FDA7;
	Fri, 22 Nov 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299391; cv=none; b=j+4056zvUB8X8g5BAUFWjeo+RCFrerUwLFIrzWp0MBn7/+Sio/GK+o5yM9mDvefvf3hcQLhOTxs+RmoGn7riofVZ9TpsrSBewBm9tZa+uvuamQwfiRUqAJJTDvUFH6oXTO/fgnn+SeagOP04zAVnMa84ljzx19K7t3SxcEeeXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299391; c=relaxed/simple;
	bh=iWmlusL5pMBKk9EUleXnvb7ew3Af/6pW8LpsLz65grM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCh6BWjzYsPXHhwv54mC5q20wld/H1lJm5psDE5FpyUYRicJ4dxiIdOMlPErbrInP/QLx+VYuukLPQPd5kiRCqTqb2CqSxsmTLUc0bsxoiOXqVN0i0A99qtGeBvJR9/A0e9RTUDPCbqrpPNt0NtKmEnn+Qprm0VFYH76A/iB8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqCItfBy; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so1745758a12.2;
        Fri, 22 Nov 2024 10:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732299389; x=1732904189; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4nNLjDaCRXlkb/aQ5npZiuBl7Gx0lOeAcRvIbDKyLdk=;
        b=RqCItfByXJ68dvvjpefanFSlncEy/LDPI09TuUj0atj0iyh1PfapA9YwvSn37XF37c
         4F/pQ9f6AIBTjwFX4xbhU8yLPixmsDHJzmL0HDICpI8pV43G9MWbtT0a6ybUVsp6n9Iv
         0fUJgFUeB9cEISdmRiiZ+SNsPtRrlTWuBs0Kpy4GDp7WiU1IEACfLG8T5KVlZ0TYaSqv
         A11aGqOmut+AGSYiFKqzKcvts3yQxz86gwoKKfgTDTwBDdfUB6F5UkIrwT6I6bnXH4QE
         zG0Qgw4lxABKItARwbus2FexKDt7EveM1DIEQVMSNXnu45XU33WshmemHXynYFLA3i8P
         fBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732299389; x=1732904189;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nNLjDaCRXlkb/aQ5npZiuBl7Gx0lOeAcRvIbDKyLdk=;
        b=ltPyc8PTbcWXQjbPuEU4hhNxuQPfoZdc4XkUxYZV9CNP+IIKc1L4D8wHz7/cWDYly9
         Q5C3nbWCo31Diq94ACbZy/geFVSLX4ANenwnnuLrtdUW/k8tzXQyMeuxkiGp+7Ei3N9i
         30dYxTmAR6Z4PHqTBrb+aOPv83n/wjFBNAgMTWwDa7N04UuBGv6zXgy36wi5WMURbI8Q
         yXnuYwTv2RMoBlSBlPMXYrPtLGfVmDeI5eAcZB8WKUon+QtUh7XXWuvxTtsK0o3Yykja
         QhaF+wNOlYvIcB00tM8I0beLL2UTIZRoex22qTLwMPrnIOm69xwx231LOR5+RWiag6V1
         +knQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmXlKzraj6yB0uXJ8up4W3fwp5kO5D+tUYJCcYsIkjyYGIth1txaLO/fjr6zy2V225FMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHw/HI4lsiiVpU0IUGb+DljU6v4ipb6beb6eXS5ADP67GfNwr
	SRaLpC4bYP1UDUZpoG4GdgQ7kc07awWY0fNJyhKyPdn/fWplx6uo
X-Gm-Gg: ASbGncvLNEYLcFPiu2F+b9zuqzOxdywMOv3aUzIBJ37CvzOei1ElvFVlmnFT2CDGyK6
	+jIhUo9X3vOIy03uDjs4euwSY+dPXcXNvFiPgaWWZbv/hIaU7mF3tKKVy8fAeSz2sQnUKB0cmji
	JVEVPNUnnQhWosBTkDuZnim03Tp4bv2DLK3ZswZ3qsBO68zl/UFLq7lb7uHB6TlnFb5w9F2Vyre
	4nVCMF5YWgCiEUcKnPz7AYc/6nyDk81h4+G3S3Y+jHeN8M=
X-Google-Smtp-Source: AGHT+IEvSrfqhEAma5n3VgRT6fZhcrRuNqsZoN1fDszvmeINT2VJQo9BV5RLDQy9eAf8O/O9w8ZLdQ==
X-Received: by 2002:a05:6a20:3947:b0:1db:fffd:5408 with SMTP id adf61e73a8af0-1e09e3f538emr5692918637.8.1732299388883;
        Fri, 22 Nov 2024 10:16:28 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de4786a1sm1919608b3a.51.2024.11.22.10.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 10:16:28 -0800 (PST)
Message-ID: <0db791f8da569ad7fdd4503ca94d897273576c60.camel@gmail.com>
Subject: Re: [PATCH dwarves v1] btf_encoder: handle .BTF_ids section
 endianness when cross-compiling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	yonghong.song@linux.dev, Alan Maguire
 <alan.maguire@oracle.com>, Daniel Xu	 <dxu@dxuuu.xyz>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Vadim Fedorenko	 <vadfed@meta.com>
Date: Fri, 22 Nov 2024 10:16:23 -0800
In-Reply-To: <ba19c9a020f2f3d9895493930bdd3a7d7a58f1cd.camel@gmail.com>
References: <20241122070218.3832680-1-eddyz87@gmail.com>
		 <Z0CfBQR8zxgJv_AP@krava>
	 <ba19c9a020f2f3d9895493930bdd3a7d7a58f1cd.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-22 at 10:08 -0800, Eduard Zingerman wrote:

[...]

> So I assumed that this is hacky but not that bad.
> Given that current patch depends on implementation details it is
> probably better to switch to one of the alternatives:
> a. allocate new Elf_Data object using elf_newdata() API;
> b. just allocate a fake instance of Elf_Data on stack in btf_encoder__tag=
_kfuncs().
>=20
> (a) seems to be an Ok option, wdyt?

Meh, any of these raise some questions about validity of API usage.
I'll just add a custom wrapper:

  struct converted_elf_data {
	void *d_buf;
        size_t d_size;
        size_t d_off;
        bool owns_buf;
  };

[...]


