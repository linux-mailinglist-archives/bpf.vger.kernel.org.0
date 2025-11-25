Return-Path: <bpf+bounces-75413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF810C82F33
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 01:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3360B3AB150
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C101F12E0;
	Tue, 25 Nov 2025 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmR6Pl2j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTfFvTL2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C472631
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031596; cv=none; b=ZMnLPJ+xBnRbdZdVoIA4D/KB9FHJlI1IS45M5+dnOLDVcQjgZXZQhVVV8ieyBhwIgqC11E8aEPn6tNRvIXgfEYLIv4rlLCS0UW0eWvotNo3+FugLBslwVnl1wGDccFOkzt6xVRdyZmcuqwb5P7wLY+sWUCCwfSjdpnPclWJwYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031596; c=relaxed/simple;
	bh=Y0rWlV+eyfJjYlqL7oYDum80s2kVae3QQklWUjodGJ0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PVhWajQ3GHxxFN2C08khXisa1AORxJrhZgWpqjfM7l9Io/UWEP9QbCFW7Cj0mz2zybg0B4kldN8sy7Ebnqw6/SKVbtIkOtNaUaIiMfH3RW6PdTzV9ZtZGUoIWeIMTyfIjYMDeXEvZswslN0L22xmmT6oRvlZiloU9vKAXeqxkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmR6Pl2j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTfFvTL2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764031592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncItnG6r8wEZMryKPwalIeSOSpPfyXeplwJX6HDv+pg=;
	b=NmR6Pl2jfQx85gX0Dp0p6uJDtFYk+03BH2xxsQ5S6hAVVpLo1So6xUvoFeM8vyRIelOO24
	I7p3JWtr96XsUReckrw6aOFuRwWThmLp0VcN83eE/RdhwGetpNYlX0ZqnIytnUCY5U/oxM
	6rX3GwpoDsI8/9z9O1rDWdVLek+VJTU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-QZ7bJlFINQiie0MkJZtWXg-1; Mon, 24 Nov 2025 19:46:31 -0500
X-MC-Unique: QZ7bJlFINQiie0MkJZtWXg-1
X-Mimecast-MFC-AGG-ID: QZ7bJlFINQiie0MkJZtWXg_1764031591
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8824d5b11easo124971106d6.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764031591; x=1764636391; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncItnG6r8wEZMryKPwalIeSOSpPfyXeplwJX6HDv+pg=;
        b=VTfFvTL2vU3/c6oEKHPpXqpOyb9gRAAx0WYYT1AYr0sIaqZyEZsV2bUtn3PUVqgnG9
         WDHBn3zcG2L1EHBx0jSJ2LTXL08HEPpbfnT5h0Z/Jz6mQf+0epXqO5DCXuB7W6cJoxMn
         97g/sMNE02pngmRTXCdHb3xLuchC576+Ce5993hSwWov1AWG6kRmqewtGrV7zm8VZFgG
         RMXGBHi+ACbt152/2E8EwZFiyej6MX6boInmhiM7teauf+J2mQkcD9PoLmdlbRSFVe8I
         4LBcSSvsMZ+3Rq7Ie0KzOeqg0VFsT6208tgC04XhGX5nLEYznXp9/3k0ZKzpmyIOpRhg
         UjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764031591; x=1764636391;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncItnG6r8wEZMryKPwalIeSOSpPfyXeplwJX6HDv+pg=;
        b=qarKMw3crZFwk05+fweV7HYuwSzvSMdqnUHwLnoogSZkYOJWCz1x3pC+E03pNNhy0H
         fEJvVjZRW83Bf99UUcZi1IFLNP2c1EQlVRspolOJ7AD39gg7fc7T5c9QfNRgHvBW0t5E
         hVJQxlFT4zP4XE61o5PBMjGg3tTnYyEeXllpsG8qBYYiOpifXQZhC0uA1tkOExw026U3
         4HEdWtR5CUdEctRPLt+O9gugQ2NPV6+lGjnjjx+Hn6l7HZyP4XMSw40FhuNGjmS9ijJj
         Kc5vCYmp1P6xBw9H5EBhcvSLrMGJ4/4Viy/48wBvnkZQk/V6yamikgUO09Pj3Cl8rV0E
         R2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNIkV/iXy1g+hCTt3CjAZMtiVviNxIe0sTGIOrNP0VQEJ1WEVhOGXHsbrdYSuQKuGdICU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GtMDcIbTMlEgVoMixm/osmfU7LTH6bwebk26KpJAvStelctX
	mKcXnRKWbkb+OlUKlTVThTx/LbhVEnO/++KG6rrTaWkuT9ugowZPQ0r/kUcnEqUtj03WqD4+ZN2
	HvoZgjFaR9ncUC51eUjopB41ASLHqk21lM63VuLXKqJVRzl6YIj9/Rw==
