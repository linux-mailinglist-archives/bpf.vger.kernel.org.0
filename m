Return-Path: <bpf+bounces-15242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99617EF686
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AD51C208BA
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0435F3EA86;
	Fri, 17 Nov 2023 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq0q5og5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE984A4
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:46:58 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50a938dda08so3178526e87.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239617; x=1700844417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7GkjPG2sCilJHiY2CBtZclIvLyVgM6jt2dZxBHl/Eg=;
        b=eq0q5og5wQoZpVzariNKmhQ32eHOlzBC2GsEy0JrqpoyFHSlBFmhOrJaVF5BIirQHn
         PH+Aqx0TLUPnaKCvIIVZ+G4Q2w1mpjgtjelchcZvBv9rIJtophBOZTdsvNWxqVUIZOyF
         1Cd7uzm4JCgdg8D6ehcSiXHMROA+KN1N+1LOEd1wPCQdyXMHQ9wWxdwHz1XcnYFFd282
         tDbF4K85MkAdQwVaLDLGqkiEmOqBGbXbiAXgbW6LL8+gwbhCbOUFc7aHFXJOBORFAIPd
         WltvSGLyTietP/5uNqoiTGsfyWhQ0ECiXnuuTpDR0AXJvpJhRQTRzPzxUYqq4bLkLNAD
         FBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239617; x=1700844417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7GkjPG2sCilJHiY2CBtZclIvLyVgM6jt2dZxBHl/Eg=;
        b=vVmw83kxNKm3ET3Y30QW7f5LDi6k8b6dLcBNDz4IA2VRWRWXm9XzDrZ9KN2uXvEhLZ
         kCy2mR89uxXdAuCv8mynf6NU/Y9ppLCr3S/5PmlOof2ShbnnZwNhrNhWuicrTl9TQHOS
         bEQunL1aJ0cfRx3psyzm2urPAXqrDdtbNQvnMw1p5Vx7n7ESwAGn3kYMrlmYHHt4WZgC
         kjgP+OqomLgedPKMnIQZzu+MSTIyZ8U/zZsY+J7X2GEhcMeOKk1ABhZz71tQO5lbgl0a
         i4t31ee7sOIzGeCWgbQh6OjzMVTsLcj2m5xWhxNiZcnNT8bobPjz4NYXl0CcOAPsyvHc
         i+nw==
X-Gm-Message-State: AOJu0Yyb1OhYz8tB6sbn64NAwQFo3B9j6oOVvu3xrzcuWwP2fkj6twuI
	Fohyy6s3nMrizpwj59PdF8if+I+RUeAvrL8HrV0=
X-Google-Smtp-Source: AGHT+IFsV2z7RJ7xSTPyTTyy5HM62ThXOd6bNrukw4uOLgjvCaGLJ1J9xEBopMQ4/ZXSgH+PhIhiAu5h+Hyput5QS4k=
X-Received: by 2002:a19:4305:0:b0:505:7371:ec83 with SMTP id
 q5-20020a194305000000b005057371ec83mr63605lfa.48.1700239616704; Fri, 17 Nov
 2023 08:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-5-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-5-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:46:45 -0500
Message-ID: <CAEf4BzbMTucD7ZMVCf6Uwcqmz8sUTqoGs4JLC2mkA9yo4LfUkQ@mail.gmail.com>
Subject: Re: [PATCH bpf 04/12] bpf: extract __check_reg_arg() utility function
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Split check_reg_arg() into two utility functions:
> - check_reg_arg() operating on registers from current verifier state;
> - __check_reg_arg() operating on a specific set of registers passed as
>   a parameter;
>
> The __check_reg_arg() function would be used by a follow-up change for
> callbacks handling.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

