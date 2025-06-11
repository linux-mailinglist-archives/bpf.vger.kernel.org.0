Return-Path: <bpf+bounces-60413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1706CAD6383
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C930B7AF065
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F88254B03;
	Wed, 11 Jun 2025 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcO1MOyW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E924C66F
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682660; cv=none; b=hrwH71qhndfLCp8GOB7fLv21JUAQIrUZRSpjEnKL+tpsvdEd0WAAgwC66Opsh1ts818ZVOoSdnRG33eZA8lITEaqzo+y+bGQX2HidMvX0+jtW+UoAVKrIIxfuHjhxgrdri0VQiwffRqkSQCIve7NFqO5aHrVjHECa4M2ARtgQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682660; c=relaxed/simple;
	bh=BCalHRmW8p0kOjeyEqvr2tjY4Juiw3vlvjSuFd3gU1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RfBcXAeK/67AXaxZGqGmQ41IPuHOJWpd0ueYnXEk3aIbVEZ3NBwRUv4m5OvL62geL/wLpvcYJXUbI+lT0WBE2BJdwhWePP/fgJ4/umAcmYGjtibMMmFYBH5cITi1Hm5XfQX79zGlR0kPySVdS5FrUEemZOokFFyKecCQmfGqP2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcO1MOyW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso472962a91.3
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749682655; x=1750287455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XnEk2tYVdilXAbv2eev8nUUTVdCmN3+YHzNqF6ISZZE=;
        b=dcO1MOyWRfhype0ThlVpacrdRqaov7M0rjxGfPqDbDy94N9LsUxglINXLywBaQZdpa
         HCpPzLu09RHsbTAB8tvq++UZdtOpUIl/zhMvuhuW+6prpULWCJ/ZXaogLaqJEE0oqTGL
         0p9r4hiCB22QR6jMe+r4cs9ks2Wg9VeYEtiFSJIHkU0t7pom0iW0z9Q65QqjOMIkvLqh
         NhIAemwhn6JjEAX/SByE+qSWl1skTpgZpUCYxJYociT9AsU9nZa/STkrFZekwGVUq9VZ
         IBRBqiWMW9YqrogU41BbYAJE7IXtIC6OfUYUbHltM784CusVE6luwdmGRZSMpV7yKIaT
         Er7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682655; x=1750287455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnEk2tYVdilXAbv2eev8nUUTVdCmN3+YHzNqF6ISZZE=;
        b=J73aTRlaBhmQO7PRDBHaN7Qwy0RW7OlzOB0mvX58B3k1knvvogIUfTl2vW+QLdFNRv
         hSNv6IuMT1QOZqkybm3ecTjPmwYBrJ/xJfP9u39VMMVw1dtZqHSnB0E9fNEnjIZmuj/E
         qNP8tZAMclCCFMMQbf1hjdwuA8NdhFNbleCAV/eEoWngnm2HY3Aspr/nO53PP1bRs9J1
         78sh1W9Yd9Y43sKCqYseL95E38K8DtxUcYePVGMc6suuhnBYQti3vjBUbuk0Z7vi9Vp8
         ezzjsBaauT7Q6pTqMvIdsp8ypaF4XOLyO+C1Bo2qKVFWujpnvtkbv4IpA998I697IT+p
         ZIbQ==
X-Gm-Message-State: AOJu0YwJl19DTjqTLJgbq4m8kePkH6+FzsFJCtMMdGyq6/zwXhnbBwm/
	xE5Y/cEyEdULxy6cOhFkBq7rZJy8+IzTXsm7ULG0moxFa3BrgngzIiAo
X-Gm-Gg: ASbGncuAKV4DX0kRyhpEiZ7rfX/WBqNwzSoXa965SuQgoo7NXuxYpgsm8eqP1twmKNG
	+iFxiB4/CSAWMytroAHpYuUhVO0oVfDnFjdgYDgPdEkPTCaZZSX8NX3NctP2VEU4mjCPAEyqBeW
	+/dd0ljva7/Hmbs7UyPlVFXV6LasuE9ggGD6fTXBXuTiI3r+aGtsOUDS+DfvlnBZii7njw5eR9K
	mfcx646pon/3mIPUyY5QUJKBtCX89iAkycb9ZOIR/5AlPBxcTUWoTHb2+Sowm5MqdnmqB6wFEXX
	wi2xvnmqKBl2lWGKrFXuVyhI/nd+utpCH/9G3n/jcLReSAdxdINISl6//SyKyPBT+ymyxNsKqEQ
	eUwxlosuWQQ==
X-Google-Smtp-Source: AGHT+IG7iUo3d6D97stS9FMmla0k3EqlEVn9ADWnDQP9JBvsu2x5z0+VecXSNX+JiQfFELLK3weamA==
X-Received: by 2002:a17:90b:498b:b0:311:b6d2:4c36 with SMTP id 98e67ed59e1d1-313c08cfc79mr1052139a91.26.1749682655413;
        Wed, 11 Jun 2025 15:57:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b1d2:545:de25:d977? ([2620:10d:c090:500::7:d234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19b810dsm166695a91.6.2025.06.11.15.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:57:35 -0700 (PDT)
Message-ID: <82d86ef16658c3d7ffbdecaf7a76d2e35897a869.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] Revert "bpf: use common instruction
 history across all states"
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Wed, 11 Jun 2025 15:57:33 -0700
In-Reply-To: <CAADnVQ+J+ZUXb6Kgry520V2Dvo85f7MeBnKH5OMm6fqoAJFqnw@mail.gmail.com>
References: <20250611200836.4135542-1-eddyz87@gmail.com>
	 <CAADnVQ+J+ZUXb6Kgry520V2Dvo85f7MeBnKH5OMm6fqoAJFqnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 15:45 -0700, Alexei Starovoitov wrote:

[...]

> Though it's fixed later in patch 8 as:
> -               err =3D push_insn_history(env, this_branch, insn_flags, 0=
);
> +               err =3D push_jmp_history(env, this_branch, insn_flags, 0)=
;
>=20
> It would have been a bisect issue if not caught by CI:
> https://netdev.bots.linux.dev/static/nipa/971030/14115002/build_clang/sum=
mary
>=20
> I fixed up patch 1 and 8 while applying.
> Pls pay attention to such things in the future.

Ack, sorry, it's a rebase artefact, squashed the change on top of the
wrong commit.

