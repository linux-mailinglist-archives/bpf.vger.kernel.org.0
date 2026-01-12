Return-Path: <bpf+bounces-78552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 212DED128CF
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 13:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30FAD30953BD
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17011357729;
	Mon, 12 Jan 2026 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OitieGXo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZI/UZ9A"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE730EF94
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220903; cv=none; b=kANT8SG+hS6PdSCy76KB3zva0MxsQI20wuTbFkXZ3wRoFIM62RDuOXZ41hMcx7OxsJwJSPAxL3rjnItKZEwGBg/2BS3HjVktY88LIeYNqWkCuuAdYKmtfFH9bC5DrqvMSTInM+D4c/ZxubMHNHu80M/8f8p8PepyAp7CD1G4gRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220903; c=relaxed/simple;
	bh=ZjjehrJm5YvJWy0YeRhJWrcroDFcZTvx9Ps9iyiwLNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+OSxrbfbb17CFloBegcKuyQrLQSgVvzfvoBhe3KqYoxX+ES6ZNijvKxSI8P6nhOqmlJx0Eaf30K1QPQH38fGVh+tSIz5rkK3lvWC3xD3OvbOAL+d7s2nJbRC31duyuuv5SZZVvxor4CVzrlW9Yii9/gWt84lJGfEVD1vpXxw/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OitieGXo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZI/UZ9A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768220901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjjehrJm5YvJWy0YeRhJWrcroDFcZTvx9Ps9iyiwLNg=;
	b=OitieGXoR2dyUtmIK9X9By0jF5SBjj1/HBirgT2J1iAqA+NtLhrkjjGG+kQoWdMEM4VyhN
	3ubE0d7E0sKQaVs0e4T1GmoC3X8Bkw2PXQKzg8cOzViFM44S62kFl1h1lm/MumcUgMJD76
	10+8Y3qAtiU4xi32PKiNAcazwliaHcU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-6WVjany-PRadkO9piOS4CA-1; Mon, 12 Jan 2026 07:28:20 -0500
X-MC-Unique: 6WVjany-PRadkO9piOS4CA-1
X-Mimecast-MFC-AGG-ID: 6WVjany-PRadkO9piOS4CA_1768220899
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b870f354682so130174766b.3
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 04:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768220899; x=1768825699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjjehrJm5YvJWy0YeRhJWrcroDFcZTvx9Ps9iyiwLNg=;
        b=dZI/UZ9AkrDOkVx3zzCQxvP21fG68W5OEe3sbO+YeRPnrMaghCAl6sQHqqiT1neEtU
         sS3Fv6vfTNg+BctlgYigw5JSw9G/vNwWptjkBHTmnT6VcuS73Wgst99xwAFROj9PZwKa
         D3tP9FEQzOL6Nvy/CPaxSsOLifwOB+FUjdCtEGYgqTYir01tKjsiajw15Dl9v5htVqge
         5TbGD3eLLInRuuAPi7QYOgJo3O1CeQVl47TczKFWCqNo6U5BMOzoYMOPrkm0RNd/xKjp
         Wi/ucQe3WSnerUfWrYz73ziAyxGSqkHbI+HA1OaJhN2AvFEoNzp+UorPPaZQEiKIBZhh
         QIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768220899; x=1768825699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjjehrJm5YvJWy0YeRhJWrcroDFcZTvx9Ps9iyiwLNg=;
        b=s8Bg4HV9OKu61zqXyFZTsdyvOSZysrq4pS02cpsxsyBGnGUFTOVKU2KBm6Te+Ei4uA
         eIuceiy8AoyGDzFFYrV/Mnsf0TbkgbOycKPIs2TEwN8IUfwiCGNjXHAfNsronFCaJGK1
         mBo8aGCcV3AKFsQOvWVuyfPvuvldXQy9atrgcSCmW12phfblxNQjgkXVXt3jE4FWbHnb
         yh5NZwaZl2m8KbcVufUpPE1vM2p2PZ5eAadHxTXLZACPoSFclJwRM/z7RiBZ91gs6YDG
         HpZUTYUK/KQHstwx8PrCHrxn0ExOdrK3nmFfFubF1PHOcA6igsHct5yj9nNBSSUpC0Hf
         FTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTHZs3ssnemacVU0rAkTY3u5MMY/SyFFCgEwgor6P9m5EaZxHaszlQW687uCsvtKuBDJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmScUnrcG61+S1ww1504OWZucYmdUhwtxDwFseo7DjDnXxXVkx
	iBxHwcAv0044FtO3QWQIjslSkN3xES5cGdjt0fF4feBkuPe4dNVsmrYIw7NfV4JCzdY3u46THNd
	2dkiF0LRFG3QQMeOeVyUihpKnZJv1BPLODvVRaGwjMbwWxceJwjFOhymdgb/rVwN5kvyTf5y033
	S0koXURJmPYBPCQxG3DkYpglKVTyge
X-Gm-Gg: AY/fxX7F2X0RlBUOVrwCVjuefzuJ7LRdE1vx7IGaCEIzaFKaVo2i720p2yNxzfPYU7+
	RTakNLT/cM+kIE379oPu3fCCgCgAiH7SkHa1HiGy8q9Oa9ZKTWJ0t4MBMW6Lt0EqUwkFFdU+HGo
	g6OM3Ngv8Q3zvb8X7oZrblOWeNP04sm7lPwIRlu0IC6huIb03+hkcyz8bTEhLe0KcL469bpvjFL
	mxu9GGoUoTfDUl2u/SMAJvKmQ==
X-Received: by 2002:a17:907:1909:b0:b86:f0b4:4976 with SMTP id a640c23a62f3a-b86f0b44c56mr573658466b.27.1768220899052;
        Mon, 12 Jan 2026 04:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFswMhcaHCw3o3UBsbFMxIsdjmuUM7j7qYcyxN3WtQSvf2wJR5Jo/bkWE4JrCNTd2SOgC9odjfanUv+fLzqSMs=
X-Received: by 2002:a17:907:1909:b0:b86:f0b4:4976 with SMTP id
 a640c23a62f3a-b86f0b44c56mr573656666b.27.1768220898689; Mon, 12 Jan 2026
 04:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-5-wander@redhat.com>
In-Reply-To: <20260106133655.249887-5-wander@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Mon, 12 Jan 2026 14:27:42 +0200
X-Gm-Features: AZwV_QhSoEhFvhmXOHxU3fZBzDEjolu2gp5vszdmYsYri4aeAFvaXLiGhbGBWK8
Message-ID: <CADDUTFyEJxLHKHiaxya5QxW49kzWdhj=hzTygQYa9JPUOe8Zgw@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] rtla: Replace atoi() with a robust strtoi()
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

This commit breaks parse_cpu_set

./rtla timerlat hist -D -c 1,3
Error parsing the cpu set 1,3
Invalid -c cpu list

./rtla timerlat hist -D -c 1-3
Error parsing the cpu set 1-3
Invalid -c cpu list


