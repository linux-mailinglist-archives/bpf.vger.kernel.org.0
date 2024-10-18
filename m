Return-Path: <bpf+bounces-42399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A409A3BAC
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DB5281A48
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 10:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5831920110C;
	Fri, 18 Oct 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVtpgpR4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590AF17E00F
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247767; cv=none; b=IlFhjCTHBaPGoLqCoYtVa8q8Rm3lFKPhmEf9x1HMl9eXFogG8LBOzJGnmVkJBCqQmaFiHq6pYSzrWxcZ7F9DaC8zanYDUjW+pcAIw0zMUVcjdOA5nqWvkjiB7/kp94sgvkw0+qDpQY/oEFBWqTjCiMyHuTo9x8rgnciu/MOGXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247767; c=relaxed/simple;
	bh=MYW6dbPyv1LA2KO8BAnlhzC9LvUw5Q9ucfBBjD7XiEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gwXwetTTYQVsEVBfi3niV2SgoG0pWfPxXlNagVUtKhWs2txpdeUocLXw0dzNh2w8FRHni30MC9/Y5tQLIWKJes8wkbrPO24OedjrUhCvq0HYzK/W0sHQYyFVgtFKA0goMZEXl/mGG3KjoYH0jqTdeSt4HYKSeT0mZkK2fwLLbJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVtpgpR4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729247765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrTOHGvby1w1ZPMwlyiQRBjU/VK2YYsb8ixcq/NW7Fo=;
	b=bVtpgpR44/PQeUdRaeIStfyeh6EYyZNpO+vVNQgqZUnMzQixz5E+Y/Wb1TnOSrBiWEPAVu
	PwnA6aHGLIsCVFi9qjgk5XcDw6JdCFM9LmZchB+K+jvbL4Z4yhq4W2t9vSC0RRrb8wgRlM
	63fRKJRm2bvWKkEcperSG371zNS9CSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-i6_W2dOMNe23-5uY7IAxoA-1; Fri, 18 Oct 2024 06:35:54 -0400
X-MC-Unique: i6_W2dOMNe23-5uY7IAxoA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43154a0886bso12637965e9.0
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 03:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247753; x=1729852553;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrTOHGvby1w1ZPMwlyiQRBjU/VK2YYsb8ixcq/NW7Fo=;
        b=jh0snl/5BuoYcDPQebj6VxyfwZWrHNdV1EMo0TocXLkxyY6Kiw6aCVehWf/mFSC9Cs
         LScS1c+ykL7fS2YMcqZcP4cj/V+gNNW3+KrRSX5g0w0xWUYHoM21BkT5b4nYTyRD4U2q
         xSliC1Seiamy50OsMpT9AWQHlDiUTGqR2MZkvrMp98ucN8ydtgY3yFyYc0NClam1Pw+o
         qPF+kuyHtWKwzB/10yGcOaEN4PvRdFMbuvJRIb64vxGGw6xidHPFWkOkMKYB2SuLHkce
         dMq9x3aqkOKCJkA9ZX5wtd6VjDcs2gVfLu+BTTthe8Q9zKy38HwfWS0pQoVNo2FcKSr1
         yTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrrgkgJ7oWlRq1SLgSLalBvZcw2YKsbhlGHo6tbNyTZv99KAfCz7uO0ZFDaE3o47cCAJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kwipsjtSdrSdd6sAVIMJpOlMA+3Prfedd+hobDaZbO4YejfX
	Pv90RXnKfUGv0Un4NuXMR+tLg20sHUIwkj03UX7Q6kgoEcxgSCNxmdax8LCNKrHxkEb2TSQijd9
	mn4OFwrexYaNh9LRTMH6opoWYLkXWbIE/tK4xSQruOOc+aea8Iw==
X-Received: by 2002:a05:6000:c81:b0:37d:52fc:edf1 with SMTP id ffacd0b85a97d-37eab6ec059mr1250837f8f.58.1729247752871;
        Fri, 18 Oct 2024 03:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFugxrw1zdOmWyzIUEN18vLVXOK89+UGpHiLlPe5ww0HM+JYH2Pkhn6/X2q66XMH9V2lOuQLQ==
X-Received: by 2002:a05:6000:c81:b0:37d:52fc:edf1 with SMTP id ffacd0b85a97d-37eab6ec059mr1250799f8f.58.1729247752374;
        Fri, 18 Oct 2024 03:35:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf06922dsm1569144f8f.40.2024.10.18.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:35:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 97D28160ACB6; Fri, 18 Oct 2024 12:35:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Simon Horman <horms@kernel.org>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH nf-next] netfilter: bpf: Pass string literal as format
 argument of request_module()
In-Reply-To: <20241018-nf-mod-fmt-v1-1-b5a275d6861c@kernel.org>
References: <20241018-nf-mod-fmt-v1-1-b5a275d6861c@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 18 Oct 2024 12:35:50 +0200
Message-ID: <87ttd9y9yx.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simon Horman <horms@kernel.org> writes:

> Both gcc-14 and clang-18 report that passing a non-string literal as the
> format argument of request_module() is potentially insecure.
>
> E.g. clang-18 says:
>
> .../nf_bpf_link.c:46:24: warning: format string is not a string literal (=
potentially insecure) [-Wformat-security]
>    46 |                 err =3D request_module(mod);
>       |                                      ^~~
> .../kmod.h:25:55: note: expanded from macro 'request_module'
>    25 | #define request_module(mod...) __request_module(true, mod)
>       |                                                       ^~~
> .../nf_bpf_link.c:46:24: note: treat the string as an argument to avoid t=
his
>    46 |                 err =3D request_module(mod);
>       |                                      ^
>       |                                      "%s",
> .../kmod.h:25:55: note: expanded from macro 'request_module'
>    25 | #define request_module(mod...) __request_module(true, mod)
>       |                                                       ^
>
> It is always the case where the contents of mod is safe to pass as the
> format argument. That is, in my understanding, it never contains any
> format escape sequences.
>
> But, it seems better to be safe than sorry. And, as a bonus, compiler
> output becomes less verbose by addressing this issue as suggested by
> clang-18.
>
> No functional change intended.
> Compile tested only.
>
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


