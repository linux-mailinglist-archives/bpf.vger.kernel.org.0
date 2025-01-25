Return-Path: <bpf+bounces-49756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF70A1C08D
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 04:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30851165E46
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF8D204699;
	Sat, 25 Jan 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVtKzDEZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F414831C;
	Sat, 25 Jan 2025 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737774019; cv=none; b=pK5PJBONOMgwGwbSV8QKCdnSvD+fhIzhN7dozqHSSgMi7vj9YkMtOHgevnxBnLJgu2r1/8SmINfTEVtaWwLO5kkCfZG6POkiGE3xXrI/G+sRfaPIvSkU8Ra74ESe+pt5BJ0po9s40PdzkJ//ojejWn0ZmD+XGyALXRzxCoeiYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737774019; c=relaxed/simple;
	bh=s2JVhHtUWC016zBxPKnMvvM6WKnyb1g7oIsbUEszeO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/t6+vqS/C7g1shY6Roqf8CF1AulTk/FbxUmH+cZN8c+1KiFTuoq+xk5MxquDNdxm6GvAlotLrlsptXmS41hH8SXbax8ns79IVuB5/evQTrlHGjKV8mIF1O+QfoKnw/29Zz/cd88XenJBXtfZJBnrQ5+fTSY5eba3ur0TRXlZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVtKzDEZ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so197788839f.0;
        Fri, 24 Jan 2025 19:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737774014; x=1738378814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp9NL7t8zXY2sRVOLerWA4VrW9USesrxxXfLHR/G8qE=;
        b=DVtKzDEZAHoWKx74gsG0Kr67Pz/g+L2Pq1rpFUtI9M6qir4rCMAe6T6KfWv8BXixW+
         YvUhlPnH4H5CuutM+QYSCv43XZQWr60HWnts9tQc3sw0DxQUNdbTh2EXtQcoR5BL80hb
         4p2D5rgVQeuk8yqr9rkivu1ffuMLnubukxr1uk3XG+pXnFQlCoDo6iTsl/eCRMrQLdPW
         bkgYhBEUVIn4sL14RPrjtbw+iUp/HGD/QdmqSp8JWQQkqoPkSTIARX9YiKGKQ0uImzeU
         WWvRnPvvpo6TsZku2tdoFiKgbaAWRZtkdsrTxBktz9HgiOh5LMa4udKlZY/46Ck2rNPL
         k2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737774014; x=1738378814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wp9NL7t8zXY2sRVOLerWA4VrW9USesrxxXfLHR/G8qE=;
        b=CWrWdoFDymWUUhewD9PPG6bWCnaTNctyOXnZ10H7vtwXTxggklMbg+4/ldGS3I9PDi
         nYrC+uwCrWBdvxi2Fjkk+aA3YzCV3qqVu+o3pAE3TY1F9HdW5IKYOAZgTOdM0spN13cG
         g940zW36rNzVgbixCWY/9MjeFeRnIMh1OawV8ESAsACvxoUUN6ZABScNvFYkprUmVShN
         7i4CmUwZelrlz0qp6uL+WGAGrKoDiwfQ96d7oumlkxuzEHO+BxwP0oYquuUo3BmQO3P2
         a/nk/dpuXBfOH0qK8IEMhftePkPvOZzhL9kV0Jy0yIR7TFE1yu7/E+6ze0j2wfhMvH8A
         gEAg==
X-Forwarded-Encrypted: i=1; AJvYcCVeG3V0YVR8GCRb/KbrXIpwYiXycUnQlFYBAFL2P2nrTD1bEiTmC5t8F5+9ZECQlLyBIpg=@vger.kernel.org, AJvYcCW5Bwkcfws45QWMbBl01XdoLsg+NZG7FWE/L1KPrZX0JVVh/cjFEYhHG/3bBrcEt2jhGbnhTuPH@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaMV2P3N1uyaULbRERICUSBln8BHJOISxvXz3ii3/IB3ch4PQ
	Ipk6lgFxuaw2L+EtLf+gsGCX9B+2NOBfEgbQGbMWLQDnJPjPNolC2SDf+vdc8N+STM6ypybesaN
	c4sGw1ipcGdWlOFUqZyTEatOE8gA=
