Return-Path: <bpf+bounces-32319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E490B773
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 19:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E98283D65
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F03168490;
	Mon, 17 Jun 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah11DE4j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E713AD1E
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644044; cv=none; b=ufULE90NYWKEYJEb2pQvunhS4Mx6jjTBjy8TFzDraiCOFoti0xj97+//iSBeGi4csT6zCXwNo4uO69sX1B8rVnXXheIBRoKauN0f2I1dikIexRIfB9y6BFomuwkDfxQaCHHVYyH/J9Rc1hjId1KmNpwbdyWCPHcOdEEpLOaTkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644044; c=relaxed/simple;
	bh=M0+nFscGw1hK6KqKAJZPQl88WWw4YSgOp13DMoFXjwo=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hwsF7IYSHGubHr8ocLAQkmn6YEnPJJPj+SHRFilQgKBHE8yN2jGAkew2JF5PBm7ZnBNqLhp4vzwMcKsKRYhbZW2GDDwzRydcgAD22SXNn8+m9Rf0Rjpa64tU6bw9yc9vmRDjVEab8RS0ALLZWI4pLLE28jYHTFgZr0AP2BP+KmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah11DE4j; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-705d9f4cd7bso2436209b3a.1
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718644042; x=1719248842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTQYtG5ZwPfwx+bmL7wQCD5n0z6XjPk2nYGnJYrR+cQ=;
        b=ah11DE4jV9SvGMi/s46V9Z5dYyCvZfaOpMrOcfBl+/XC0XC3gzwSwWbX/bxdtb9W+B
         F+SqcGRE50u0MZnu5k2FQ33snWy6aDn8MEa/dm4aWK/cDX3gk9A6i4I9+YT7tRXFtWDN
         0M5B3Da5VY9m6Q2vRfFsG6uPKeFTIIf6AVADZ8DdbO/yoYBYRwsotSYMA73ldZAL4sxc
         iX7wh+6UAETb1NjMU3HbQLYUZWK7+V53nAW0Iy2qrkKG3meKM9ty+3JEOaETKjwqtaHO
         YJBc7KMpwAdu0YkL6izxpBR1DNScfwNNlMcEfSQ7PFbQnoRyiSLqtaloWQu7TktISwaG
         7liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718644042; x=1719248842;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTQYtG5ZwPfwx+bmL7wQCD5n0z6XjPk2nYGnJYrR+cQ=;
        b=FpU8i6EE1zsqRO0WZYsBDQWEUlifmLK48BXW33Op/clHrZJQMn5qtAd+qD/svog9K1
         1JsaMv8MRB9y0vqdq87TuNcUbE6NmGanFezp9E9kfiCzg9ghCrU6rFUyHAjHQ1vxafsi
         n/8u8O1PPCq8OSG56x7aMgz96NJXy1yirM3bKElVdyZyCvYmaC/+gO7PpQMNJVJs24YB
         vbRnjeqkB6h61lbn/qO650QjaAg3/5AJeqVDWudJTUOyBiecSu7cV6+Kgh/eSr4jOiPe
         OGoz891bbf6fh5zeD+3i6cm/4ah2L8WCtFpwN3MQSgJLuR988sC/tBsMKQo5N5/whd2P
         Oj2w==
X-Forwarded-Encrypted: i=1; AJvYcCWxKtpJFVHo4eEz/Sdcd0yA6p8SCfEQ4LUfFyEgomDtuJBWRZmsa3umTfxjf4vSOBjmlA5w23F6ggk7ryX6tr99FUgW
X-Gm-Message-State: AOJu0YzoBp4nEEOtdtT+xSPThv6j0lgtwPCZEX3fkUs+9HniniLbcqyW
	OmNWQ0/MHZQBS2xcby4bna6qMzASOnQzMzpOUXjQKaY6LzkMv91d
X-Google-Smtp-Source: AGHT+IHlsoOKmf5QACZ8M8qzr2ANtg7zY0704f4c7ZKv2WnPsRzEK7cMrMyzrb4IgCQuBaq3CpE+DA==
X-Received: by 2002:a05:6a00:2d81:b0:6ec:da6c:fc2d with SMTP id d2e1a72fcca58-705d71d35f3mr12049909b3a.23.1718644041837;
        Mon, 17 Jun 2024 10:07:21 -0700 (PDT)
