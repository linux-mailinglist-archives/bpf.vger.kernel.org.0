Return-Path: <bpf+bounces-52464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46990A430CC
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 00:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289CD17CFC5
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22451F941;
	Mon, 24 Feb 2025 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFkqK57H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C420969D
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439559; cv=none; b=jsstKXOO8RbGCQDWK5gVFRu/gC3PSxNC+R0Mduv4FraCnE7N4S9C2hNQD0GkT9luFRYr4PaNPbSmpuWQRXtWA+JTMpwuoRIwt6MEBrdpLRoXR22Hcl+iNdJzt+Pg7oV3fDJ48AmAKke514vFVE4I8ol479WWqZGKkQWjUE2Bibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439559; c=relaxed/simple;
	bh=q5kCke5/I9J/qbu50eGRdISsinSmjkOwgKjgfQ2/GaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/bnMmSF7HhIEJ3dMiDjh8dskAfqxPUjVTGQQURYviMQMKit8wEM0vMhUEagWs0iAGWIhP6eH0rT7Gdx/+LVv11IfM9IsVc4QFPJUHEGR74T0HYOuNlDbsom1eorEPP5lHP8x/hLVTsJKyqCUmoEbxOBxAGBOni5DOqb00pLNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFkqK57H; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2210d92292eso150005735ad.1
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 15:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740439557; x=1741044357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJEI2CXbSCJtkV9i4mNkMenvqp/L59Y2ATvwXFma1yY=;
        b=YFkqK57H5tFd2a2A4Du7bIBRV9VCBmbHmnwV5eY5l3GgB5PTHk8KNy09nu6y3XG1Tj
         +iw/EEuoji5h7xpxz47JqARMUEM7xfD/VKrVHxo2j9rEVgoDJgEpJwvdpwLuVUqQ4eeY
         Dvp/9YLfPv8v4n5JQ9xtsZxiZCIXJh2obo9BJ2om5E/UQ5WPCzzbXd8bbsTCmAu2yMwn
         YLqhrc/Dclf3MufMHwofngeQefPirwfBaV3+9C0X8SDMkkfG3hc3FPB2fA74k8s1haXC
         +KSxHWMtnvvxX3jWub+2SfTr3qpbpEabuulmLmeZjp6d2BT4Xnx7GSLRfS7ue7UmCkSf
         qRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439557; x=1741044357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJEI2CXbSCJtkV9i4mNkMenvqp/L59Y2ATvwXFma1yY=;
        b=QoZMmrTmohWyv7FHLwXG1JLg/jOmA7L5iv57RV8AFdGVtUUVlCPTfzPQlauoe0UBX7
         dcII0CkO++QudvxJBE49QTQwLuBF//Z6D73Jp6Ugkl+MkNte+PJu7PsTyhlP8A/+Rd6Z
         E9Lrtj+LxDikRZ/WmuLHtt9sb3Y9FVLKSqTKZciyx2a/xjKdFib3EQcOruJLyxRG0Xv0
         6ay/LGrtb9IOc8VPddZCarO/VQ1CaZ/BOjbdZJdTtFHyjU4a3Jt1YWSMTARIPR5YRF1z
         99AUhr9p2CuryWsDdClsZknak8sEV25inCLUvfbif4VMjtQdqHfUr2XJDaEDUvwhlaPZ
         iYfQ==
X-Gm-Message-State: AOJu0YwvR2Y1E/X5nFZo5UeHsyVIiXnJ0d9jCyu2uKAqPRpWAUvxGjZ5
	4MLZMN6D6XqMdJ9U+eyhQi26/xPYrlryEyYQ0t+GvmxXyaUW+kRofqpFcL8qnBeChKOc1FpjM9w
	qHaqQ7+vGEa/LsuhXJZiXrDUugc0=
X-Gm-Gg: ASbGncu/cXiBDs4xHgSvvL9toJaeX17+F9CjqQp5ypnfOxpwj0gELzdHTXCM8XlVjrZ
	NCAuI5Zu+N0sao+XX8vARQQSyvQYs5z1TuWP4MYwMFNM5ps4PNfZb6iqR1/A1/XVS+2X8d9cbRY
	lMsJq8E2fXWQPUsrfUsIQUydE=
X-Google-Smtp-Source: AGHT+IErr2lLrwaWN5cFlvAHmWmf+eOTucAG0NpSwrLy7dBClOhGg/RI9Q7tR9WZ6QIKFIVFz0/wd1tek4gvwuxySKo=
X-Received: by 2002:a17:903:41cd:b0:21b:b3c9:38ff with SMTP id
 d9443c01a7336-2219ffd11dfmr234206435ad.37.1740439557079; Mon, 24 Feb 2025
 15:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220215904.3362709-1-ihor.solodrai@linux.dev>
 <CAEf4Bzb4T3DcySAyyCXWBK-ShyW9iuE-OM9f7EHXmBJg5Qm0eg@mail.gmail.com> <6b35b7490955800b5cc3833508c88914d59d0d85@linux.dev>
In-Reply-To: <6b35b7490955800b5cc3833508c88914d59d0d85@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 15:25:43 -0800
X-Gm-Features: AWEUYZn084yrJIr0WyqN9FyT17G9DYR9SAoQaHLvqiDxrwxIrnpmdbZP6VhL5XQ
Message-ID: <CAEf4BzZkmAQOeFWLn7BTcqLVj812dfhxxrybMxvWXfQG7hBi2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: implement bpf_usdt_arg_size BPF function
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:15=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 2/24/25 2:05 PM, Andrii Nakryiko wrote:
>
> > [...]
> >
> > arg_bitshift is stored as char (which could be signed), so that's why
> > you were getting signed division, just cast to unsigned and keep
> > division:
> >
> > return (64 - (unsigned)arg_spec->arg_bitshift) / 8;
>
> As it turns out, this doesn't work either. Presumably because
> (64 - (u8)x) is still a signed int.

hm... ok, surprising, but fine

>
> This works, however:
>
>     return (unsigned char)(64 - arg_spec->arg_bitshift) / 8;
>


nit: just unsigned (int), BPF doesn't have single-byte division
anyways, so it will be upconverted to 32-bit (or 64-bit for noalu32).
So let's be bold and use 32-bits here ;)

> >
> >> [...]

