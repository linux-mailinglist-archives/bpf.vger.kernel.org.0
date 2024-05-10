Return-Path: <bpf+bounces-29556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2378C2CC0
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 00:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF40B1F2135E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469417082F;
	Fri, 10 May 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjOZNA0C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF9134BD
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715381215; cv=none; b=lHrshEOwNh7mMxr1hmzfpAop814u+bmZn6T8dRVEjMZRwbmooniLUmQacbE3CFSvSejKGaSUemZtM6Gybp/lD2zF9yM3GkfZJ1mkv7QRtst9P6WYKXzuPVD/uqB1LZOYRt28+7ieF28BNf840tRcbSVhMh8MWluA9wQ0t78uCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715381215; c=relaxed/simple;
	bh=+z1i8cobcR+rITNp/ZTw810btpcFAOaUXffSZNVVQXc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9XnBK8BrCXnzv25RWRjjNTP+Bs6/pJu3ehkbOaWC1uVFDJ3Y5scS2qQVzt6gCVNBtR8WHwhgb7tvML85YSMI2FNr8qtocBx/tzepXdJkp95OD/iMkxTnn5eWb9bqw1P6gVyv5xr2SQwegaxArD4dMWELnH10tBVGuJX2f06j7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjOZNA0C; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1edc696df2bso21589365ad.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715381214; x=1715986014; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+z1i8cobcR+rITNp/ZTw810btpcFAOaUXffSZNVVQXc=;
        b=EjOZNA0Cx8KknT0YO+5hEDgRbARhMhAcLb4DlsIH6VBtAVHv/Jpu+inA4r7L3ZS+MW
         P8uA0gIUQSIsHLTluCdtXYnas1UhJTwe8DsIXZdutpW/4iluubNezVyaCOnu4qTZElpS
         wnIiyzuEMjaJ/r7qFNxqAGlo94re5Eey1mWP8qk/983q8gM6rvgluifUucSFH8TWiDDP
         3+G22LSEo2/f43U1DOLxD0cdcHYW/V5VZPtKfWlRz3FYEZwruef2mgHQus6j7ExdCk7m
         u2m4guyynsmhqLjzQNZfw4oyLzM3+VDulod59fjQOOTr5urGwaGwbahbzdWgIW8oQDz3
         Go6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715381214; x=1715986014;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+z1i8cobcR+rITNp/ZTw810btpcFAOaUXffSZNVVQXc=;
        b=vG/+K4etXVm7BA5O7BRnudhGGFDCZOOmDt+qnwY+6ZtWZbXoQKXyz08PfgyBzJEP2g
         jmqL66X+xVlcS+w5Ii7vW8uwqMWelsUArxqMd1Kw2HbsdXS2ueywczSfNsaUd1njuasF
         RHNrTkAr4YruoLyrR8cnC8m6cXQ7BgBbyfrfDlulqy6Si7c0WVneCJ5u+7M/JUUSnG0H
         uUaB1IM9mTzxyIPK+oEVDVY4XEc6Ud0vzm364Z1EEiGFObWD5BaeI4lvacSAwP4ozWD2
         GMvZOVupMzeMurptvelyqCwKNQ6VsQjAxNpkJWwYRUwHOaYjkBzijmedKFf54PLBgpsd
         9L6g==
X-Forwarded-Encrypted: i=1; AJvYcCXIqZdgCwtMKt6sFev8P6ug8UC3fMWWc8aomlW3V2zkcZvlm+Sd2w9d3IGbHfNm509GV9bgzMRLx25OY7Fg82i4hZKl
X-Gm-Message-State: AOJu0YygCjoO8SJcq3oVhqX2DAEXdF8nw2QbD6yzmaDRyahfrLUJehv6
	72h9wvGvLHsUKejz8lY08Z4UlBHnCWlEKI/XJfFA5IuiDUnhaqsE
X-Google-Smtp-Source: AGHT+IEBXXLKLswt0RHUY4n48o9aJWugPJ28+q5oZOtu2U1mt72GnsQL+8qa7sRplSqE5+zVit6Oag==
X-Received: by 2002:a17:902:eb86:b0:1eb:4a40:c486 with SMTP id d9443c01a7336-1ef43d17f42mr53093225ad.14.1715381213754;
        Fri, 10 May 2024 15:46:53 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c035d8esm37347525ad.199.2024.05.10.15.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:46:53 -0700 (PDT)
Message-ID: <b11929f6fc0306ff39a592dc52c2fd0f96f82a4f.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/11] selftests/bpf: extend distilled BTF
 tests to cover BTF relocation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Fri, 10 May 2024 15:46:51 -0700
In-Reply-To: <20240510103052.850012-9-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
	 <20240510103052.850012-9-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:
> Ensure relocated BTF looks as expected; in this case identical to
> original split BTF, with a few duplicate anonymous types added to
> split BTF by the relocation process.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

