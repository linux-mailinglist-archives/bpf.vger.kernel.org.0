Return-Path: <bpf+bounces-6224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C976725B
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3FD281A4F
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8314AB2;
	Fri, 28 Jul 2023 16:48:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921015480
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:48:44 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD6D5253
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:48:24 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so34986731fa.3
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690562848; x=1691167648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3V90xe0un59aDlPX+82hlpa6RFv0i5Rghwuu99zIdE=;
        b=LbdQkW7PK8TrpCeLL9Uwz6YGDIDgSe2GKPZLlS4pDTi2nFUudtZ7VQrM4NjzHzTE7z
         CdKIREe6ZoZP+Ye2zJV0HgEBSqw9hP4wA4kH6oipQ7rTAc5c+OAETZgzJXmkz9CzGf3L
         bYtKuefukOrpCfR71RRwZkQXyjqv7AoUGJ3Fsd0cUbirVgzqM5QH5+E6lFlWTXhHKL1S
         8sBjDnswxMquks5GEuKwPix5hUieiX+If6mxIYamdZCSSJI+zlDgflZghTNx+uh7qIbk
         1UepBizaoULdxmyo35fDHQNmAZYayT2q/RUVVpU/XY2DDRVrysOSmRoqn9hypA511EQ4
         6Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562848; x=1691167648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3V90xe0un59aDlPX+82hlpa6RFv0i5Rghwuu99zIdE=;
        b=TnsNfB8tTsknf4k4n8GgqmrE4axP8STcHJq5I6ow1HE6cb1KJbd2gAN+x8SHuDOFBJ
         cE/t6pJvhkV0HYrLconhuw5snGk2I297qmcMU+XmgpqBmN65vs1MCq5oQCjAXuUiG0Uj
         PV5Edpvb6sS88br1TcKE8lN8N3AzhISnFqVUT7hFI9SJR0mJTl0WeukfDY76Qt8hBZad
         U1BJYnUZ5vlr9VCDxxM7IcpfkHy9kXnL24DuLDsH0oY/BCsEcw6RrwNUVw62MiTiIN9U
         vG3CBc5FSEilkjH1E1ZAHbpeIgW8s9OHBCqHQXlC2iEjt+xmyR1MEdwMm048HtvRXnjc
         bduw==
X-Gm-Message-State: ABy/qLbtfJRgAzTZnrcCtfVBK8gwopxEuZdqWsLU0uLyzTC7/iC5O/FC
	4XL/lDFoeJ3ufezxuAcQZW/f00PRJYGGi//q53ynwOu+
X-Google-Smtp-Source: APBJJlGoFJ7zEdvS558UF7pER4i5kzzyjMamupsJ88AKf+A8V/1fFxe+qmB1+0VEDb+kyltDesVllV3KXVaOnC+poVE=
X-Received: by 2002:a2e:a3d2:0:b0:2b7:2ea:33c3 with SMTP id
 w18-20020a2ea3d2000000b002b702ea33c3mr2360290lje.22.1690562847636; Fri, 28
 Jul 2023 09:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878rb0yonc.fsf@oracle.com>
In-Reply-To: <878rb0yonc.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 09:47:16 -0700
Message-ID: <CAADnVQLG7WY9BthOQTDQ6UkszJo5HDiGSjKO+jMKaJ+02G90QA@mail.gmail.com>
Subject: Re: GCC and binutils support for BPF V4 instructions
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 9:41=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> Hello.
>
> Just a heads up regarding the new BPF V4 instructions and their support
> in the GNU Toolchain.

Awesome. Thanks for the update!

> V4 sdiv/smod instructions
>
>   Binutils has been updated to use the V4 encoding of these
>   instructions, which used to be part of the xbpf testing dialect used
>   in GCC.  GCC generates these instructions for signed division when
>   -mcpu=3Dv4 or higher.

With sdiv/smod implemented do you still have a need for xbpf flag?
Anything still missing or you can start using -mcpu=3Dv4 in gcc selftests
and remove xbpf completely?

>
> So I think we are done with this.  Please let us know if these
> instructions ever change.

Fingers crossed, they will never change.
How far are we from running bpf selftests with gcc?

