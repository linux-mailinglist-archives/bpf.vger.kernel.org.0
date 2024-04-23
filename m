Return-Path: <bpf+bounces-27585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CC8AF773
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 21:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443491C21E88
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 19:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB11411C7;
	Tue, 23 Apr 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngz0lt4Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39821DFD0
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901072; cv=none; b=bKS1hS0Hf1i4m4Dx/XUjCUn0yzWd1IeHVQm5xLsrtXpQ4gOMgUJLFlKDryDYmnYc1Mcla84p9fM0ajGxAJITgKOALe53Ih74U03V+wzNnRPWFdz0pgVS/rI5868DJ54OCJlo1iFHVaoAI2zviPA8WG1YP/HkjsKaEd/MqYLmGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901072; c=relaxed/simple;
	bh=v9SbsjyhzhjwcOcCqyudGLl0V5x/J4wgYJOh494ToTE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0Wvv/Q27sVXQ8euIIwl3mjLAL+3xACo1MAAaettnU7xfIvOKnwkg6JVE5QBeqMqbG38+zWFV2KDrSozH3m+4XVQ4LigDOAznJ2P5LPzbXuXj9IvKw8c6dirF7kOmx1M2zZ9dnH4251zSSuEnV+2YlwHwBsxSgpUljNtTOlCKoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngz0lt4Q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e5c7d087e1so49387115ad.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713901070; x=1714505870; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v9SbsjyhzhjwcOcCqyudGLl0V5x/J4wgYJOh494ToTE=;
        b=ngz0lt4QUjwHyBZrwZEpZuDaIiYcz97mwf0jzS3AZ5DSsJVnmi2qPstwr2h9K8chT/
         GEb1ydOtzFoem60exoHRixdwA4cSMTJlWbRwtzEKvkhTKX3BfjUQmp+3V7aIpch/wGB3
         O3C93lBvcwmPZFQxmPELPmKt0dGF27lRmtfLLI3qBzGdcT8Us1t363DWacduNZc4Ei2m
         W4TnmNB2O/ZK14BLncnWkI2MX9zQVysSP6LThEWgrXGKlravrzAgSzJeuA7YsOCABHZQ
         Uu5ByZqZcPwg3nwXzYUT9kuweaA/nEFSwPjq7kJZZkIiQ0rJNPduB6IIqKu8Ogl3T6Eh
         Zfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713901070; x=1714505870;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9SbsjyhzhjwcOcCqyudGLl0V5x/J4wgYJOh494ToTE=;
        b=o8s+JMJOWWoMfU/8hTm49XgIAC0vvVXdYkpQot3pXdyc7ceMFBumtG7eIdqTlu6xOG
         VZMH68v5dbDB9A0eBC7Ter3jpG+NfamAokUWJnXQ27/ClDBnu1PiDk9JGvkCwYLBUNS5
         bOtPtB9xjqIyLf/eiUfZSxIZ6cHj3TY3qN+dM2V3ICvktB3NEQUTcrRY4U61Z9sHBKSi
         xd5IY9dkZsF/T2D9EqCeL2yOLenfejMraPmfWwZWfrmS46rV5L5/DHUSIJyiE3ikMtzh
         SvRygdexSdh3cER+SzQjKkFI35QkxD7RriPshLnU0XZ40IFQo4aGPRaPE1G525JjNf7C
         U6pQ==
X-Gm-Message-State: AOJu0YxpwIb8gEzHg/fs5D9vOgvmuBBlJFyY+Zzh3nnY9sKpp8ARxTZY
	RU18kikw7guCzVpResZnVNRcTs+rQrKeIfIpATl2oRlZf6jVmmDL
X-Google-Smtp-Source: AGHT+IFiAE9q7PMEP3ZmV52lL/zErsK9ZhSbTqWCblH12rVO+8Z/W0sJFDkpHnHS+Z+hl3kisA+Z+g==
X-Received: by 2002:a17:902:c943:b0:1e0:115c:e03c with SMTP id i3-20020a170902c94300b001e0115ce03cmr623953pla.53.1713901070114;
        Tue, 23 Apr 2024 12:37:50 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:74d0:ee16:7cb6:89ea? ([2604:3d08:9880:5900:74d0:ee16:7cb6:89ea])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090274c800b001e28d18bd52sm10422720plt.232.2024.04.23.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 12:37:49 -0700 (PDT)
Message-ID: <bd151667d1afa40abbcf5df3bb8044ed3b51b2f8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf/verifier: refactor checks for range
 computation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, David Faust
 <david.faust@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Date: Tue, 23 Apr 2024 12:37:49 -0700
In-Reply-To: <87wmonzxav.fsf@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
	 <20240417122341.331524-2-cupertino.miranda@oracle.com>
	 <f347d6ea9a0d8ecb77fe13a89470195735c706d2.camel@gmail.com>
	 <878r19k812.fsf@oracle.com>
	 <047c972f71bf89a7d4004f1852fe498d3e2ad010.camel@gmail.com>
	 <833fde942383aa4b306ee0ef75c1a5ebf212e02b.camel@gmail.com>
	 <87wmonzxav.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-23 at 20:36 +0100, Cupertino Miranda wrote:

[...]

> Sure, I will prepare it. I presure the patch should be the first in the
> series.

Right, thank you.

