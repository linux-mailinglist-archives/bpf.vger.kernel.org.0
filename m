Return-Path: <bpf+bounces-22045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B130B85589A
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 02:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8952290427
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 01:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9928ED9;
	Thu, 15 Feb 2024 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy5//rtf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467A10E4
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959460; cv=none; b=oxvNEpcgFWNvFxu2nr7jpxe9M3JOixBKxQQfDAG02QjUnc7xgsXcfLebZYFVZYkgblG5h3sVEHtKdSd2ZzMim0PPBRMTM4Acnf9yhMj24qepR7Xwu+89VtO2X1EwLILcYJVecO9JCyR9t61ee7/tnwoR8AIHRk1Likb00/DXhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959460; c=relaxed/simple;
	bh=rBeqMfCdEXmwfMpDadOhiJTfLgcyvHIz2Bpb6G9MOiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3Apj6jxof/foupuY9BrmHXRthJuYvJoH1omHpfOIiYoInNLaZcFIP6Uep8/pnNwpyQyElpVIe/U3iXhQ07puREGgU5Li55YPcjVGB6D8VvZyp/NTDarGtUktXTQEXZQEqKLfFgY6DtjkMfyQqtD+7NBuldUlY/DJE039FmQUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy5//rtf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso551838a12.3
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707959457; x=1708564257; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rBeqMfCdEXmwfMpDadOhiJTfLgcyvHIz2Bpb6G9MOiA=;
        b=fy5//rtfA7K/tT5RjxAnlr0PmyJ2BrDIWiNC4E6ccsoMzwx9iOXmXK9X7+1DMydmD5
         7U9CVZD+PF3BWksCQikveCi0uLlTUuH6D8tMCfvTPus9F4VqJf0XlY3GmDIMNK/CdBoj
         RjSEjsG1u1BQn9WL577pHaVCzM9mDrvbbnEpcA0DisGCBk4g6L8Xl7K7fRcwSCNsGL/W
         8B/rcYsUCV2rYVTXmO362PXFhrg6ZdANV8CR5gbAR6LlCoT9JCPeAKac2HW6MkvodmMR
         m6NrRwLpmyVN/hmmb2v68LlHjD45e0KjYj9TVA5FDv7TSiP/dByyfCT3/WaonbD0flNA
         nq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707959457; x=1708564257;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBeqMfCdEXmwfMpDadOhiJTfLgcyvHIz2Bpb6G9MOiA=;
        b=nq6yEsEoJTwESPk6TLmcOw/pW4whzib55KjNUHa7HlEaMOmkkWcSD3n3uQmGkG6rWg
         pl4F9Cz3+jVsuLNAeLU7GWdLrpqj2jeFagyF2ru3Q+GCURjJA+Fh73IEFEeDDaMRJTKA
         gGebpefGop5fsYRZK/QglWayJH/S3uBCPde5p4b4Ycisrdsnx3i7mkQx7h29UPkmvEic
         3tF4nXrSnyOJvJp0+iPvbqy0Wq/yUxLg/GW+qKanzgnIIJCCSXpnwQNRQvu6VlApHx5q
         Sy5z8wADlL8cfgQ9cjX7bPhdUDBc6GzaBGG60nPOlT9KnnnmZvESwX/5V66xHecWFnfe
         xgHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYUxfkVrEDS6K2qq1GDdV0ElrCufoi25kCseDwFoYQsdwRbdWOblUiGTZ/bSljN7YPx2bfnmE/ZvIKgkk1UIQOHlo1
X-Gm-Message-State: AOJu0YwI1lHPl0Kzfe8fk5J9gJ9v/h558xAKNANyGNXR8FClfxlaqYS0
	R8gSJn8Qn7LMSKJ1AokRePGZsWg8aMgnJcOwdci693ROMb6h9ELWUqB5VSah/Bk=
X-Google-Smtp-Source: AGHT+IEwSeBwHmo9wTVxII58su7bqrBayPTsJNFfbOGAjMciP+Pn6FO6bjdjr6J7PWsg9+wobNp61Q==
X-Received: by 2002:aa7:d952:0:b0:560:9256:3cf5 with SMTP id l18-20020aa7d952000000b0056092563cf5mr193951eds.34.1707959456949;
        Wed, 14 Feb 2024 17:10:56 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u26-20020a50a41a000000b0056392b7d85fsm77480edb.9.2024.02.14.17.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:10:56 -0800 (PST)
Message-ID: <93b66d1f05678a554288884a3c22a143d1cb3a0e.camel@gmail.com>
Subject: Re: [RFC PATCH v1 03/14] selftests/bpf: Add test for throwing
 global subprog with acquired refs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Thu, 15 Feb 2024 03:10:55 +0200
In-Reply-To: <20240201042109.1150490-4-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-4-memxor@gmail.com>
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

On Thu, 2024-02-01 at 04:20 +0000, Kumar Kartikeya Dwivedi wrote:
> > Add a test case to exercise verifier logic where a global function that
> > may potentially throw an exception is invoked from the main subprog,
> > such that during exploration, the reference state is not visible when
> > the bpf_throw instruction is explored. Without the fixes in prior
> > commits, bpf_throw will not complain when unreleased resources are
> > lingering in the program when a possible exception may be thrown.
> >=20
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


