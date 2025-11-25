Return-Path: <bpf+bounces-75414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 048DFC82F3C
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 01:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F4D54E687A
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592F2192E4;
	Tue, 25 Nov 2025 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1dEP6Ji";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9rCZAWj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815E20ADD6
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031600; cv=none; b=aoHg7330VdBfu7ViihIntXfO2bBxBG/NTWapvZ+LqrBGR7vU4DurBA+eFVmy0qwFLuvL8B99zpP+GnxR0YD7022IrWwgbzxJYCB8/DAfVCfZe+iMURrTlEAThbp5OHgFGl02oj5FkKUasPzFKJg5PXHD0hpTuiP6DSDFan6nwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031600; c=relaxed/simple;
	bh=G3zh+yMK/TRKivltkP3mCqe+qC0Y3SskBQgYCuxwWBo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ud7ClxprkE/BQ6XXkmGxDF/VSJiih+qQzSYDrDbpyXnbNFqkFXu4XAXBxKOglhc66AEu3979gjAf40JWEoNPEvxfO5LbhsswBQ8RjK1kKeQPBxz+YAL2oBopNuN5X0MKYMa7hr+qtFBnnIEG2R29MWJacenAqQ/Ga26EpB067og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1dEP6Ji; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9rCZAWj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764031597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYQVballiQUNa7s18X6oVPWwoZUsXRJUaKrTG/soO4I=;
	b=G1dEP6JiH55T4EeRxHw8fG4PamxkyWMVZBvV6biSc2ZgN7cutp+HW0xYGYhzcrrFWmgXTM
	P2iQi565697wC3eEw3YOihpTpM40Iro8AEr/7YhtfN4RuPXIGH0JHIlbp410b2eqgzrvhW
	3H8Dmgn3VtwDhY+gv8ZxmM+cT4oP61s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-3XSvA9gKN3KDdN01vXG2bQ-1; Mon, 24 Nov 2025 19:46:35 -0500
X-MC-Unique: 3XSvA9gKN3KDdN01vXG2bQ-1
X-Mimecast-MFC-AGG-ID: 3XSvA9gKN3KDdN01vXG2bQ_1764031595
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8823f71756dso57562066d6.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764031595; x=1764636395; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYQVballiQUNa7s18X6oVPWwoZUsXRJUaKrTG/soO4I=;
        b=A9rCZAWjI2aWxYKEb57dEK/f8piO2fwvYLqHbQ+CBgm/5JRFnXPpgNLyuXA6B375cy
         KY/4ZjBNqKfwG8CwE+r3xmHSwOKp9YRIlUXfcDIgeeNJQNk93fUo9XKN4cr/v1whzpN0
         3Om5mH+pOWvX5yfp5/XJrotcsISWT8BGdMvmqIaOHQsf1CI6g+5NgSYBw1wU479lZbcs
         qtSAAc52fw6XfddU6ItZQVyxZeExTDndWcb0j3oa4ZFSBWNyjvrreHqMerbXsxtP685d
         hweiwrsyhxjI18Yb8/BZyX7zuRAeYAUOk39JmEhgypVNnusc97B2Yc/ZYxVYEnZEGInO
         uyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764031595; x=1764636395;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYQVballiQUNa7s18X6oVPWwoZUsXRJUaKrTG/soO4I=;
        b=TcORdRikBmKlPEyd5c1diWab2SJ7QzkVUDH2p1MHjyEASox+BNI2QwwFSvzfObGF2q
         DyX7gBAzhIuTjUUTj6sftJPmHB+wfAlV+wtiQglvA56Up2p0ss9iz8FvIHmV6AsP2cHh
         xAxCeg/D7RL+Js+WjIa/A1hIRxN28HspO1LwD0xW/mzB3NeOZZSoAYaGRRdN+L79ymI9
         /Z/HuMBmNWtkgzPDJlZdEeto4KuJjynNztOBRtVM+pKIwf8BNHvsojoiWe90VkpnsPZb
         BofFEEbMLBJeGtjMMHd1MzCTFwTk42nG2THyrYyRFXV5RG8y1KxjLZZO3tT/goiF/6Lm
         UGmA==
