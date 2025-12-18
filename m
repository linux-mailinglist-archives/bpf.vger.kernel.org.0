Return-Path: <bpf+bounces-77056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4AACCDD80
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC363016980
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0722D838C;
	Thu, 18 Dec 2025 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAZ0tnxv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1C286419
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766097599; cv=none; b=Ct/8Heysf59xvbemeQwUb3YmchmZfLkc7RBG/DQwWRazJ3v67r2x0W4ZzHVGivUkeFp3P7zLypJR0mPqVMkh8zdRAZZ9vICY/JTvP8kmei/dB/4fgTpQqr3EVDTEZyST9WCvUXs6h9qDh0VMWDZ9srUXHEQR4XnNsMgA4PHAFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766097599; c=relaxed/simple;
	bh=eamKHa6W7ULY0ixSx/sof431csrKXdlpYvmmnDnJOFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJA/+38w1ihivS9NvIn35mHLYAqk+03rLe346KF1cCjP2gCiemcNwbMiMvYvIXUTDaL/dlo5Lvjy1+R0JDnU64WqzJ1oM9Hw9UUZQmC94PG+HaHhbZG5bJrd2RiFGYrCAGL2jAvvCba8FPXQy7B6F0pHl0terxBkS8/TbcOzbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAZ0tnxv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bfe88eeaa65so815603a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766097597; x=1766702397; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eamKHa6W7ULY0ixSx/sof431csrKXdlpYvmmnDnJOFA=;
        b=jAZ0tnxv63j4DOvodBhWdTRwmrfNfUen/w5yFUlkAcD/EBvQzMK3Cm4wYcsRkZ7CBK
         4sz/2yI/lafXrnXEVoBkEsBKZKAE9HxUsBLGO7Qn2QZMZ02LPj48YWIYPoqZvSalkysA
         zuwJ2wPCbqN/tyd4fKR9glkI4s4H4ohAV5BdWZY50B1IIhTbj/xh/03LWPm9HZsLeeGF
         PuBgxvHQqjYuLwPZPHuI8ZNO3OcLQGLM/fzibopqhGZLHjzosQGGJx1r0PCxrh00P58Z
         NqSdkARs/ceSaP82PifVltK24F1o/zBO7P6zJ+hgiJeb1nbQoEkaAhzqlali3TVBWvQx
         0Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766097597; x=1766702397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eamKHa6W7ULY0ixSx/sof431csrKXdlpYvmmnDnJOFA=;
        b=rYoRPBXeBTEtGQMTbnb2+MRHHSvDRrufxtL5cXOjSkCcg0HldHOcF1+JmxSUfMxfZQ
         0wgaFT1Gl5XgqKv18Vc4RnT/T14XFmBBIRCqqhdf70DL3GJwoGM9VOS3zdAXgeetVxW2
         1hAxDGOzuqeidyIEvtJiF+rELRUgD0sb2na3uJ1cwh50JPvDdlTEczwUYxXfI1nzlW5T
         OgSPk7TKhC8LqLY/qtosWza72jVfMyP/JLeEH858+jvcmB9b5VcZ+Pm8W6tMYCDbf5JW
         NZZj/itt0hbqVCnV1H6sPXrLmOz4SIakUN041+QL6cnJWkNGQMsyFkOlFCzKMhT3nHyC
         DCsA==
X-Forwarded-Encrypted: i=1; AJvYcCVoQ8C07uqQR/hC2/BfwAJ3qYFuCRi7tRrUjQR201lJd2X8O0vYd6lmCydE8p1vKLD2Ios=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4lTWXSecItOjycPMhVv4uoLasPKmi2qxPQ2iHzrsCjTfTYTf9
	ydHdS/oYPBWVoLGE4/gryobNlwiKHABE6DVLecGBaN6uK+rxDOU9Hl3B
X-Gm-Gg: AY/fxX4kTNDRjTPkkqPFV1YcdSAgr7NybndnpDOM62tsl1At8gaCNdRHP999wrh65cN
	j3vEX5mAcLOIxXwGJ5Rx0nDFe3mNxEutmintiKgUBCCGlRoX7+gDd42oovJyRWzgjj54wluqo4G
	uVBLTfRWcm4avqSjA57PhzV7fYYyqDoBLzjPbpAXR3UPdnd7qC0crpi/HUmkTRzoLBcU2AedSrX
	/CxjRaYSomHZTowxQCkpUHB2ZQCIuCnaLW0RaWjNZqp3Jn4xMBLwCEeDYhTuGksT94Do8q2cxQ0
	G9qChikH45yJH0gomUh7xy5SflK84sUOdgomgKVfE72HaowBQ0aP+F9dVpP1tpCreBC1UXz2jFa
	WoktrPUBI/Wcc03YloD5GENq4/sYs1sXbml8Gv5B+mopWgVZ/CvVxhEQFEolAuQsqHra2hXmf4t
	u16qbxOhXKHpqVl4XmisPCEH+T1+GN78bHMbAC
X-Google-Smtp-Source: AGHT+IEVSlp9LXlzmaGmg8SZZsLd9mJhWKS6Iylg31EbQc75zWEKIMS5zueMBmRpuYcgZRvP0hKo6w==
X-Received: by 2002:a05:7022:2586:b0:119:e56c:18a7 with SMTP id a92af1059eb24-121722b4e90mr878908c88.15.1766097597216;
        Thu, 18 Dec 2025 14:39:57 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm1480954c88.10.2025.12.18.14.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:39:56 -0800 (PST)
Message-ID: <62a74bb81d7e791cffe4aa52bf3e18bc854f3edc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 8/8] resolve_btfids: Change in-place update
 with raw binary output
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ihor Solodrai
	 <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrea Righi <arighi@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko	 <andrii@kernel.org>, Bill
 Wendling <morbo@google.com>, Changwoo Min	 <changwoo@igalia.com>, Daniel
 Borkmann <daniel@iogearbox.net>, David Vernet	 <void@manifault.com>,
 Donglin Peng <dolinux.peng@gmail.com>, Hao Luo	 <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend	 <john.fastabend@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Justin Stitt	 <justinstitt@google.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers	
 <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, Shuah
 Khan	 <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev	
 <sdf@fomichev.me>, Tejun Heo <tj@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Date: Thu, 18 Dec 2025 14:39:54 -0800
In-Reply-To: <CAEf4BzZA4czi1KEOrW9tn8v18LZN4FAqzrHyB_78VatEZhb+Fw@mail.gmail.com>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
	 <20251218003314.260269-9-ihor.solodrai@linux.dev>
	 <914f4a97-f053-4979-b63a-9b7a7f72369a@linux.dev>
	 <CAEf4BzZA4czi1KEOrW9tn8v18LZN4FAqzrHyB_78VatEZhb+Fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 13:15 -0800, Andrii Nakryiko wrote:

[...]

> It all looks good to me, so don't wait for any more feedback from my
> side. If Eduard doesn't find anything in patch #8, please send new
> revision, thanks!

Lgtm, let's wrap this up.

[...]

