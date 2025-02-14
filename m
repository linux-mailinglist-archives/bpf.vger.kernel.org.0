Return-Path: <bpf+bounces-51543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60626A359ED
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 10:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BDF16A571
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 09:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBCC22D7BC;
	Fri, 14 Feb 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhbphSf2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51E22D7B4;
	Fri, 14 Feb 2025 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524378; cv=none; b=B97Ha0GHsRwCtnYZP+Djzpg6pKIOBfz5yZPpe8IR8v1uFggGE3EhePkSQRwlXqQyHExj/yC8MKh9UR8CkDAz+Hexke3vG2OepZBOArUPmNNGKQsvABB31zVeT48A64lPR55sLOKUxKYRtW+/qeTBFBEtkwa0bTjvBhN0LfZEQt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524378; c=relaxed/simple;
	bh=qtmYY6rJ/L1y7CZVoE8AYNaZ3Qhs1lC8X+DzaqDmp18=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i34879aEmWFZ/xt5V8u3XkUwccIXVJyAdyegMs/+T4K1iahtPfwMF9Fu67k9VBnIyF/RE8yHoCAwKh/8yAGFoJPJjw5vITI4pcLV9K9Pbqp5Nzb5I4YZecUEEcFTZpDbxSvtulektkxeReseHMza7P9x34cT8Rw7Quk4Qd2uGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhbphSf2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso346226266b.0;
        Fri, 14 Feb 2025 01:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739524375; x=1740129175; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zkkKVj4O4+T0jkOmwWR2y4c6c62qb3fa2Pp2VwxJ1Ig=;
        b=UhbphSf2rfP6cHn8Ivagat9WLA5QUM/NbOmA/YA/Hf7CmqyZ0jXhyeRJNLxGFwcr6j
         Fy4fAoLuJskSJZb7MXfiJ2cgFKp8btuKtWsN5qcv3NbgW+Fpa4haR5K/3Z2QL8fU0IDo
         NRSgfFNTky2L+NAuz8RIICkXcxqFUqIptzqxDtfIQrXMwfssZziPAV6AIxGKlZ3RUaxi
         a18cbSuencI/PAfzolM4nyIj/c3b5B1uOxdGKsUGQvk9kDPn15DZBj48uE3qzqZL6h9y
         EJzLIR9sa5HPAyIz3Ff2vuPWyuo6idqjqdwQqrzxSFKs4rh32MfamBx+Hp2LsyhRBgUh
         Yv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524375; x=1740129175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkkKVj4O4+T0jkOmwWR2y4c6c62qb3fa2Pp2VwxJ1Ig=;
        b=UxzYoFm+K1i7bmQHBCBTe56pc5uPF1/KYSvXfCoBEapaXQtFslsp6CCbInvEA/WkD3
         pbR6RsTTm7LrRcUsbMnHtdNymwvP72OdKLAj8I3o725u9De908XoqtOTSAQuK92k9JLC
         4gaQ3VGT8JGYGbQOUdD5mHHFTgwKehj1rTzVQKQKmsag4Zu4q/tFXdJLSKHF5wEqTBco
         YkY1jif8AXDAOvQStsfgOW+NefYmwbsjxqho5jk/GnS5BqAIwnJgy+9tZSMDlIyAuPu0
         F67WzQIVCnqUHjeFx76P64g9b3O5+fl5Ovj9fKFt+94kq5BZLan+EKjj5hH4NEiZKDAU
         f9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVPITdqUnYg5WUeiJ9Pssiwa1eLBGT4eADyIZkkaKC9WhYV0pRPjDHLLT7/4kFE+lsm6cc=@vger.kernel.org, AJvYcCW7AN2q36ZXpU8jlYySGJ1CUJ4Ar6kckS8H0RuEsRzTXh2wdwuTuKIEwVAZcPoXFbDysFvwFQ2JclzA8Q==@vger.kernel.org, AJvYcCWe7C+4Hu9tDtqwhQsiQWBiaoUb8vX7Oktza/MqoqcxMQ/DxURl9sszM39ONyWywYtkysiEttEe3UdeXuLU@vger.kernel.org, AJvYcCX1JEsPf6t2spFzcPOJfNPpZIpxZk+Xc8LDUSULpLi4XHjaXckWOFyix+vrbf81DsNNKJ7lT9cY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5eqGf8sF7TP4VYiSs4uXOC+Vrt6fvJyaOLrK5aPWHMLHq5CmU
	J55zhQ6Ea3tBuG3+zjHfESnghyKj2iy8PawBeTAWqc+j20DVvGu/
X-Gm-Gg: ASbGncvRzfM5roseS6/wQtZyjWhKHSazSnrSaLqkUfANt0vcrIK228gCgX/hrbQB5J2
	jVffpKF1qgctfH7QFC+Ja0T7uMvs6n0Lv07CxPEpH+ejgu/9ogFmyr/deir7qLoukONmRwcwNNZ
	Zeh/g1b3DQgaj4S9JNEayAk7GFVA6yn/8KY6HdOO53NNlA4+Lr6jQlGQSQWfnq++EOHDc88xmOm
	11X5ykiPeWmMf4OyNT0ZIa5ye9reT5F5wCfPDCEzltCsmF7RezhCHvD8lGIAqtivJk3s0At0dTP
	jg==
X-Google-Smtp-Source: AGHT+IFXjGI94UhM8i6zP3k1JVzmHTbwmz1b/CvAgRDWdtqvYsnfjXSrmNRpG++i+WUVHrnEYxUbOw==
X-Received: by 2002:a17:907:3f1f:b0:ab7:bba7:b758 with SMTP id a640c23a62f3a-aba510aedd3mr478012466b.20.1739524374494;
        Fri, 14 Feb 2025 01:12:54 -0800 (PST)
Received: from krava ([173.38.220.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337697fsm300528766b.105.2025.02.14.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 01:12:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 14 Feb 2025 10:12:50 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <Z68JEhkMs9rjgVHP@krava>
References: <20250214160714.4cd44261@canb.auug.org.au>
 <CAADnVQJhh+An8uorGh-WQfJybqAu84MOREXZtCxep7fZtyMd6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJhh+An8uorGh-WQfJybqAu84MOREXZtCxep7fZtyMd6A@mail.gmail.com>

On Thu, Feb 13, 2025 at 09:33:11PM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 13, 2025 at 9:07 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the bpf-next tree got a conflict in:
> >
> >   kernel/bpf/btf.c
> >
> > between commit:
> >
> >   5da7e15fb5a1 ("net: Add rx_skb of kfree_skb to raw_tp_null_args[].")
> >
> > from the bpf tree and commit:
> >
> >   c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
> >
> > from the bpf-next tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Thanks for headsup.
> 
> Jiri,
> what should we do ?
> I feel that moving c83e2d970bae into bpf tree would be the best ?

right, bpf tree would have been better fit for that.. should I resend that for bpf tree?

> 
> Pls warn me next time of conflicts.

will do

jirka

