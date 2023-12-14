Return-Path: <bpf+bounces-17748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D67028123BF
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78ECD1F21A07
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1009389;
	Thu, 14 Dec 2023 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMp32I6u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD8A93
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 16:14:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso51674565e9.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702512869; x=1703117669; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W0OcKAwifRqNmYgP1XgOh1G6q0pCOL0lDQbJED3LjLk=;
        b=TMp32I6uTjvwaWUXHIPhjlRcaqE/5GfnJVW3AtDsa+GOJG3+OBk7LQPhi/PI1v8p14
         qoXrrnxcVo5UsEhusGhzV8YiAEcyyTE9dXi+8iqI32uZIzLrE4Et8GrCpFwiWcn+z8os
         ZTFZfP41+a0ReIc2SjQ+gdNWsyvLp4wqor9C7tJt+ufkZSPU3GK4+8j7s3/RutqT5/PX
         NMB7lCfWE9+oeMylrpJfgySV16RS6545+DM3xIbVootT9Z6+pHjvne3pOhv9Nwe0zKsP
         2pW6/HDi1f6UY0562N/W2/15YLf7sgZuthGMu8WUs0XyYmzabLkuKyzHbnTBYJ3Nak0y
         pNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702512869; x=1703117669;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0OcKAwifRqNmYgP1XgOh1G6q0pCOL0lDQbJED3LjLk=;
        b=Az0fRVmyV5/qxFY8aaPNmv/CEPQFUVYa0iuj64tjLfTMfy4t/gPqVtkA6ndu8DCPzr
         yFqaFj6bfvb0jIg/BocP3Dp4dgiwmTJUu+mKgC+EuOHwsIMLdr0cYNQLVK+tt3eJa5hn
         ZPAg0gArldZb3EPM7IeiH9SKe5Bw2jTan1QOw1EXj3cqgoruBHspK7v/rTyC3Ow1lo1R
         7PKgYisBKbbp9oOCn0Hs0FIPdVm/QQrTW19BJGDQKRlQZbso3PZNuXDSqt8ZSnfqesHt
         WFaVTx4Q46HPi0fA58m1rpUiqlDre5tQZMzrfva2O3i4twP6yRSVLRK7WUnn7JyeqBT4
         K/GA==
X-Gm-Message-State: AOJu0YwFmUYO2IU5tDOp1zTp7ipRxCm2BamVRgbnrYsFhFwOZXQ2OIUy
	WT2ezArBxU/ALunfMOD8UXb4F62JyJBZ7g==
X-Google-Smtp-Source: AGHT+IH00w/aphkxo1L/qfncHcYslksCIpRne2y24X+AeLrdAft6UzrJfl5A4e8ve4WKlU35I2IM+A==
X-Received: by 2002:a05:600c:2111:b0:40c:3689:5cea with SMTP id u17-20020a05600c211100b0040c36895ceamr2990708wml.197.1702512868883;
        Wed, 13 Dec 2023 16:14:28 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id iv20-20020a05600c549400b0040c4afa027csm11266674wmb.13.2023.12.13.16.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 16:14:28 -0800 (PST)
Message-ID: <e04b9037317987f7f64eac7c6c2f469c50377284.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add freplace of
 BTF-unreliable main prog test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Thu, 14 Dec 2023 02:14:27 +0200
In-Reply-To: <CAEf4BzZz2cMf787nu9Ldz2YwuZRSF9w9fCmJT=E=+=t99BiZMA@mail.gmail.com>
References: <20231212232535.1875938-1-andrii@kernel.org>
	 <20231212232535.1875938-11-andrii@kernel.org>
	 <f94dd0e3404253936b7489ea9aee3a530749c633.camel@gmail.com>
	 <CAEf4BzaeEhfFB=ZSQO=i8hT6OP1bkT4b2pzHoViFA4Q_Vju1tA@mail.gmail.com>
	 <795bfa3fef7bb0252d5e1d7fd721880ddfae0ecc.camel@gmail.com>
	 <CAEf4BzZz2cMf787nu9Ldz2YwuZRSF9w9fCmJT=E=+=t99BiZMA@mail.gmail.com>
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

On Wed, 2023-12-13 at 14:48 -0800, Andrii Nakryiko wrote:
> On Wed, Dec 13, 2023 at 12:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Wed, 2023-12-13 at 11:25 -0800, Andrii Nakryiko wrote:
> > [...]
> > > Yes, if we add a bunch of extra log grabbing and matching logic to
> > > fexit_bpf2bpf test. Which, honestly, I just didn't want to touch more
> > > than I absolutely needed to. So I'll use your permission to ignore
> > > this.
> >=20
> > Still think it's useful and diff is not that big:
> > https://gist.github.com/eddyz87/5f518b96eb4188dd1afd436e811bbef9
>=20
> Ok, Eduard, ok, I'll add it in this patch in the next revision. It can
> be done a bit simpler than in your example, though.

Thank you. Your implementation is indeed cleaner.

