Return-Path: <bpf+bounces-65379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D09B2161A
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD5DD7A64AB
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 20:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F2C2D8765;
	Mon, 11 Aug 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk+vF4MD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE5311C0D
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942493; cv=none; b=tlzcnpSE4mEXPvI5ZOIIhUtGjW1VntUx4phEnC44EcB4wVVrfOqwrIi/5+Lt8IKJmXF5f/DXBdj8ei0cieKvymy+RJEVgjhr+fBGG9GP0S1NzhAkbeJRWPSeo4jwqBWuiGkRh7wIXM9+nxAOOx0ncY/2KefvCNdG69rRLkKaWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942493; c=relaxed/simple;
	bh=z/cF4HJyy8v7JF4wTsnIUFBPWgQU9oVsfrOn4boLJrc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhmBP1aeJSGLLI8fPNeDRd9x9hULV1Aw0n5d6ckk+CoWk8TtXFRF5e48sS3obuNx+6Lj1S5mf4q7TK5aUVp+Vt2lhaY+oPS01u3ZiHg9WdmS7GkqWZD2qITkGJzjK+L0PRaSCZHWdCA2wr8mRlWWB3YmwEj9yOkNTlZAK1q4s4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fk+vF4MD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bd2b11f80so4312008b3a.3
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754942492; x=1755547292; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IL/PM0hhCSNhmuSXxc62zb0dFIk2C9toScvZNxOd2Os=;
        b=Fk+vF4MDkj5Uhf80GN9Gr0jGOP0Ob+yPoWmZs+4UCApbX//V0EKtzupKj7p1mwIf7I
         G/+MgdT38M4veUFtltIzNmOOkH/vYuOS+IEUdYfvaDnLnvfGaDed6uvbMM1J3qcmdPCL
         D0ehVWLiGSJN6BSui9eYuSOAQW3/6Cu44fWpFLkw7b5n7TXgNB5ExVP8LfjcfDKhPD9R
         PmmwXr0bUbiPbwCa9uyXTEu3PSdgbOnMFlibC2RRs60ykG2S92kIXAAdmZfGBh2ZGs4G
         MyPMpokUHPZD057tF/mijUN04WWRHWScWnqkDhFhe7f2e4lvrAEF+rRHCycOWnf3QYZ6
         xs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942492; x=1755547292;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IL/PM0hhCSNhmuSXxc62zb0dFIk2C9toScvZNxOd2Os=;
        b=SbWOvs3IiOzWNt+/g7pCcxgvwrTEq2p0mHpdJTo7PAxP9CJqLbPYMIYRHMxUPpzUQt
         VTCYKCfPwaw10730eygWRIEEbwS4uqmGRcum+bGFk19suOz0RAYxuaPAUXP/mC9iIA08
         VrhrD+tyClK41/EU2YMSFdiBls397IzNaQ6s+CdShGC5ib7vXH1al+dPYxhCTpN5Q3tI
         VHkqAo3ymphhqjKGiccqnkiI9W9Xw/tMcDIX4hHgL9+OFZEhYNVR9B2vtrfwQ/tNEPW0
         Hvs4hEu1GqEuUIFJ5J85+UWYj+Ad6zq2o8UzSTM23cZzE/MdI7mT8ySzt4QyeKGtG6I3
         j2vA==
X-Forwarded-Encrypted: i=1; AJvYcCVb18nxvKXFSrDpdVlcaFyu41cTVecvBjTZJtz+t4WfP6Eis0cTwaLDd6lTE4NV5PnzCzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCKDr5wPcLzglvCPJJq1mCxwdOAaC5UXWSqg2mKT8no4Uv/ReZ
	B39vlCDOzlJfl/j9GKghlYmP3jfFZNtmjIdN91gBPDsNj99QzPU7ziyo
X-Gm-Gg: ASbGnctGQX00ojghx39o8dPVS39ND46BwQvcn7pXWJBSrXu7SmO6OTZZjCtekDqr1cK
	SpKjN85Cf9nea7AZT7ejHDmzTeCaWq9+Ot3BxKLHd3PkAp0HbzvERdjThCEuoX5MztS5sIrFDkw
	pySLkroM9ok8ZjfgtUqzGN0bTIj2m1yimOMNRPNt00HslLN4wqZbiZj09S9lNGOQkL6yK3rlJ2m
	+WGvRy91LNlfjMu36UdbZ4qZqqaZU6Z5aKq9zdNNAEJQrnLuKt/WaMZWMcYi3iZy2HotMBXYM3U
	OXyQ9Nkx9lQw3UMmWmzW5vuAQmDL2DQt3vA2nMsRMZw1C63RkyiQJtQ9e8sotNElNEz8pSErDhG
	qpLY/7LEd49qyxzgt/JVjmWl1wFnMlP7/EF7uBEjh02ns
X-Google-Smtp-Source: AGHT+IE9NeymCtyW+5scTvPSZ6I768s70R67abXRFAvlmW3bSNZbLkORCZYSx8PmTKeuxamAnvNsjA==
X-Received: by 2002:a05:6a00:178e:b0:76b:f260:8610 with SMTP id d2e1a72fcca58-76e0de418c1mr1127185b3a.9.1754942491691;
        Mon, 11 Aug 2025 13:01:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:129e:4a5c:ec89:efc? ([2620:10d:c090:500::5:43c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8a838sm27712894b3a.32.2025.08.11.13.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:01:31 -0700 (PDT)
Message-ID: <e379ecb2c4f8a2b0fe45b86fe49ad48c44c5c852.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Tidy verifier bug message
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Mon, 11 Aug 2025 13:01:30 -0700
In-Reply-To: <aJo9THBrzo8jFXsh@mail.gmail.com>
References: <aJo9THBrzo8jFXsh@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-11 at 20:58 +0200, Paul Chaignon wrote:
> Yonghong noticed that error messages for potential verifier bugs often
> have a '(1)' at the end. This is happening because verifier_bug_if(cond,
> env, fmt, args...) prints "(" #cond ")\n" as part of the message and
> verifier_bug() is defined as:
>=20
>   #define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##=
args)
>=20
> Hence, verifier_bug() always ends up displaying '(1)'. This small patch
> fixes it by having verifier_bug_if conditionally call verifier_bug
> instead of the other way around.
>=20
> Fixes: 1cb0f56d9618 ("bpf: WARN_ONCE on verifier bugs")
> Reported-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

I wondered why that '(1)' was printed lately...
Tried this patch for both verifier_bug and verifier_bug_if,
works as expected.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

