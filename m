Return-Path: <bpf+bounces-32536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521E990F89E
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 23:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF91B1F2390A
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896D15AD9E;
	Wed, 19 Jun 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEi2hoi5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBEB7C6EB
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834228; cv=none; b=pR5u3G6q6mlBU3V6QczmF5f6JNJKJHzMQDA+Qklr8nhhur6XBvcEWRpjGFDPJzHKG4vZw/SAj1XJd3OvrChtmeQtt9bxiyVNura90/N9I3gUe3u8mI0tNG7yvD+UaPyXLZU2DO/MECCeAx7SHy2dIjJ7dQYKc5q3Cd6Fh9OlC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834228; c=relaxed/simple;
	bh=nwt0yyf8n/ImBN1yBkc+y10wB0GTjHK564P3bo1ITtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwQoPyDOEpRGuQC9j/1qTTdb96+qLcCABl5nqVUB5chJsI6WUxarMGMcWp+ht4yrpudEw8yaM3fa0H3/rT4wlFVFet60tLbo3ikZNWSrxUbN2sGGvsx0pBcQIU1uz6g3eEaJwshBta2bT5yIiuLLoJ/MqhFQOX0kMTOXFRKYy5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEi2hoi5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so2669175e9.3
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834225; x=1719439025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwt0yyf8n/ImBN1yBkc+y10wB0GTjHK564P3bo1ITtU=;
        b=dEi2hoi5XiHS14jXlrG7uCWHBfM2tqLToUFl9f7TMghbCTSQdK8QVqYgw4VqE2/fGs
         CEA5nQ4ComaKSP+BE0GDFjWuLX+vibuZFLdw3IjZ3DPwdHPT1vWATu20tak9yV++GgZO
         wcBXn4O0OMVGuHRBce4sh4r1pZu+nhCiG3C4D0tOaI22MHqqqZfrBIk/MY72n77ET/j7
         mmkMDnBrSDjL2lKd33/IVzLHN2mk+sm+g2D3l45+TH0cdaidL0Gh1DiKAcbx2QIc3B0o
         n9DtwDD4t+J+LH2yLBL7fqlOJ5FZddGSIn756WcJFfqavR/aZ9w+wuaATjrGXj+gqXDK
         D/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834225; x=1719439025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwt0yyf8n/ImBN1yBkc+y10wB0GTjHK564P3bo1ITtU=;
        b=MVJDiQFCOywSjGUqkBJjrcuHp54nch2BxEW0tnEd3vP7xHNIHbLZ0TT1A7WftRWN0f
         rGeJuscDyo2kDHjLBWpJJ90u5+dYN29DwqLMe+XTTAO9YH9xhaZY7RpvY8R6e+5HU7VG
         yM+Y5qMbEZm5uZRKoZXD8nNOaMTc2M6rr7CMr4Es8FX387kVcSfaMaNJ9wvx2wSkTFUQ
         mBKFGrfRUquiuGp8+NWEbVyXvcvmvAnxTyV2aGFnccBOzuTBzPrJNPV6KFTE4Uoj0QOG
         5EVMaVmlBq2NMa9bLFwoN9l3R7nbUzTm9xtLiBv9rwFEcqcGQrm9ChSuc+uIx7ED0dP0
         Ta3Q==
X-Gm-Message-State: AOJu0YxIqhB6MHH1uAqBtp69IaUuO6BxP0QoJOvgG02IVnEoDjUmfY2B
	KmQMpKzsuD2K8wCFqLxPZm0vWPzROncICTcTJnY1DyoIfikSt44w9nw6E5veBGDxH6O+1KplBl8
	LiRE6tGw8EThOwfPvMT/TjH4+2b+UMQ==
X-Google-Smtp-Source: AGHT+IEfU+gXonT86vU9s6tQqm5wCaJl1mE55kAbEv2aHrr+hGlbIRJxsHlHxP8AHEZZR9tbM3SMcUUd947JoF5eIe0=
X-Received: by 2002:a05:600c:5102:b0:421:7e88:821 with SMTP id
 5b1f17b1804b1-42475293362mr28241615e9.32.1718834224550; Wed, 19 Jun 2024
 14:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618184219.20151-1-alexei.starovoitov@gmail.com> <AoWNnDQxM1Ckwtroep85ZBr0qZ3bxEBjr4uvmJae7NPMVOh6EoGAEUrS8XfhDsF9Aqa0bG7_CnTD1yToOr-mKbipj6rJ37XcSDT_UNEgqE8=@protonmail.com>
In-Reply-To: <AoWNnDQxM1Ckwtroep85ZBr0qZ3bxEBjr4uvmJae7NPMVOh6EoGAEUrS8XfhDsF9Aqa0bG7_CnTD1yToOr-mKbipj6rJ37XcSDT_UNEgqE8=@protonmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Jun 2024 14:56:53 -0700
Message-ID: <CAADnVQL-15aNp04-cyHRn47Yv61NXfYyhopyZtUyxNojUZUXpA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix the corner case where may_goto is a 1st insn.
To: Zac Ecob <zacecob@protonmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 12:38=E2=80=AFAM Zac Ecob <zacecob@protonmail.com> =
wrote:
>
> Hi,
>
> Have applied the changes - moved to 6.10-rc4.
> Prevents the repro I gave earlier from stalling, however I think it has i=
ntroduced some new bugs, in part involved with ldimm64.
>
> Attached is a new repro that stalls.

This is a separate issue. Not related to imm64 at all.
Actually two issues. One is verifier related and another
in may_goto patching.
Will work on separate fixes for those.

