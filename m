Return-Path: <bpf+bounces-9808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113DC79DBC3
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3AD1C20E09
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CB4BA50;
	Tue, 12 Sep 2023 22:19:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8AC33D2;
	Tue, 12 Sep 2023 22:18:59 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54710E6;
	Tue, 12 Sep 2023 15:18:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502984f5018so8729853e87.3;
        Tue, 12 Sep 2023 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694557137; x=1695161937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XSY8ZMt40+LfWzUvU2F+1fAOyiq6EBAamykygoHnjQ=;
        b=rcK8J8PIHb7ji+/LF7w1U/jh3Y32JJnPN/K8veS9DSVhctseIpGWfbbbSAJ08sVf3/
         ExbEUxRT1vtxQQYRgwxhIXkwnkJPwoL7PUOBXFDWTcgiZR6fH8gIiFlFMo/d6qUSF2tU
         ETo0Dzh9NreRfbl9ART4FXNyUZsPDhxFFRNIqRrwVX0pf3MYvUGK2W8DXIrMiYCmKUug
         hr4estHz/N84FYmWEU7fwgTN8SeIYl0Cp6zgFsWd9cN3kGbdcrzTxbP725uiQl7z2zbv
         vOEhjcfdGa7CtqTnbKFr8HBXCW/DTRKWy/WKjYRenHxf8BrRXXCp8IGhwzlEIgHsbssa
         K9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694557137; x=1695161937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XSY8ZMt40+LfWzUvU2F+1fAOyiq6EBAamykygoHnjQ=;
        b=giLIyX5JSLbcsf6wmkFbrIQS+UAK/inezG7/OFUQmZeDf80efECz+XdDNJ/UIELGTt
         3q03Pb/5m8tSd+VZH1WfSIgb9MuUfcjXtlQBsoU3jNyPmdFLbKYRp2H9YS07bmpoeUCg
         7C3VytDZUbNluGUboW3j/mIHA65CHvCq8qzDO1IElYPnic/nrYAu9XTVsv+4LSYCwaaK
         YdfAh4d2CLRFyurX/CIUd0O4pO41Xy+FEIo301y1vmEgctjp3U0nL7mKYf2+T7Fwd3Bl
         gDuDFeSKb30jinNNr+INooe2enbyZuwRKLy45kuDQ/ZZ/DkAegABMiaM+maK2I3atMED
         ui7Q==
X-Gm-Message-State: AOJu0Yy4oslnq7QxtRU6sqJR/zA3WnFsEJ8HoxdvTxeWXFoU16hbTyQ0
	AFkWZFIvk+HuqPpaRD0fIwYy1y55HkQ3x2I0dAY=
X-Google-Smtp-Source: AGHT+IH1ATRVlWCPJEbWfjoxrwhYstSSqOtzKcPTYAXwwZZfbXGmszyoYb7akXifhfGbtQQ0MBQI3SlhNi2A2Y172i4=
X-Received: by 2002:a05:6512:1091:b0:4ff:95c:e158 with SMTP id
 j17-20020a056512109100b004ff095ce158mr631125lfg.64.1694557136519; Tue, 12 Sep
 2023 15:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913081050.5e0862bd@canb.auug.org.au>
In-Reply-To: <20230913081050.5e0862bd@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Sep 2023 15:18:45 -0700
Message-ID: <CAADnVQKt_oCgJpVv+jqi5yhO4XUb2RWzajNSsNWk4fJWD4cJ7A@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the bpf tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 3:10=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Commit
>
>   3903802bb99a ("libbpf: Add basic BTF sanity validation")
>
> is missing a Signed-off-by from its committer.

Hmm. It's pretty difficult to fix.
We'd need to force push a bunch of commits and add a ton of
unnecessary SOBs to commits after that one.
Can you make a note of it somehow?

