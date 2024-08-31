Return-Path: <bpf+bounces-38665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06D896713D
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 13:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1922B22823
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 11:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3FD17D378;
	Sat, 31 Aug 2024 11:26:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D9A33EA;
	Sat, 31 Aug 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725103601; cv=none; b=N7Fm3Dv5lRSWD7dT1rXj9ihlqr9qeF0Mq4pV322sW+NEWQLcwT/tsDksZH9XjKjtqwSiiukN7Cj6xUesi7IGMGVBAawrSceKjRpGonVUef+an5d7DfpifJ9FB78/rfmkHv23zCvBIzPQEJfloPAvnuBt5Xpzk0ODvfBenMhEBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725103601; c=relaxed/simple;
	bh=ZvbGp0mAKFAUDmcihLLlDp0OuZrzBX+nmwBkND+95xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQLbVOYI0GUA1in2RwGdrcRugw3XPlqZi+41I2TK3ZhroBciEkF8mGUo/dF1i6hUXPKmjGyVqJLbJqWFF/2eMOW8ihG+opROrEce0Q2K0YfpzXo5S7hLGtrVhPS/FNddjCBrfCi2by4et0yrjUcuyzuayiqtCkzeHjre8modQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bb9d719d4so16089405e9.3;
        Sat, 31 Aug 2024 04:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725103597; x=1725708397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvbGp0mAKFAUDmcihLLlDp0OuZrzBX+nmwBkND+95xE=;
        b=jbldVREBC1YooSkH250v1GgzxXbNMPbXAye/wGmwI09d91YZu9iJhGDM7IFk1NvLAl
         j+d2UAB5yP3PHxLv5wHSlcX82t3g52bEpjypQaXsrDjeAzUMLcgHr5TqoJ1k5rQpQqMy
         7ZtQDYnkOex/7ySAcNwmz1fVHoOChFrumucbBmbSKGq/FxnfecXE15er9TpFD7d3aN2x
         VIYJiN3QoSjrS77JTu08oPPiexu0VsnGMwEkmX9Mxx8Xz4Jq+2qv1DZTKY22CIHqsLHt
         zzCkZMXY+ylrDB7DCP6Dw7JiHqTsmFslZx5rFinU+ANyn4GvDPKYL1EjeJj5mSvy89mD
         dQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWULp5kPr9EXduoAmjqDHC7MGniyAEf7M24mxU+rDACTHk2Lq7mMxkPqGTOFz886pQq8t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/RCXcvPy1dLmefUXM9cR3trOPy1BM97iXi6JielQYn/nIK51
	vljXHvN9Bdt6Jw0wNW6gB1DZIEyal5K3dOwftcB+MPB5z6ejXohdjNx+/wq4
X-Google-Smtp-Source: AGHT+IHjIV0wNFzBDkSzTEmFFC73pt6/3eZBEe0W3ElSXi4eWK0Z4NvLr/P1WhaQ2fEt9aRZk1om5A==
X-Received: by 2002:adf:e642:0:b0:367:9614:fb99 with SMTP id ffacd0b85a97d-3749b526f8bmr6304669f8f.10.1725103596789;
        Sat, 31 Aug 2024 04:26:36 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccff17sm2870399a12.73.2024.08.31.04.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 04:26:36 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso2502349a12.2;
        Sat, 31 Aug 2024 04:26:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEOKapEkXfkGdGx7gZLaxQwmnrqEIrkH+QdIrRASyyp6W/u68eQBAiEBprgMoHR91npV8=@vger.kernel.org
X-Received: by 2002:a05:6402:2714:b0:5a3:a4d7:caf5 with SMTP id
 4fb4d7f45d1cf-5c21eda33d9mr6746821a12.36.1725103596088; Sat, 31 Aug 2024
 04:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEg-Je8=t_cXKsWL0XSx3vF1gsArSWpychfbEf+yjM6wVz3Mjw@mail.gmail.com>
 <CAM22NNBrXSUbrpFAKv8jrREKTBYx_aW0cibtDE5AZ_kTijUrPA@mail.gmail.com> <CAEg-Je_9r_96j-un6TS7Dm_kJ3m7Q6y_RDEs9NTvxjNJM-zEvQ@mail.gmail.com>
In-Reply-To: <CAEg-Je_9r_96j-un6TS7Dm_kJ3m7Q6y_RDEs9NTvxjNJM-zEvQ@mail.gmail.com>
From: Neal Gompa <ngompa@fedoraproject.org>
Date: Sat, 31 Aug 2024 07:25:59 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-yfKSvHVnyJDmD9fprKX2kw9icKcG0SipGTUvjivwL9g@mail.gmail.com>
Message-ID: <CAEg-Je-yfKSvHVnyJDmD9fprKX2kw9icKcG0SipGTUvjivwL9g@mail.gmail.com>
Subject: Re: Weird failure with bpftool when building 6.11-rc4 with clang+rust+lto
To: Matthew Maurer <matthew.r.maurer@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, 
	"Justin M. Forbes" <jforbes@fedoraproject.org>, Davide Cavalca <dcavalca@fedoraproject.org>, 
	Janne Grunau <jannau@fedoraproject.org>, Hector Martin <marcan@fedoraproject.org>, 
	Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 5:45=E2=80=AFPM Neal Gompa <ngompa@fedoraproject.or=
g> wrote:
>
> Hey Matthew,
>
> The current thinking is that maybe the culprit is dwarves. We've
> backported a fix in Fedora that may help, I'm waiting to find out if
> it does. Apparently all test runs with Clang+LTO are broken right now
> with dwarves 1.27, so it wasn't just unique to my merge request.
>

Well, that didn't work. The backported fix doesn't seem to have
resolved the problem. I'm at a loss now.



--=20
Neal Gompa (FAS: ngompa)

