Return-Path: <bpf+bounces-27843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088BE8B2876
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE891F2257A
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3152314E2CC;
	Thu, 25 Apr 2024 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItIGB12V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103F14EC45
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071144; cv=none; b=lJzOQkp4O6biB5tXhAibDLbeCC8184IhibA5DIJsa166DuveNaqdHbb1npod94AJL2OfG3jE2hcz5j0B8aKc5uwGiX9eddIQBWHxJC1mp7fukESXNqtfr8m1Ly7nxeP6fxZiZM26AQ8qcsAQF2BQYRijboK8Ae6ynqqybSDVw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071144; c=relaxed/simple;
	bh=GXUNFLGB/npnShTtTZ0lttv3Oiphyr/HeCFlu+bWhKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XzSIXVGBdEm6B+Djpj0QEYqqKzOJKMg0zTbX4JGlqLz1s0WtBsT7O5AmgzjWaKAwuYk6884wIir1m5um76a/4M7/45f932YXVERJLTvOPGgvX0/h1k2qXjEkrnqz/VSXLY+1a3JFVSk/x1wFCv3hVTO66xRKOgmcItWWYE2WL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItIGB12V; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f30f69a958so1242451b3a.1
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714071143; x=1714675943; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GXUNFLGB/npnShTtTZ0lttv3Oiphyr/HeCFlu+bWhKA=;
        b=ItIGB12VJmGwySVbNhnzRL/rf6Oeip2ShSlyI4ebk9jkEWKtfMkkWbMzKTqoYVA8Xx
         UdrFN4qcjZRdJfadvJhj1xBSkl7xRdewySw1mDcSI3MkGULj3bJ01+L5f+mrUXoUxXnp
         8bczcDJQMDB3QkZdrUfX4YfuV+UwQawXIGCnug0sJ+WauSglBclxd9quUf7Ia9D2bpe9
         ACmNuA8o3jwjiyetY9YKEyO5ZNMZlawZAkIM0VkZJCuloXl7ezCrUW/t+c8u2CW3dji1
         LUHpIU64ajj5wc6KZI7BU/QWDk5leSyNMfEhrQpgcEoua+VkHRgMsoMBECz1GBXVKoiQ
         H9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071143; x=1714675943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXUNFLGB/npnShTtTZ0lttv3Oiphyr/HeCFlu+bWhKA=;
        b=ZBeU5d7G+6RtniadFPYkZzcIyISgslTN6JeSFr4HzcSmcL/bg0jtq7spekGZPgo2PK
         fKouXDVq3AZlMN5vQ5+skgai7RGt+9JTmzDPriICWwglG76Xm4hhPGUBjSfHrtyFnslY
         XTK/LA4vMaS/zdwvF8wtGLkgJ7Ypq2himWA1UJHYtwI6cGTM3/qAOfZD6ChzHoPljMun
         dGM+/9bGbkQjoGmrbmaBM0YO1Fg8XuxO98R/pKCXcO3X3wweHYAd5WMp7KPW0EWL/IV1
         bF9lZwXj5YtLbUnt+0KAktEAsVWiy24IjYxW7ul/vRfHsgCnvvxGqCDU4HQWlzaid+pO
         3j7w==
X-Forwarded-Encrypted: i=1; AJvYcCXFkffIMHwnhNSKhyFi37uGlYw1qzbSJxs+Y3Y36g+qSgKenbLXqGQ+G1HqjcUnD8fZL8XUPTQzN5Z2N6qEDWjbkUAA
X-Gm-Message-State: AOJu0YxpEGdX2YY6P7IgrVu1Wi99mNhET9ihP4VcjiewmIdb8+mDqSVl
	TqD+FtVtlZoBhKuZuoR1tS2OU4P070U4Q50P4RFFCdQmhq8lLP0t
X-Google-Smtp-Source: AGHT+IFHqdgN4ypSjuxtlaX+yPld1AjiLRVAFzjxD3BQia+/DvpVMvsS3q4HNTZ5GqAaqUZ1bI0mmg==
X-Received: by 2002:a05:6a00:93a8:b0:6ea:c156:f8dd with SMTP id ka40-20020a056a0093a800b006eac156f8ddmr788242pfb.11.1714071142832;
        Thu, 25 Apr 2024 11:52:22 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:b5d8:5a56:aaf7:f817? ([2604:3d08:9880:5900:b5d8:5a56:aaf7:f817])
        by smtp.gmail.com with ESMTPSA id u12-20020a056a00098c00b006f09d5807ebsm13055985pfg.82.2024.04.25.11.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 11:52:22 -0700 (PDT)
Message-ID: <77c1b7992e05af2d0178dc68f3330732a735caee.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf/verifier: improve XOR and OR range
 computation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Jose
 Marchesi <jose.marchesi@oracle.com>, Elena Zannoni
 <elena.zannoni@oracle.com>
Date: Thu, 25 Apr 2024 11:52:21 -0700
In-Reply-To: <20240424224053.471771-4-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
	 <20240424224053.471771-4-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 23:40 +0100, Cupertino Miranda wrote:
> Range for XOR and OR operators would not be attempted unless src_reg
> would resolve to a single value, i.e. a known constant value.
> This condition is unnecessary, and the following XOR/OR operator
> handling could compute a possible better range.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(Please copy ack's from previous versions of the patch if there were
 no significant changes, it makes its easier to review subsequent versions)=
.

[...]

