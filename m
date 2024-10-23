Return-Path: <bpf+bounces-42932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1AF9AD243
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945B1B23CBC
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE0B1CC150;
	Wed, 23 Oct 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLpETILP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D11CC8AA
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703594; cv=none; b=U87Sn0NIOn4AXvGoqZo8HEtwLiSk+h+vRnl9lGnFOSfq+qFLCg3Y88H22VArl5Me5wRS3zqaDVxeE/ihLhiFR5AzPwof2iVz2QCEyguyMHAdx3S0WIAYAft7e8WPVXe3EtzoY+8wAXFOXhRad2tzPEX+GM1qZg3XpQJSH4W3VWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703594; c=relaxed/simple;
	bh=dDMjDZjHFgwPfpoJPxh952KQSutdK4woFOP4+28pFL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXhb/jCJUk3MwLvxJN77B194cocbWQzXay21LzkRXCf073A1A9P4ZdhpciW0VvbV6yHDzIGdVbe3oCOpcs43mrUJYghUzkY8Gj9mvU7KgAQCtwS9teKaKBaBXjgtt0jxsuE5rv44OrFo9tZUS1diHgea0hbFC32FvHzrVxRTzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLpETILP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdda5cfb6so73139545ad.3
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729703592; x=1730308392; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dDMjDZjHFgwPfpoJPxh952KQSutdK4woFOP4+28pFL8=;
        b=YLpETILPtvU0zdye/QFp7ZceRVLjb/7JHATv/Yopv4CoHDfacMposngSbGjsAHvSv4
         AbkfOEqQFVHVyqahCEUffZlUBSpYvDpYDgjfV70UgWlSlBv+GQu/b0kN+SWZZACgWpgP
         VBNo7dHBGwVOPBOm3h8lrpLPO1RjyhqNd40X6K25YlhUB139j56hI6vDT6dB0zdH/cqs
         PCwQQdIds8aWV61Maa6+CRMFKD+wSHiG6ufh2iCHg8kPWVgZ9yXtRhpuBol4GkNApLH2
         B5jJsI/4MWosDlo7xtOuxHcV7AigIa3cjnR7mi499m6dGMf4wW2HdK0lyZua4jP9cK9I
         CS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703592; x=1730308392;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDMjDZjHFgwPfpoJPxh952KQSutdK4woFOP4+28pFL8=;
        b=aqMPfckQxEtLrvIIps2WdrVwy14rw8IQnHsB5jpJazLE5xEoEt8Jvc2/5IKfx8hPuZ
         7uCx9EqJhUWAxxNQ8vpxCxwO+wI6VrEZthT0ygM+9IP/QQ4jwz/602rxN3mUJahnLA8t
         +/faRREsLpteXdjVds8LkrmBzKJNtWso2S4P+8icxEAI4qCXedCGCO6ONstAb2NdsR2+
         /eIBat8DuAlO9c2Pen19imRAqphEcS4d63x8IiJcfzuklLE6FKZtqSKJjxhk/WWi/YGT
         spJkPV+Rqz4V6gXHyHsx9Gtw6/lukedKMz6cDrBqVDKZmDF946WFXICOvxGL6ySUB6FL
         100g==
X-Gm-Message-State: AOJu0YzPN9miyK/GwHkKkawEsJ47jUHJ3rWoxse2lWv89vIMIw/pCOmA
	sgDLyg/7bCokti1bi8YEiwVSki8cRvvLEcOKEJyStRp8gRSFplfP
X-Google-Smtp-Source: AGHT+IEpIO3gKI9CxFIRe8oWoxjiLEafTGPgAM04pwYau/xkfC5U++KEx+rGbhQrRVxQDuaO7gxksw==
X-Received: by 2002:a17:903:41c2:b0:20c:d072:c89a with SMTP id d9443c01a7336-20fab2e0e55mr43739185ad.59.1729703592333;
        Wed, 23 Oct 2024 10:13:12 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a:30eb:d182:edbc:9581? ([2620:10d:c090:600::1:5e2d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eda2c8ccfdsm1404426a12.45.2024.10.23.10.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:13:11 -0700 (PDT)
Message-ID: <31d0895a217388dfe6bfa5b74c4b346705f894e4.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Extend the size of scratched_stack_slots to
 128 bits
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Hou Tao
	 <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <song@kernel.org>,  Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Date: Wed, 23 Oct 2024 10:13:09 -0700
In-Reply-To: <42a4ec6bccc867d18033583b1dfea0736ac1afb0.camel@gmail.com>
References: <20241023022752.172005-1-houtao@huaweicloud.com>
	 <CAEf4BzZpL7faQh61X_pqr+57qxzDD1LcxWgUqNZCCKh1z5hV9w@mail.gmail.com>
	 <42a4ec6bccc867d18033583b1dfea0736ac1afb0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 09:17 -0700, Eduard Zingerman wrote:

[...]

> > We have other places where we assume that 64 bits is enough to specify
> > stack slot index (linked regs, for instance). Do we need to update all
> > of those now as well? If yes, maybe then it's better to make sure
> > valid programs can never go beyond 512 bytes of stack even for
> > bpf_fastcall?..
>=20
> Specifically function frames.
> This is a huge blunder from my side.

The following places are problematic:
- bpf_jmp_history_entry->flags
- backtrack_state->stack_masks

The following should be fine:
- bpf_func_state->stack

Not sure if anything else is affected (excluding scratched_stack_slots).

I agree that we either need to update backtracking logic,
or drop this stack extension logic.

