Return-Path: <bpf+bounces-19832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A5831FE2
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 20:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59911C222FF
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14F2E62B;
	Thu, 18 Jan 2024 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Upcy0/sN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24329438
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607449; cv=none; b=A8dObjxXmn7GVdscyUFen4lVfBMaS92GH7vWv1qfXBtzRJGvyP7Hj+7zOboXktmQyHh7IopKRmpj4mOr2hzozC/ziM6Ac1JLpnZQ8Vs7/TzRI7/ugGAofdDwlZN9y+CiX2w3JxtidlftwiueL9VdmAoFFYYJOfvGkAwenllUGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607449; c=relaxed/simple;
	bh=eHRZEinXSOUHDRseG7mDU6jsqujeI0p2yQO3mB4NzUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gpN/EN2GJ4JqSWkRXxnzmPytC6c8/wqYE5uTgcJHiRK8GbfkohOQApbljgYUfNwtZPeM36xOPA5g+M/Nmi4rxjZcGTvYZIh+3iq8KBc6EtLq9gkH6vphzc/e+MVtzk6Pus6Ia5J1p8ZvoRqVIe4bx278iqbnkdrq6N5MLI7i5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Upcy0/sN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337c4ec9e46so1488679f8f.1
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705607446; x=1706212246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Vs+7KF9K2uaJTpsax/1I3PLDy6bGqQtY/U8UekdFXY=;
        b=Upcy0/sNPsjarBdYOIEWbceZzihjNsnPgUdjtDgSTTqJL8N5d1O8BxggK5FeYoZkuY
         j+JexUWlPG4OO5EdHfUHzijBGx2A7Vdfmud5Nc3Qcw6gfFE2tE7CW19+KVc1ahcSpTxw
         dAscJWOasMTETHnhdeUU7zp0VWVo6sCDFoMNEpuohME2IpmJWcMe6qgceqKqO53diQz0
         e/Zw1e5yJKzgu4Me5lHPi6BSX0hYhQkCphkPIAvu2gPKPZJxqctf0g2nAfJucrDPX74l
         Pva/OZ3o31gipDICVQNnVskw5Dh3maQ/W27kapt0MB8YdU3U4DUbvuEUYuB1VSAitGAk
         yg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607446; x=1706212246;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Vs+7KF9K2uaJTpsax/1I3PLDy6bGqQtY/U8UekdFXY=;
        b=ehlF/sf8nQFXQo3Rp8YRdg43PR3ixYsgtjxgsl/4N4LJWp/pZIwHt2LMGo8eh/hjzo
         Wjns625TJ1REzLI0V61Ls6vRXOG+NgrbfWlOCyXcjQlj3YFwt4zNF4T53BzVzeQCBcGS
         ohoBJtkfdgx6BLXHAwMiW+9n6LAOHhRX/RWjgzL9SeOru/tAtZWpqpnYIRR/rJ1xyYow
         3kleWmCmG0+gPPgdPn102L9QpJGnYqf7G6XqA9Q/S5BHb1P9ip0B4HIKU5h0Ma0KWPMT
         w4ZPTncjQiXzLwEix8cu6+Cccru1Kg6TvxsL9has7zvVYKzhJcs85X52YVF9GQ7tG4W8
         q2OQ==
X-Gm-Message-State: AOJu0Ywqou/V1oR72S5mBJCGjl8igsQVzb4rZzPN0pS9d6d/yG2lnY1d
	ioUHAnLfgyd4EWCSqbTQVkMNGU94Y9Fyy0duM+1WXenGeLiv92y3
X-Google-Smtp-Source: AGHT+IHNfX2UJTrDJB4BdkWp82tgM5KpbxKIl2EZQkkcbaNATne91bTodBmwdW5N0hXPBRqsH/0LBw==
X-Received: by 2002:a05:6000:137b:b0:337:bec0:f8e1 with SMTP id q27-20020a056000137b00b00337bec0f8e1mr368703wrz.244.1705607446426;
        Thu, 18 Jan 2024 11:50:46 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d4c4f000000b00337d6f0013esm1075143wrt.107.2024.01.18.11.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:50:45 -0800 (PST)
Message-ID: <e4a6106a0b4247cbf83c2311e60f69b10ef1517b.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 5/5] libbpf: warn on unexpected __arg_ctx type
 when rewriting BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 18 Jan 2024 21:50:44 +0200
In-Reply-To: <20240117223340.1733595-6-andrii@kernel.org>
References: <20240117223340.1733595-1-andrii@kernel.org>
	 <20240117223340.1733595-6-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-17 at 14:33 -0800, Andrii Nakryiko wrote:
[...]

> +	/* special cases */
> +	switch (prog->type) {
> +	case BPF_PROG_TYPE_KPROBE:
> +	case BPF_PROG_TYPE_PERF_EVENT:
> +		/* `struct pt_regs *` is expected, but we need to fix up */
> +		if (btf_is_struct(t) && strcmp(tname, "pt_regs") =3D=3D 0)
> +			return true;
> +		break;

Just to double-check my understanding, in patch #3 you say:

> for perf_event kernel allows `struct {pt_regs,user_pt_regs,user_regs_stru=
ct} *`.

Here `true` is returned only for `pt_regs`,
meaning that arch specific types "user_pt_regs" and "user_regs_struct"
would not be converted to "bpf_perf_event_data" but "pt_regs" would, right?

[...]