Received: from localhost ([98.97.37.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91db4csm7835544b3a.18.2024.06.17.10.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 10:07:21 -0700 (PDT)
Date: Mon, 17 Jun 2024 10:07:20 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: =?UTF-8?B?6YOR5Zu95YuH?= <zhenggy@chinatelecom.cn>, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
 bpf@vger.kernel.org
Message-ID: <66706d48967f3_1c38c208e5@john.notmuch>
In-Reply-To: <42dd5ee4-fb01-4b84-9418-65adb7480138@chinatelecom.cn>
References: <42dd5ee4-fb01-4b84-9418-65adb7480138@chinatelecom.cn>
Subject: RE: [issue]: sockmap restrain send if receiver block
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

=E9=83=91=E5=9B=BD=E5=8B=87 wrote:
> hi,=C2=A0In=C2=A0sockmap=C2=A0case,=C2=A0when=C2=A0sender=C2=A0send=C2=A0=
msg,=C2=A0In=C2=A0function=C2=A0sk_psock_queue_msg(),=C2=A0it=C2=A0will=C2=
=A0put=C2=A0the=C2=A0msg=C2=A0into=C2=A0the=C2=A0receiver=C2=A0psock=C2=A0=
ingress_msg=C2=A0queue,=C2=A0and=C2=A0wakeup=C2=A0receiver=C2=A0to=C2=A0r=
eceive.
> =


Whats the protocol? The TCP case tcp_bpf_sendmsg() is checking
sk_stream_memory_free() and will do sk_stream_wait_memory() if under
memory pressure. This should handle sending case with lots of data
queued up on the sk.

On the redirect ingress case we do this,

  sk_psock_handle_skb()
    sk_psock_skb_ingress()
      sk_psock_create_ingress_msg()

There sk_psock_create_ingress_msg() should check the rcvbuf of the
receiving socket and shouldn't create a msg if its under memory pressure.=

If its an ingress_self case we do a skb_set_owner_r which should (?) push=

back on the memory side through sk_mem_charge().

Seems like I'm missing some case then if we are hitting this. What protoc=
ol
and what is the BPF program? Is it a sender redirect? I guess more detail=
s
might make it obvious to me.


> sender=C2=A0can=C2=A0always=C2=A0send=C2=A0msg=C2=A0but=C2=A0not=C2=A0a=
ware=C2=A0the=C2=A0receiver=C2=A0psock=C2=A0ingress_msg=C2=A0queue=C2=A0s=
ize.=C2=A0 In=C2=A0mortally=C2=A0case,=C2=A0when=C2=A0receiver=C2=A0not=C2=
=A0receive=C2=A0again=C2=A0due=C2=A0to=C2=A0the=C2=A0application=C2=A0bug=
,=C2=A0
> =

> sender=C2=A0can=C2=A0contiunous=C2=A0send=C2=A0msg=C2=A0unti=C2=A0syste=
m=C2=A0memory=C2=A0not=C2=A0enough. If this happen, it will influence the=
 whole system.
> =

> my=C2=A0question=C2=A0is:=C2=A0=C2=A0is=C2=A0there=C2=A0a=C2=A0better=C2=
=A0solution=C2=A0for=C2=A0this=C2=A0case?=C2=A0just=C2=A0like=C2=A0tcp=C2=
=A0use=C2=A0sk_sendbuf=C2=A0to=C2=A0limit=C2=A0the=C2=A0sender=C2=A0to=C2=
=A0send=C2=A0agagin=C2=A0if=C2=A0receiver=C2=A0is=C2=A0block.

The sender shouldn't be able to have more outstanding data than the
socket memory allows. After the redirect the skb/msg should be
charged to the receiving socket though. Agree sk_sendbuf should
limit sender. Maybe the test is not TCP protocol and we missed
adding the limits to UDP/AF_UNIX/etc?

> =

> thanks=C2=A0very=C2=A0much.
> =

