Return-Path: <bpf+bounces-40079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C4A97C351
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 06:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F42D1C2191E
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 04:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6F17999;
	Thu, 19 Sep 2024 04:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6m5n6FN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D21C683
	for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726720337; cv=none; b=Gb7r13PMpmnI5O+khvPH59awytJvAeC47nLlm3ttXMtLK5EUtreuNy27a/psheT2TJp3P/l7YA0os69HOtWDgkxdbK0j1nrLQUhZ/92Dx8RezspJmLQfDxBCevs9C5olstbJFxBRVz9qXqkXPvIhWi83zyEEjl2eRqN9TdIKjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726720337; c=relaxed/simple;
	bh=HJ4zeE2S4YqcMzijwX2CO0dtR7GoZifxT7zLndEU1y0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYxBgRxnc+mb1A3+5FMRytoa1tF5FLtQadxhjCD/EzIMRAAq7N2zxeJGuSCNSQ/Ko+BiDn66+Lko2FNNmWBPK09ZVvyayYRJcp2Yw1Yu61EWLlSVy1seFc0Yitqu/5qF74/D6NBVOAPM8VGsXv5yitaCdPHDCMQL3LmTzIsjlr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6m5n6FN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-205722ba00cso4047055ad.0
        for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 21:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726720336; x=1727325136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HJ4zeE2S4YqcMzijwX2CO0dtR7GoZifxT7zLndEU1y0=;
        b=g6m5n6FNcTEZ9QA2QDMTSFHGOScNuRo/xpbUzmMVF4+HXUY72St+KL6xP5I9y+5xlo
         mh6fQBt7/osgn5aiSzw6cDy6FDMnjy6plKj/bh8/JRUBYD4lEMKvB06g2ry+a+Zsnmeu
         kxpNvnSdjjJaIB0DFSog4vyIKLPBY+JA8xSi89ker+FQ4qNVtF8/PBZ+m8ZPLrXydtdc
         3WfS5ti5Ev0aDcsGJmw57+fa10mHY+f8jga3uJn3ajddSEYBvSgG+h4Yex3AP1JgBL+L
         /W7looqHc3WTvURfwfclhCUVdosKVfY+mlYI4j7DmYqryMqaNz49H9MolkZl/DTy1YDl
         Z/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726720336; x=1727325136;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJ4zeE2S4YqcMzijwX2CO0dtR7GoZifxT7zLndEU1y0=;
        b=g2WT/a0LTgbHNcTkTfs9AIwQooHCpksQMDtcnGrmU5gaohrW08Xw+pGF+3mlJNK5Fz
         2GB8xyOrW2cshvC4NYOiWrtrYQmtQB+EJzW2nOvcldjy0m36R2QM4hL77o4W2jtXb8f/
         6xGl/9qd5VMJKO1nA1jK9OFUp5E4ZQMVYbsw3yURmLWs1NkUIFqm9aOqy8EAHmFkCAyK
         TejLxDxczC3PBT3WKWspsIVR8lWaVjrvK2f8DyveBlomNbgXAA/+T6XP6P0+VQRw2zzn
         +rYsMo6Ryv6ClZmaOcSj/jNsU6Wrv+yOXeefiSaR5xCDV9KS4kByGNZPyax3FJvV9eAO
         2WWg==
X-Forwarded-Encrypted: i=1; AJvYcCXI9tPAgFr2kUnGs5Oi2VMTZNZpTfwfJwxIWMkFn3LLm5NOGnUx+Fg6+rLmUMJz684mJ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhHqBgmgijMzuvDYQgCXd1C+2duhNkStSBlr6ULiXBnKkVf+S
	X92gt62eYQp6H/8/TL/R3yoiDYMm/D/MienDXtKOILgehR/ePBnJ
X-Google-Smtp-Source: AGHT+IEzhEyP8OA+3u09eumynDI0BG3ZqPBhHjAwxNQTCVpmezfA2YTmicg+Re75wwvtwFBCN5BUUA==
X-Received: by 2002:a17:903:22ce:b0:205:753e:b496 with SMTP id d9443c01a7336-2076e36a33cmr360855865ad.3.1726720335682;
        Wed, 18 Sep 2024 21:32:15 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d1837sm72169145ad.173.2024.09.18.21.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 21:32:14 -0700 (PDT)
Message-ID: <beeceb70d2a8b60d08e5d76c99040789615584c6.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: change log level of BTF loading error
 message
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org,
 andrii@kernel.org,  ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Date: Wed, 18 Sep 2024 21:32:09 -0700
In-Reply-To: <CAEf4Bza3JcUQP8KikcizW5-K_JpvZFeXr9aJvOCeO1VD+qySoA@mail.gmail.com>
References: <20240918193319.1165526-1-ihor.solodrai@pm.me>
	 <a63ec24f6a54173d29a7b88ef679b2aa942d606a.camel@gmail.com>
	 <CAEf4Bza3JcUQP8KikcizW5-K_JpvZFeXr9aJvOCeO1VD+qySoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-19 at 06:25 +0200, Andrii Nakryiko wrote:

[...]

> Nowadays the expectation is that the BPF program will have a valid
> .BTF section, so even though .BTF is "optional", I think it's fine to
> emit a warning for that case (any reasonably recent Clang will produce
> valid BTF).
>=20
> Ihor's patch is fixing the situation with an outdated host kernel that
> doesn't understand BTF. libbpf will try to "upload" the program's BTF,
> but if that fails and the BPF object doesn't use any features that
> require having BTF uploaded, then it's just an information message to
> the user, but otherwise can be ignored.
>=20
> tl;dr, I think Ihor's patch is fine and sufficient. bpf-next is
> closed, will apply when it reopens.

Understood, thank you for explaining.


