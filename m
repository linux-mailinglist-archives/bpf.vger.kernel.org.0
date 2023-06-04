Return-Path: <bpf+bounces-1771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832C721478
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 05:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6491C20A92
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 03:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78951C26;
	Sun,  4 Jun 2023 03:26:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1017F6
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 03:26:52 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20803D3
	for <bpf@vger.kernel.org>; Sat,  3 Jun 2023 20:26:51 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-626157a186bso27260216d6.1
        for <bpf@vger.kernel.org>; Sat, 03 Jun 2023 20:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685849210; x=1688441210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B0Eq5vr6kFgjFfXTPBz/vAuJS/uDyXMLmVUV+UZbQc=;
        b=oB9zogOXwJwjJlsRg2Q8vBhY7m0hbmpuwSAnTMzlzO1mqhrFoeOf/KAQIe75+x8VTY
         Tq4WH7bt74/W2kbafaGJA97Uc0Jc631+oiUJrTu5jUVi4IiviJyhoj+7WxvRzMcBinUB
         I3LMOWH6/LSIoYbYuDgHeagaP09icGn2apIjDK5wTeUK0gGXgjnLetqI3DFeyfmm6Ybc
         se7z+KxzXZKFcjUAddg+71INRAWwBOvPLU1L2XCV+Ad37lh7aZAvLc7wayWf0FYJQCH+
         CRgF3IpOdhM3ik0+K9PSkC+TgEXTZe0o6VV0h/05n5/xW4YUxpPLG3S+ZbFzW79kjB/2
         ukyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685849210; x=1688441210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B0Eq5vr6kFgjFfXTPBz/vAuJS/uDyXMLmVUV+UZbQc=;
        b=TozfbDF/WXN0AGPC0dNbK3KNFmnifFzY7srLofJpmqFWVX4lmK6b0e7gEZoy/sCrFj
         8jZVq673WvJX/57BxSKlq+MXpQV19t/v3yU8OG24kXWmMVlS1wpw4iLMHffOofHcJ3J+
         WsJQZhyo1VeQZA/CumgxZXTdMG0bfEgh9LtfLqB5ShP2E9bUN8xGlv9CMBsN7yCsUoOq
         BokfBJbbybLyxCOdsSCxYUfq50RkvcKmjL4A0xgzhNIIf884SAvfJaaTEWQ1NMisNenY
         y9tsvgWAgYEnpZsvACl2G+Emasq9Zp2h4067Efg42lsn2M8mcnYkpclUYXf2e6RIlkM/
         W7Aw==
X-Gm-Message-State: AC+VfDwwSw0eMWcb31HbtUz5hpL46v7RkJUXaml8jSBynX0108u9kC+8
	+BbIiaXru4HdBOFHi4JbTtTH93FL9JSIahgCu7G2zGVLi+4=
X-Google-Smtp-Source: ACHHUZ52k2rA2au1lPYFNMjY7ZNvpeXDRhbctJhSF/El0tSfe1GZnxBHVKWBW2pXr86U73OkooX9OJ+z0WDCKEonwhs=
X-Received: by 2002:ad4:5ba9:0:b0:626:c17:8b55 with SMTP id
 9-20020ad45ba9000000b006260c178b55mr2533057qvq.25.1685849210209; Sat, 03 Jun
 2023 20:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602085239.91138-1-laoar.shao@gmail.com> <20230602085239.91138-3-laoar.shao@gmail.com>
 <CAEf4BzbJCCxj-0CCy_xsiJKk1Re_iXNGH95j9ChnOwSeeLUYEQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbJCCxj-0CCy_xsiJKk1Re_iXNGH95j9ChnOwSeeLUYEQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 4 Jun 2023 11:26:14 +0800
Message-ID: <CALOAHbAf=X05fqCz1ABX3pzc60QE5ax=pEfuGxhFkqJQT7Md6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpftool: Show probed function in
 kprobe_multi link info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 3, 2023 at 6:16=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 2, 2023 at 1:52=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Show the already expose kprobe_multi link info in bpftool. The result a=
s
> > follows,
> > $ tools/bpf/bpftool/bpftool link show
> > 1: kprobe_multi  prog 5
> >         func_cnt 4  addrs            symbols
> >                     ffffffffb4d465b0 schedule_timeout_interruptible
> >                     ffffffffb4d465f0 schedule_timeout_killable
> >                     ffffffffb4d46630 schedule_timeout_uninterruptible
> >                     ffffffffb4d46670 schedule_timeout_idle
> >         pids trace(8729)
> >
> > $ tools/bpf/bpftool/bpftool link show -j
> > [{"id":1,"type":"kprobe_multi","prog_id":5,"func_cnt":4,"addrs":[{"addr=
":18446744072448402864,"symbol":"schedule_timeout_interruptible"},{"addr":1=
8446744072448402928,"symbol":"schedule_timeout_killable"},{"addr":184467440=
72448402992,"symbol":"schedule_timeout_uninterruptible"},{"addr":1844674407=
2448403056,"symbol":"schedule_timeout_idle"}],"pids":[{"pid":8729,"comm":"t=
race"}]}]
>
>
> probably a good idea to also show whether it's retprobe or not?

Good point. Will add it.

--=20
Regards
Yafang

