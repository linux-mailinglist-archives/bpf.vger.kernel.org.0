Return-Path: <bpf+bounces-60423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FDCAD64D4
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 02:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1334C7A2E55
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 00:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934597080C;
	Thu, 12 Jun 2025 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/QWduL8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11344C77;
	Thu, 12 Jun 2025 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689898; cv=none; b=qmSMm3ocEkc9xqfy3hT1SwY2M62m2PmVh4TfFcHm6Hgdhptbwz0ttaSsckUVWKsaflIXKDQ1izZaqVbC2rSWtYI4BKwJCPWW8Y7ovlAH56i+7iyC+lQ9bJc2BxOcX3g3T7HtImSTRo06kErh6H2h0cyM3WzlCI063aNjOJBJsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689898; c=relaxed/simple;
	bh=Co1a1Nm2sB+Th7aev5P7Jvlh9qoQfqU992/CpUH4hro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/h1UenPhCtqLpHMd6EwQ/Ur3EPePbmiElbsXzovXRNXQ1JHUf2wgbpX62OoZxxRaRMi/IosmAbPNtoikFSDtYo4by7GwUzBLS41Eh1AokGwVxwMXDai8EAg9WTkyP2IoFQV7oEMGuOUmfeK1d9hRu+3pLdkECb6hKHPPb0QdBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/QWduL8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a376ba6f08so253829f8f.1;
        Wed, 11 Jun 2025 17:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749689895; x=1750294695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co1a1Nm2sB+Th7aev5P7Jvlh9qoQfqU992/CpUH4hro=;
        b=L/QWduL8QC+K8aqNGWmtha9N/uPUxLT12eYhITPlfVWQf0/0uIsj/ea9NxwGuvYndq
         cSM/DPDxeU1mLWsMvH8da/k5m4JnC8UBVhOf9p7gCYODHX9xc7LffpTkiSj3izrcmpDb
         HAAVmkMnxftINuiIBem/K3cQu+vGrqmIfX5RI++8a4tu7p+ZR8DsOO1+9xgGT4wM3kul
         yxg0yBaa31qrOFuT4lF4EsCVrj6+ov1ZTKPV+EnqnE/W/CFTPuGu+7b2Qu5SaGFYDWNY
         LdE9Wu+PPxTDhUug1cv3DbbXtUy07pE1TkZaxGLpzej4QIDaxMmTQnL+D4mBlx4VKnRn
         InPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749689895; x=1750294695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co1a1Nm2sB+Th7aev5P7Jvlh9qoQfqU992/CpUH4hro=;
        b=BtAhMLkDWhozCT3hTpp/u6pphh7AVrDqXwcwD9ukOTq9KtdbnmUWfqBQOlw2gCWhXB
         7kay/GV1io1ZUHChFfLNjwsa+QKSgRjGEKRH441sWa+qk/0gUbACkw4YUDyidzZW8yug
         gTAs5YfS8AfsguzPQxSEE9NATzfs6hqO1yNzX9IFwc3Mu4gO1JR0CP7l82tbi7MYvUao
         5azJnPBz2X2pOuLb/l82fOH3C18N77cbW+KrYFWeLfhVrUhd7dis8J4lOLaSgVWfYO+i
         S8mI9A5JaALEc7xIa2wkA0JwjJAbDT4jTsm32VJgnRoUmqN33ZqGBs8LRmSfb9x/fwND
         u+bg==
X-Forwarded-Encrypted: i=1; AJvYcCWGqo0VeJHy9E5lsWiWhUtpHr0Co/6RoVCP34AT0mz/Xw5uPO0n5kAHbpddCgdVmWDqmYk=@vger.kernel.org, AJvYcCWXVWNP23OYNTqQ+Xuv/YNKBynb6kNYxgsxC3UeTO8GefJUe7hg4cK7Y2DbssMe6jnXNuCF5tpb1G3iI9gq@vger.kernel.org
X-Gm-Message-State: AOJu0YzifTg+HqxPDlcXsyB3d62KvZbQFKdZ5pgek3Xgt6eo8HSb9ug8
	QGHV3fl/na9ZbSwWpP1ueQD7wrBgpCb9hrmbleUavfP0j8XKtOk7mYfhpITyZK1wQ0lw9qzxN4y
	EWYjrLku0tLm+/JQv/as/AeZyBuzFctp60CV7
X-Gm-Gg: ASbGncurn2DJlRxFI4aMOqfqjIOuvCcArJxwPFGcoJGL31qhyVb5PJObXeW/y1qLJpO
	W7G+v6K6d9qdyvZpMFs1EhucsjrySA8Fyw09tAIzdAwsQVn2j9jEYEWhi0t7Sb8i/sQYE3gOIYi
	8UuowhlVxoYFoFIyMbCJKc0PeBywbrH9QdeJrn/y2c3dzgyowDgzPpYaEft7pZIcmP0mQK0i83
X-Google-Smtp-Source: AGHT+IG8bP66zkPjeab0be/H5Oj+O0xU9qOWtLM8bQKXl/v0wHM+9jp8tnsjve2EMxkdYWshbLmqpE1g2xLuV3LS6ZU=
X-Received: by 2002:a05:6000:1889:b0:3a4:f66a:9d31 with SMTP id
 ffacd0b85a97d-3a56130a030mr585050f8f.16.1749689894468; Wed, 11 Jun 2025
 17:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
 <CAADnVQ+G+mQPJ+O1Oc9+UW=J17CGNC5B=usCmUDxBA-ze+gZGw@mail.gmail.com>
 <CADxym3YhE23r0p31xLE=UHay7mm3DJ8+n6GcaP7Va8BaKCxRfA@mail.gmail.com>
 <CAADnVQ+Qn5H7idVv-ae84NSMpPHKyKRYbrn30bVRoq=nnPq-pw@mail.gmail.com> <CADxym3bK503vi+rGxHm5hj814b8aaxbQW17=vwLYszFncXMXhQ@mail.gmail.com>
In-Reply-To: <CADxym3bK503vi+rGxHm5hj814b8aaxbQW17=vwLYszFncXMXhQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 17:58:03 -0700
X-Gm-Features: AX0GCFuNC73Sxxm0G72Uvl2Fd1CSOpCdiqgwtirOZTPLJo9-hgwO3d2JpZcMId8
Message-ID: <CAADnVQL1KBYE3ev6b1gvve_miDhfxSV=6y5QYWEhG5ynPwti-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/25] bpf: tracing multi-link support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:07=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Hi Alexei, thank you for your explanation, and now I realize the
> problem is my hash table :/
>
> My hash table made reference to ftrace and fprobe, whose
> max budget length is 1024.
>
> It's interesting to make the hash table O(1) by using rhashtable
> or sizing up the budgets, as you said. I suspect we even don't
> need the function padding part if the hash table is random
> enough.

I suggest starting with rhashtable. It's used in many
performance critical places, and when rhashtable_params are
constant the compiler optimizes everything nicely.
lookup is lockless and only needs RCU, so safe to use
from fentry_multi.

