Return-Path: <bpf+bounces-76214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BC4CAA5FD
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 13:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2413058863
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DB92F39AF;
	Sat,  6 Dec 2025 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1XvKT2Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974A1DD0EF
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765022813; cv=none; b=ogzTIiP3DPOMclSumSPvCEKR8KUfNJMTtqiZld/Xz83UP4CewpyXlRe4xHW/T2YJbXSWeGBdjGB0YwJPLpCddk8wTlxCZGMRSF/fDtTNCoEBUCiebyEXwTpi2rIZdOL93XRV4hqmJDD+BkV0S0vc3+BPDX1VP9BB0BOJM2up68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765022813; c=relaxed/simple;
	bh=k+MKk5xQNUmJCzI6fCNgx01mXAm95ACa4t1QRs3+G2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LndEOosBy4wHdIeum4JFAMYOKwYZzQa8FnKHJxhfdulnFqY/JunJHHFeCyblK1iQPse1///nwxUo5843mx1qWlh59KR5M7AtKGz/LLagiZuXVqPjL516W9wkWHRTKKH1sEAjr8ijRfJvJ7LM3JsHc3+wmi2WHvD1A2zL7O4TZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1XvKT2Z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so27702355e9.2
        for <bpf@vger.kernel.org>; Sat, 06 Dec 2025 04:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765022810; x=1765627610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+MKk5xQNUmJCzI6fCNgx01mXAm95ACa4t1QRs3+G2k=;
        b=C1XvKT2Z8Vfk8WdphbupPVhRgWlJFT3HuaiZIVIYLkr/mBgCDCxoNQZTHL3Z62Rd5r
         8gAnF/mYNb/dqa34jOwRVoR91VmKNAxgbPjk0nTDKF2OXDaL8M7UzNY7aC9gy9jZE2uw
         pD0qAUf1zwTYCjK8tNtFvE6yO/k8OVi/ikJeBJHn5QWQLLcTzpSd6/BX104WRN6rcXvd
         m62Kinj2OAOhQ5w9bwxUGvQsszzdctWju6Jl1m2F9c8Hup+b8TFJ7ThGokYGrDQOVBEr
         Hmb3aDHNeG9Yhp7o7CTPvXu0sW68TUlDWEEUgAP79WASNWfnP8/og2AIynUJBdpH0d54
         lCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765022810; x=1765627610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+MKk5xQNUmJCzI6fCNgx01mXAm95ACa4t1QRs3+G2k=;
        b=jz9E/Vw+W3S94sgqM5x8FlTNHWGoobd6DrLKGJWmnD5DPEN+VTsNmLjTuZ0OINBLuA
         mUzAwd4qyzcI93lbHFtvOjnFbuY7VU/TieaGQizmFTABjRJ3iMZl4QFXxqyvZEdDZiN2
         mMVSBIAB+YWiwgZYCBEentFbxOQvnhmq/GyNX76L7FSMKiyxgdRvjejBV8fTT7W7PGXr
         cbXjaUd1IMMIp1fhGrgZgDfXTcw3hHoJR+1KY+6xgtaQEELrYl1F9P1VRZHblP8zUhdp
         eVJqIZ23SCf1qfwKx4RFEMVggTSkJTUVbASbUcVSL0VCCVdtlID075CumoLUMvSa2TOs
         0diA==
X-Forwarded-Encrypted: i=1; AJvYcCWgfzAqvMNPgdrySZs2WAUiUy7aDG7/AU3zMOch0h2bHDGuJFZQpV5XaeFkmFp44Vs6Z/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTkKkldg6keMqt2dZKLvEQibcG6MDzjYC3xacKr1RKhU2MIdA
	JNkyWmIIs4PY08TfIlt0VKNalrlPRWGrmhlgvDNH8q/IozBMiqCbyGBZYKbSVAbg8qtpvFW3Xiy
	lNA5Fc3QOIvt+ojY/UOs6l1tGRKXi7zs=
X-Gm-Gg: ASbGnctzmlsCsts9bi3nQCXH9q8qqraZqIhET5HmxTqz/sKKwPmni+E2284LxSdZgdE
	9zkR1pw5B67cZkruHoPLJ86N/85jjpp+Pr2djgTNDMupSAsQFjcrxgsBwGL1bw0d/4PY1LQxN+k
	D5pyX3UGpqBDVNebNDs8iEZO4g7FcO0VCaE2cWL8j8+q3ulVrRTGyp4xlRno+9H8IKFjpAnfxxF
	kQvNi84pmV1qJjEaZHR7Ss9c/C3Luu31SINcSPd+smksVRVVxRuevog7GRyBGG9ELMRXpcUNVN3
	FTsHm0s=
X-Google-Smtp-Source: AGHT+IG2RnqxuduKXe+OlLJ8x+brYc3GiUevAWJ/44bnL3SfDCZXKE2Opp2R1TLCbFBRho5VpV+kIqZWig/jUKXGfQI=
X-Received: by 2002:a05:600c:458e:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47939e5dad4mr24968295e9.35.1765022809644; Sat, 06 Dec 2025
 04:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251206072946.22695-1-enjuk@amazon.com> <20251206120115.50257-1-enjuk@amazon.com>
In-Reply-To: <20251206120115.50257-1-enjuk@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 6 Dec 2025 04:06:38 -0800
X-Gm-Features: AQt7F2pjn1ZerwjndpAkbiaaApAcf9K66sZJ8_FtOxx8Gr41-tneZBXme2enlEg
Message-ID: <CAADnVQKxZv9hCLeFz60Sra5t4J4h=EncoKW3K1OyEBePAfqmuQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
To: Kohei Enju <enjuk@amazon.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, kohei.enju@gmail.com, 
	KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Song Liu <song@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 9:01=E2=80=AFPM Kohei Enju <enjuk@amazon.com> wrote:
>
> Ah, I forgot that bpf-next is closed until Jan 2nd due to the merge windo=
w.
> I'll resend v2 after Jan 2nd :)

?! It's not closed. net-next is.

