Return-Path: <bpf+bounces-62431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB7AF9ACD
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD7C1C87901
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D321D5AE;
	Fri,  4 Jul 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxF+jDC+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8850019F48D
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751654156; cv=none; b=MoThHpAzbvhc87uI19LNRDrS2vAPMhvbr2Qi7dMHhql3+0P0YIrGdKOGBDwEKnG67YZiF2365TWUg7XUs3szQbhHNnz2xU5JRFp+i5Kn2oQGA4mVngM6KJu1aL0wGsLKCa3Mk//ch3ESRQX0DS4rO1RUEJLx7ZzLbQQIa1Dq0KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751654156; c=relaxed/simple;
	bh=FeutbQAMmLOWCLHLvMaKhbzyWDMVLZudTVPqEOrl09c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEQwg9ANx4ybAgOPbU2qqaSYb08xlJgj8ZLqwWeCCEdbd2fbVlwyR+1eFTC8GXwUYe0dveo2UX3SFsKBWGJEyJABX0cgRGTQ0Po9zjy2Z2Gi1TGciXFD6A8c3IJI7iCo/Y488Zv/v8znbmpSI7b7SUJ5hc09giYvqkt1tf8zaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxF+jDC+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3220c39cffso1128068a12.0
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751654155; x=1752258955; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lETQimKK3MAGmONF0nKx1s9HizHsI+xZfT7JuYjyzgQ=;
        b=MxF+jDC+DKuQQSn3HRUtJlWOcssVkQgaGvtee1rCVj//mHhheJwGLGJAnWSoD0Q5bA
         8e4B6GhbF0kdy2Rbw4k2eWW78pAfgG+mKXUz0evVllu+wx6/W/RwYssrUOYlngrOCa/n
         Pa6WZerQRaBjpTxDD6/Cm36UupmX3B3TydPiB3q0tTOFbFEI5tnTUfda/9uYefHvzVrP
         MBfv5D9SaVTXs3s1GJvxw68Sk+sJmwJUrEjDBXkXg6iLQ8dRQ/xUzfuOq0dzG4l5LkgE
         vr1xbi63Aw/v8+mO7jdcukuPLxqxNn8gVjEHnFLBD3fFNc7mBM4t95OEPn7u/ioolrq9
         dgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751654155; x=1752258955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lETQimKK3MAGmONF0nKx1s9HizHsI+xZfT7JuYjyzgQ=;
        b=pWjWjOsQRc6eeY3xcKzzjLrR3V1LUajmK8wMDCuT93lnFDqqOMvBlwFisuFnBWsr0l
         UKjP5tycm0BLRcs9BtZtISG0FK8KTRVLJPsk/15UWOJfsHpaZ+MamJiqYXDKxBBM3wPX
         L7QO/tnkV58gfe80O2EFLHUU6jnu3liJN+FMKDRLkKSYaiqA1J0kQiZkiOy+h/zmwiCE
         H67wse2ruheQJhsIL9Pbt860D58x+ikcy7nF+5glKZFYe/w0mPzhwBI1O8ZK7k/LeGBw
         RH6PBKlXLmIaFuJMPPPTyVrJWraukLMpHmHPG+O+MVxz8VJz1204bD17HipdeTopH+7P
         IFFA==
X-Gm-Message-State: AOJu0YzSfOCuH9ti4AuG3r+nGNEL5ViV34H0Zm90uZ1Kb4IQ/DIc06ZZ
	3tZhErHVc7PdYp/DjtF9IOt8EXKyV/1gE/y6PthPwEpJotuOiOCbSpgU
X-Gm-Gg: ASbGncv/k4NAK5lzMPO4zPcxQs16bFX41OSALvkRFjW5mTJYJhozwvtX+OmYywFXN4k
	fg3VFEm130+twdamw0RF3bxoSfwDvV6ETCY2mokof/ujzkJFQbc3AZd+gB7/2F0Zb0V8CU4z7K6
	irdKSTjxeFWLgnrmTF8m1IJlPrgKyMaRNhJLzrKyzmzrsRCuA+0bHBXlhbMTX2dQdfza3PCEPHw
	Eo3/q/b1GJSloJ0neuAeVyVyi52r+WCzZ9MVAVoG9MX1iZq475vL2h974wplBbmtkQ6qtNtRQQB
	+JVc85/jNJaaB3bwAJhEtlXu6MU0TvArgsS2tTIU0UdO+bn+hwnWVZk0Ng==
X-Google-Smtp-Source: AGHT+IFYHS0NmrkrHgr5FOPHnjXDd4Vy7U84x9hnUZ7cNwJUp50jpx27rqVxdU/Cm3ur1yljKG2Ajg==
X-Received: by 2002:a05:6a20:3d19:b0:215:dbb0:2a85 with SMTP id adf61e73a8af0-22606c58373mr4131937637.0.1751654154891;
        Fri, 04 Jul 2025 11:35:54 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee60c55csm2632684a12.43.2025.07.04.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 11:35:54 -0700 (PDT)
Message-ID: <07995f23188af2e2de8568ad61fa74c9e95ed2f2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 8/8] selftests/bpf: tests for
 __arg_untrusted void * global func params
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Fri, 04 Jul 2025 11:35:52 -0700
In-Reply-To: <CAP01T74bqqPCV8xYQCoVHGTWa=3m4H-xGNiQsiGbSjQyGEJ+Wg@mail.gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
	 <20250702224209.3300396-9-eddyz87@gmail.com>
	 <CAP01T74bqqPCV8xYQCoVHGTWa=3m4H-xGNiQsiGbSjQyGEJ+Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 20:12 +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu, 3 Jul 2025 at 00:44, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > Check usage of __arg_untrusted parameters of primitive type:
> > - passing of {trusted, untrusted, map value, scalar value, values with
> >   variable offset} to untrusted `void *` or `char *` is ok;
> > - varifier represents such parameters as rdonly_untrusted_mem(sz=3D0).
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
>=20
> LGTM, but can we also exercise BTF_KIND_ENUM{,64}? Since you
> explicitly handle both of them. I guess char * covers BTF_KIND_INT, so
> we don't need more cases (but up to you).

Sure, will add.

[...]

