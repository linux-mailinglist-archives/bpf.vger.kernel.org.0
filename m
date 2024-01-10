Return-Path: <bpf+bounces-19324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3208829C89
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 15:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E7B281A44
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7424B5A8;
	Wed, 10 Jan 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mi1xbVek"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024F44B5A7
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed7c0744cso3055447276.2
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704896923; x=1705501723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPwzpR2AcrYAGatwXlQ0YDaFgczFIL3y2D+qE8YbV0w=;
        b=Mi1xbVekrbIqkESDDIcR0yo3+LvKji6PQW+2nTxCoBVfvxRLigY5rUEgjebppT0l+m
         +gl39OiAusnT2addvR/xhEbpf82cflxyDRRGvVmn8EE5EJjq/OC4Bu2Pnd33eDB+SRuv
         DRx9uzmb5lVnUrGhNCHKW9buY3hysEjmJY4QCDb+nF2jKSSX94bgZz7KixLf5ZILB0Rw
         3oWDBtHvFxKVazdRA9YOPP0Fqqpoly9x8qYw4TgkIzig8SQa3iTruBpe94UulD/yS9+T
         IQUN0avibsiQ17ZHVpumCA7/bETU8eiJkleaqdhPOA3PeZYA5JDOqCW+RIeBuTkOoi7N
         enFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704896923; x=1705501723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPwzpR2AcrYAGatwXlQ0YDaFgczFIL3y2D+qE8YbV0w=;
        b=DucMQeTIP6pRqmrQU81m/wCX0tHcBTa5r0ImK1aojPC0iOVyXOjMLAJTtRDT1WxFQ4
         IdaS8ikFZWGwA0a9kcWyb2CYOJa3KC13newKUyIA8VCd+6vgdjXuYbF/auU08Etk5638
         IX57uS8zLsFEWm597vUmVti0S9Tyf+viGEPUWOrm/4mxs1F2MIUXaJ+KIJ02iZplHjNS
         /tM8bWrMWBsl/wZP487D3ywzt2as5XIrtq2rmr2t9OnKc3LIG+ehR85I1l4rroQc/kz5
         QRwsjmgAfDt/FWxYL5Kf+6kUuHF5rYnPYw/xTOJuuWiiwdVh/c5X0MpN5HfdH2a2sN/9
         t6cA==
X-Gm-Message-State: AOJu0YxBveP3qQm1/dFTiKsRUei4T+PyzLj7DH4s8/zTmv5+m+SjOlHu
	3fr5ZlGmyk4Yx8cbygk8D0Zl/4ChHMDtt9XZe6N3mfKg+T5t
X-Google-Smtp-Source: AGHT+IGOY1jw6Oyln37Za+55Yv2izoyd+kANAVjkzS8Je05FLGpelRQHOO8M8YM0AqtJiWBdw31dKZAffDFBfTCQZ3M=
X-Received: by 2002:a25:9288:0:b0:dbd:f4e7:5311 with SMTP id
 y8-20020a259288000000b00dbdf4e75311mr733836ybl.0.1704896922860; Wed, 10 Jan
 2024 06:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125033.4158-1-laoar.shao@gmail.com> <CAHC9VhTs_5-SFq2M+w4SE7gMd3cHXP2P3y71O4H_q7XGUtvVUg@mail.gmail.com>
 <CALOAHbDEoZ_gPNg-ABE0-Qc0uPqwHJBLRpqSjFd7fH6r+oH23A@mail.gmail.com>
 <CAHC9VhQkRPMO2Xpg0gYdpOPZTDrp1xKwU=idt9EQJg7Zi7XjqQ@mail.gmail.com>
 <CALOAHbA-aW5gHXuf4MZVDXqD89Ri=9Ff7wcnV5wnBe=+pjkLrQ@mail.gmail.com> <CALOAHbCqMZE2F9E+KdLtF=hw9_hEkhjAsHaCHaRwKYWU3wyDyA@mail.gmail.com>
In-Reply-To: <CALOAHbCqMZE2F9E+KdLtF=hw9_hEkhjAsHaCHaRwKYWU3wyDyA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jan 2024 09:28:31 -0500
Message-ID: <CAHC9VhREmXPg2TgDcK+moeJv3AvDR1wKiKNEex0AX6cQAzhVjg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] mm, security, bpf: Fine-grained control
 over memory policy adjustments with lsm bpf
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, "luto@amacapital.net" <luto@amacapital.net>, wad@chromium.org, 
	akpm@linux-foundation.org, jmorris@namei.org, serge@hallyn.com, 
	omosnace@redhat.com, casey@schaufler-ca.com, kpsingh@kernel.org, 
	mhocko@suse.com, ying.huang@intel.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:07=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
> Paul,
>
> Do you have any additional comments or further suggestions?

No, I'm still comfortable with my original comments and stand by them.

--=20
paul-moore.com

