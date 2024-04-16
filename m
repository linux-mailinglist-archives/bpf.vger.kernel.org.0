Return-Path: <bpf+bounces-26885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4558A62DE
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 07:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1688F1F2400F
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 05:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B29D39AEB;
	Tue, 16 Apr 2024 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JARV77tA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A459F1CD06
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244383; cv=none; b=BzH9xNLcnAdNoMnBf8aCjLesqbjk0b84uZbR/HBcbNusykN7qntT2rw/2JqPecF4hD9JrL8QP45C8VHEd6EHH5Oi1s9yTEWhQl1zYNDSVDLFJ5r7HZlDKauBxHg0g0h3Yhdto+TY2DoV3zXm2UeqNz0Gu6uz2DKPr6p2CJ6Llbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244383; c=relaxed/simple;
	bh=wWqbcDYzIUafz/DfQKOVHCF2VBl/W280Mg1YuSgZuTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBlSbhGJokMgFK6rEWhOrO29bLTRHvx9thHVG5wn/qDCocMUM6TjB2EV0EXrAtZ7AbydaT9vq6AvcohzSs9xyzgzz+SaMWvOzh8jV7sp/O17xd4unTYYRYXJe4ID7Z+UftqtkGookfcext0i6DUZC8ZYNgVnCHzrG7A5Z+rbEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JARV77tA; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23333dddd8aso2349774fac.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 22:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713244380; x=1713849180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWqbcDYzIUafz/DfQKOVHCF2VBl/W280Mg1YuSgZuTM=;
        b=JARV77tAi3sPPHEZ5j1oRMuIvOdpWgLOK+LxTEOfIQVh5SK7KZSfsQqnvKAC2Q9O2s
         lQlAOHCNhbtRKkP6YSUq7wbGFAwsG4aUV7On20gTnd3s6nqfDD/kchvJdYNX5S0Dvdgv
         3PWnxcMcWWezQd+Z3ubkfSwyDp//EMPu0nKR9u1g60/RJmmSAlJ2jJjqijP6vzWzDKRV
         Q1HUGzBG+Nt3CA+XPAkz+K4ob7DeOrvrqZsl4MUxKIgx1ZUEaNuitackrrPjiPKJdqv0
         7VKn2J8dovSv6aFGCW0bXoLzBuccsj8vtLnN4FzgHx/m0hrqJ/9VSZSS0krNhnFNZwh3
         nMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713244380; x=1713849180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWqbcDYzIUafz/DfQKOVHCF2VBl/W280Mg1YuSgZuTM=;
        b=fO1je9EltPzC8HBz/WJbqiCBH7eyWOoJd4QP02ZYt9RrJAEf46MfTUH16W7xeKfDKc
         ECmjlfZpGePf/OMkGYSu+zJ4/D5Zoz7UQO8oESZOtYVxEyAho6IMDoFgam7HhvZsql5D
         E9c7FILFlvBEsGDbe1DYK+Shsz1QmkBo8T3iJu55nWWirGn8sJ7Q13b/LwN4+qdb/Hmn
         SAQjS4X+Ps9XCXt+0dGI9F339r0rETZvwWCncCMWXThFor0j8fsoAkjMHIcn62Iphu+v
         f6wncavto06CJDOWOc41fiLkg+O0hp7GN6vjyfCCswfBfZj3cTqTwfEySgQ6M4WZPSny
         94/g==
X-Gm-Message-State: AOJu0YzxHvvsGJY9zNQmeCkMXnbsAexVaoly4f9b0bSpDooLbVFbheBa
	i8XEJji+to4SwNl4JK0kDsHjL4nLDYGJLf9qvPIP/FwQ0/wrbHDC9EC7LN/VDJqFoJVfby5TERJ
	m7ZnrJkxUUR3TJBJVMA9I0SnS3JHucRhk
X-Google-Smtp-Source: AGHT+IFX5huU2NWdNyDiQTDoTyiNgNRsN6kQKRcoo8YaUqg7gmGo6W/0p+ZYGEqAMxOTC3VhuFrXMZEkV81KCVjdLdg=
X-Received: by 2002:a05:6870:1b17:b0:222:90a1:596f with SMTP id
 hl23-20020a0568701b1700b0022290a1596fmr14411495oab.49.1713244380584; Mon, 15
 Apr 2024 22:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36c8d494-e1cf-4361-8187-05abe4698791@tu-braunschweig.de>
In-Reply-To: <36c8d494-e1cf-4361-8187-05abe4698791@tu-braunschweig.de>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 16 Apr 2024 13:12:49 +0800
Message-ID: <CAEyhmHQZD+F=dJTS8Pywp6vyKfo0Fo=O4Ww+8o=6+GwJ-WogLQ@mail.gmail.com>
Subject: Re: No direct copy from ctx to map possible, why?
To: Fabian Pfitzner <f.pfitzner@tu-braunschweig.de>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:41=E2=80=AFAM Fabian Pfitzner
<f.pfitzner@tu-braunschweig.de> wrote:
>
> Hello,
>
> is there a specific reason why it is not allowed to copy data from ctx
> directly into a map via the bpf_map_update_elem helper?
> I develop a XDP program where I need to store incoming packets
> (including the whole payload) into a map in order to buffer them.
> I thought I could simply put them into a map via the mentioned helper
> function, but the verifier complains about expecting another type as
> "ctx" (R3 type=3Dctx expected=3Dfp, pkt, pkt_meta, .....).
>
> I was able to circumvent this error by first putting the packet onto the
> stack (via xdp->data) and then write it into the map.
> The only limitation with this is that I cannot store packets larger than
> 512 bytes due to the maximum stack size.
>
> I was also able to circumvent this by slicing chunks, that are smaller
> than 512 bytes, out of the packet so that I can use the stack as a
> clipboard before putting them into the map. This is a really ugly
> solution, but I have not found a better one yet.
>

Have you tried bpf_xdp_output() helper ?

> So my question is: Why does this limitation exist? I am not sure if its
> only related to XDP programs as this restriction is defined inside of
> the bpf_map_update_elem_proto struct (arg3_type restricts this), so I
> think it is a general limitation that affects all program types.
>
> Best regards,
> Fabian Pfitzner
>
>
>
>

