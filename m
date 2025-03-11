Return-Path: <bpf+bounces-53821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C87A5C2CA
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 14:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8217D173F30
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209B1C5F09;
	Tue, 11 Mar 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q859J9/j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8D5680;
	Tue, 11 Mar 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700000; cv=none; b=D22QIMejih2VJFG9fMDP7TeyYiGEEUE0fOrE/NkfSRrg00f0ET0yj8l0VJCtqjjTo+T/8F13DSOhnjSSr2uiwZCnaM2xAClrTYz0R05I2ryThd/c+cfBDaECqiHkQMTOd/CAsgfANDzCWax/WWYkSJlKOWUPURy/9mygrqllqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700000; c=relaxed/simple;
	bh=7Zy1kk4BdRdQtbjOTG9mU7W9gqw00B9cGe73F8xSpqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHP+9FtdpWrDeOfOb0b0Gy77acEkL1EDkpnQpNrVvjzlubDdjJqniEVaMZupLLJeVuLZvJmOjjAu8zpfUR5uR66hRiDFtokTYsAiu4DEneH1LbjCn8zcWHrD1WlHpexhke/Bjd72CtvxVsV2c0FbmeyjJ7Kv5yQshaI/sB5jcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q859J9/j; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso1152583f8f.2;
        Tue, 11 Mar 2025 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741699997; x=1742304797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrGfX4x2Aa9xenpc4m1RZVV+TDDD5yQuNTqPBgfqUZY=;
        b=Q859J9/jtE9o5HIVTmweVytG9Nw2OnK222TLroyAI4AtUVSxeHQULoUZ1kafI7Yi8p
         UOHLZyISLZhkEneIjDTZFgz5Kv3NtSgobQF8T+iGublnOQK0KBpA0S/mN4mFrAaftJfI
         dvGP9tXNSl3EHUj1iA055ulhemP1MVQ58URfSuhiPfvCMOt5c2EVB/ib3acgBzacjeFa
         469kAAvSOTiWgmWMFMuodQLF8lk2hWVKYYDrv9eFLLPwxj/vmxSIGt8lQWvZZ43qcavm
         jyIOlVraJ6fk9twnGs1rxhtKADvRmQRpdPdTu1m2XfGDYz+ofoEYBih748DDbZz/gR0Y
         EYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699997; x=1742304797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrGfX4x2Aa9xenpc4m1RZVV+TDDD5yQuNTqPBgfqUZY=;
        b=AdxSp7ZUldf3H3th23ZYw1iyyVt/jOuzX+NHZ+fzllogEllnAZqu5MchV60xSN5ApE
         aqMMyjCdXycn3YXgKAgKZJiSGegLTbblBK6h+FopJGK39t7V+6AvkKSjsB7zBkgwKEAq
         Iuy160RwFbREJtIDXaEmG9JbxjEFaSoc9wNwvppfDd75RIWPufsrgRxyvUGxpzw5zvKY
         GUz6YuhGAg4KgBGpaRESrMk0fcV04MUhGjZk/dZz1aApJQgc07eYK3Y6T5FdODzcaqHt
         4fH4LEFEg9p46X8IRSU6dsRRsHwQMvLbq/lgMfNf5PrhpdrjmmeRYl7bOX3sUAy0q1uw
         tZvA==
X-Forwarded-Encrypted: i=1; AJvYcCW7H1LeECvy+hBJtmRzEGk1VysvrzqARu3/VkdsUBZ62D1qDksAhP1aFKJzSTO3nELU/lsoqpvBEbcyvcPZ@vger.kernel.org, AJvYcCWQVQ4TIpD68G/21l2+PItq61gIm3wtJKHZMml/Soo05YAvSKwUQzAU5PFVjbztC0tOcphmIaI5U6dEEw==@vger.kernel.org, AJvYcCWSt3fOsUH1C3GIb8BvYvCi5I8qMN1mB20wGIUUXQUTOUxPOBhB2j+M9ubUH4whBlnNXRX4Ql2G@vger.kernel.org, AJvYcCX61EBDQpWj2pq+RjX93zGQ539S+usn0FQO6a60ejWP/WoXqKPbGWiqVxsrrwClTm2ePJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHHc1c+k1MOMX1vM37s98sdb9pfiMm4BcCzfw31FzqZh7O8NY
	KlWvnJzvxFr5nyYFswhfiTUdro3LSxEp4v8Yv9T3uURMHYGF++otHX5PFyE2X8KBufMH4fFV5Yl
	NURe0PNF3b6+q3koCm4GaTA7zy6o=
X-Gm-Gg: ASbGncvJjnz/nkHImJM6ZCS4IAx0lI9etSHsQmvzT5c2eH/Ot7MOjwWWlO6/lO0ptEW
	DxV99PzceA3fgwy+FPPooZpaiXIyCR4u6TmL7WMzmIcC2jlMTA0lW0EO+wNbzYQRNNUO5mX3ZnY
	FPa78gcDHL8P3jW1CFazb+EShNdA==
X-Google-Smtp-Source: AGHT+IHBVQJuTfs9B4pfE5RirSQyaHtCcHxs515oakngY8PPeyDMH0qZXPQnBLh1YjLsLXC6t+3qUlKS44WCNPYKboo=
X-Received: by 2002:a5d:648f:0:b0:391:3150:96ff with SMTP id
 ffacd0b85a97d-39132d57d7emr13975492f8f.32.1741699997097; Tue, 11 Mar 2025
 06:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311120422.1d9a8f80@canb.auug.org.au> <20250311093011.48fa9d08@fedora>
In-Reply-To: <20250311093011.48fa9d08@fedora>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Mar 2025 14:33:06 +0100
X-Gm-Features: AQ5f1JryXLRbqZUdBNcaF-eYH-2gTaTy0mT9LSBYjTmy9095EUpSZcnv9aZIGFs
Message-ID: <CAADnVQJB+4SY66r7oe+d4=qf+d96OmHb4o1763AQUw7MhdwDYg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
To: Luiz Capitulino <luizcap@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:30=E2=80=AFPM Luiz Capitulino <luizcap@redhat.com=
> wrote:
>
> On Tue, 11 Mar 2025 12:04:22 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > Hi all,
> >
> > Today's linux-next merge of the bpf-next tree got a conflict in:
> >
> >   mm/page_owner.c
> >
> > between commit:
> >
> >   a5bc091881fd ("mm: page_owner: use new iteration API")
> >
> > from the mm-unstable branch of the mm tree and commit:
> >
> >   8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> >
> > from the bpf-next tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tre=
e
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularl=
y
> > complex conflicts.
> >
>
> This looks good to me:
>
> Reviewed-by: Luiz Capitulino <luizcap@redhat.com>

Looks good to me as well.
Thanks

