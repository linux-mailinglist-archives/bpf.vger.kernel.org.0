Return-Path: <bpf+bounces-57375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C80AA9DDC
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CF9189192B
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9822A270563;
	Mon,  5 May 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmLvHy3Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C2262FD3
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479420; cv=none; b=ObllTYgOTdJFJBfDUNRYsSJ3WynxvS1XgYNKJdRl5cbNdwjQkfWc1qJR6ZN3citaNjz6n7k2tQrZb+YDw9RxfHFsvawi4axra0uZ4hztIaTMjAhi2UZsZF9tlggPTly/R5BO8rqyqcVP5UOdyTK7xXanzao78S0ZxhUEV8HC5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479420; c=relaxed/simple;
	bh=95tjT8TAdAf99Hw45paYyTwvOqu+G7TfW4lJXekDKqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJkgS3x0QgEJ5fFkMCbolJLfMHVxglBZ0gASUtVZGTxXUGRD77xM8TX+Xf38usDknsczLNDoyRkrRlYvGCxTYcpq7Q2q02u6UzOEBtE3vToh0/swbDJMbqAw8Oa6cSQeRJRfSjpbRqTYZ2gq4J5LR/pPQq9f/x2kL7kSSQSFgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmLvHy3Q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso5230521b3a.2
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746479418; x=1747084218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95tjT8TAdAf99Hw45paYyTwvOqu+G7TfW4lJXekDKqI=;
        b=BmLvHy3QtWqgW9kX3NtyUYPwzZwGnAQlHnP8Z31qI2cg/t5NhVIALBIGKOkITo8Bw7
         L5TBZjiya2lV+YJ+bzDHmiIPjWOXBovQbzoj+hnYLtZAThVu0laCU/uytPx3d4myxL/S
         JMIxt6NJZgkIt9/zfTLxDH5GLt0YyF11/fbnEkfFmoGSJOdgzHWptucKumky5Z2r6sO7
         /GHmvO/yHMgE3PhSsplwqtEtqjpCvw/0dFcI2S5XQlSJYukdOG7pYx28SKryVrMDf0WC
         qeW1aRZkcl3j6ZHRSalDjB3WXPKFHhy4bMCeCwxjLFBmh890mVBCjwqCUA4rszp/cwhS
         5VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746479418; x=1747084218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95tjT8TAdAf99Hw45paYyTwvOqu+G7TfW4lJXekDKqI=;
        b=pjRZzZJdbu5swtUM3WcUwEDOI5VZih6apKOjMW2Ax3xiU9oIlbrrpqJvYXX51k17XR
         +oZ7BODYfJ70HpkftPmWZQQd27Cevh8NIMOBSCky40sJMksc3MhnegPdsjguR9j3tvLJ
         CT4YAd+McL0l0Yrzv3RB8c1VHPRaXMxDwg1dkINy1Ie8322wQIm9/KCkcWZwkoW4J2LB
         1Lws4VmqiKUQCmhth05OwwnSNKBfd8bBFSdhGgwpSvPX6tq+PDbDAaLg9I++Xw5/G2uy
         BFmcCEf2Am/1XTSgd+fpvouQHRTT+vpXkaEI/WELgr+cMJVQAq/YubZFIjaN7zumP/Xu
         qjEw==
X-Forwarded-Encrypted: i=1; AJvYcCWdBUdz0UAAMnutOqpPZ6u4fFHty+XMlOEmy33MP2YBSk9kpPjlKpHg/VJMk0pZmv/IXCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybD8eUCzJHYuqXWlkJRdGUYYvV8wTVNpprsZH3xEUGJ8oBfoBP
	WEMkELR1/Z31xag0yuA0zDcbVtttsuwukbLGIVkhHJnKHm5z9wJF+X4Qp2ywBXNDgx4aqJmRI/n
	KP0Vj97UEC6I4zylzLvhCSnmSO7I=
X-Gm-Gg: ASbGncvTvJsqt/imeulIh/V/+TuJwjqWkQtlFE4TNjzfs/YpdPiehC+YFB3XBLnW6d1
	OOhAkeHwlsIAFC65E1ymRTlk3vICX3e25c6Q3PHR+itGGwN7PaZ0no4XaQsoWNJvdGU9bQmsUAv
	ZpnrUnKq9bxV1xJZvonpDZPKCSx8hI4GItACQ6ZA==
X-Google-Smtp-Source: AGHT+IGk6VqbwhI/JQddaeU0H/bAjlLnPVWY+KlT6YoPkDY7gBQG0L93fKYyIT+lgEjxmVyolcFAYcNPsSh1swEIFPQ=
X-Received: by 2002:a05:6a20:4321:b0:1f5:8153:93fb with SMTP id
 adf61e73a8af0-21180b6a0bamr760313637.10.1746479417761; Mon, 05 May 2025
 14:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501235231.1339822-1-andrii@kernel.org> <95dbb7e5-c2aa-4114-bdb9-9d9ea53653f0@oracle.com>
 <CAADnVQKmQKVTkf28Ex6T8Y03xDQ6-3o-rEcOM3vGZcVHGcrfSA@mail.gmail.com>
In-Reply-To: <CAADnVQKmQKVTkf28Ex6T8Y03xDQ6-3o-rEcOM3vGZcVHGcrfSA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 May 2025 14:10:05 -0700
X-Gm-Features: ATxdqUEaQWxhl4F3hB-v98pFoy73H0_LjpmJ4_OruTUW91V4x7rnwgkiLI8t37Y
Message-ID: <CAEf4BzZ-3ovbCEO+Jnn30xNsxE4nBnGtqL9FZ0O7JkUa=t0YuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: improve BTF dedup handling of
 "identical" BTF types
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 11:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 2, 2025 at 2:32=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
> >
> > >
> > > On the other hand, this seems to help to reduce duplication across ma=
ny
> > > kernel modules. In my local test, I had 639 kernel module built. Over=
all
> > > .BTF sections size goes down from 41MB bytes down to 5MB (!), which i=
s
> > > pretty impressive for such a straightforward piece of logic added. Bu=
t
> > > it would be nice to validate independently just in case my bash and
> > > Python-fu is broken.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Looks great!
> >
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >
> > Should have some numbers on the module size differences with this chang=
e
> > by Monday, had to dash before my build completed.
>
> I'm curious what BTF sizes you'll see.
>
> Sounds like dwarf has more cases of "same type but different id"
> than we expected.
> So existing workarounds are working only because we have very
> few modules that rely on proper dedup of kernel types.
> Beyond array/struct/ptrs, I wonder, what else is there.

Well, turns out I screwed up the measurements. I thought that I used
libbpf version with Alan's patch applied as a baseline, but it turned
out it was libbpf without his patch. So all the measurements (41MB ->
5MB) are actually due to Alan's identical pointers fix. My patches
have no effect on module BTF sizes (which is good and a bit more
sensible, I should have double checked before submitting). So, if we
are going to apply the patch, it's probably better to just drop that
paragraph. Or I can send v2 with an adjusted commit message, whatever
is better.

