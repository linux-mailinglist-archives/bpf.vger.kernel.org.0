Return-Path: <bpf+bounces-64585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F6EB14647
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 04:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634D254200F
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 02:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF962212B2F;
	Tue, 29 Jul 2025 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVa21AuO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA31D618E;
	Tue, 29 Jul 2025 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756469; cv=none; b=ndvVxdT7dKs6EWHE+FRN3UoO7VSuiZb6OLepruHfKwsZYaT6pUyLUrffB6LlJgb/YhrKKTNS0umAJsQNLCfR+kYtQAobtREj3eWKiK+P80qdmn6sVnJjgCUUaE6GmqZc1zaMitt/5JBGBVkH8yluYQD/ergpId3TG4LyxuiPTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756469; c=relaxed/simple;
	bh=Vc7/jSBr2YAKmL3/MFoXVVDaZSRF8fN5wWv6+oIPiks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3UuBprWehbdaH3Qx8eiSkdaArH5yLsbd1jwqJ59p863/xOs05WEjx2CK0MviY5Uj/KrBOZgp1hOXQLKqsv/sViKdCbDnPKfwetkdpf3Ifq8YiR7wOBao6HvULI0K5SyNZb1xPtW4F0+a4aTpCiglBlDQJGtug6JyA0DeK0oUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVa21AuO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b786421e36so1375963f8f.3;
        Mon, 28 Jul 2025 19:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753756466; x=1754361266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc7/jSBr2YAKmL3/MFoXVVDaZSRF8fN5wWv6+oIPiks=;
        b=AVa21AuOzyc94LVlKjRlV66Z/E0vuet5/8VIr9C4Ax4Zn29hlk1QdZoQkRnWJ6xZdb
         gBOupFRW7JKaNxywEJM4w//ByK010SJs5sCUvlnQcGzPxDnmxyYT9lRJtXcTwu9+ymQc
         MXM+8bvc6yecV0T300w1ehd61EuwJ0O2M2ePKlFi5KyMismJddXOiLv98+cOLyHbV6Sd
         9CglBn5aMb2MVbIs2eD3cng2byb4gK0lsnT8nJNMnnWpERduFOHCTd70taBT9/WR5ttX
         ZfyS3uhQ4jApTfVmw9yJM/rruHyDJSj8YcVedi3MMM0dU+c78Ckk33ndBYfCWbMPb+sW
         SgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756466; x=1754361266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vc7/jSBr2YAKmL3/MFoXVVDaZSRF8fN5wWv6+oIPiks=;
        b=fLiWZar5+0N1p0J82E3DDSDtUWVGFd3oWenDg3N6c+A/poJjCp8X1Ri1GBM3KBEMPt
         xc6By48g6CHE/5lfFV74aUbqtCB+aiP7zytIHpMTCsLf8sKfzUIvODjYH/O1Gr+osp08
         LysuwQdF5qPQJpAX0+nBOFVEZuiZkvo96sjndjQXlbSpcV2Bp7StLSO7twN88XXtt+JM
         Bp3pB0FvXw32k/B4/9PwFOx9L2swa1fv+svoWN6+PgNB7uyM4ZaUx3rgumvj8o+VrfqY
         ptWxMzSAfOBOuyLR/upoHVwPIFeggoF3pIqxBZ1gH1jYOAzk8RX7fW7pgwQ7GINcM4kw
         GHbA==
X-Forwarded-Encrypted: i=1; AJvYcCUVL7RGpkUYynqwXrlTtuZ+We+VTLy4oq1n6mstuU47cMsb6thrd6ySCB23N+oS2epVhK2Mc1l4@vger.kernel.org, AJvYcCVraLdaAo6WeayY5RVdifVd6HCwW2x3sXffxC9jubBu5ha3GiDnFOMmua9ExXuqquLH38U=@vger.kernel.org, AJvYcCXRJM3cO3gxXNV/hvm3/mklm/UpoUnCMGKau72SRVMNHPEMdn76tm0a48dEy2rF8wh+CY7SLbFFWJuuBGU/@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlSbwLYLQZXxTtSn7bXtibzYnfB+gixGaXHEZwlUTaxOxYxl3
	5bA7cRnfKFhd1MuknSiCwAs5gpMdswJc7DFmHuoRPpJfT918QGqb9S3++vIHC33TtZ9cPvV8Lqs
	YDznC8FcI8wMWBMwjLGW83NVfVemm2cw=
X-Gm-Gg: ASbGncuQjI1vIu1kb3vHmFsU4lsZ14BrUDT5EFaaAftXY9LGRSMezSDxkyikbV/ktEK
	aslliRbgOJdGlx6A0cs5SVSi11wZ8SFeG5Jb3Qa8GPmY6q1N4qjfXms0Id37OmMZevFXRT9awNw
	ta8K0I53XcVXZgvA6b6JvwNDAVB7K9Enq14CNGcj1D+ajeR71le1mg7CHchM/mZrCsuW5LVY19V
	JGq1+Bgyly575LPkvtTHwLXJT/DcRIdF5RK
X-Google-Smtp-Source: AGHT+IFlmtFhzVv+Fp70qB+mZtZWjMEPLOSnkLeaFYVBwJWbNxAuQThOGeVyHmQ9DkjvEvy4Fve6z9tXyoHYkWvehW4=
X-Received: by 2002:a5d:5f90:0:b0:3b7:75dd:f373 with SMTP id
 ffacd0b85a97d-3b77671c767mr10608771f8f.5.1753756465779; Mon, 28 Jul 2025
 19:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144442.1427943-1-chen.dylane@linux.dev> <8e6cd484-43f6-410e-a580-3671642a7e65@linux.dev>
In-Reply-To: <8e6cd484-43f6-410e-a580-3671642a7e65@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Jul 2025 19:34:14 -0700
X-Gm-Features: Ac12FXw0Ilwtg9SXeVcdvKqQnD7OJyuvYkLWwnUMFR3uLFOInTr8tFgcAz3VCFY
Message-ID: <CAADnVQKTsNvWrt+e77sgnL4N7_tWMcKtOP7zTAkEwTeGrv8nCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpftool: Add bpf_token show
To: Tao Chen <chen.dylane@linux.dev>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 8:25=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/7/23 22:44, Tao Chen =E5=86=99=E9=81=93:
>
> Ping...

5 days in a queue is not a lot. Pls don't ping it again.
Especially during the merge window.

