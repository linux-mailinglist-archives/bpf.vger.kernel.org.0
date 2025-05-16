Return-Path: <bpf+bounces-58397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E7AB9B41
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 13:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4AB3B6B0F
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1998B238C09;
	Fri, 16 May 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJI+vYoU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA5233D91;
	Fri, 16 May 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395622; cv=none; b=cS/auwoLcibhOgdak1iI0JvHnuTr3cDZVeS8AGJEmdf5eY16Kj25wfvhIkUmxFhpc2kZF+tMaO+De6pZ5i0UyBHj5tQwtF+qAPRphEZNg6swWHMoMNzhxOEAA05mkW/nhP86bZPR0s5dBCBkI6B+yAzqf4aNpXz0wR5S1YurGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395622; c=relaxed/simple;
	bh=0Mj+BtykqOdNUsFmfW8HuzL6Mqk7536Sro33aJLlBM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjhTO8B4Od1iIm68ZvApM8ZXmR12UPmOGqEJ4wNQyRrW2LLYR09kY32EsORKovE9gAX/KwMA85qXZVttewD7FWR+eH9YYi4Gq/idXQtSH8LEzpZuG9znCwekPLydhkgwtON1KtY/HK7mwEHUVp+9eGycfNGujpoD0X/czhi7Aho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJI+vYoU; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3fb3f4bf97aso1035625b6e.2;
        Fri, 16 May 2025 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395620; x=1748000420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxhGcnn6IqTQUmc2HYW8DH4TY3uNPkdwnZshlk/xeUY=;
        b=EJI+vYoUz+pNMd9OmZU81t596MRisnDMMamRWUF7UeO6rUWdiqdseOoBWwFrBcBs4m
         IUuuZq40ksFpdBpJyiJ2b6XpXB2kaW5o2/RERpvBVjcQ6cIudOYfpjDGXfgRpDIdqFzr
         kIzuMinM0EuGMZAK2PriuDUdwDXWQIOoK4NhNwMgPf9XxPuU4LS0RMjwwpSy7uslX6Zl
         ZZi1Z41WhBVkWfVY5NeaFZ6805veQdNq9EcYBEnoTbM61UojE5ZtaO6JpkhvT8IvIVNt
         FfV+CsVPOmBGmZBFIHa51BaOkN3Vn/mt5LGp2GEXRwp78UzPfKSlLwf7wL8ws0ENx9fD
         jczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395620; x=1748000420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxhGcnn6IqTQUmc2HYW8DH4TY3uNPkdwnZshlk/xeUY=;
        b=Qs4D3Nh/pL0qQ/X+vttihnqF2nViKo3jO9ltYgTWxcHl0/FSMLal7Kit1HBdYwFhch
         p36CRcHqpCYgQe+TWHyOueQdlmbrX7s0Y0jrQBXm1yLq7LmS6LvgKefBreadRh7vwKd/
         Ks/QPTfVrpr6wctjHRT0wO+J6zJz5ho6s+c+CM/dj8bHW6dIMqGmjWlUi94DLfOcYiyA
         mUVQrKsmHZrAGIt1uQbgU9FiJthGyI3DJw9/KvEsUa47ojFKow0+ifRcQVzZW3t6ZkSZ
         wADJGBZiKazf0zlwJWP8fLAz0WKTlyvxk2R2bIyYtmP8FSzRTFVjAe7UXZrghHOwetTf
         dNfA==
X-Forwarded-Encrypted: i=1; AJvYcCVtXGc4UQGgYaPS19GiXg8upZXH+FjjL8STqzJkErx9/HH9o0ue2rZv6SEVLKo6eC2Z+dZjFnU/@vger.kernel.org, AJvYcCXPPPRaBHGQTHBCJYl5gGUbw5+qOwCPu3yPCRdmdTj0BQNV9S56oqKhCvlpOdxDbycHu5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSHBRLg+kK36/i258NzsFbMTlvbuKf3SKhEln7dit3+TroJIH
	4CBUTiwZa3pnGyf4puwkIyMQOzKQrWfK60iN5d6EJS+m8noNTP1KLp4KG3bU5uVc7XcikizmrUe
	LBspg9anQpvm3nZR5+hLlN2cbOOzzJmA=
X-Gm-Gg: ASbGnctJNraBgBKsbUQJidOlnLgV40QRsX/Xg2/fZoDoztN81jYPwKQcIWejyWa87Bb
	mUCAz3VD21y4fZLMp6YnZe+RLZdK+I5ltvq2FGy5upwgh5zwyubWSY0zOz2PSr1sDdrkPjBCozU
	dqsw57aWLCpbDB1PyKN939Xvo5E9sr2vEF6mUdXSkdcqT22uUjeQhwLIDQJ7/UJx0=
X-Google-Smtp-Source: AGHT+IGA6+yGsHEZB4h4688rV2RS7jYQS6csUsq5/06mGIJ8DFSpcISgYgYQEDE9K3OuPX1eYRNws+vogqTArgtBuAc=
X-Received: by 2002:a05:6808:3195:b0:404:764:f7b6 with SMTP id
 5614622812f47-404d865812amr2415447b6e.9.1747395620173; Fri, 16 May 2025
 04:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515231650.1325372-1-kuba@kernel.org> <20250515231650.1325372-10-kuba@kernel.org>
In-Reply-To: <20250515231650.1325372-10-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 16 May 2025 12:40:08 +0100
X-Gm-Features: AX0GCFsG0H-iCjEs2uW7AlC3GHq30MzFGvk7B22PHzzVerBpl1NH0wzI33Cg9gw
Message-ID: <CAD4GDZw-pL81FQmgKL9VBQ1pcHra_i-Ceje97y0ajXMoWvEuHw@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] tools: ynl: add a sample for rt-link
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	daniel@iogearbox.net, nicolas.dichtel@6wind.com, jacob.e.keller@intel.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 May 2025 at 00:17, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Add a fairly complete example of rt-link usage. If run without any
> arguments it simply lists the interfaces and some of their attrs.
> If run with an arg it tries to create and delete a netkit device.
>
>  1 # ./tools/net/ynl/samples/rt-link 1
>  2 Trying to create a Netkit interface
>  3 Testing error message for policy being bad:
>  4     Kernel error: 'Provided default xmit policy not supported' (bad attribute: .linkinfo.data(netkit).policy)
>  5   1:               lo: mtu 65536
>  6   2:           wlp0s1: mtu  1500
>  7   3:          enp0s13: mtu  1500
>  8   4:           dummy0: mtu  1500  kind dummy     altname one two
>  9   5:              nk0: mtu  1500  kind netkit    primary 0  policy forward
> 10   6:              nk1: mtu  1500  kind netkit    primary 1  policy blackhole
> 11 Trying to delete a Netkit interface (ifindex 6)
>
> Sample creates the device first, it sets an invalid value for a netkit
> attribute to trigger reverse parsing. Line 4 shows the error with the
> attribute path correctly generated by YNL.
>
> Then sample fixes the bad attribute and re-issues the request, with
> NLM_F_ECHO set. This flag causes the notification to be looped back
> to the initiating socket (our socket). Sample parses this notification
> to save the ifindex of the created netkit.
>
> Sample then proceeds to list the devices. Line 8 above shows a dummy
> device with two alt names. Lines 9 and 10 show the netkit devices
> the sample itself created.
>
> The "primary" and "policy" attrs are from inside the netkit submsg.
> The string values are auto-generated for the enums by YNL.
>
> To clean up sample deletes the interface it created (line 11).
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

