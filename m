Return-Path: <bpf+bounces-21810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A0852572
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B7AB23AAE
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD80A947;
	Tue, 13 Feb 2024 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUoiX4kr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98BAD49
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784491; cv=none; b=do7oPUgR1Uqzyx8XnH8UFmIcb3OCqapteuXq6gbhFMRKI7bmW60+Q1FAy1bsqpftlD1+14le+yXcrolt7SEBGeHk1zBjFGo/f5gOu2s+tWFOv5O/kamhUgn7dqGX2vRZwD//UWCnHjlxjeO9BDBIW97EyK+ykA7le81XMre0vNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784491; c=relaxed/simple;
	bh=FOGc79+ETvVA6Geopaoo14UU1BZXbE8uudRnk74Ugrc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QASZo5FYB5rC+XVVZHeHNf7KnMs9EzQt9v8jXDnYq2v9/O4rRmkfnFF/aHiMx7WPuBM6wcInvfAbk57z8srsncwiaxM+2pf+tW/N8r+nzOfXr0RybIzqPGATTqO8XQ/s+FZCnjG8EWEmCHdn4Lk9wo2DbcSePYh7ZVTrorifeT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUoiX4kr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a389ea940f1so411252166b.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 16:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707784488; x=1708389288; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgAE2TBY55VeyYZWuloSgaoDdF9/A6cg+b5lU/FoEXc=;
        b=VUoiX4kr4UsPYZ6DzAed2s92rncbDzkAdkrGip0jcrlpgBZK85nbow3vZFeM2K8tU/
         P+saeK1D9UqB6UJEPMTjxkHnaBZE32svBVeSaw+Tar2HyzAa/cr19unlIrliC6RAUscu
         LBJV86E5Gra04U2l+q3pYvosuBbw16EbLLc0WMZmMN6fZk+zi4D2m7EAb7IRT5yOAX4P
         iSA79Nc0SCwowDnJcNf1duwvYRQVyPzuR7icH++6aOBaWHLVR1mMTGFjKntSFAH8lcmm
         qAGs0hwY8fuJDObMLBQOX5qY3K6/3p+Qq52AbtM6NN0ZvJ/NxIQJqqrqeAvtK/sFDvBE
         3/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707784488; x=1708389288;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgAE2TBY55VeyYZWuloSgaoDdF9/A6cg+b5lU/FoEXc=;
        b=VM0GP1MSrB3KrWbF13Zz/urCfbb/tCBBuFIy54S6oY2DWCJQNvP0UsILpBymDinb+/
         JFVS0c+Ck6rjpSmNe5nLpsm+eyEUF2X343Ioc+kX8o30yY3gTKUjEeJlQHFNCLlfbcE+
         swJkey6xnJCTyW6+T8/geeXmDttxrF3Eg++q7q7d7VeJs+r4QZ/x+PW6Hk5N1S2i34Jn
         PEkJEJc6Bpk8D+tr7taF+9If5lE0q4IygV3Q+key832/RAhkeZ6aHcnkv2GKOtZNOxF3
         ZKtITlCAoX0NMs9CUTwhQm5PfoNfDUtGP/ylQdtDgec6iKgm0Lb0HpxCXfixtSAUcMRa
         yOlA==
X-Forwarded-Encrypted: i=1; AJvYcCUxLN82Oxrnu0uuPGO7NIaI7OJnhhq+Y/0uMq0wKYSvH8LQwd9I/dBNBm51V+bxKtR8vwwnsHN9j+dEAEA4kxm26Nm0
X-Gm-Message-State: AOJu0Ywckil86pypu00z+o2ENs3z1/+zRRaPNKWHI4Tyjct8DuT1DjQQ
	25hFvfzhcXarrUWoiDCqj5ua7d4VDVer8tDcIklMO0x+seNVBSYU
X-Google-Smtp-Source: AGHT+IGtDPRIuxb1QjBBonx0v6nNo3jP793WFIAHxPPA4C+Am1ppDMHG2e51mlcbk4h3vbSdo98+Rg==
X-Received: by 2002:a17:906:4144:b0:a3c:82ed:5b46 with SMTP id l4-20020a170906414400b00a3c82ed5b46mr4117733ejk.59.1707784487660;
        Mon, 12 Feb 2024 16:34:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrUmQ3aTjdZq5V5PlZymtYfgjs4g5TAhwxHIlv+II1BfD9uXHpnkLsyexTpavr9p5wIyj8lpeOvUsdMIwbyc6zJqiz5l2EGqWDzBnXlpmFRHOPmydKGiCluMdH7oG1WpktzWJCoGYLJloyM3HQrAdaDne/F0FAxCnHNHl/nBiFEyxvEA0I8kJDiIfOGi7T5qHWHYUpSJ3U7jTHAYl2LhcAWA6jL3ttWDnm7r0GQJTk2u8XCu/lNsp6mdkxH7yL4Pg+/WLJe40iPULzmOXF0BQf8ssJyTtz+I/N9Z3Nr+dV6GVaildKfh9lH/3KKGrZgtjM03TIvikBZyMmY2Qy8tAsqRtJ8buRoIgVndKm+RyCnjH/PIx6j4Cw
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lr22-20020a170906fb9600b00a3c5fa1052csm705708ejb.138.2024.02.12.16.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:34:47 -0800 (PST)
Message-ID: <d84964662e2e11e6c94da99c7c3e8a8591d1376c.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global
 varaibles.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 tj@kernel.org,  brho@google.com, hannes@cmpxchg.org, lstoakes@gmail.com,
 akpm@linux-foundation.org,  urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, kernel-team@fb.com
Date: Tue, 13 Feb 2024 02:34:45 +0200
In-Reply-To: <20240209040608.98927-15-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-15-alexei.starovoitov@gmail.com>
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

On Thu, 2024-02-08 at 20:06 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> LLVM automatically places __arena variables into ".arena.1" ELF section.
> When libbpf sees such section it creates internal 'struct bpf_map' LIBBPF=
_MAP_ARENA
> that is connected to actual BPF_MAP_TYPE_ARENA 'struct bpf_map'.
> They share the same kernel's side bpf map and single map_fd.
> Both are emitted into skeleton. Real arena with the name given by bpf pro=
gram
> in SEC(".maps") and another with "__arena_internal" name.
> All global variables from ".arena.1" section are accessible from user spa=
ce
> via skel->arena->name_of_var.

[...]

I hit a strange bug when playing with patch. Consider a simple example [0].
When the following BPF global variable:

    int __arena * __arena bar;

- is commented -- the test passes;
- is uncommented -- in the test fails because global variable 'shared' is N=
ULL.

Note: the second __arena is necessary to put 'bar' to .arena.1 section.

[0] https://github.com/kernel-patches/bpf/commit/6d95c8557c25d01ef3f13e6aef=
2bda9ac2516484

