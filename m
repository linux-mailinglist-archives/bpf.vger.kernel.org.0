Return-Path: <bpf+bounces-41438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E816997040
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4943D283B5F
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BF21F12E0;
	Wed,  9 Oct 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RmzLyaxN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62B1EF95D
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488175; cv=none; b=pPLKmoh7/t+uFkNJqfq2dBOGldUfp2oNgqbzknZNG2qUboJ0RPfUlN4R7miwrbdHpihWwo7nhLspY+fHBlT6OxNLZv71UonkfzjqA7zc6hE0HOXN9fbgViFSCIrUlANPbsU1d9LhPQ6nIr7MsNxyZ+u5MMxK9msRJvaTIK1i2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488175; c=relaxed/simple;
	bh=t0jsWZVzZQn+sDURCRyRKujF2TOyMfjajxg8xq74q88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnjuQe07fjVq5Spcr1Hh6Ifa5NClZejZ81hWV3W2XJATaCFE9WagKjrre+cEn5p0zkxD0FnakwN6pDT0kGjmhQU9q8wqGiAAhTkOA4QEIgg+W/uesf1Phl4DuZLvN7Rxjj39818hjjE79qQrsten8VFn9DDe/szpD/vmYC7oWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RmzLyaxN; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fc21ac668so172086241.1
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728488172; x=1729092972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qhu38DngzJNXLHykf9yFte9ZgoMKMY8LdzsSZdaHnjk=;
        b=RmzLyaxN8sjmApq7cFcKSo1Uaq6ZkYzM6NlPIxyfD0/RdCDtQ13ddThIM6RP20+woc
         jez37ghbj+ugxPTXZtaOAkxNK1EZhGF3PMswEAJnuyzsrRUsiKBTcpD244KjJBvQk1lu
         w6+LQJceWk7N3Gh+xb0on8+M/6X4QY4A0HdUtITtEZgu89DTKyMdwx81SysyzpWBlwMo
         mdXiah6rIZ78AZ3J1quvMBSpj0OjVOKn91fLf+N7pn/OkiOT+Hle6xI+CXaswtTDk1ki
         X7K928R0rHMWEflw1EbVeOjMnEJaHSgXNoL/5xGjVuhLGCc3w9ZVPiMgE1jPZUbrEwzb
         PJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488172; x=1729092972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qhu38DngzJNXLHykf9yFte9ZgoMKMY8LdzsSZdaHnjk=;
        b=HRQXx6mlCrRnQPoIOCFa+5bzg1yaFytlE60GE3WgDAY8RcnE8Ic/X/WADUQ3BxhNGE
         8ikbCPbfKZY+aYCeib1QHPMPDr1OIIBsaYKeL1A8p7n4JazTzw8pm1nDXcLJ32EPOv4U
         93oUVkjj3p9nd+/d5y2jlURk59fx4cjYCknsbp+qD/MxJnP8rdy0D3OvGoO4TCdIHQpB
         IFVj7YGohUyFRH5AHw5t0THBmSV81BId5rBjSmlTXeP4rq3oghLWiZhnPw1VWvdAyCXl
         e3c3yFi/QX6DTgHvmWAHCrTWCRN0hcguUMC9tqq/AHQauQveI7wj+AOgBajVlyhauZGt
         B9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU0/6AMT8MVT/CL7iJ00e1W5TSDxJJY7tZ5GdNGc2ihiLYuci+5EBRLF6zONVUD7nCmJBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLbbW28eZD4rATZdqIb8hvJiH2wZ2bB4bEdsAk9ft7OrxKVxGB
	5hOovXu2Kwh/DPImZAoIZMwCLFMiroTYJb5T5AU26m04ULahdvCR8YrygIaruOkD6zkkiUioFRg
	uZgBXg1wpyJbrAKUE7ZjVFVOAZEeRVbzgYNPwyi2AJPkTbvI=
X-Google-Smtp-Source: AGHT+IGXhNalhdnG3UgTDQ9dAvTj83wJi/06ycVsl8RL3FYNY25jYKWxfxAzxHyvtp+Cq9de5ucgCU67xNjnkIFk4Ug=
X-Received: by 2002:a05:6122:290f:b0:508:1db6:3b5 with SMTP id
 71dfb90a1353d-50cf0c8bb7fmr1934036e0c.13.1728488172555; Wed, 09 Oct 2024
 08:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Oct 2024 11:36:01 -0400
Message-ID: <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, ebpqwerty472123@gmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Move out the mutex in the ima_iint_cache structure to a new structure
> called ima_iint_cache_lock, so that a lock can be taken regardless of
> whether or not inode integrity metadata are stored in the inode.
>
> Introduce ima_inode_security() to simplify accessing the new structure in
> the inode security blob.
>
> Move the mutex initialization and annotation in the new function
> ima_inode_alloc_security() and introduce ima_iint_lock() and
> ima_iint_unlock() to respectively lock and unlock the mutex.
>
> Finally, expand the critical region in process_measurement() guarded by
> iint->mutex up to where the inode was locked, use only one iint lock in
> __ima_inode_hash(), since the mutex is now in the inode security blob, an=
d
> replace the inode_lock()/inode_unlock() calls in ima_check_last_writer().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima.h      | 26 ++++++++---
>  security/integrity/ima/ima_api.c  |  4 +-
>  security/integrity/ima/ima_iint.c | 77 ++++++++++++++++++++++++++-----
>  security/integrity/ima/ima_main.c | 39 +++++++---------
>  4 files changed, 104 insertions(+), 42 deletions(-)

I'm not an IMA expert, but it looks reasonable to me, although
shouldn't this carry a stable CC in the patch metadata?

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

