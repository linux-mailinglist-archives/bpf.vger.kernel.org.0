Return-Path: <bpf+bounces-55737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED17A85F28
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 15:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7A0173814
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 13:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9A1E0E13;
	Fri, 11 Apr 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx+P+TWN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415618A93F;
	Fri, 11 Apr 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378360; cv=none; b=kQsMqgNOJRtOpdmeK0AgiZ7yx6lSPVxnpfPKAT8INPyiwq0yoLewFL7I7QEl9REsBHN7QoU7dKRj0AycqKsT6KmKHGhWe8rNKEUpoFlpKXDT5+LyLXZYi7qgGqCBSkrI3XHAxesh38CnQyUHuX/XgVZCGW51Xo9Oug92sxZP9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378360; c=relaxed/simple;
	bh=6auAeTvEbGMRITZyY4M5w7DUVgwBUd9Oo/zM3cb3fiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/c7B65ljYZTBDLFDBe9NJf9+VW9w0qmNvbIo6J8UVyjuwW/oG1ny38kq73rycgg9hHqOXvTfnNbwFu2z+MVPps4Gtdmb/XCpIizAZMFa5vWObBJXWzmcTuzwQSyApA84shpXCZuAH7FTvuwpBlc4oIHRW59gUC16OTX1u7MAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xx+P+TWN; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac2963dc379so325173366b.2;
        Fri, 11 Apr 2025 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744378357; x=1744983157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GlathsTjceQi/t2GjCVPqqGTc//79C9q6C7CdCvnNE=;
        b=Xx+P+TWNMQnpKK4OYe94JVYWP+eDL3Wepho2zznRqhcUeFD2QXH4SSKccevu9U3nuI
         tBRJJpeUvcH9Jig9P4P44WRNFvRqQs8yQsazM1A8mVIUur4ny8G/HBU5+dtHyQz8jbcr
         GiJbRSxOko4JHdl65yZzi7Io9VfGsaPoq69GyycTAb3wFYkGk2TntEPUOUagEim6GesL
         buQAc3hBB/XIPLwCcscv1qEZNjtb62K43wxIqgPMKP9yhF2bWJVQj8AthsSICOsr18ck
         h+uWWBj8Y3PXXEJNEkMzkfTqptzwUK1pmpxR/btl+9DTpwnTGumftepEMC2T9mAYlWzo
         wmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744378357; x=1744983157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GlathsTjceQi/t2GjCVPqqGTc//79C9q6C7CdCvnNE=;
        b=TGO8BhbJxhG1nPd/9AqhijHboiKAZ8Rlvb5weXRGyEdbVm2uatrq+3JiAARq2djZ/T
         3Tu3qEqc5vuI9NDByA6lBose33QU6K+Td+Qo71bi/mbOG1LjBSDYlQwjNTBY7hgkf1SP
         Vgu3GZf8LEs0folSphMqzL5xa+LHODycPihgUAHqnFnndq2E4gUjcGGk7q1jdrbZGLS3
         9DNrzlrRGMWoJcqZhzg2AqcidEbQbwN8dS5VQgs5zxTBO1WGnFM2eI166Pw5/1A4b07L
         gOw6srpYuNLh7A5WhnSNyEQJgEWKp+/B4Kk05i366Bj/044Mqccg1JrtwzhoZbCHAfNN
         VJlg==
X-Forwarded-Encrypted: i=1; AJvYcCVLcrXLLa7HABPb1SIw7umybQPMVlwOIUJs/gsvgYIvwAbVaac7xQgDXeeNSCpE1q1ajFnVg7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWA98PEuAQmGUKhzYyLJIdwZHMsEQBvZACgzv0MGphM3VxkAVU
	sbQeNZOw7NbG2ucRJMT5E0dwm/d4VzPOxqqNyR9n1MpZI9WTTnbMyrWnS7d6GReku07FK51SRrK
	wqxNWyVBoZJm7/ZhObMY2uH0PDTo=
X-Gm-Gg: ASbGncs1ydLcn26tDd8arkb2qZEy4VKDzUmLczNS26zCiodNBdTBsfq5lvzguQ8KvF0
	8MtojtVQ/+j2Mm9F5seAF53RN+V+5w+Ui4csdyqh8liiRbtT6syuvi5YbY44C1yadFtAdSnys3/
	e8hxzF1+MUbNcI19B6k9LGL0pv3198TKQzsufzleaQyYHsxG/DTd2bh6gwRP5f3YG3Vo4=
X-Google-Smtp-Source: AGHT+IEef5n8uwBF/gIUihQgoeIsWcFRzHG+hVacnglE/XMRvf9In/DoYsn+f4JZmYDYh06uIq7IcjNU8SxXxMY52sQ=
X-Received: by 2002:a17:907:6d0b:b0:ac7:31a4:d4e9 with SMTP id
 a640c23a62f3a-acad343a069mr261189666b.4.1744378356705; Fri, 11 Apr 2025
 06:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409214606.2000194-1-ameryhung@gmail.com> <20250409214606.2000194-4-ameryhung@gmail.com>
In-Reply-To: <20250409214606.2000194-4-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 11 Apr 2025 15:32:00 +0200
X-Gm-Features: ATxdqUGWpUTEathunBsuySzmg3x2f27Znxy4IMfqg7gdZwufPJ91_5KJ5tt-gns
Message-ID: <CAP01T77ibGcEhwsyJb1WVaH-vhbZB_M2yVA8Uyv9b5fy=ErWQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 03/10] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, martin.lau@kernel.org, 
	jiri@resnulli.us, stfomichev@gmail.com, toke@redhat.com, sinquersw@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Apr 2025 at 23:46, Amery Hung <ameryhung@gmail.com> wrote:
>
> From: Amery Hung <amery.hung@bytedance.com>
>
> Add basic kfuncs for working on skb in qdisc.
>
> Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
> a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
> in .enqueue where a to_free skb list is available from kernel to defer
> the release. bpf_kfree_skb() should be used elsewhere. It is also used
> in bpf_obj_free_fields() when cleaning up skb in maps and collections.
>
> bpf_skb_get_hash() returns the flow hash of an skb, which can be used
> to build flow-based queueing algorithms.
>
> Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb()=
.
>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

How do we prevent UAF when dynptr is accessed after bpf_kfree_skb?

>  [...]

