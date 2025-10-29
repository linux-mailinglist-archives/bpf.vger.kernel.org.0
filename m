Return-Path: <bpf+bounces-72833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A70C1C384
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 17:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23A15567379
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912BB33B6C5;
	Wed, 29 Oct 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1nadL5U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958712F0676
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755907; cv=none; b=KbRgj7D4yK7p46USLU58zZO5+RmgzeOTKg2wl8N5bwMUzysXg854PZdDYtWc4Th3CkgA+oTJIM7/pWn0pmc5MAUuj60fRrQoTaUEU0FmrAAFMWCWy201m6ZW3QlJhAjX5XDN/drbtomBDOFLA0YQg09QDhgx51HaVScOn3aAeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755907; c=relaxed/simple;
	bh=Jwdv6/9meoYUWvOfN7SO9jrpugknEVlmkhDpfiFHKn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ6fNmiQBf1K2rOrMhRgoEib3BkXttmpn7JdjXX6W2uxpPjg/a19LEOB/C3VbaGjeelU6BPzv81XM4zwTVBhs5sUkbXESQGuZk9/dzXnQLU2c4+UFWjrR3zBL4uNDjgTq6vJy0sY8vI3NlvdCxdrr3L1sKnqNrvFhi8adu5FGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1nadL5U; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4298b865f84so17129f8f.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755904; x=1762360704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jwdv6/9meoYUWvOfN7SO9jrpugknEVlmkhDpfiFHKn8=;
        b=W1nadL5U2bSeY+TcybSfsiTmgoOo1IBL3eWyzAmk+ejKJLex8rTwklOpr5Wp6tbIF7
         vlCCnk9+GP9GAVg6ht+UoYBWX7I9eKQR6e+Jwh78ZZKd7W860tD3onMfHsE984SionrB
         aHU+/2Irpe7vs+rq1CaWv3kMktI99CgtgB7vpKQx/25dRFefirSHj4bGdQFtStBr/aCK
         /luzX45L1aDfa8+Gs5PzSfj67m58UpTCvyN0WBUpc6rHg5+ueLKSqBegSV92jrpsUexs
         zffEuiqF+t+IPqoWUEdYAJnU76BdL4/Vr0xXp42MHCyoy3hWuKPemWM7vXYwE6hN48wX
         6zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755904; x=1762360704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jwdv6/9meoYUWvOfN7SO9jrpugknEVlmkhDpfiFHKn8=;
        b=KEyc+s15GZ0RrncHL4C4VNAseaJtra9tW1pG2y4aYnj+tcGgtjKfMYKPZZRUcCKefp
         jLi72LZ+JvFyQIxAXiQQsuBlMZY4bhWRilVMkPTZ0gGzeyRxO/eD23Hm5tDlwOPdBWSn
         EQ1bPnnuuDGb3Ycnr42Bc3ah0Y3DfbsVWXH7nhERVNta5LwHqs4yMS5dlvIdarf8EvIi
         IQk5jxxRyIK5VwtBUrBmHJiziZYE7SBRHMrmAd/fJKpiyieUkqZU1Erre0njiJAv8Ikh
         t12BSeIFVYOe01cyCiBefm6zCcdCDe3qJT3xwXp7fLbjhZfEIB5nparBykObadsodUip
         FkAw==
X-Forwarded-Encrypted: i=1; AJvYcCXVjXrjIGswZ5I62ArXUem5FADwJceJf8T3/MdNtDfGjRLeZEDLH0JXcPARly+wIZ+bY9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1i7NlKApiQlorUpjqTvTbDpgvfE69lGriOR33JbFu/7uBvHU
	iUC5XCDPWZTLIWAvyyYIC0CttNDMk3dLFPlBlO19dSEj/3JeL4wNowDcbCUfLCIE83LBNqlG3tH
	eCnK0MKYPvIzxrCQc9p/EFrBwQvlA0M8=
X-Gm-Gg: ASbGncu8alwC3OzkN3TMJZSmQidEAbKhnnr2yKBpOF1iSu/QwumDNoXpj+C7Dvsq6NM
	3mack2NnmpL+cDgjCx/XJdyz9pEgG51lmj502vNXNP/EcNA9ftk+bI8TuxtZ0vFaXl0WNuYecGy
	30xfEJ7gxrZms+Fd0n5wa41QL5BMOTEd6HVmRsRvmGgZg99N7Ug6X0wsErVTORLnRGJviEpCz7y
	332cGqOqQ9BOjmFqkSwsigk9JvNPUzQaODFDYA95oS9dONyiaWoF2MNL5/aV0fqedL8uRQ8Wlw0
	2stLrGGifbNg4wXbIpVyJpPJKLwn
X-Google-Smtp-Source: AGHT+IHOKbYQRjb7noEtg9viqdiV0KOSoE8fwPGm5DiruA+2k83MA/tyzn39j/Xj8DclgnRtviyPtE2Cakz8DDAsYdo=
X-Received: by 2002:a05:6000:144d:b0:429:8b44:57b7 with SMTP id
 ffacd0b85a97d-429aefca83emr2893529f8f.51.1761755903765; Wed, 29 Oct 2025
 09:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <176167501101.2338015.15567107608462065375.git-patchwork-notify@kernel.org>
 <CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com> <23eddad8-aae3-44ce-948a-f3a8808c1e24@linux.dev>
In-Reply-To: <23eddad8-aae3-44ce-948a-f3a8808c1e24@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 09:38:12 -0700
X-Gm-Features: AWmQ_blZBI4M6hqka-WDWjrJS6mwNo50xI2IEFe-TA0xh4CdlMem_GYEsm3tD7A
Message-ID: <CAADnVQJHAxKmhDdJ_SkgHMf3adiS8MmD5MJCfiFfxU+8peT9-Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and
 local storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, patchwork-bot+netdevbpf@kernel.org, 
	Menglong Dong <menglong8.dong@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:50=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
>
> Right, this is the classic NMI vs spinlock deadlock:

Leon,

please stop copy pasting what AI told you.
I'd rather see a human with typos and grammar mistakes.

