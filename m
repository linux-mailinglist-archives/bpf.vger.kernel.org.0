Return-Path: <bpf+bounces-63642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6D9B09281
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F234189E16F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844C22FE317;
	Thu, 17 Jul 2025 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUOpay/h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05028B408;
	Thu, 17 Jul 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771604; cv=none; b=nyKhX91j73cUaFKMJQ5dfdwqNrxnKCCaTc4dZt2Oi+Ps3dZNsV98pxmcMhwxfz3BdKWSCB7AVT3DTO1wkmd8SvW8BimWyxFVUrK1VrjyC0Jne6c294Qu2FpVtsTFVDkVvGDHBy77nUF629bwoS7kWQsTDyAE44PqOFknJIIiNm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771604; c=relaxed/simple;
	bh=ewb+FIZz4kwCsl1j25xta8JzmAG2AEj7KxN2meRe0Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2P+96JOsx3lhno2LyHoSF6Z+pnbdkz6z4e2YUwlxmWJMG4kDUB3j1H8JvKOjas0VvJAPnenU7hBWn8i6Tvlf8mAroMjlm+qoTFhSX6VSKAG7SbNk3MmNLsPjMv6g96ygZ/xf8fB2Rcul875xQE2q3QByqk3VAZDFF2Xtd8xjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUOpay/h; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2eb6c422828so1655448fac.1;
        Thu, 17 Jul 2025 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752771602; x=1753376402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ewb+FIZz4kwCsl1j25xta8JzmAG2AEj7KxN2meRe0Kk=;
        b=MUOpay/hLI8tNkyyjRdBC7YU0QuPaWaQ/ZxHwjUXYFsGWOxVJh9s3znPyigmiFkOCI
         NhUgyQIjoOlP2QD7jMUTfnhdFo3QE0GbbqhXHbhPamX0D8NZeNy+bxQF9LS0tBVv4y98
         V+tJ7cE6Nbg7lLUajR2YUe07Z32fqXHmBGNsFjMOH/f34yd3xMrSJnkBoAehrkvjALp8
         Va4wH9PBfGrqWhufUlpydZ4b4GhDppFnOPJowd3onVxwKS1cCoPY0tHDvEZI+XR75WfI
         dhBHmYZxVY8OsPa0BIqV/7bINgknyVLG3yOTggD7m8Ep96zV2YjI46DObOaFL3n1BywI
         XJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752771602; x=1753376402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewb+FIZz4kwCsl1j25xta8JzmAG2AEj7KxN2meRe0Kk=;
        b=jhcGJFFfDAdxXBEvGtja3zgJlL9Ro2xofn04JUTUjV3QomdXhnJnYufGKnBNuV8II1
         xqXh/tXDMVke7Qmwe55pku4pWi4EjHbxLeUlpl++YtWSFry26wtHtrYUl4uewqgLvmUG
         yPidrilavSVBM6+yGwIzQOQbu3SAUbafTo6RGzkO8foRykSNEWAqlqGNu8IcK7drJvPP
         prDlXdAbfRwzaUqc3vFPp4GN4GjOLZe8mtfg9sXqIXAdQDdmTGFBLIwZythr8WGcnOfx
         OiKdJA871vP+XxS1QHJIgbo7W2rIib+7nfPzmsXhzIvjAqVFN6pvZG6GkyKjNV8DZxaA
         1Wiw==
X-Forwarded-Encrypted: i=1; AJvYcCUGOD9o0bb63UF/UzpDwI1kPbdeeS2isNG+MBwQWDiIbYMwmi7JVURX/6LGSmmh5qFJ0iU=@vger.kernel.org, AJvYcCUkB/MVSeQbgxHu0kgoFTUfMqZKkY0r2mD7Kh2myto5QR0kq+/yoYxskttjuMCHJDTGkF+U0c7RiS25+No8@vger.kernel.org
X-Gm-Message-State: AOJu0YymMMFI4otlQmWwwbrGqt/5eQPiYrxLKMa19jkkwSVvePBZdp3l
	u2pMzHX3ioVcKDMrcx3Cp2bvDNhrFLOLhuhJDMCx+2pzPgVViHfCj6P1bGSzKDTCRW8qWUyic9C
	2nFUnjNBExFM/uw7M3DuCBQ6z/md3OCE=
X-Gm-Gg: ASbGncvbBjGZuCKhHrLpF9+JxP/lrPW9VKHU3AyY7sdoBtPGSttLTVJwMe43WWkSIjw
	R4LuBa1NtmJ73a7qf7tzWR6Pl4+SIOfUDgV940IxGuSWptnSMb5My2hCpoXDhtSPHZJlC7tdpd3
	Mc3fna+HWQdN+9BRL3L7Vl3D2BgPhNhKGhMNChvcwaDO21rvYS/7zlg+ePiQWUfYYJyV0jKg/Yv
	653IdwS
X-Google-Smtp-Source: AGHT+IHYBhYyFCO7kIhIJXgTO3z867nKb992R6AyR0gE9NGM9WDzDbHkdUMO0+XjlDg9KIzr1gOchlwer9OVKvMXqJU=
X-Received: by 2002:a05:6871:e281:b0:2d5:2dfd:e11c with SMTP id
 586e51a60fabf-2ffcc181093mr2710454fac.7.1752771601492; Thu, 17 Jul 2025
 10:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717115936.7025-1-suchitkarunakaran@gmail.com> <f6c4944d-c6c2-4a7e-8dd3-791d0c29022b@linux.dev>
In-Reply-To: <f6c4944d-c6c2-4a7e-8dd3-791d0c29022b@linux.dev>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Thu, 17 Jul 2025 22:29:50 +0530
X-Gm-Features: Ac12FXyTF7cN_d1c5mELIt20EHp_Qy3GriUYaqZEKLzGqZAStvwqLcaBbeQocBw
Message-ID: <CAO9wTFjEJOfF7krFuV=DkZFzRU3FpRXtnq93UaX8=_Y=wnwbHw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strcpy() with memcpy() in bpf_object__new()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Jul 2025 at 22:19, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
>
> On 7/17/25 4:59 AM, Suchit Karunakaran wrote:
> > Replace the unsafe strcpy() call with memcpy() when copying the path
> > into the bpf_object structure. Since the memory is pre-allocated to
> > exactly strlen(path) + 1 bytes and the length is already known, memcpy()
> > is safer than strcpy().
>
> I don't understand in this particular context why strcpy()
> is less safer than memcpy(). Both of them will achieve the
> exactly same goal.
>

Sorry, I meant that strcpy() is generally considered unsafe because it
doesn't perform bounds checking. Its use is deprecated and
discouraged, as noted in Documentation/process/deprecated.rst. I made
this change with that in mind, although I'm not entirely certain
whether it's actually unsafe in this specific context.

