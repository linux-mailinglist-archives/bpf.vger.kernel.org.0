Return-Path: <bpf+bounces-37570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7237E957C6C
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 06:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007102847D6
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 04:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E94652F88;
	Tue, 20 Aug 2024 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LIn9pyw4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2628371
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724128436; cv=none; b=Z6eAd/lYT5f7mpPvVuo/A00jPwT5kxlBuK6CrQgm54eLPZKTfU5yFmNyh7neVm/ww4Gk9J8TZeT9larpnhrYjgrnRt3svw/G/pQvA9C99l4U1iNtbww2jfJWaqaysk9BuhwN4Ro+mzWCIYWLMHYieWRzT8hYKfVSAnC5+e6m68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724128436; c=relaxed/simple;
	bh=zhEqPS7GHdqMJse27lQWRdYXUw4ubv7uqJ7MGu3CeTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6T3NOS9BxahXu8E3oc/d53g6/M6tmLuN0NqtagMgZlRe0vjv8PDnI9u1RkkwaxA3w/haxtvxkmfnh6ZyWvDMl7r/IM5BWdszoNK1wjkPKFLuteaNlH0gX0S/5V15usjeK3JId6NNCFIkhjaysn/kbfqSLYukbAIlVGXh8pcEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LIn9pyw4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-690af536546so50388227b3.3
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 21:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724128433; x=1724733233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh2PCGc+K5cunZ/qwakjKSHo7lYNiPsK7m7qg92LGVg=;
        b=LIn9pyw43fb0C4ZzlT8si3gLUOhYL0mc68nQKOttGfcYNAifN811QqU3b5hg3Lcb0k
         +5Rm9yRXm1bagooRrHia5fIU8ItzxecFhDd8Dd6G9Rtra5Tmn1+6QtlJF4nvc1XDZCSC
         DbaNKg7UM4Zbm4rk29hgfPrDAmdfRgPG9y2lAMzJln7W3LQKb5C6lpLcemEqM3PKOcBL
         9YCNMhGRBskgD4jtXrNgF+zfExX6K9hchppmG+HPNPGZaK7WlyISCSneSPhlTAlLZXWZ
         LrPTCrJbM0IsLJwj4MnJhIbzPVFwUZfEAhJqIS/21y1r2tmCa7xSyJSI/J9r1YVzZ2aU
         44GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724128433; x=1724733233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hh2PCGc+K5cunZ/qwakjKSHo7lYNiPsK7m7qg92LGVg=;
        b=dwPh/s3V83JFIU0+7sNDTb2V4lrtTsVpbQUSnSTXXCCOvR9bzArZPF78McXNOXrvRG
         9tt4dHl6EfnyRN4l9s/L6zYo6P+gI/rwO+yMUBsHrNxS3cv0Yi5MpopRH1cxrwHtEI4m
         hSx4QznwTFqVAYFRpZt6daBb1hBLj2JKW9pBCYxfGsCW2lJTwBdUDP4OdW05IJrVRG6u
         uCjpsQecAsgAlVPyflHxcYQtYTfcv9bQcrKsGmZs+m5oWSkdJzEa1n3DiFqeXo0jobdn
         XK6/moE5zPOmB4Ld6RGArPP6ekDCxui9x14f6lCp9j2kFD0eEDo7Pq1Ub9HFNgqAvaQI
         CYlw==
X-Forwarded-Encrypted: i=1; AJvYcCWzYq/X6q/2w4gVwnCfB2MGy6ZbUC+r3034sieucAXD3zRE0KPDNyi9/DStMHrWNB8irsH5vMsljUvGatK2vfaVAplj
X-Gm-Message-State: AOJu0YwWTuFyCpj2kEYIFMkcsIiy4mR2cjtJBEQ2I64Vas7aIvjdl9Da
	PGiTk7cQcR3B2TOTpeMFKlVFahPDHLVG083DlB5L9xSrOzXSM+k80YEvJ8fWbscEWFYR1bbseWb
	qZDQSdzGQLBkHJDhHN2P+H/eFNqpWBRlV/UmO
X-Google-Smtp-Source: AGHT+IEcPtboqaqxuboCIBCdC2X9+UGxp2JXC5GT31PipGlZgu2et1276RlQgUB9DQ5/QRmlNmCw62lsYgGo3+0pnk0=
X-Received: by 2002:a05:690c:6ac7:b0:6b0:45d:bf78 with SMTP id
 00721157ae682-6be2ef29217mr11133857b3.36.1724128433327; Mon, 19 Aug 2024
 21:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816154307.3031838-1-kpsingh@kernel.org> <d95d9cbe-54ea-4e85-aa63-4494508be5e7@roeck-us.net>
In-Reply-To: <d95d9cbe-54ea-4e85-aa63-4494508be5e7@roeck-us.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Aug 2024 00:33:42 -0400
Message-ID: <CAHC9VhTAkifc5+Ka3keL0=rUwfU=S=pDXh4mqdVxJDUwD-swsA@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] Reduce overhead of LSMs with static calls
To: Guenter Roeck <linux@roeck-us.net>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, casey@schaufler-ca.com, 
	andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net, 
	renauld@google.com, revest@chromium.org, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 5:30=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On 8/16/24 08:43, KP Singh wrote:
> [ ... ]
> > # v14 to v15
> >
> > * Fixed early LSM init wuth Patch 1
> > * Made the static call table aligned to u64 and added a comment as to w=
hy this
> >    is needed.
> >
>
> Applied to v6.11-rc3, together with several other LSM patches from linux-=
next
> to avoid conflicts, this series passes all my qemu tests. Feel free to ad=
d
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks Guenter, I appreciate your help testing and debugging all of
the different arches.

--=20
paul-moore.com

