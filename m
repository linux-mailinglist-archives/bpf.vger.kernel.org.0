Return-Path: <bpf+bounces-33135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DAA917955
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 09:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71747283FD0
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 07:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41888155A25;
	Wed, 26 Jun 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmA6E5t4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD7ECF
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719385760; cv=none; b=bJnZ11iIzlQWZ0+fMbwe3MePBg8drNNBoIeEsIfggvYoS/NVlvEsAf0RG1Bez7YUeJxl3VAu3ByDpgT3NWwLcjTB7sarS5GwWPEoUg3J0IFyHcw03LswDHZqREQcee3ZOQeobHYDiF11Gkjuv8UD17vSp56KSG0GAvyze5UvsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719385760; c=relaxed/simple;
	bh=QrxVkCdKKEMxUgfzCoTT8hc65exG8o5upDEfNT/+iro=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T89fedK6hjmlqbh4Xetw4yi8w9sRSwNmb0qBh8yMj291JXfG+fLXsk6nzbV0MfBDkU9gYS0DVI3kUnI1eloQ9tJVRnhK0aGxhgsaTtq9+rCEyzp2/yq3E8+FqNcxEXNiRqDO1OYZlTemZCCEGMyFFkX5APgKyN7k2Vv2iS+j9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmA6E5t4; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b97a071c92so3046917eaf.1
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719385758; x=1719990558; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fUlBSYFHlHlfMAV9NS6fuMuDOMCCmtda0SO6ZMGRkU=;
        b=LmA6E5t4qrb4nhNK5663AssBYOFFJj5LY6ljkCwJDg+MxUrvB5ttJxUb2/OYmgI5Ot
         gb9L2Pg8YKCFuBNkNlaE2tkUJqmdaTTYyeP0qaJV6EIB9oo87FJn40n5xcDhP+ROM+Bk
         hy5WYnYi16FtL7k6PqtaPLxvHQVYQmojvDOf9h/VH26T0HJdV8L9HyEpRd5EQ8QNq29v
         21OwJxeHSnajRu5Wb3ricIOv0IXjgNbPU9eP1CqEK4kbAf1LFmflIyVaxe1o2Ym7DfkB
         sfHHIXbuuFHB39bZPD7spwww6IGP29TD7IKNrOV+AdIvAAI0mWXxjVeyA06Iq/R0On4B
         5OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719385758; x=1719990558;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+fUlBSYFHlHlfMAV9NS6fuMuDOMCCmtda0SO6ZMGRkU=;
        b=IZkDToJH4vPhWOb6W4CmHVsuV+hnuE3UxWqitOCyLV/7qCV6GHWj4FvYF82GCJD4j9
         41igrOrFZhpDbByxsdfT2dS977HiLMzjphc+H56IOTKJnFOofCOA8nXun8XFOKK+AebN
         ugpUe6bjpvZQ9yJdgWf+0/x3XeBJ8acCOOkgu+GPLsvU+faRPeQRfwVEgI7/AGS9Xcel
         VZ+XnW+NHP/gkWbqumL9IDRetKJ2wZtRcbnOy6XWJzL0RtkEeY3UBL3RBdICJFxsUhuo
         btkG/T5/J2C7cHIEa0j2YBAZAbsL4WuPi475859Ge91uIT6l7NtzaKJKUyQGenkVdsn9
         c34A==
X-Forwarded-Encrypted: i=1; AJvYcCXcyB7ynWfrLCs6Yu+zyJKZeUcet+VFwO+jEjt0pP2GxS+jymV1sD427yDeZkihMrXpLmoE8ILwTW1AgQe2QpMom1M5
X-Gm-Message-State: AOJu0YxCWXpolQGoWw7QeFIjzLr98oe3Rkb77zFLdS/3+podvI1osqcS
	INsugD3+SYOURorQiZwoiMluVX+cRh9RrnexVdYS8Kjgja+zc30S
X-Google-Smtp-Source: AGHT+IEMJCfzzfrFTqSUyJbuOZ59wWVPp1RoXInBUDuUeIT1PWSDY4U3SvX+L7iu5yywhm1BEgVoqA==
X-Received: by 2002:a05:6358:80a7:b0:19f:4b46:dffb with SMTP id e5c5f4694b2df-1a238a67da8mr1214291755d.20.1719385758368;
        Wed, 26 Jun 2024 00:09:18 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm8062910a12.62.2024.06.26.00.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:09:18 -0700 (PDT)
Message-ID: <b0fd686d3dfbc580041c8347a05c8daf451d89f2.camel@gmail.com>
Subject: Re:
From: Eduard Zingerman <eddyz87@gmail.com>
To: Totoro W <tw19881113@gmail.com>, bpf@vger.kernel.org
Date: Wed, 26 Jun 2024 00:09:13 -0700
In-Reply-To: <CAFrM9zuz8Wh5g7ykOkmFXwVdxgB7NQWzDbvv7=CEpEks54GnSg@mail.gmail.com>
References: 
	<CAFrM9zuz8Wh5g7ykOkmFXwVdxgB7NQWzDbvv7=CEpEks54GnSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 14:11 +0800, Totoro W wrote:
> Hi folks,
>=20
> This is my first time to ask questions in this mailing list. I'm the
> author of https://github.com/tw4452852/zbpf which is a framework to
> write BPF programs with Zig toolchain.
> During the development, as the BTF is totally generated by the Zig
> toolchain, some naming conventions will make the BTF verifier refuse
> to load.
> Right now I have to patch the libbpf to do some fixup before loading
> into the kernel
> (https://github.com/tw4452852/libbpf_zig/blob/main/0001-temporary-WA-for-=
invalid-BTF-info-generated-by-Zig.patch).

> +		// https://github.com/tw4452852/zbpf/issues/3
> +		else if (btf_is_ptr(t)) {
> +			t->name_off =3D 0;

As far as I understand, you control BTF generation, why generate names
for pointers in a first place?

> Even though this just work-around the issue, I'm still curious about
> the current naming sanitation, I want to know some background about
> it.

Doing some git digging shows that name check was first introduced by
the following commit:

2667a2626f4d ("bpf: btf: Add BTF_KIND_FUNC and BTF_KIND_FUNC_PROTO")

And lived like that afterwards.

My guess is that kernel BTF is used to work with kernel functions and
data structures. All of which follow C naming convention.

> If possible, could we relax this to accept more languages (like Zig)
> to write BPF programs? Thanks in advance.

Could you please elaborate a bit?
Citation from [1]:

  Identifiers must start with an alphabetic character or underscore
  and may be followed by any number of alphanumeric characters or
  underscores. They must not overlap with any keywords.

  If a name that does not fit these requirements is needed, such as
  for linking with external libraries, the @"" syntax may be used.
 =20
Paragraph 1 matches C naming convention and should be accepted by
kernel/bpf/btf.c:btf_name_valid_identifier().
Paragraph 2 is basically any string.
Which one do you want?

[1] https://ziglang.org/documentation/master/#Identifiers

