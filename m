Return-Path: <bpf+bounces-17345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F73080BD51
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 22:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4956A1F20FA8
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3FF1CF86;
	Sun, 10 Dec 2023 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ5dhQuX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4502ADB
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 13:14:04 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso3183160a12.3
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 13:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702242844; x=1702847644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GXDK4NPT8AOsFRt9zx3A0m9grq81nXyLEQqGa/oegKE=;
        b=bZ5dhQuXRR+digaV+B9Iu76aL1+rxing1HCRrUfV5dQEseD2SvLUWT6KYl9K6cJs6r
         bYggg5gu2BR3Kl8d6RV8tHUF8sqBYn0t2Af7jLy4Po1j1uLdak8sPASUNREKM59gGAgY
         LVG97sP9vQWWEX70/LVCrwF6Z/f8jzsjSFTagKudUdmgIsxPM4sHYu3P3YVpYnuIWo+8
         DtLpkA7G1hg/mz1Q1pm8yuh/6BTtRTvSVhFn8JZukeM4TasXSDANFeOSyzc0NwT6j27c
         7SulHrS2DrnZXKvq2cq1P/2YFGD3PGH8o7d0Goj7vSuonXS28QGHyAHvZiZUr+qmc194
         HykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702242844; x=1702847644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXDK4NPT8AOsFRt9zx3A0m9grq81nXyLEQqGa/oegKE=;
        b=BlBEGo1Ch2o4IGsCg1Jw6xXI24PWwBh+VZPdTisUa9vp+DfrmzXbII/5iS5AU1LAU2
         I/9TtqLXMPEBLXSDIqI9z1Q1eqNPxnlm1SzGRvWjGws/6xpih/4fWfGAKyliScUw6kyA
         5+/PTMS6cldl+JCh0CthWCoRyoHCzFVk/HlLmKyezXj7I5ixmJSY6cd2iakDgAU4bYKx
         GTqvMFW+KFVmjxOU/1KMx4gtNw/CTtDCeCJRYlPNtJALE51EgJuIMeevGtlJQpKNa+CT
         RVQc7IEqxRy8hmrKn3hIl7Lk0V78xzlNzrQCrNcJyCANuiJ7H+B9MdmXTsETwHDQrp+o
         O4Pg==
X-Gm-Message-State: AOJu0YwkMTY+qCq0SSiNLOMx+PORjplsqn4nLZv2ph/5lNR7MEpNuRdV
	X2zR2PTmAIjfp6XVNzfPkCj3ZA0UrbmuXF+ug2g=
X-Google-Smtp-Source: AGHT+IGcVi6zf4BkMmnx+BqLx9B6ugGY02+UOdr+AAS259vMUzp3EZhrExK7RFTfcMOmGIm7sBv5mnGewuTZDJ/u36U=
X-Received: by 2002:a05:6a20:3d93:b0:190:5faf:ea71 with SMTP id
 s19-20020a056a203d9300b001905fafea71mr4604576pzi.49.1702242843686; Sun, 10
 Dec 2023 13:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127201817.GB5421@maniforge> <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge> <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Sun, 10 Dec 2023 13:13:52 -0800
Message-ID: <CACsn0c=+H57dx4C17VNkzJaUF2cYeW33Vgq+72uPv60jZ4O8Hw@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA conformance groups
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Vernet <void@manifault.com>, 
	Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>, 
	Christoph Hellwig <hch@infradead.org>, bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> Hence my point: legacy and the rest (as of cpu=v4) are the only two categories
> we should have in _this_ version of the standard.
> Rest assured we will add new insn in the coming months.
> I suggest we figure out conformance groups for future insns at that time.
> That would be the time to argue and actually extract value out of discussion.
> Retroactive bike shedding is a bike shedding and nothing else.

If some existing implementations aren't supporting some of these
instructions don't we need a way to make a profile that says that so
that tools can know what they have to generate for things to work?
That to my mind is the reason we would define the profiles.

Sincerely,
Watson
>
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf



-- 
Astra mortemque praestare gradatim

