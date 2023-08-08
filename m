Return-Path: <bpf+bounces-7269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354E5774D04
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 23:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC81C2100D
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEDA171DD;
	Tue,  8 Aug 2023 21:25:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE2E569
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 21:25:57 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9690
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 14:25:56 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bc9811558cso5102654a34.0
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691529956; x=1692134756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZdMVUIy7CoMr0jl//wKKkqgHFqN85zKy17qlq02oZI=;
        b=ttepeYR137ozRSfCx9dSRikZ14KF4yKqxIHFiRfIyqSbYlA0TkCEurIi3UHy4f0pZv
         t7yCNilX3DdI3iwQ/KWCfaW6hI00cJMplUj40j27emLAs+fU7qnntXCDENWxFAoC8d+A
         +IH7r82ZZu4VXlIW2UtZiEf81LpLLDJpKGvTNIJINoSP5OEVhRSRM+eaZ0OXmRdzCdUx
         ETtG+tH3TyikJmRr9zZcN7bJVd+nuSYM5dtpGst/xQ0gTmbN+9a83PWFLgS53foCP+c8
         mj3cvNEp152OfT4cCpPY7FxqHxeC5Ty1z69GCMWtb9wq5sGYgnkrjvDKpGaa2D6N/j0V
         1L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691529956; x=1692134756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZdMVUIy7CoMr0jl//wKKkqgHFqN85zKy17qlq02oZI=;
        b=kpPzx4BinWuTc4kXr/kLJHdVUPjlyIQJMngQ9fpJXXPDikj+XcXoDXtfrqnNEFFGwU
         7J0NGq7ytczEcdtgwQxBLxdOaE7G/ZowpbiQ4eDL/1ihewHZe9ZSj86VuZc81rcd/6pb
         Dk5S5J8NHhGZkMUjCPp8CIWehRqSzQLrbn9w2Cy6aqtDugev5meg21QwcSGdbIK6FcS/
         YYlmqxinevVWBHbgpk0l6D9LE7LzmTDIKxQfe7+i10s4RDsbZ2uQ9XYEEUG7Ps31H4gR
         2Kkg1swtgNjKXPtYtLXQwhsOuDF0op42xjaYZWe1Ysr5Hj03MjJR58Nx7Yy7M6nFMpGf
         h8cA==
X-Gm-Message-State: AOJu0YyICZylIgp9XJB3kyWLqg20hKD4lQFoBXbfgrV06agZypfJnYx8
	ur3DgdKEfRP+izFWO2QOdwHNDK4kWR92bK8DjUGvS7LswmzwRa0R
X-Google-Smtp-Source: AGHT+IEIMOk3jp3ssexrPXM0NGdY7AZpMJ8274d7SgaWz8eQRDqoAESq7fISvhhDYWR85E6WIUA1BoKelvkKuA1cOcs=
X-Received: by 2002:a05:6358:98a9:b0:134:c4dc:9e28 with SMTP id
 q41-20020a05635898a900b00134c4dc9e28mr584432rwa.17.1691529955942; Tue, 08 Aug
 2023 14:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230808052736.182587-1-hawkinsw@obs.cr> <20230808182444.GA1158877@maniforge>
In-Reply-To: <20230808182444.GA1158877@maniforge>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Tue, 8 Aug 2023 17:25:45 -0400
Message-ID: <CADx9qWjUFL-019oA9d-W78i2+Wt8MbO5HPMX-x=TJPu5kz1_Xw@mail.gmail.com>
Subject: Re: [Bpf] [PATCH] bpf, docs: Fix small typo and define semantics of
 sign extension
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 2:24=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
>
> On Tue, Aug 08, 2023 at 01:27:32AM -0400, Will Hawkins wrote:
>
> Hi Will,
>
> This looks great, thanks!
>
> Acked-by: David Vernet <void@manifault.com>
>
> > Add additional precision on the semantics of the sign extension
> > operations in eBPF. In addition, fix a very minor typo.
>
> Just for future reference so we can have consistent nomenclature:
>
> s/eBPF/BPF

Sent a v2 just to make it easier for maintainers to apply the patch. I
included your ack -- thank you for the review!
WIll

