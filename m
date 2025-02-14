Return-Path: <bpf+bounces-51534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F969A357DF
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 08:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530EB16BB4E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6120B1EC;
	Fri, 14 Feb 2025 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXKzKnlY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D48201271
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518039; cv=none; b=nsUTQaI5pwCeVNOdOQBA9YpIAwGF9Hm5FI/5Z79iKoaFK1J9SeyxE1PCtWJQuIRAI7AlmDrHyC/MXWi1Jyqf5gssYvD+2aRcfRIQ7IBiFLFUx858r+5Siy/0BtSeNzGjCRBJavaq37RF2WzL3h9xLaPB2T/V+DWIn+kl0Vl/cbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518039; c=relaxed/simple;
	bh=SH81qIbJDrlkjagBA41a2hZCyGGfrh+clfsJyxEcW/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzbUKd1dF4B4lwp5rAKZRu9k7Sst4RsXsL8rOGbbTGNxnoaqEOgboFCsMPOySC3mpI956R8VQj5AYZxcktJZMSpSG4s0XkFRIjKW8hCceDuNHyuFhHtKp2xRqG/hqF7IUZ3KZhnx/8W+d0gmFoYvJvUKCMvBJ4Wqcf77M0lpKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXKzKnlY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0155af484so243859185a.0
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 23:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739518036; x=1740122836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWwj3Mxryf8akwMI/GVLmkQvuAXly9Ta0z5CzcSt2g0=;
        b=AXKzKnlYxXbByEV1WgvdXegHjLecRArCDBPotfMljVCrgysiBNhGAZQ0pegMZ5mFto
         hXiyHa9vqERbYBlrmkFyVGvhf/AzKUIWSUIO3dVplU/JrLcq1D7P5VafI7zSxOJuv0Sq
         FQ0/DxnX5yiyFZEO9mz53hnhAurxtWpk0T+Z9XJUpZwhBywpb/yrE/e/2sEFpMajz0Gd
         gGWBo7oTxllkkOrefzxabIk8Q1C7J27ZidDoOm86kmtliX0RNHrc/CXj8vJBNdGI7Y7R
         pgORenIYV4vDhDcLkQC6oL3j2ubL5ap01pA+VSvSDULT1yQgD4Olb9J+uwVS3wQ8Qstc
         hgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518036; x=1740122836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWwj3Mxryf8akwMI/GVLmkQvuAXly9Ta0z5CzcSt2g0=;
        b=HPJp2FCzovWVSQdruc4YTs/YEJSGsPc+24HRYU3xfwzv64A/EBqP3YcHyOToxjrAMu
         611aPcloYvdawJieXkoM6F4eseFbODK12JR3sx3Je9YvtiZSdMlMDOTzq19+a66bO+Y7
         ckso69Z+iUzeItt6NNLGTcaya7HmYMXsNd5/pbMFXXZHjQrNenpB6ibLSCgLXxZaai6l
         zZmy86VCIO/tN+1rbjs16gphqw7kzi3B6LGjFjW+FEorBaW3KxJGtsw4m2QGenh4DDn9
         whnoJ9GejMi8iZolX29uBpFZVjPiF5RIrLtEi+k6irZ/p6MmxdTvHCnIEwW4LEOMXc5m
         Ck+g==
X-Forwarded-Encrypted: i=1; AJvYcCXKGNJ8ybzIPH1c8/nIfuF0pxFtbtmUVsmXSgZrnJc+oXn6w8f3nStAfyTY7RTO60k1/GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPJFUKY6dCRv2A2BpPvg4APXjlFIxSsqF3V1S+LRvG0CozV9y
	MMJqZRpqN9gr10+irWqAcHfapEix1NtlZH568n6TnjoUtezXoY0ztZ/cMu4bMSCM9uAt9hB1k/I
	9e8eqQ8KsQUfebQsv6w5Z3xneODI=
X-Gm-Gg: ASbGncumIZMVTpsnvE5L5KSjLRYM+Q+y25s4SU8xI1JWDN9mJ4MtgKARpFozVp1s7cp
	AKN8eOXw71WcOBQml1jiQyXlyw3y6AP4JibWDBolkCwPs9L6aAuX6hs++fx2ZYRKdtnDTiwKzKr
	M=
X-Google-Smtp-Source: AGHT+IEkY5SytniN5eZx8iG/bzkqwtRfmTGREmN/HC5xrxtMoAshBx77AP9OFi2GcHaf8Ocln6CDOWkYh+fT8f0Qas0=
X-Received: by 2002:a05:620a:4154:b0:7c0:5c74:57ba with SMTP id
 af79cd13be357-7c07a14e8d8mr909727385a.27.1739518036420; Thu, 13 Feb 2025
 23:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211023359.1570-1-laoar.shao@gmail.com> <20250211023359.1570-2-laoar.shao@gmail.com>
 <20250211155055.q2kequxtplzz47u4@jpoimboe>
In-Reply-To: <20250211155055.q2kequxtplzz47u4@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 14 Feb 2025 15:26:40 +0800
X-Gm-Features: AWEUYZkRX4Thv7WNzoBnhOLgAliEkSV0jzkVGIyLBqlpUzBm0YKiKjitx4SdN_s
Message-ID: <CALOAHbAjnR5Y-4SD-WUGk0KuYz6aBvEVEQLCv-W3gwfqG1CVyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common location
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, peterz@infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:50=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Tue, Feb 11, 2025 at 10:33:57AM +0800, Yafang Shao wrote:
> > It will used by bpf to reject attaching fexit prog to functions
> > annotated with __noreturn.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  {tools/objtool =3D> include/linux}/noreturns.h |  0
> >  tools/include/linux/noreturns.h              | 52 ++++++++++++++++++++
>
> Instead of moving the file, please make a copy

Are you suggesting we keep tools/objtool/noreturns.h as is and simply
copy it to include/linux/noreturns.h? In other words, the two files
would be tools/objtool/noreturns.h and include/linux/noreturns.h.

> and add it to
> tools/objtool/sync-check.sh.

Sure.

--=20
Regards
Yafang

