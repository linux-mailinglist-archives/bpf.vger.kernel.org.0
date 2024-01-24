Return-Path: <bpf+bounces-20246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9BA83B10A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAEEB22F7D
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4EB8002E;
	Wed, 24 Jan 2024 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChkJHH6H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F47811F9
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118208; cv=none; b=rUjNdrAAYojE89cvDbpuqxVEUEWIM4XQNAI+c8syA2za28WIejhu0AW7+PDc7QVrlpXXLIkeA62C+zN1lEgRgMjFem3US48nQ5qnoBElwdJwXjC+zrnkeyjLb2vvrPDboDxGbUQ6vsLX2ZhZnZ3H+d+TS1YeTvApJGggdUw0QE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118208; c=relaxed/simple;
	bh=xuQROw/hwtBfPRlaiRvOkvn8Qupqyhz+6U0gOeQnfDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRbQcHAr89eWJUJ7LBYec2WPwIg1yxaSrm4Vgg+zd3VgJZRIqHgY33CZpjqe9SVMAoLq6Ei6ZWpzzP5LO63TAgLj0bbfDJ91IxGzbr6jltRyCzGQ2iCIuV7BEwDN8Ox4wF2Oiyuj81kJINWvBbe/JvHjTHxESMYbS2dF0Pza4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChkJHH6H; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a315522e251so30001466b.1
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 09:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118205; x=1706723005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnrTmYtHnDTLm3ey0X8GiRCnD+Zu4kq0T5aFG1gHUww=;
        b=ChkJHH6HU30AAZabGKwsktbQ8MIZrbogADIBtlGhJo86YDb024+DF9qSoXd8DKA4Ex
         dM8PU1sl91yNfqUg/JYHmmuwoDF0zp8qMzZ5oWpC9XWLDs8DzW5bxCOneZ5xzhhhhnK/
         /6WoXgGQGqjgtC2lQLjrz3hNttQ3tY7y14mc0fwbhJME96WU1FvZBNA+9WbHqdeT6k2+
         qgcfqIdpBzkUy0h1+nCFMPO89x9xl2WqjeH5cZlwxTJ/uIgtjADTvkJH3tqqPJZNqWG/
         0cmx2/8QXA9DCRtx8f6/wt5brdzDkIeBWBNu6UaIyLFWnEzFC6krjJ3iNYDocDTI6uZW
         r+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118205; x=1706723005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnrTmYtHnDTLm3ey0X8GiRCnD+Zu4kq0T5aFG1gHUww=;
        b=qI4QaoLlDaX5fezwiOLk8vIyulH8aVoSzEEW/E/ORh8Ul+L9DUI30v7NmZE7MamTA+
         tJmlh+n6Ye/0iER4f1ZauZygNWx8kBwPUmZB5UzvciQij4A+p89PHtSRIrf21k/iv/hL
         d4+tHaQfuJ9A2stAVV1AbQ3dRI4UNqceYszU5nPhrtJixaFfaUb95tcmUOZ/juyXoCJl
         Oot+jx/SoI5hA9nXV8w78bCOE3F6HNVHpjFPIhFIKthMSlLq8/MWA1oLz1eJK0GqyERJ
         uau47nQIVd3lffsMuIY4pKXT+QoOnI3toZHM16tFWe0cOp33HexPUt6owP6T+tvamsth
         rYGw==
X-Gm-Message-State: AOJu0Yza5MlSlBNXlKOVMVP6WE67sGugnntc2rJu53t5hZKTmfOKpJfx
	+a1bbdVgiupazsEEJQ+/6zEYHQy6t7MVFQPsBUD13Vd33ah3/fgtmzquNc/GsH1r+sIgZb9Lkve
	tlSIF+9hCgOfdWDkhzSvkU+HxIR4QPukH
X-Google-Smtp-Source: AGHT+IFPbu4hjoZe4ypZeKGKKS5ngHhThFNk59uxLvIkfu9Vh31l6DV6vj19eLZShUfZI2LP1kzEsGnyIqPDwo4WiAI=
X-Received: by 2002:a17:906:46d3:b0:a2f:7876:5770 with SMTP id
 k19-20020a17090646d300b00a2f78765770mr861209ejs.70.1706118205219; Wed, 24 Jan
 2024 09:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123185945.16005-1-jose.marchesi@oracle.com>
 <bb8b375a-fdc7-40db-9ebf-ebc89a12f5c7@linux.dev> <87cytr2l5y.fsf@oracle.com>
In-Reply-To: <87cytr2l5y.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jan 2024 09:43:11 -0800
Message-ID: <CAEf4BzYk1Sr5srYH9z-b66drhK9QFKFbOAVacHD-siay4rKUOw@mail.gmail.com>
Subject: Re: [PATCH] bpf_helpers.h: define bpf_tail_call_static when building
 with GCC
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, david.faust@oracle.com, 
	cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:25=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On 1/23/24 10:59 AM, Jose E. Marchesi wrote:
> >> The definition of bpf_tail_call_static in tools/lib/bpf/bpf_helpers.h
> >> is guarded by a preprocessor check to assure that clang is recent
> >> enough to support it.  This patch updates the guard so the function is
> >> compiled when using GCC as well.
> >>
> >> Tested in bpf-next master.
> >> No regressions.
> >>
> >> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> >> Cc: Yonghong Song <yhs@meta.com>
> >> Cc: Eduard Zingerman <eddyz87@gmail.com>
> >> Cc: david.faust@oracle.com
> >> Cc: cupertino.miranda@oracle.com
> >> ---
> >>   tools/lib/bpf/bpf_helpers.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> >> index 2324cc42b017..3306f50c5081 100644
> >> --- a/tools/lib/bpf/bpf_helpers.h
> >> +++ b/tools/lib/bpf/bpf_helpers.h
> >> @@ -136,7 +136,7 @@
> >>   /*
> >>    * Helper function to perform a tail call with a constant/immediate =
map slot.
> >>    */
> >> -#if __clang_major__ >=3D 8 && defined(__bpf__)
> >> +#if (!defined(__clang__) || __clang_major__ >=3D 8) && defined(__bpf_=
_)
> >
> > Do you want to guard with a gcc version as well here or you assume any =
gcc which supports bpf
> > should be okay here?
>
> The second, because GCC versions that do not support
> bpf_tail_call_static are not capable of building the selftests for many
> other reasons, so there is little point to support them.

bpf_helpers.h is part of libbpf-provided API, and so it's going to be
used way beyond just BPF selftests. So I think it's prudent to guard
with version check just like we do it for clang. I assume you do know
GCC version that is meant to support this?

>
> >
> >>   static __always_inline void
> >>   bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
> >>   {
>

