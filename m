Return-Path: <bpf+bounces-27828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027978B26F7
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2934A1C233DB
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D866D14D70C;
	Thu, 25 Apr 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mehYGFRu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319FD14A4C3
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064199; cv=none; b=tT/TqxqZD4RxL5hWs2ZgvHXVY0QCIfaX+IIwxZYEBvzqWNVcmXNosKE+IKjZnThA3fhopP8/EpMkRCcbfeYLeT0IgfU5sYNAcYqwfVoYrv1YN/CB5El9rES3fNNfvmGzE8dfW/hSBcpcYBib5/0UHLxYHZHqGETxNcDe8w4fJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064199; c=relaxed/simple;
	bh=NsnmQaSybMjTBqvval8U4fh837A3fmsRSanDZtcKISk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uqn9eMc2Hxk6UuffTRt1sspVVmV/uzlHB0PnqmsCrU4w2HTy+xmvEjgw7MtIzCbV5Ur/pQzKcmjzAyiqjTut09n0h6N2CQyP1zCnvEsNuN9WPjFd7VBAwNh0/sDr228rc4Y9INI0GqtS8Sh1VOM1kugj9oHP6MBFDDC8XOlaiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mehYGFRu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6effe9c852eso1081910b3a.3
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714064197; x=1714668997; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JJDg/o+FyVBFFGbYDVOWUbSroPfLtTAo1OWanaBkHNY=;
        b=mehYGFRuimpHRsoQRFfbxROAvrCkawylgpuK8j9Q5ed7SVhjXDPtgzSygLPW2ga3RU
         8E5Zh5A/urZFKgPYOVs9dT4PBpoBnmdxURJRrLYvypFWtiGkmeQW4dTbjeEqyUeShs61
         bsVgr6XuAxeJA+x23gOuy8XM8o7yXeSoOx1Qr9mQ84fOsUBfAsMBgnrGs1+QS9qTR7EN
         PHuAtipxlOOApYr9TISEw1Q/hdEKgeZp/U9tUBJnIRWtI+xFYYHuevaMHHTXSf4JYXf9
         xVo9cIvLz+fSqn3g/+GPEZVlIrUkOyEm6bQYvFQb0SvrhYVeO0+PnRKyfkJEjyLbsQKu
         j+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714064197; x=1714668997;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJDg/o+FyVBFFGbYDVOWUbSroPfLtTAo1OWanaBkHNY=;
        b=pBDdPmRCjx1OpWmvKh1958QFK4cFdhVTNWmRahCb3HQW64JPNS/gRFm+t8nzbbo0j+
         n7+LC91AoabB7vljQU+sj91tkxUYrYmtORYl8UcRmJw/S4yNztlYl7CiWTdH4H2+wci3
         eBv0Br9GqmYKcIJSMJt8JR+HEGkAriAmazmQaggI6+0yIHdXETWUVBfI4a+3AR5Lrhk5
         D4ufHRZZThJv1n2mLct5fbVrmU8QH3CHitdGPd14I3DhbB7B71Q6ljOkEuDGKsM63S3R
         ZojqXyN9zoCNqi6drJbcistJBwO2cbZrvao02XbyFDdPjrjhDCyHb26Ky1wWpjn29JYu
         0mog==
X-Forwarded-Encrypted: i=1; AJvYcCXLOEukbI4UOJMIvA9mMcgCyLqy/azqSb8TuKJNyoIxCUkqkTJLb1IxXbdLmDWJAmJKyhSsgvjMzZjB91adR/KT81H2
X-Gm-Message-State: AOJu0Yw/jOxhTHvpjYcMwjdya8sXOXrYleClc1KzyCJ+8tptLUun4ukq
	AyJ0RtNpsyr21W9RqVPKIYSSsfdmcJxXe/i0duKImY7LsSq3AJZC
X-Google-Smtp-Source: AGHT+IGfc2fjRsfVIBIJPUrScgvGS0Ft/lJ9NjFA5NawlD2Io8cEMIkdF2lKYM4NHW8Jm5J6Q8wvqg==
X-Received: by 2002:a05:6a20:4388:b0:1a7:431b:541f with SMTP id i8-20020a056a20438800b001a7431b541fmr273110pzl.50.1714064197368;
        Thu, 25 Apr 2024 09:56:37 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:b5d8:5a56:aaf7:f817? ([2604:3d08:9880:5900:b5d8:5a56:aaf7:f817])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm14212830pln.154.2024.04.25.09.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 09:56:36 -0700 (PDT)
Message-ID: <c493f6d93bc7bc8162bbf01dbb4ce5d0b7a7f084.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf/verifier: replace calls to
 mark_reg_unknown.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Jose
 Marchesi <jose.marchesi@oracle.com>, Elena Zannoni
 <elena.zannoni@oracle.com>
Date: Thu, 25 Apr 2024 09:56:36 -0700
In-Reply-To: <20240424224053.471771-2-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
	 <20240424224053.471771-2-cupertino.miranda@oracle.com>
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
> In order to further simplify the code in adjust_scalar_min_max_vals all
> the calls to mark_reg_unknown are replaced by __mark_reg_unknown.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Nit: if there would be a v4 for this series (hopefully won't),
     please extend the commit message with something like below:
    =20
  static void mark_reg_unknown(struct bpf_verifier_env *env,
  			     struct bpf_reg_state *regs, u32 regno)
  {
  	if (WARN_ON(regno >=3D MAX_BPF_REG)) {
  		... mark all regs not init ...
  		return;
      }
  	__mark_reg_unknown(env, regs + regno);
  }
 =20
  The 'regno >=3D MAX_BPF_REG' does not apply to adjust_scalar_min_max_vals=
(),
  because it is only called from the following stack:
  - check_alu_op
    - adjust_reg_min_max_vals
      - adjust_scalar_min_max_vals
 =20
  The check_alu_op() does check_reg_arg() which verifies that both src
  and dst register numbers are within bounds.

[...]

