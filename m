Return-Path: <bpf+bounces-70462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0E6BBFD56
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 02:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04EBD4E6080
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8431A267;
	Tue,  7 Oct 2025 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFL/B+j1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5B834BA2A
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795727; cv=none; b=APRmOrNlnAdOklRrKNat5e+7eGqT4BUZx+tKsePtS5vRMG8PGiU1XQ8u/ThbNX/qqHopNqb6+L2HWMiVOQGMqE8rvtezpGFctP6nbrYjfDK/tmv3iC89qF5axYBymWpBN8l8931pRLeOKTfhzqI0YlTY3sJWHmo1T9R9P/oUPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795727; c=relaxed/simple;
	bh=nGZ2EogrKEiaqTL5GriLDgLwRavCphC9jYMZV+lxcho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5tTk1vrVUL5HAiIwea9APvl0aL/ZBiO3HQ/+2FF1Ng6M0B6NqwGzM9JNUhw9nvhFRLQU6hx/osqei+0BEyDhRF4tf8jzisTh1GsHM4+2sJoE1TMXfOpYixjBGESWWwqurflp/uTtWn1ofoiyIIULTfW9PyV7BtRZy+ZQE0L478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFL/B+j1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7835321bc98so5320188b3a.2
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 17:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759795725; x=1760400525; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oiRjcfJIewpa8KP7G1m6wLpSth0fMD35BS4LqaYJfPU=;
        b=RFL/B+j1cCvMelfx9XA3IzZQMTyhfpAy7HMUUg2qu0cy81/dy57EE9qh1r0Lz6YAw0
         ABVXKp4pePrRY6el4mxHhWzMMmylpeQnl4m3iXXv60TftwUbXoEjSk4BbxgNBYwt27UL
         PDSp5yk/5bDeBYhxIAkJTYPjPZ2jeC4mpE52aj4hRiL1vNFUHOzcL+AB3tCEi1uOICXP
         TYfns3tjCvpluShFjQJpGhpwDUub2EWs19UpMRJBk8rfBTMnQME9jqSqjkLiL0xbrSbC
         JZJK+hmxyT56cJL/2IOomMwbXl1pB6i2n8jPefPCHCnWxU/si75sY7fDshMqPUYJZ5zd
         Mm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795725; x=1760400525;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oiRjcfJIewpa8KP7G1m6wLpSth0fMD35BS4LqaYJfPU=;
        b=JKJCDReI6fKX9m6WFIj4bv1J/664VGwws3/UITv+w7GhUQW/JGTWlpL9vMf3fq/+MI
         /T0Ou5XfCH5rP9ToEpsGHuYnKr4W7ULf1U0ZOdlymKvQjRmiQgALNeR1vHNKKd/lsNN9
         7sjgwTIH1eLcQrsr8SCGhQu46/zA6MEDBIPbyeMvyBNq9fUXths5Y6Z3ZGqEP7UMlwK5
         Xl7pNBlHjMsyjPb40xKrn3RGA6QRu9+RxePHqB/2od4Emy6IrVQw6i+QvLtCNCN7amIM
         5aE0ZIvQsOX+NNbHxJ7pCoicqjhui9pzFcCeAl6ecnLE6QolBc6DV3aG1kQixJMPrE4m
         oJkg==
X-Forwarded-Encrypted: i=1; AJvYcCVfsuKGfcD6KF/PxQ19rMVWpMn/wz/+OvCwc0CCTSdX6Y5bweF6syjtogdMjXtzb5DGgIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Hivt1pRYrULpggc0gfiMSR+0WJATnZEkQSjaoVQQSrxqi9Fg
	9krAXGln01l3/tTqo8X+/86Lh6icvOuFHhseJenEpRhIOav1iUeMEVE1
X-Gm-Gg: ASbGnct5oK1DI5WD61oKSw1clTONxZ4GX3XFVLP37RPGJPbI55GjCHK2/oSbf/Ia3J6
	+GDdPoVQuy5gvHlVIUhgaJL3X3lSpJAXri/iEtG0Vmmb+CQnu75GQY8BaTuneCUc1vvsS9T9032
	lE0KGtMGYSSsCAoA4izCMX3t/zfO1UHoPhNKvtcjJ20xqAX7/kZfM6YGNNxHsr4Lud/OazNi+pu
	QFsbAalU8CdjCrJJPTw9245I4E7zxgtQh+jO1TXRxCrRcn8Mto9767MZjkKAvETTHoKqXzIxF5t
	P3Ug42f5hQUBOfNRio17mTzKI6guFk4664uKmZWO5WOLMD4paxw3QhM/jvVqFriHozpL5vSWUGA
	JjKaffa/fvly5sKTxFJvGCnEd+n+ABFtCAHruW8fZXKi4a9gXZOt21Fh6sT3ks/jTMpgc7nh9
X-Google-Smtp-Source: AGHT+IHpPGEg6F+zaIjrg++N7k/pdjQYMD/uPyurvbJxPRRfms40/f1ejJIWbvgrNbkhNrq4XVA92A==
X-Received: by 2002:a17:902:ea0d:b0:269:603f:420a with SMTP id d9443c01a7336-28e9a5cc5e8mr205676295ad.5.1759795725123;
        Mon, 06 Oct 2025 17:08:45 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:d60a:adc8:135e:572b? ([2620:10d:c090:500::5:b20b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a3255bsm12170646a91.16.2025.10.06.17.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 17:08:44 -0700 (PDT)
Message-ID: <7b2f7c6b6c0332ecda81239b04a19a289d38223f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: extract internal structs helpers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 06 Oct 2025 17:08:43 -0700
In-Reply-To: <20251006200237.252611-3-mykyta.yatsenko5@gmail.com>
References: <20251006200237.252611-1-mykyta.yatsenko5@gmail.com>
	 <20251006200237.252611-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 21:02 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> arraymap and hashtab duplicate the logic that checks for and frees
> internal structs (timer, workqueue, task_work) based on
> BTF record flags. Centralize this by introducing two helpers:
>=20
>   * bpf_map_has_internal_structs(map)
>     Returns true if the map value contains any of internal structs:
>     BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK.
>=20
>   * bpf_map_free_internal_structs(map, obj)
>     Frees the internal structs for a single value object.
>=20
> Convert arraymap and both the prealloc/malloc hashtab paths to use the
> new generic functions. This keeps the functionality for when/how to free
> these special fields in one place and makes it easier to add support for
> new internal structs in the future without touching every map
> implementation.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

