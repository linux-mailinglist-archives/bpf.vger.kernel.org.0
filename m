Return-Path: <bpf+bounces-35306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B31939796
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110F72819A3
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F01131BAF;
	Tue, 23 Jul 2024 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5quwZ4Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C505273F9;
	Tue, 23 Jul 2024 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695717; cv=none; b=D6nVRVE8BGc2hQsLpCurfq6l8r0wlMu/OncGm9U7KRcpTezy9LCIabyAaV6vlcF21YNfIcQ0XO+zyPdMNunaaFixoahY0Anc1PiMUukwpTYekpVudduy2dHmA6A8jf44mD+PNFx3J5aYuonHys9evtwYjmqWRLn79O/TQk+l4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695717; c=relaxed/simple;
	bh=FZnTNjlo0UpiDSvo4Q3KmWOx25Q52HO9YrNEkdMxvJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoVj4MvWosYw6MjKhGsG9TXEXKaAALlp9komghVsGoZt3vYc6YjgUjOpP/7QZfc47KuIxppDkBX8UrmLIJvPg6D5Bve7d5VwQ0+WvJWBE+mxrfkfQ7xOdsU7Nzfylc9dMigXS6FyAefjjCDhmLcrsrlahYjE/mcCCO+8eTIrUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5quwZ4Q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367990aaef3so2595116f8f.0;
        Mon, 22 Jul 2024 17:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721695714; x=1722300514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZnTNjlo0UpiDSvo4Q3KmWOx25Q52HO9YrNEkdMxvJI=;
        b=R5quwZ4Q+qjujveqt48RQqnUmF+F1EkmZotxTaT9an9UzNoD7xvXBomd9gEfFfrFMK
         a70n/iyMSCoEmMYvDaUlE3lZ0saZ7mYwosVDfq4EySig8TUwuRGV1Z5p9p0GYGkt2rOb
         2GhBmCraI0IEXIU1tuXcLTQmn3NJD0SRMXZZWpZIpZumA8ZeEUDOgFeerIMsl47sDddl
         V95GgZuiHGJ6YtzeTx3FiKRcb3+/BrN4WYgNJjMZ06hLaTMSHxz0x8BPvSwUE2uuVVdD
         ld5GPD7s6b9o81LcAuOujwwEeH7IWuvSU+tJ+6tZJ0ybOdiF5HtoHFUUUCk2SDtsTVIQ
         8kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721695714; x=1722300514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZnTNjlo0UpiDSvo4Q3KmWOx25Q52HO9YrNEkdMxvJI=;
        b=CJ9uSjX5q6xWKI01BA/sAfAhdKoreJuiSBrO6EThxfL+nC5oUXddAVk1IscJH/uQkd
         QCkoqeXgnE8jzhEukcrae6GK43yXxeUh6NFMZCauzq5rlqopsbevUJuDDlH6tEb/lkPH
         3FbofvtBI59otdPA3+8+ltmTbU0B51N9EgV6ORCD+LVU+S1Fw4dCP6OVdkOAIyumf0Wp
         PUQEkeBKuntRFcvGbULSxk3w4PRHaJbadbZqWhqGuVctH3xSGj6S65dRZpaGoUEC6W2X
         mxDTIiF55hJjG6ciwuJMIn7GnFsjkEhcuQCuD+JLoF8xGhsZ3JojznSKQHPXpUhtDRZX
         vB6g==
X-Forwarded-Encrypted: i=1; AJvYcCWLsFclc0vRoPwhXDV1wxzbWGd3rrxAd/lsXinltsyl4RhXCq86zWiTfkY9D2ejP4lgimhyo0P6Q1Y+rnivIQQXByEpgGYDL8OTpOAUTK2KKa+s9Or10z3dS5ZKL+jq/avv2yxF4s/CuoJLI919QPUB8ZF77nVibhyWc2drzmiJyUEA
X-Gm-Message-State: AOJu0Yw96A1UWI7Ikq/uBIqPxB+zXe3z6hNGV89ar3VJH6qCs3yDcUPO
	26q6yR3YZPGeto31w3Wq/P6Y2sfmYGr978Ext+4x/Wb+FkfAIy5UbJAUpR1qfuYnv82HfSRHvF7
	EozfsfQRbDZUYhiW1gW7B49v/7NY=
X-Google-Smtp-Source: AGHT+IGXeWZrAjKZkuzJutdiGCpPnrNfbaEFu9lhTnYOWOM65FB5LIhmsHtE3nbdFDn4ykI9v0T2KInUEPrefVh1lxE=
X-Received: by 2002:a5d:5284:0:b0:368:68d3:32b5 with SMTP id
 ffacd0b85a97d-369debf8af7mr877389f8f.13.1721695713692; Mon, 22 Jul 2024
 17:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
 <20240719110059.797546-6-xukuohai@huaweicloud.com> <a5afdfca337a59bfe8f730a59ea40cd48d9a3d6b.camel@gmail.com>
 <wjvdnep2od4kf3f7fiteh73s4gnktcfsii4lbb2ztvudexiyqw@hxqowhgokxf3> <0e46dcf652ff0b1168fc82e491c3d20eae18b21d.camel@gmail.com>
In-Reply-To: <0e46dcf652ff0b1168fc82e491c3d20eae18b21d.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jul 2024 17:48:22 -0700
Message-ID: <CAADnVQJ2bE0cAp8DNh1m6VqphNvWLkq8p=gwyPbbcdopaKcCCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/9] bpf, verifier: improve signed ranges
 inference for BPF_AND
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, James Morris <jamorris@linux.microsoft.com>, 
	Kees Cook <kees@kernel.org>, Brendan Jackman <jackmanb@google.com>, 
	Florent Revest <revest@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2024-07-22 at 20:57 +0800, Shung-Hsi Yu wrote:
>
> [...]
>
> > > As a nitpick, I think that it would be good to have some shortened
> > > version of the derivation in the comments alongside the code.
> >
> > Agree it would. Will try to add a 2-4 sentence explanation.
> >
> > > (Maybe with a link to the mailing list).
> >
> > Adding a link to the mailing list seems out of the usual for comment in
> > verifier.c though, and it would be quite long. That said, it would be
> > nice to hint that there exists a more verbose version of the
> > explanation.
> >
> > Maybe an explicit "see commit for the full detail" at the end of
> > the added comment?
>
> Tbh, I find bounds deduction code extremely confusing.
> Imho, having lengthy comments there is a good thing.

+1
Pls document the logic in the code.
commit log is good, but good chunk of it probably should be copied
as a comment.

I've applied the rest of the patches and removed 'test 3' selftest.
Pls respin this patch and a test.
More than one test would be nice too.

