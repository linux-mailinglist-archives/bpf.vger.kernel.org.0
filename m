Return-Path: <bpf+bounces-47530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6549FA2F3
	for <lists+bpf@lfdr.de>; Sun, 22 Dec 2024 00:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B951888FE2
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 23:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F51DDA3D;
	Sat, 21 Dec 2024 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaGyV0WC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DD1CF8B;
	Sat, 21 Dec 2024 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734824823; cv=none; b=PdnCYkaVxXg5DIHqVlS8CI2K6cwHutjquY00XwatSY4EtaZwgLlP/VabRL+es8+DUWazmahxA7zDKxfBhKpWXJoN9m702f03x3YIqH8+p9+V8c5bRqa/9PZk+Z7w2jh/HEAaRTIsPzCRkMRAgM7MW2PF2WNRt57CaKf3E209HxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734824823; c=relaxed/simple;
	bh=0ouUObuOCyKTSOBpY6GhrsRN0OZbudti8B9DK5ph4gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9n0HLbNfMCDbSnESPS5C1S/oO8XOURlHBxZcynfrWRA0q8hHoODDS0W+DIOzqu61uBnBApgTUIFmHVH9FRsdAn0q2Db8gamInnwW9pvni7/H67b0Deu/u+VLyYAxepa+E9OQGs9UMwE9/fHHYe+BImfy5xEKpbz1pps3g0KvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaGyV0WC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso21102045e9.0;
        Sat, 21 Dec 2024 15:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734824820; x=1735429620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgEBPO6P/SwRrVDOmP09vsqVWyj+vIvyC6hhF1Fkrc8=;
        b=AaGyV0WC9sep8XMg+/BAytRXsJ516is3I2P6jN8O19EyLOW/KGzYO+WDKgABIo9oUR
         u8pUVMvg5oEGz0gK3HiVnbCIxw/U/+v0luhrgo3ZjgKsv5Q7dCtrT5sssXHkCtvqENdc
         ZR4vWIC05OzxVyTbMiNQqqvmqR6Nz0e/K16ixL5Q7Y6pgWun0FKQsStwHVE69Ihfh+LC
         ni98NqTzsIYh7i1yDjkDOkNAbh7LcSACd+xKMIZ/jPdhx2uzYUm9kkQjuBgEQGwgsDOn
         eH2FEm8XMuY5m8wyMewaF7byuUCnyLPavRIEQUJNIO6+bJGCoDGXJxgN4BIJX+UVnw26
         y2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734824820; x=1735429620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgEBPO6P/SwRrVDOmP09vsqVWyj+vIvyC6hhF1Fkrc8=;
        b=IgWb1F/wE9Oe+s0MShGxD06dMSC6HutG6EUtRzgpMQBbFNSoomg8estoKehE+ntsxY
         M0N2gJPNdgjXoUpNtkzsohy+/b+Mog46yEJtu2Iey46KEhh45irFBMVp5aYLERuecFQR
         QD/UvHha9a3qW9GGVpm5IQ650pilCn+rNtPzxXn+ArJ05TWkBjK0xLCRGWs4QryiMf5n
         5qAdzegiUjTvpiYRLNqReiy3uAv2yq0CFAiYWF1Pacn6HKM5jOFinZo2AmGaqfXAvYtP
         4k3/RxOMitXtk/ZFEBLgzpWdB8SroXjNC4y++oSu845UP07DObEKMD8o+IuBvV3OWaq0
         2RNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQQIfyJp9xP2WAfO46BmgCuJIbeEG84uBLA0VV1g4u7mVy/BzsW+pvbdu7YmLkIeEFMsg=@vger.kernel.org, AJvYcCXm7onI2TOHKLcFjJB/xalQhwvArkTSJ3fOPiZZ3cdnZWrc9G5hDclRLM9QJC0rYOPbViEzI8N1QX8F2d3g@vger.kernel.org
X-Gm-Message-State: AOJu0Yxde8H+ug7uAZHsUFbzPn1WFYFqlIrBSFvv/FDoegU9VYPz4BdB
	SdyI/OdLQaSVMRQ72VvFvyXhTvpuKGX0G1uloBo9HoMgzZoNbGbg8BJwTUTs+RT9kDuNFBKUQEq
	xv3TclMCbLj2E3vZ6N8a64HqEHSI=
X-Gm-Gg: ASbGnctElGAdENg7bJfbhOIFzQcZh9g/5nilHRTcKiUqYHrbT605BAgS4MX751WnJ5x
	m78WlZFsorZUO3MA37I15f0+ngAQxxwKoUuFQSiK9PKqAugl+mLFFh97+ef8T+bmXfbwWQlk=
X-Google-Smtp-Source: AGHT+IE+p5G/Ht6xSevMFWyC8Yg7OD7Us10wpQ7lg1nboyXUsp5gERCrYU3vL6Yceo7+wYvMqsXVLoSDxIX2z/s/pWk=
X-Received: by 2002:a05:600c:4ec9:b0:436:51bb:7a43 with SMTP id
 5b1f17b1804b1-4366854852dmr64562755e9.5.1734824819675; Sat, 21 Dec 2024
 15:46:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221210926.24848-1-pvkumar5749404@gmail.com>
In-Reply-To: <20241221210926.24848-1-pvkumar5749404@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 21 Dec 2024 13:46:48 -1000
Message-ID: <CAADnVQLC0hNpg_M_54netES5Q2ugSSULcSMzFPGcPG2aLCH8=g@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next] BPF-Helpers : Correct spelling mistake
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 11:09=E2=80=AFAM Prabhav Kumar Vaish
<pvkumar5749404@gmail.com> wrote:
>
> Changes :
>         - "unsinged" is spelled correctly to "unsigned"
>
> Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>

Are you trying to land a trivial patch to get on the record?
Please focus your efforts on something better than typo fixes.

pw-bot: cr

