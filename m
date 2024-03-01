Return-Path: <bpf+bounces-23139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D1D86E175
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 14:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F7B1C2260D
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175DD42AB5;
	Fri,  1 Mar 2024 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWKMRoLG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF721EB3B
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298174; cv=none; b=J7TywsWMKYPWjGYt9GWZvr783fkHKP4R4ttyLI4x4gOIlA9Ohfw8OZzeOD3s8swSA/no2atfHYSSwMmEGvVYpawgBMEliEWcXvmbA+v1pyvWAwMGCb0ZqqNynETDVBFtWJgh22MhpZi1rnwm8y3GjskntDu/Xs8RZzh4WPSx2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298174; c=relaxed/simple;
	bh=OvG24BkvEaqe8OrzbXeOdqfA7nREK6xO/wJ3GgykDvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T82s8si6VBSKRa0qKPAakQyWOsS3GVJPHNTKogdDCG4+drqjHPhpWknmCplJhmIuzUuLzY/8yETJt8uClei9FlUe60RX0VOLUbFFBHbEcMEaUelkzq+g9e2ISeYDMJzE+0zaZCFBwV29IdHSqGRpqJBYmZNfNszCTSUSuqv8hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWKMRoLG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709298172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/riObx+6pHnsV2QvL7phojFIfjcIVe9zNsMuHpkwW4=;
	b=MWKMRoLGKe1JHTl4i+gY5H6Kzk5yy69TPjI4Ds34miK5LRnHPnVxLbjRwbCC4ZbO0w7Ouw
	ZY/85tPbq/w/dxY8c+gp2pPI2J2U1HwDM31KVFbl/xocPP9h/oE3lSPOkMfg0wJ6v9ekie
	YJO1Zau8uv3Ud10vQ28ABqdn87vGVPs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-RYImvA0yMd-CbHnbdKubgg-1; Fri, 01 Mar 2024 08:02:50 -0500
X-MC-Unique: RYImvA0yMd-CbHnbdKubgg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56618452b5eso1803839a12.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 05:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709298169; x=1709902969;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/riObx+6pHnsV2QvL7phojFIfjcIVe9zNsMuHpkwW4=;
        b=LJ9tKuPHZ2IjeT4lNkqP0euChRcAUwX84DCe/D/te7TIjhqom8WE2s7IGqSlXQ+iMa
         ZQ1pr5u3d3u2qF73XYMOVvqpt0xDQuFVM8WzR2MuoaewzVfwzuxZ7hYPoMdMfxREmrgg
         M6ZQX2vAeFSexnWPUWDM+P5bgPAlIsA6yCCMUcLNmt72qO5ddMMvE1prxinQLE7lRdVN
         Rb1Rh8u2wFKxVUx3E4aJE4jS7SxhuMGsseDSm2oFNt2fWUtA0j6Y9RLMklF3H1YmiWxj
         W8DKyb2UsZWmHayA0r2ZHz/oTl7CIBr9hPrDz+HhyGt9A2ugAuIVpMyHTN5hyhYTYM5E
         uq5g==
X-Forwarded-Encrypted: i=1; AJvYcCXeuclMXpf5152XGjOvg6JGJ8JeTf9CM5ftEwKnSMM7/dee/ZO6jcdMYKEcu3EqWZ5ma7S7tMRjE3hKJ4yFcnwWrUdX
X-Gm-Message-State: AOJu0YypHWn1SfFZfYjfM7ePgPtpzYP/PWjA5YkNOOGYR30QQ/yydk3A
	JLZebAednyDhxESn81tNYvhqV7r/A1onWumSSdKdtl2h/ySZXu5aDzB0owi3omT9yO8jEYzYlKr
	PP2yzIYK4TPN0YwFRFIH3BCrrbap5SHs/xdmQG3m7Y8GAEQuAbA==
X-Received: by 2002:a17:906:b84e:b0:a44:511d:606b with SMTP id ga14-20020a170906b84e00b00a44511d606bmr1060257ejb.8.1709298169750;
        Fri, 01 Mar 2024 05:02:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYznp1w3lq4gy1tqCaCFYEfvS6l+yqp5A3bkph6XMD0U/Y7N/yG9456IKgIoYlVfBgSzV/4w==
X-Received: by 2002:a17:906:b84e:b0:a44:511d:606b with SMTP id ga14-20020a170906b84e00b00a44511d606bmr1060245ejb.8.1709298169388;
        Fri, 01 Mar 2024 05:02:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id mc18-20020a170906eb5200b00a3f28bf94f8sm1682191ejb.199.2024.03.01.05.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:02:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BF100112E96B; Fri,  1 Mar 2024 14:02:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: John Fastabend <john.fastabend@gmail.com>, John Fastabend
 <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: RE: [PATCH bpf] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
In-Reply-To: <65e0eb87a079e_322af20886@john.notmuch>
References: <20240227152740.35120-1-toke@redhat.com>
 <65dfa50679d0a_2beb3208c8@john.notmuch> <87zfvj8tiz.fsf@toke.dk>
 <65e0eb87a079e_322af20886@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Mar 2024 14:02:48 +0100
Message-ID: <875xy6ayvb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Fastabend <john.fastabend@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> John Fastabend <john.fastabend@gmail.com> writes:
>>=20
>> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> The devmap code allocates a number hash buckets equal to the next pow=
er of two
>> >> of the max_entries value provided when creating the map. When roundin=
g up to the
>> >> next power of two, the 32-bit variable storing the number of buckets =
can
>> >> overflow, and the code checks for overflow by checking if the truncat=
ed 32-bit value
>> >> is equal to 0. However, on 32-bit arches the rounding up itself can o=
verflow
>> >> mid-way through, because it ends up doing a left-shift of 32 bits on =
an unsigned
>> >> long value. If the size of an unsigned long is four bytes, this is un=
defined
>> >> behaviour, so there is no guarantee that we'll end up with a nice and=
 tidy
>> >> 0-value at the end.
>
> Hi Toke, dumb question where is this left-shift noted above? It looks
> like fls_long tries to account by having a check for sizeof(l) =3D=3D 4.
> I'm asking mostly because I've found a few more spots without this
> check.

That check in fls_long only switches between too different
implementations of the fls op itself (fls() vs fls64()). AFAICT this is
mostly meaningful for the generic (non-ASM) version that iterates over
the bits instead of just emitting a single instruction.

The shift is in the caller:

static inline __attribute__((const))
unsigned long __roundup_pow_of_two(unsigned long n)
{
	return 1UL << fls_long(n - 1);
}

If this is called with a value > 0x80000000, fls_long() will (correctly)
return 32, leading to the ub[0] shift when sizeof(unsigned long) =3D=3D 4.

-Toke

[0] https://wiki.sei.cmu.edu/confluence/display/c/int34-c.+do+not+shift+an+=
expression+by+a+negative+number+of+bits+or+by+greater+than+or+equal+to+the+=
number+of+bits+that+exist+in+the+operand


