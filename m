Return-Path: <bpf+bounces-3811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BE7440D4
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6305F2811D5
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7454D171C0;
	Fri, 30 Jun 2023 17:06:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF78171A4
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 17:06:45 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2910D35A5
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:06:33 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40345bf4875so14631cf.0
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688144792; x=1690736792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVASgTbCR4LtAtuJDvbzQqcVGfEYiy6r88JHy3o1xnM=;
        b=sRPUrGc9oB3Ibx7b/YzR9zN1h4GcsCtdB2wPN9i2xCzo+C72hWz7E+S79AFvhELUXK
         WT5lbrV1eH7BnRBwtfu4x4nJqK8FXOGykFCm62qvLNqfcM0IX3tT0ottt4U9mJS0ujXG
         ok3WBjbbowT3gqGBb5uyVDA7jzQEOezX8AQ5feg+/c6kOz1ZcFJS4wT7zPYaPogOWRS4
         wkgW6D7yqK7Dcztm/cEkDOHB5nzTQnQOFZdAE4DxBGn8KpY+g32ARYs+IabA4YVIPMUb
         xksSUOtEBJY38SV1cV938+lQnctdlcTd3W4pvDateJ6xEwnTv9exq5ebBdWU1QdP8wNy
         hs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144792; x=1690736792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVASgTbCR4LtAtuJDvbzQqcVGfEYiy6r88JHy3o1xnM=;
        b=B6zYBTFTUPL/ScD5EBZpyzwtR1DwNNCk3bDjvYxKcXbdSmknAl3dLJHPT2hbuk2lKZ
         gr0kwrLc8f412cmUtJKFB3bvSLmKeJvC9Unx54wBaovvry5uKKc/H54zMYlY5NTOqvLm
         s3esO45StNjO2N1A9kMJMABYaBJ5Y/JAVIp9LIJ7mPOLZz4c/1mr1seNmjHD399tJr68
         FYD/PHoy6tOXb4RIFRqzGW8ZVfllGJvRniIZat1yVEKdeUxXxTwa620F1l1UPuzGWmlj
         mh1iz/LC00uomWTLN+Ug0DmqXsOhbihBwKnpIX8PBq6TYZFjbneWmNe+wN8Z8rngym4Y
         bcog==
X-Gm-Message-State: AC+VfDy3Kes4fAIDBrFqBdpFxyvA3W3TudReAfk3AUDuhlZcyTLBcOV2
	Dz76qEM/lMgj6citonHFiMF1gm+o5qzNGPa3j/qiVQ==
X-Google-Smtp-Source: ACHHUZ5cxfnrUBwwr53QuYLI3sStCvIc1DXzuyCXs6zKME22fD1QxLFlksDAe2Lqzr/0juxAp5RWE8ZplNuk+Qp80UI=
X-Received: by 2002:ac8:5b46:0:b0:3f7:ffc8:2f6f with SMTP id
 n6-20020ac85b46000000b003f7ffc82f6fmr1044117qtw.28.1688144792039; Fri, 30 Jun
 2023 10:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627181030.95608-14-irogers@google.com> <ea39aaf0-0314-1780-c1cd-7c3661fa3e7c@web.de>
In-Reply-To: <ea39aaf0-0314-1780-c1cd-7c3661fa3e7c@web.de>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Jun 2023 10:06:20 -0700
Message-ID: <CAP-5=fX+kdRujgNAq8SVkkNwgnB383r38+AEmvon1k01R4X=kg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf parse-events: Remove ABORT_ON
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 9:56=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > Prefer informative messages rather than none with ABORT_ON. Document
> > one failure mode and add an error message for another.
>
> Does such a wording really fit to the known requirement =E2=80=9CSolve on=
ly one problem per patch.=E2=80=9D?
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.4#n81

Sorry your explanation isn't clear. Please can you elaborate.

Thanks,
Ian

>
> Regards,
> Markus

