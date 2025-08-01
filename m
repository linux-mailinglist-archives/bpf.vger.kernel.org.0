Return-Path: <bpf+bounces-64908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C31B18563
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77208A838CF
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1533428C5B1;
	Fri,  1 Aug 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFZ6F8x4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C226B756;
	Fri,  1 Aug 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064298; cv=none; b=tknuGFaPgyr/QYRwSltjeeZsg26hfJaqXR+Y06fnWw8dLy9l21EBxKNXRiyokhe2zSAqy8/jA6Tii7X+n2qTqKWXF6zbzv6OxSaK5fkxhxKl6WPthDkGFznrKuO6NchqgUuHUqtjg9w+C3bx/2MMT157Ikhl5VrmgKH2vMN8lC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064298; c=relaxed/simple;
	bh=sT5+gILX75jE9nEmMDlp+Prtc6kUT11BXMxfsofp9Dk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rh9Hxqp/QtYYpP65ZI63TnlV61ElKwdnLuov+puL4o76Q0RmzhpqffMT9406lxDloh9VLkkqL2d7xQDd70LOGKwbJNLOyrjiyNYqYWese1kgLDrJd5F3dQ5E47Vdhs/DBQJMDZd3jTsT/nvMfK2I5eoqdRooXjsBiojbieUxHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFZ6F8x4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24014cd385bso13677505ad.0;
        Fri, 01 Aug 2025 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754064296; x=1754669096; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sT5+gILX75jE9nEmMDlp+Prtc6kUT11BXMxfsofp9Dk=;
        b=hFZ6F8x4MBQPVTN+dlewpvH4Atujj31xZ2jBomRycMAjhqNKfO4gdzk2MHslUuxl3O
         BIYtHeygfhOEZKvBxHAJjpQWHcdrKRhbTaLDvVVW2ic78BzUUGxljrCZi0Zt6/f6XY2d
         E/Tt9akdsHIae6J4ZIN+udiI2OixvmMaJ1suLz8ztndeY0BBA7p1cmsr9XTz2bhGScnS
         sNCdaaFwQD0w4Xxq0LcouTPrZtMTQ+SpbjVGGkjVaXm2wYbWQXETsOz7NwJnCmisVKjd
         yLwd1YdXo3t7suD3M6P9mR12vF3Cavyz1A+Yzh3cQU29edibQ0O4Qkk+ZSh08Xe5bgPJ
         4V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754064296; x=1754669096;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sT5+gILX75jE9nEmMDlp+Prtc6kUT11BXMxfsofp9Dk=;
        b=bViqw+hEIHQktMfXtKEu1llDP5f+1DFgBmAzuFLp84DZt/avsCV/TZqFTjOWvI7qxB
         kyabnYZVsDuF+2tuFUhroHS5MilUVwZJ3cWdFsC+vDO5KyFnBxrRRhBRPgsf9Uk7zAPX
         ESKkur1Qbtd0hHorwLagn4RqSgqj1p2Wia2ckS6Jz10JJ3Y9xs5b/pxDfoo/WMAmdvJh
         efpmxsh8dFD3f+0935BzDczFs1Byf7vTJwuWjltCR6QL2bg3iSsKs01kxBPlaKAG6Sc8
         qzrM7UPy1gq0klHXS1PVN5QfYZm8Yrex75lHS0LXomiN2vCUZCCJVsn4bpsCsJrn1stX
         TUYg==
X-Forwarded-Encrypted: i=1; AJvYcCVuA4ZH+TNrFSac2FvfcCBorBtwoc+v4U44b5rxcX/Gv9In08mbvkBQiUwKhuKooWkwEDM=@vger.kernel.org, AJvYcCWqom99GPYP09DiLxhinAaX12Lnb4kR1ijdVmsL4B6HZAfKF0gLH0cGZzSSWTPCu89dvA2wQ5S/Q99NfaxsulW0@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7fmm5SVtK3JCExbr3fCL3mIQ1WmzDUjdDUgP7xZHl9/Uaw0Q
	JeZ1qIPz4SGNasyb6e5y0ZypAWF9AXv9kclDBpAaUJtYi/4qcTH3kPEohBAQ8nnK
X-Gm-Gg: ASbGnctWiAqI7mvYgOwJdS6PbMWQGBKWwK6bZziKd0MXTkkA/s79XRvWbXaQMnw26uO
	l+ORcG17jZTl+uWxSxDUfDhI5Fea7EZfHCBa9Zcw+RPfhqBKlwvbBpCigOeVkpB1Y2G8S4gOZdJ
	3Ym4NtcGDU68cyaD7Cv5bHFabiqDWw57KgNuq6NH43jGxyrhxP6S6XTQPL9SIb91Ggk2sUqrFz0
	RXPF4NCDBP5NvJ83BlIMFywGWqMSuwTvEQrgzp1kL6JcS2L/dxhY0gFQF2X+170pnqSHrAJ1f/G
	FuIA+jOJhiehM1RDdHo8dxg4IdU0unpAOwHHn5pkaRaOLEDkkGX686dRqJeEQtCfUc1Huby6bXm
	nKdKCv7BKK2oeJK+BNKiJdojcuc0hNA==
X-Google-Smtp-Source: AGHT+IHJIXdii0rMJAwRu8YRujpMl0HWhvsGcyk6u7NuEINtRVlgj2la7H3O2AZgdDxJNYOVVECIEg==
X-Received: by 2002:a17:902:f705:b0:240:80f:228e with SMTP id d9443c01a7336-2424705d7c1mr669335ad.52.1754064296464;
        Fri, 01 Aug 2025 09:04:56 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bae3036sm4052572a12.45.2025.08.01.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:04:56 -0700 (PDT)
Message-ID: <271c59f8837ed5a077aacc062d8c7e79712f75e0.camel@gmail.com>
Subject: Re: [PATCH bpf 1/4] bpf: Check flow_dissector ctx accesses are
 aligned
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, netfilter-devel@vger.kernel.org,  Pablo Neira
 Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Petar
 Penkov <ppenkov@google.com>,  Florian Westphal	 <fw@strlen.de>
Date: Fri, 01 Aug 2025 09:04:52 -0700
In-Reply-To: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
References: 
	<cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-01 at 11:47 +0200, Paul Chaignon wrote:
> flow_dissector_is_valid_access doesn't check that the context access is
> aligned. As a consequence, an unaligned access within one of the exposed
> field is considered valid and later rejected by
> flow_dissector_convert_ctx_access when we try to convert it.
>=20
> The later rejection is problematic because it's reported as a verifier
> bug with a kernel warning and doesn't point to the right instruction in
> verifier logs.
>=20
> Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook"=
)
> Reported-by: syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dccac90e482b2a81d74aa
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

