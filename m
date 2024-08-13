Return-Path: <bpf+bounces-37115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F73950FFE
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 00:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4389F1C21C50
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 22:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587111AB53D;
	Tue, 13 Aug 2024 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q49BPO3Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FB36B11;
	Tue, 13 Aug 2024 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589847; cv=none; b=CRqK2LXs1JA/N3OyaSYkEJROXK1QnfbxQDSxMoRWiicuTYDy2qdROgve4R0iFiqCTqRP6tvRfvBXMsL//R0E5ls11RrsxZD3gs1f4FhZDu0vFMD2AGO4PoRpYPaW9mz2//pvbdM0/tCSVKD0JiyvBJQYGZim6B2EEVsm+wtXQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589847; c=relaxed/simple;
	bh=GN/tNCf1J+3djJB1qyOAIMGREHE4dIzC14ofAY9keQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/WhnQWSNoK0M+kwKnzmPQFyFqerhUljoqwJHdqvwCJag8Q7AbBVyWGM5FAKHuDP5V0dBXy5fN+atCs8KoNk+BVtonH3Xhyme6uzaRrwIsZK9Ib62u4bYPI/0eW2JPwpOfpVONVLd+R+nQyjSxcVEXUDx75QzvUie51yyhuLO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q49BPO3Q; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb5787b4a5so3975060a91.2;
        Tue, 13 Aug 2024 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723589846; x=1724194646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+X9amBCNGzPbKLhSrsybSJwOHCEylYOwiuwStURnpQ=;
        b=Q49BPO3QzwCu5uG49zPy4ixwcxFRofWZW+ivx/7IicbV53nQt6BIqe5Fay1RLyuvxJ
         Rxo9QuKeFDMbJ5HaYq6XayTGDjHG+50Ke6j7DMQoOlS25GPz8h6lk7KwHSOl/vsqwW2y
         b0jgZ/UfmuvrF50h8C7+a5hBAGDVX3JUkvHR7GXvFYS1YlKbIl++12lOk54jryKnWNbj
         PSeKzeHFbO4CuwycX3wf4AxuRAgu/dnx2CC3L7K6jmehj3Z+NtVfi+UMo43KEPr5B9RQ
         8+tWMFLYcjmNr0r1p96duiEZaXV+VCo+FngSLSy86zd55crQMRPQhDUF4SFfAM78ts5m
         huOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723589846; x=1724194646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+X9amBCNGzPbKLhSrsybSJwOHCEylYOwiuwStURnpQ=;
        b=eTJ1Twstrn0kAUpmH2cEewtRcKzITy7mV2uu8CUBhszBgtGBJka5UFm61NANqZNAwz
         uA0pheTZkl42F7hOrVSVOgv9te4B/Rtkx0U+aTuiS642uxro47FBoPmFQUAkFk5KK0+1
         XUjLAipbWpWqQQp1Nbl7oxeysUS+lL/sjU78Cdfloj3IS4qTM+L/u2a9U55X3vwyoKV0
         D6+6Ukqv2gfaswfgl2rharU11tT9873DsnY4wEXp/xiMcXtlhI+uwAAxMnutZ82qZW6/
         X7xTDHx7NCur8PwRp9/aU3mUr5S0snJWFMJfHYB3SE27dYq/FGdtOLsUo7zhiZU2KObH
         3iNg==
X-Forwarded-Encrypted: i=1; AJvYcCWfPFMPqHelNkFrFaPN8lUTXFbycyiIOcogQxu3hgrtU1OZS4N49F4y+85O1prbLrVzTN72jta1/6V9vq9rVT0SttQuJH/M8diuVbDDky5hbtY5DjOy3e8dpxS4wRZES3kVJkwL9dUDXrMBvO6twmzbVvqgiqliP6YrTO1IaULmezWhpQk6XRaU4iquTKWNJZ2ydpqYsA==
X-Gm-Message-State: AOJu0YzYqcGy26rWs5mi4KaEPCrlQTwMrDEnGf9WOS1RZqPj25BoENhN
	PGfqnDYKpaqxdzlqeXN11zounYNoIaCtBSjMF3UTIyniVla/KJY0hNyAzeuX6EXs9wsAA4oGTYg
	oW6k2oq9Ig53j4+D9byw0k96DQ5g4hw==
X-Google-Smtp-Source: AGHT+IEknBc9gZ8ToZRdgOZ21NGJ7+F84SQdCx1+V9pZydDzRl629BLydncsPEzDtfoq2qbwFCCXqwGj6f5s2S5NF3o=
X-Received: by 2002:a17:90a:10d7:b0:2c9:923e:faf1 with SMTP id
 98e67ed59e1d1-2d3aaa8a696mr1183852a91.18.1723589845703; Tue, 13 Aug 2024
 15:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814085319.719b42ff@canb.auug.org.au>
In-Reply-To: <20240814085319.719b42ff@canb.auug.org.au>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Aug 2024 15:57:13 -0700
Message-ID: <CAEf4BzY56aDs3GsVPAKM0=VZA6GGZFr5ZTDYZqf_cxMQP5UDYw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:53=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Commits
>
>   e811c1ee15c7 ("bpf: convert bpf_token_create() to CLASS(fd, ...)")
>   795bc52f75ad ("bpf: more trivial fdget() conversions")
>   139dc6fa791d ("bpf: trivial conversions for fdget()")
>   2d74d8e9897c ("bpf: switch maps to CLASS(fd, ...)")
>   b57c48f806fd ("bpf: switch fdget_raw() uses to CLASS(fd_raw, ...)")
>   b7014005e1e8 ("bpf: convert __bpf_prog_get() to CLASS(fd, ...)")
>
> are missing a Signed-off-by from their committers.
>

That was fast! I'll add my SOBs and force-push, thanks!

> --
> Cheers,
> Stephen Rothwell

