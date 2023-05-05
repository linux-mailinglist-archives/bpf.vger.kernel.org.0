Return-Path: <bpf+bounces-162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52B16F8C30
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 00:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299831C216E3
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 22:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C3A101E0;
	Fri,  5 May 2023 22:05:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60309C8C5
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 22:05:16 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD459DD
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 15:04:33 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so2015868a12.0
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683324266; x=1685916266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOmbsGYEsFtfQgM+qoHHhgYWXdL1U5AVLffr2XaVCw4=;
        b=29z1it1cgWZlrXnWRidPMsJiaHZfbDFSS2z+lvwr5JJlvqHJQhqMcFcUfzDQRbM8uR
         xm5cc7i/hCctNB8/lz4FG54GBwhUg8DMksAfWLiXj9aSe5LNCNCuuX6Et6xsI8Yr7bVT
         RNNwdZejW1hhvaspkKdLBa3s4L1n+YDS9KdquxiunV6Ff7M2/CpbZHiHYjfGkbUGiZ32
         Q88wurXUn4OpFvaWFODwfVeCUB2G7A4FiEw7JUWaEFMWJM+suugNk2/+yO5/FUHz3AgT
         2BN8YNPJO3fzS1sG1NcCCjUB2vV383PJnA5YNzNqxkqD8a3olStAKkQjp2u92/22FR4j
         LBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324266; x=1685916266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOmbsGYEsFtfQgM+qoHHhgYWXdL1U5AVLffr2XaVCw4=;
        b=N53BbLyCPCKJ75DoyXymmUnYeF1Tr2N4rezqY9X81glZjL471cZMPMGsgj3rZDPROj
         UnuDmzsz2QOKmbgdQMlT5aUkRET49wv4cJnJPzziPWBFZfk4VF/BQILxUfgnEH/sCr4k
         bCINgzMA/KJe/gIt66DE5aArwYuOdY6PDyH5YbZXwFIzyD7b3IH60iPFEmNVRZNe/Tpr
         yYwMIHDnReVJOSKtGoNih0qQaDFhr2ybtGfpuMhYWWUg7D1b3InAluV7RgC9V4F5PM6v
         z1d2s5yK4fZb0rUUKl65FmyY2kbBk4FJ5MwPmY+J/CIFhbHoufoRk4cBxy3Tth5Z206t
         Njkg==
X-Gm-Message-State: AC+VfDx7TYJ4lv5a5x4SuiWLelXcKbUobohxQ9HRoSjLmniNTVWOPxql
	X9wc03aSsoVlN8bafAX6EjuHF2e0F96p4tPre9+R6w==
X-Google-Smtp-Source: ACHHUZ5MsnLAiarFV1wmEmDt+cF1aFc+Wfxd6gEqmofNLsVZzj3BJvvBHG5JhsN6HlVC5r2TRCHsOqJMfjECeRwJObQ=
X-Received: by 2002:a17:902:7782:b0:1aa:fdef:2a93 with SMTP id
 o2-20020a170902778200b001aafdef2a93mr2623876pll.7.1683324266149; Fri, 05 May
 2023 15:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230504184349.3632259-1-sdf@google.com> <2e88749b-cbd0-af1c-9a73-44947e53b486@linux.dev>
In-Reply-To: <2e88749b-cbd0-af1c-9a73-44947e53b486@linux.dev>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 5 May 2023 15:04:14 -0700
Message-ID: <CAKH8qBtfozv0TOkZrXJno1CjAFMqgYixZVAnVFNKxMX-yJSHiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Don't EFAULT for {g,s}setsockopt
 with wrong optlen
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 5, 2023 at 3:00=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 5/4/23 11:43 AM, Stanislav Fomichev wrote:
> > optval larger than PAGE_SIZE leads to EFAULT if the BPF program
> > isn't careful enough. This is often overlooked and might break
> > completely unrelated socket options. Instead of EFAULT,
> > let's ignore BPF program buffer changes. See the first patch for
> > more info.
> >
> > In addition, clearly document this corner case and reset optlen
> > in our selftests (in case somebody copy-pastes from them).
>
> Looks good. A respin is needed to address the selftest issues. The bpf CI=
 will
> help to confirm that.
>
> Looking forward to v5. Thanks.

Thank you for the review, will take a look! The part about endianness
is surprising. Existing cases don't care because they are 1 byte; the
new ones are 4 and should, in theory, need the flipping.

