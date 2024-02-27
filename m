Return-Path: <bpf+bounces-22824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D23086A3E3
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 00:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B171C24D58
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA956460;
	Tue, 27 Feb 2024 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCvhbjN3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED355C2E
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077424; cv=none; b=P1U6bHL6se3E3/MEyFO6JuypL89jiSpAz9klfvlh1OMNX9OiMWH41hXJqjPFHG9NnRXgMj6eALawa4z+RsOF7m2vAYW9u4XE12S7u6737C4NWGgbaZaHusuFuU+tz0bIAx+sANcyCDev1LznReARznO3D5aZi+/ntlWnUdGhAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077424; c=relaxed/simple;
	bh=KutdNCmB+2mcG6w+TxXQpcdaf8Q2UIuMmOFgrLL4v9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+iOmET8NEDIbUADuijHd8g4mrisXf8DG9c5ZiwGkjtS+90dTo2I0oLLt33oUyq3cVYeg6phKi38zK+9qi4vo4HAau3azEpeJgcd7lzrZ3gAkEZkz8Wx9HTTbSWEeJjRkEdTwpTIxLDrVbEkRR4SaTXKVQM2ky2woOBMSc/LngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCvhbjN3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2533089f6so59427771fa.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 15:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709077421; x=1709682221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1lcTUsoa5QDJTIpSBO4UnUIlJIw41E/e6nZyBsZ3NEQ=;
        b=dCvhbjN3KX+6xz/xvJ/gM/04odnkRkAS053bqPgwCCrHHsOaRDJc/xT0875wQknsYj
         feIQ9juampxMIR++aU7T/GMERhhQS8d0L43D7ySJAFrh++R6IDDN1zENWO7kJxNBNe7n
         LaPQbilCmaZtvnXT9L03UEIGEEEY/67KWHWwEO9506UKkxYtzRXNKEGyG/EhKoGr3rWH
         V+KAojhqvRBgsFgPJQpFoq2Y78/PnUEjZUEmp98AZC3euUd3QerGgGFnx6GiqpeAia6j
         Y6PWYjuHjDPNPU0qaNtqmvoYU4+HyFLAwmv8TkK/KDNE1YTGEVRiNfVe4EgxnWvaTPnR
         rp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709077421; x=1709682221;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lcTUsoa5QDJTIpSBO4UnUIlJIw41E/e6nZyBsZ3NEQ=;
        b=iMXPPRIDbwaO5ooPIyvJ99PQBQBCHpST8kjAPMnjZSdRCjsBqsf/lTl1IWi0NG6cp0
         PFzlagO5uRwalqaFs2Avjh+0tm7D+Ses8G4+F+E3/THK9nRMWY8mFxXGPb6CICEFrvTY
         AalHSAFfVh1YRvYOy9ushchYxLTv4M8YiD1XhrDnEeZmMn3VH6ukc23jBjpFPt5RdvnC
         uJPhs+FYHNeB66+tch5hxW13uecAsC3vTAnOalp+JOwIlL9Vm7Dybb+xQNqS515UqFhF
         RZcOghjyQBap8gx5CkXmu1zYGuAgrGhLXD6AO+klWfigEt518H6GAqae8WCzMHMY06zC
         bbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLSXw+A/P6+iBEdkQ3nhjulSY4QWhMdk7MSgbj7evQqmR+WrEXIe4UBONLO32pj3hCFxJIOn82c3O4h3Yc9tyknZzl
X-Gm-Message-State: AOJu0YwiOuE7Jtqvicr0uX4mcKn4NP6kQmAI+G2Q5YjaimNCmDWqAHfa
	6jQAgpOqYkZxASNBjdmJqKgIv70UdAsJbsRBL5Q+A8mqUYNM6QcM
X-Google-Smtp-Source: AGHT+IEWzOr7qqOaffM9yocFoD9j+kCoIIPVXMCNi3/41TAeTI1otUS3Usnz3dhb0L0HnckmbdxbOQ==
X-Received: by 2002:a2e:97d3:0:b0:2d2:6788:3183 with SMTP id m19-20020a2e97d3000000b002d267883183mr7235244ljj.48.1709077421188;
        Tue, 27 Feb 2024 15:43:41 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g20-20020a056402091400b0056452477a5esm1227641edz.24.2024.02.27.15.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:43:40 -0800 (PST)
Message-ID: <96873180940fa4ce62a3555c9d2caa373b8d1160.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com
Date: Wed, 28 Feb 2024 01:43:39 +0200
In-Reply-To: <ee2d5820-c250-4526-826d-49fcd3391e1e@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-8-eddyz87@gmail.com>
	 <ec9d8997-f5a2-44b6-9bc4-2caaf19df8a9@gmail.com>
	 <c9395bfd3cbd27ec5280d2e55abc6a6186fc663a.camel@gmail.com>
	 <7adcc642-4dec-425a-b198-14bbc0416f21@gmail.com>
	 <f6b6bf33c1fa379fcaba9ceaeb841a275cdbdc68.camel@gmail.com>
	 <ee2d5820-c250-4526-826d-49fcd3391e1e@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 15:40 -0800, Kui-Feng Lee wrote:
[...]

> For me, it is useful. For minor adjustments, shadow types is easier and
> simpler; for example, change a flag or a function.  But, the features
> presented here are useful when a user want to switch between several
> very different configurations. They may not want to change a large
> number of fields.

Great, thank you for reviewing the patch-set.
I'll wait a bit for additional comments and post v2 tomorrow.

