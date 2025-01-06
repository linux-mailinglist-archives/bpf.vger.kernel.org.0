Return-Path: <bpf+bounces-48006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A21A031B1
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F0316171E
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB161E008B;
	Mon,  6 Jan 2025 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOY+KiuX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF6148316
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197074; cv=none; b=WusIAk9Fqpov6VIY1LZ6ViDrMEuK50RF7ldu1by6HeqO1nXAXT7iuDr1w2GBWubmx0qXhL/ylPIM8sGTzo5Nklmm1jbWijWg4mvzduTtOIATGsqkCZASfGj20jMgJaREXTH4h4MDd9Z3u72nLUegjdudcKxAI9NJKUwZKOPrxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197074; c=relaxed/simple;
	bh=DbrSK/CZ5qu4pXlfZ2NFmNNw4U1WJ9X+NxX3n7q00xM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MZmTyzj3mhicEohsNG6drhXrCrtZgPR0mkWovLz2qFB8lTo1dtIUkqPTMnX3niz0yi7pMfhnab5yCPSp8AvR239gEA7c5cOfCSqsE6hcefWG0HjR8TPUaZAz95uebUmbymf0L62PF9hn27/GflsxnWeRVpyKBWi3vghcrLBY92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOY+KiuX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2efded08c79so16946245a91.0
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 12:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736197072; x=1736801872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DbrSK/CZ5qu4pXlfZ2NFmNNw4U1WJ9X+NxX3n7q00xM=;
        b=DOY+KiuXl0mZmbCNRWgtFzW39KjR+0zenopwi0wQSooxs3RZd1g6RD6CXjAWzIS/rZ
         dGzn6KatRqcSfynykv3m/Zd0ZdA9ZL3FEdbZAHq8UIG9M1xV/uCWkZOInpZmdfg/fIse
         qlhTCpdYbMoi2pWCea312E8JJojHCMtueaqWEYPj7qS0JPLA8J6oIdgHbZEMX3RKxABX
         tF+MgBRO/t5FG8KAQy4mskupRHkSqneJq+LC9FKAYpbL+YDyzAzelJHThizCP55Lwzy6
         qKPgsxK79/F9lS0iPaaH9ITGoghIyzmCPujW+uTfxgIrTaVfLdhRiOgykgOJ3E1yx30+
         J3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736197072; x=1736801872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbrSK/CZ5qu4pXlfZ2NFmNNw4U1WJ9X+NxX3n7q00xM=;
        b=nNleuORycthZf7GPPmub6GyCssaaSGKd731ibtvFuyJ7F79LoTzDPAr8H5/O0jziJB
         6Q60NedFRYvglv6CBT2hQvymU1DFO2WppG/hdb0yr6NEnZmG5PJ1lDm2vTKeEWz/9tRr
         fSCeQg0xDmiR56gF9DlrzFPowVZyxqJR6aRuY40ES86LS1XHYnvNWL2zm1E7a6U9Ym52
         FALUgLQjClVarfBR02eSfx59QiWpIK+9ao+htckOPZtQh9VkQy6ZTMmpn8d7qDd77Zkz
         EcDN2En+BnolHL8JCSHW1Evx+YDcDnxZdVJf0D4gSmO+ii/nWXyel7KqvzaTVdzNyHjX
         Yjmw==
X-Forwarded-Encrypted: i=1; AJvYcCXSHOb+gwaPvCYppHmC58feiUbZUBpFLdcWDuCRuslhnad4eWosSG50e9XAT70jTJeV6As=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhW+6h4eLKlF6Fi3uFqdMBf48k8wABdOIvhJc028zP6WcJOnO0
	YsilTH4azDm9Aiw32YfFR1hvKT1PcvIWK8FoYOYBMDn2xxCZ3vXF
X-Gm-Gg: ASbGncsif5zxPAsdZ6ZcK/LVWnoLrahtvH+B4TcKOjI9TmTead7uTwE2NQeFaNALVTM
	zV37qwtcu6o7YfWvyVN+batmGChPq8uL2ACkYSeLZeGPlH4AGbhvnAHsJ3Djk1/4XMH+TWzqVgK
	mL4OR7vuY2RI6RQ9QVpmpUNCxvOKhHFAZb+fTlr8InSRX6POXnAD/bliSZvk6RcimFZBR2sI3z4
	IpyCRO5lE6mM1x8AujKYhHjo7ptakHxgKdOvMLzAO9mjiYBPF7cRg==
X-Google-Smtp-Source: AGHT+IGdlkO8TrIT1i1QZu6VqRex11t2xBPLap0HrH3rXc3FIOemWwSxNsafBErRxiCyzmwh6IO3Zw==
X-Received: by 2002:a17:90b:53c8:b0:2ee:c2df:5d30 with SMTP id 98e67ed59e1d1-2f452eb11e2mr58459437a91.26.1736197072349;
        Mon, 06 Jan 2025 12:57:52 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4477c852csm34208735a91.22.2025.01.06.12.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 12:57:51 -0800 (PST)
Message-ID: <ab41261789251099e09f62909da2b0dd084170c3.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: handle prog/attach type
 comparison in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 06 Jan 2025 12:57:47 -0800
In-Reply-To: <20250106144321.32337-1-mykyta.yatsenko5@gmail.com>
References: <20250106144321.32337-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-06 at 14:43 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Implemented handling of prog type and attach type stats comparison in
> veristat.
> To test this change:
> ```
> ./veristat pyperf600.bpf.o -o csv > base1.csv
> ./veristat pyperf600.bpf.o -o csv > base2.csv
> ./veristat -C base2.csv base1.csv -o csv
> ...,raw_tracepoint,raw_tracepoint,MATCH,
> ...,cgroup_inet_ingress,cgroup_inet_ingress,MATCH
> ```
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Seem to work fine.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


