Return-Path: <bpf+bounces-4661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D9A74E30D
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB97A1C20CB3
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC52392;
	Tue, 11 Jul 2023 01:12:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058037E
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:12:50 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C032E77
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 18:12:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so77583981fa.0
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 18:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689037943; x=1691629943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pex3OXnO+EOM0lLTq/CM4rL/UluIcTGfOZlbj7zTj6I=;
        b=XGk3u5Tmo+EYlpt1Qfu3/ixZ1p9CmSyTZXM9nPs4sHgd8JF0BrcUsfwCKiTdPyv0fh
         5Nm6VbULLqvq46feHjNShV/O+iqzPhLvBjtu9C92+wNM2MnE4m2kBt6v7Mo7MvvOYUCq
         Ti77jV5xXpQDReAOanTur3xQ7/Adz9eIVeA7GJHU4Rb48oDvZTQyoEBk8GXp9K6jJsmO
         1J+jtjCk6Iy8K5UVQRz6+U17WshhgDk3rabbpcOQOn8dwH0Xc7FfOW1Cgu9oqJY5lWPL
         M4lC/4GKoVdXw1Z12E7ts8kikjRuERnsA7itkQZSWL9MNggNTrFNCv+fGJ3gjj70ghhj
         bA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689037943; x=1691629943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pex3OXnO+EOM0lLTq/CM4rL/UluIcTGfOZlbj7zTj6I=;
        b=LQmHwIxuHyeFuhSXTToDqFJBGCUkxjHNXbeLJHzDQbkY1zsa909MMfOReqCOg/yyHz
         2exEaBTo619SKnBviAl9Vqq8yVLhJV9lVK4R1jGEvJA631qqidfybKRm3JbI2KjS66ve
         OdrmWKoXep6E98HxgLCSLpou23zTZZ5hFKDeM24cT9Pr0kgxTZJrTZmwwLRtGbNC4tet
         3ejay8DNVAkdvFY1K7hkeVIEUCRsswUce4camzMFPT6rZTYy1dPXNdjbw9kbgwNR6FAf
         b4HnPSAzTivqj3pNCSxsAY7LMU+LemlR842pusVfPI7/T5lv96ApMr+bBdV9hUbQ84h4
         vyxA==
X-Gm-Message-State: ABy/qLZ3SSr5R4ZLmALOybM9hu6lG2DqtUIk+ULfaB7fj2bOMnJ4Mx4V
	kgMMOb2Bk+MGPcdwFXt9KiheFbLqOyi84zokYejLSUo8xnc=
X-Google-Smtp-Source: APBJJlG/vTWX5lu60jp5eKOQVbHSm2ZmTT39myj8gt9u/9jh77aLQqQjNkUzDJb42F+gfR/wJIzK4SC7aXwHZ5BlIWs=
X-Received: by 2002:a2e:a311:0:b0:2b6:fa42:1b1d with SMTP id
 l17-20020a2ea311000000b002b6fa421b1dmr11980850lje.29.1689037943157; Mon, 10
 Jul 2023 18:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710183622.1401-1-dthaler1968@googlemail.com>
In-Reply-To: <20230710183622.1401-1-dthaler1968@googlemail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 18:12:11 -0700
Message-ID: <CAADnVQKjugok8G1ymHC1TgZbTeB=-wvYSU49YgerrLi=F_fP6g@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Improve English readability
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 11:36=E2=80=AFAM Dave Thaler
<dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
>
>
> -The three LSB bits of the 'opcode' field store the instruction class:
> +The encoding of the 'opcode' field varies and can be determined
> +from the three least significant bits (LSB) of the 'opcode' field
> +which holds the "instruction class", as follows:

ERROR: trailing whitespace
#36: FILE: Documentation/bpf/instruction-set.rst:106:
+The encoding of the 'opcode' field varies and can be determined $

and in other places.

See BPF CI:
https://patchwork.hopto.org/static/nipa/764126/13307479/checkpatch/stdout

