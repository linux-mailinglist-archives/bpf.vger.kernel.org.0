Return-Path: <bpf+bounces-40071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B99F97C125
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 23:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE1B2127D
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 21:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACA71C985A;
	Wed, 18 Sep 2024 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVEI7jIt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCE6FC5
	for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726693442; cv=none; b=Vgbw9lIavdQTQsF1SsTOva/u98B0p/Z/yisAH74S9Sy8pQvTGx6bB7EVNYAfFC8hmmZZoFofoAq9Ev9gaiw938ZZX6dsJClnkuiXSqt4LUvHKuJ1cVeNKsRKibYpy2gSoQ+2jR5Pa6SJ7Oxgemb269mBbbauiM0xT9X8Mc61Cms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726693442; c=relaxed/simple;
	bh=5O92wmlCS9wH0Fafn8sumq7OGCxMd+jHkS9S3lg5xKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1DSLSc6f54T8slzsKcT0m/Orr0DV3Rk1/DRikFKKm2cBlQyYO3clJo8cm5sLg7mEwAXMyKAMG53Jee7o2OUCwJgBe7i+JwvC3LviZoWprXhwXI/4fTNa+WxohtP3ITTVKYL7cVcqyRIetXLPtB97hm8WKV4f5h06JC1CNeeQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVEI7jIt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db54269325so51326a12.2
        for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726693441; x=1727298241; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IeOf7SBNvgkqQEPbXRLR4mXH/6saWjUcTK2Rb4RpAv0=;
        b=cVEI7jItDYhI5FDf8HnP33W3D4+YmrKej12/Jl7QjTcoAzrmfCYzVT6pEO70ISzS5g
         pVRyAvKhmRixgsFDc34mg6nq7HiCcQ90zzOiO7Wl/ImgQ13kDvhNNxGlML4byCsRVcA5
         CHfQnVTEHQf9fFWOx/Uohv1ELYOCDnE+iEX2sAOvvQ4nMwVb5DvnlP3cAF0J/UUknOaL
         FKySIZKHIILZEzzpY4p4Ccu7VxdLRrKE43AExRm85j3WFZQSE6/GAaQB5YXsboS4ff8I
         glXCgi+YCbiLzlJZY5xsHRHZ5aY+MPZXmGwFC4Vumvr9O/SXO1KD06yhTvo33RoDaJOV
         UKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726693441; x=1727298241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IeOf7SBNvgkqQEPbXRLR4mXH/6saWjUcTK2Rb4RpAv0=;
        b=DVxb8CPtoWIecjxxNOD9RKU3kb9dgy3DaZ1XnrwAQerkmhiL+xxzAIrK+QaGF7ttwa
         pmQMK9pJ2Cn4mtfVJQH7jxa6WZZNUc9NVzPDqz47VtuACxIzWhiuzrCtYuCoSZL8L4g8
         axQN/1Kk+IJovS2t8vPKYbM6/NrHvgJZgMgiNLyH5g5purkN5oIG1NRqfyi9tvmXqiKl
         PJQBhAPxl+DA+5QmXHkjZkqD0iqfwauEKnVyyxJxP8a1i8vZd7SwqlwBqQmIpnczgogZ
         sjpb34uRQUQxvqzcgOMFUDt/S6mqHWP/Ihl+Pskn1dYnezu8kAULN5/SK4b++oD+8U95
         KmXA==
X-Forwarded-Encrypted: i=1; AJvYcCVeXAoFLANn31pw71u/4KWUo5KYiDx501rVuzX60Drait0NKs5UfaUvIqhugwL6x/R68Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLJLHURlakPFq5E6e7sNasCm98GR5VzNAhI/51tBqEsujNR2Q
	TKxqqTShmxRHAlIZJoYXHC/R8kGRkztX+lGS67Vx+xDdfQUKYwv1
X-Google-Smtp-Source: AGHT+IFDkFpGrb4r+7eBN7iOYb5tnuUMrK/6fJTQh7nt+IERt4Vxir0GLvkxl2aIVHx7C9yCTTjNeQ==
X-Received: by 2002:a05:6a20:d526:b0:1d2:e90a:f4cd with SMTP id adf61e73a8af0-1d2e90af52cmr9187853637.35.1726693440481;
        Wed, 18 Sep 2024 14:04:00 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7e40csm7120220b3a.111.2024.09.18.14.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 14:04:00 -0700 (PDT)
Message-ID: <a63ec24f6a54173d29a7b88ef679b2aa942d606a.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: change log level of BTF loading error
 message
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org,
 andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Date: Wed, 18 Sep 2024 14:03:55 -0700
In-Reply-To: <20240918193319.1165526-1-ihor.solodrai@pm.me>
References: <20240918193319.1165526-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-18 at 19:33 +0000, Ihor Solodrai wrote:
> Reduce log level of BTF loading error to INFO if BTF is not required.
>=20
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

fwiw, I took verifier_bswap.bpf.o and replaced .BTF section with empty
one inside it:

    for s in .BTF .rel.BTF .BTF.ext .rel.BTF.ext; do objcopy --remove-secti=
on $s verifier_bswap.bpf.o; done
    touch empty
    objcopy --add-section .BTF=3Dempty verifier_bswap.bpf.o

And modified veristat to show log level for libbpf messages:

--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -187,6 +187,7 @@ static int libbpf_print_fn(enum libbpf_print_level leve=
l, const char *format, va
                return 0;
        if (level =3D=3D LIBBPF_DEBUG  && !env.debug)
                return 0;
+       fprintf(stderr, "%d: ", level);
        return vfprintf(stderr, format, args);
 }

And here is the output for veristat loading modified verifier_bswap.bpf.o:

    ./veristat -d /home/eddy/work/tmp/verifier_bswap.bpf.o  -f bswap_16
    PROCESSING /home/eddy/work/tmp/verifier_bswap.bpf.o/bswap_16, DURATION =
US: 26, VERDICT: success, VERIFIER LOG:
    verification time 26 usec
    stack depth 0
    processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
    2: libbpf: loading object from /home/eddy/work/tmp/verifier_bswap.bpf.o
    2: libbpf: elf: section(2) socket, size 80, link 0, flags 6, type=3D1
    2: libbpf: sec 'socket': found program 'bswap_16' at insn offset 0 (0 b=
ytes), code size 3 insns (24 bytes)
    2: libbpf: sec 'socket': found program 'bswap_32' at insn offset 3 (24 =
bytes), code size 3 insns (24 bytes)
    2: libbpf: sec 'socket': found program 'bswap_64' at insn offset 6 (48 =
bytes), code size 4 insns (32 bytes)
    2: libbpf: elf: section(3) license, size 4, link 0, flags 3, type=3D1
    2: libbpf: license of /home/eddy/work/tmp/verifier_bswap.bpf.o is GPL
    2: libbpf: elf: section(18) .BTF, size 0, link 0, flags 0, type=3D1
    2: libbpf: elf: section(19) .symtab, size 336, link 20, flags 0, type=
=3D2
    2: libbpf: BTF header not found
    0: libbpf: Error loading ELF section .BTF: -22.
    ...

Note the log level is 0 which corresponds to LIBBPF_WARN.
So, if the goal is to move all optional invalid BTF messages to info
level there are probably a few more places to modify.


