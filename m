Return-Path: <bpf+bounces-78963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DBBD2135C
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 21:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAF00303BE0F
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE34356A37;
	Wed, 14 Jan 2026 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBlN1yHD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328942F3C2A
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423583; cv=none; b=eCAPJvzqyOQrVBvfUzmT5nQHx1I4rtsfbx0SUJ8N1CVTCzU+nLLgiWk4wIt77ChizgjDYm+vUijoz4p97PLuwrxYcfPG93/NgyjN+kTF1ApC8rGE2GP2naSx07o1c7umPgIj63lWwMJkmyoVc7YktwDtNqQkdSMeynuzuarS1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423583; c=relaxed/simple;
	bh=PSZqhr7fvldty9yhJSzFIySWtqFdFNfdF7+2G5csF+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1W/DBZExxtE3TynM1CDsI5ZQTwBeK/3jIRGbo8+7neYYoIFI3rITvaqK8fSUB8HcJoJCO2lOfOeDjJBgo+Vi46bPqinwQdZIMSM01m54+jMbWMT5oK4UdCgfpGUWmzCi6UuI7EG/Y/kkmG7XPrkBY3De57uXRprGVmP2xFVoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBlN1yHD; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12331482b8fso559478c88.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 12:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768423581; x=1769028381; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PSZqhr7fvldty9yhJSzFIySWtqFdFNfdF7+2G5csF+0=;
        b=lBlN1yHD5PdmlZOB8fEUqRMUdVIt3Od9QNc7kylb6TetyCOvhWy+IKjGtW7NBvvqQI
         zhCQaDXOcXIU8aHyUOp6EVpEg7kkzgy/Y/iLK4GTLs+4NTIJz7Il41EHBxes0NZ4iESw
         OUZzOek1d4u7a+eso6RVvnG1x/5oB3eaBxs9g29E22Qovwkn5u7cZqxyYpN3pp6QPvun
         82S29OcYl3IoRNvYKXcgvoLeyXGVf5t65Ht3dfOG+a2sud2TZkKxyzVvpPPp1nHhW8bP
         RdjFat52mvnHr2GOBBYmrC/ECHOyVE2wjNiANqUfSZz1knG6eWO8Yqoz1J+2FrOOpNd6
         nJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768423581; x=1769028381;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSZqhr7fvldty9yhJSzFIySWtqFdFNfdF7+2G5csF+0=;
        b=NDydwB7yhFStqlJxy4Wi47CvWSah1towifpZu0tSerFTesShFboaAqoSvbnQF24M7k
         xSymWPh/WZKxvP7KrWo40LxdcOqgzKZjKY2HBZremSNN4VSLzkaTC3SKCNW83/niY127
         DxcSP0bATUrOXlSdNPQZCjosiC5hRVf8LZfrbscbuKt5BTlGdvNIN0SdTQY6w7nyU6Cz
         e9rhoZAA0QaeZglGF9c0hzWKztA+6YjNiPi7FB8aEdive6e5ne20MlpOWcuL1u4SAZuE
         IxevA+85y1ZEWW3PfExzYmY+/HGkhqW8vRCoLSXg+hwixzHerONXDKoRlynH9WvjbFtu
         ow1g==
X-Forwarded-Encrypted: i=1; AJvYcCUNqv+JqXELTjd2NszLTmf5qm3jmufWdaWy9S6el/sQ9nRlC0zSMEWKA6Jh7W5ZpOJyYB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyYbDdnRuiM6e8Mru7lxlxXRTzH6rYmzhUIY8ue9heCvcxksC
	Tq2dyeuPKC4KgeR6ayzkIJQgFKf5DkaUaauh9f5lOKhu1CwWtDgaglqc
X-Gm-Gg: AY/fxX7rjJeNWGoC+c13mjWzs5KRzrg3FjvdR1Xkv0gKTRsOpZM+u8/WkEuVIkmXxjf
	J5a1S6f5fFmP47taJFha3gfR26aj2ey1sqNc57n8D8yzQUv/l7p7cd4cvsO2mbXymEfkt/AsSHW
	Ys+zVhG/+yX4QbUxQBSsBI5F7WrlUzf8NlNnVe52YfH42Yxn1y5N2qgxOwJwkozxRmGVBfwHE2L
	PCI+0jZal4qgijBSDadgE+jXisaVvvaMjmL2jSBz3E3U3RpvhERbiIuuGTE+J+agKnitI/MXB4H
	KCHNLyk3Lbd55DNFnwvuBLLRDeyofFm86XWQGrNFmr5MGA/XFkv+zXgGQWQYttVMTx4OZ7RvTrz
	+7pVtntvwgEmeuPbAzwb0Wixpniw1J+CK8tIbREVKncjRlsczqdurHS8lPUo8y/SbKSA5PBDteI
	EpvEKyIN0G561EDbKRMET69cAnM24MZfJgAHrrHSarpXBaTJQVl7BBqX7BNP0pbSSeFw==
X-Received: by 2002:a05:7022:f516:b0:11e:3e9:3e99 with SMTP id a92af1059eb24-1233778d7d9mr3337201c88.49.1768423581158;
        Wed, 14 Jan 2026 12:46:21 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:19da:d3de:fbdf:aaba? ([2620:10d:c090:500::c9bd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12316f2db84sm12839971c88.14.2026.01.14.12.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 12:46:20 -0800 (PST)
Message-ID: <2e5ed01463ae8f79780a42c4e7f93baeafd2565a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Add helper to detect indirect jump
 targets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song	 <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov
 <a.s.protopopov@gmail.com>
Date: Wed, 14 Jan 2026 12:46:18 -0800
In-Reply-To: <20260114093914.2403982-3-xukuohai@huaweicloud.com>
References: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
	 <20260114093914.2403982-3-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 17:39 +0800, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>=20
> Introduce helper bpf_insn_is_indirect_target to determine whether a BPF
> instruction is an indirect jump target. This helper will be used by
> follow-up patches to decide where to emit indirect landing pad instructio=
ns.
>=20
> Add a new flag to struct bpf_insn_aux_data to mark instructions that are
> indirect jump targets. The BPF verifier sets this flag, and the helper
> checks it to determine whether an instruction is an indirect jump target.
>=20
> Since bpf_insn_aux_data is only available before JIT stage, add a new
> field to struct bpf_prog_aux to store a pointer to the bpf_insn_aux_data
> array, making it accessible to the JIT.
>=20
> For programs with multiple subprogs, each subprog uses its own private
> copy of insn_aux_data, since subprogs may insert additional instructions
> during JIT and need to update the array. For non-subprog, the verifier's
> insn_aux_data array is used directly to avoid unnecessary copying.
>=20
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---

Hm, I've missed the fact insn_aux_data is not currently available to jit.
Is it really necessary to copy this array for each subprogram?
Given that we still want to free insn_aux_data after program load,
I'd expect that it should be possible just to pass a pointer with an
offset pointing to a start of specific subprogram. Wdyt?

[...]

