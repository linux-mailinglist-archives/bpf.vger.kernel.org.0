Return-Path: <bpf+bounces-77632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82695CEC7C1
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3293015EDE
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7F3093CD;
	Wed, 31 Dec 2025 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd8tXJOd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB142AA9
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767208232; cv=none; b=PaqL0kg/j2ddCJ0lr6w+EzuT1I/E8zZqxiWv3WrkkewxkPwVI1zv5x0n81aFGaBo2w56KbwtS6qAJDpzGc5ye1iozq3fwi08uXz/dkMIaKCXBmpGoUcMhVIEp+4cOMtkGUcwLOv/+ySYLA0P0yGdykYfzNlFwTYqbwPuM/M7N8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767208232; c=relaxed/simple;
	bh=mUoghVt3VMeEOKC+hnZ8k+4kB5vO0vL4DgmvlKqTUgg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tAQBFgxjMvklgjhhHLk/lF/UeZycJho6csoUDv4XmPh84q/mc30H4NWBV96hAnNW7Q8dV+1lhpUKlkWNEa2U5xK2V2mkmaqd3F38tXL0L0I1oRnqWmoD/0hWu4JeZBx2Qc8pnZkyy64eHUOx1dvVbxnxzsjgSBDhS3Y4ZE+87A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd8tXJOd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f1bc40b35so192210155ad.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767208231; x=1767813031; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mUoghVt3VMeEOKC+hnZ8k+4kB5vO0vL4DgmvlKqTUgg=;
        b=Xd8tXJOdDD9z61txp0sUF9/ZNg1TtHWS/On0U4t4QYBs2U0XEriaw2tq28TDBiUt8J
         w4taabQ+KDHqkB+wjVhMsDyP3jO2MnSYu+x4sWzQcExoIrNmLUj9LYMU9x4/sTHihatq
         KCWP14Hpp5LmoVojmOveFbkmxuvx7nUWoEYoern48I6ZPtx7ao0BoACo937Edr4kMauc
         GBnRQVog1c72pZv0efReHClwyCk4bTx7lyRUyWnFY1zbxuIzkOX8H6MRzCmpJYXi+xj4
         SnHRw7a3J4GaMSPfdcaXtKTuVAmoQrNhZX15GnJXiFxXhsU0NkMKzau+BexRaM6BithB
         vAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767208231; x=1767813031;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUoghVt3VMeEOKC+hnZ8k+4kB5vO0vL4DgmvlKqTUgg=;
        b=T/dbw4mOKc4FSKBFDPu5QydFbdOibUedNty4lmyEhQ0IKuSAW3z2Myp9TdbCpt4gRc
         EDejy5ZImsj0sgZvwVhQbPhXbjehQGyNVPmLQQA9QffEoWEaifFq2YjzM10huvz4QE0v
         5HjfnqLgytBFDFRdC4KmlZ/E7xeLQHa+X++AW7Amje8MSfdE49oLFnszU42vR5zHbCJm
         ze1PfV5wi+MXObwmpq4/17LEsIR0epQEMiSsOhoFmiNS4NAVXDtEL7QrMBK7ocxo4jGJ
         P0PTn8kXTw0U3w9ojuntA/tNCJWQPZ5xRquT/p+qnzsJymArTIp0hcEjhQ4jL5Stg72j
         kafw==
X-Gm-Message-State: AOJu0YzN3Ousav8PghCbzBb+C2e2ogje61bWv1sZ2hOO+fQ97KfhixRY
	ce6YF7/FjG9f4mVMystYU1+uKS0nFC8S4bEH7NXO+sRGHcc7shsnaYyuBuR61WOe
X-Gm-Gg: AY/fxX7Sw5u/PYuZvJe3Cdfuc/tDJ3CGg/rltWYiMtrh81CPOsBigT5knXlXZfd4QiY
	/h4x6HmuOoS0BPCaaA+LTHqXF3sPdLRS7rCJrplamiOiU3cRyi4zDw1f2msf5+JOOpkYZ4Nhi02
	veehvURwVuZOnUxgM+THzHO9IKvhzBSmUsHQyPBBdJ4MonGQM1f7eJHDjWIWrncPYAdoD5o5K3V
	dHEtQxB5RqPF7OOK5MPW/j7tscZgXQsBbCOiakk7Ap3Np1BYboHT9ZeLFVvE+jCLORZbdOwexpf
	67o5sXOSJus1XEOsw1Tqx75NHMKt0MaA16c1iji0ecoSMiFDYbVcHErzY13GwJ2ylmQuMkHgbF/
	2Sa+wRYD3FL/qcdsdOzgS1bSvI0ny1+zTMmSHXS2f8SFj1+i1W3O+Xp07S2oBKLq0W4VP5tQiH5
	sqoU1voeAB
X-Google-Smtp-Source: AGHT+IGoC08hkxeMtilYkIh9SsDKlr0o1jPYr6ydZY/CHCjzGFIGqYUDK6C2I2CY2DPt6HK6uwbJpQ==
X-Received: by 2002:a17:903:4b48:b0:299:e031:16d with SMTP id d9443c01a7336-2a2f273827bmr362156055ad.33.1767208230852;
        Wed, 31 Dec 2025 11:10:30 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c65d71sm339302575ad.17.2025.12.31.11.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:10:30 -0800 (PST)
Message-ID: <49cd9cf5a600e240e2ebea8098e25026688b4cb8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/9] bpf: Make KF_TRUSTED_ARGS the default
 for all kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 11:10:27 -0800
In-Reply-To: <CANk7y0js_-wvW281NAbr2eaCmvMxBAyCDd0wtdf+7XGKKRxEVw@mail.gmail.com>
References: <20251231171118.1174007-1-puranjay@kernel.org>
	 <20251231171118.1174007-2-puranjay@kernel.org>
	 <c1204513fe4da235d6b6b45eca9d0260a31e89ec.camel@gmail.com>
	 <CANk7y0js_-wvW281NAbr2eaCmvMxBAyCDd0wtdf+7XGKKRxEVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 19:00 +0000, Puranjay Mohan wrote:

[...]

> There is another aspect I want your opinion one:
>=20
> Assume a kfunc returns an error when you pass in a NULL pointer for
> some parameter, it checks for NULL as if it is not valid usage, it
> returns an error. After this change, this kfunc will not return an
> error at runtime, rather will be rejected by the verifier itself. This
> should not be a problem for real programs right?

Yes, makes sense.

> I think we should drop the second patch: "bpf: net: netfilter: Mark
> kfuncs accurately" because these kfuncs have no real use case with
> NULL being passed to them, only a self test tries to call them with
> NULL parameters, I think we should change the self test to detect
> load failure and leave these kfuncs without __nullable
> annotation. What do you think?

Actually, I was going to ack that patch :)
But you are right, each of those kfuncs is a wrapper and functions
they wrap, like __bpf_nf_ct_alloc_entry, require 'opts' not to be null
or return an error.

