Return-Path: <bpf+bounces-72156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F39C0801C
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 22:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B5B3BD117
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1893B2E6CDA;
	Fri, 24 Oct 2025 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ig/NWESD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43F2E6CAA
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336860; cv=none; b=U7KqBI4wrtsMhNSvSrcwbGYZCOlSfZF1sMuf0u89Td/gh2wSTY+qyePKkhuXXHGmBkRf2vQHutRpyIoF3sdcSToPewsjBMMTIZjq5+sxGrw46oChqbwBIaetBYDqJFi5k+WvsaS61EvWB5wd1MZj+CMGEuX7Pd1tzTxbIuRT4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336860; c=relaxed/simple;
	bh=QRmmUPZjD0Nl/pzvJDzPxygHUoc//WlZnhbayyftwX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQP3b3XZJ63EwQmAK8U1IKiJXwGJyaJk9Vsjil8a3l/RoNeVqeigqBRiFgCa8qsoUWOcp/arUkuIeTKyfLvXa2u2Zyspz7ieC23WpiMcwIGQ6OPpQ4854M3phrgYZCHOTOcA1YOuZSmmnnRGWC3X7F7eA+de9S2dLzrPa9Myqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ig/NWESD; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-784966ad073so31734877b3.1
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761336858; x=1761941658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRmmUPZjD0Nl/pzvJDzPxygHUoc//WlZnhbayyftwX4=;
        b=Ig/NWESDE+V92QIAs8zCk53vnQj51oYAK+pzbV212WD2G+yUvvKjvhTy9IiZvbfWWz
         47+14pJ65zdfrpG6ITUPgGZm3p7BsqVObqp8yKF3njxT8BlMatV4DGKQjGcuX7mvw5rw
         wkaXanPokV8WnRclwP200/vH3zEIeUmEOAPRs2pCQJSxGPALGqX1thYEGX6k+Wwm84v/
         NdQ370q4xL2lpiigeIrsFRbl2KvP8+CSXysI7CKHn5rv8nFVbHcT4dARO1NCK46uTteP
         FeJHPD2l+Y1kZLbGLMfGkcEoD3oBN1hCQNrX49yfL3iFzKxQPFMahCYqg/o4/8JuFskT
         ch0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761336858; x=1761941658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRmmUPZjD0Nl/pzvJDzPxygHUoc//WlZnhbayyftwX4=;
        b=BebmV3dSe7oV7rtEp2eDLKYCwEMxIqdf50TIvVnWp9XX9iw+Pk45Zrx5VTpNW00+MS
         Y6MdhwlkyY5P64qKkR+vJO+eF+5JcSL8gRXPCcC+ssFcLH+GK1PhesjEUo4Z7tHD5aZR
         6bs4V8uZD2WdEaM61sOfk9UEMeEezxaBqyv+X9Siy7tkugBY0Bj8S/uyEUa3jGraUPth
         eJoy7UEZAhoqy1l4sdm6hc+jtaQKTmFoN8Xp67r9xjripoQq+id73B68IPI4N3+TGmhs
         LYUtiDpiBzX5HTG/WiFyJHGFEZEX97vdz4l01nprilS8HCL90ljZgIZEwQJKxo5+P8rT
         IV8w==
X-Forwarded-Encrypted: i=1; AJvYcCUMPI70XkgLUUdH+uNwiL5PIBdcFA9+769tylERpEqY5Gne2KgovsjvH+DbM9RohyPGCiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89WkMjhU9OPsMH75E94dT2WAHsnWszjs8yP7bcF9d4XR6b1Wh
	Gg+Hg9BvLRHRGtM14f06xiZh/d1T9b5aF8fyX+xYqx2ecGDZkkV5KtLLnOIEzhQCOpyptz8U+fO
	mOhbQTJphX30hkFAwEuiHjYRCei+m0SeP+el46LPP
X-Gm-Gg: ASbGncvG4uK47OkJr+HKhACodc22UicttFMqX4RgaCe/HlvCRMPUZQg1GlYPIVJu6Tm
	Ybg7FobK9Nw3o3DqD+fj/JGMAIITjbkogCl6IP+JRyhR4db1LrCWwZ9KzmsCqCTPk2HzbUbQesk
	qSatr1YwdA/icWNCr+A4bo45jX0NNJ/WYvtgCCAs2Bf2SswxhdSA1vSFf5Edzb/2ks+U1wcNxlq
	E6kuNEF5UckvNiuLTq1VDnSPBz0ki+oZ6YjbsZJ2cDUEKy+K1YQBdtW6UMLLw2kveGt1jpTcYSF
	6Oc4b+DMxROjDtlQBCgCwd1uyk4uSPzHC3I4
X-Google-Smtp-Source: AGHT+IHTpYbhZDmL6ruzEWH+gphI5m7Ialef1RNXjW82+6aaizHeKOCv9/XRyMcMq4hJKcNstGH8IXkZIyc1k4him6k=
X-Received: by 2002:a05:690e:12ca:b0:63e:2f32:cccb with SMTP id
 956f58d0204a3-63e2f32cee7mr16781408d50.10.1761336857579; Fri, 24 Oct 2025
 13:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com> <20251022182301.1005777-3-joshwash@google.com>
 <20251023171445.2d470bb3@kernel.org> <CAJcM6BFTb+ASBwO+5sMfLZyyO4+MhWKp3AweXMJrgis9P7ygag@mail.gmail.com>
 <20251024131004.01e1bce7@kernel.org>
In-Reply-To: <20251024131004.01e1bce7@kernel.org>
From: Ankit Garg <nktgrg@google.com>
Date: Fri, 24 Oct 2025 13:14:06 -0700
X-Gm-Features: AWmQ_bm-8GreWoq_uf6j4SHvhOnHL6CyYtA5h03iWipus0wRS1EtWd4i-WIu02I
Message-ID: <CAJcM6BFnN2HSYy=3+ocx+-M=tZroba6wCz9Pxgc8hyS0szdD2w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] gve: Allow ethtool to configure rx_buf_len
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 1:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 24 Oct 2025 11:17:04 -0700 Ankit Garg wrote:
> > > Please plumb extack thru to here. It's inside struct netdev_bpf
> >
> > Using extack just for this log will make it inconsistent with other
> > logs in this method. Would it be okay if I send a fast follow patch to
> > use exstack in this method and others?
>
> Could you make it part of this series, tho?

Absolutely. Will include in v2.

