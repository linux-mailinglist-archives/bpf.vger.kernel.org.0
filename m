Return-Path: <bpf+bounces-36798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C91D94D822
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 22:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4BB283CE2
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 20:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBA15FCEB;
	Fri,  9 Aug 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGGH5cGG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE5225D6
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235821; cv=none; b=QwGI6xKma7PuUggpVgcbuUC54KpBIW33+aX7LPHQJD1XJ8XOSnMxDerBJZdxearsYlK4M6/1OugqiiCJ9pRF85rhidrPuz4fdNnBE4R26oWaY6pUyDXMqQgni7ZjIkGLzmd+SiXfU55mqrGzEzGi04KTYATDKuiF6Hey7udkVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235821; c=relaxed/simple;
	bh=IKry7HoUt5Xu8xpltE/xXMpAeY620vE4cAPCOCabolg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIgbydGO36GTyWWh8UepiEJ1hXfFWlKCNYQOHK9aySiC0Qsc99zeEW9z9K/ZiWx/E7bWktaNPe31E0q02h/hTJYaLKxVHXkbuZGYgAbr2Kcf3jyaqnsyUhwq8gek6mzW9SgVtooyrezirVLtEAFsGGffJHpj+Yr8HRB8hDvYU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGGH5cGG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso2002234a91.1
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723235819; x=1723840619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKry7HoUt5Xu8xpltE/xXMpAeY620vE4cAPCOCabolg=;
        b=QGGH5cGGvJsWFbTrnie2ATKF2JEJ8RisT4NY/2Z71w/j5HEYguWfrW6wyWhMCKL9f5
         N4yQwnYH7tQtRtYO8H/8BbD05jqI3QkEI5punNV+U+wcbsJmkVQ8kyuTfL5K9w4CT/Br
         U9RIjdAMwMcApKOkWv6TcXeqhMc3VlTclOfKXwOZt72xSaYywwdaAZ5hUY7ywQlX6G2P
         MOKRHmg1nMZK9qUMbzsOf7CBeYF8rqtHJdtXuaw+hwkUME3kVwwOHNNXCeFkHSPSg7kK
         HtEjpJPRfO3fEEss74I+McCyPsquYait9PCNNyFBYr4WR0DQqJObdfQPe/708zuwY882
         vH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723235819; x=1723840619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKry7HoUt5Xu8xpltE/xXMpAeY620vE4cAPCOCabolg=;
        b=iIPbPQKN3CTY01Npwnqze95Qd6YkNmbWaRojEtU8JS3vZxAwaZp09vSEymZQQtMK6d
         k1t4mabzbLAoGYxYyogzoa8lLtWGqS4YbjvF6dwqScTI65EUzQo+1Q7jE4jz4FUkntB3
         LlY7lV4XtkeBFTnpB6A7EghUkEcfV8v5vlaVfvVsMGn1iNChbHjRIWCHjd9A0MtiNIk2
         /HaXTvClVPfqFhn9CRHIk8wFWkzOBf8yT6OSTfmsmrCvkPlgb5+ynEBgApgzL0ail81C
         3baHC8MDn/13/zjjaMrpnC7cWyKHc8TYMi/TvYjk4qWcMLTJCAQ1dfrWfMO10XKDsa+O
         muPw==
X-Forwarded-Encrypted: i=1; AJvYcCXBwxOaxcEjLE0BBbntDxL2UpnLwPMhJQPfNezLnnzX2FNoSQbQbN53kDkXPQyDqTZqvRWyB9QpnfeA7rNRHX1HetUT
X-Gm-Message-State: AOJu0YygdRPbXMi+sm05+lPBspdU1K0NnWlXFSWwzUOmZNWRm6gR2lir
	2NXLP3+4LyvFlyriKJMkM65nolGuh2WxAcwUinsVmXH5C5WwTuDYALF5axzy0ThzhaQvo2ZkhLx
	F7dWB8u4nEkM+ixbWKN8vM71cr1g=
X-Google-Smtp-Source: AGHT+IHDLGGgJ31xjXKJoGWQxGzplQstmWWpJNI3sK5dP51655KVHuwtw5y6BBTsGYHNGfpkTyiN+ZAGqUeZFsib0p8=
X-Received: by 2002:a17:90a:1301:b0:2c9:9fcd:aa51 with SMTP id
 98e67ed59e1d1-2d1e7f96d90mr2971489a91.5.1723235819340; Fri, 09 Aug 2024
 13:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808232230.2848712-1-andrii@kernel.org> <20240808232230.2848712-3-andrii@kernel.org>
 <2689ece2c10e234a2326ad4406439ad7c8d35a03.camel@gmail.com>
 <CAEf4BzZ+PKpcx+OXhr60MizW3x1dEGp5=FbC5ZUkfpg-b04hzw@mail.gmail.com> <e5d51074951cb9ff800f5255e9959c53dc4b2aa0.camel@gmail.com>
In-Reply-To: <e5d51074951cb9ff800f5255e9959c53dc4b2aa0.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Aug 2024 13:36:47 -0700
Message-ID: <CAEf4BzaYvc4zwKnHp451OZqFz0vUVKJDny+CT2+og-z2yosaCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: allow passing struct bpf_iter_<type> as
 kfunc arguments
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, tj@kernel.org, 
	void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:40=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-08-09 at 12:28 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > I'm not sure I follow your question. Drained or not it's still a valid
> > iterator state.
>
> E.g. make sure that some such functions might be called only after a
> call to next() that returned a value.

if that's important for some specific kfunc, it can handle that easily
internally, I don't think we need to complicate verifier with
something like that, even if that might have been useful for some
niche use cases.

>
> > I don't want to put any restrictions, the user is free
> > to pass it at any point between new and destroy.
>
> Ok, as you say.
>
> [...]
>

