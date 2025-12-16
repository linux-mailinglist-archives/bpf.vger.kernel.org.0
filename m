Return-Path: <bpf+bounces-76733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AB4CC4A5B
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C01230573A2
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177433065D;
	Tue, 16 Dec 2025 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="jSYGcNR9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284D330652
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905923; cv=none; b=froTogPEh56zabhw0pBgtuPpudUzqwIXxrG93YRP2hQb/tRk5nYr3XmUouSgOFCE43PaPHBu8rBdZCAc0Wh/+2bPx/yG6QjQXP6luIpYYdoCVHr8IeavYnBD+OfeNqJW3OImlqQ1QjUE6JIjnE9TB0XLS2vckqPbOzS1Bd0F8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905923; c=relaxed/simple;
	bh=K3Wy8gVjTVOF56EMynBzdgOaChDCyS40WkQoQD2u8Q0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qlBu5T/bYPfMdlUZBm6kzEQJmWTspSDYGHDjE0I0QHEhblwBmOFzScnFHmK+gjRkJcJD5D44wgm7KQbbNTKYYbXl36PcDGE6xOdFikSgT0bkvIO3uqFkoW7yebxQ3ORrBKAChcTKa+zcCNRXASsrA/vp09YfOka3TCY9PBMIU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=jSYGcNR9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee1879e6d9so57484921cf.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765905920; x=1766510720; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3Wy8gVjTVOF56EMynBzdgOaChDCyS40WkQoQD2u8Q0=;
        b=jSYGcNR9NLxOr3cvl5K7PnoonAsji/UcR1f8OCHauw9MLGVVARRa+bIU2F6trpZpvN
         VDen6XJ+vJKi1qQX2fJr00GIaaydF/5Zni4osUlLWSd50S+TF7/lWY0u9YSJm+BiPzhP
         3H5JEtgVPl39SnZchKv9nDFhT8R+jAjDelBrofVkoGWMyzjF0iqzPdfsP5Nbgakke2Ts
         OWJ16WPANH45vcyMqu/USdoPvJYRntk10Ij+TDKSJ3KbIhZ+zw1YHoZ+tvK0ARcu+DBs
         OYxprJU+WLLrMGkkTuTs+/beb2Pjk1TjhZWTfKNy9apaPcHeZw4Px+McJ6bvkii1dVWG
         R8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765905920; x=1766510720;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3Wy8gVjTVOF56EMynBzdgOaChDCyS40WkQoQD2u8Q0=;
        b=GVDaEwNwKVUNWXkzJJQSvi1t+ywagAVpaisXRbwe41+q8Bc1WOBCb8AgKlPhhQ654r
         TQtHdm+SSp4kixQ0vYUf3HbfU707yicCU/wj1lbRMX/2PWq/2jpcLaw/fHaNxdxXG7vA
         AtGIvkaJ5BMKRreiR8nDztDSkpa1Vgxh2b/XTu0HsKhlSgQ5z1JgHf2qOqSOHJ9TndYP
         OxkA8/AJ4HJnvMFQDUrGjHjj0dZYJopDLK39heDn5iK6BdQYeSiY/Jdl5xSYE4F1DtzP
         AaMJ89Gi30YXE+Ygl0vsB0SqfvyLOI0KAaL/dO6/DOaw6zA2lZZD2/bssJqS9BDEOMkt
         VbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaIsSFzha9zaYPbEry3LdkqefvLB40h8HSQcdWCrpJj7bLhQw2nVMyVTse01EvXfoA+ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypw0/Bi/jI1bxAonyuCN83hQYJJbvD+rO1mhD5UtgEBXaVk1A/
	d3Y229HomNB78e/EUYpaAfIFTVFZrN9j474uEhbGrljY7SbZRUMF8yo5bDRPTbjNGOR/b9TTNcY
	b8+tNB0s=
X-Gm-Gg: AY/fxX5lWSQef+LisKWYGBHukMVaVn8v7vu3bCEZUy6Nps5Yyef8z6871HGzN+DNfYx
	52rWXN6b9jzIIlB4OEsXI8Mdk60VWA3L5eJceSJz1xUSEhnuXZlW8i5a/hDVIq+Axr5CecHd/kS
	AlaS9KBr2PysV/Cfu2GXHcjueVske3bKgDD1SoV5j//ea7ymTicjdQ9BKcKPay2ulRhi7PbvuaI
	1Wl+yzj2C53WJeDrw1zyF1dWhHa3t5BtI3b3uCcgLpRNhNXE8YFOPDVmg8kHovdb2tr3tFru7eK
	NAmQc9FCjQmOi3Hw8BR9Lbn6olGHQUmZFrx6CBS3SodiyHrV+vmMcci+vYgTWrMWioBMlICRTNI
	cNHDr97AoCtbPdmgBUU7RAtIE9kqHDyHxlfmTVV6n61j2iEy7B5B42H4tLo6GaOiS249XrnBeJs
	SVG01u5g2MuRk=
X-Google-Smtp-Source: AGHT+IGB97F/oXI/OVvlysMQdpF/A03U1EJLU67jNGBRFUDaO3ZL9R2OKBZll+TORGRC+M04C49kIQ==
X-Received: by 2002:ac8:5908:0:b0:4ee:2459:3d6b with SMTP id d75a77b69052e-4f1d05af856mr236548231cf.49.1765905920093;
        Tue, 16 Dec 2025 09:25:20 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345b4b894sm19859651cf.12.2025.12.16.09.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 09:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 12:25:18 -0500
Message-Id: <DEZTEJOJ7WF2.1VFDHK28XKO4A@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <memxor@gmail.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 2/5] bpf/verifier: do not limit maximum direct offset
 into arena map
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20251215161313.10120-1-emil@etsalapatis.com>
 <20251215161313.10120-3-emil@etsalapatis.com>
 <0720a98e6a73ee6298d73b2c64a08f47a4337007.camel@gmail.com>
In-Reply-To: <0720a98e6a73ee6298d73b2c64a08f47a4337007.camel@gmail.com>

On Mon Dec 15, 2025 at 3:19 PM EST, Eduard Zingerman wrote:
> On Mon, 2025-12-15 at 11:13 -0500, Emil Tsalapatis wrote:
>> The verifier currently limits direct offsets into a map to 512MiB
>> to avoid overflow during pointer arithmetic. However, this prevents
>> arena maps from using direct addressing instructions to access data
>> at the end of > 512MiB arena maps. This is necessary when moving
>> arena globals to the end of the arena instead of the front.
>>=20
>> Refactor the verifier code to remove the offset calculation during
>> direct value access calculations. This is possible because the only
>> two map types that implement .map_direct_value_addr() are arrays and
>> arenas, and they both do their own internal checks to ensure the
>> offset is within bounds.
>
> Nit: instruction array map also implements it (bpf_insn_array.c).
>
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> I double checked implementations for all 3 map types and confirm that
> the above is correct. Also, I commented out the range checks in kernel
> implementations (as in the attached patch), and no tests seem to fail.
> Do we need to extend selftests?

I forgot to address a couple selftest errors from this patch in this versio=
n,
but after fixing them for v4 and applying the attached patch I am getting a
couple failures - direct map access tests #332, #334, #336, #337, #338, #34=
5.
#332 (write test 7) is an unexpected load success, while the rest are about=
 a=20
mismatch in the error message. Maybe the test wasn't being marked as an=20
unexpected success because I hadn't fixed it up?

>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
=20
I will omit the Acked-by tag in v4 because I changed the selftests - sorry =
for the=20
after-the-fact changes.

> [...]


