Return-Path: <bpf+bounces-4831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA7774FECB
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 07:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBE52812E2
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C0B3D8A;
	Wed, 12 Jul 2023 05:42:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615702119
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 05:42:00 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF781716
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 22:41:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso10616568e87.2
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 22:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689140517; x=1691732517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQPpDnkU+B0d28oe2Z09vWnkPG/WcLBH40AU/B81wQg=;
        b=UA8Tir8t6/MrPSqgO0b/9ZBC9cNSuCPAeEB3vPZYBK45HacE2tIgXWSPNVi5Pa5DMV
         xj8/DvS4bdmtrkmaOEr44d3K9/DjgYAsANaNSvnQ1dc1UEf5XNr65xRheQJ0T/j5WsIO
         Xh5DnpJXfejRBYkMZ940/5OxCBJkKO+4TGc2dVU16qozXjK1GLWYATNIlqXfDm/OQoWO
         8rtZKv0Sda6TZkG12KKed8Lg/d7NLeafk3bCJFGucGBjEHQYv6IOuk4V32ZwbKXZiDqU
         20b1+mc33t/zT7SwpvmSvH5HcS6lFQnDod4ES7ayI1r/XyNw+EMMbZuH7DiRe37+JX2v
         PKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689140517; x=1691732517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQPpDnkU+B0d28oe2Z09vWnkPG/WcLBH40AU/B81wQg=;
        b=S99rx+cae+iw/OwpiDWFwIhs0xQzvhyqxkQBp++e1FvR0eKA5X5Ln4FJzKze8RCHlY
         /Pz//5PBUjtJx1SRFARK6exg7ug8P8ZEiIURQM98Caq5krm+G4bkHR8abLwYOHJL83L9
         fy3xBGrU+rary8/bDz7xd6K6I28KPaaPHzWFI8nyk8iVA3EqWSZYSUTIkzHqiWVDiXKr
         GgSSfY+RWKf5sujaF43BIxefie7+kjyWv7501fXyKiULiwUzmgdpQNE4UsGxRuZ5ARN9
         dCarFWv0BGr54+TlrcPpKIUHX6xTaP/z5MqPDp5PUUjrsSr1Tg7PLGe2kBvCF/F2ovH9
         wBNA==
X-Gm-Message-State: ABy/qLa0JZsxFlravhgnkDsx6xbkhIPJbO8yWU4uBny0GXAKh6JGjpgz
	X/hS+rYMxqYkfmj0eX1B2VPA0l8VbWSCryeG8fQ=
X-Google-Smtp-Source: APBJJlH8y2Zlfs639Vxq6tkeLoRfpFr8kJ8JAzJ6cLvasnmMnTZkl0axVBRP2QnTv1tq6HF62cYvLcb7lm5kXoE+IGM=
X-Received: by 2002:a05:6512:2828:b0:4fb:897e:21cd with SMTP id
 cf40-20020a056512282800b004fb897e21cdmr15848964lfb.67.1689140516500; Tue, 11
 Jul 2023 22:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712010504.818008-1-liu.yun@linux.dev>
In-Reply-To: <20230712010504.818008-1-liu.yun@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jul 2023 22:41:44 -0700
Message-ID: <CAEf4Bzay5QC_pbH-Km-oqL8MzzyUCtKU3Xc2Jie5bbRc=PBi5A@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Support POSIX regular expressions for multi kprobe
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, bpf@vger.kernel.org, 
	liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 6:05=E2=80=AFPM Jackie Liu <liu.yun@linux.dev> wrot=
e:
>
> From: Jackie Liu <liuyun01@kylinos.cn>
>
> Now multi kprobe uses glob_match for function matching, it's not enough,
> and sometimes we need more powerful regular expressions to support fuzzy
> matching, and now provides a use_regex in bpf_kprobe_multi_opts to suppor=
t
> POSIX regular expressions.
>
> This is useful, similar to `funccount.py -r '^vfs.*'` in BCC, and can als=
o
> be implemented with libbpf.
>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 52 ++++++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.h |  4 +++-
>  2 files changed, 51 insertions(+), 5 deletions(-)
>

Let's hold off on adding regex support assumptions into libbpf API.
Globs are pretty flexible already for most cases, and for some more
advanced use cases users can provide an exact list of function names
through opts argument.

We can revisit this decision down the road, but right now it seems
premature to sign up for such relatively heavy-weight API dependency.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 81aa52fa6807..fd217e9a232d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -25,6 +25,7 @@
>  #include <fcntl.h>
>  #include <errno.h>
>  #include <ctype.h>
> +#include <regex.h>
>  #include <asm/unistd.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>

[...]

