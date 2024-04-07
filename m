Return-Path: <bpf+bounces-26124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A089B2D2
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429CC1F22017
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C43A1A1;
	Sun,  7 Apr 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TW1wJ5b5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F414293
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507019; cv=none; b=pYTyuobcjOsn/7uaBN8WP5DtB4dW9BVOzUEX9YaZITsThrsVowPBESNEcnFtgx/dpUyYVDtvZkxau5MO89KgaRIjAKarCXow2zquBO0+DSGuN0Jnh6KKBnNLuvS4Add7MV4BNfp9xEK/byZNUvrmcWNhWmRsycsla7Q33hrOLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507019; c=relaxed/simple;
	bh=Fq2Xb3yx6XN2lfY9L0K9Eeah0+XWtOfbbaD//ohGADI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=blUejcIu4VjKjJRKkyjzDRVRTBgBEy2FCWejlk57AwaqZayFMmHvgoC2U+5eF1YlyBldWKw9+8DggkrPKYHZqGy3zh0OX3CzXFTeE7ITMPGIKVuQetnO43BJYRCM7Lrx6HjKoEW9jqOfaA9acsk+y/y07xhNolHaZ7Fk7BKNxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TW1wJ5b5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e41f984d34so1592665ad.1
        for <bpf@vger.kernel.org>; Sun, 07 Apr 2024 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1712507016; x=1713111816; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTGGnJPzdQoXIOBITh6rRey/linvjMemVCnik0SXFYo=;
        b=TW1wJ5b5+LUEwnYLDANqDMG0cDZoNy4FZXwHzoo71Qr41xZtLvF5FCxzZHd/NT+yg7
         dC0jS47FwY/xCBAyizY0GP5ewfEVz0s9gN4CSyMAwglAyOi29w24GT42lbCSxBzu2U3L
         8DO6ueCUmcDxpI7O8lgELFM/MY23/+kIwG1or/a9tQTC1tPvmB6c4JKEp47TkZVacwG9
         69yBviuV0i8e6cEfkN7tvN6WFWSgw6YuSz3TJksnD43cRfYkyoy6wP49ZigUo1hM4typ
         DV1GF5EyjmTdpCM5OW2OLgFKd7nHybsdpewE3BosnQevRPkbS+uICFlPmQjIDj2psBVR
         3cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712507016; x=1713111816;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTGGnJPzdQoXIOBITh6rRey/linvjMemVCnik0SXFYo=;
        b=d4EbQJbQHAofBZmV72BXfhqAUV1tCt6ToMUUm1wvG3H/+8r3zkq/WxXwl09D0iywzs
         mgR/10URllfgeIk6hZT0XxYl7UAbWh3NLPEf2WD8IljinJ4ivofmCDaTKHQmzgpvlUZs
         GKMCZ3XJI+lufJBnkrNx+xHXmA7VLRexrQgGT7exc44gAb4akbbXh7YM5FCGNXrjA5oP
         QMjJt9R4u8tun9js73Ci7noqEGToklrs0aUGAiCDyL2PWFKrRk9CyeHIdnhe/TzDOnwS
         7dS/rRNGWm/73vGr4DciXKCPP+JUua3vc4+KAc6hDCQJJDWIi1kZChW21PtX40bCk331
         1bdw==
X-Forwarded-Encrypted: i=1; AJvYcCVVFejnA1YoihfplkYotL5fJIZc0yoHcXpfw5cKt+P/5AdeHHsAGiFdtNGF0+FfiFEHnC9gQkJtOzDyGXjkBAUGU5Ks
X-Gm-Message-State: AOJu0YyIU+whwRyhtbDsjxIACOClq3MN/zbtoFb7Bt2RjSjBr0VCJle6
	0GZfWZZ5Sb9CQ7yUNJixPfDPXo/7cWr2LbEYSDGDGpjvO/QvEb3QkhAStXbdzfY=
X-Google-Smtp-Source: AGHT+IEDAfDGgDBhUewbndGCHe+R5C4MKmmM6dEey9/fFAJ2NqlIMPDksCbIuWlWuMkxOoKeROeHJQ==
X-Received: by 2002:a17:902:f544:b0:1dd:c7fc:2b16 with SMTP id h4-20020a170902f54400b001ddc7fc2b16mr7085653plf.68.1712507015791;
        Sun, 07 Apr 2024 09:23:35 -0700 (PDT)
Received: from ArmidaleLaptop (64-119-15-44.fiber.ric.network. [64.119.15.44])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d04b00b001e2c1e56f3bsm5118607pll.104.2024.04.07.09.23.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 09:23:34 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Watson Ladd'" <watsonbladd@gmail.com>,
	"'David Vernet'" <void@manifault.com>
Cc: <dthaler1968=40googlemail.com@dmarc.ietf.org>,
	<bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <0a0f01da8795$5496b250$fdc416f0$@gmail.com> <20240405215044.GC19691@maniforge> <CACsn0cmWzT4-+g0w0-ETC5ZMC1hdW0v-Rh1ZNCG2O23m9YCALQ@mail.gmail.com>
In-Reply-To: <CACsn0cmWzT4-+g0w0-ETC5ZMC1hdW0v-Rh1ZNCG2O23m9YCALQ@mail.gmail.com>
Subject: RE: [Bpf] Follow up on "call helper function by address" terminology
Date: Sun, 7 Apr 2024 09:23:33 -0700
Message-ID: <003001da8907$efd41140$cf7c33c0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGym9lSVor9R6wjkVDgbvdbCMHIbgJp4F1KApIu0eGxhPS+kA==
Content-Language: en-us

Watson Ladd wrote:=20
> On Fri, Apr 5, 2024 at 2:50=E2=80=AFPM David Vernet =
<void@manifault.com> wrote:
> > On Fri, Apr 05, 2024 at 01:10:38PM -0700,
> dthaler1968=3D40googlemail.com@dmarc.ietf.org wrote:
> > > At IETF 119, we agreed that "by address" should be changed to
> > > something else in the ISA.  The term "legacy ID" was used during =
the
> > > discussion but Christoph (if I remember right) pointed out that =
such
> > > IDs are not deprecated per se.  Hence "legacy" may not be the =
right
> > > word since we use that word with legacy packet access instructions
> > > that are deprecated. We decided to take further discussion to the
> > > list, hence this email.
> > >
> > > We need some term to distinguish them from BTF IDs, so another
> > > alternative might be "non-BTF ID".
> >
> > Non-BTF ID is fine with me. Any objections?
>=20
> If something later comes along supplanting BTF it will be the not-BTF =
not-non-
> BTF thing. This is bad. How about untyped identifiers?

For runtimes that have a way to look up type info from a non-BTF ID, the =

ID is not "untyped" per se.

Other possibilities:
* Classic ID, but "classic" would imply classic BPF
* Index, but that would imply the runtime actually has to implement it =
as an index=20

As such, I think "non-BTF ID" is better than the other possibilities =
above, and a
future ISA version could always rename it if other things come up in the =
future
that necessitate a terminology change.

Dave


