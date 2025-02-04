Return-Path: <bpf+bounces-50459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AB6A27F80
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 00:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B658E165EA9
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46E521CFFB;
	Tue,  4 Feb 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT3lOBFO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35421C19F;
	Tue,  4 Feb 2025 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738711301; cv=none; b=Wuztdcwj9ueXUQIiSZVZtT4MmzpTXiB8kSe2ePpfX3g6GI35zWO89rC2Grlg0tsG5BBbxj8NCuSLkSJuep633f+OQTGoYXtmacJqYrFb7AqE7UVq7kZnIULilrgBeKHvJ3AygMd6renLTU/fCcOkMiAKqeOeZ7giyEQuVlLPELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738711301; c=relaxed/simple;
	bh=8C+r43R7t8CBhPQ/4RIA6QmD58GvsuWFa2/7vu4xtvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rl2JMJfdZCUb3gzjUzB8Ju2RAWFpQhTQJtXjI5vlfcjNbqHRswTg8ignXVUoiy9JDAXn+fGuiy62zmJgHPMzC2+fUm7/zyw4AgW1m4ibJn9JzkKjLeAXs1ke4x/xMuByMSEZ7bRk+cBc0itBDOAr+Z27DEnMDBKjCkZWCHw11MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT3lOBFO; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso5500303276.1;
        Tue, 04 Feb 2025 15:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738711298; x=1739316098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmmbI8fOb7I3HXItfhRdYRDqI5AHl5BtIJfv0JJtPAg=;
        b=GT3lOBFOSvx71NgLxBqCsLjl9qpW7CCx3XNbYa4fAnWleumyDwFts2C4NUu9SVxnaf
         DbBO168MqNH8ZgDTSOSvOCFe2hvxMpnVc6S4kQjgfXAJdd/ILk2q30Ba6PsAFUikepTk
         PWstFvTBZG0dXjkzFXHyKx/ywwFGqlt83zbL+NEytAzbxevs5hd2nQGtfQ0pblc8Ft+n
         Qt4FXl/8RcW8xR9hjTfs2xIi8dhAhmpOo46VGYU8+0wTNjElz3updH0HhvG+Q+QY1+s0
         FilNm5GyKCXDYkCSN0cX2VYYT1oT9Sbcd8hEn7d1bJNOaXjZ6xip9dELFzK80IIjleO8
         QrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738711298; x=1739316098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmmbI8fOb7I3HXItfhRdYRDqI5AHl5BtIJfv0JJtPAg=;
        b=LuBqbgabpwZQ86kAhfO+5CzU5YGafwHbAMYbNEJPIH1L5CSMjdPq+U8fIYmTcHKADA
         7fMW/VlI33IxyPe2pSp8R2WwJEPCRsry0fdkkVzQoh2xi1a4JPfMRdUW5cw+MedB5qFZ
         vv2L50xEHWZIUOWK4kzZKQJCDiueBqqq3RhzQuvCIV+fAiPNYjKB6mf5kokmbBCw3ewx
         bZG9xxZEB+Nf39Xj+b8FLja0eZo0fDw+rK11irCsxY799HNkNpLzTxEL5RXeQlrCzUV9
         AsbSIUeuACi3axXkNKk970+HS+Oq+ITV8+i0/hOUKrqdy7h95jYMOPdeKQUr9CZVSCOJ
         V14g==
X-Forwarded-Encrypted: i=1; AJvYcCXu8wErwTS1V00mJsL+8GsVqVf4kRzSX6eKGFt9/jKkCjxjHYUSRplu5jmfR51sLT11mBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVcYdXPV+Gl6pBLjyIDVDCn3dNH5gK1wIbajw8LYlMe1hHjWa
	2xuEqXWZAc07RdNyIHScqfn3F69Vsxl2Gzmxfg5mGKyjcJeH8fo+IyZ5mMNvC/7DQdmjBptl6Q0
	3LPBjTPytuvDgiWo7qNloDvWEciA=
X-Gm-Gg: ASbGncvLoynDoS7S4Euglg4QtAFHSCjEMV3imFQG8J5xmPUqXKEztBi2/7VI6gNgKZV
	4BYBXOEPnYrR1rKtV2vF6hx0BtSdDff/JeykNP8U09/LPtgS2YLyCwGFvdA8kIDQTMy4l1P+Gus
	B5OxP9QJcRNSuV
X-Google-Smtp-Source: AGHT+IHG5JUWWSAuddklveIAvU6BhMIF7BPwTIDPY7rYI3oFFJ+7oOUd2e0ZIZYlMy23SK7IMR758JkevzYV0KbeZ1Y=
X-Received: by 2002:a05:6902:2204:b0:e5b:12f7:cdb9 with SMTP id
 3f1490d57ef6-e5b25a05d84mr808526276.14.1738711298538; Tue, 04 Feb 2025
 15:21:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131192912.133796-1-ameryhung@gmail.com> <20250131192912.133796-9-ameryhung@gmail.com>
 <20250204141851.522ae938@kernel.org>
In-Reply-To: <20250204141851.522ae938@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Feb 2025 15:21:27 -0800
X-Gm-Features: AWEUYZkEqMm4fApu029xrlYMo6iZXKs4m_ilS_dw_-LAaNmhcr2lDd5B8qK88jg
Message-ID: <CAMB2axNNvNMy1o6m2DKFwF7O2AkgxZXUW+6rwhhc=788v_KM+Q@mail.gmail.com>
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

On Tue, Feb 4, 2025 at 2:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 31 Jan 2025 11:28:47 -0800 Amery Hung wrote:
> > +             if (new &&
> > +                 !(parent->flags & TCQ_F_MQROOT) &&
> > +                 new->ops->owner =3D=3D BPF_MODULE_OWNER) {
> > +                     NL_SET_ERR_MSG(extack, "BPF qdisc not supported o=
n a non root");
> > +                     return -EINVAL;
> > +             }
>
> This check should live in bpf_qdisc.c

Might be a dumb question, but could you explain why this is preferred?

I can certainly do the check in Qdisc_ops::init instead though.

Thanks,
Amery

