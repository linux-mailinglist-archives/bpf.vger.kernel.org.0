Return-Path: <bpf+bounces-41225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E539944BB
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4361F22CD8
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167BB1C2306;
	Tue,  8 Oct 2024 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvlXtTZX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC218C902;
	Tue,  8 Oct 2024 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380941; cv=none; b=o3WnkLFovwB13pfugw+qzFgaaTVQJzB+d21rUNus/RHVDB08E0kzVS0JFFGAinmBFYRqjH+qOF3yGbu1dPM+WLXThi80EoKZecxnyVf4DfMspGNOOe7ogc83Sg0Eh1LDV4Ufoqz+e3IStH3PQj777A5TnTbKIv0u/NKMgiW4MVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380941; c=relaxed/simple;
	bh=tU35sMwfHW0oz9nDOBv8N9HcArN+NHKpPCL4pcNVrlI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BknKzM2zITTsfQwxinuavGQSRJ5nx9O4tIlf1T1sXQ45US/qTO9FdG9mqMI4L+gbJJRLrHwliIbFO55WtiEw2zDM8p/Fxgc+nByo5sfKhxK/WOTSIMDocqGz3gf1AQLU+g4oHxn/6jJnEVM0xpbiRhzkR/UmYVF6WNXhAzO88GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvlXtTZX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b6458ee37so63074835ad.1;
        Tue, 08 Oct 2024 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728380940; x=1728985740; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tU35sMwfHW0oz9nDOBv8N9HcArN+NHKpPCL4pcNVrlI=;
        b=cvlXtTZXP0A86QDuHwRHb24eIju51PhlKCzhok0q4xgw7Lb8NJBc6/AJwVLsLQ7lP5
         eR5xTvDvL/WFOh2S+JAA1nymmzjfttBEP5i5bP999KVUi9FsSjFFFXIqwFRR/Yby+6w7
         n+NJrZLQxaPLeM5aFzLCLRjr9lFGtTAm+4SxFDMBmz2KzaDoEzZ/3SyDuCMdnEYH0GlK
         sYD6NCcMQq7Vz+dNOpTQ2KiTO7IYavpKMgEgPrtvi4ZBLDz4eK6NuV/KTIrOYQ/QVXm4
         O0AhWcsnnCQ9g17y9JubS8DDLBNnayo5/HxN9Ka3DD133RNVSLIy8aiDmxebMpL3xmdz
         g2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380940; x=1728985740;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tU35sMwfHW0oz9nDOBv8N9HcArN+NHKpPCL4pcNVrlI=;
        b=fc8R3cusZDXnQAg7dg1AypAfeqUILA4oQkyk0KKvWtfmmHhUj8oqEsAt1mGW97BB+0
         6coutbH5QXTss+6lmG2nwJorXdLXy76a+qlmF3kny+bcr67zWaamAM8OF7MSOlAFxR0d
         6Dv/qnt9hKZXh4pX3rcNmMP9RxAn76g1QjOCAvh3W6nmfylyEUL/hLeLKTxkY3cJMMbr
         7Ejzp62PvAK9OwISLMGLMqPxwxDa7+VtMHTaKuVLqAWBTOxGE6RZ2ucr9yVRKdMb43Dr
         Ubgj32sZvgAuiOHjmOup1OI+PW3y7qfPJ3EJKTkQBz5ePR5jZaPO5AQy51FLQ6pLgV+8
         LmYA==
X-Forwarded-Encrypted: i=1; AJvYcCVkdjRt9t3dmI/eC/ZSm9QMvOlxq7OH/DodgEpHQX772zRNPLHrb/T89nG5tGa/cLHetuE=@vger.kernel.org, AJvYcCXJFaEDbgO+sbHyjii6bQ40GdM0MmwQthfXhfxIdgVI8/sU71ZB9ECqWIdS4zs4KW+d/QKUdHm5kWnA2VTC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1duLw4GGlW+CJUTQAHq8LHn61+DAv2JoAhzVeVnWjLDRT6ID5
	oPq80VrSKFZtMiA1tFMWYwf6Yl8koWwG8mW1DtqVsKCdAhPVgR2q
X-Google-Smtp-Source: AGHT+IEWBwSFLD3n043xyObtsNFK8VZmQC6iUelhpLwKOQm2mvSoi4yvEWEegT7DhafYQcwNu3WcmA==
X-Received: by 2002:a17:90b:3890:b0:2e1:e280:3d59 with SMTP id 98e67ed59e1d1-2e1e639f23amr17053008a91.33.1728380939594;
        Tue, 08 Oct 2024 02:48:59 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f6380sm7098592a91.40.2024.10.08.02.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:48:59 -0700 (PDT)
Message-ID: <b7c4b77e22bd8005ad5758706ddefe878f949d94.camel@gmail.com>
Subject: Re: [PATCH] libbpf: Fix integer overflow issue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: I Hsin Cheng <richard120310@gmail.com>, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 08 Oct 2024 02:48:54 -0700
In-Reply-To: <CAEf4BzbpxXqNLa02r0=xw-bHzDoO5BELHqX+Ux35Hh7XRNY92w@mail.gmail.com>
References: <20241007164648.20926-1-richard120310@gmail.com>
	 <3be8b6307e7576e5a654f42414a1f0f45a754901.camel@gmail.com>
	 <CAEf4BzbpxXqNLa02r0=xw-bHzDoO5BELHqX+Ux35Hh7XRNY92w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-07 at 20:42 -0700, Andrii Nakryiko wrote:

[...]

> Not sure what Eduard is suggesting here, tbh. But I think if this
> actually can happen that we have a non-loaded BPF program in one of
> those struct_ops slots, then let's add a test demonstrating that.

Given the call chain listed in a previous email I think that such
situation is not possible (modulo obj->gen_loader, which I know
nothing about).

Thus I suggest to add a pr_warn() and return -EINVAL or something like
that here.

> Worst case of what can happen right now is the kernel rejecting
> struct_ops loading due to -22 as a program FD.
>=20
> pw-bot: cr

[...]


