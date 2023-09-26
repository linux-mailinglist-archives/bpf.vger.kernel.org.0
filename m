Return-Path: <bpf+bounces-10906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F27AF5BB
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 23:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 227D01C208FE
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 21:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB114A52F;
	Tue, 26 Sep 2023 21:32:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDF347AA
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 21:32:22 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D65158AE
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 14:32:20 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d862533ea85so9517394276.0
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695763939; x=1696368739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY9jveINp5V5rlaBbscxlXmPxYesM9ges3+QHzPHTww=;
        b=JevHIhiYqEti5uTChAjUeDs+BEKCL2g/TRyKpHJ/sKw/h9kJ+4HCHHueL9YgowiXeH
         y+mmV6LB+UES6nnIE0g9mcDow3/ZHPCPRA5pmeJtKaqszxJpl0NT7ay2th4isuwERWRd
         6ifB8qXrbjG6XHh86W6nYjbJ42MprekK2a0jDJyRYz6wdUkKZDcVRoJbS8W75zZJ/ol/
         wjRxHQwuiELIsm0pgootgzP3h4C5nRtHxDOpGShBY4KEdcX1nWkWGPR50zOC0aZH70pv
         bM2ZAeX1I+fDiPw6Kc3dDttcv550is1BDPyTfxuXeB+7xXzhCZYRvFSfU+WatkBxmaVl
         Tq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763939; x=1696368739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY9jveINp5V5rlaBbscxlXmPxYesM9ges3+QHzPHTww=;
        b=obh9xHAh74V9JGvb4PhN+1ZUmE/UHhkdRDeRlyNeeqVbiMf/khUwNDYpdj1oP36G+D
         sStAPVRXlHPoFmu05H1pL1Np+46EfEn9BOXcup1MCfGBAIy4mGxLbRg9yRUQ9w3g2nda
         l4C/QgiSzu/ERW1mITHl20Arx+6o0+6xXbPuweAtIuN3Vs1uex0+4DwOEAGFQ7ulF9JC
         /QVBY29JPFZcBG1EYiLRya7/ZcBRIxhWqaGyJfCJLZpMCRUjoLY1l7fkS7ZZDKWlHVvc
         lUaVXyyXI5cFUHualkrLVStzMaI73oMQaYnqnp9hq50lSnbR3LhF1tfKz7hOe4gUsoXI
         h0cg==
X-Gm-Message-State: AOJu0Yxml7xqEGhAH079mUNLhGJC07/YZhjhaCXBBtBIXDVqKSy/kYTw
	j+AolELbl9KBioQ1e/KuCgfwFtXc2vbMp0b/I9R/
X-Google-Smtp-Source: AGHT+IFCtQ0lRQAQtAczfLsb2sztHe5JKNKH8brd6I1PKgoiFWprOSxrLQWdFdj8Jz71vraPlw9N0n534XJeETDCyZI=
X-Received: by 2002:a25:d308:0:b0:d85:e4c4:4778 with SMTP id
 e8-20020a25d308000000b00d85e4c44778mr183132ybf.0.1695763939574; Tue, 26 Sep
 2023 14:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912212906.3975866-3-andrii@kernel.org> <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
 <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com>
 <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com>
 <CAEf4BzZC+9GbCsG56B2Q=woq+RHQS8oMTGJSNiMFKZpOKHhKpg@mail.gmail.com>
 <CAHC9VhTiqhQcfDr-7mThY1kH-Fwa7NUUU8ZWZvLFVudgtO8RAA@mail.gmail.com> <CAEf4BzZ8RvGwzVfm-EN1qdDiTv3Q2eYxBKOdBgGT96XzcvJCpw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ8RvGwzVfm-EN1qdDiTv3Q2eYxBKOdBgGT96XzcvJCpw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Sep 2023 17:32:08 -0400
Message-ID: <CAHC9VhTLnT6HmkvJBXVCApHG4sCFdgXxJykPQ8oYLaVa8vXWkQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com, 
	sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 6:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> No worries, lots of conferences are happening right now, so I expected
> people to be unavailable.

Just a quick note to let you know that my network access is still
limited, but I appreciate the understanding and the detail in your
reply; I'll get you a proper response next week.

--=20
paul-moore.com

