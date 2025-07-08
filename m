Return-Path: <bpf+bounces-62577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44408AFBF2D
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF8317B032
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D414A4E0;
	Tue,  8 Jul 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn0H8d5u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095254086A
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933904; cv=none; b=b9ZBwpAdiv5LXi8ej6XIA8g6ZyIsXjakSoTLvqaY/gADZuZhQ7R0D0wDradJc4+O/Aozd/lQN7xmtfK7RRYsRDKJ/5jOVGmdnp83SuZUwI8nF9E6H8Gi1ebliZWyjo/KbSuuXkYsJuA5+q7n5Hb6Y8Xk1RlCQCgJb0t/4fyKUKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933904; c=relaxed/simple;
	bh=9R09jtiwjshPpnfmFTxaPOe3gARHiVfXPj1zqTA+Ro8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lde7rUYszoEkeGW6iLR2T7ddMR1agKPfAjFYxJmoQx2ZHMOGyL9nirTteje6kMyRQ3/Pf24ChIv6yvahGhrUEhlABTzSVpQ41os6oiFNGDMPsLhGSOnodMJG2Otcj5QGTZjT8/c9ESRKF82Yv33JWfved5jQmajcz+7o8djTUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn0H8d5u; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34c068faf8so4112104a12.2
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 17:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751933902; x=1752538702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uU4x2uZIufF5oSN9ILt4FnX21GXOoxKG2bCNLztJZUk=;
        b=Qn0H8d5uKe2Tg9c38yrggt6AYZ+EFQcYj9KDPNNzObHdCZhmFbE+FhSS90WfrFPRdk
         0ZzMz0NXvCwP3N5GKCAza3S9gjamTwgd0nIWJLFXQVUBG41ONABb5mjDa/I9v/QD1kqr
         2Q4OhwI2EADMNqUDWeIdXlK+g61SaeKMBDGbLCh+YFScw82HU5S2lOh/bOq0eeC1P+UR
         4XWsbZtF8H5xWDPP3dFeFheJsyu4cYTmzuURZY/9ZYPgS9Gffb/ef7Ey568PTmO29LxL
         4Pn7saBtxuJCeGZIh6zZr62kHtyVJIdW/kYkYG3RbF5l86IwXxzgVsQ9Ww9RszrJzfVe
         a6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751933902; x=1752538702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uU4x2uZIufF5oSN9ILt4FnX21GXOoxKG2bCNLztJZUk=;
        b=f+qaPtYl2bdYjATqfL95EHLjQXMOuN3DA/+3I1QYBdjuTJKyji58CP93O95/Mi1a0d
         +HIIGUVF+SdtF75hgYkevxfyaRuR6quQBEXNVzNG4YEiSQHZksQO6h3Ds0MYWfFtAuTP
         QtWcJ1YdMoQeQSgVn0niUyfnwijR4pLS687DI4HAXOVB+0NTR14wDNOhtfnJ7JAxhrVg
         Re2iaSpOo9FXvwJfskDtP0dAojLXqzqve0abjAWDy/qO0PHaAQlYevQDacXHqr5AK8Im
         qNV4ocycyZCjpY+u9eQp6/RvzME4TZcUvj0W3BtFytDI8ZL+4cdtOKXTUuUUdNEyov3a
         /YHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzzFK8izNJB/mggGmK6MuKz7a1YS+1IzlokC813prV8B6N2ULFW/ht6Ib01pMsK7ZJR7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgzjVSF20X7zc1CQXcvQMohriRyb/Fhwmiyhdn/pIFFWVqI2sY
	UgCW/qx0oC9l5CbDZeKlYTNbBRLOgPRuO/dEsWSk5pYoKnngOBwcsB32
X-Gm-Gg: ASbGnctfV+572aewAGJui8d1TQc4iV3msQdZvZtyoDHecZ0w/JDMVpu5WZwskd9i8an
	sB6Y1KcEHNQnGLQW/HCCyhn1xva6qHPhfw3SLnZHr15gsjGBVLeJjt6CM87XSnQAvrsJYzwliL0
	+5+e0QDp/dzjZ+qfQJwxZeQ32zrc7AYwhFnaB92Cj2ixUSO484prcV6wFjrBOzCQjYDKmHEw33g
	WtGiUZ0Um7toAER2aj4mVkVoGxblSFyFv8sOswhZkW4em8Ki4LEmOUoB0SodA6HTzXZ2+tJaPPf
	P5HhnuzmVSrIw6lSuMgmGv2p6txbfzXZkraNUuxiuVxmALVsK3h030KFYOoNydweyWXwYDJnQI5
	jBw==
X-Google-Smtp-Source: AGHT+IEWz91qS7zRQT43P4VZDTQQWOnkkpWVgBOo0I4g8IwvtBaDW9sj75KeRRXFMt45sTWjrwZhzQ==
X-Received: by 2002:a05:6a20:3943:b0:220:193b:90d with SMTP id adf61e73a8af0-22b439d1747mr1650419637.26.1751933902193;
        Mon, 07 Jul 2025 17:18:22 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:6ad])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429b34dsm9204840b3a.120.2025.07.07.17.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:18:21 -0700 (PDT)
Message-ID: <2dd335c0c9152a9941f42a4e70a95846f7d6de49.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Anton Protopopov	 <aspsk@isovalent.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Quentin Monnet	 <qmo@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Mon, 07 Jul 2025 17:18:20 -0700
In-Reply-To: <CAADnVQLp=ED2XAVhgO5jgSt6Cptkw6-H19Qr+s63m+jjCDwXRg@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
	 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
	 <aFLWaNSsV7M2gV98@mail.gmail.com>
	 <e726d778a3cf75e3ceec54f5f43b9d5d66ba5e97.camel@gmail.com>
	 <CAADnVQLaBuDYBoQvVtug63MJO+2=oqb9PYap8Jv+U8HB4ETe9Q@mail.gmail.com>
	 <88c63c574dfd7d3845ac4e558643ab52e77f81dc.camel@gmail.com>
	 <CAADnVQLp=ED2XAVhgO5jgSt6Cptkw6-H19Qr+s63m+jjCDwXRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 17:12 -0700, Alexei Starovoitov wrote:

[...]

> > check_cfg(), right, thank you.
> > But still, this feels like an artificial limitation.
> > Just because we have a check_cfg() pass as a separate thing we need
> > this hint.
>=20
> and insn_successors().
> All of them have to work before the main verifier analysis.

Yeah, I see.
In theory, it shouldn't be hard to write a reaching definitions
analysis and make it do an additional pass once a connection between
gotox and a map is established.  And have this run before main
verification pass.

I'll modify llvm branch to emit the label.

