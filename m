Return-Path: <bpf+bounces-41347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7C995EA1
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 06:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73FCB2414D
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 04:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE47213D52B;
	Wed,  9 Oct 2024 04:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhelK2GV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8272F46
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728448243; cv=none; b=L1VuI7TYcMGV5Wji7SXmtUeUlYWQ5AycOALn3tzD/GDzlvGNdtcpcx0UUp2rZ6NrVEXVR5hfiI/s/YuMBq5e4uMTWElJWXnWwrG/51oTQvAjH4OS5aW3WH3kwQUprEEAn3zy4V9kL9UXkYl9vbirZ7FqSEjScnToqKm09wNCLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728448243; c=relaxed/simple;
	bh=wXidKdlMfZPL83NEIfZeyBFCVO8VszuQjsc2MnFN1Fk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I9g6xcQ6Zx4JcA/PWmUrjS/VhktddUAm7ipSPNKa2DukOFA5OUnF88zxL9aC3Y5F2M21s0VbNExvoJHkcWbImJYJzG3uyQFyqtXqr/FGAghPts0XA7ZStBMmMhdwnakQPVY1rCTnNlszcduWl+9aZ0w6Y3yTkso/P6ZqmnZZRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhelK2GV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso4054494a12.0
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 21:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728448241; x=1729053041; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wXidKdlMfZPL83NEIfZeyBFCVO8VszuQjsc2MnFN1Fk=;
        b=FhelK2GVWoZiNxbLRGXPW1pS5IKKhaRZG4rmuJt4JcRKjhjKG0E/+l2YYk93klL7JD
         OLvfi2m0t5gkG2av7BVIpvGRO90QOzr7lsRHSme2m8YGNRKYhyFLbBigFMu+SQbkGaos
         xx/DCVfRoOYsrz3FOUe1EQQWQLiFpppQRvIs27EKU9VTCZQ8hVKpJHmsF6VlJWwpxDI3
         sQxuPuM+JzxZHQ+SLj+ldYB/2POkRW/4pPY1470+QDMUbQ9kJwMbZ59NvELfsboHsAg6
         qvlxCDNFUvl/9PK7zASRGv58I2S8RbuszOurXRIagaWIYl2DdSU0rkFEM+mdHN5pRknC
         bIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728448241; x=1729053041;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXidKdlMfZPL83NEIfZeyBFCVO8VszuQjsc2MnFN1Fk=;
        b=BRtGaAYAlUUVts1yjmctm0qzD3XjtNXQiEQGtxV6aRP0tFyHUe4KloCqgoY+6nkmQr
         FjA4j3a+1dgeT0U3PUR3D875sn7BS4YPuVk+dhvievwgcgi4aB+HdiAWV6TRijIvpJuv
         nvbDuW3ngQ9lLNY2P51qJ9bGOEIIZn/zuM9UPBJ/5Wex1F6AX8oKwRsz/eYgGME4i49b
         GuHuSLO04eZSP1AKkseV+jklqZGErkURkv1zbenOUI0qbE84HeeQpKyJiVoFFNDoIWvq
         dW/vBXEtgEQo1b85+7fxHUhcyx+paNVDCdRcs9WRDlDXoJJv8TveDh3g6I+oxxpr7GeF
         pw+w==
X-Forwarded-Encrypted: i=1; AJvYcCVNwu6F0cjBA6ygBbbQ/YpFK1jWg5b6QPUATDiN8WUDJWFLeyA1qM6n6FBOL3b9y06qcKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmZC1kB0HFnU9oQ1c94kO+0301y84KkcF1jPsfnk7k/rdfKrS
	8nGDN7vWIyv4qMET7m7u1nTnUEHNSWGAHr3g/4LCK+4MCOXX6lbT
X-Google-Smtp-Source: AGHT+IEAUJPNxPNpIxeQJH+yOEHUzjRTY1K9tPgs71WFXYaajKsBIbi1iqJW8EnasyzTaXB7vbg5JA==
X-Received: by 2002:a05:6a20:c998:b0:1d4:becc:6ef1 with SMTP id adf61e73a8af0-1d8a3c4ba7bmr1890438637.31.1728448241166;
        Tue, 08 Oct 2024 21:30:41 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833cdcsm7671890a12.49.2024.10.08.21.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:30:40 -0700 (PDT)
Message-ID: <3a5a828be789bff3f48f3eeeb681a4709198f58b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Prevent tailcall infinite loop
 caused by freplace
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com,  lkp@intel.com
Date: Tue, 08 Oct 2024 21:30:35 -0700
In-Reply-To: <20241008161333.33469-2-leon.hwang@linux.dev>
References: <20241008161333.33469-1-leon.hwang@linux.dev>
	 <20241008161333.33469-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 00:13 +0800, Leon Hwang wrote:
> This patch prevents an infinite loop issue caused by combination of tailc=
all
> and freplace.

[...]

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410080455.vy5GT8Vz-lkp@i=
ntel.com/
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---

This seems correct as far as I can tell.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


