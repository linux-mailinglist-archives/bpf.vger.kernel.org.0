Return-Path: <bpf+bounces-15760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA24C7F62DA
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 16:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC09E1C20EA9
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8D3D994;
	Thu, 23 Nov 2023 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b82miik3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DED8D5A
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 07:27:05 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so1300661e87.3
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 07:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700753223; x=1701358023; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qe8GeLqYwJZ0Sgp97DHACte562cvCk1GFVE+UEwyYoQ=;
        b=b82miik3i6+OdjMJcth1Am4hh0EZIgpkHTUsX06FntGAYno+a4VNbxlMKcgrQEeekk
         k7iQMID/TQ7GuuVwVgSrC+04PQjv7x7Nfa2h7wvHLARtADiFKpEEDTFf5O3JLhcolKpx
         grF4dq16bWWurNglbqyy4fEVYydtApy6KQjyug8UHEip/63ViUUJ/Oo+hcO9zC3mr7/7
         ImmAQT3P4zF+kfU0X+YcU3kvHOplyPHIwdPOdKSRZDC1H4mXqC5CSSi+HU9o3VDDOYaS
         26yQwjOwZeaVqTODHjFkQitksQqzL4XzE4aH5V+HPAzn1cr+8jGUzdL+LmQFxBVlXuf7
         Wo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700753223; x=1701358023;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe8GeLqYwJZ0Sgp97DHACte562cvCk1GFVE+UEwyYoQ=;
        b=vFPGSGyproZlknfCMgQQktLUHl4eaK/W9ndeqr3xrq06TQH4hivk0zV8uRYRAwz0jV
         ESm1VSvAWC7KCOOiVsxexVmxZ0MoC253pt0q4VoLUMN98l9ozHjDU5ATwYaCCyJ+qmWb
         3qx6dSDG9z3pRYvTrgl7I2mWpdotXUdhDHbQBDTGW2c45VhMep4dSdw4KTCa5XDs2JDL
         TZIOsV/OOH8SkstGcC/mTZfHg9luZVQftB+1ANBSJzhHK73GSlTh9JhXNEkR15yOz12f
         mx3/Qd94poxac69RcZOMbdQWVmWaiixMvT2ciEvbFXy6vrIa7dnzpY0mwYKhgxVeF5id
         IShw==
X-Gm-Message-State: AOJu0Ywj/Ixkm7szjfqy1ivcXjswdlzfhC/aJjc+k0C85Xtmzz3Ca2Gz
	O0lpOGYdycSsB852o2+NxGOZgyKwfXxPYw==
X-Google-Smtp-Source: AGHT+IHQ2p2cow4c/ex+pc5KhEwIAqM1SYBXbVv2YGxEKKp7UA5s33oF/uuBY9qLBGLOCz+8qwB6FQ==
X-Received: by 2002:a05:651c:205:b0:2c6:eea4:3cfb with SMTP id y5-20020a05651c020500b002c6eea43cfbmr3997774ljn.50.1700753223093;
        Thu, 23 Nov 2023 07:27:03 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b25-20020a2ebc19000000b002c6eb321d87sm227934ljf.118.2023.11.23.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 07:27:02 -0800 (PST)
Message-ID: <80b1929ff7acb9a5f50a3d12ab4cba59a0a786bc.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add lazy global subprog
 validation tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 23 Nov 2023 17:27:01 +0200
In-Reply-To: <20231122213112.3596548-4-andrii@kernel.org>
References: <20231122213112.3596548-1-andrii@kernel.org>
	 <20231122213112.3596548-4-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-22 at 13:31 -0800, Andrii Nakryiko wrote:
> Add a few test that validate BPF verifier's lazy approach to validating
> global subprogs.
>=20
> We check that global subprogs that are called transitively through
> another global subprog is validated.
>=20
> We also check that invalid global subprog is not validated, if it's not
> called from the main program.
>=20
> And we also check that main program is always validated first, before
> any of the subprogs.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>



