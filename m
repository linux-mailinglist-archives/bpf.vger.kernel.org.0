Return-Path: <bpf+bounces-29558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65B8C2CC8
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 00:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8211F22695
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 22:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BCF179211;
	Fri, 10 May 2024 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYgnLD/a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B8177980
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715381831; cv=none; b=VBB80YE9l4bZZXAnqO1wGrU7M4d9pwX1kAmjyRK4SQFunrITzdPL7IJk3wAGQ1+C8jXkIYR4R/6AhG42tayuXy5auD0gQitfvUCEmVxEKwUyteHYXZzEKG9iItyu5vkZUCoWZuO12CkE89XF3Jqo9xsZiBL0NjqkIPKy0765tpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715381831; c=relaxed/simple;
	bh=CpbmmIh7r9d73jgxQSmBnmTxPYQZZN1tGJyyk52iJiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vt6GiibWvs7c5JAreqN4hftjZXsLjuevNmbQg8J5osS6nhfzRXEAADIpZqN9l1af0ohl22XBWbS/qqGVBKV6ZvkhvdNGCJi6pioGiUa91qXVQ0hB39FoxOYSPutXXv2XdAiXgC5ALi9f4uIC7mhcST29GrpF64Vfw8qnLBlOpoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYgnLD/a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ecd3867556so21467975ad.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 15:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715381822; x=1715986622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G+zG72hxCkPBJ8eC1mTUD2S85fJoKbSik6hT66Hl3Uc=;
        b=MYgnLD/a6OFfsBlNaD1YHnyWPZifxdilUmvdwn3697XfoiK+7mc5t8wpDpoEl4y9ZN
         653sLR365OuwiGsf3e5xqlhXdt6cnQSxu7VhtRayIOlm5VME37n3KvWzRyQOi+AWXJR9
         osRKwtK9IKpO43WwyuZ3yRTxe5LaUQsJFTcqAQsygsUAc9U3zEwt08zqUIvo6Q5gBXMp
         7ETSadXLGl4JSno3yUSGD0RP0/WkrIGnk6/c1A8Lh7sbijb63+Pb+a2A5T5Jd9szjhw0
         5xoCqDHdq6iH6nH+V8gvGBN6QVBy1E9ks86PmdgQSQtFIu3eqCcIB1sfIZFmQeM0xHAB
         OCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715381822; x=1715986622;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+zG72hxCkPBJ8eC1mTUD2S85fJoKbSik6hT66Hl3Uc=;
        b=ni314kKgn8vG4i78mzbC72vbe9eaU178BnzFVCdEFIdu42lV3sVGnEw2EJt48LtcFl
         n1pK58Plmo7RZKB78iUq+3Hx4dLaF5qUmU0hBrjdLbyLwKQt7oA5DciOXUXYSHjDtmBb
         1LKO4JFSQDWUkeRRwgdh0i48Xd6CSDg9Ta3ONc6eY5yM3kxz866ULOLHsbIOfm8X8yJx
         xxUdv4bGJN+sPVAvZCeRPr4iZ7DbTrNfJbRKya2n8AdYsBtnf3R5JfNsJD5OY2l/Dnxw
         8Cs3tW4rqwmZYj4YV8PJhHlwY1O3zEL+h1HjA4tp+bGDYtWiN1FMSZp0j/0ElNv6EqL5
         T+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjI1sOK4R/4pJPCN5KEqbTgSI7KFYmXgAnM05MaGSKMvkE24wGITBXhRvS5ZEewFKDHximyRU/aAAbZBYBbBfeV6bL
X-Gm-Message-State: AOJu0YzU2nMlqfTmPtwDJ7xGDeyycyjfoiYQJJ28C0QfY708Jm3dv5jb
	5DP59QJe9PWxfyilD19+XBlu0IL+0BrruBCeOIBk2hs0MGfMyGRM
X-Google-Smtp-Source: AGHT+IH2o8SZhw3CxrRWQcohVkqWMisiPrQcDDnyZfdgy9umXc5659Qr0e/O0Gr15QOq+rD74F7z4Q==
X-Received: by 2002:a17:902:d490:b0:1e7:d482:9e09 with SMTP id d9443c01a7336-1ef43d0a022mr48393735ad.7.1715381821926;
        Fri, 10 May 2024 15:57:01 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d176fsm37554925ad.58.2024.05.10.15.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:57:01 -0700 (PDT)
Message-ID: <e65e8c7d387312f4b13a1241376ad6b959f90bf7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and
 kptrs in nested struct fields.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org,  kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
Date: Fri, 10 May 2024 15:57:00 -0700
In-Reply-To: <52912c4f-219a-45d4-bb61-aaeadaf880c5@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
	 <20240510011312.1488046-8-thinker.li@gmail.com>
	 <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
	 <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
	 <62a51fcaddbf5eb8552a96e6a24ded83f8f9fa49.camel@gmail.com>
	 <aa0cb7c8-f057-4f51-84c4-2cc9bc4e2edb@gmail.com>
	 <a938837ff87adcdebaa58f612395dee06a0ea94a.camel@gmail.com>
	 <52912c4f-219a-45d4-bb61-aaeadaf880c5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 15:53 -0700, Kui-Feng Lee wrote:

[...]

> > > > > Do you mean checking index in the way like the following code?
> > > > >=20
> > > > >     if (array[0] !=3D ref0 || array[1] !=3D ref1 || array[2] !=3D=
 ref2 ....)
> > > > >       return err;
> > > >=20
> > > > Probably, but I'd need your help here.
> > > > There goal is to verify that offsets of __kptr's in the 'info' arra=
y
> > > > had been set correctly. Where is this information is used later on?
> > > > E.g. I'd like to trigger some action that "touches" __kptr at index=
 N
> > > > and verify that all others had not been "touched".
> > > > But this "touch" action has to use offset stored in the 'info'.
> > >=20
> > > They are used for verifying the offset of instructions.
> > > Let's assume we have an array of size 10.
> > > Then, we have 10 infos with 10 different offsets.
> > > And, we have a program includes one instruction for each element, 10 =
in
> > > total, to access the corresponding element.
> > > Each instruction has an offset different from others, generated by th=
e
> > > compiler. That means the verifier will fail to find an info for some =
of
> > > instructions if there is one or more info having wrong offset.
> >=20
> > That's a bit depressing, as there would be no way to check if e.g. all
> > 10 refer to the same offset. Is it possible to trigger printing of the
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> How can that happen? Do you mean the compiler does it wrong?

No, suppose that 'info.offset' is computed incorrectly because of some
bug in arrays handling. E.g. all .off fields in the infos have the
same value.

What is the shape of the test that could catch such bug?

> > 'info.offset' to verifier log? E.g. via some 'illegal' action.
> Yes if necessary!


