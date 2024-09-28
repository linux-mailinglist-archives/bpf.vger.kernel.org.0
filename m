Return-Path: <bpf+bounces-40463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA758988EF8
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 12:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33721C20F54
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 10:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB0218E05D;
	Sat, 28 Sep 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6A/to0y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09E18A930
	for <bpf@vger.kernel.org>; Sat, 28 Sep 2024 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727519124; cv=none; b=GHrsLbTiEPNCAD/io9k37tbF6iICgryUA2U8HnUAufPp/BcVIaQoqtpll+nLYMkItg4zhjW3nxYMMBVXNFw3L90T7bPD0ercolvfUC85N8V+ofuGTp7rQlWOsd7MfkuzOxTUdhkpheWqn5dHL/QGoeb3VQ4tmU+OmssTtwSoECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727519124; c=relaxed/simple;
	bh=YkZoX0CsjmzFvfopU7hGkbnhwqnxGNEwU5Esx0GfTqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2gQWGqT54d1m8FJjvt+TLunnaZW08KdcktDSH97RP3B/WppIEfRWDDf3RPJX1FAmV2fs2+Jrs+BwFH7gIooeJzFkiXfO1zhK/v8xGrlOBz1srBnZZ5IeK9uvIpU3JmajYdFhhHsqo3C89pMK2Jp/6epZuXyX9vGT2WFAghggpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6A/to0y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so26415085e9.3
        for <bpf@vger.kernel.org>; Sat, 28 Sep 2024 03:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727519121; x=1728123921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkZoX0CsjmzFvfopU7hGkbnhwqnxGNEwU5Esx0GfTqA=;
        b=H6A/to0yt+xOxEQkkwupdS+wi94cUl8ljgyBRuta0vZihIc/cwAWHXBnaxVLdOKg31
         iYqf1ILUhQOu1AU5ZvHPaizZYr0eRuaZfsHb7oGvHKN5MRnl4KZAdIkkhrGddUBYc8UE
         qYtLHBUGOhDKJwTZi3xZuJ5WNaiZSvUlyQBly8hIKEBy0UvNXcQfJk3tnnkV6cHorYhd
         Tu6iGne9A2agwD8F5eIi2RZJ0VaHB4sBRrWz0YVyQybM30WYciq2Ukpb6xEIgYyVzggq
         su64Cd5aCdzoWVg+okVMnED0XuGaAX4+sBKi7MupG6zf3650BdqbEL98egA5g2LpNslH
         YxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727519121; x=1728123921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkZoX0CsjmzFvfopU7hGkbnhwqnxGNEwU5Esx0GfTqA=;
        b=HMMZd0VmJtTj0URN7vs6q77pjtZZwb9T7Pdgv90x1AJSgA7T1rXt6Uxbqk9ZCIVZUG
         06sKb2ZGUvF8SpPMLokWaCuLjg5jC4DTk9PheZoVaD4EnSCCWgRJ6tO9TzMtUIRfSEoO
         WiH2spoK9Op+0dS8RqccD5+doQy5/AS1UuHwDV+EDNvU+pd56Cute32TEFRxM7+g1zaj
         vpiGUqy9TV1aNec2yuyPiIpcm5dHCikLdojWkrP7zwZnySKzxFA1v/aGCRfqXYG1DDAe
         s3duMeZ3FWd5i0z39jpwXSSKokxEf7UHvCA0h8/Py+XFDCjQbykV6VHe3BEhRfBJWGyi
         bc1A==
X-Forwarded-Encrypted: i=1; AJvYcCXUPyO9UTCirSHQU43zsQn8GRc4lGk9YcFTkobLV9osu5RwCusFYsEjij4oJG7RpCTYY8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6UKZ3FcT4ST7cwowr3mXaTtasUMkzojKIgUzpZPYsTWt0YCTn
	IyTd+KJzmAyHsXdXtuAm60f6AbGVxNAbiDbA7GiXTG645itDI0Xe9UcwW9NNw3OErwPPsHcFqXK
	hscOBbMo2Q1H2P4sSbHTKnlsPd9M=
X-Google-Smtp-Source: AGHT+IFgT/XO53YfvskqZetBTTgTLczL9FzRRqwQrQ++3V2TUECN3aOxoQza6Lck3XmqqY3rou+DpjPtgx+9KUBuseU=
X-Received: by 2002:adf:eac9:0:b0:374:c8e5:d568 with SMTP id
 ffacd0b85a97d-37cd5aa9974mr3949914f8f.29.1727519120424; Sat, 28 Sep 2024
 03:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9U0OLJJYvRoSsMY_g@mail.gmail.com>
In-Reply-To: <CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9U0OLJJYvRoSsMY_g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 28 Sep 2024 12:25:09 +0200
Message-ID: <CAADnVQKda-ta8PnqcAcXy92-V0unGbs+5qbquT6-V9F4kpJk5g@mail.gmail.com>
Subject: Re: Possible deadlock in bpf_common_lru_pop_free
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Hsin-Wei Hung <hsinweih@uci.edu>, Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 4:02=E2=80=AFAM Priya Bala Govindasamy <pgovind2@uc=
i.edu> wrote:
>
>
> SEC("kprobe/bpf_lru_pop_free+0x352")
> int test_prog2(void *ctx){

Instead of resending old issue and/or claiming new bug
please send a patch that makes these functions "noinstr".

