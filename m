Return-Path: <bpf+bounces-51522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC53A3564A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 06:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C563AACF1
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 05:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426EA18A6C5;
	Fri, 14 Feb 2025 05:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV1h6rkn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE238DD8;
	Fri, 14 Feb 2025 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739511205; cv=none; b=qwB5JS8ywoJ5rDLo6oQOnxBzQjqPXihzv3E/xVren/ydjhdcpjGaKlF0OqZLZjxARzsz/6HSDZTRBpBsXayxvqy4ms5zRgur5E/FCu15cqs8sR3gdQrrgUk26Dfng0m8YVVFRIqOKC5WZ0m3RdPxZ4GfC02ouJIgC8WCr/YHRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739511205; c=relaxed/simple;
	bh=L5pk5X30gpJ7gnywIkkEXwpQTjt3ETXHwQhi5SLhsWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0NsNTmQEzDWxyZR2lVdZdvzzsI3nZ3acAiAdkYoV+YmCGnTVeK4pDFjxQRwZ0RenrIv5LwhNJhaaXm4tknvvL6uluifEfbVty1Js7pbDJqyuMe4xkul/sG8gS65Evb573rCRCB0X//qTw3KFnYQrLFHBUZSwtfaWES+fGU3VIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV1h6rkn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dcc6bfbccso909875f8f.0;
        Thu, 13 Feb 2025 21:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739511202; x=1740116002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZKSZtODxM+noN2/9IveqzmmDuQqERiRvMNYTlwLCo4=;
        b=UV1h6rknrFvTR+T/QoqHxgOk6Xdmhh+kf4GLBeXAPgK9fnbk798FbjEKHHcXHjEI/L
         KQKj3ADc+iQPHQJeB3aBgCh0inRhvTzXXHOkiMeuURy7saYwfM+wQ3mjliJAUSRGIIR+
         MI1SO+zxSOjN7HtoZCZnZ3HM/w8EyndqmV9TqZ0ATnyyVbeA1hbMibvGIUfq3zKclqGa
         CW/ON+4cSDlqZLxxeHoUKL202Do17UgpRdOnfJoaFmmbSEPxO/0p8GOq8vihFkwMAicw
         rg1vCjfFNyptBukwegCQ+m6j9ZqE6V6lZb0eBeGmD8Ogs6PEvSidFyfZNbDObE6p/O/E
         ZK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739511202; x=1740116002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZKSZtODxM+noN2/9IveqzmmDuQqERiRvMNYTlwLCo4=;
        b=OSZktYNAaxjNVvLo134Nc69dV3YCqrY5FOTGnHOSXyYMRMw7yYQpxuCjc9Mp8pSWYR
         sLxUQhy7lTYWy1PBPsOmrSAaaqT5i+2oUmvPExssxIquGDG++MRclaTuzy3n5ow2OV0+
         7sVz6ppMsyILWk3uNzV0/OmnKNP7qYGq2yrq4UB5/6t5MSoTn7AuGs9eygU/L+J4Dnb2
         +a9e4xrlK4aagLA/sHw3sJbh4y19JL8Yz3O1nFEhec96E5jU3L8Bz81X/2QzTS5HB1jN
         az2EfWEQBd29dM7nw6GnYzGFf3jU3eoWWcCM4AvjxEYZ1v3UhntE+60gJYApr0EJk59T
         nHqg==
X-Forwarded-Encrypted: i=1; AJvYcCUxL88bZ0LvRlTjeV5B1EeNZ4S677joDyw2ZnfuOSHcMOOUHxIG5ItLAtLqNRpr/dlGTaU=@vger.kernel.org, AJvYcCVB32lpA//pOYhMQEYuc23baCNdW2qcuMDuqhKe/ymgIW63onbHkb5blrhutuklGO+T3u0NAvRHn+tUdg==@vger.kernel.org, AJvYcCVxP9xD06WI5+Qpe4XcVMWZQfs3duKEXtBOkUdaFZywDeENkfxLX+WvF7f+rX4uztZTBXAMe/6a@vger.kernel.org, AJvYcCXyKmwErJ10/qwI7PKiKVgFqJqPbfVBwodGZMLAH6KNOCbIcR5XXGvLp3NsoQ80cmGKkD84m9hm+Fh4Vh/u@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpZvw06TxPQp7MkTp/Tq1CvCRbn0s7+RFusZpxt6k8XAk8fh8
	LJhzuln2gtY78ziJVAJ545tCxEGAP2+4QAKzXoUkf0X4B0XUDDSH1eDqqIiS63yCqFTbyl5xRfW
	lzZUKEuWak1IC81QeHBqLmrHMqh8=
X-Gm-Gg: ASbGncu/SnXZsSiMHBC/fLG69b9IrS6MhoKG1wBuBxoZ7Y8F69GDnod9YY6q/ffRTsX
	xrz7Xpojg68C7Mh8ovUI3mtEr6ZwDuPpeCJYXpe3s56SU7mQLOAZ1yWKn/am50wgITZ8qlilall
	VYTw6ic9S8GWYnuY6TJku7RfqyQlrc
X-Google-Smtp-Source: AGHT+IEF5LAqGZmkuhURa/S2hwHJ3FXPr8eM2F/6SJFL1O8hdpGxlppS11AKZcoalYHBSjqsDU4mE66s2+Zk1tcfVGI=
X-Received: by 2002:a5d:5226:0:b0:38d:b9c5:797f with SMTP id
 ffacd0b85a97d-38dea26e79bmr7916643f8f.18.1739511201973; Thu, 13 Feb 2025
 21:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214160714.4cd44261@canb.auug.org.au>
In-Reply-To: <20250214160714.4cd44261@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 21:33:11 -0800
X-Gm-Features: AWEUYZl4EytNCpTfs7QcXZ1uBLgvuERgrbd8OHm-WiZUZgkdL7qNGZkC194Ee4w
Message-ID: <CAADnVQJhh+An8uorGh-WQfJybqAu84MOREXZtCxep7fZtyMd6A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 9:07=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/btf.c
>
> between commit:
>
>   5da7e15fb5a1 ("net: Add rx_skb of kfree_skb to raw_tp_null_args[].")
>
> from the bpf tree and commit:
>
>   c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for headsup.

Jiri,
what should we do ?
I feel that moving c83e2d970bae into bpf tree would be the best ?

Pls warn me next time of conflicts.