X-Forwarded-Encrypted: i=1; AJvYcCVd84rIrXqqEQabTP8JY3vl7nZXQ/qoOo66n4CSe4lCdrrYIfH5Ts0blhVOsk9/CWi8Ygw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cu74WTG2dhFvofx+UxejFJY17Rc1B28uJ3ViXJb9vVVnZ0Wz
	8g406e4WVwZyYjvoI4SspSy1jUGMAcP9E4PIJ591PjZ1uSx1q2aSX9U4OmQuKG3GoLYRAfRqH6R
	pbg8pCYXRzPttkjTzvIOk2hMVrda9p+m5XBCwb0Qeoohn2TdmN6bWIw==
X-Gm-Gg: ASbGncs16O9B3vnYeyE6G7flzOagYCF0O1eA3p3+eWNrpfN1xbas6p5mIHkgqlw9SaJ
	sIONl/7wQq6Df9d8dcOVPYeah7aNae3WsVMIlACeEdo3Kt37mtCjL5khLVI4d5+NJvqucPGuOhP
	NNJLm2DdUfYSIAXo+zxYaXVIRpgjgns47YIN0lPNzDAB4RgO5rOiNjzXY83qP6jIe7N7YpTZYvB
	MPu5Xdo/ORpLYwu66tqR0uVcigNj3bN5LidzwEcHxw71wUuGnaGVvm8tS+5LluozANew4iytIZ9
	C3L7hANUhN47rLsI8XWvh84B95pE3Qkxg+sGUpcdVX3PoZ81wB7XcA+NbqrQLbD8E8nRikrRNCF
	WSkEAf8q+wKNxEbAMW/uyvn2q229N8VSBoXhZF5FgWQ==
X-Received: by 2002:a05:6214:3286:b0:785:aa57:b5bb with SMTP id 6a1803df08f44-8863af9e4e2mr14512276d6.43.1764031595191;
        Mon, 24 Nov 2025 16:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1IIBLslO2enBnltrjevE+RfgzVlbb9qwoLOv7Ks1RpjPqjqO5ugdNzJyrbWT1YPDsV4Kegw==
X-Received: by 2002:a05:6214:3286:b0:785:aa57:b5bb with SMTP id 6a1803df08f44-8863af9e4e2mr14511936d6.43.1764031594723;
        Mon, 24 Nov 2025 16:46:34 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e46a4b2sm110780436d6.19.2025.11.24.16.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 16:46:34 -0800 (PST)
Message-ID: <e96f06667d07fe7f207fc8769218967d22cf7634.camel@redhat.com>
Subject: Re: [rtla 05/13] rtla: Simplify argument parsing
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Ivan Pravdin	
 <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, Costa
 Shulyupin	 <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 "open list:Real-time Linux Analysis (RTLA) tools"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Mon, 24 Nov 2025 18:46:33 -0600
In-Reply-To: <20251117184409.42831-6-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
	 <20251117184409.42831-6-wander@redhat.com>
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

> =20
> +/*
> + * extract_arg - extract argument value from option token
> + * @token: option token (e.g., "file=3Dtrace.txt")
> + * @opt: option name to match (e.g., "file")
> + *
> + * Returns pointer to argument value after "=3D" if token matches "opt=
=3D",
> + * otherwise returns NULL.
> + */
> +#define extract_arg(token, opt) (				\
> +	strlen(token) > STRING_LENGTH(opt "=3D") &&		\
> +	!strncmp_static(token, opt "=3D")				\
> +		? (token) + STRING_LENGTH(opt "=3D") : NULL )

This could be implemented as a function (albeit without the
concatenation trick)... but if it must be a macro, at least encase it
with ({ }) so it behaves more like a function.

> +
>  /*
>   * actions_parse - add an action based on text specification
>   */
>  int
>  actions_parse(struct actions *self, const char *trigger, const char *tra=
cefn)
>  {
> +
>  	enum action_type type =3D ACTION_NONE;

Why this blank line?


> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index 160491f5de91c..f7ff548f7fba7 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -13,8 +13,18 @@
>  #define MAX_NICE		20
>  #define MIN_NICE		-19
> =20
> -#define container_of(ptr, type, member)({			\
> -	const typeof(((type *)0)->member) *__mptr =3D (ptr);	\
[snip]
> +#define container_of(ptr, type, member)({				\
> +	const typeof(((type *)0)->member) *__mptr =3D (ptr);		\
>  	(type *)((char *)__mptr - offsetof(type, member)) ; })

It's easier to review patches when they don't make unrelated aesthetic
changes...

-Crystal


