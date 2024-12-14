Return-Path: <bpf+bounces-46971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B49F1B6F
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4298E16B16D
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCA4BE4A;
	Sat, 14 Dec 2024 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HslHEneO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FD3D26D;
	Sat, 14 Dec 2024 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137180; cv=none; b=pRR605Bd7ZvW1kp/vo4z5dggLRBAF/R+VduH/dkWMSdUKwfcPagMGFFKDADepAjB6K14OkbLtcJBgF3g4EGXUrGX9S1ctRPVbznQ9FAXT7h+Dm9KbCDHQbVqUVfldadTe59DmKAAwy5xZIrZtQXpyNd0wkESguRVOFIYIE6HnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137180; c=relaxed/simple;
	bh=g4e2q/khgPGV0VuEz73HRbKXN9dEY9KUu6Imbj9y1Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hL4S4ce+TmZKGBJZqjKNdl5BIkx200YhFqYUyzzNQ6z1dVZHCQHn7NFxRFGn6K+x4FXhn5UUWkr+0jcgURrj0fHG7KVHzF7qYFn0RIVWYUG00SUQUEPRI1V7v/XxsZesMXm4+q2wsEwH+ru7hY2KREeDxvpN/MsalpLrNr0/ZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HslHEneO; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844e7409f8aso54108239f.1;
        Fri, 13 Dec 2024 16:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734137178; x=1734741978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBHyxTe88+/bwuXMWfP9oSNa7kt4nMReWOD70EhhFdY=;
        b=HslHEneOpVuPZ910E4KoIeqoI85EY/oVHuwGgF1GXG3GrLKZ+6GzcJqSZ6tLsyw6P1
         PO09bqhTg6bUZAA/o/5hiDqjT1L5o2SC3ZPLChoJnS4+X0PbSaHBnZtruzpqIVhwdQ7r
         xGueK1J+9IaGw56Ftm557FiA1MtwzIsyX39lef2pXAw5oOwNLiUnjIj68iDKDfqhQu76
         p2a7C2Mc3mzfIZEFmX+CWfqq9uJZ575LDLc+BACKB84QIgB5BB5xQwYIMSZNd+NYenZf
         ZKPtmh/nR8tXD4R7D3i16bo/OXv+MypTgjJwFi6CFi5F7dANZR1AMYIGEeiPmfXyCRdP
         ss0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137178; x=1734741978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBHyxTe88+/bwuXMWfP9oSNa7kt4nMReWOD70EhhFdY=;
        b=hIO6xWQgSPkmRmVLn1KW2ltXwLpCWXjiF85zp0TZaATKXbBtnPX6eNlYsgtSsudyPJ
         7p2U7s6fxUpVb84JpO9Nte+v+7R5nHq+m5pVCNzXYD+q52oHL4gvPdU7sZ6Ib38IDbM2
         8Z9wafLGEyuYWnxO9ZlFTSowUCRlsk+HIxI0RxqtENw7jkjVn+v8Tk5krJK0DXlYwnRu
         Z66tWfWHjysmI+XvDxvWPYIF6VfZUOsvGSyPNYqah37jUbe2xh2+XVjfOMlmyL287ILq
         yLrc7EB3qFCGWuc+LHxuBl5MN3SXX0DE39snMlsKEV15DpSnbv361Gh7ecZmiqln/kr3
         eSoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn5+c5Nt00JkdldK42a0FhUxXI/67hUWNmKvS7j8xpJDETNxF4QPOm9GIGw3L48Gv9AdayThjb@vger.kernel.org, AJvYcCXB+kX1qylNo7kGq6LrfuL+xJU8xgDD0vwjuyynbf4HsUMKpsNKPZNbfqUo2ei69kMPopA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqqR+b3kmlrFKet5IXcGL68oB1ShP+DlLf53v0ECzKECTIJNg
	dZXbIC7i3pONuKJ5baY533IcwEbtI4J36v0ltY7+HqNDukthzaE+XxqEPHXvEwhlHaxM6Dwdutq
	JxV6AbOHzrFam9fTidAOvfmHiAJU=
X-Gm-Gg: ASbGncvw57WokB4L3lLpEhRGBfNPol1bKHcawdixcUOVzz+YXEs+uCp9NEfg3wiiBBI
	ZWmvdc6e2mfq98927pvh+hoylHvFw7rpsqO4L
X-Google-Smtp-Source: AGHT+IEW7k3rYi10wyCkMojBmq4gUk3ffU3yzftxloXpsVuRupqkfe1o9IQ4KJiRBArUDABxLWvWojvOOBOUj15RdJM=
X-Received: by 2002:a05:6e02:12c5:b0:3ab:8db6:12ac with SMTP id
 e9e14a558f8ab-3aff4616e30mr50649955ab.4.1734137177992; Fri, 13 Dec 2024
 16:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-12-kerneljasonxing@gmail.com> <65a83b0e-5547-408a-a081-083ffd9d1c91@linux.dev>
 <CAL+tcoDALG5pEXEvhrN4e3AWTi8xO-qOt5nLty55hsDiBaRPrA@mail.gmail.com> <14464b87-aaf4-4879-89ae-2006c1024fab@linux.dev>
In-Reply-To: <14464b87-aaf4-4879-89ae-2006c1024fab@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 14 Dec 2024 08:45:41 +0800
Message-ID: <CAL+tcoDW744G+V1zGSThAT6h1gSeBAV5MdEZOBeXE+8xAPovVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 11/11] bpf: add simple bpf tests in the tx
 path for so_timstamping feature
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 8:14=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/13/24 8:02 AM, Jason Xing wrote:
> >>> +static u64 delay_tolerance_nsec =3D 5000000;
> >>
> >> If I count right, 5ms may not a lot for the bpf CI and the test could =
become
> >> flaky. Probably good enough to ensure the delay is larger than the pre=
vious one.
> >
> > You're right, initially I set 2ms which make the test flaky. How about
> > 20ms? We cannot ensure each delta (calculated between two tx points)
> > is larger than the previous one.
>
> or I was thinking the delay is always measured from sendmsg_ns.
>
> Regardless, whatever way the delay of a tx point is measured from (always=
 from
> sendmsg_ns or from the previous tx point), it can also just check the mea=
sured
> delay is +ve or something like that instead of having a hard coded maximu=
m delay
> here.

That makes things simpler. Got it.

>
> The following "struct delay_info" may not be the best. Feel free to adjus=
t.

Okay.

>
> >> struct delay_info {
> >>          u64 sendmsg_ns;
> >>          u32 sched_delay;  /* SCHED_OPT_CB - sendmsg_ns */
> >>          u32 sw_snd_delay;
> >>          u32 ack_delay;
> >> };
>

