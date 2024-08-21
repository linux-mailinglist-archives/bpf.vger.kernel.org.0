Return-Path: <bpf+bounces-37775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0A595A6C9
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F41C21957
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0AF17839D;
	Wed, 21 Aug 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRzcGuP/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484213A3E8
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276282; cv=none; b=UnMPieli/uk6jI25uSvv3aMJDb5EUrCqntG89TyD1cahwN4dVIVQmOzBnWHICX7lgMDyti/O04f59UEdWtarXjVMK/6HjGRUNCRWX+eim0zwb6RNuOs+bnFEPBpeZ6wXCfpUB7FiY9nuBFJmxJXX3aRfcsVE5ZzrToE1LTZtYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276282; c=relaxed/simple;
	bh=2PK3lfNp9O5AG2/77+vGK2kPRV0TtLNvlWqJrPEEo6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alG72/dWEFuWyHgoRLycUyBpwSE6aHETSI89qs5DKoZk7prJmcCZ7q9maAqH1FCJBuLcLjpdYIsSAWh48ECyHlTdI396m2fX8oT4Le4w4oYFYbM/5Q7Yqpx+KhEw29qExmPOqjepCyRMtQ3+xxbPx8OC4EsLrLUCtklmNvW5yHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRzcGuP/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371c5187198so34372f8f.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724276279; x=1724881079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PK3lfNp9O5AG2/77+vGK2kPRV0TtLNvlWqJrPEEo6Y=;
        b=HRzcGuP/MzQOfn7v67LaB5UQb5XNdWW6mc46m9n4bugKcbrKFm+zx8FhQP3PUYKo3f
         c3aOU1SyrH8STE6pz71ey5inwcrRA+uqcx28VVc6D6iB625Z6/BcobY83d01ycQ5dPb8
         JtTNe82cQWkHCq+qgffpJtuuuvGiILXWe+e4f1Q91ZSWk+ltK7GMiOQwEHqLu3UCb91H
         jJMYf+Zzw001Dkg5hWZiM+ZGmEbanuIyP92aCWreDTfgp24gnAVKPnYFCTV7Dwoimmjx
         FaM/moZLTgyp8KZa008LAS5tGmXkBucvXo5fs1dHMT6k/X49gKgNItMHyJzMku2Z8aP+
         tOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724276279; x=1724881079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PK3lfNp9O5AG2/77+vGK2kPRV0TtLNvlWqJrPEEo6Y=;
        b=c/wTcR0vVROmhDjdx50wwrNA6UKhZ1auamehgedT7Ta9lpXpn9fc0oR/EAgdAsVY9y
         8rv94HhuDUxdfWoSiURknOU604KVp3hHosJiYkJT3i3ghF3M52lYonPWeYqxQeUMT1nu
         xJklOMmz1RvkliT9B29Skz4up32yCya9nV6e9lsa1uQgHQ6qyDv+zC4X3Lf2Z4J1YWBk
         5SNKBGf0p8dXnRQdXwVVoRy8mELVlPmypYKUuAodUs93/5GhBaKZQH4iSaWY3mXuWWCb
         Yz6+EpUelsil5HONZoqBxNYhnniyDbjw/Ieb4tDi2vxLL27GZB6z0FAK4/pXKBBzkKFy
         UIEg==
X-Forwarded-Encrypted: i=1; AJvYcCX8UA+Qk15E193a72ZGUk731G80X7JSsGiWp23V2p0o7kU67bRblQqwfSodeGDmeUlpP9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ctz+sHOEplja3Z3/+RapO9qzSzr2ZYXs/q024V2UoHxPIs04
	axxyGsAI/l4RxoCtc36vZTsf47zMbmPGFb08E8qMFJWymS1gY90D/gDhozK29187/DR9XdYhiJV
	VtUH+XL7XJ3PaFux7rkwIPQBWFeA=
X-Google-Smtp-Source: AGHT+IHppp5Hh9D7zJMyT9YElEFasX9lweBx8uapRk48qbGNlLfk7GGPkORygW5I8qAyUO9AKJqNSjcjn+v79wFMmGM=
X-Received: by 2002:adf:ed10:0:b0:362:2111:4816 with SMTP id
 ffacd0b85a97d-372fd73224amr2198897f8f.55.1724276278562; Wed, 21 Aug 2024
 14:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEZmFA3ab8Uc=PEm0bdojZy=7T_F5_+eyZSHyZR3MBG4Vw@mail.gmail.com>
In-Reply-To: <CAPPBnEZmFA3ab8Uc=PEm0bdojZy=7T_F5_+eyZSHyZR3MBG4Vw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 14:37:47 -0700
Message-ID: <CAADnVQJA0WjoX3SGLccUvczUaKaLqajz2rj7=d2H-xrDXmQFkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/bpf_lru_list: make bpf_common_lru_pop_free
 safe in NMI
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Ardalan Amiri Sani <ardalan@uci.edu>, Hsin-Wei Hung <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:30=E2=80=AFPM Priya Bala Govindasamy <pgovind2@uc=
i.edu> wrote:
>
> bpf_common_lru_pop_free uses raw_spin_lock_irqsave. This function is
> used by htab_lru_map_update_elem() which can be called from an
> NMI. A deadlock can happen if a bpf program holding the lock is
> interrupted by the same program in NMI. Use raw_spin_trylock_irqsave if
> in NMI.
>
> Fixes: 3a08c2fd7634 (bpf: LRU list)
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Nothing changed since last time exact same patch was posted,
so same nack as before.
pw-bot: cr

