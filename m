Return-Path: <bpf+bounces-52015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E092AA3CE62
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69B616BB44
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8FB158535;
	Thu, 20 Feb 2025 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4yv46pQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA181130E58
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013377; cv=none; b=MSBsosVUmB8L/C3XPXqxg/U6bDCm03ob1Sdq69/oudU+bkNu+v0YKE1gF5lsCn411tih7a3RWm63kqz3Bla0wxnJg2Bf3bdaRIqFYHdmfIa9pTmzq5SdL/B1H24XnHwYeCAxJYmCgP68dUDPUEFepbfreTfbESy8YKJepCjiygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013377; c=relaxed/simple;
	bh=LXSLbJDB5g8r6GACw61AfG6N+ks+IfRxhrPaxPQ4zk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvctsPN9JME1Nt+k9obk6TtRlxcD9pTdwRu8aoC8RkaRTkquEZy2EDS8MXm+ug+htHU77Z9WQ2zcrY51MJJbb+uF6MtHd/9C9Ghi3tPtLiMqwfHyFFW3Wq9nZZD7/77gKmoNgcruMITF94ujle0pTaTTHv/54ICpVmTzEbEscbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4yv46pQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so830141a91.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 17:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740013375; x=1740618175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cua64ExYp2iF1kD03APq3N8TU8kx8zWkpfYZw0sRQnI=;
        b=m4yv46pQTQvy5W2u56spe5H3WaCPwPNDKyv+HIp6UQvZJ49fvfT2W3daiRYd0qB6xF
         sk8Y6M/8EP7vrDrbAsQd4H3S0sKf1BC8KDka9L867PY/GEN78UK38aVMDGszy/ZRMFVJ
         iQVJ4NAfMQX0R60Kk16sY78B8NP1sGbcurP6YPLOJZJSFef2nrKEQu894erjzptvnhUx
         YcTlTlJb3Kpd9IjBT7dMWRC7TgfLLWi4E0taun8CwGRwnhIP8rBu9ZYP4gAAI39PnaIK
         8eczTKXgb+eUwsi8Y7y3Sp9un/FrLfC+AwM80shjVgGh6aQPPTJ3gSA/qKYNL8p0qS+/
         OVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013375; x=1740618175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cua64ExYp2iF1kD03APq3N8TU8kx8zWkpfYZw0sRQnI=;
        b=didtUfZOmzEvwUqlbPbk37FL+XnTT2uK4w68/7G3GM2Dnyj7f/4c2Um1kdon8jN3/F
         6JraM5Yhn3PVz5f7/ZLZLYwctqAN/nUpXJ6dcK+EB6ypjZZP98MR9vudbJxR1VdmVtFi
         KwtNgu/9GCt+RY3BWs36UGQuPzUaTHn3MD6O4U+84KqFtf7n6WAyTGXtTpLKoI1RIql0
         XqatDuOT3nv1PPCLleombCQYHXGjkymIlCZCY9hti19Z9Mxnao7dA0YgQJrDvSpNcbwm
         Yo747BLp/cpAdO/X+bUg22mJr6RCPSvkKt3RTjpJyhePNXiK68b7v7jgFyhsSyOjVp3R
         FRTA==
X-Forwarded-Encrypted: i=1; AJvYcCVGykyp0O78Is9F7qH60f/ndG1ebIy/tfqNYY6Et6Sru5UCR69ouCNn7n8GPmrud2cHf8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzMj6mhhsvg+ue+UidQZXAtxmC1pfLY7U8ZsXutS6e1neBcRpz
	Trc5zWNfsw/AcAo3ygV1iUcwquzY8l8a8oxYdBP4HVT8Yq3n8ja2QEHsk1HljlskwOfBUgOyNB7
	TsYxx692ex62RPumFMGlojCXXbIU=
X-Gm-Gg: ASbGnctO4KyKBgc/Th3u/5UHqFbpPYUj691Yy3vXwA9sZaNlde9k9GgjDVQm7qvgioG
	pl7x49Y+Jds8O+keyivoa35VurprBlZGSwa4buwfpA7qCbzlMT79VlsR8NV4hHEd9tiH2157SVg
	4+rtf5xwvllIRJ
X-Google-Smtp-Source: AGHT+IFUKQPlXYWQ3QXEVquW7aeQ9d/n9WoASvzFwPnVIBVMRQv7W+E2AF0ua+2EYhzL4tM1jMrJxUc7JqMyTLkkSH4=
X-Received: by 2002:a17:90b:3886:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2fcb5a17cdamr8843499a91.13.1740013374748; Wed, 19 Feb 2025
 17:02:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213152125.1837400-1-linux@jordanrome.com>
 <ca3nfe2a2xfkt5ws6qkghzwmv4vmlsto4f2o2pr72sy46lftwe@xh4kt72yeia5> <20250219161912.ba13c3ea1c648500ea357e93@linux-foundation.org>
In-Reply-To: <20250219161912.ba13c3ea1c648500ea357e93@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 19 Feb 2025 17:02:42 -0800
X-Gm-Features: AWEUYZmYJtk-rNEhnk91HBX-JFi4vnuCBZ0vZ8w5KOHXN1O0XZVDYttv4fgwWcA
Message-ID: <CAEf4Bzaptxiyf3FBJYBc4ByMat2SiTTA6YUQjgOMo6ZVFCX5Dw@mail.gmail.com>
Subject: Re: [bpf-next v8 1/3] mm: add copy_remote_vm_str
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	Jordan Rome <linux@jordanrome.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:19=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 19 Feb 2025 15:33:12 -0800 Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>
> > Hi Andrew,
> >
> > Do you prefer this patch series to go though mm-tree or routing these
> > through bpf tree is fine with you?
> >
>
> I'm seeing no merge issues at this time.  Via the bpf tree, please.


Great, I'll put it into bpf-next tree, thanks!

