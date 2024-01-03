Return-Path: <bpf+bounces-18890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D2A823545
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54654B235FA
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A631CA94;
	Wed,  3 Jan 2024 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgiNNeKI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6B1CA87
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-554909ac877so8845372a12.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 11:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704308569; x=1704913369; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C7TLMCK1LZY6Ww1bOpl/u1Mp9G1NE7l0W8HblNPZf/o=;
        b=CgiNNeKI2QRBFzCoBOD1GJTZjFlkauc9ugxdbQy9zfy1hFPqnmT4Mn6QXM9+m4Bzv/
         UMlNungBIWEfj4gtrBG7qTdWbS3OlB9uSQZkWtpg1c5FKm9kLpHRL8MI30P4v4vl3qKF
         yJp+tik+llMb/3QAWoI4kkym2dFjtrjU1Tfh0CDz3l4k/+8hNBebNWIGu3wmVzgmFWPj
         PsGRLNy/yORtP43qYG00BbeW/tWyhkmozTggWwMqj7b/YjV/26VmuhlRz+gGLCFIGQ8O
         mjhov5WN4PBjoLG7VBMn7ZqarCebhon3e9ZhvaWtwW4AmDhhypcKLnZo8edjOfsffiS1
         QJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308569; x=1704913369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7TLMCK1LZY6Ww1bOpl/u1Mp9G1NE7l0W8HblNPZf/o=;
        b=N65dOb25shvANbA8BDS2eBulBnRYWfG4UenxXQDGbVygsmixzlRFMgUWd/sXAFudm3
         Szv9dRiJvMMdPDlnIVO29uCVetOuzzQGO1HpjXTK3R1MV/7nZ0yVd089BiQ9eZiESmjL
         vdP+CSbKwkAJ1gxkyijniWeIcy2Offg5ODCzRCftI3UDy6qG5sSVhWgMf+alWZ0ywFE6
         j6XSqSfE/YEqWpI0Uma1UwEQjgu6i1VBCJkwAJ1EmDJ9WEYyzfw1U9u/WpYGW1NvzQ/E
         Q9w0Q0K9EhDKyB3wi3/3HFkF9TmMHSG5fuhqhGhg1EizeVso3yhJS5WCWBuEkDC+kcMt
         fTjg==
X-Gm-Message-State: AOJu0YwhX1Ty01vqTb3tkqA+C7QLgIxDWqazO8FF0fg9Jxsy5/4xEwjf
	rrO48FbHducScpmemdtMb5Y=
X-Google-Smtp-Source: AGHT+IFlOxlkWjq2LBJ30hMyqJcNM9eIdWO1AfA6Usi6rsQRl5sbnaa0/cl444sOgBka4Eg2sNTiMQ==
X-Received: by 2002:a50:fa95:0:b0:553:4ec4:6980 with SMTP id w21-20020a50fa95000000b005534ec46980mr11479708edr.80.1704308568701;
        Wed, 03 Jan 2024 11:02:48 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id fd23-20020a056402389700b00553a86b7821sm17694675edb.74.2024.01.03.11.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:02:48 -0800 (PST)
Date: Wed, 3 Jan 2024 20:02:39 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v11 2/4] selftests/bpf: Add test for recursive
 attachment of tracing progs
Message-ID: <20240103190239.b6wik6yukqek2ckc@erthalion.local>
References: <20231222151153.31291-1-9erthalion6@gmail.com>
 <20231222151153.31291-3-9erthalion6@gmail.com>
 <CAPhsuW4Kh1oLZX4gUOKc-SJqma2Ougjw7TPaEnS0t=UKi-Lx4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4Kh1oLZX4gUOKc-SJqma2Ougjw7TPaEnS0t=UKi-Lx4Q@mail.gmail.com>

> On Tue, Jan 02, 2024 at 12:17:48PM -0800, Song Liu wrote:
> On Fri, Dec 22, 2023 at 7:12 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > Verify the fact that only one fentry prog could be attached to another
> > fentry, building up an attachment chain of limited size. Use existing
> > bpf_testmod as a start of the chain.
> >
> > Acked-by: Jiri Olsa <olsajiri@gmail.com>
> > Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
>
> Acked-by: Song Liu <song@kernel.org>
>
> With a few nits below.
>
> [...]

Makes sense, will apply these suggestions in a moment, thanks.

