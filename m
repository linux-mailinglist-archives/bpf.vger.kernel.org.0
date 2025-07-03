Return-Path: <bpf+bounces-62347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F463AF82DA
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 23:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEC11C471D0
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102512BD587;
	Thu,  3 Jul 2025 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7oztA/r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F12DE701
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751579508; cv=none; b=RxmNCILRokYy1FJ91QnFqvAmXzPam9pk4l9+XGsKk3i1urrifnRAOh+iGgdkPkD1Ou++3op6f/18fH4zZdZAIEGbb1oFvUal/TbA1sYgqdbvaaASCV2MakaWZu6S3mEEQmIMh6OzQR7KWpjP5VTdLPQwJlL3cDJVhqy6ddKZyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751579508; c=relaxed/simple;
	bh=xCET6qE8uEqZmTrSEq/ls628z1kryhXfMJy7K3A2dzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m10fgI3Lwu5IFkGXDRFyZrPShNno6L/m+HA0LqeXS0ujjdYdXWzhuciT3oV163RykjaQB0ygxN10fzLweb81CmURjspgtLXz04Szy3IpUZ9XFYqcTRzXCKJpM+6W+F4YtYrVfDfzbS4+f/ZqoQ4paPHaEmuUEiLyOinbCu3shlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7oztA/r; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b34c068faf8so379791a12.2
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 14:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751579506; x=1752184306; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xCET6qE8uEqZmTrSEq/ls628z1kryhXfMJy7K3A2dzM=;
        b=a7oztA/rhl9MWZpHMAltwjiPgFdbsSJiJ7A6oXj/q3W/Bc+/F4pZF/uxN4Ycvwdgg3
         kXIId8nJzwkvZ53GnPUt2JGeRMXTCJgTC+JAMGWw4kVxME9XoG9T8cgpHNoZoIUalli1
         OgQmwK/fQ3RmJ4/HHa2zpNRCHZdr89KbidjSOR1gKclJF1vnQRijRKaygTB9Iq+vVRNq
         +BVY7QGSIfLMLJMWZW4TZP8Dw0j8g6g0M+EKQz2JNVnNWerxEhEiV21JMFQ4LTD/1Fc+
         kdf5ll8bv2KKWVN3lBIjrHcapZf7RUvOLMMGAoV6U1U/ZOlwbMhEkOD1OR/BWgRynK9A
         2BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751579506; x=1752184306;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCET6qE8uEqZmTrSEq/ls628z1kryhXfMJy7K3A2dzM=;
        b=spvNaTdsNA49ZF+nQ66x7QsC4Kpa2Nncgfrri9AUWxIA8bPu6Kf2DndjaYPbHzBlLi
         xSR2/QmB2k+Lnmv6UGXbdtWQbh8Werbid3XLexkBIQSL0zXYhKvCBMWh8nUX1SAKndAv
         WDpMlP5esZn180ViLB31tONU4gn6UXbPbf0XBxykEoplL3bzxzVS9+DS3u9sSHH7qVCz
         3bwxFRRYZunAO3A3Z2Udv0HOGDHao4+wMFVcUG0jX1/XzgjAIfQT7aRP/Cx1SC1X6lYM
         lJx4mFakSp0Fx/rlUzIUodQSintpv9Ee5Arqt/ReFcrZsOcmgu0inna9WsY8hN9wlVoH
         UdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDBdnPQCKLcK7wZOdncJ2Iq6nfqAGjo4C9/JErnNfsJSqUp1GOz1ZEZMKw/1uQ9QN/1wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI49B5sT+i48BlYIB4vA0EGnUityYNWTvcRaYMa9WaUpz2lUEj
	fcDrvL93vpKahljdgq+fn1fIxHvJhXts2NDp7QG2bSjpTmqkDfl1FZro
X-Gm-Gg: ASbGncuIiiFcNLeSfO0AKHsJ/TsQHIEO8OPrhrJHQ4MznqRm2NMEEdmongLaGzQApiq
	7elbLEBnLqpUqdhRePAhZM0LRiYDMJ3r30UPHaYbav1bCWZEIDknTDeqx9RGoR84o/z7Vh1Mzzt
	efDVGpNF+k8WiU7bZsJiVaSTOKBFFiNMaDXkKEx5f5okVCCUKRMspB7LKl5FZeIpr2HbtVduajV
	sQm5QInjsi2L58G6jE54SjgHKk21hplCPFvXVgAVEnuvg/wDQEK2xo7//TLd37WfhP2c+j7aBWl
	whFEmHQy10QByIBEeeqJu5dz77uCjIAGg41BRLwJikuCHqFc5Z02aMALaBrPp2boejTp7wMAWL+
	guLg=
X-Google-Smtp-Source: AGHT+IFfg5GDFRGCmrXA13cHXdtaex8+FVwCjJXUr/+GSH1UC32voX2LwuObvXZEZc7MOq99JFnpVA==
X-Received: by 2002:a05:6a20:6a1c:b0:21f:7430:148a with SMTP id adf61e73a8af0-225c07e31d7mr409058637.28.1751579506463;
        Thu, 03 Jul 2025 14:51:46 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:90c4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f3d0csm466844a12.38.2025.07.03.14.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:51:46 -0700 (PDT)
Message-ID: <b30b2404c40fa170c13ec1750b4c00d0480a582f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Avoid warning on unexpected map for
 tail call
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>
Date: Thu, 03 Jul 2025 14:51:45 -0700
In-Reply-To: <1f395b74e73022e47e04a31735f258babf305420.1751578055.git.paul.chaignon@gmail.com>
References: 
	<1f395b74e73022e47e04a31735f258babf305420.1751578055.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-03 at 23:35 +0200, Paul Chaignon wrote:
> Before handling the tail call in record_func_key(), we check that the
> map is of the expected type and log a verifier error if it isn't. Such
> an error however doesn't indicate anything wrong with the verifier. The
> check for map<>func compatibility is done after record_func_key(), by
> check_map_func_compatibility().
>=20
> Therefore, this patch logs the error as a typical reject instead of a
> verifier error.
>=20
> Fixes: d2e4c1e6c294 ("bpf: Constant map key tracking for prog array pokes=
")
> Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> Reported-by: syzbot+efb099d5833bca355e51@syzkaller.appspotmail.com
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

