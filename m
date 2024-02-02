Return-Path: <bpf+bounces-21048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB13846FC2
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 13:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB74299ACF
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF513E23A;
	Fri,  2 Feb 2024 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="th3orebV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185A13D4F7
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875587; cv=none; b=FpWQDJfslDbCywG3cHqqF/+S9yOB0cfZtZyBBQMr9zB2eG8fRdfQj9jcvpGjXiRkCyim/NH9K0pKxxL6ZafgmB+LODjpj6wKd41fef64KO1gPDsbKPFF3xXJH0BzOaFtsOtM29ZOCFtd5CtSa/Z9ORW9F8uh+Xv4bjRRU5+m15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875587; c=relaxed/simple;
	bh=+jjYu1KPV2gY+aOmDkkFqJkHQcKgDotXU1Yp+JBmiJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmexI9U+74plsDFRinUfLtgFoH4JAQER11RCgPKAg01S10EMk5TflCyPHQ/dt7K0uI3VxYGAOLO7kKk3PE435zwcNPDY9l9S/Rtn7n//iIVce3yKoCU6kcpcdklE0rexL/vCg9BeeTwStrJNl/s+TR1gbMG+ItK/4x5bs+rG4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=th3orebV; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso2025141276.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 04:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706875585; x=1707480385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOcxIZqO4IqfJmSqGEdIgtFtjChFjymuVUxS/lQec88=;
        b=th3orebV9j9L30r/wQD/kRJ+T8uz97z/zLPh33nnqPdfGWzS1fym3CyxRNtrRKaARE
         ZWQ+9/WNECuwDiDAuEvMgD3azazFGUciDPgj1K3DYr8ar8BkJi+kAYv0zAOs2Cb8WO7h
         P1yVMfV0Fbs4LZyJlShqXMEbIbtIPHAGVADvA+Ynd5yKEwT+BPlbHsQ+HXNE6MxsVOxl
         ldznLMLRG8d+pASLOrQCWsJ3FBmB25eG1/Eu6hn6iehZxqobc3J8AekeYG999eAvN7sq
         jX+7dklzkN/GOxWTpm1AifYshnu6Rj9PASbuhkyga143F0YKGbp1n6E/L+CyWkX0T30B
         K8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875585; x=1707480385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOcxIZqO4IqfJmSqGEdIgtFtjChFjymuVUxS/lQec88=;
        b=jMzKY/zYqL454hMakd6FA7f3V20cdJ2lF5SqjCX/JuSU9tOgCWMK/UQX0KzNCw+JRI
         Fimrs3NCv2Fcei2CN46zxv4jrpHafTy1Xy1QyO1aMHR9nUq0wkYy38qyzlsrwQVzKkte
         ndK55tcOKogRVsTqj3blVfpYFr3HeEha9bfLGVloPIixRYmkZEDzrCo22HLJXz8KwY8h
         cPgo6QtcpcYMjfjt7V+vEyBE1T/vhC7FtIedVHDX5dBvZDFPGTnxuJjNJdimyYW35d3v
         hjkzdbnXFUn1pgm0mod2WOG78lNVTkXyiHJ7nV3o5Mof3U/gHqiyZcDuTJDdjzQaF2QY
         CQwA==
X-Gm-Message-State: AOJu0YxhZn9DE9/KDup/QLeiRaFfrSqQnBdOXeUpKNXeXE4mhCH/Pgdj
	iZPvhCV0nC9HOUGtxdDdSP7Jt0GW/WpSLP+03iaHcyB2qCX5E30XFjjU0RUgK2Jw+08t9JrccYc
	z8KPnWYmSL2m5DmuiR3047dOXyawlPuIv+al/
X-Google-Smtp-Source: AGHT+IHoWeN3jttcPjwh+OPSpjvodC6/9rP2EWpkqV7rIlLo6L3yt+/be0CLaH/oMoxdru8C9iqcyf1oeiLpRcBoEdw=
X-Received: by 2002:a25:b602:0:b0:dbe:9e31:35f6 with SMTP id
 r2-20020a25b602000000b00dbe9e3135f6mr7176994ybj.59.1706875585221; Fri, 02 Feb
 2024 04:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-6-jhs@mojatatu.com>
 <CALnP8ZYtVXHbnvESkZpcVwpJAVJWe9NP1EtPQOzTKD3WUnqO3g@mail.gmail.com>
In-Reply-To: <CALnP8ZYtVXHbnvESkZpcVwpJAVJWe9NP1EtPQOzTKD3WUnqO3g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 2 Feb 2024 07:06:14 -0500
Message-ID: <CAM0EoM=OMO8O_4ge2gmQ5kMDnr9kWOHxm-tWtrKqksFMA=E61A@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 05/15] net: sched: act_api: Add support for
 preallocated P4 action instances
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:07=E2=80=AFPM Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
>
> On Mon, Jan 22, 2024 at 02:47:51PM -0500, Jamal Hadi Salim wrote:
> > $ tc -j actions ls action myprog/send_nh | jq .
> >
> > [
> >   {
> >     "total acts": 1
> ...
> >         "not_in_hw": true
>
> For a moment I was like "hmm, this is going to get tricky. Some times
> space, sometimes _", but this is not introduced by this patch.

Yes, unfortunately that is baked in into the actions code in iproute2.
Would have been nice to say
"in h/w": false

cheers,
jamal
>
> Reviewd-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>

