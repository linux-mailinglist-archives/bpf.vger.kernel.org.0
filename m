Return-Path: <bpf+bounces-46192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E289E61BF
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41861884E13
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBF7ECF;
	Fri,  6 Dec 2024 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYJz4L/M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E6A41
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443726; cv=none; b=EGLHLRVqjcB7BLXIGTOjE8D6v9G7rMWdvNc4I89ARfNvIMBQtTkxLfiCI4V48m6JgnROkrKlnvKM6Lx3qdWxlCSmgdUdNkuTTofqSGIytY+Tr6J+EVwWTdscxzAFAx0R+AZWl/gbqafGwXjJA9x42QNYq8QWnMtfWxEyDxD/kQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443726; c=relaxed/simple;
	bh=VbNQFmbtDpjBWuBq07spbzJD1f1SBpCaL0ZcrU7Lrhk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5fz6Mk/RWKs/6kxeVZ6bllGawEMv/aRI8NSsriQlu9tES6AnuoGpoP0GkyFU6jRZ8Y4hATUy9EPO2zowmT0MbN3MXOV0YE4iGKRkQ7VWp2F5i7nOrP+U8aiiUpCUKs4SJq3W9Asu020VMV7vTpyxOTiWkDsl/sAUNtzfivxzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYJz4L/M; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215bb7bb9f9so13304225ad.2
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 16:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733443724; x=1734048524; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VbNQFmbtDpjBWuBq07spbzJD1f1SBpCaL0ZcrU7Lrhk=;
        b=OYJz4L/M3KrQM4lXokY7IiyL0YaeQLG2lFVEJ7G4zxAkIuV1yHUA5mKJ4nNHBBtdiS
         1pA5A4e6LatG/orTd4WkparldmOAPX7Jzp00AZODSMBSQws013LKZdDw1Y638gDSPCyK
         5zFqVwHMbnWqBP/DEdAdXkE7L7zsNChWOVLnGUinV2vgL55XikFXZ2EtWlW2idCp08uk
         it+KSDcRKkGS/Gbnbu+U0gpmICy/aQdcvqtU0SP9bbMe64UW7EyultkTwap0Y8u762fI
         V57yDJRSRBocKCxgqAHXrnfJv4aoIKsOjOjIEaG0qoKtPvy0bABV3L6/WqPzed6yv1sh
         4img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443724; x=1734048524;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbNQFmbtDpjBWuBq07spbzJD1f1SBpCaL0ZcrU7Lrhk=;
        b=uLXUJGptzrJL99+51geMesPuTqpJxWUo9uVfvi9bTiA00fm4TKQTwNwCD+lRHwnALf
         cG8nn0O7aHRYlr+yLYlV/KBEL6kLzoS+PZm3IvuLra4T4DKn/vUoWzStxe2RxbYzdsTP
         8YHLo2MVgnfw4RZPPKtDFPxi6yXILUIzjM1wdncnFJuo2FZPSk9vC/C1aFGEgpbaCOsd
         n2vlctdWToJeB0kkKxfgkZKNi2Twkvkqq0dRq8kbc7VBpo6DNslUQWiFgVtHTID6/FUM
         AcM45AUo8bxnf4UZVCO7fi+GJL5WzPMqbklFWlUUeF3InEULY/Wlssh4r0m9Z8hXNFON
         MP4g==
X-Forwarded-Encrypted: i=1; AJvYcCU1AZQL13nu9AkLOAV1CQjMdgFyHYRNRdz1YNQdp0Gmlq44+Gb8x8oSgs23zjLYe42JeoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPkNDmgCbJY1f07ijvHDpY3x1u6YXV0Sp/eWHa1ALTbU70Sj/
	k677c3CTfnuzE6WpNm+ZIqiwpOi92PaxXOR22+fdhaDlBMwSWIHG
X-Gm-Gg: ASbGnct4FNWCexX4zWaZMdZUGYHG7Toir5bMZR8wNdfQRc0MBB0Fq10EJkm0XNvX+ao
	Jjx2YhDVoTIC3V6ipD3SwEiwcY36H3P+bS1L1XIdC9YkPiu2Y/XoKfo1x6LR02ETXo1GoyA09Uo
	oh+2h/335uG1jPmq802QA/ApLKHebeYXoNAfbhj5hxRdzGfpq20AkNFYMDEZhd6kFmop7UWTYsi
	dxU5eAqd1MsmKtbX68h9nvSkJ8X5EkPhBheda47+KNpUBY=
X-Google-Smtp-Source: AGHT+IE6lLoGQ3A82cd4sIO5qb1bdbkG2hpXga7TqhSyHavSHnxfITkj57K5sayP3wWjnwb9uengvg==
X-Received: by 2002:a17:903:187:b0:215:a190:ba28 with SMTP id d9443c01a7336-21614d5b849mr10765305ad.22.1733443723895;
        Thu, 05 Dec 2024 16:08:43 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0a7a4sm17939175ad.218.2024.12.05.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:08:43 -0800 (PST)
Message-ID: <0f4e3cecdab67174168a22883cdc6d6336bd329e.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add raw_tp tests for
 PTR_MAYBE_NULL marking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, Manu Bretelle <chantra@meta.com>,
 kernel-team@fb.com
Date: Thu, 05 Dec 2024 16:08:38 -0800
In-Reply-To: <20241205223152.2434683-3-memxor@gmail.com>
References: <20241205223152.2434683-1-memxor@gmail.com>
	 <20241205223152.2434683-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-05 at 14:31 -0800, Kumar Kartikeya Dwivedi wrote:
> Ensure that pointers with off !=3D 0 are never unmarked as PTR_MAYBE_NULL
> when doing NULL checks, while pointers that have off =3D=3D 0 continue
> getting unmarked, and also unmark associated copies with same id but
> possibly non-zero offset.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


