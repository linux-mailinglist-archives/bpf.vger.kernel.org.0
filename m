Return-Path: <bpf+bounces-5619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE3F75C9DE
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DF2281E8D
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439601ED35;
	Fri, 21 Jul 2023 14:24:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166331ED20
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 14:24:42 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F7A30CF
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 07:24:38 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57764a6bf8cso22528417b3.3
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689949478; x=1690554278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8ztgMvA+efivb3zvfwoxg39ThpiIM2mYSu5oGv5kHQ=;
        b=cP8k+YLz02K0HGvAlXEo84L+RFE1hAHgDU85TQL6prNb2Z1x9Kj092DtJQ+5Z2Gnt4
         hX/jQxXF1ZzmY02zOJRUhRX0m8vv8y11XVCAloo/etTo/xIhUNLekzvEpswheDzTvKDq
         fLiAYPbzMigSmG5ENKuoiA3fFM/cctYg3titn8JI/6g9lYQVhSsqkb8ZijuwxRuAL0dy
         r4CqMG1BsTjbP0KyvGOtg12OZIIw8MwesZku+d6/GGIb/qTug06+GGpkGPqCFHvAmiRE
         niRsOFymcfOzvCEF2rT0OcQuzfdz5GiRy6xFtStUT9kUVw9nDcsTZk8fmcnYi/bNS0Jk
         UdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689949478; x=1690554278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8ztgMvA+efivb3zvfwoxg39ThpiIM2mYSu5oGv5kHQ=;
        b=Olbfi6iDBDkgAkQ6D1M+zZ6zzqYUhaLN3GXQJD60yRhn2JYQfqGnjeqZZQ5mqVb94f
         NIAXKyrrPiTMzhbBfH4K7K/qtioRiztDERvvRgF4S/NeY6+fh0WZ7nxbABzNut8llUzh
         6iKyqm2Wsf8YBrnxGbh5xanfTYkXRCscO7jSq/r7eevNO0v1wCikugmOcyHKbTA1VaBO
         W2LoZpWGXZUNVIW49vvTTvnDz6vn9sHHJRxfTR3ZiYbhQJ/Iz2FzmLpAkamvAmI09OBc
         /EMa26dsLXncWKibDZpVd/JLBHiTeRdMdQMdEg4PghXO9vcZ3d5gwUWKys22vMcXzfbJ
         gJXg==
X-Gm-Message-State: ABy/qLYZVFtHirVmoR5dRE85azVOgHUisaUoHQl8pPkxLnfhOXIu/WLn
	YuE3XePUEeml/0vKp993l6mdGXGAeuJuTzKjGS3I
X-Google-Smtp-Source: APBJJlGkctnRWeYQSNR/Xwb+OMnSG51UHGgmnhj0crFYLZf3uLEvqoDrwlYGU+rZRaE9jZgtAqzvJN1Wd16AeboXQtE=
X-Received: by 2002:a0d:de84:0:b0:576:777f:28bc with SMTP id
 h126-20020a0dde84000000b00576777f28bcmr209789ywe.21.1689949477988; Fri, 21
 Jul 2023 07:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721033236.42689-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230721033236.42689-1-jiapeng.chong@linux.alibaba.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jul 2023 10:24:27 -0400
Message-ID: <CAHC9VhT3pA12ndrPE_VzgA7_tr2cWVz1jn3QLch+CW9P+B37uw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Use NULL for pointers
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 11:32=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Replace integer constants with NULL.
>
> security/selinux/hooks.c:251:41: warning: Using plain integer as NULL poi=
nter.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5958
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you for your patch, but a patch to address this problem has
already been posted to the list.

https://lore.kernel.org/selinux/20230720203116.316250-2-paul@paul-moore.com=
/

--=20
paul-moore.com

