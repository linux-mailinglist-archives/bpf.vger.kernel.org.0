Return-Path: <bpf+bounces-76521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F643CB85AD
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 10:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C7623009954
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499A30DD2F;
	Fri, 12 Dec 2025 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZIAvXGp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50051282EB
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530086; cv=none; b=J+/h0Tjk7s7n9eF7fSFuYx4lvfAxZUSNVnW6Q3N1YmZ5LCGVisOU2Ord9MVTa7QmIyWlsBgeW86z8Dm0uUV5EOMfmhO2MPm8WfgJOR6Gd0iySB1xWNyPlQmdCRBlAOJk/yt3A0XiS0chcJfagF77P90L0JuOi1Nc1eERd/c0VrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530086; c=relaxed/simple;
	bh=JKozA+ihNq4x4Z9RrSdTKWeKEiQ1xyKxK4t4W67sS6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AyUzLm+L8o46JIiLajFYkqVPopleElVu5kZZFRLAYKdbbwjsJsWwM6YyMpzDvxwM8GVdRjzx0lZttODNUbCvNObIIx7qVeQavG0JbLf5L90/6K/GsokPLzUTT1s8rwrzO1iFe0s+HlFrGnx0gMRjAJcOFvia5QUsmZBXpqSNWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZIAvXGp; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c7503c73b4so548709a34.3
        for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 01:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765530084; x=1766134884; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JKozA+ihNq4x4Z9RrSdTKWeKEiQ1xyKxK4t4W67sS6Y=;
        b=EZIAvXGpEbKmuutCyOXbkCuDLYOm1e26odMeEezMdaEaIcD1tvdWK6e35upU50QoWU
         DxO/rvrMYkxcUeOy2bqhL6Yb5kvScfJeyOks9lKBDhe8d8s9kcNjtE6dr7xKDA7ELZQL
         NWRDNXmnEjx5gwyKq7bZprh8+n/bTJr8Y/lS0FT6Ct3lktLjxCxNOuoNViXt8E7SVOBA
         V5/9Qimb5niNxRMy5m0D7kcz3qc3yaRFrPpMgY6VHko5zXGmlsd9yz7SFpo6FADcRx1q
         M59r5kIVV0YH2+UZZEhFcD5yIbPEVuojZrW+fP3+tSMR9zt2aqhOcp0uwCitPW5bV+RT
         U6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765530084; x=1766134884;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKozA+ihNq4x4Z9RrSdTKWeKEiQ1xyKxK4t4W67sS6Y=;
        b=cCHBdapuTnCGIsRb2/axMEAw9XFWlfy1tCyfNPxKmFWCE4og+38jew8URFqiLz+Gjv
         OOhhg+NpNBwGjH9oONNNGSGvg8sufZybmIEaC+UkHRmFsm5HT9S02aechs3PvjdcAQYX
         jp7j0TJnNZQk7ire03UCrgRNxGB/aHYKmEeETg5PZQfiMy+d1qOwweNJTgCNO+WiKnKG
         mbLUlWKJdecivrh2eeNCP7moyOE7YMm87DAaUKMzevWZf2704a0exno4n+EnSA7nmnQ/
         uN4WdxUiP3va7HIYsMSDW2DVZ57LeuWrRKtn0YTjoChd6m+UrM9CV+AKDJb7Qrz/jZno
         WAiQ==
X-Gm-Message-State: AOJu0Ywp1p1BSglK33BZSdYoqhvjNPXEzpt5tv7ltGDRlqQW0kzbPaG8
	lTIP4dz0gO9K6d673enp1MeJY4V8VcHPLScirpAZ9Gbrv+Tej/waO1M8pPZPLArt
X-Gm-Gg: AY/fxX6VZng8IiKPIFN+U3oP5oIlySHX6PhcrQk+0Hg6MJUnWRclAV0i5h/d8g/dGCw
	qabIalnm5H+LWufBuIRjhTNdaQ8TUDYtBTXTVnujmvM2gvXZZPsl3uTQGObtArS1atiKEd9VGI9
	fGlzZtc6LqUiGnx/U2X5tiqj2xmp9WuJCxzoud5SPhPlwmAEQF1btCIf8CSl5IyoGNz6RcQC6Bw
	XCfMe0QcYcUrpHLi6/6mLFsbqVv+NkOwBtda3UQFx8tMJFa9lPyE7kPfsXlj+X3PiGZVbsFgz5M
	5GpeeDYHddgEqZWt4BB/vATezvPutFdyp8MkaO4EL4uckwoZvb9UB9wmDsRCEUEB7CBOJmdRbJ0
	YSnSXyPgULrVOSCuHSxEWFi4Jdw56MrkQeRUAUp7dCTnyUU3Gnw9uUZW46q4moRI0c0favsoV8a
	RC9VUrWfUp96ICsJ8NTL1QYuVPr6dJxU49bhyZgHLu459BPm9oc5Rrgg==
X-Google-Smtp-Source: AGHT+IH321PbFRiMaWCDNl4lSGVuS0AwL6lMd2u2Ei57eaf0ISIe5GTqG0pgY602LItAKZZCrdasEQ==
X-Received: by 2002:a17:902:f686:b0:295:9a46:a1d0 with SMTP id d9443c01a7336-29f23cd7cebmr12297065ad.45.1765523389898;
        Thu, 11 Dec 2025 23:09:49 -0800 (PST)
Received: from [10.200.2.32] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f2e40765csm5138155ad.0.2025.12.11.23.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:09:49 -0800 (PST)
Message-ID: <e509afe94b4492d64e27756f4db773b7a179e994.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] lib/Kconfig.debug: Set the minimum
 required pahole version to v1.22
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier	 <nsc@kernel.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <void@manifault.com>,  Andrea Righi
 <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan
 <shuah@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng	
 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Fri, 12 Dec 2025 16:09:41 +0900
In-Reply-To: <20251205223046.4155870-5-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
		 <20251205223046.4155870-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 14:30 -0800, Ihor Solodrai wrote:
> Subsequent patches in the series change vmlinux linking scripts to
> unconditionally pass --btf_encode_detached to pahole, which was
> introduced in v1.22 [1][2].
>=20
> This change allows to remove PAHOLE_HAS_SPLIT_BTF Kconfig option and
> other checks of older pahole versions.
>=20
> [1] https://github.com/acmel/dwarves/releases/tag/v1.22
> [2] https://lore.kernel.org/bpf/cbafbf4e-9073-4383-8ee6-1353f9e5869c@orac=
le.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


