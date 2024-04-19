Return-Path: <bpf+bounces-27229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F768AB10A
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2151B21259
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F09B12F591;
	Fri, 19 Apr 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZfQziT9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407F184E;
	Fri, 19 Apr 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538197; cv=none; b=hZm4URHmlol++6xTHRzvs8aakJgSkube5+BPj+TpTgjatkBNKruNG0r7CFwYLlOpzjqpBYzXJD/EXLme+D8ajVJtK763/Dyu3jEUNlCIN7GGbTUsp+Pbs2LEEdti9Alw5hXPJbzRR/LbQHcO+UBsTqgYUiP7KHedBrKKXhCdHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538197; c=relaxed/simple;
	bh=fSINcalIxLeMUg5Ti1nMvccOMVOatwCS5Sp0a8RnAiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH5ss05fTdRvtLqNUje7iizz/fLQEnDsVulGnJyYl2T+72XL/LgLyO8X+GCeAhd/c30aoNskLo6nRmrUItsmzzFJ2gUN1FWf5d7y9iFsrIzSLJNDnRiHW0J+ltwrT18zgjV4v1brWoCi86S5vT5k38XeOstMFA5tR4a7Jsey978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZfQziT9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44f2d894b7so206982866b.1;
        Fri, 19 Apr 2024 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713538194; x=1714142994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSINcalIxLeMUg5Ti1nMvccOMVOatwCS5Sp0a8RnAiU=;
        b=SZfQziT9D0RMV+ZTLlHckFNh2e473adUP34JrYwZ7fXgg/jEOdmvmHctNWJisaZz7r
         sYnI/nCVpqdxZDCyjqp2EvpcGiGZhbaGEUktemcWBc7fOp4g6BBsglz2jVoDRiKRFAue
         oWWtKRSvmhhqw7ZUz9LJ1Mgu/0B9rJWBNiATr05oXRAHPjP8eXw8ahJ7eSBew/TwiTRD
         e2L/F/rcLkE1cIEBmhhgwAsDDU4IiHQ5P6ClPy0dlXoMfvTsFitWJecBivVHBy5vlUuF
         BN3O2NBsBWDSlNJwgckzowyejtk4CnoTyvtReal9ZC24L8tnW27AAByKwXrWsObA0kEV
         Gk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538194; x=1714142994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSINcalIxLeMUg5Ti1nMvccOMVOatwCS5Sp0a8RnAiU=;
        b=ErhiBXuostC4On6sJrpgcAz+amBoRRm0f+hS3h8Ky7qvtRH/O3SiiMNWAWyfN2aqdo
         mDFsAmK4LUMuoi+4NvVqCGsCBoHrFBXB/eA4px+m/rJUsE40ula2+FX6lWEEW63G8FRK
         Ccy79pxT/LnIiiEEO1veqFozlnERpdYcVGLY3fKI+SawoigCD1tqnNrEWO+BK3hYvR3H
         d/UueIj1Zt5nWP/TUrhrgoauC6TUFrgaCsXKXfpWRiDeGPEckWw64/JmY/ScephJexRy
         ki9iJLqSCSHtcz3NHpRZqSjum5uA1VBxkINLab+TgfLE7j9m9FksY8iQwkH5bE79e9On
         OhaA==
X-Forwarded-Encrypted: i=1; AJvYcCWIvtidU8E3QWaE2g3llaUciyjmoiRyJaNFl60fLm7HgYpo+xktyKF5xhORUCZ6uuUodja/tt2aozJmacBVEmtylAIIFSn4/Q0jptDpsJQEH6LEP1oFfPQG8CQY
X-Gm-Message-State: AOJu0YyJquTkuYfBbySRsmVCEkYYtjCN6aexQcva9Gl2mY/+24eCzJ8J
	ZGZxhojuAimK4ERF1uXL3ig2CMuRjNY80decC9jU0aJRnuNJixCsyHJCr+9IIi883mnzBw60j5V
	lEICrLSOEDbtmt5Oi2pWvsbJ46Mo=
X-Google-Smtp-Source: AGHT+IGtOnX5DIqaDw4yYJCOGvwF3sUfzpGdz+OhZABD5lyBBs39G7gzSAlEM4bjHf+f7JQw0ufpDFhAKG2lo/417vU=
X-Received: by 2002:a17:906:b105:b0:a55:75f6:ce0f with SMTP id
 u5-20020a170906b10500b00a5575f6ce0fmr1662248ejy.13.1713538194507; Fri, 19 Apr
 2024 07:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <CAADnVQ+-FBTQE+Mx09PHKStb5X=d1zPt_Q8QYUioUpyKC4TA7A@mail.gmail.com>
 <CAM0EoMknntbtdZY32yjA8pUHMONfZyO8gbxkm31eSKj19NBRhQ@mail.gmail.com>
 <CAADnVQKapK1iUrX+vED4pq4LGa8sM6V0FgYotvHOuuc+0D+K4A@mail.gmail.com> <CAM0EoMnHsxKHSqGVLWoYQGDDnY-Ew+hMvnY5_jzwfghRGe2EHA@mail.gmail.com>
In-Reply-To: <CAM0EoMnHsxKHSqGVLWoYQGDDnY-Ew+hMvnY5_jzwfghRGe2EHA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Apr 2024 07:49:43 -0700
Message-ID: <CAADnVQLZcdOHKMdrm1vAAJyOAqPmf7vA5ejvYzkMz8GZpcJmcA@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	khalidm@nvidia.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	victor@mojatatu.com, Pedro Tammela <pctammela@mojatatu.com>, Vipin.Jain@amd.com, 
	dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com, 
	mattyk@nvidia.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 7:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> You dont get to decide that - I was talking to the networking people.

You think they want net-next PR to get derailed because of this?

