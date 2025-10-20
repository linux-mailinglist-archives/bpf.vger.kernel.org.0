Return-Path: <bpf+bounces-71423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF2BF26EC
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F00423192
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A22877F1;
	Mon, 20 Oct 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjfM3gm2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A595328A72F
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977703; cv=none; b=DRI5a7kh6p82BqgtibKr6rtmH3P3YNeJkFommyu5+HftTiXX4jdqSpLZMJMj0wb10lobKYjI1y1J89TlVQFF3olHriBIN4l1iNag9p5Kf840m0KfgwJX7yyjeQPNxo0/OoDGOIi4fxySkQ6M+ryzpWojSumc2EjtIetZFSH79HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977703; c=relaxed/simple;
	bh=BEZaggrBBd4b0AfjBpwDK0R+fV7p40QB8e5rEKn57B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNyyF2LnLKiA98HKEq0GdfQa+4t3O5Z4WWHNxQpUC9j9n7VJYe5EMxf98NG4CgbTgOC3NKVp/VgPBZUvQDZYrbtJtoSbg32s8sMHST/3mMLxyMgOcfmRyRsXk8+Wls9uCatkIzv7VbSSWorl954G03UOuqpfWDPm0AXlQunTAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjfM3gm2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47157119d8bso5448655e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760977696; x=1761582496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEZaggrBBd4b0AfjBpwDK0R+fV7p40QB8e5rEKn57B8=;
        b=RjfM3gm28U5ghZSqu2mnef+2Jt4MrrtHHtl1+Suw86NPNckFD1eHRdxFiZ4yJRaqgM
         IK/81AFPbKx6RKPlfugMIH004AL2JvFPO5h8MW1XOgvOiyvDXN0/fYvZMCi9u7qMvgn9
         hOkNQ61hk1RmT4IJ7LarCDYFBf0M20yMcaiBB8/EqF02ToE6y41pwTgeFXCydMB/y5XX
         jUegSRqohqZry9qvTTpw/DRIL7s0qVEacP9y7hS0LVPXWASp8oM9ftKBSLSE0Ynxn2wb
         oiz4pig+tZ+IeTJxxTWclBIR/ojL70CyI8nx3ibmD7uirBpW2stXejV6cKGplM0mDtwt
         bGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977696; x=1761582496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEZaggrBBd4b0AfjBpwDK0R+fV7p40QB8e5rEKn57B8=;
        b=B/yaKJ6LDD8EDYqiV0hd8ThNWze1huIU0b6AoNdDuX3j7bSFkh+vZePpCDAXiG3Ugy
         SaNYy66mLmDe5g+QnpaG2uwXzH5eak1HMOtKb6/3QMKWMNUemuPL46v4Psb8scF70muq
         kN6tuxoKYhSYptFtQimKX5gwh9ZKLFElFW9wRk8PEw1nStztMdL79580ofEkrQ2qJoqS
         l+2yzwaLSiMzrQcB1jCUbNr8Mli+0iYQDwJJ5f7b5I5fYUvcAxbdRG5qFICF63oxoC9F
         iWl0vbdwQEDCEi+4PNXReGjYQ46po9EeQZMJ6FVxgJHHZb5ext+hDWJ/FEA3kgAa+nOL
         35Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWOxdtIXBK57mXd4bvMHJj/WQj3KYOBPiv1/ZKbbjwtj5aegKmezToDgnKTQsLpDa3r3ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHMU1Cpjb2gBOTgimCcAKji50rCay7IYXa4t7hJHQeJzNlOpA
	iEaynKbcaHBu1UUyBGmIzb7z7G94T0E/M3Z6ISsOJVLFdiyXUDb3FFbO99tgFu4c3sREQYeGnEo
	US8Cb31QmDhnOPD1WoAiSmRo7OVyqDb8=
X-Gm-Gg: ASbGncsi9ar8P5xocdKQqoyIF8tzmHEpTwttEXo0sV3zJkTLcHlBpBNb91xC8WAe9qb
	l3IS8jzB8lcW39J4N1imV87eaquYA8LfNXc4S0RV/WStClaAF9Eq42I5lu3J+rFEBFEwFv3o6dx
	SzgdXCfKZrpLX+AMnAyyL3aJ61ekUtKjaVHzEqXa286tSmYYam805+syGoYkFSyN90RQqSwa+W0
	oWY+gvR4CB7QpHUdPLvDgtaDvSajDB932yQgIr3KVDUM894wdRQuNENrHv70/nWRm0xkcfzeQZs
X-Google-Smtp-Source: AGHT+IGgsb23uLOYmPtswWrzHBvsGatayTaNyrZEWVwipxccOWsj2/tNIa+9q5qhrVZNBeJYMzzwLQsvnR4FFMLm6S8=
X-Received: by 2002:a05:600c:19d4:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47117907234mr107718165e9.19.1760977696264; Mon, 20 Oct 2025
 09:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4Bza6ynjUHanEEqQZ_mke3oBCzSitxBt9Jb5tx8rxt8q4vg@mail.gmail.com>
 <20251020085918.1604034-1-higuoxing@gmail.com>
In-Reply-To: <20251020085918.1604034-1-higuoxing@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Oct 2025 09:28:03 -0700
X-Gm-Features: AS18NWAYQpOtsQ2xgj0ICvDQj1f9fYVEjTCZgyvRi5tfiwjitQ9rlcRw3bERhgg
Message-ID: <CAADnVQLDQpNEa0bT6nyX3UfGTE94YxrM4gPD+PirmqHwXRB15Q@mail.gmail.com>
Subject: Re: strace log before the fix, with fsync fix and with fclose fix.
To: Xing Guo <higuoxing@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>, sveiss@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 1:59=E2=80=AFAM Xing Guo <higuoxing@gmail.com> wrot=
e:
>
> Test with fsync:

I doubt people will be reading this giant log.
Please bisect it instead.
Since it's not reproducible when /tmp is backed by tmpfs
it's probably some change in vfs or in the file system that
your laptop is using for /tmp.
It changes a user visible behavior of the file system and
needs to be investigated, since it may affect more code than
just this selftest.

