Return-Path: <bpf+bounces-44899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59989C992F
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69768283ECC
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE088837;
	Fri, 15 Nov 2024 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrg2k4OP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DA3C39
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630033; cv=none; b=Rok/1b/nEFY0ceMhyQW09R/LKUqjXnn8MeyIZDsFHQ/SZoPiNC9BkXUTwi4SC+8DRsCzxAoa/9nDrSff6AvCW+BuhhVDMy/+nJg5lGpZUbkvGLMkfAXWEjAjecYYy0NaEfoKhJ6DT4ToRDEGphefRIeI5cjcCdmVT2Y+HjvK0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630033; c=relaxed/simple;
	bh=qEiDdRUbgMm8uO17Gzb55XSPuJAkiNpzUIslLyw1hH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHi85UM8IgsQEUeStvWIBFww8ofVC0rW3s9EnGR2eTW/OPColktSmcsGOOxx0dUvoMfyq5fppYjjDYbwNBWJ7iWSwbTICS+dio5jeI+NhmoDNtZ4bfgspfmzZiG3RMjfiJPmOwLot2YQVI+kRULyGO0/m+iVGghB2qwDwcpu/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrg2k4OP; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71817c40110so650351a34.1
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731630031; x=1732234831; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qEiDdRUbgMm8uO17Gzb55XSPuJAkiNpzUIslLyw1hH4=;
        b=lrg2k4OP1SbuC4JsfPqkY0G7okUSsDUBOVNa/7SATN35us8GT4rwligiPvaHbYm5ph
         H2v67wtu+qIgHls9UAGrIs4npOuNyYvd33Le0SD6hS6Ic+PpO2TigaHQ3J2rCzKVbfe8
         Eo9+eXVvFLVNyH56iiNskUbZcOkMkc0caHQxmaNzxZRX5RepT6mvVzcvSHAdHFeulj3g
         F/TtzEgO/HxY/K2kHdPP0UWkfZRpu2a5vIL8wYDghOy7cjaD+KdAAf5928+h9Z/zI7+W
         n9iao/+kxndzCaBCj5AuRn9+JJVwUum5lSMgl91PuN8yL14/Is/c+9M1DovwxMqY5DP4
         KXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731630031; x=1732234831;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEiDdRUbgMm8uO17Gzb55XSPuJAkiNpzUIslLyw1hH4=;
        b=PeguzvC/elgHd5gAoZ1F5myDYzCmM/kTh/IaZApQvJLskkFZDsZzP3oc1SIHCOYeKn
         /RwtBO7zTMCdpugtd+qnSEYUtBjGKegFRGb1NxVis9zresQr/ZxhRisj/Qd1P020XheX
         1KTuNxix7rP3olqjeYMlW7VE+HY2xFSvN1XJ6QUUBFC8wMc7AQDmLNjfXwN2qNUqRyMD
         CPBY/PgK23Jj5XawVPtUcilyoApyNqnvmC0wSgjPBzXz52UN+ruFcpQv8s10cD23ycLV
         R39GuKKKVMw6KQOPCWiOemRIsyccCdl3O5Dz7hp+OiqYsuKI3HO4KogJabMbbLpfyW/2
         UBvA==
X-Gm-Message-State: AOJu0YyKvyWPyDqzKqIcKy80dUdK7ShcS3zN3We08ShuOetUXA3f5B8K
	1DjJIWOo2umZWkWXP4ntJNY3WfJ0HC2K+D9WYyYqlwAeQDOhJFWy
X-Google-Smtp-Source: AGHT+IFTJCJcExdVNMF+PJa/yPy+JJ6YgZafnnbzwXIAMg8DGxMtEr0ww5nZ6B8bjAPJd5mD28Wl1Q==
X-Received: by 2002:a05:6830:6305:b0:715:4e38:a1ad with SMTP id 46e09a7af769-71a779e3738mr993912a34.21.1731630031173;
        Thu, 14 Nov 2024 16:20:31 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dada4bsm169363a12.56.2024.11.14.16.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 16:20:30 -0800 (PST)
Message-ID: <d34cbd7bf86d01ecccd70220078a7279756c8ec6.camel@gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in
 opt_hard_wire_dead_code_branches()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com
Date: Thu, 14 Nov 2024 16:20:26 -0800
In-Reply-To: <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
	 <20241107175040.1659341-2-eddyz87@gmail.com>
	 <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com>
	 <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 16:17 -0800, Andrii Nakryiko wrote:

[...]

> This true/false logic seems generally useful not just for this use
> case, is there anything wrong with landing it? Seems pretty
> straightforward. I'd split it from the kfunc inlining and land
> independently.

I don't see anything wrong with it, but Alexei didn't like it.
Agree with your comment about organizing flags as bit-fields.


