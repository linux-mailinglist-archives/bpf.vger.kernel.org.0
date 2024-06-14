Return-Path: <bpf+bounces-32152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBACF90808B
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 03:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A788283B64
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 01:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2E158D88;
	Fri, 14 Jun 2024 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPn2VksV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56296323D
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718327641; cv=none; b=kGof0i2ObUhSs4RbdQmoYboeqRArO+of3p4FK7OAckGzT684oIN1dY9xhLCNdmrIpigjUIyxH4S5/3Hpwn8NvK1zZp7rxNLdjtkkYFgeFUXCQ8n2Qli2ebXfS8SYij2Ee+yAPmLALhOFvphOkUht+z0jS0VC5j6H4jptkMLQLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718327641; c=relaxed/simple;
	bh=z4toKMZpFWuwKat1a+ZaTuZsi7lnu/SyoxHiYh9dI7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QrpY7dT/WneDgTPBhBoaNH+v/LmLDzfNimfPUGSi9T6LKpW4Md9+Mxydu7+Vd2+giUMejlaZ3UqiBM2ZOyfbVjiFq+kbZ1tC4g7ZP9CuZNI5s0CDGW8BYBa3NGdTd8jY1X/k5i/QEpyqkhw8uTVjWYQ7uL4aIGFXilOlKd3ZAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPn2VksV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6fd08e0f2so13043165ad.3
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 18:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718327639; x=1718932439; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G8CobMGHbI/MtPw5WK2GQshh/6IgWQUzcoKp/VSG6Ws=;
        b=KPn2VksVdjvknKoewa87GIZjQdTSQhA+UjS6M+NdxtWNsNLnG7OlzPJwrG7XUPtpeo
         NYCkFIk+AWb/2FGYjvL9hUX+Bt1+VOqimDB7xeyS0vWCF9Y7qLYSiZgkcLRuZvd1EMcj
         aCIUwGeZaLQ6cXPf5IJi8MZG9xZOffWH0UnFSbChm1xp/T8jV4oTgNAWN4WS4xwtpHPN
         7YQQJOhY/l3Dd8tihckE1Jp9i8UG5hucgGM009I5+jdDNUycdt8GchBTLvT5pUv7aKtP
         f9QRJY/f/aNVpaz5IcqUDRmjUbEiA2+QpdXCvKxTLRovcMtgKcjevgRVcoXt04eJsMMd
         fzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718327639; x=1718932439;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8CobMGHbI/MtPw5WK2GQshh/6IgWQUzcoKp/VSG6Ws=;
        b=nYtklEAuztSn9C4eWOxuuGQpfZfGoCiu8HFNk8aiJt+h3v8w41Hkn/SzqpBkaWnNLJ
         VHT60l7QPcWP/hXEr3vRw2peeoy3BrpwOxYS2DGrUlyhjouIeCPM94OPb9l/hbuwHQr4
         T5u8ID+OdqeZ/7YWroygOrDnepsrcLq1Xh/yBtzhZjuu1sMGDDcST6zbveI7pjUid1c7
         PJP6+EVQS8+BzFKWlgafwJSCSG+Uj+rS25kcv9jh6ZMkpOKrkx8RAXBTHuDg/TyOw3QH
         o7ho3kXm7FJqCjnPCuPArRQU79GtKzH/+SHgImTes8BBP56lZGZfsUF0FwUw+QoaDrUu
         GovA==
X-Forwarded-Encrypted: i=1; AJvYcCX9hcK2cKHgoFWrhbpSH2O7iH1jDlHhTxB93U5kdT4DzzouKk3ymW7rKlvcXO918bEwgOs4yIIW6dmaSQKqO50iGzUJ
X-Gm-Message-State: AOJu0YxE9YO1SoFHaOq5w+qe1LIOpr6atxKUdHEvYyhFa32mCWj0rK4r
	tE7JdAI/GTy5EoUUbgMwX6QrtXmiHNx8LlxGNLOVaQcViacJKNtZ
X-Google-Smtp-Source: AGHT+IFb+jk//kwTHJTf4E/d38O5kggzR1LhWdbioz57dpNE8wOqIJovRh8tXa2a5KfAeSy0R5+m9g==
X-Received: by 2002:a17:903:182:b0:1e6:f93:801d with SMTP id d9443c01a7336-1f862a03df7mr14401065ad.58.1718327639468;
        Thu, 13 Jun 2024 18:13:59 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e99sm20720005ad.4.2024.06.13.18.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 18:13:58 -0700 (PDT)
Message-ID: <d8efec449385287b413ddabeb1a7b9d082f658d3.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 4/9] selftests/bpf: extend distilled BTF
 tests to cover BTF relocation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz, 
	bpf@vger.kernel.org
Date: Thu, 13 Jun 2024 18:13:53 -0700
In-Reply-To: <20240613095014.357981-5-alan.maguire@oracle.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
	 <20240613095014.357981-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 10:50 +0100, Alan Maguire wrote:
> Ensure relocated BTF looks as expected; in this case identical to
> original split BTF, with a few duplicate anonymous types added to
> split BTF by the relocation process.  Also add relocation tests
> for edge cases like missing type in base BTF and multiple types
> of the same name.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

[...]

> +/* ensure we can cope with multiple types with the same name in
> + * distilled base BTF.  In this case because sizes are different,
> + * we can still disambiguate them.
> + */
> +static void test_distilled_base_multi(void)

Thank you for adding these tests.

[...]

