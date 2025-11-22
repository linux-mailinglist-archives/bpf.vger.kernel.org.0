Return-Path: <bpf+bounces-75298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534F7C7CB1B
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 10:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9143A893C
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBB62F3620;
	Sat, 22 Nov 2025 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/ch9uUF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895A285CA7
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763802315; cv=none; b=WQb5oeMpjAP/SQ61o1dbasd3waocECZVOUzc6ap/dx+dQ9RnulURDv9u3jzwvaxiODT6J2FBY+bRckBNHsiQvMH+jvZEVwjhqP+Ewd8EkL1HD5jTL8IVU8ZwhoCuwKvL3vSqIaomu1iYXhvVw+mwkXZeqjJf+qAK1JfhzsClyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763802315; c=relaxed/simple;
	bh=Um4UnPbfNFpJnJ1Lns/u56GQ00jKL4b5KxYTpCEB7Ww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NgwK4onFF4pf0OqozZGTkrI5YAfTI5Ka2Tya0G4F+XH+0f37bVhnlaApWTw3gXq97n9606Kda15wc2J+6czao2L27ftNdg+8pzF2uOuhkLRly/9kR+p3XRM+fllpj9NGRnCV2jATEkjZZg4zQ+B+pz1J1ZJl1QbK+/987EV2B3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/ch9uUF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b75e366866so1279162b3a.2
        for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 01:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763802313; x=1764407113; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Um4UnPbfNFpJnJ1Lns/u56GQ00jKL4b5KxYTpCEB7Ww=;
        b=k/ch9uUFQSgIGksmwPVpss0qOKiHEOIoWr1X4XsdzP7D8VYHXn3zazjV1OZJM+ywVZ
         /BJpW4JdRjBN9TUNRGyCZE64ywE8NTeSnmp4yOmmahHOghqBNySNU9QYaHg52Hu86gnp
         g+2bmHyVuHpZg+aF5Sid8uji+gCzegu8Erfh4h6jUV4n9FhM15dtRhDUSz9xHyA1vP4w
         X9bokvSXzwwZ6YmZ6r66+ajfC4Vy3REjhi9dGP63dDOHgl8IySA0UhYaI3TogHxQRSL1
         4NmLasZhRzJ6Pft1G4lI8iTpe1HdPY/UmetgBib+Sq0t0KYghETcQI8Tm/5dv4d92+Kk
         u5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763802313; x=1764407113;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Um4UnPbfNFpJnJ1Lns/u56GQ00jKL4b5KxYTpCEB7Ww=;
        b=OA65uw+kgk50cPXG+jMVKurMC1MFvG9L8gfojyvRV8oCHZz/e5qMkitt3qR0KLwexj
         W+42p9PzEa1bdTZ0ouvoi1HoYK989yLwJTU11aLPdH04tGU7/mAt0tOu5NaT2CJU0F64
         O+e6/fjWpA5gvAf8V3XbFIhPJfQ46SPWg+ot46Ifow3rV4gDPZRK6updTWL2K8OCaon+
         uyMmluv1ynvaCZZl0lwDGnpGMbXLH2JSsUy66B3etNPmkRtwDtNYOVRdmcPKx4LVlPPr
         bm3NCxzXLH7oLoVDpPxKvgP876d1eDq/rMnMSTU7CRjSqB8fa2Zz1F6ni/z73iXpTVz+
         m3lw==
X-Forwarded-Encrypted: i=1; AJvYcCVo6oRNYWsp96hMNd0ATXodB73IbRhdm6gYvjrANUUGMBHbui1hVkQIZtpb8iTTnK1jbMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+eOemEr2KvP9q3XwKbeIMQgRFDrGWfDmBZJpsB5DmzmuFm3Kb
	6JDBnafxpa1Atcb/H8Is7MnwhJnMosO2hVPlUP8guQ4AlCNm8m1UNm2d
X-Gm-Gg: ASbGnctUbw24tcHiUxpVWbrROktekpOV/BjoTb1HSesZzBxoCK+fm93ZgEZIhutxAB9
	gOcvep21xMf3Hebh+5krosWCxSUWPSLtae7AM/ZIRHpjz+eXvE4SdsaL/sVirGeM/g6tvuZSuSs
	iwSHiQWcJB1fD3y6LnvIGxbsINzhqMe9ScgTo0QWUPWw1WmQXYWiZ7XHGth+PbmRnyldxYHNuhq
	4kOu+p2qKQkBupFurE1IxYE3VzCiDoV6BT/6RxyGgNA17JZhyKM9vx/ZTyxveNRef8mgRo8kO27
	6vsHPbAtbU7nMPGPGSN5Cnnum/XOatk08eGarPxIu26b3B/bkGIYlnIgIvp3wrEkS+xu9+SaNK5
	9w3OZiL8g43VH8me8xiu13+CMAneWnh7wR4gyccUDp0j3kXEwxGntt+INLdfmAknUlcYrotQT3U
	gHk7GULtg=
X-Google-Smtp-Source: AGHT+IFUab76b1PQE4Jfa8RjCTvQiCrsvEsvVg3FMlD/dO1BErN8i/ili2DuOSAeQ5Zi3rpOLBGypg==
X-Received: by 2002:a05:6a20:e291:b0:345:e30f:d6e6 with SMTP id adf61e73a8af0-3614eb9eab7mr6869367637.15.1763802312773;
        Sat, 22 Nov 2025 01:05:12 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0243b19sm8435596b3a.37.2025.11.22.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 01:05:12 -0800 (PST)
Message-ID: <ce92f733d24bfad103a9abcc209f411398e23332.camel@gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting
 validation for binary search optimization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
  Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Date: Sat, 22 Nov 2025 01:05:09 -0800
In-Reply-To: <f515305c3b250f9dbed003b98d78f72c3d72cc2c.camel@gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
		 <20251119031531.1817099-6-dolinux.peng@gmail.com>
		 <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
		 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
		 <bddc9f1d5c1f2f7f233707cf2af81a2013d46b7d.camel@gmail.com>
		 <CAErzpmvP41CNQhRVKuDU23xnBKjj239R6_e5K8DSwcNDo7GG5Q@mail.gmail.com>
	 <f515305c3b250f9dbed003b98d78f72c3d72cc2c.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-22 at 00:50 -0800, Eduard Zingerman wrote:

[...]

> > Thanks. I=E2=80=99ve looked into find_btf_percpu_datasec and we can=E2=
=80=99t use
> > btf_find_by_name_kind here because the search scope differs. For
> > a module BTF, find_btf_percpu_datasec only searches within the
> > module=E2=80=99s own BTF, whereas btf_find_by_name_kind prioritizes
> > searching the base BTF first. Thus, placing named types ahead is
> > more effective here. Besides, I found that the '.data..percpu' named
> > type will be placed at [1] for vmlinux BTF because the prefix '.' is
> > smaller than any letter, so the linear search only requires one loop to
> > locate it. However, if we put named types at the end, it will need more
> > than 60,000 loops..
>=20
> But this can be easily fixed if a variant of btf_find_by_name_kind()
> is provided that looks for a match only in a specific BTF. Or accepts
> a start id parameter.

Also, I double checked, and for my vmlinux the id for '.data..percpu'
section is 110864, the last id of all. So, having all anonymous types
in front does not change status-quo compared to current implementation.

