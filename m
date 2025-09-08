Return-Path: <bpf+bounces-67739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F2B496D4
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FB93A3B44
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817113101AD;
	Mon,  8 Sep 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amgx6JbG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE007C8E6
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351930; cv=none; b=Wn0SsAIKeDgsBJbdWupav7KOsRs0wliWzI6c2oIZ0Hc9JysAsFrFTMghmWmiS+hPV8KsiZENItXV8lcAKqS0RCgfJQj2hRFi5mcIDbjZIVXfUpWVvQ4GItk5bq7oycmaJpSZSWugPZmjdIyDueszK2DBuWsTw8r6OWfRmJlFuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351930; c=relaxed/simple;
	bh=dW9+OEMjOm6envSUh0WyM+qzWWUUkWIz5pqYzHWmxck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=loTn3EJgk0t9L/zwz4N7WnTGgETlBKCsummDh6lfweOQM03W+I4mZaQDAK5hE2aIv1SRaf/79OpUPcC3f3Jr4yJKDkGeHYQQYGek9LPqodCFYBycPK6pU5ARRbGuazhtIsYP5CfkLqhMgxh45DkUUz0al4goqZbYpESuryDL1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amgx6JbG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77256e75eacso4177337b3a.0
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757351928; x=1757956728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dW9+OEMjOm6envSUh0WyM+qzWWUUkWIz5pqYzHWmxck=;
        b=amgx6JbGk+ptW1mixT5B9erri64mrBXhd/5lklPsaLkDZrub7yPN68RRg0X6hiReYW
         nlCUrtvjDvdbgDSl2uvMjJgYuRsZIgN0zwDWzbhOGzt6rhunx2Z7N1XYZSrdqqpNDS3b
         DtLGZcjmXMWIw/V90mRh/HnjpfIQOC3QOxMW5PLbzX25pR0x5NMaaVXfEPusxtRDp6UB
         HQu9qvgZE6NkaMxUoqcptrvJO+g5xlOeG3EH0rCBNqtUXdANyw0o5HfJWuPIy3IlRtmx
         hslNTlgfBmCBsbTWECjXNlkIvOsYwOJ7PkHtCTeYfNtTxr79FbparRcVop5H4Dhz0SSt
         7FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351928; x=1757956728;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dW9+OEMjOm6envSUh0WyM+qzWWUUkWIz5pqYzHWmxck=;
        b=LdN7NVu7Epvl6GMIkG9m4/t6DQSj/xjqJ/+qKvxWx2W+rVs09/IomTai0c3MkM96iM
         T00ZirfpOj4/gdDutiJezNgp0M/+R8Vl8Qb0G7jWcfTuRWFc6VTo6rfe1YvERLm6fS/u
         hhRtv5eQmPGSR6MfjwlMNJw3fYbHRGIXoVKETvHab7VpY+ww3om9+ltbza9DfZmfWaj5
         +bFy/Wy7i0NbvEDWyR/hgJiBzoqJHXVQon6zrusjf45UT1+shjGJKxPT81SAW4qyOG3O
         7SbjliigX2SHGP0cWkjd3Rb412x+1cqSJw5baYk6ENJ5l7xQpaSVqtfN8RZVtS3E8owA
         r7kw==
X-Forwarded-Encrypted: i=1; AJvYcCUnCk4HW0Q6kleI2+yFwGL56EtlHoZNQ4ekSc4vE83gfWEgJMoN12zrl+u1ooabs0TuQsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkAKc9EFSIXWBOdr4j9sRGmFyfQqq3u2LOK+VrzOXHPlIYD6g
	74OApWZdp3Ffu3kAB2kcGca6aQ74ZCI/RhQaaNrEZ0OkW4AJv0Ec+Zo1
X-Gm-Gg: ASbGncud59ghhdfkv6b8/uwWO1S8/lm9beS4GcDbNMX+EXvGnqNnVRNL9OpDxFdaExA
	bbIrZ2iruB7iHLc4yy0IlKT71WmW7ekVl2qfArwUenJlUbDvaajbWsGDaDcIHCmOJwQe4iR++Pb
	Kypw+ZyzsKUEoTWWFx93xlZ4ev+IgyoCdxT2NoANlgNw+VEIOgyS/Y5k0pyT+n2vOutrxKaZ/DB
	3WsAJhON+urgR9Wdm4fWYxXnISHWsxG24HYoMYwwpLgOXcfGxv3zP6SxOZhayIN7pANq7cR7S5F
	JSGCQIEeNG7QOQyVh11KsfAF0P7v6Sl1MbIOAZevucDlodizG8543K2IKoxZBSPvXL0jcvT6Ej8
	i+gGFf8dU1tKjoNq/S/dDoHGf72tfHPpkLj6k6aCPhFzlQvWIXoa6bnSgwo2bHpNyJvFj
X-Google-Smtp-Source: AGHT+IEas8nqwYhq+MBPxFMJ6m1+PrkHBFxiW16bMfXn/CW64H1LE2rTgFQ5y9rd4/WdO3zCxaBn/Q==
X-Received: by 2002:a17:902:f681:b0:244:99aa:5488 with SMTP id d9443c01a7336-251731194ecmr126321235ad.30.1757351927924;
        Mon, 08 Sep 2025 10:18:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:613:2710:d29c:cd12? ([2620:10d:c090:500::5:c621])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b11becab2sm181682365ad.61.2025.09.08.10.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:18:47 -0700 (PDT)
Message-ID: <4fd6d0a9bfa380a4c2422d57df058207d056bc87.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/7] bpf: extract map key pointer calculation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 08 Sep 2025 10:18:45 -0700
In-Reply-To: <07b33757-7ba7-4ddf-a4a2-3e4fc77bfecd@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-6-mykyta.yatsenko5@gmail.com>
	 <453b077245a1d42385f00ae9a30916e88b07164b.camel@gmail.com>
	 <07b33757-7ba7-4ddf-a4a2-3e4fc77bfecd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 14:39 +0100, Mykyta Yatsenko wrote:

[...]

> this function returns the pointer to map key; in case of array map, map=
=20
> key is an array index,
> which is not stored anywhere in the map explicitly.
> arr_idx is a container for the array map key, we need to pass it from=20
> the outside so that the
> lifetime is long enough.
> In case of hash map, we return the pointer to the actual key, stored in=
=20
> the map,
> arr_idx is not needed then.

Oh, I get it, `arr_idx` is a temporary storage. Sorry for the noise.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

