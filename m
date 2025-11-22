Return-Path: <bpf+bounces-75284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B98AEC7C14D
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 02:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3290F35A254
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891B42C0290;
	Sat, 22 Nov 2025 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxJOsDeA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD8729CB48
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763774241; cv=none; b=tuBM7qXhdPS4rvxrv8O1QXehsz2Fd/cLE5reACODk3p82bznmuHkvUxdd8zMnix0328EtVKAg7r0mFH6sSwiKHVAzGsTJTwAH4XcaUdfZJ7a0RTdemCL12+K7/ZwCtSumoZioL4CgDt6mrRkClxCXoM5JEloXaFWJyf/kKTIbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763774241; c=relaxed/simple;
	bh=PJoV6VdDOsLL2IC/TnwjqbxADRYte+W3/ttZzgGPoq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sBDVJ/vAmgAvNBsD/DlivnStn9KAzo0klY4cX2b8qqCK2W9okZKA5JfpI8tpo9UYaKTfUxdPRqfkqTDi0RZO+/edK+6LjY3yEkWg80252LC058aQyeuzGt8SZzp4gSlDBserh370uyttBHN5EOwaf0Z3FBpxKPu9uKFjIpTMJ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxJOsDeA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso2203220b3a.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 17:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763774239; x=1764379039; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJoV6VdDOsLL2IC/TnwjqbxADRYte+W3/ttZzgGPoq0=;
        b=bxJOsDeAuEg8KNPrBF6qnyjpHUmMXculL3d2kOKWdck+DYTS+ch0ygpswFocwa7qjf
         CX4AusmPmOw9Z4Czt4O0LnEhJI/BZfk6NTVxDk/cRNX2k38eTS5haoG1uiCnQQKqVBtm
         il8FynM0Y3rBJqBmRRNw/wdToen+3Lq/QLLm5SCwgrauhVxuvloFCK90DoyBdop2oDPK
         PD9oHQ91id08uBZs1QeN4Iuc0bBchCykJWtLLTrFJHFcE9jRlsbRsS5hOgC7D+A0AgOG
         pygWluX1VHhTotx13p7Qq+b4dqjvFfdx0dovw4dJqasTjj05VJjkh02Ik7jRgeZUxh1e
         EYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763774239; x=1764379039;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJoV6VdDOsLL2IC/TnwjqbxADRYte+W3/ttZzgGPoq0=;
        b=mH2xw6yxWEoeq/kDH3hbl5C8v+effJgj1SYLTmU8yTA2JFFJEB2R1FOKi7/wKAgW4C
         lB+1SeuRiH8fJy/T6GoaZH/LWGoEL/LQUa/1WsvluXrEn3pd6p5gY/CeN5v+BLo2zT/Z
         Y+klHTcflhpsoZi3gvMDWqJAEJ/xFlrRcMTP5jJzN/OKGNlvvhsphDNJKhOlEtRJMhqs
         +v2+mePb0ohZ8sPd/Mr4mwp+pdjThMyhRb43Ii6rtADwejFZGuLdZsddgRk1YOGNgDSn
         mDozev6mcYCewGo2p4z4yv63GG66Kxya0K5nv3ajQPxqT/T1SCMb7Q0T6AVj6E7Sy6cw
         0ulg==
X-Forwarded-Encrypted: i=1; AJvYcCVRmbq/hnsC586gxc0bySH7jAQcBF37Sq/FqRpGZhEix92zSgoLF0LyFT3u+VUtE6HOUy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDfmFizUhnmeAj/JiLYvqEQ5VJ1sNFKMVANta9owaok+/AChu
	L5vZQRUhMGSgpMcIbYaph2WqbAl3ZL0X/EaJl/LT7SJQH1prVTL2RM/Z
X-Gm-Gg: ASbGncuwrYUgQAWXOO1o73Kgh3Krh2eCu3gz5g2Mx6apIFlHdFitCkPQ5qLy2MEzln1
	WBsmTJttq7+aFc18a6hzEkyPvEzCp4UnJfhUGgpBrkFPgu6RlaZ3Zt3UP3JuV9JlIM1a9EBjoWV
	p2Ffv9zQvMLfb41NSx2U0j49KK1QGdj2VdTgXRo6XPDMkhHUd4x4tYcydmVPYSE1vNucZOtln6R
	smcTBBUtWy8Ce5eFwOvD5Tjp5/KkPY8QngX+VW9iqSCleuSj+ZXeOEXIuQ2l2Bcr43RNxiJ3Pq/
	iZDM/z3qEfDfNCy+w75ZVmAa2JW8B8UGTs8mboBmheaqyZtVRbroDhufUNNsY/6mtbtqh2Y3JO+
	8wPBrKz584l7k9OKF8BI2eJDvrsgoFEFHZemtgZvW6CjGrf4OKP8ta/EN+5h765MAJwhx7Bo89u
	nKAohFnzA=
X-Google-Smtp-Source: AGHT+IHnDk37olLEI0Tty9LM9PiDOCyA9gHpuIhc/YREOoZvyCHLVeBO6Cnkcs/1gVL3pdthcm+uIA==
X-Received: by 2002:a05:6a20:3ca5:b0:35f:46d3:f27a with SMTP id adf61e73a8af0-3614eb4f145mr5403901637.5.1763774238856;
        Fri, 21 Nov 2025 17:17:18 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0d55b71sm7342420b3a.55.2025.11.21.17.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 17:17:18 -0800 (PST)
Message-ID: <795dca13afc1eb3c19dac04667e1649eaa71d2f4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests: bpf: Add tests for
 unbalanced rcu_read_lock
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	kernel-team@fb.com
Date: Fri, 21 Nov 2025 17:17:15 -0800
In-Reply-To: <20251117200411.25563-3-puranjay@kernel.org>
References: <20251117200411.25563-1-puranjay@kernel.org>
	 <20251117200411.25563-3-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-17 at 20:04 +0000, Puranjay Mohan wrote:
> As verifier now supports nested rcu critical sections, add new test
> cases to make sure unbalanced usage of rcu_read_lock()/unlock() is
> rejected.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(Although, it would be great to move these tests to RUN_TESTS
 infrastructure, at-least partially).

[...]

