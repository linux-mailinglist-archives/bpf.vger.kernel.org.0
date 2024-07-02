Return-Path: <bpf+bounces-33671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F779249BE
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDFB1F2214F
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88857201262;
	Tue,  2 Jul 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emr86qeu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2320012E
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954412; cv=none; b=jox0b6/cOKcyORbbRCKLmj42iHKySkAVu5Vf9puHNH45vP0e8CLmO0NCFHBHyBI8w6TMYQsMVYRb+LlquHpxPJbNQVwyfELyi2tHHq0d3FkgrHmBWGJy9Omx7OCY9U7fVPcbaPeYGoEPKjLDraU8aG2nDaqggwRKRgpfwPDXdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954412; c=relaxed/simple;
	bh=j3iFJsviFPXXLCebKt+NehGB7hFpBqLngYpsLOqpJwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iVV4AZD8ugFd/7ZCy862X2hYJJekVB/dGiuBFxN6saAz4BtwLMjyvUZ070p8B+KNV7PT2/ewIEhguzojmtj+GuMEt8gc7sCqp4/Zr5UDqeyKz1h2ZL3Y/Pwrpm5DykgxKd6oWfkK03ul/qbPE6y2NcH/zf+oJNv9hQD2XzjED/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emr86qeu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb05ac6b77so6656335ad.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954410; x=1720559210; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/oNIlXPlnkOUTfjbSZTUFcyqnqHALt9jRrMlCZQw6A=;
        b=Emr86qeuIg5z6tjAjoNlNp5zqmr5F/6GkvhJK+kPbXlE3IVLlamyNECwPfHw5hihTw
         oRkwTkU8OH7qOvv1stbM16nXa9thgsTBdpiEuf6BqwOO8DHQPavxM8mE3y1Yxv/pkNog
         +THmWVMtDFDl5Bh/Uw8ziu1hliEbwhvovyNn0pGN288tmuFI2164YUEk5Mbd0iZl0f2x
         pmr5oekFT6uW6KbJSNurQ1zfGi1UgBsTjG/Tpx6GQLEOn73/5Ym/e+WM0OxGCzzJ33Lv
         LWmahZO5BANCNWA/tE2rOn9B41QsO8prlvf6T2A+EsYNcrY1vv+/sqWTq3fsEXN0Mzbm
         wuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954410; x=1720559210;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/oNIlXPlnkOUTfjbSZTUFcyqnqHALt9jRrMlCZQw6A=;
        b=f6XyhJzBsajJujaVcKsgdQn1tpTFRQtrXH1yA5jqPOv2RSWaeJTvhinw9ipLggK3qv
         hq8l9FseTxbGpwArwGpCiSk+E8lPzGpeO5htYSbWOoohFlX3E+UYdaK5QofZ5wJ/8WI5
         7kMdkBfF4SPLIbiqhtHc4KUJ29drrD9e8VwLs6oUVBBTHcPZX/jCvDuBkCg5VQ11et3+
         jY5bChq13RiPuMVgGOFde9yG/TTpy+U3+xYFSuHWu9Cc6IFerhIQpCi3vCyYOPA63J4I
         oeEPBT1OawCvrtv8pTRv9iLkQblSoCZh4wcqVWEABDessAOnR6OWoMwPRtsuNdqtxl0O
         XGyg==
X-Gm-Message-State: AOJu0YzReIGh5P8LlE6zaWVTm7NZD5RdbtA7bYcWYirAokY5EbzW1of/
	Fw3VXFdwu3k7v1J5sMcy1qEKYyLocSbRv8YxKwww8BSKmnZH7nrNrKzE/Q==
X-Google-Smtp-Source: AGHT+IE3Jq7yk8fYbc4FeNCuLX3M0Ztc0l4KcjYk8h3uAjLbsGgzeX7zzmdPjJXI/QsMOLgQkbQJ8g==
X-Received: by 2002:a17:902:d509:b0:1fa:fc69:7a7e with SMTP id d9443c01a7336-1fafc697b37mr22942045ad.34.1719954409976;
        Tue, 02 Jul 2024 14:06:49 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15967f2sm88699525ad.260.2024.07.02.14.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:06:49 -0700 (PDT)
Message-ID: <72afedd0d26329fce7dd3651a3a4c68baa4b7967.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 6/8] selftests/bpf: extract
 test_loader->expect_msgs as a data structure
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Tue, 02 Jul 2024 14:06:44 -0700
In-Reply-To: <CAEf4BzYtG-6po-z7AvtcEnW_y963awzD-ShXowWOKsp2RRKxcw@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-7-eddyz87@gmail.com>
	 <CAEf4BzYtG-6po-z7AvtcEnW_y963awzD-ShXowWOKsp2RRKxcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 17:42 -0700, Andrii Nakryiko wrote:

[...]

> > +struct msgs {
>=20
> but then "expected_msgs"? It's not messages it's definitions of
> expected message specifier (which is a substring or regex), seems
> useful to preserve distinction/specificity?

Will change.

>=20
> > +       struct expect_msg *patterns;
> > +       size_t cnt;
> > +};

[...]

