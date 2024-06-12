Return-Path: <bpf+bounces-31926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E25E90549A
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93A9B2656A
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF0F181BB7;
	Wed, 12 Jun 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXi0ZaeX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298317CA1D;
	Wed, 12 Jun 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200628; cv=none; b=VKYU5FZA6oBv26n0ouy9eMJFK1wCkyDIF16fqxDB80xd2TCH1rsW+H0cYrB8Vo+/anICUj0EEE42hzPKtHGnt7lnhfHakWehvB56SkIzDtuZ+05X+H7kWuTkzt/3CyCLMST1qYJjhXqvBI5QHdjVVKmUTfzikzOSfeiKJJzYWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200628; c=relaxed/simple;
	bh=VgkpApAv0XWVhyeZqIVjDLA8e2kkKodnF461ysuPxNc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UVe5I659XzF+CBqR8BnBTWXKblrtw20NS+L1/GLEQBeE+yQscSou9EAcMYMuFfWzi0j6uhdph6qaOfQzW2O+ez1mNyVUBFZ7+t3YlkwPF8NRfSoyXHM1l0+4BFmSZkDMRjAdhWoyqhcUA+daaXGRa5lMONn8p3SeBUSMY50Rvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXi0ZaeX; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b08d661dbaso9017456d6.0;
        Wed, 12 Jun 2024 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718200625; x=1718805425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myClNR6MZBQfRJrEDDf6nVsnfHCgfV4V7+aJY3JBsiw=;
        b=ZXi0ZaeXhOWBFxufE3ziJORJC7umKYi4jJo7CtD2EZz8nmENsa03qPwuwBNzYzaqrS
         KQj1Mf78isahy/g6xqWoXS0CIRpdh0YQSfoZzdPJrfdj/58vS7nxiAOMzT+10kJiXY4i
         XMIOYf4b0LN6aFiUcN3Ifq+XlUO49VGaY0/+8Vg6+zEjKKqzpprbgv8hKKD8/IrdRUmw
         Wau2JSSqevalmOo+5q8aLa7r3qow5MYk4FhHWaQqrFou6QzvW7JyNC64Hr2pclHZhBHV
         Csq13RtZ4d9a2RBRf7WQt3PFYxCfNtjBqaJqr/kfX41GAPNms4C2N5IY8iAsfYnaeYAI
         QOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200625; x=1718805425;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=myClNR6MZBQfRJrEDDf6nVsnfHCgfV4V7+aJY3JBsiw=;
        b=BP4RWRAJbcaB3bsw4dcJ9AiJKK9KJ6HPlAqOgEv4Ul/p0r6bSQUNncS9V3EAVOXlxp
         X9omAnA2z3qcpns52UzhYgHfiiz3mmP9caESXpjDXJ+x32S3GKNeMsMbzPGZdrAQBdaw
         8f3fT0kMiUT4iR6mAvUdBsFBtPPt7HiZiH6zHrOCXpRR/xlzWwvEM4hP1vRFvauR98Iu
         phDkJQWIMLq/yZiyzfbiMzb0k7gT/cQVh6E9LBnt79TmwnA7eRUAGfoNG1RwoUG1i70c
         ZaadV+PkxgmYCMkyHrBTpXonwT74u5HBm6Bq3VKH6EtmkvYCCnQabFpWqniFeGdTp52F
         ETEg==
X-Forwarded-Encrypted: i=1; AJvYcCWZzFUbLTf7dlrY+Wut2NstSzNNct6G0wKWqcNXnVPan1hFlrL9PEH/f5Vxd05XlNKGjXeOHDtLpSOKpdcWI/603pcq
X-Gm-Message-State: AOJu0Ywin3a2ozwpTr+ZbrjL2mFWE3CcJUZeqtyoiwlrex5bxnWat014
	Ko2YCSDTk4s3QCX6jfGzJrNoyHFV+ebfWctSKsI46rTbY9uH8Mqf
X-Google-Smtp-Source: AGHT+IHwfI47771c2CPntVeqBP3o3z5zPcr2t9lE8x3olznY0RBzzw3FHmqGLsuEir0oUYFPGHs40w==
X-Received: by 2002:a05:6214:4a04:b0:6b0:7b24:56f0 with SMTP id 6a1803df08f44-6b0c9f256b2mr36066256d6.6.1718200625616;
        Wed, 12 Jun 2024 06:57:05 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b082f55fd2sm26678886d6.71.2024.06.12.06.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:57:05 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:57:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>, 
 YiFei Zhu <zhuyifei@google.com>
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <6669a930e1bce_125bdf294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAJ8uoz2-Kt2o-v3CuLpf2VDv2VtUJL2T307rp04di5hY2ihYHg@mail.gmail.com>
References: <cover.1718138187.git.zhuyifei@google.com>
 <CAJ8uoz2-Kt2o-v3CuLpf2VDv2VtUJL2T307rp04di5hY2ihYHg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/3] selftests: Add AF_XDP functionality test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Magnus Karlsson wrote:
> On Tue, 11 Jun 2024 at 22:43, YiFei Zhu <zhuyifei@google.com> wrote:
> >
> > We have observed that hardware NIC drivers may have faulty AF_XDP
> > implementations, and there seem to be a lack of a test of various modes
> > in which AF_XDP could run. This series adds a test to verify that NIC
> > drivers implements many AF_XDP features by performing a send / receive
> > of a single UDP packet.
> >
> > I put the C code of the test under selftests/bpf because I'm not really
> > sure how I'd build the BPF-related code without the selftests/bpf
> > build infrastructure.
> 
> Happy to see that you are contributing a number of new tests. Would it
> be possible for you to integrate this into the xskxceiver framework?

Makes sense, we'll need to take a look.

This is an internal test that we have been using for a long time in
our test framework.

My mistake for not keeping up at all with the changes to xskxceiver.c
in the meantime.

We want to test each case independently. Including a few non obvious
cases that we discovered from real use, notably

- Using XSK only for Tx, without installing an Rx program
- Using XSK with an empty fill queue, filling it after bind

> You can find that in selftests/bpf too. By default, it will run its
> tests using veth, but if you provide an interface name after the -i
> option, it will run the tests over a real interface. I put the NIC in
> loopback mode to use this feature, but feel free to add a new mode if
> necessary.

We do really want two machine tests, not loopback mode. Also to
integrate into the drv-net infrastructure.

Another non-obvious feature is to test one side AF_XDP and use
PF_PACKET on the other side, to be able to isolate and exercise only
the Tx or Rx path in a test.

> A lot of the setup and data plane code that you add already
> exists in xskxceiver, so I would prefer if you could reuse it. Your
> tests are new though and they would be valuable to have.
> 
> You could make the default packet that is sent in xskxceiver be the
> UDP packet that you want and then add all the other logic that you
> have to a number of new tests that you introduce.

