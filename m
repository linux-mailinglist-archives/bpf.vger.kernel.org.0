Return-Path: <bpf+bounces-30154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8408CB467
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 21:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A5428270B
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53F50A6C;
	Tue, 21 May 2024 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6+BHUJD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE5208DA
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320810; cv=none; b=qsWOTipb0YURVX3/RtFlo6J5FCRvk1uK/o3mKLyEru5ZesJPCCFQom8bMyb5h7m0eGBWoMc6zd7Qf62I3UtuERo/5i3jxwLXcSn7wnFl0sL2sTrJ5kLAoI9nbDYzp3KaHBi3ruNhnbx1oL2qM6VMzxJEW5hZktZReVsMrAcyf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320810; c=relaxed/simple;
	bh=4t3VO0T5AN1xuOUfNosPknnDnzzxhVAQ6ntclUfI5eQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=loRUEZ2VWuOVrjtqaHrgK8y4K6QVJ6VZe9SaJJHuChssOcROoSsphxhwd2+PLb/t9lsDJ03vkWf5SLNcXs7qeOXJ4dMls1o/wk4WCI+c5A0Dn6Q2Z1329nA8Dfq2W5Nv+Ivnm64liZkf6XbMtBYp0ukOWye5iSmnqehgZC82wUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6+BHUJD; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7e238fa7b10so137787739f.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716320808; x=1716925608; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4t3VO0T5AN1xuOUfNosPknnDnzzxhVAQ6ntclUfI5eQ=;
        b=S6+BHUJDIDuw3xS+DKNr9T2X/Y6FbvZ2SXoeXXxSehCO7U6ICLohi5AnsAn0K/DiTp
         6GuWL6oMP4VqpWTttpRQk7zyUsP4yIRnYXNDEen0mEZMroFl4niMK2bF6Iq/ngOEO2Uv
         qq+YUvBaFsUxfBzDMrQhUwp6CnK/ZzUl3PmoH1NXFkQyaE31jFIda1BKTem4U8+io7JB
         Hpr4o9ph5Di490M0jB89Ye4D+ngrbA/kj5bIFGsqYPSrPBLR/RlUkymf7zPGJbxVs1ZU
         +urrcARgMrbeM3//XEuR5ZYs6FrBP7kSmx99zgZn6MVlsAVGrB87qJhEp9AHlFEPpkv3
         6bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716320808; x=1716925608;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4t3VO0T5AN1xuOUfNosPknnDnzzxhVAQ6ntclUfI5eQ=;
        b=VSQTPRXnOpPG1WDfcZLGFafKmRTOdtL4lfpC+Y3wri+Qlrmgalrh38vH0qC0DXZmEQ
         qG6BFkaThjBl+xbDq8GfL2GE8OjvV4UQBtK56dTff0hUQE7xjhBSsO2H439wih0SQr4/
         eUf35EonfDlcwDwtCWLmu6MGUSEWd4Kq8sp5NkVwyt4wiEwdbk9l8FpQOdmyPgINj2Rg
         lSkyjDP6Dvz7dobuNVxuGq3OW1GduyJzGIu8opyIAltGHWJTWQsVHO6Hke7Xk5Nb4uni
         Uf8qBh3WB4hDuyreZNwjdxkDgdjVARYrl9+/P37qNkDgJlfHnsH4Ms0HOcpMouqx2eXO
         1HJg==
X-Gm-Message-State: AOJu0YxB7gwPIgJZCWCR7DsnFFEGVnLgtJaaQtWW9iQZS/huhrwzyLUl
	Ozzqmoub1q2IKAX0bvmcPVzLelh8mgwdnj4fGTsdW+2unpnc747PJfEiJkcL
X-Google-Smtp-Source: AGHT+IGd+tlNtrm79N926vxmxgTmrNrnGtFUiCJcrsFH8VWOQTjhq+kRtiDq+8gcFFec0sn8Hmmbng==
X-Received: by 2002:a05:6e02:1523:b0:36c:559e:755f with SMTP id e9e14a558f8ab-371f7d753c9mr236035ab.1.1716320808105;
        Tue, 21 May 2024 12:46:48 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b3181fsm21134614b3a.217.2024.05.21.12.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:46:47 -0700 (PDT)
Message-ID: <4c8a90dbdc4677b57b19bc0d8b4109e3b6537aec.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] bpf: make trusted args nullable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>,  Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org
Date: Tue, 21 May 2024 12:46:46 -0700
In-Reply-To: <20240510122823.1530682-1-vadfed@meta.com>
References: <20240510122823.1530682-1-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 05:28 -0700, Vadim Fedorenko wrote:
> Current verifier checks for the arg to be nullable after checking for
> certain pointer types. It prevents programs to pass NULL to kfunc args
> even if they are marked as nullable. This patchset adjusts verifier and
> changes bpf crypto kfuncs to allow null for IV parameter which is
> optional for some ciphers. Benchmark shows ~4% improvements when there
> is no need to initialise 0-sized dynptr.
>=20
> v2:
> - adjust kdoc accordingly
>=20

Hi Vadim, sorry for late response.

I think that this patch-set looks good,
but I'd like to ask you to add a dedicated test to the following file:
tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c.
(crypto tests are for crypto and might be modified in the future
 w/o consideration of verifier pathways they currently test).

Also nullable dynptr sounds kind-of funny.
As far as I understand, performance gains are due to omission of extra
function call. Did you consider inlining for bpf_dynptr_from_mem()?
Same way it is done for bpf_kptr_xchg() in verifier.c:do_misc_fixups().

Thanks,
Eduard

