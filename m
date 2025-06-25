Return-Path: <bpf+bounces-61558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD82AE8BF2
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6163F4A41D8
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30D2D5415;
	Wed, 25 Jun 2025 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPB+glgT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C81E102D
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874657; cv=none; b=AbOy4LwZ/uA/TWcTJTL0Di3bTFoee9IsaEsGifB5/SAHYv+d8zZ7LfMA3YWhO4EOBIBQF0YNmZnjiYxFRt7qrSaD8Fjs2F/BSZl6AWMeYPh5WOrbpVrzrsQeNMrqSF8mF+s8Avgx0G5qLTJiHHJ9SBrp56HovydSWfG3o9Dnets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874657; c=relaxed/simple;
	bh=oksZnGerC6fDfkfwReIjQYIFC+Uv/ZsYCP1wrJv9HUU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nmcd4twsA3WQngfmmuZaEwen8Pt537RZohi7QQyXORbO1J5vGm1xIIsZHEJPo5WZpkhixA1ZfRqkRZHcwjTWcHXGo4OzFQILh/cNebrf0Mek7AuZMNGosAl1BA8ahWzseQECt1xpxq/tj1G8ahfwOQ2cQR8jmupaqIhFwFw7coo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPB+glgT; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31c84b8052so171594a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750874655; x=1751479455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch1XqppMoU9ofuGwbXO861DVZROkBCQ2tWzxovMtGJk=;
        b=EPB+glgT1PGnpneVayOewgImCzA1aRXHy/K2tRbPFfZwbeDR9RLhkCJGvfyuk1MFwU
         ucScuIytSzSsaBEl4EmyxLb65tmLTGDc5LCydEAyH06sFOMub9Kn9pkOhtJJesknEMUU
         pYeX62PTKMIw2weCS4wER/NDHD3+EEK+ZwWSneVyQIO7rETn8wJmbSHGK+ihMrEFo2gi
         cv5p6LRJVHJmMQuu+BFuwPv9XvcgC2ov7LdRNBFVhSHT+qaEBeqUc1QfJr2/1FbdYg0n
         JgurgxC8zZ3oPaCuhm0bPdi8VyHgXTe1bguoN0zqJah8tgmGdCoH0AN0PzIkan3l16tq
         hUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750874655; x=1751479455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ch1XqppMoU9ofuGwbXO861DVZROkBCQ2tWzxovMtGJk=;
        b=P5l1r0amqcyhx5dP9GlCFSE6/r0boNpeuZ/seyg619GhMp1IR2i2ECsI4J+53wv3h5
         FClwlMGJBF1THwQ6EWDNBh19gcaWUM8yXwKe/wA5UlbMrBCdIk14COiH83oiIk5pWkav
         QMvXJS83Frv6A7/fZqLUKmaQLEoTUtRQxTz1c0dH2gSAuab7AOV514jTXpvEsCWTt9Ve
         7a/nls5ZDw1RcXZXroQB+1lVnVyQkt61Tj5vWKwpHs2Q/UvFdJlEMovQOrkLFHQACGtm
         JNux4tymqnuwZdE1XcKn9dwqOIUtHHJmzTPf8d9xBqnbdSbbq2MfOz8vMh+ZNbomclT3
         2ZUA==
X-Forwarded-Encrypted: i=1; AJvYcCVFcvIO8j6ITSkCprDDmaG/5SgxP+nmMsDQQveiGc0+kb5tQkiDdw5koBGCNauAHw75sIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLe/sKRo54Rh6NO9/peHWxtvu999wtXWQerbcIuGmXTDXnLeqh
	RMfshOkIkS5fLSLHnJsxjkAJa6iwhJA1lyNOtDPuFY2DfdWAVra0KTga2ft9H72/6E4=
X-Gm-Gg: ASbGncvs4/SSTvZgO3J8v2gjdN/bFhWPxTUk81d11MRkwWXQPeeH9UqV0cR7t8FXLEf
	ntFkoSzyBDh3CMZ5lL3u0UD5Xoum3eCzASnRyGD0fGxiV/M1YAMNpTMAk5U1WA4Crx8qGuLiESF
	QVDi64ROPtDjFwcb7sbbiAxIiZGEf7x6cBsLMhMDC2uZHbal20XRHhgJVQ5bZZKZxLn9Mdw91Gl
	0l+58UWkpnANaoe7hQG0rvDyRa3CWawM0w+YfQoBOYeG10L4p490KX/55g0RMslM6iaYW+/QQrG
	d1NXIItckrrQcbrq36fGGLkn5iYQD0xi/556quv9r2ZbK68XZJLT20vknmBYnFzlsO7Do0JujcX
	b7JwcQwWCgQw=
X-Google-Smtp-Source: AGHT+IFJJ27dTjpF1wHZ8byuGn+5VLJ9M2v94lVmxe0NdKQIWbWuZ2VbJxhP4wI1iudgoo+bo5uk/g==
X-Received: by 2002:a17:90a:d650:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-315f269d16amr6362217a91.30.1750874655038;
        Wed, 25 Jun 2025 11:04:15 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2bd4:b3aa:7cc1:1d78? ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53da49asm2216427a91.36.2025.06.25.11.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:04:14 -0700 (PDT)
Message-ID: <5a56993644fe6a81c1915048984f79d2cda1ab10.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: add btf_type_is_i{32,64} helpers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
Date: Wed, 25 Jun 2025 11:04:13 -0700
In-Reply-To: <20250625151621.1000584-1-a.s.protopopov@gmail.com>
References: <20250625151621.1000584-1-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-25 at 15:16 +0000, Anton Protopopov wrote:
> There are places in BPF code which check if a BTF type is an integer
> of particular size. This code can be made simpler by using helpers.
> Add new btf_type_is_i{32,64} helpers, and simplify code in a few
> files. (Suggested by Eduard for a patch which copy-pasted such a
> check [1].)
>=20
>   v1 -> v2:
>     * export less generic helpers (Eduard)
>     * make subject less generic than in [v1] (Eduard)
>=20
> [1] https://lore.kernel.org/bpf/7edb47e73baa46705119a23c6bf4af26517a640f.=
camel@gmail.com/
> [v1] https://lore.kernel.org/bpf/20250624193655.733050-1-a.s.protopopov@g=
mail.com/
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

