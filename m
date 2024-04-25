Return-Path: <bpf+bounces-27804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C9C8B2196
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 14:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4381F22D82
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462B12BF22;
	Thu, 25 Apr 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OTEQXTRB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4857C085
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047998; cv=none; b=VYezAAVsQoueZTXUCcTP1tLZqjbcELMwB2+GxIFXNbMh7TkkGMGvgXVciOTCIq9iQ8W/o8BW4qiRu6qNaaY2O04Eym9KNZW06AfZ84skCu5qtWTu/MiXzT3vIDj/xNv8MrGfM60dAR5y795TIx0TE70Wz2gohXOBO8oPzBaQwMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047998; c=relaxed/simple;
	bh=qoCndbqMNE3BqNyuRKerd5xZFKipqxBEtMUifgugVLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7BAUn9ER+a4RAJwA8Vb4fqOcBvT0xxwBbRdOvOMc1oY9mPNAxxggUHaI4Q3jccwX1SkppWIwjkYnTuWbLlZLuGaZBeMNX5slraSYkvflLzzA3MngtsFnpjYmSIgExVK2/0+0J9VE36uSUIuyy30MoaCYb/hmmWbqMphk0PtRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OTEQXTRB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso617869a12.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1714047997; x=1714652797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoCndbqMNE3BqNyuRKerd5xZFKipqxBEtMUifgugVLA=;
        b=OTEQXTRBWZ2K7BrdEbXZCmVvlRFJ1WiSNFf0A4lWgy+7aNUPsgQtNFIo8Kzjtm+2UE
         2zjGVuxWoIZ8QaEuDUefBJ6LszuJkPDzCryK79i156nDfdDRNQku7yq3xJO5dVgIrI7H
         eG7C0M4AjmV32Q6pOROpuQabX1TkAm7XqgeXwrZzVJI8lHkbIoCe3BE3CZtu7G4JCHiq
         yc+zdCjNFw3u5p6xMlKudaIqrueKt0AVUp58sr5bpje2YVQ+R8u/8dGHjpk3/Pc3BCWd
         7J0AcpOIfKcu/Bn+4lycHRZtGdlaGFBcUOfI29dNo6WmE1W6sb7fW4SEuyO8L/rySHTg
         mNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714047997; x=1714652797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoCndbqMNE3BqNyuRKerd5xZFKipqxBEtMUifgugVLA=;
        b=VP26EZ/KU/ZLxgHg0PKWKhiSYRz14Xz7RFPdFtfzmulYZudxls2iFOyizg4AVRE7S2
         3seXXB4Uhf6ZqG5rb6FEZ2MLh02jHZL3bB7wUgCCF5YPv0c8wccmkLoqjOZqWwW+ZcO1
         8C/KP8OHLZrHEBLkf251789nBB37UJ5PBblQT+uT7RBHCcAkYRtOfzCT1kIe7Xl3tJq1
         9PIOCTieNA6UuOAQu6J04Tkst8Yp07Hc2DxOrXSNQkbHhsmFIRdKIssX6dW3Gr2gUA9V
         lb1A8eQl8nWTOjceobsSfvZvovexv4nOV4mzGu8UizMG3oDfr5UfpRAWEOts01T8skNO
         TKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxLOU6voQo8DT9nwk03yHftr/A/GaQ7W6Laz6HiHjX/nCOJrohNF6vHkbwnFLcqw5pb/UZbPu7SL4T5EnWslkaPqig
X-Gm-Message-State: AOJu0YyvSFE5vGhiaXCrbdgWpZe80b2T/KyZkk8mWDqRrpvcy3C2R3qt
	VFb2TWVDIxHo+1R/vpOZ8gH5h+jorpCRwTAhUI78IVPyROqlxH41wn03LXWilZOQczVl0zbpUFf
	yx/4Wk19qFHjCZLHD/yQw72hJxa7hEMHxcT3NaA==
X-Google-Smtp-Source: AGHT+IEE5M2ANlYyuPFnN8QiC4Pt2f/2Sdx+reeKgeULql42RQtBmelZABoqu1+suBWFmyBmGyXug7HMm4D7XG9r8T0=
X-Received: by 2002:a17:90a:d583:b0:2ad:da23:da0b with SMTP id
 v3-20020a17090ad58300b002adda23da0bmr6450954pju.34.1714047996954; Thu, 25 Apr
 2024 05:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712639568.git.tanggeliang@kylinos.cn> <e4efa52c26ca5ae97c7e4e7570d8da9cd44df533.1712639568.git.tanggeliang@kylinos.cn>
 <e2aaa0f0-7641-4d26-9256-1151976235f1@linux.dev> <Zh+E5JlEM6fisrFS@t480>
 <f3f0388e-8884-4371-b96c-80d4ee34592d@linux.dev> <ddac8e767369df15dc421bb613f88463bec30448.camel@kernel.org>
In-Reply-To: <ddac8e767369df15dc421bb613f88463bec30448.camel@kernel.org>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 25 Apr 2024 14:26:25 +0200
Message-ID: <CAGn+7TVviKqYSD3__uv5idsDK93ynQPETxgkRew3Zn9AMoLvuw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] selftests/bpf: Add F_SETFL for fcntl in test_sockmap
To: Geliang Tang <geliang@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 12:29=E2=80=AFPM Geliang Tang <geliang@kernel.org> =
wrote:
> New version v5 has been sent. Please review it for me.

Sorry for the long delay. I'm in between laptops. But I will take a
look this week.

