Return-Path: <bpf+bounces-13921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8137DECF3
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 07:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073D8B21236
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D12D617;
	Thu,  2 Nov 2023 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbLAiE1l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B11FA4
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCE1C433CC
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698907437;
	bh=JZC8owDBelQHN+vVxyY7bnfOIM1BeEJV3J70IF+MQbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nbLAiE1li+8dfQtIpGABw8eiX3Qgtu+vyYnZbxqjaoe2JWt3jWiraR1T4HmyC9pb6
	 YymR1MocjQYQXpkP+1MDY3QSdamHPGmwtdqRFW67pKMJw4zj2VPIiT+8uzI7GyJdd/
	 wEF5G6s0Tw0z4gmeX09eB32+DP5FBXz7cTY61NhCfRTo1rcGdu22ZMgSKgSEx3Dc6T
	 9o+xrrYbT7QTfys88zyRSkgNRxQbRMLWcatVHZ+gtQekBJKKzNY646UDMWapUfsDrd
	 21cKF1R55a9oSxeRIlBS7BgMJZngWJQnK4ZVnX2dJ9vx8q0OR6dBhDyLU8+LOzbbm9
	 7dzY0VVxB1MHQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-507b96095abso611838e87.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 23:43:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YwTe8J384WRqvpEYsFcPMk3QZ/2f5eu1IqtikLWW2LClOVODyW1
	iHOz4kOeso9HrEFYOI4iQ4mrdio3JALs7V4qc4A=
X-Google-Smtp-Source: AGHT+IEEqLDUYVuGWl0Tr3VtOWf4BuAVkatX4W2eVJlC/CSRNJferNi6GJmnTETA/eu3zR+hPOT/HETtEe5GwcKQXFU=
X-Received: by 2002:a05:6512:3c85:b0:509:4864:1b3a with SMTP id
 h5-20020a0565123c8500b0050948641b3amr1178569lfv.64.1698907435908; Wed, 01 Nov
 2023 23:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023061354.941552-1-song@kernel.org> <20231023061354.941552-5-song@kernel.org>
 <CACYkzJ7mz91WuvC=9CWA-ewh6ywCHseiH5-dY0jOA0Piw3jQ-g@mail.gmail.com>
In-Reply-To: <CACYkzJ7mz91WuvC=9CWA-ewh6ywCHseiH5-dY0jOA0Piw3jQ-g@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 1 Nov 2023 23:43:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5_P7R5mcv6hYfC_7JAp8Arrf2UdErgqKy+FLG=57yFMA@mail.gmail.com>
Message-ID: <CAPhsuW5_P7R5mcv6hYfC_7JAp8Arrf2UdErgqKy+FLG=57yFMA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 6:27=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> On Mon, Oct 23, 2023 at 8:14=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> >
> > This kfunc can be used to read xattr of a file. To avoid recursion, onl=
y
> > allow calling this kfunc from LSM hooks.
>
> I think this needs a bit more explanation in the commit message (some
> details on what it could be used for, we can explain the use case
> about persistent LSM policy and LSM signatures with FSVerity). I know
> you add a selftest but some more details in the commit message would
> help.

Sure, I will add a short description here.

> What about adding the KF_TRUSTED_ARGS for the kfunc?

Yeah, I was thinking about this. Adding it to the next version.

Thanks,
Song

[...]

