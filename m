Return-Path: <bpf+bounces-66546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E566DB365E6
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607AB8E379B
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A5A27EFE7;
	Tue, 26 Aug 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEm1c/MD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02B11946BC;
	Tue, 26 Aug 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215692; cv=none; b=rTGc4pojbb12FacVptmhOfV5JS9WHp7Ju7y1OXnWwyb2QfLjfAe7XeefjqbGJlzFIh1qffGY8lVdJCve8/yBUWPElMOybQgb5/fonrxvRQaPNRwWmxfz5edu9IgSMKLSeYCJWcXU9WxWNJCXqtH0Qy304uVSuLEY/EmXhH6aUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215692; c=relaxed/simple;
	bh=StlgVVEhnfuy2dCHY7mJM3Wx52YzKkteqIBz7YRbBRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkBdjM1B4MFGuwK4Nh1oDZPCSEAjbi+F7qLRNQQcLyZW6aJ9a5CQVdBQe2CeRHMtyF0T395vLmUtudv1LBN5eOBsWGTPEZy2DN5HKxSfCxw4xPdo9Uw81vU7I2I6n2CWL044joLX7WKEORa8uj/su5ozobuDPz27q+gI8yUEPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEm1c/MD; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-886dd6e5c2dso178214639f.3;
        Tue, 26 Aug 2025 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756215690; x=1756820490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc8igmt9EzywQOCNzz3+8ZuPnWwRdVjnEqpFK4yGS+o=;
        b=NEm1c/MDqaTnAPofgNSo5ylNGPKGPJ202fVPjlaIlgQBBA5pE9nvIFExdtwRh7h3Xf
         YaWCrnZGbp3DGiRz/IsE5EphCQToZnkVULb0JIja1xHcHmJP1dkT1WmNH3qeAy5Shckx
         rVNvnNYWZpIbsFq0lUYW7D4Dl5DfpN8DIJEF/av/M4PDX3f8z+GmoDxLKNNCNzcDT2GC
         mDhU9Itd+5py4VFm4hy7qKIi+Aw9TMlOuWwPeEAo3+JzHUkjR6mqIg1X1+TY45UyCNdQ
         7iNyei9sGxUON5KUFVXcib1AFEu/c6xGWQHJ+HL/76GMH1+Q7th7RBNnwPYA24DPNymo
         iWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215690; x=1756820490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc8igmt9EzywQOCNzz3+8ZuPnWwRdVjnEqpFK4yGS+o=;
        b=RkiL6tLrsdZ/yJjhxJvN+A89Rkfbtbu1SvEK0BtPoM7MH+9K8+rrmo6vZRv3jPDT0W
         u/2B3U0eqhEWm+336w+tYWhi2+7SrYRNu0rD+l+El0LbHsqnt+l9OIesOGa2XeGRfJfX
         CnbyFJQzqdhHyJO3jIKcZuWEarvFd/H41S/Ez6ByF7QTNN8CdwNjvQtlDUY10DLN7AZ4
         lOIQTET9OWZbmmsBk47b3B6ri8axzRfr/1CS9gpkm/7K8U+HT2IoaFpO2sR/ewAv5Dbj
         iItXW2W1QIsTnQpCXL8SgYEVbH2fiHUtpcIcFir83PB0fD1zREh2RfexI86YkASf1ITf
         KX9w==
X-Forwarded-Encrypted: i=1; AJvYcCWKNtD6MoxLl3j/WvQRakOfT8RFJP0rchg/5GsxD29+KGbbxif0TZCFVpbIl/13g5Vgw0I=@vger.kernel.org, AJvYcCWLA0HVKPth+X0qFYKuAFzD5Urlfs/boOdZTvKnpz8vAGVxEfy9a8/rb1iqRD8hOQc0e5ioonql@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HZI+/rww5g2RaVP/4P8imXszHVD4gvHg/FU+znnebYOkD/aF
	QxnHq7M1cYKH+4gDI9POmP7PRWLGFNfqeT72KigATy8/p182GDeXW/HCDaU5GbVEQUVjhC/g5sy
	1ksut0naPAgckAHpC7ALzwQiEvqWYrlY=
X-Gm-Gg: ASbGncs+gWnk+E/+1+fon1uI+xJ7KlDprqLxGoLmzFeARjr7afO0u79Z7HWQe5jg8bl
	l3YnxJmfWkEIl8itxedO6A5MePd/eYFWzzD45FU5YTM8eci+5IU5DWCeZ0sQ3Wuehr90/yVU+0V
	7OkYe9bfA9vCcH3FaQJ9PXQHjbXkWjDlLIzL94Vfy/UNlACHt3YxDp54v6t/Vjyjuqisy2q4lBj
	mmuz3Z6wxeq4OTcgPsBwE4h+zU=
X-Google-Smtp-Source: AGHT+IFEddDfhJ4zM3pglm+bmljYDtNbEj2uaY4xL2WX94J5Pgslmq4Ui80HpfpkLaOkvFaxYTyoRjxfOgJaqeL/7a8=
X-Received: by 2002:a05:6602:26c6:b0:886:c53c:464a with SMTP id
 ca18e2360f4ac-886c53c49b1mr2049508139f.18.1756215689817; Tue, 26 Aug 2025
 06:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
 <aK1sz42QLX42u6Eo@stanley.mountain> <089fa206-1511-4fd9-bc12-f73ab8a08bb6@iogearbox.net>
In-Reply-To: <089fa206-1511-4fd9-bc12-f73ab8a08bb6@iogearbox.net>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Aug 2025 21:40:53 +0800
X-Gm-Features: Ac12FXwyprilJi-iJnGxS-Z1XsYqSG1pic_qZ0P1BDTwQUegmT_TSw0kyf06qQo
Message-ID: <CAL+tcoD=Gn6ZmJ+_Y48vPRyHVHmP-7irsx=fRVRnyhDrpTrEtQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, aleksander.lobakin@intel.com, 
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:24=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/26/25 10:14 AM, Dan Carpenter wrote:
> > On Wed, Aug 20, 2025 at 05:44:16PM +0200, Maciej Fijalkowski wrote:
> >>                      return ERR_PTR(err);
> >>
> >>              skb_reserve(skb, hr);
> >> +
> >> +            addrs =3D kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KER=
NEL);
> >> +            if (!addrs) {
> >> +                    kfree(skb);
> >
> > This needs to be kfree_skb(skb);
>
> Oh well, good catch! Maciej, given this commit did not land yet in Linus'=
 tree,
> I can toss the commit from bpf tree assuming you send a v7?
>
> Also, looking at xsk_build_skb(), do we similarly need to free that alloc=
ated
> skb when we hit the ERR_PTR(-EOVERFLOW) ? Mentioned function has the foll=
owing
> in the free_err path:
>
>          if (first_frag && skb)
>                  kfree_skb(skb);
>
> Pls double check.

Sorry to join the party late...

I have to bring bad news here. After I tested[1] on VM, I saw an
around 18.8% performance decrease (from 745,705 to 627,331) with this
patch applied.It can be reproduced stably :(

[1]: ./xdpsock -i eth1 -t  -S -s 64

Thanks,
Jason