X-Gm-Gg: ASbGnctB2yTUlGEZ46fpsVrHPlpVri092k6efG31iSgSoQ8pk8r0MxIhPS8lW2t5zxu
	YAStEZyt5E7NW+yl9HzxkkzvGzllOpzdGM4yf/P8QNskhDbZE4Ew/077BgsA3y4+Jz7cXloxPMi
	Xzc38BnAPXfTbIAQkK5GNMBlfJpb39jqFruSrxAn+gtKu9LXf7BnQNywDAx30dYShy9p4tNmCl4
	ZAj7oy2ZG2CybwLNHDmcr1t3sxBWieThO1uq8BYEQxyfTFRLZ0XOAJnvEhh13HX/xQ8u5STs5Vi
	MnT0yJxPsrB5UWwlLhO9ttcZPHxdbttQRdmJ/QnxCTbk8jlmrOtFQOm2iSBW88CIRGuBsUIw/6Y
	PyA7Z8RbtOYmT/R0PY6AK7auYUkbAly5xsdjkepo6Sg==
X-Received: by 2002:ad4:5bc3:0:b0:882:3ca2:f11f with SMTP id 6a1803df08f44-8847c4ca39cmr201790116d6.25.1764031590968;
        Mon, 24 Nov 2025 16:46:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoEJaswoVSDH9fyyqjPDyF/mbttDXLpmbINV8TC0fuiCOS4UY50MM0uWdGNruKowqDwIYEeA==
X-Received: by 2002:ad4:5bc3:0:b0:882:3ca2:f11f with SMTP id 6a1803df08f44-8847c4ca39cmr201789886d6.25.1764031590551;
        Mon, 24 Nov 2025 16:46:30 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e599978sm112470636d6.52.2025.11.24.16.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 16:46:30 -0800 (PST)
Message-ID: <9770045bcf400920152f0698c07090a641cc4aa1.camel@redhat.com>
Subject: Re: [rtla 04/13] rtla: Replace atoi() with a robust strtoi()
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Ivan Pravdin	
 <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, Costa
 Shulyupin	 <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 "open list:Real-time Linux Analysis (RTLA) tools"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Mon, 24 Nov 2025 18:46:29 -0600
In-Reply-To: <20251117184409.42831-5-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
	 <20251117184409.42831-5-wander@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:

>=20
> diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/ac=
tions.c
> index efa17290926da..e23d4f1c5a592 100644
> --- a/tools/tracing/rtla/src/actions.c
> +++ b/tools/tracing/rtla/src/actions.c
> @@ -199,12 +199,14 @@ actions_parse(struct actions *self, const char *tri=
gger, const char *tracefn)
>  		/* Takes two arguments, num (signal) and pid */
>  		while (token !=3D NULL) {
>  			if (strlen(token) > 4 && strncmp(token, "num=3D", 4) =3D=3D 0) {
> -				signal =3D atoi(token + 4);
> +				if(!strtoi(token + 4, &signal))
> +					return -1;

if (

>  			} else if (strlen(token) > 4 && strncmp(token, "pid=3D", 4) =3D=3D 0)=
 {
>  				if (strncmp(token + 4, "parent", 7) =3D=3D 0)
>  					pid =3D -1;
>  				else
> -					pid =3D atoi(token + 4);
> +					if (!strtoi(token + 4, &pid))
> +						return -1;

else if (

Please run the patches through checkpatch.pl

> @@ -959,3 +967,25 @@ int auto_house_keeping(cpu_set_t *monitored_cpus)
> =20
>  	return 1;
>  }
> +
> +/*
> + * strtoi - convert string to integer with error checking
> + *
> + * Returns true on success, false if conversion fails or result is out o=
f int range.
> + */
> +bool strtoi(const char *s, int *res)

Could use __attribute__((__warn_unused_result__)) like kstrtoint().

BTW, it's pretty annoying that we need to reinvent the wheel on all this
stuff just because it's userspace.  From some of the other tools it
looks like we can at least include basic kernel headers like compiler.h;
maybe we should have a tools/-wide common util area as well?  Even
better if some of the code can be shared with the kernel itself.

Not saying that should in any way be a blocker for these patches, just
something to think about.


-Crystal


