Return-Path: <bpf+bounces-68569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 426B3B802A8
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835A2326380
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32E22E0902;
	Tue, 16 Sep 2025 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr4PlmSp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084FB2D9484
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063152; cv=none; b=h8jWI/Lweimm+tZkakMIMOi+4IhcPb/dt9T9zl7nTAPHSQPm+2WGIdyIRatWsjkV7PndIFLuq/Ov1hEesOMTJxHibrTCCT/4c2worPMFtKQk9V5QWf16TRzwoBhcPM/i7O+97olRviDKmCjMiP78DDcC291fH3AyVFkdHV09BKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063152; c=relaxed/simple;
	bh=CNIc+/z0YPhRzNU5H38f52rgt7kECsxQHwwK3vJpVDg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WoGteUnpG2AbwP3SuWl1mlXa7LMdiLmtB9MWv7DWeaHY1mI9f6Iz2lkGchivOXJBLSp/Kf0VG7A/3oIRt7+42sBOygKe2qgwBtZqMnNOnzjPF6shp1etCuOhW96NNAfeSELCklZ6KXfdiR+AJHjgt/zaxfl+DMDKm2+9EJOi9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr4PlmSp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77786498b5fso2398942b3a.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758063150; x=1758667950; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIgBWpcgvHzO8Q0Ibm4973Q8eUDOqHp48szsu3vTCik=;
        b=fr4PlmSp9tRXuJDqaH+1iVFN43+4jwSTwlffN3l/FzeLx6QpJMFjLX3IyO5KE0E7Cj
         UiYrNae9TRaazb9fJPHprmJ2o0qHUcjjc2FhGZD6Tx7XWiu7Lie4hBUeDGgyISKKNUgK
         /hwNLVgATXaMIFeM2aq3NnIWTaPvtK3m2asQNcnsHxrG/jxDN9JArIl+D/Do/eTNYWiz
         yi7TthfHPTb1MQfZYlMRMnNdITIhV3zISShy4mTvECrXZ5tHZahNPIbPme0d6PbB+k/i
         IlI6KYGpogtBrtZUNrFnIiq7z3N5Ci5Idjz2hNMes0bD7llXJuAuq/IkJuTMPpGe1TBO
         MZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758063150; x=1758667950;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIgBWpcgvHzO8Q0Ibm4973Q8eUDOqHp48szsu3vTCik=;
        b=GvnPLceCgeJkzupq2bR5dW6gdrv4ORrK7artkXBcvSkRwrmTbKyYudaMGnMv/3c/a0
         loB0miNTkJOHxhdEbYSvcgNCk+4bSpcfXkopXVgEB5MS+tRgTC2HE2ALNvM5g5Tih39C
         Kvcm9TCMT7ZvFjr2KjhlvDiMJSId0R5GMuA0KeEmm4JJUnCJXGufIqJx7Bqr7d49HP2z
         HtdrysJfDHx0FEI/XGiwiZPTZmZZjuOAeeffSQsSvYnHnIAm/nf+7qQlxvzu+VSg+xJX
         /3dk0csXFbPk0fUwurKUzdL7gVNALL7AVvwuUUk2axf8l4e8VmIXWfHa0CxI6Jy3umO+
         6LMg==
X-Gm-Message-State: AOJu0YxcKbGaF6KetyokE5xtem9sbEQqQOfB8Q1rHOPnksbdVC3vHIB1
	SvplN+ShAp0NkvVEA4Qg4mdleJ6Ai4RtYMJggyf+lwkLbXgRwDavOSEX
X-Gm-Gg: ASbGncv5isoc52BGVGh2J35KJyAg5kr8cxg1rPTi/V76goc4XT4XcJK6q2saHXUV7Kn
	erPrX7VZUPLi1ea0DRrNWUsiBmh1jFb5RfTIJKURI5ipgGzcOW77ItLagbjlWQeSdKIKklQOZj2
	+Hxy70wDN5omLuqOWLRHBe6NYqrUyY+GuBp+/9JASJvWHXLgDRrWsF78LTtfL37WVwHbXv9Ox5q
	+TmQ1P0RUfu6YXg9TnFIGz5azDsCchwujyERFQG3poLXmUB/wNlrrgwVQ/gV12i5f8UQQRX+a2w
	1ChF6GRPs3RFp3begSnLa/n1dncagmCMDPCsXr1+h8TqAJPvT8n55nFw2ynNiATZd9YcMVUCSfu
	aMPYZnmExL6ItLashrmDPk70bSY1edn73iHnYK1bvcaQuuA==
X-Google-Smtp-Source: AGHT+IE+5wY0WOhuHFitk+YGINteyHjSH5gngOESdfQU6I+TjpKpt9qBScOI1cvavzkPeaxLWpfqEg==
X-Received: by 2002:a05:6a20:7fa9:b0:240:489:be9a with SMTP id adf61e73a8af0-2602aa8a67dmr23424437637.23.1758063150164;
        Tue, 16 Sep 2025 15:52:30 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a1:9747:e67f:953a? ([2620:10d:c090:500::4:432])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a46f0esm16671341b3a.25.2025.09.16.15.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:52:29 -0700 (PDT)
Message-ID: <d364feea75ec3c473e214b3198fe0360ce15ae43.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: dont report verifier bug for
 missing bpf_scc_visit on speculative path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 
	syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
Date: Tue, 16 Sep 2025 15:52:28 -0700
In-Reply-To: <CAEf4BzbMa07jVzDpdnfdZfKyVXbE+XKyoJ+UyM-Drv-2850UZw@mail.gmail.com>
References: <20250916212251.3490455-1-eddyz87@gmail.com>
	 <CAEf4BzYJW+O6CD5+V1wP3uF0=BBVNLrUwM+co7Pps8HF13p3Ng@mail.gmail.com>
	 <e011fbe6e1e715243b9d1166d7a125036cbb6b9b.camel@gmail.com>
	 <CAEf4BzbMa07jVzDpdnfdZfKyVXbE+XKyoJ+UyM-Drv-2850UZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 15:47 -0700, Andrii Nakryiko wrote:

[...]

> > > grumpy nit:
> > >=20
> > > if (st->speculative)
> > >     return 0;
> > >=20
> > > ... leave the rest untouched ...
> > >=20
> > > ?
> >=20
> > I did this on purpose.  In the comment above I explain why the error
> > is valid only for non-speculative path, so want to have code and
> > comment in sync. Tried inverting the comment to explain why it's not
> > an error on a speculative path and it is confusing.
>=20
> ...
>   * (c) is the only reason we can error out below for non-speculative pat=
h".
>   */
>   if (!st->speculative)
>       return 0;
>=20
>   verifier_buf(...);
>=20
> (even as is your comment read just fine in my head, tbh).
>=20
> But I don't insist, if you find this confusing, I just don't like
> deeply nested code when less nested would work.

Don't like nested code either, but in this particular case like mine
version a bit more:
- same nesting level in both cases
- error condition is explicit
- in sync with the comment.

[...]

