Return-Path: <bpf+bounces-69909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 688A8BA6436
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 00:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36021894B90
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 22:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DE32367D2;
	Sat, 27 Sep 2025 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzzyqiw6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96E18DB1E
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759012406; cv=none; b=o9XSm2vvtX4VzRiyN3Eomo08oF+v0iY14tEtbUrevdFtqSwku2LjHYS3KEN9aVwcPkwEUcLfa+L3WCJYHarRB7h/cuEPEvqWGZ4bmacdQ1rbrdv8QJqMSLNwkv74JBxoVeEmG0/gM883UJzwqAxYw7Z1nesenugWvBT1PV8CddQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759012406; c=relaxed/simple;
	bh=okSoG67AVrqwQgRDUVgLSQHl4EEy9sXaZ6gvaK1fRr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0+lUa6Ehk5vEvb69qBMq4hY5AgEsFmuiQ3mUwf2bb+S/clFz7kdhPrxt4TNG6U6p3g+JpnQ/GmeSNsYOgIsIIbq+DxPZw8aGr6xdxFOHtj9l6Z4Lo2ZrYTNurY6X7Rwp+4383J5dBGO0zq/F0qqyFt/ExmbVVGVUOJNJWPKGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fzzyqiw6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46b303f755aso29911995e9.1
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759012403; x=1759617203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+r8GKg6ojoggq3b5ZSlvwmzwsCqHsWdwX0u8H9jkcc=;
        b=Fzzyqiw6clbnrSBAYQoFVIFqoNSOOy89a2NX+njLZ7B3z+qO5yZ5xRo+bVZfWfxlwv
         RLGShwe4rbKgIF0oimq/UU2fIqwsE282rW3CRgD1em4/ajuy4f87hvg/scxNU4Nu++cn
         tgYiSbFRMX8AMokI+T/WS8IZBinmY7RxB6CJZKFsMEXKvIK87LXzMap80FbfMGTK2BMT
         yY0oQW6bbnHZZrRN/5TbWBXDKL3DEWwdTX/Wid5AIYCO5wYaYgSFXazkwAADx9NabNgk
         DxRKz7z3gR/eWEdttWqYc4neGACAcsxQWLH3ln9eNSrjkCndgS3WRBqfToHQrHf34Jj6
         BrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759012403; x=1759617203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+r8GKg6ojoggq3b5ZSlvwmzwsCqHsWdwX0u8H9jkcc=;
        b=nHC1YcLi3W+F5KlucsRjnKaopTwBZemCGwvDwQE6+AUc6eeHgXPBoSOf4Rj2l9tilA
         RxQf7wHznCbpwCoxPJvGxapp17c4LVjpFhLGEIVXep09ZIOqnhM6NxgpxLdjGnRsLXSJ
         TUjvzaTawuAsJXaz3OMhhnspgeLuu3znyhsGBClyc2u9tKCzMIG/0LLMFzC5BTUQz6xG
         GC4SZjxL1yXMp2cusFa0Smyd0U+RkoAGwY3DBsbPFZdj+0WtbrlRac30lmtNlzwAHSQE
         K7lRg26gkRoWIhmO8Uw+Jkd75oghOJbpV1fgPYnIIeobAIE4uKyktkd5tO6g3aUs7r/F
         meoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX35ZGYyc57+88jhrZ07jbg8iaadZ+gtkbC4yQQLHEwVCQSYxnzfAaaFHhNXljpTniJdFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzecr+5RRul9dPmsqeN4iek6KqWudLHfOHqAooTwo6UHiF6+kDR
	+aq1ZmWNa8O0SHHx4jKNRQho4P5nTRey4y7pQZ1LL/sRmvLbAJMm+sljfjz1ipf9nsePgceqQ04
	F+y+Ojlv46LaKgiPrzb0rXe6hDV5umZo=
X-Gm-Gg: ASbGncvOtlylq42O0m12aLZRQeeEzKBQXdAU2BROH1aHaKlPrZZvpftLAQtxAOprVeo
	u85eP+D+dk7TuCW70flmo5DkvlIfVfb+wkR/O7EApuKYtNv98iI9pitEpjUJUB8FmS5x9erjcNJ
	IQ93xIjt18LVd0WtSggzDfI5PWR0ctMqJinE/4nSUUpSV+AOSrQ6aglWg/7glVLrTF5XdgOW/zp
	FF2/al/e9yQ0XkU
X-Google-Smtp-Source: AGHT+IHlvY4jduOUJxngyjg2fpYMtY/KoN4vYBo2gCLH9NW+PTBP86xfLcfWyKXfuJG1gXmEWJ+rAOk3JufiofvxzkY=
X-Received: by 2002:a05:6000:1861:b0:3e8:e7a6:e5a9 with SMTP id
 ffacd0b85a97d-40e4ca79e1bmr11210982f8f.48.1759012402988; Sat, 27 Sep 2025
 15:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921133133.82062-1-kpsingh@kernel.org> <20250921133133.82062-4-kpsingh@kernel.org>
 <20250927210345.GE9798@quark>
In-Reply-To: <20250927210345.GE9798@quark>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 27 Sep 2025 23:33:12 +0100
X-Gm-Features: AS18NWCpnMoezfM_ulk-gMxklejFWtM936-2X14gBfp3bMxRAfH64BtYGnYtoQM
Message-ID: <CAADnVQ+t6JJ9YgH_xgicbzvvP2WvEJWxi+hioQtFKrR6BLTsCg@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] libbpf: Implement SHA256 internal helper
To: Eric Biggers <ebiggers@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 10:03=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Sun, Sep 21, 2025 at 03:31:24PM +0200, KP Singh wrote:
> > Use AF_ALG sockets to not have libbpf depend on OpenSSL. The helper is
> > used for the loader generation code to embed the metadata hash in the
> > loader program and also by the bpf_map__make_exclusive API to calculate
> > the hash of the program the map is exclusive to.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> Nacked-by: Eric Biggers <ebiggers@kernel.org>
>
> No more users of AF_ALG, please.  It's a huge mistake and has been
> incredibly problematic over the years.

Lol. True, but good luck with that. AF_ALG is uapi and it will be removed
only when the last user retires many years from now.

> If you don't want to depend on a library, then just include some basic
> SHA-256 code, similar to what I'm doing for iproute2 and SHA-1 at
> https://lore.kernel.org/netdev/20250925225322.13013-1-ebiggers@kernel.org=
/.
> I'd even be glad to write the patch for you, if you want.

Yes. Please. If you can craft sha256 without external dependencies
we can certainly use it.
Certainly agree that it would be better than AF_ALG.

