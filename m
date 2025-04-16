Return-Path: <bpf+bounces-56052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E7EA90A41
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBFF97AD1C7
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41902236FF;
	Wed, 16 Apr 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRkWJ3MJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19952222DF
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824996; cv=none; b=I6tAOO6+pJEgyZ78j2FXY/q9zwM3TDMJ7onRPU6X2yvurFn9/+yk3OMHPDwatlUCEi4TChAXPaWwOOKmKX6n4TdxDYHgEURktKkWRzK7bci9RYlgC4zaXu6nZ4KLs0qaY9DuoSPot8c+85lSx535LOFWPNurCLnhPCe1Ljo0amY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824996; c=relaxed/simple;
	bh=n8cbLzOV3EPlbIIwO98qWuR5dBGTmSbM8oKxxCOOOQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z1BfXeOHxdVidmTOhhItOrZJ2HLg3U4toWzoV2KP6+EWN0l8Q6f2TiWhxBCith1dCEKCOx2jCT7CxuTA4HCrR02jlLmgilHgl9zqfsZciHlAxZ87OaQ057TglFupGebfPJctgHzaAPNaEtw71ULfGA5DtABq0UFa0qW2m09CcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRkWJ3MJ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4775ce8a4b0so106567961cf.1
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824993; x=1745429793; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8cbLzOV3EPlbIIwO98qWuR5dBGTmSbM8oKxxCOOOQQ=;
        b=ZRkWJ3MJNBSGbg3v6hP4All7JiKV5NmQKdQ/B5AoZa6Vk0n0Eohj4B4qGls8B6lSUA
         ak7IvF/mPZzEaGndz/lVHuBDXUsUYBWlFa48+kGZYVbfGMIVf/ED8xylbbQbug5COXjd
         /2wujuwdXFLIfkUCWikjAoNM8bKstttJw4Wf4cdFwC5yzk8ySCugDQsEM8gKuH8ucdFI
         oi3vde+5naJvX7G/tSweojyV8p34sCeBO/UxngLza+f7I5yAPeEA4x8Un/39lj9ELXza
         bA7ltwmgZX4VVV+o+FTgdAiS4W2nFcD2R4+ZleOfihNqXMQP/SofNkbbV8W66eWrrfJB
         CTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824993; x=1745429793;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8cbLzOV3EPlbIIwO98qWuR5dBGTmSbM8oKxxCOOOQQ=;
        b=UTGV/ik6zLQ3kyVnsbBHIttqBG6L6Kxx9FYSWrP9aWZgGN/dsAOu+ui9e2MijXxSGP
         4zUiV8UwJ7UTGZR8OlwnY+kF0Ftm0K+wdKU1nrm87WWEZnxCwGUIepoLLOQoYXa/9PKs
         YTPCfRKhfrlbFQDzp9cjB/NCxzvquLu7wxo+UsyecPFRDBr5A81GZMe9JEYg45wGDpJQ
         lsMTip4KIwGgHe2p7Yl5ZMSLqpKl/HVtJNsEn20jTUL7umaWS+/o3dh9EcrjXg1a0eP+
         SUB42OAvuosC5ZNNy0rbh18djgPtl27IynWhxqERcWYrn14KMIXeF0FcZ0m3FBCYQRC7
         2fHA==
X-Gm-Message-State: AOJu0Yx0lAAM+kenUY/EdHt0rIHZRwljbrNPhHQkKl/hIi35lQfAEJsO
	FzgyiJq8znTGgZAGn9E8K/pcIYx/4gMxfomr6Bh3NeXuwwvPe9V1
X-Gm-Gg: ASbGncthSQKXWD03dVDY6N2bVTORjHB060TDsvzf4S8dK7VexAOXwxnPNdoDq/iAVIc
	+UXm0JepeFgwbmopW9DgKMwpBnXlJxkBf4DrVQCr12FjnUbKFbKKD5zBgtLBktrmpCUCUj8gKAI
	D0yjAZhdiYTgc5qaSKIS+SGIDZCjkCdlMO2OcH94uC5xXkIp65nn8M9Pc2DdPkJgJdrYDj8wGm0
	vr/Yex+CqIU/quyQyEcfqQDisXL/y4nUSziLZufrRxB+ZshtUvb7veV+P8dpxRrM2w9j5qcoTRh
	6BddeTwAfWs4rvIjAdXwS1Dv2IRWjxFW5jomxHZJhKU=
X-Google-Smtp-Source: AGHT+IGivaBuasCykHPZ34/sZC/9W1+Mg3Zgufd51i8FsDIaC4TpJWJI6TC1bX0Njq4hDNEJXoPueA==
X-Received: by 2002:a05:622a:1495:b0:476:6a3d:de44 with SMTP id d75a77b69052e-47ad80b5ba9mr41881051cf.18.1744824993567;
        Wed, 16 Apr 2025 10:36:33 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::4:24a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796edc1af2sm110366571cf.69.2025.04.16.10.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:36:33 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 06/13] bpf: Introduce
 bpf_dynptr_from_mem_slice
In-Reply-To: <20250414161443.1146103-7-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Mon, 14 Apr 2025 09:14:36 -0700")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-7-memxor@gmail.com>
Date: Wed, 16 Apr 2025 10:36:27 -0700
Message-ID: <m2r01suhyc.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Add a new bpf_dynptr_from_mem_slice kfunc to create a dynptr from a
> PTR_TO_BTF_ID exposing a variable-length slice of memory, represented by
> the new bpf_mem_slice type. This slice is read-only, for a read-write
> slice we can expose a distinct type in the future.
>
> We rely on the previous commits ensuring source objects underpinning
> dynptr memory are tracked correctly for invalidation to ensure when a
> PTR_TO_BTF_ID holding a memory slice goes away, it's corresponding
> dynptrs get invalidated.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

If I remove KF_TRUSTED_ARGS flag from the function nothing fails.
But that's because with current interface slices will always have a
ref_obj_id, right? And pointers with ref_obj_id are always trusted.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

