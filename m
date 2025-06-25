Return-Path: <bpf+bounces-61578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C0AAE8FB1
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E727AA0FB
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B7202C30;
	Wed, 25 Jun 2025 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIvS2SEN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35953074AD
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750884673; cv=none; b=UrDLAvCjNIkIYb/jjPrmAcVQh5RrI8UaptelwGg8QGlgKlvxlL1ZunBomqtAvI6ErdBz1viYsBkdnqSs9j3tpuTegvfpOVNMhVcumbxTqgvNq8N3wW2ipSOiuzItfCq+2daRJh+F4JZNeL4YXvi58KAoYFz17pGprhh0JGGQfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750884673; c=relaxed/simple;
	bh=0BeaTWSo0S6xOdX0XZUILXulGZ99w1DIVvWagVUCcjw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l3vU6XW4C3iyMnot1hi+9CR/Ir9cFIBwAm9zgWpRCU9cSIjAC9cFwLqSMviOlT2p0Cgvf5MptdqjAc2Ri5Cr0VAZ+Bivc3uulIXdKULLR9qPzuD+xpXqMPKBQxOngq2jegwSUB818t/FgJ+fhOP8GIIHokDzq/fVE5yoB+Ybke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIvS2SEN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-237311f5a54so3778405ad.2
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750884671; x=1751489471; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BeaTWSo0S6xOdX0XZUILXulGZ99w1DIVvWagVUCcjw=;
        b=eIvS2SENpLAxP071tyU9GCvfZfcZIDQ/UPeodohxesMYnP/J4Pkjex+VZX/O4kvk8R
         YhenCs0m4vB80uktEjw6tmX9frgy7JMbKbt42ssvrts9NMXZ5eRExeC9muvTs+Lpvoff
         VwJstz8/7rxjE7fV4dlE2Xeve4h35c5fGB/2p4BCUq2GwyN8nlTAuM4tK0dZ+wp9WBGC
         E5Y3Eb1vxPLVyAYlMiBd35O57wiMQiXE2+FrFOJUTZhy4G00YREhso+I0wwTPVShxGuB
         WN2A3fE0h7rEpF5LmwdhkjrJWpZ9dqTkPqn2HGCPA1oNfGLac8eBz2rU3wokNsxA4ftg
         Uu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750884671; x=1751489471;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BeaTWSo0S6xOdX0XZUILXulGZ99w1DIVvWagVUCcjw=;
        b=NfhWxQgZBwMpdcH5glWBb8wvGczNO1GCS9FeR+c0sCa4RNx0cWvXazQMXpX6gjvrvV
         4g5APWW9Pj6B6sxhaZQqedlw6+SJ4bFSn7pNHXUOKFoSZgep7SzUjRjGQnGkIOtdHyd7
         Y4CU4vQBBSZo9xhbndpRgmqUqMxFU+uo7rdRgDZFh+P1lDYmeYI91bsTF9iO7UPw32WK
         IYrD+DhRLaaz8sCPeWq1UOc9MxXlKO4KiNbo3UffO3+b35rHRVqi2Bj3yLGTRXChSOet
         U+uZkGXNDzncF1AS8/I+163JKCMfK5+rRVhhpmqdcw8aNWzo2ZpIgayunEZLGjdombnK
         D6HA==
X-Forwarded-Encrypted: i=1; AJvYcCUjrHrobi78hrBLyFWsUi01c71e7S3+SV4dLjbEppQ1D5h70kNH331pLTHcUByg9iX1iXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSjCnc25aq0boQG3XSDysdY1UD1poePDxGXoOL0eEkcvWbKbW
	dXoEO6Edc6cWpnRJtMTksZWh6L37uwOYlFfYLxwdxWDF+s5/nXDv1lC7
X-Gm-Gg: ASbGncsh9wVitvf7ei9GxKrgQhViD+B9/isrsb/KrDxBz2Dbq4Kn342Iqw6cZr3mePh
	LLDKMICZ5EqLY1Q5ez/BQR88WCNy0mP1RIJdUWO4UfrVIGyWJ2D6ismgsJanu8HaXCgRb/kfqIB
	E70/JIBEhFL5NrAu7nsHuyyMMwAB2ExSqqJbCIDNH2q7h3cZceDt9TofkQUdtyUYSQ7pQ8iUGk9
	cPSEN1ZhENd6PDT/0v+Rm+cmQ3TPWUzeP2/LZ+xh1XloiXf1KD+8WSTO5CZE7VoJWmxKcHc+HaU
	oc3B0RptC9GzWPm4FLT8pSGSD4DHJShxBKqmf8O4CpE3f23Q6IRRWUYnAna8Ky9EerBHYls7F5o
	4yJuXOP0PUgM=
X-Google-Smtp-Source: AGHT+IH1dwLT9azV3+Mo9IF+Pvh9PDemObDUlWFPKSev3q3OVVqcaSGI0tFeEktRXk7lexOy2LFjXQ==
X-Received: by 2002:a17:902:d491:b0:235:737:7ba with SMTP id d9443c01a7336-23824069f92mr84051245ad.44.1750884671079;
        Wed, 25 Jun 2025 13:51:11 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2bd4:b3aa:7cc1:1d78? ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8674544sm137676475ad.167.2025.06.25.13.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:51:10 -0700 (PDT)
Message-ID: <b30b1790b51fb11afd666d583ce344e450447cb8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] selftests/bpf: separate var preset
 parsing in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 25 Jun 2025 13:51:09 -0700
In-Reply-To: <20250625165904.87820-2-mykyta.yatsenko5@gmail.com>
References: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
	 <20250625165904.87820-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-25 at 17:59 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Refactor var preset parsing in veristat to simplify implementation.
> Prepare parsed variable beforehand so that parsing logic is separated
> from functionality of calculating offsets and searching fields.
> Introduce rvalue struct, storing either int or enum (string value),
> will be reused in the next patch, extract parsing rvalue into a
> separate function.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

This patch is the same as in v4, please don't drop acks.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

