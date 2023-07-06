Return-Path: <bpf+bounces-4146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31597493A3
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AF61C20C71
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 02:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E2EA4C;
	Thu,  6 Jul 2023 02:19:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040F7F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 02:19:42 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8D12A
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 19:19:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b70224ec56so1751521fa.3
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 19:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688609980; x=1691201980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BR5bk2NSP6NPbsV0TwJAA0rRIdy0PhRynQZOR4S0a8=;
        b=c/rDbeDri0JfHEYEaVjpJKRTA9sJclPQ5+9NvP5zV8eyAv7wBsPJ3fM8RarxVDkpI8
         4iWaUY0BHYQ2WKGGwcnAOuOcUW78oNEtmDMEQyd1/6jQVGAb6eIJUR/m+PmtFJi1hgC7
         ezIHt/oWU6KvPsM9Pqg4VwtCYe1lc99hbczoHt3YyKhM7MUMmO/CHlqgVAKFb2oeQW+5
         8MINf7eMDU9VFyQywn7dFVHoqUbaWrhVoiCvMpdUu0n6LcjOT4xKP6Bgu6hfO7T9jbrR
         +hWcsuN0+WHFBnrJr4G0qW+q4Z59332j+UYcmTr/LG8xyDS+a2Djp6dlXvLw6ZgoXGPQ
         6okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688609980; x=1691201980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BR5bk2NSP6NPbsV0TwJAA0rRIdy0PhRynQZOR4S0a8=;
        b=IYhAG3RbAhXTmpRBgU/48zwXqDlLor6SR+TKkc/q/1K/IQr6Y7zypFyD/pX4L5r0Dv
         QVDoTBkyOjZtVcnvJsSD3mhLWRt+XMkkeKpT5fZWuzFa8KbkWKBLuT5A4bTx+xRoSkfp
         suum0hqZZv61Zym5kJBGsJApnJuTjoX0Cv/lflIMnDDO1sUApFlWnr1m8mh5kGfNyTMN
         sg9Hs2bMImpIFKS7qzNt8prQcBWhI1jfXcXjABH36BRweUemdXBHmeGOeEWdJnWquqSy
         IUgnVZgrdMC6Vv8f10m/TSfl7jf+6fa4oilXMdATzvyjAp7UTEvtFQhO31Xa9jcMEycU
         TVCg==
X-Gm-Message-State: ABy/qLYIFNaRXvY6mlvsHstJK0XDRpfw+yq0qRWzvJI8es4LN5SWnnBI
	bQbLn/cvlJNj5/uZN+nhIFin0ibHlhLeo5zKtkc=
X-Google-Smtp-Source: APBJJlHf/0gsMLXwzF7LGtxR93CjtAYFSFv5TzESZMz5c3j9E1/mhnlsDowl7tngliOL3Aa4HRB7kRjG1QnEQFf9EsI=
X-Received: by 2002:a2e:95c4:0:b0:2ac:82c1:5a3d with SMTP id
 y4-20020a2e95c4000000b002ac82c15a3dmr330854ljh.23.1688609979774; Wed, 05 Jul
 2023 19:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230705144730.235802-1-memxor@gmail.com>
In-Reply-To: <20230705144730.235802-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Jul 2023 19:19:28 -0700
Message-ID: <CAADnVQ+Y4N3hm++nnrSKiMECTXSjaqm9ib20XbveePdksK35+w@mail.gmail.com>
Subject: Re: [PATCH bpf v1 0/2] Fix for check_max_stack_depth
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 7:47=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Fix for a bug in check_max_stack_depth which allows bypassing the
> 512-byte stack limit.

Applied. Thanks

