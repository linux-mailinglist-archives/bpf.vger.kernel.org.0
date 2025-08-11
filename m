Return-Path: <bpf+bounces-65398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB22B21809
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 00:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591551A22372
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309C6219E8C;
	Mon, 11 Aug 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXv0raRc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4417E4;
	Mon, 11 Aug 2025 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950590; cv=none; b=F8KCX1MjuOFfVJE2Jps6yEkwdqe7JrinlW8xnpeGe8snmaXDP4xLKLJXIi9qopWs4BfvudnEkjvvGhkzpINyO88Z8XWVVRPUnHzJvM+bmW1Tp4PYutQO8ngR4nVqTiFWwNQNbEzi3C6nyaXvTaN5dRvWTmlgfbWFNZzaYrtvQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950590; c=relaxed/simple;
	bh=M2D1VRoQ3zn0PyM1FfBVHiFGryUV41iVco7i4VJJfmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQDDc6uAgMcX+TdkV4LwvrMkq0EgdPEA7YI3hCMNeOedJBRIA2DPHbUD8poe+i7+VoAbAOA93I4xocJZjoRGDQx7iz1viWwHrJ7eFdz3oYqV8FntlZf135a4pg6yhQg3WlSD+8OfjnZ/GKyOuDA3yiduyvsTmTGWH4eUJ658AM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXv0raRc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bdc73f363so4294129b3a.3;
        Mon, 11 Aug 2025 15:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754950578; x=1755555378; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WoTD4n8WjzNT/Sh1Fmja4gNj3IizNwY61c8ct39qSv0=;
        b=EXv0raRc8RgVmS+oXEozzbmlv8s5XtRuu1Sq6ZacytwQfPM2chgj+v4bUUup3Bw28+
         DvRRxBYMe3K1fmrsEgFmmzKnnpc2takm7jISmjh2yLljtLmcKYPJhzR2qHrYyeb6HwuE
         dRNPS4j+Y3A+t+h7YKywB0J1InrwO85qhruIl/1K/33g8+vRKTBp2CaYRglv+U8vBNNc
         IFQO9MuZbxq17yFJtALJBa/FrDT9gewmueYIp/8fmpXzIoqIaBa3NsxnuycjVCmRddj/
         cebn4mnF0alhrMssVUKYlS/iQPAk6ik5GWO1Z8BgQcSzIwFuTpacSzk1IbG+q7mXlEkz
         Uf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950579; x=1755555379;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WoTD4n8WjzNT/Sh1Fmja4gNj3IizNwY61c8ct39qSv0=;
        b=As2c95YrvpQsxb4xPRl+Y7G/XjhWdTiMZuFeRPxota5nvbeb5JddqbcxA9IIphcoUD
         iDKVyJeAFzAzp+Zlcqt0pkWbwKkzrqt3YOPWkscU+6LZVHGCa6s5nqZHWTAAOreKmJi/
         Yig5euWnsDCce27j5rTPkBLlSOddcdL7ZedfGookVfNQU1nddpTKwArySG6pSelXvN6/
         FU8rSgBr3rUREtKrLGrI1O7wP9k2VeTyjEoLUX6siwLulrNbgfJCeqks40U2kZ7oMns5
         MoRWXdiTzHO0m29jtQEPzFFP3yB8+MA5+BQ7K3y7Q3el0kNWbrLelUb4FByFY9I8cwCq
         nrMw==
X-Forwarded-Encrypted: i=1; AJvYcCU/am33Ld7IxVc4gOrmc0L0LdvfW3gNCs/1jLo91jHYPTp9DsnAqwma80gm9LuVgirc1h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigTRgwKlAat/gzVjmrtj4E+OiVCYE+lMl0PxIiWokq46kWbDM
	OF4rS+ekJc/1yH23FkatTRSEhJnm0pwn4WOXjGpVfOoayEqGondQRlH2
X-Gm-Gg: ASbGncs8YamUrTzBvNbmmx/Ace8hScq81qy7kBS7XkPzu/in4tdIUSNOEG2/fL6vhXW
	u3w28kPS1HX6Uyg3LeFC5/3w4RS8fQviQMsySx6TLNcQtWwt3P/KKj94vuQfVOq1BwEiGeRehbx
	JOOidPDx7b5lNFKYPpbLwgjl+ye4XBdN4bBctjg9urtkdK8GdjLW1CJkJTiSrqNKvqHQLcxZILy
	MbtgyIK50JbPrWV5XNvyHnne8wPOQLeep+nxdsbXyfoJpVorH6KGNMs9NNwa+R4mVk7GW8WnYH3
	kY1xYWhDUlIkRrgF9geSwWEFnXT9XARQRV/+Ah5cRtOzmAZaxto/3nBStu6TpwnkNzFje6a8u+b
	ErKtmPqE1sonL3yqwh9mL9Apdvu568ZxhbXZsE04LfVh5
X-Google-Smtp-Source: AGHT+IEl0lxbbSVaV2tH4whp5zAdZvYxAUsCl+JBfkoAVSjYRB35BOEKaBR9mmB/TFhF358zEX9eUA==
X-Received: by 2002:a05:6a20:7d86:b0:240:1a3a:d7ec with SMTP id adf61e73a8af0-2409a880f54mr1574435637.4.1754950578552;
        Mon, 11 Aug 2025 15:16:18 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:129e:4a5c:ec89:efc? ([2620:10d:c090:500::5:43c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4384baf139sm5887003a12.36.2025.08.11.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:16:18 -0700 (PDT)
Message-ID: <efc1618c4d24e6c80aa51f61981bf6a24912cd97.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use sha1() instead of sha1_transform() in
 bpf_prog_calc_tag()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>, bpf@vger.kernel.org, Alexei
 Starovoitov	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-crypto@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Date: Mon, 11 Aug 2025 15:16:15 -0700
In-Reply-To: <20250811201615.564461-1-ebiggers@kernel.org>
References: <20250811201615.564461-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-11 at 13:16 -0700, Eric Biggers wrote:
> Now that there's a proper SHA-1 library API, just use that instead of
> the low-level SHA-1 compression function.  This eliminates the need for
> bpf_prog_calc_tag() to implement the SHA-1 padding itself.  No
> functional change; the computed tags remain the same.
>=20
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

The logic seem to unchanged.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

