Return-Path: <bpf+bounces-78553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F475D12930
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 13:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67F97302EA23
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E039357738;
	Mon, 12 Jan 2026 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1Rkhz04";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDJwFEJs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C20356A0D
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221558; cv=none; b=LIZ9IRSHEKSfxT9w9BAsNw92IaAIOpra1OwUqalLpHIzq+DGFpJd+chnzwidenGjgSo2BI6HkUD/gcxAQ5jA9/kk4j9szNmOm2Zsh+4Kv1107MnXzQaz1Wp6Aoony4+8IPL5kgsohixnekV9CYvN/q772D38WsOMRFhQhMn3dE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221558; c=relaxed/simple;
	bh=zPmMnIUeMW/xGbc72LiA4361srUY4NN+6TfLE/qZZo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzIyydMBFIda5pB1V4tY2iB3VBVjuVd1FRXRKwmQ1jtXYa8PIF9jr1F/YyV73P8YnBDEOIz5lyKxsVqtDkodiqn8Nglxe015G/vX0iNPxuwk4eLmZyBKtHfFdbLOU9ae474rUVHi/hxJVbmD84kisVeioX+iru5uVkFtJ4g3Suc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1Rkhz04; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDJwFEJs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768221556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPmMnIUeMW/xGbc72LiA4361srUY4NN+6TfLE/qZZo8=;
	b=Z1Rkhz04RE21eprrJc5oAZs1rckpqwON6+JRWGgnucQEoZXttSy+BS3Rzvt4Nnv7ZvJtWS
	h6LoMhDXI/XHEprB3jkkbSb303jUo9nX1YAeaUU1utkuWPcb/SI1RXl9wighYKnIWWBjpA
	cz6dlKS8AfJd0tf+eY5zkpRyZlHg3CA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-XhBkSdjqN9-Z3OhK1bcm6w-1; Mon, 12 Jan 2026 07:39:15 -0500
X-MC-Unique: XhBkSdjqN9-Z3OhK1bcm6w-1
X-Mimecast-MFC-AGG-ID: XhBkSdjqN9-Z3OhK1bcm6w_1768221554
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b871403f69eso130087966b.2
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 04:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768221554; x=1768826354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPmMnIUeMW/xGbc72LiA4361srUY4NN+6TfLE/qZZo8=;
        b=MDJwFEJsRM6qKgqUQy47+FCWP/odarzGWUKPwMlIeYrPe1TuqlBWURxzFT/dxYpf5S
         XSWH1jc2HJW4+8WriGNDcMBz7VXsxm980El0eQZL1mQ0tEQMue1Dn/baf2gSkzjRytMs
         LAr+sudTmXzvTifc8zaIRQQ0BXG1Mi4d6t8a3WniO5A4acEd5bVlaaPj0nztAQM7l6Yl
         nD5ZohXdCx3t628autASZmHCDHnZsoQaIBGYf/DMQxf3izhv46OKOHeSg0pxYPEqHBBZ
         7Vju1EHO3LVpfs2hTnrySqGXleRL9L1y+1D21JZRSWbOg9fCoMylJq7it1tjDk4/9h/t
         WYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768221554; x=1768826354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPmMnIUeMW/xGbc72LiA4361srUY4NN+6TfLE/qZZo8=;
        b=UkeHpkjsnnUm2sgY94BAmL8ojHQIU/NMH5ZcPJd4tfll5bSFJmwKCxAvvJwCz28wR9
         R+8GWmMJx3Wizfs7fddZ2WymWQ+Ot3v7/F6VWIz+lqRkKIk/fihssx9JCaLA0G33YwbS
         Fhu8rMYq0AEMD0odpvNnZMwZPoBof9/7aCruL4CANwI8OXQZmhescb+FmsxDmEArVckz
         dS9H0d7RXpUP/WOXRoSMkFCC8as868l9JLttcbcy/dociOHZoM4kGZeELS/qLvAjxc9X
         2NWL6DqdGCr7I5PJY6lMHBam8VTfVUdKlYLu/kfrgZUsq+dLP/cjLPySB2DNHkw4VQhs
         dhBg==
X-Forwarded-Encrypted: i=1; AJvYcCUSBkuMifpdEAHDAwNC2pwwVVXCPizdntrf8A1lrrHgK44OxYQdLr3h0xTrUoAtTPRdonI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfUfC8RcP9fNivgdugjXSz8m3rwJDJAjJJc8UvPJ7RxLQnLjp
	fTYfdXP0byXaUSoPjTo3kOO3ROMJTFcDA4DXjXy0i29P4YvOkgtsmiD3T1mGYWHgSrV/7pDaS5S
	iS8OBBZFdt9k6PqKkpTj3p0heGwi4L0w5JSUuT/XOj681TEWvrwSjwzIEBVmFX7g/bKRKGn7caV
	RcBtZJKkIYo1jYBO1DdUsA8cQQqYDr
X-Gm-Gg: AY/fxX4jEb9bsOYFgBxraItc6tXAPy506mAYt51AVTk3qQYidSRaJSO+Ay4NzQPhjwQ
	o6Wz138kaVz25+hfXPsmy3wod0A/fKssaC3fUscK+RXSp4tkvZqamIRG49MVv7cP+jJ0i0MAFwH
	nVYmD1dbaMrj014LlxwzlbRTe5IKJFo85R3D7LRy4OFiRaaOQKBJfQWODjAaVIouI2WnP9J6OqO
	zLGhKe6uKRQGcM4DWmPueNT
X-Received: by 2002:a17:906:d54f:b0:b87:718:5da2 with SMTP id a640c23a62f3a-b8707185ecfmr471401266b.1.1768221554304;
        Mon, 12 Jan 2026 04:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3+obAgvpI3XGqVs/x4/87zfrvhtWt19z8TWgbdUn/UY6KiSt7yf30J8rO+jMO6vWIwvauNVnXpg2n56+W+L0=
X-Received: by 2002:a17:906:d54f:b0:b87:718:5da2 with SMTP id
 a640c23a62f3a-b8707185ecfmr471398866b.1.1768221553899; Mon, 12 Jan 2026
 04:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-5-wander@redhat.com>
 <CADDUTFyEJxLHKHiaxya5QxW49kzWdhj=hzTygQYa9JPUOe8Zgw@mail.gmail.com>
In-Reply-To: <CADDUTFyEJxLHKHiaxya5QxW49kzWdhj=hzTygQYa9JPUOe8Zgw@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 12 Jan 2026 13:39:01 +0100
X-Gm-Features: AZwV_QiopI6W-8pUbNsGpRjKtlB-Ai6Lekl1JIddbiz00sbteCjQLnK3nAzzz4g
Message-ID: <CAP4=nvQaunTud=CT8Dp4cYCuB=m7t_0VsCsvmxRtBxC_T6dvzg@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] rtla: Replace atoi() with a robust strtoi()
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 12. 1. 2026 v 13:28 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> This commit breaks parse_cpu_set
>
> ./rtla timerlat hist -D -c 1,3
> Error parsing the cpu set 1,3
> Invalid -c cpu list
>
> ./rtla timerlat hist -D -c 1-3
> Error parsing the cpu set 1-3
> Invalid -c cpu list
>

It might not be the worst idea to test more than just "-c 0" in
tests/timerlat.t :)

Tomas