X-Gm-Gg: ASbGncvzo4kY79q4gJGsqa0r5yxRa4cS+2eg6yLLxQW2hIGTYvLHxJMOz3/zrWwWOBq
	dyRBucsAGpY21YT8VupVdszBm4Fk6U+NGrO8fxSKRxOdVZ2aplKB37ClYo0buCQ==
X-Google-Smtp-Source: AGHT+IH2/C53p+L43PT50h3jUSde9ylukeaVHvfy87ho+Zh7+OWs18iwLJ2PxiR5Yi3OHcE/J/9iykUTY9CenOKtINk=
X-Received: by 2002:a05:6e02:152b:b0:3ce:7d8f:3d73 with SMTP id
 e9e14a558f8ab-3cf743df874mr295855485ab.1.1737774014373; Fri, 24 Jan 2025
 19:00:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-9-kerneljasonxing@gmail.com> <40e2a7d8-dcba-4dfe-8c4d-14d8cf4954cf@linux.dev>
 <CAL+tcoCzH2t0Zcn++j_w7s2C1AncczR1oe9RwqzTqBMd4zMNmg@mail.gmail.com>
 <3a91d654-0e61-4da0-9d09-66a82a24012a@linux.dev> <CAL+tcoBVtqNA_7dN3vpG9VqagjM=VaRKKxDBUiUK-DHPA5Mg=A@mail.gmail.com>
 <7bf7110c-b978-45b8-9f74-4a37d6e98d5d@linux.dev>
In-Reply-To: <7bf7110c-b978-45b8-9f74-4a37d6e98d5d@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 10:59:38 +0800
X-Gm-Features: AWEUYZl9DdfjzdnyxVz6tgb-JE7m2gfpq4umfi1zg_4z1o1NOwCCMr-sKbZLW_M
Message-ID: <CAL+tcoBJNmnBEhb5SM3+zU=a6xFw=ccVBA336B1Jfmv_6Dhr=A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 08/13] net-timestamp: support hw
 SCM_TSTAMP_SND for bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 10:37=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 1/24/25 5:35 PM, Jason Xing wrote:
> > On Sat, Jan 25, 2025 at 9:30=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 1/24/25 5:18 PM, Jason Xing wrote:
> >>>>> @@ -5577,9 +5578,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff =
*skb, struct sock *sk,
> >>>>>                 op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >>>>>                 break;
> >>>>>         case SCM_TSTAMP_SND:
> >>>>> +             op =3D sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_=
TS_HW_OPT_CB;
> >>>>>                 if (!sw)
> >>>>> -                     return;
> >>>>> -             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> >>>>> +                     *skb_hwtstamps(skb) =3D *hwtstamps;
> >>>> hwtstamps may still be NULL, no?
> >>> Right, it can be zero if something wrong happens.
> >>
> >> Then it needs a NULL check, no?
> >
> > My original intention is passing whatever to the userspace, so the bpf
> > program will be aware of what is happening in the kernel.
>
> This is fine.
>
> > Passing NULL to hwstamps is right which will not cause any problem, I t=
hink.
> >
> > Do you mean the default value of hwstamps itself is NULL so in this
> > case we don't need to re-init it to NULL again?
> >
> > Like this:
> > If (*hwtstamps)
>    if (hwtstamps) instead ?
>
> I don't know. If hwtstamps is NULL, doing *hwtstamps will be bad and oops=
....
> May be my brain doesn't work well at the end of Friday. Please check.

Thanks for your effort, Martin!

I will deliberately inject this error case and then see what will happen.

Thanks,
Jason

