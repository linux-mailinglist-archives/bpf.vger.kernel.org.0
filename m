Return-Path: <bpf+bounces-50489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D55CEA28345
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 05:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A116571C
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 04:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9872139CB;
	Wed,  5 Feb 2025 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAVFLDhR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455125A650;
	Wed,  5 Feb 2025 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738728801; cv=none; b=s1o2V+sZX3aua9S9p2Lxu8Aw2mbo1w8U4VJv6VZP7bFMrGq+TuX13Xex28EqetEzc+KsMMdFfvvpH+YYJHX00WC1d1GWCtUnk5aFq7DzTI+uzMxcN2TbTxrGttjM5V93Ic60CiGQeBI1l8/nUIXxUHW0xkW0cQMGPtjfXocfrKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738728801; c=relaxed/simple;
	bh=+s3LefXLlNCA5fl0feJyjjZcXtEDfoG3n55IuudFF3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRKgNX+0bq0hP5XEDXVyQtMm7AzagKXAWNcBkLIgIiGTuHAFzYQO2oOsrky4EDdjno/lg4NgHoOCVzcrpeNJrsn6ErvyrMy/0EyzM1NVqZJFllL250JaWuKFIgCIM82TP0lsbUYWeLfKpFjOKPUJR/VpHoVyuX5xOmyaehiL2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAVFLDhR; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e46ac799015so5823263276.0;
        Tue, 04 Feb 2025 20:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738728799; x=1739333599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0huHE4UuIu4kQSf4E6Kmw+nnapeq5bzkpfgwJLnTVo=;
        b=SAVFLDhRQonRlGIH5aXFUfLpdo1ox+qK2eBQvS4L9UhMnZZVnfPvGm7Kkxx8YjiOvx
         El0fCYb7AKkruQ7e24dHEEx6R2l+ZUC5JtHAip09qz7W4U0z41L1bEXfhEL4V/xsBFuQ
         lC7V1sHcOlyfJcCnPYeXB7MOIR+a/7Fg9oyV6FrRpgKwITuOo+iX5b57xA74QAjxE43C
         TvR9Hlj6PLfzNJmQa/bycUonGctfjRlggHzLRz6nWUZ/Bzhq+lNBuyNxpW0NznzwnKJo
         Yu/IJQ+2jD+30aTPf40uYjR40FW6vVWjIcVGdxGRST3xaX6XPeTow7Fsxo3N0L3C7rlr
         q1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738728799; x=1739333599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0huHE4UuIu4kQSf4E6Kmw+nnapeq5bzkpfgwJLnTVo=;
        b=Wq4IXPK+AvJZDY+aU/0XQ+dZe1ckwfRNFRYEFaZ/TR4kVWkNigl7sLrTCiAlA9x9tp
         B1MPdjtNzRHUUKh7PGCHQpxO2ahEof8S0g9OecQ7OeNHQWWlql9RrIcrJfScHWNFT+Ex
         Z5oTT5uZpD27LXSbVQ0Rn4ThiIWW3GB/H7NX7phmJxeTVU8QLx5iWloNpKCuljHndbWp
         aRlLfYi4io+TAM7Q02tGxULYbE/tIM+As4OsDr/XsrsUX8tKoqmDo0rowVOUsZtL742R
         vMWH8X3dgvO4shnaLpMVG+DOzF9bGGfjKcbLi9URXss27R+uTMgDXZrUBmEd9K1+d6tX
         6gzg==
X-Forwarded-Encrypted: i=1; AJvYcCUfAqG007vl6HzydoZd2wDflZl/18eygaYhvrkPJ4/nnfQcrDAkPseHjNYPUJbKAcSKN8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJO5P6pgwoBdKuRn0U5Et1vxgrWdr0s2by+sCh/Ls2CKOQxvxW
	OOoy93qbpm32kQo9IpRM37GaQ43XQFlN1uQ53+kGhagxUWe+5wRXIZZFYgCMMyGJKPP24uXVavt
	GQaXO4ECF3aGhlOqujYS9MeSfHLU=
X-Gm-Gg: ASbGncvlKxTBD5bsK3xxoydZnoKWKZTZ9AT8AjfCIzF4E0rBEkmh+5S13C3Qe9CbNsD
	iVWYgaSosOXyTowgQ+fn/1/5gEQGRSAPHO3e3/Dd8Rrtv8sGFtgRPj0X3eYA33dBF3Spn3FVC
X-Google-Smtp-Source: AGHT+IFXbfDYOlB7D31OOenhm1lyp6fuPx18c2ttepMxOx+jPV4HSTDQUishUk59fWMgDAxk/CgMftwARgGACC2Pfok=
X-Received: by 2002:a05:6902:2687:b0:e58:33d2:6a12 with SMTP id
 3f1490d57ef6-e5b25bd9037mr1150161276.31.1738728798671; Tue, 04 Feb 2025
 20:13:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131192912.133796-1-ameryhung@gmail.com> <20250131192912.133796-9-ameryhung@gmail.com>
 <20250204141851.522ae938@kernel.org> <CAMB2axNNvNMy1o6m2DKFwF7O2AkgxZXUW+6rwhhc=788v_KM+Q@mail.gmail.com>
 <20250204172725.30068497@kernel.org>
In-Reply-To: <20250204172725.30068497@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Feb 2025 20:13:07 -0800
X-Gm-Features: AWEUYZmmzrg-u-JLu5ZtUk-OCT-fpH5QLflcq46tS4caEJmQ14QYZ8JDlWqSrAs
Message-ID: <CAMB2axMrKN_2=o+SRAvh_cBkc347JVhZE4OgojH=vUyV_cBGOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/18] bpf: net_sched: Support implementation
 of Qdisc_ops in bpf
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, yepeilin.cs@gmail.com, ming.lei@redhat.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 5:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 4 Feb 2025 15:21:27 -0800 Amery Hung wrote:
> > On Tue, Feb 4, 2025 at 2:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > > On Fri, 31 Jan 2025 11:28:47 -0800 Amery Hung wrote:
> > > > +             if (new &&
> > > > +                 !(parent->flags & TCQ_F_MQROOT) &&
> > > > +                 new->ops->owner =3D=3D BPF_MODULE_OWNER) {
> > > > +                     NL_SET_ERR_MSG(extack, "BPF qdisc not support=
ed on a non root");
> > > > +                     return -EINVAL;
> > > > +             }
> > >
> > > This check should live in bpf_qdisc.c
> >
> > Might be a dumb question, but could you explain why this is preferred?
> >
> > I can certainly do the check in Qdisc_ops::init instead though.
>
> Basic SW abstractions, this is the generic layer, bpf_qdisc is just
> one implementation that plugs into it.

Got it. Thanks for the clarification.

