Return-Path: <bpf+bounces-65011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F87B1A914
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 20:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3730623C1C
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 18:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C6628643C;
	Mon,  4 Aug 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E61M0me9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD71BD9D0
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331521; cv=none; b=tBBua7HYb9YsSWObZ6boLqgeBKM6+Xnp2WXa3hpY2ewLPRSXSGdV3G/KVgU6DAjZza1cBLgwXdhgGGBfK459mf9TsaP511e70iJScwGHNkV5aBYA5tRY0hqvvpIvJdkQyGCibT+ihtilII9HloJkqyHq8zmKI/i5sjymwC74OmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331521; c=relaxed/simple;
	bh=sJmIS+4VMfjqdG20GuSrtYDj9UHHKpW7QBhkO353ZHU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Do4OQ9SB6f2Y6O/0o//fqAUYyNJ6KikgevR+eC4dz+rpNNUlp/FUBAhHRbUw+1y01f8/jBo0YW/Wy/qrSS6x+mbf69PCTyRyPhh51X5Wkwa58kBJD6FbBBfUr+tefv3rYQNFANoPDOkOQLbO+t7gC24tZfEtHaFbOPl9LOt3oKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E61M0me9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754331517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPFuA3XT5rZs0YkAQkaYeJ3lMViwpDLOl0oehXQ14cg=;
	b=E61M0me9DtxW/czm6XIM2FssAVMmbq1EQJdXYqpkCBuVnAxV1dR/NGhTaQ6WCorzJRL7mx
	V85wogt7NohbF9ZGNQjAAHf9d3y7wrFG67EKeQFEMLAIZe7gfjQNlOjdCtytWXl0W7v/Jt
	tbQo/INVrqqZGv4y+uf1mtkjhY8NSBQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-2kO-p0IzMr-8C4eeXA7HPw-1; Mon, 04 Aug 2025 14:18:36 -0400
X-MC-Unique: 2kO-p0IzMr-8C4eeXA7HPw-1
X-Mimecast-MFC-AGG-ID: 2kO-p0IzMr-8C4eeXA7HPw_1754331515
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c43c2af72so352329139f.0
        for <bpf@vger.kernel.org>; Mon, 04 Aug 2025 11:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754331515; x=1754936315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPFuA3XT5rZs0YkAQkaYeJ3lMViwpDLOl0oehXQ14cg=;
        b=G12/ZRRZwWwb254X+SA5Oh7UiEGuPnnSl9naqyXeV99iR9yFxfqaousBuCCjYG5i7R
         ez0y3rQjJThj5dExQR8y+BovtUGzxzPts+Ad3jFgbJY5pYt+PI1jaiKWbqtJj/Q6E41v
         rtIR3alqPn4YHOXF0MlC0E7KDV33w+vvbuHptyoOia/GIu2m3XOC6N790GkbN1n2Yw1x
         XPUGH9yhyYyRjyx9dPVUDkWuwopeRkIqLKLhQUQ5Qd3+/PWY0BQ2QBxhqIroAGa5q67S
         e00sYTi0qdsPSvWdLxtWRDeh6M36EUDqPml85Oald3hdBg+1kXpUVrE1ybgbRp7ReHha
         FeRw==
X-Forwarded-Encrypted: i=1; AJvYcCXzrRcWZswo/iuGePzyxRFA0I688WnbYW+VZ9CgD42xlFFO7IApQo10QFhQJNO/Quy85rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcuXoT7lU0DlHYK9xCYzN/6Yp3GtHmMHupJBW2Kexag5h/oYzy
	v73WBmkbY/X2nZ1zOkgC9qG/0lrn0DAEyKZUNbN2+Edeoyub4AXS/qnSRdBgG1wI1jsBKtHk/je
	yNG4dpgAuGr5pJI4MpzrcfkZ2X0wXvXDDSrJOqqJGdNb3QKx0HKNlbA==
X-Gm-Gg: ASbGncsCFY5JOWz5OMf4UKaKmmYxfQ5fNOCDXF+Sz7XtrBoT+LX4774M8DJ9PcjPhuD
	Hn2ewagx+4cNLEeyVqTHebssDECO1ycZE3paBuB+52qkiOGrJK/zoF1P3GAKOSLGjAQ53ZGw9h5
	XduQQW0aLZNos5QOmEH6GXYT62JyKBoWlufOmRIKrVwriZSqT59wgPS9roVrcCUYUdIYpYaLsA4
	cbYphnwJz2qsYI1iYzWdkgJ4GAWVpYS7sD434X+l+TKytaI2pzNWCuMjJpcxYHAAv/IaIK26JhW
	m/QfsksvAq++JELYuQ0qH1BdU7SVglqKY/ykgHFGqIp4MuWNSJ6GLCaOtwslS2wGD8p3
X-Received: by 2002:a05:6602:2cd5:b0:87c:2f66:70f9 with SMTP id ca18e2360f4ac-8816824b198mr1908989639f.0.1754331515393;
        Mon, 04 Aug 2025 11:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRY7UzzPxt1OP5gyqT0uCW4Gog0m9+ZLLEFgonjkQDZIWdxputL/74lAccIGpspoDTOpfy5Q==
X-Received: by 2002:a05:6602:2cd5:b0:87c:2f66:70f9 with SMTP id ca18e2360f4ac-8816824b198mr1908985239f.0.1754331514891;
        Mon, 04 Aug 2025 11:18:34 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88187f182a7sm60068839f.6.2025.08.04.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:18:34 -0700 (PDT)
Message-ID: <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into
 shared structure
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, John Kacur
	 <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, Dan Carpenter
	 <dan.carpenter@linaro.org>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Mon, 04 Aug 2025 13:18:33 -0500
In-Reply-To: <20250726072455.289445-1-costa.shul@redhat.com>
References: <20250726072455.289445-1-costa.shul@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-26 at 10:24 +0300, Costa Shulyupin wrote:
> timerlat_params and osnoise_params structures contain 15 identical
> fields.
>=20
> Introduce a common_params structure and move those fields into it to
> eliminate the code duplication and improve maintainability.
>=20
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

FWIW I have a bigger consolidation patchset in the works, that merges a
lot of the codepaths as well as having everything use osnoise_params
(with some members being tool-specific, indicated by comments).  If you
want, I could rebase that on this and use container_of() to for tool-
specific params... but then that adds complexity with the top and hist-
specific params, most of which are common between timerlat and osnoise
(and not merged by this patch).  So we might want to just keep it simple
with one big struct.

Any thoughts?

> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index a2a6f89f342d..4c99a3746380 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -59,6 +59,32 @@ struct sched_attr {
>  };
>  #endif /* SCHED_ATTR_SIZE_VER0 */
> =20
> +/*
> + * common_params - Parameters shared between timerlat_params and osnoise=
_params
> + */
> +struct common_params {

I'm not sure that util.h makes sense for this... it's pretty core rtla
stuff rather than helper utilities.  I'd just put it in osnoise.h (or a
new common.h if we want to keep the actual-osnoise-tracer stuff
separate, though currently it's a jumble).

Do we have any naming conventions for the actual osnoise tracer as
opposed to the broader osnoise family?  I don't know if it's likely
we'll ever try to put something outside the osnoise family to rtla, but
if we do "common" could be a bit too generic.  Not sure if that's worth
worrying about at this point.  Certainly better than using "osnoise" for
both without clarifying.

-Crystal


