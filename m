Return-Path: <bpf+bounces-16498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37B801C7C
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 13:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7B21F21169
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 12:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D28516434;
	Sat,  2 Dec 2023 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJSxB+6h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F9A123
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 04:00:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00d5b0ec44so432501566b.0
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 04:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701518438; x=1702123238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9DiFZj3v9xLYHP3w0wBrV0Lfs4wqpYH+DVaRtddtD8=;
        b=RJSxB+6hHoV9ctvBw3WZhqb4GYef5kWEuRAG76GJD81PmcGtEUUnoaGPYeP8JyYpeu
         pt+K8ajQXz7xbCUYqGJ+3GxEZKiqanDZ3BK3gGhQq0pVPUrudt2rFSar+zMrCCwm2ZIk
         je+rivTXExV+xc+yMPr20+bWLxrgsK7Ad4GA2Y4rddfk428b2r8nScTOyVbq0VthcEN+
         P/a4zS173QOFDs5huPgDIpUKwVRQntJ++1N7y6Nmz9EUuimfZd6rUajXU+mx4/065JjV
         nE84nFTCNimHermteH7Wl65OLlSTBc33wxgPwdNEu1Zkg66upW2H3Vm6zxZubgf5F5tC
         yDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701518438; x=1702123238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9DiFZj3v9xLYHP3w0wBrV0Lfs4wqpYH+DVaRtddtD8=;
        b=YNROdGzeRwGraFSq9eQSvtwfSvGUdRdIi6JiE/wCI1Wt8l4Caw2oJWCntUjYC80/ZA
         jNdas8uFV5R9wYZ9qUHAnkCxNAGYl7Hau76rhb4HwVIjcJ4m4+9OUMk4ZJdz56TsB2i4
         D2DASZjt3a0+nieZNWvjX/q1PTodVt7jK54yR682ccvYpKzpH3SoGfiMU/6GSUq7Mr0O
         NrHaXe99fqHcsewAlYPeoZ4y7o67EcF/qO5LFfqjFRLnXc9sYcEuAyKo7mqe2/bIysy6
         rZcuoD0ye9LyzFUPbPrsmm84PjxH/q+KU6sA8lBsIEAJH+MBfIwtA+mFf8rrf8L5rMuM
         uHxw==
X-Gm-Message-State: AOJu0YypDrhDKOB0jOVD4kO0sHJ7IrhZNe40h+7ilKe0OhcQQb9n21+F
	7OylUyYpDPj9cX/s58YULFk=
X-Google-Smtp-Source: AGHT+IGS6/+pAfM8kb4c2+Nz57Oxez6r5u1MAxOldrQEQn30FbJb+371M6y3m/rmCbdGh+g+qQkF/w==
X-Received: by 2002:a17:906:e95:b0:a19:a19b:422e with SMTP id p21-20020a1709060e9500b00a19a19b422emr1111397ejf.153.1701518438328;
        Sat, 02 Dec 2023 04:00:38 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id bs5-20020a170906d1c500b00a0bf09c9483sm2993421ejb.35.2023.12.02.04.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 04:00:38 -0800 (PST)
Date: Sat, 2 Dec 2023 12:56:59 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	dan.carpenter@linaro.org, olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v5 0/4] Relax tracing prog recursive attach rules
Message-ID: <20231202115659.7ml2m2ibdh6q74fv@erthalion.local>
References: <20231201154734.8545-1-9erthalion6@gmail.com>
 <CAPhsuW7_DQ5ttrT9AmcXO2__MN+Tman-mgbrJ=TG11r0SfPH-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7_DQ5ttrT9AmcXO2__MN+Tman-mgbrJ=TG11r0SfPH-w@mail.gmail.com>

> On Fri, Dec 01, 2023 at 04:01:10PM -0800, Song Liu wrote:
> It appears this set breaks test_progs/trace_ext:
>
> https://github.com/kernel-patches/bpf/actions/runs/7062243664/job/19225827450

Yeah, my bad. There was an issue in the original patch, the attach depth
check was applied not only to "fentry->fentry" chains, but also to
"fentry->extension". Reducing nesting level to one revealed the problem.
I'm going to modify the attach function to maintain attach_depth only
for fentry progs, this will resolve the problem. Thanks!

