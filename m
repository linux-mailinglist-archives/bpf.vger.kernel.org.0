Return-Path: <bpf+bounces-28521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198B8BB0C3
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2581C2117E
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F24515535A;
	Fri,  3 May 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwywyRnO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BD4D9FD
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753250; cv=none; b=ZcYVZfglYarJiFRNKZu5/qDtBj4DYh7Y3ohjx3jb3aV8oOrDrJATSCFluUFINJdO3BTHi97/WiiAFE8ri9exdPG4EWop6qC0dt2teaVEV2D2WjLQFkJUQZBXcza786ewGXa9ByxHpLTHnUQKY4+e2aWo14Qv56iptd1hqKFMLok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753250; c=relaxed/simple;
	bh=IY8pWUmOxSMyHnTZwnBC3vntB8y+q6btVVHWtT34FZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbAXJruH0uD48OEv/pk9FGP4ejBU1R5mJRaAbC4LEjrl5eQbT7A8EkbA2zm2QvXWqYMqgRfjlyWIgN834J5iyCvREDWuW8hDGbAJUkaLd338vCLt5Xhw6XVRXAqQoC47VAECRQ/2n6lsGSb4VYnJOhaJnC7T3cB5ODeppslqVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwywyRnO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so64772581fa.3
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714753247; x=1715358047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY8pWUmOxSMyHnTZwnBC3vntB8y+q6btVVHWtT34FZg=;
        b=WwywyRnOL1dY1Ou4cPjn0vGtfl+v1TWuCifDIjTblWT+1uW6efpwfJbOV4YSqrmfKa
         zJNTtVQA86AQdjNApGP5t1WCsKz4mxxRZvkncRgz86I2xRLcker7VixDe408Hm64sPbm
         N9kI9wSn34VMu7Y4kMqIJCJGI2JpgLLWm3UXS600Kdpi4cAfXvuoFla6XAYdU5kg4y/S
         V5wvBJp79nsZVz0MVEkqropWEH8IeBXu8AW0Y833CODGSXbI20ZLra1c6i7IE4AkqOc8
         iwD6RupepRpF5y39PHChMvxkvTtjy6ADvRV3UuJu+NPy7PTNMArtB8xiVkaDVFjj6xTJ
         YEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753247; x=1715358047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IY8pWUmOxSMyHnTZwnBC3vntB8y+q6btVVHWtT34FZg=;
        b=rslTzEI5B6ygv/db9iQNnKyPnxi4VAvFPD3uEvZOoeH6i2ymQdjA/G957KqLcOvWJ1
         An5bNAKva8Rjd48CHMsIrXKCKi4BPX1MNR4GKPD2hDm2nlBzsvT1ScdDOzetsmILzF5a
         IaCNswXXSbjZRTbuw/e0gaWh6Y+keYRwEwa2unQQOAorgxW30ftpOnc36alPKL5r4KqT
         Ye7Jn1gBeKnkcgQ2kB+12oEr1lQ545ZhakJ7jWa39mSIGLn6ZxaOxUhqo3y+jMMPeUuU
         hlfdWin9aE36LVC5CywXnWcBylRN51r9liu0I+FkUjM9FDAxq+RRRORJ3BUx5y8qNEfs
         LubA==
X-Gm-Message-State: AOJu0YwYmLbmAKWhJqmBbg/REAG9UxQoXERPL+Nd7AHuTdc6QT5CphMO
	0vOG+JZkIw3YJmLjxqKjs4y0f77P94IEwyq2ntpDNDN97VVumGw81PkG01fGUZyhoGYlirpgJ29
	jiOj7NqTQDzR8tLcRi3b/r/9KoSBw0Yvb
X-Google-Smtp-Source: AGHT+IHU3II53jLqLCXMdta30ieJ2HI7yBuly1q9fg6Y7FH9w11w6Ma4ZftLFhesCekhI4sFj0/20d2YJYajo1CNxgo=
X-Received: by 2002:a2e:80d4:0:b0:2d7:17e0:ff56 with SMTP id
 r20-20020a2e80d4000000b002d717e0ff56mr2373224ljg.18.1714753247089; Fri, 03
 May 2024 09:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429212250.78420-1-cupertino.miranda@oracle.com> <87ikzvt22v.fsf@oracle.com>
In-Reply-To: <87ikzvt22v.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 May 2024 09:20:36 -0700
Message-ID: <CAADnVQJa9h7fgyHN3sbgpPrV7Kk8O+N2NVL4pF4qbE5xf59M9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/7] bpf/verifier: range computation improvements
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:14=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
>
> Hi everyone,
>
> I wonder if there is anything else to do for this patch series.
> Alexei: Without that later removed change in patch 2, the intermediate
> state of the patches does not properly work. Eduard refered to that and
> agreed in the review for patch 7.

Sorry, but I insist that the patches are done in the way that
they don't introduce churn.

