Return-Path: <bpf+bounces-61441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4834AAE715A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0AD1BC359E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0692571AD;
	Tue, 24 Jun 2025 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbPsrAo+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364502475F2
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799455; cv=none; b=sMTN/yTnOvrOsYN1NjMc2utsORvv4DJeaBG8gMlBte371kOAa7qs+cu8XiHvJyjOdsvs9fKueMOPSjyuNbRHKMuhiFMlM0AxDCs/QA4fkz4ZenBsrTkt1QKIAqbJbnAgfERQ3N6pLR8eqILQaV8as393zDjcgbPLHAdS/fu9Cfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799455; c=relaxed/simple;
	bh=PXZ3xhz5v/fttxGH56cOOdmHnVkzJMdvnQsa9jnCgdI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c27DthzeMdurTmbf9NbWzxCK6PLYeKqbtj7gotOTTftFpzhfwT56u/53sjela7AZN0z9FeF0gOqe0enTxQ5JEWZvJ3YGswVf1+uL5Pj1CWouh+NfINP00Ms3CxuH+J/B1o49unVAfxZ8WTN1UNcVG86VN5/S9P+UjZBXlxv6AOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbPsrAo+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748feca4a61so3144791b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750799453; x=1751404253; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1S8P6EYMkOp2vsNJJlPBlejDxPt2HKT0r1zZ0Yxmgg=;
        b=kbPsrAo+iTfqsH+SX15eaz0SGTvYzXnuqpwHA7aXpneqX/xKJXOGBRuSrhFwOw/jro
         C7GQdzwJROAljhglQr610gHnCL98XGRqWPRakqfTEDJukQUH7BwtGdR2DV+10TR/kQsG
         Ykpbl4/UgHvA0iKcHp1RrIhS4ZUQAgtdpSYkePa/t8Wn6v75L73mhH+2vvb5otq5Qh1t
         fOACr9w/Y44iHYan3I0VVxNDofK1W4Uz1BIQNroFZPvPOrcBHQKq6g/06jIYYAA+vxBS
         WQ5Z3PZuk2k5C6A6Y73DjXO0ossH09rowYaRaF5nVzaa9zbs7DdnEeUUj4K8AAIurTLe
         vU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750799453; x=1751404253;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1S8P6EYMkOp2vsNJJlPBlejDxPt2HKT0r1zZ0Yxmgg=;
        b=xDe4HazH1hfsBuusQcobp7ta8wDb028Uk0oq6ThDrFP+yXu8x5a2rRdWkDmsoYqLx8
         d+6ifd41K5+6q+QK+uicUQ0wO01yr+3+vI+cDB0ruWyUebFUHy8aDQTN0PW8v1o7PSd+
         YDMcJr3QM30orkT6ZD+2yXc7FM18YR63Wzx4r7wG0huKElaeBGTp6xwH388QaKJHbMaZ
         agtAVON2ueIUKaITArXO0JklQDhZrUWe9XkW/qpst1ZiZgxacKu0Vswc5J5ygRUPJhks
         0A36qY5JzNQTlP1dhOyB0ZhskZPMxNI1zNspEa/KJcOTLo0zXJKKcvWRbR+QNVBP6VYs
         r/Og==
X-Forwarded-Encrypted: i=1; AJvYcCXkxs+L+sABXN1WjAHBaM/JFRAJXXWiliJVCArjDnabbjLEKmD/r873xnf9CE97gzb48bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVlu5Gf9YyrDtDxcOvvjXmvBxUUDi8i1Mo1HwmQLN58HBPeXF
	wAeKE+Hmwq/rpGoGeEQPHe6oWKykUptjKTYl+L/lKIAlADU5nPKcKPVBRiLWlu8vpxI=
X-Gm-Gg: ASbGnctZfH8cBbkGrbZje5fFrWgIGFijhwn5A99X/xn1ZFs9FxoCHxkYgqdndUEA897
	ohVz4UmY0rVap6B5tdGeI4bS9YcZhzka0i9JiNv4IPOJMw9qFzAZuaYlQ3gwCrdb60+kqH7OL1M
	BHvRMJIP9ynz5aOvPdTp0WUPYSENNfJoRtmuH+C9cNLP0igmL1EGecznScljtiAPOkvBG3lCaPU
	/qnHhBj39m8MSkR8WUL7dH8MnZE5MErTqWoKiBN/kesNDpD/m30eh5rUqf94OESeavVKbGx2b1i
	/ynLqy8lS4CtBOnnIIQrOS6uEDnEhxE8kUbQqrT6anctcKTD2hXy7EVxmKpB1s5O/eCkJGqNip+
	56PCZErUgug==
X-Google-Smtp-Source: AGHT+IEUx5APZLq6OjlaznyDBDOH/iPyposgoiJCV+Ln24G++5Y+XOzZSNv7ksGjX7KHB7oVIwGwzg==
X-Received: by 2002:a05:6a21:32a7:b0:220:658:860 with SMTP id adf61e73a8af0-2207f2066d9mr656596637.12.1750799453406;
        Tue, 24 Jun 2025 14:10:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8850c6fsm2701652b3a.114.2025.06.24.14.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:10:53 -0700 (PDT)
Message-ID: <55bdd85e5db7dae94016ae57bf2d1ff233dc0881.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: simplify code by exporting a btf helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
Date: Tue, 24 Jun 2025 14:10:52 -0700
In-Reply-To: <20250624193655.733050-1-a.s.protopopov@gmail.com>
References: <20250624193655.733050-1-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 19:36 +0000, Anton Protopopov wrote:
> There are places in code which can be simplified by using the
> btf_type_is_regular_int() helper (slightly patched to add an
> additional, optional, argument to check the exact size). So
> patch the helper, export it, and simplify code in a few files.
> (Suggested by Eduard in a bit different form in [1].)
>=20
> [1] https://lore.kernel.org/bpf/7edb47e73baa46705119a23c6bf4af26517a640f.=
camel@gmail.com/
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

I think such cleanup makes sense.
Imo, the patch would be a bit simpler if:
- original interface of the btf_type_int_is_regular() is preserved,
  thus avoiding most of the changes in the btf.c;
- helpers btf_is_i32 and btf_is_i64 are introduced for external usage.

E.g. like here:
https://github.com/kernel-patches/bpf/commit/d3c003f0a83cb66700f6a6e9b750d8=
e425b53cf5
(I use btf_is_u{32,64} there, but it should be i{32,64}).

Nit: the subject is a bit too generic.

[...]

