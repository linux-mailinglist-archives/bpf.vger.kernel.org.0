Return-Path: <bpf+bounces-79505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E83D3B76E
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 20:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E824D3025501
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879C42DF153;
	Mon, 19 Jan 2026 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELTnFtq9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961D2DB780
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851729; cv=none; b=p2fEkEjmc3LT7OZk1HRP/qovR7sOAcVC2OhlAHQ1GZJl4yzW3evPNtWk6Kio8O84o4Nq9s+IzIfIJiFU0cwSqh3OAiLE255owvp4yIqwfIkgka8W53Y1RfyJQQ9MlybA0xJPecfjV2/UT71iTz7i52f74rA+6KQOeYKCc+rGGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851729; c=relaxed/simple;
	bh=iZO2VBK0nImOZW9dN9Z9WYlUe8QYmg2zG5xkDa41XXY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IIics0PwJvKXhy2XOoTgZhIyWTYguEQItpyjGUi+Nb6jPsjjvq0Kzl7AP7DIkQNEEEdoiLHeJre9tp4b3e3RfcKXP9WegltnFtdZ1cmwfqyc7xD4hu4QZkK9BBi0qDr6+v86FwOBrDFDHY5OER7cs6q1lwHddv4GKFDSewKkvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELTnFtq9; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-121a0bcd376so4513918c88.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 11:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768851727; x=1769456527; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eb9yz+SvKdaT36UoPu1hkjKyUKmj8Asls2elh6D0MXY=;
        b=ELTnFtq9vcI+NL8Vk0rQW1gW791J0zoxX7iOoVMuY0muU2+U2pyuJY1Rzy+sznLkfZ
         nOc5nygNckvNSPGSU4erbSwmfna07vMEjMDfJejyg8E6mNQrbIldv/I+27CpM85xVrN6
         h1YjpDK11gLbDLSdD7QheadASOqutoYhk/K+7xWI98j8TI5L41qcLcjvdjDgKt4E5eQN
         Rr0ue62Apvi18zPyMW6dd9Im92ZS52N1yQhZ19zXRRZr8IE1BguIgXuRE1t6QmQJCVC0
         WsVoF1dia4y20aYtANH5AxwIfPNMXXquyKiZ/LUvExub0jo9LDqSWAk4dAKljrA8huLq
         IdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768851727; x=1769456527;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eb9yz+SvKdaT36UoPu1hkjKyUKmj8Asls2elh6D0MXY=;
        b=aVlkcHGR6cOfUKGZRDLvjwGKbEBiy+Yip36QsRO6Y+QTBI9hE1usptMbWGGDVh/vCb
         UJVUKBof8hqzJE5VhlkNs5Y6GcNnJoybj4lsGjoVpVI25LncBcdyxR83AZeu0M3ewJHY
         qVl6ae34SX0AWL5GKkkslQIZcOfCLx8mfJvW8+60qsmNrUHYgHa43PgqZ66NdhVmrrHl
         Vt5Mx3U0gbLjmqxsIB85djgQ/HOUoP4fz3Vix7wy4HPxPtvu/Of9+X/fQwYELu8A6nz9
         nRdXpqgIgXDhk5L719Z23lcC58qE8yFqG59ywUmpHH+Y1Cj7VCxXeZ9ebXOzddL2VR+u
         Vxcg==
X-Forwarded-Encrypted: i=1; AJvYcCU2Eb2RoB3eHwcHT/LxmclXOeFgqffBHFXTQ4t5s6mOmWEM2n2P+QQyrg4Abj3o0AY/Iio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymie1ITWNOq7ZzXhzuBQPpStsWWuS7HQFFDiIKP8k3U/s+J+y6
	r/VryxH/fjnuDx8OMCM3BdSNKRX6Npd8c582pn4qSFF826nEZ43yZj6L
X-Gm-Gg: AY/fxX4LRc0EHoPgN4E+G2ta5e2DQVOY2cEMa4ZKMxZ+331M8bCblyLrXRQcOYcT9uK
	3iHNq53bE07knMrSfGdUf+LV8XI/9jSLa8FNsTQ21Yu23bhrfFixfj4B0z5ZaIRGU4Znn432VMm
	uos5Qegf/LYhYsJR4SKZoroZigis0D9t8nMfaDR1cLoynwoV4peL3+CgYBI9TwR0nKDBb0jRVST
	PM4GL+JNYR0SfrY3dVxeG/G98sfOSTsSjqzU3QEzXHig+x7a1XdgzWfDiNqPS07QEQCRMZNXjW5
	GZIMF7QJXs9+P6gg3opQOjljFfyPR+MapzLBD742KD7b55XyN0FqulA3/+01xU1D1xIT5sS65DG
	lSHz1BGQBOx1IufRyzWqAuwRGCpXWab7iI4r6Sg0lapJG94WBDF9AqPhZpXtFJyGnTKiYm2ronR
	/hQs5/hrCyvY8p3xPKa7LF8ndu4j8I6yrOHFXJiEPz1CDthVYkySUEkq4nKq5JARxzIA==
X-Received: by 2002:a05:7022:6606:b0:123:2d4f:ef1d with SMTP id a92af1059eb24-1244a73d37dmr10368106c88.30.1768851726861;
        Mon, 19 Jan 2026 11:42:06 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af22aaasm14952342c88.17.2026.01.19.11.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:42:06 -0800 (PST)
Message-ID: <f43e25d4f86cf567e06141f0408b0c4c169bd7ed.camel@gmail.com>
Subject: Re: [PATCH v2] bpf/verifier: optimize ID mapping reset in
 states_equal
From: Eduard Zingerman <eddyz87@gmail.com>
To: Qiliang Yuan <realwujing@gmail.com>, andrii.nakryiko@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, jolsa@kernel.org,
 kpsingh@kernel.org, 	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, 	song@kernel.org, yonghong.song@linux.dev,
 yuanql9@chinatelecom.cn
Date: Mon, 19 Jan 2026 11:42:04 -0800
In-Reply-To: <20260116090809.25290-1-realwujing@gmail.com>
References: 
	<CAEf4Bzb79hesJiPWK3hoNb8LrpmWv+OmqSCE284cXMHHQUWJew@mail.gmail.com>
	 <20260116090809.25290-1-realwujing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 17:08 +0800, Qiliang Yuan wrote:

[...]

> Metric          | Baseline      | Patched       | Delta
> ----------------|---------------|---------------|----------
> Iterations      | 5710          | 5731          | +0.37%
> Instructions    | 1.714 T       | 1.555 T       | -9.28%
> Inst/Iter       | 300.2 M       | 271.3 M       | -9.63%
> Cycles          | 1.436 T       | 1.335 T       | -7.03%
> Branches        | 350.4 B       | 311.9 B       | -10.99%
> Migrations      | 25,977        | 23,524        | -9.44%
>=20
> Test Command:
>   seq 1 2000000 | sudo perf stat -a -- \
>     timeout 60s xargs -P $(nproc) -I {} ./veristat access_map_in_map.bpf.=
o

[...]

As discussed in a separate thread, I don't think that system-wide
profiling is a good fit here. When using perf stat for collecting
pyperf180.bpf.o processing stats I don't see a big difference.
Regardless of specific statistics, I think this change should be landed.
=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>

Please remove this 'Suggested-by', you found this change yourself,
Andrii suggested improving it further (this usually goes to a changelog).

> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

