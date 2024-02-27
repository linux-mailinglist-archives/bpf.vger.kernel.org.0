Return-Path: <bpf+bounces-22822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E6586A3B6
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 00:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F821C22926
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5B256745;
	Tue, 27 Feb 2024 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik1mfv3j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8855E4F
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076617; cv=none; b=rTi9rIcDiDvGV11I+ihdg+M4Eep0+Iz2TD3Z9q6keLpNiILWtlA+4iE/VgzjIWR2iTSUQBichLYintbOGu0dXcph7OIhdpfHFOEM/U/OIh1mEAptVGRsKBPbU+i8wyAYNVpaFnYTj+t9abk+IrjHomOl6W/G3zdLL91ME4UC/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076617; c=relaxed/simple;
	bh=jNUh0FRGMj/Pqfzu5O9adTkoGKQYu653L1gCDLpaqPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uY2scGxpV7a+2gcuP2RN0HFAkdk+7OELZDdDixJfn2q5sF0gec1asfsNRXkjn/0h/tKfS0ET97VXzLCDimXYL1/YDIqT9GzfqI6bh36GG/v5D4LWQVzyv41wS+vhyej5omRMnQM+DFlhvb5qavKDTjSVJp/pFVGUhdbnkdmaZro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik1mfv3j; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso5958581e87.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 15:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709076614; x=1709681414; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OQEE50POk5CIqNsLm0Dod5a2bDUqf8pMW4cucuHK7iU=;
        b=Ik1mfv3jXKpuQ9aiotyetNXezuMz0+FJPfMZO55We2guZJyZENp5cR9GI5BICLUUHo
         NnYaRFja7NuR3ZNWa+Gxzrud8eOJYbvdF+tcJGGNbB/bkPkJcNg6EpkXlKxuTRnNqHUX
         8NLJYVElqLNczFAX98lrV2oOU5KWPUDl2J10/NQguzFM3XQ8P+L34wDZKmZw6A7ueVEg
         Jo5bzaAKcAK/ohH9sLnUvjk2MZiau6eJCBJYG6BFeQi2x66J7gcAp9CubJrsHZggtjir
         1o/I8lSyJXl+EWR6xnaaEGMx38qKz6T4kqwdNsDyoKE/cuuP+t4KgsDmRaf93ZvKFbc/
         sDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076614; x=1709681414;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQEE50POk5CIqNsLm0Dod5a2bDUqf8pMW4cucuHK7iU=;
        b=mqdoiyCjo7fOR345ZV5/Hp9Nz+gYP7stm/8QkxsWlEKOvGA14vQFYP/zPo3+D29Fyg
         1LY8kl7kpNE8plDyv5V/5ziCsBDTQ1kwxf6A/ngE6u7vV6t4caavvlPYkR+JtDyyZ4Xh
         VosOquIRMNEiev1ktEFiSAoSPAI0scAwINidt9UIysUOmT6Bw9kwqR4ROtMqYl22ef3A
         ha7euBucwIdV8YbUqWBPIB6z4ROGAZbyhXdfsPoBxtEACKjIWlngAw8LpSUvj/fdqo0P
         CJwfgiRK8iWnLF5MDJOqd1iHKuSW/dj+OJuiA6PWXb5IfspoIB9yecj3dAcEZgVSgEdE
         6U3g==
X-Forwarded-Encrypted: i=1; AJvYcCXjAExxWEuU0sMwgiWMIK1ntYydQvZPug2FU9SK+7VrdcqJGdGnWrLzrpUMO7tL7zhVglTIn5cigos0ZuCtLjsGjmz7
X-Gm-Message-State: AOJu0YyMjg7yrOROwz9h+6qfrpT1VSFXr8FwxIis7OUlt0tmC7sGRbxA
	MFpXK8XOwHGN5YKUS/bWg4AFpfZPJHfz6Pcber/VclrsdPT8LsNs
X-Google-Smtp-Source: AGHT+IHbx5Lt1bybZqHBlRCtzMn6BnoK89PuMAWzR4JK/i666beg4FOEdmIg9APdAnp0+CIKqYJuSg==
X-Received: by 2002:a05:6512:2146:b0:512:a9d4:c506 with SMTP id s6-20020a056512214600b00512a9d4c506mr7250522lfr.27.1709076613864;
        Tue, 27 Feb 2024 15:30:13 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906a28400b00a4386852da5sm1232690ejz.83.2024.02.27.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:30:13 -0800 (PST)
Message-ID: <f6b6bf33c1fa379fcaba9ceaeb841a275cdbdc68.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com
Date: Wed, 28 Feb 2024 01:30:12 +0200
In-Reply-To: <7adcc642-4dec-425a-b198-14bbc0416f21@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-8-eddyz87@gmail.com>
	 <ec9d8997-f5a2-44b6-9bc4-2caaf19df8a9@gmail.com>
	 <c9395bfd3cbd27ec5280d2e55abc6a6186fc663a.camel@gmail.com>
	 <7adcc642-4dec-425a-b198-14bbc0416f21@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 15:16 -0800, Kui-Feng Lee wrote:
[...]

> > So, it appears that with shadow types users would have more or less
> > convenient way to disable / enable related BPF programs
> > (the references to programs are available, but reference counting
> >   would have to be implemented by user using some additional data
> >   structure, if needed).
> >=20
> > I don't see a way to reconcile shadow types with this autoload/autocrea=
te toggling
> > =3D> my last two patches would have to be dropped.
>=20
> How about to update autoload according to the value of autocreate of
> maps before loading the programs? For example, update autoload in
> bpf_map__init_kern_struct_ops()?

This can be done, but it would have to be a separate pass:
first scanning all maps and setting up reference counters for programs,
then scanning all programs and disabling those unused.
I can do that in v2, thank you for the suggestion.

Still, this overlaps a bit with shadow types.
Do you have an idea if such auto-toggling would be helpful from libbpf
users point of view?

