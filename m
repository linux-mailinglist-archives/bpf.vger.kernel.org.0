Return-Path: <bpf+bounces-46244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F539E6547
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 05:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D1F283C00
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 04:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85EA193426;
	Fri,  6 Dec 2024 04:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in4zDpHn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12F1917C2
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 04:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458050; cv=none; b=fnEqLmsT48AetyS682QZr0GvQqRYwuG73CVK3UylN95v/kx5TLAuCLq+0+qlo5sHDLi2xVp5Ts4F0Ne1Sg9fKqLkN/glfzm/g1TYVSL9gKWbFTMadn5G9sKN1lCJ7LIGbAboREKh/Ei9VaVnflhVbiaIfoH2QP+KZBsH5TP3PTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458050; c=relaxed/simple;
	bh=nSTJ9aPUTZ4sIo41CycqHrsaZv9xwosBXK/tq2qz9Ck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rfheu1UwU11LfR+9xzH5hSkO+nd63sKby0vrM6LWv8+yWUv3Q4dWQ3NrxQf+JKGFMiB8g+kLaJGQBRcXbr57cbtPVbT4a5SlYAupXnbRlCNJy57/j4ZDUwROo96Uh1qGmlTWQFgsxjA6XgLwx/2LlDS//xOS8W1UKeuiHZeeyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in4zDpHn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215b0582aaeso12844405ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 20:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733458047; x=1734062847; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nSTJ9aPUTZ4sIo41CycqHrsaZv9xwosBXK/tq2qz9Ck=;
        b=in4zDpHniDIH+9IeU+jrYgbCwAfSkLx/CiBv4BT5+NnJG4lEpRGe9xpZ18RRc50g7Z
         VI7wgWSun6SyuCn2V+95SVlXm+Urd1hVG//W4WKHbYfOJSy5GhwaYwGqzxDNNJwkqfqN
         7BQgbb7ahyb1ENOd5nKMlGgcTS7yjBKbml48zKXmLs2SHXQNwCkPLTUCS9I+EK1NItAH
         s83o9BiNds+RHApNJNjr2QV0Qm8Zv9nk22d0RrHWG8dcIJi/4tH8cHGxuKwAHJDfx89X
         NFHlGXXyr+Ta+bioRA6G+gtcMpPELxQuw2Pb1Z7p9sa6+VPy0ynKuY4DsTRphwLeKSg1
         GRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458047; x=1734062847;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSTJ9aPUTZ4sIo41CycqHrsaZv9xwosBXK/tq2qz9Ck=;
        b=LmL8Hm1+A9nVPnt39mDMJ4szIM3FzHDAx2XY4AavqsnkLT2cDBBwr+jJxyCrHETzjL
         ixaQFtgZayqWW+kKFBtSilono1XzqcbIg2uKdWGrb+A7BA0C/qfEBadAw7VVi/PVZowq
         8OLOEBPQqn8B+gWNy2bfGNfrlm9ZM/T8cutr1VgqZWcAgn2C9qDalT+IYCnDSF6xf3yc
         1OUHnwvdPhsTUPTjiqFRBxqiKpupaUWZ57qrIOG2nlu+Hr6aVZMD6xXh8irPadfPzX/u
         4wBLqcdvTi77D/UBpQ3rhOQtxJraQNCSqdtAGWWMCoG186kDgC9wOsltLlTA8bCvZKN4
         6bGA==
X-Forwarded-Encrypted: i=1; AJvYcCXUMm4JJ0+3t9w0GFaPfFgjsMUqts7Sed1TAuXuQYSXtVW4RXfYMWP3J9CrhUtsoO7Hvts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiI7DOBzVvIe8/4yqVUcz/QLU1JzvnEScB412MgoxPWOThNKdw
	mP96BNIhKAjq0Js0N29JfrbTe/eWBSp1yB/jcuz1Gg2/yWFvlrM9n5AaLg==
X-Gm-Gg: ASbGnct5QTEUfycGEu8ay3DL1bEkUeKIgrdjq/FZAH5E097SQZ8E1bl8aIrI7/pdiHH
	ZLibjGfJ4PimNOTsNKY4uLs3Z/fE4wWAjKVIYyr5NxkpOWDexCvBunusChM1qqyyDSu1oy0FTCi
	vJvhf+M7RMb5NNiRmYq03S50H0SvFzVchzBoubTwZTJOoWHhlkT7TXcvIB/qCp4TRIqXQ5pqRm1
	rKnMYN5G55wDabaKQJqdQhQ435MAk0AX6Z/cSeeNBBvjDo=
X-Google-Smtp-Source: AGHT+IGxlb8xgJjNwCRfmsrOTnVUT7YTRSLPJVRqr212pXWZdt23O7XjHyo/vAsK8Olz1VZ7pBea0w==
X-Received: by 2002:a17:902:d4c3:b0:215:8c36:9ce with SMTP id d9443c01a7336-21614d7be2bmr16346785ad.30.1733458047435;
        Thu, 05 Dec 2024 20:07:27 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0a736sm19939125ad.217.2024.12.05.20.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:07:26 -0800 (PST)
Message-ID: <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov	
 <ast@kernel.org>, andrii <andrii@kernel.org>, Nick Zavaritsky
 <mejedi@gmail.com>,  bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Date: Thu, 05 Dec 2024 20:07:21 -0800
In-Reply-To: <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
	 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
	 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
	 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
	 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
	 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-05 at 17:44 -0800, Alexei Starovoitov wrote:
> On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > so I went ahead and the fix does look simple:
> > https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-bug
>=20
> Looks simple enough to me.
> Ship it for bpf tree.
> If we can come up with something better we can do it later in bpf-next.
>=20
> I very much prefer to avoid complexity as much as possible.

Sent the patch-set for "simple".
It is better then "dumb" by any metric anyways.
Will try what Andrii suggests, as allowing calling global sub-programs
from non-sleepable context sounds interesting.


