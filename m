Return-Path: <bpf+bounces-49629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EF0A1ADFA
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 01:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B48167FE3
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 00:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF6D1CEAC9;
	Fri, 24 Jan 2025 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mydh+Ufs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1794320F;
	Fri, 24 Jan 2025 00:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737679371; cv=none; b=bBO9jYdJ9SeVloPawhekT+IY2b5gnN0lF50WS3Qo10pXCQE9tcuNr/gkeUIOPO/F3KjXimCFHLyIv9JDLCyjXelNVCXF1tPFugHu+89Ws3jhXXunNOmn3CTo+uj9FMgToQNjfp7QzDtLhhhyccL3E/naR4xMzmNJ0CFmaA2+xeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737679371; c=relaxed/simple;
	bh=R2l9hdH6/KroDDYzgtJPYjTvocGwEFKh0Q2rGUgSrcY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbNRgFEkrORVNLmcbItEFv8E54ywGjrJN95U/kZtkPcF4MhPNMLwByfK8vVC+POmJ9UQhUu+umGqc3TKt0AC/slzKGDNUZL5LjGxTZZ6BlLst3gCK6qb4PPVqNFMfXCCTBA5b8hfd9AAvMwTDRxVxSZMJSFylVdq9SUiCDRo17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mydh+Ufs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so2848849a91.2;
        Thu, 23 Jan 2025 16:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737679369; x=1738284169; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R6Qkv43BMeHNM1xgUgKjEpDSYIHYOJ3Q93zRofy5oks=;
        b=mydh+Ufs1IzV410Ho3xZiqymvEuhD1RLdE9m7XHMfx1FDmGgQiHjqir8fgaKUDN4b1
         VZwylZkvIRPIje3V9xJBOKFDFZAWZJDLQcgBupoqhRLg2/8cFH893Wibln9tVYdzb+WE
         gYqNn1bvR5XyFzFAz4n8NnZkqsLkZ9Wl3uPNoljcIzEZjwYPIo51zwK9yKO7EH6TsLIa
         C0HMex/M6e6j20wBcuY9z2H+Grrg3Q96p1nfrUF1f+43/3hL6makDL/vOmHNogO6ujSU
         8VYoBzxYmQrbbdJc7ajmnConqo7m0ZtawF8abmrw9OgXE3ijokBav651Ubn00iMQ7Gs1
         abTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737679369; x=1738284169;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6Qkv43BMeHNM1xgUgKjEpDSYIHYOJ3Q93zRofy5oks=;
        b=EaJfYL5VtyqlD7HAwqEXdk+zslIHfWzzSkjIw7So1YLS+A0CxP9QyJtAtdyj6+WSqE
         fqdQKfEwav/i9/l40k41+UN9qefoPOPpWgIIwG5Bb0ssBNLiP6bg3hv0j1yPdInbv+E2
         +0CeDRgkr3Lu6DzmhgH813D5yuFU5svPlIpmuTj3TxvwAHlR29MxjAT+U2aHqOTKi9Md
         +QtkpwaAj5mwI6DWkJo7mV8gRgX28eaoO46NbNzgOMBqtDPyK+2aCW4nJn8qxqFimz0/
         EgVNU2N6vSevAjvkN4opA3KmAJbJ9/9T4QMoqJUn1cyaoKE0COpH43mIue7YxWgYr+/L
         6K0A==
X-Forwarded-Encrypted: i=1; AJvYcCWiUmhEgMv485E151+DXMPgqk+N3rPONOsM2TPazyATxISeJ+adoIqruOWTU0OIFH758oH5mBlUw30ibDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjuGnNkxqb2js8rSaKmXbleWNxFagR2mtELZa28ul7kyXYSVKr
	wqqVTqA+YvcMNvHnig0ILgmXk+DevIlkyVcxk1Fu+9AUdGxYbzcvgXO9iX2j
X-Gm-Gg: ASbGncvVnO8MK3dLDTktsuvyfrAEvXo/oQn1s6jBPJkVaB0cXhyvbsXUyurOp8qpYDp
	Ik0Ya11lYODcmgMuOU2PpXL6gpTo+saJeohF6qILmE/tUYRHCoWpnE6bQjsLaTzEjrPCw7zWt7Q
	1g+8cIzwPkO8Z7dFA3TCvnJS5ZUxZzV/JotdrtNqi7C38c8XLowOadPM9Fesy9pI0pBNM6CEJZq
	fo/DM848YMD7vuM2mHNHvFxpQiKp2YMzCvtvf/mA89s4+1DWk7n35gYA+U+pqcLoYiet1fr171q
	ZT8AaBIovzfN
X-Google-Smtp-Source: AGHT+IEk6QPGG4rbJqgc8UCBlEIRrY+6513hYnAl0SMtcaHsiiOnQe/o/GlUb5kejlPKklfeP1DqUw==
X-Received: by 2002:a05:6a00:2a03:b0:725:e499:5b86 with SMTP id d2e1a72fcca58-72dafbb5646mr42589387b3a.20.1737679368940;
        Thu, 23 Jan 2025 16:42:48 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b3dc8sm602239b3a.66.2025.01.23.16.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 16:42:48 -0800 (PST)
Message-ID: <3955701be6b7f068d50a5bef2bbe74b97e285621.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] Add prog_kfunc feature probe
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Jan 2025 16:42:43 -0800
In-Reply-To: <20250123170555.291896-1-chen.dylane@gmail.com>
References: <20250123170555.291896-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-24 at 01:05 +0800, Tao Chen wrote:
> More and more kfunc functions are being added to the kernel.
> Different prog types have different restrictions when using kfunc.
> Therefore, prog_kfunc probe is added to check whether it is supported,
> and the use of this api will be added to bpftool later.
>=20
> Change list:
> - v1 -> v2:
>   - check unsupported prog type like probe_bpf_helper
>   - add off parameter for module btf
>   - chenk verifier info when kfunc id invalid
>=20
> Revisions:
> - v1
>   https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.c=
om
>=20
> Tao Chen (2):
>   libbpf: Add libbpf_probe_bpf_kfunc API
>   selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
>=20
>  tools/lib/bpf/libbpf.h                        | 17 ++++++-
>  tools/lib/bpf/libbpf.map                      |  1 +
>  tools/lib/bpf/libbpf_probes.c                 | 47 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/libbpf_probes.c  | 35 ++++++++++++++
>  4 files changed, 99 insertions(+), 1 deletion(-)
>=20

Hi Tao,

Looks like something is wrong with the way the patch was generated:
- patchwork link:
  https://patchwork.kernel.org/project/netdevbpf/patch/20250123170555.29189=
6-2-chen.dylane@gmail.com/
- error message:
  https://github.com/kernel-patches/bpf/pull/8395

    Cmd('git') failed due to: exit code(128)
      cmdline: git am --3way
      stdout: 'Applying: libbpf: Add libbpf_probe_bpf_kfunc API
    Patch failed at 0001 libbpf: Add libbpf_probe_bpf_kfunc API
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".=
'
      stderr: 'error: corrupt patch at line 103
    error: could not build fake ancestor
    hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch'

I get the same error when trying to apply locally,
could you please double check?

Thanks,
Eduard


