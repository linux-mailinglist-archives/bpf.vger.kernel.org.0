Return-Path: <bpf+bounces-1413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249DF7152FD
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 03:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759DF1C20AF8
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 01:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98C5A54;
	Tue, 30 May 2023 01:39:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26980D
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 01:39:40 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4341D9
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 18:39:38 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6260bb94363so19385936d6.0
        for <bpf@vger.kernel.org>; Mon, 29 May 2023 18:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685410778; x=1688002778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQvSquq+PxIhEPJsRAq6WPiWhrg2kySLnI7kv5zrI80=;
        b=F9Wa1gWJy5dS5Lxh0ZWw/7XkkplqZrGT2v7EqxnxslC8igxy8tCBHC8LcTqnrFSnE/
         hLmmm9S1G8YZYiYEj+FpXPjMdDKc2d7Im6rtI6/mp33IG6N4mEr8HexIPdM0bi/KSMOI
         bW72LmPfzyko+01UgcC33CYFOgu4+Dis23g9gdX5r45VeNU/rsS4d4JCkqcVYIxG0RR8
         n6owGquAre0zOWF6T0TN9Niq9icjgunZxnhHDRqsaMAkTmnuNoOAecikeX5N38x2XZeq
         N3sxWzFY+GADdJyAcC9TvfDoX2tVF5qjsIJk/Oyl+bcirFxD0UtrTA7jq7ohhSpQd+vR
         uVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685410778; x=1688002778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQvSquq+PxIhEPJsRAq6WPiWhrg2kySLnI7kv5zrI80=;
        b=YydJyCWJqVaZdm2LtvwXOnIRN+4FOQ6oABso5ItkzRko2IRz6r2DM/wA1p2PqB2cEe
         v3C7OT9pP2yLsKHmZYIxk1Jvtrj3HF/UXMqc2giPtb/HtFv3JpRy6mDqbfArfLWOsNRt
         U2eNmkq73vyo+ITp2HLiTkfI1OYJ4b4ZNfw0E4jO6QJ+WckMraCDmcKy+LcgcaID6vNr
         HQA4BFgLZxaH1H1Cjs+gWgtd7c0wmWzW2xP0FdjO78y6IcbHDe24GS/oq2FSTIR36mh+
         zybZTdJ4JjGBQhS2/iYABM1glIeNQ3T+qdvRCYE8CiS6kSPdT3JxEZmD4VXek00Lzosf
         uB5Q==
X-Gm-Message-State: AC+VfDyRrJcWb9a5L7vFHCkre5gkMW7RQ0d1Cw9kzs3jDhAJXStk2x52
	XOvuvZ0EQAnFUFct+oABOlwOYdc9aaof+G6+jHs=
X-Google-Smtp-Source: ACHHUZ7o8CA85/yBTUVEzH6fAeCRZTfQZpr1tSeEGfA8pzAQFOjK16FjjSV4fLuAtLChgdb1Yqtc+2t4SnCCqS4Gw7c=
X-Received: by 2002:ad4:5ca2:0:b0:5dd:b986:b44 with SMTP id
 q2-20020ad45ca2000000b005ddb9860b44mr1083002qvh.6.1685410777974; Mon, 29 May
 2023 18:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230528142027.5585-1-laoar.shao@gmail.com> <20230528142027.5585-2-laoar.shao@gmail.com>
 <ZHSVSWph86bmJyvY@krava>
In-Reply-To: <ZHSVSWph86bmJyvY@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 30 May 2023 09:39:01 +0800
Message-ID: <CALOAHbDTiPvawvS5xegiLVERzjh2MgmusDQFhCcfLY=wzw=oTA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/8] bpf: Support ->show_fdinfo for kprobe_multi
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, quentin@isovalent.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 29, 2023 at 8:06=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, May 28, 2023 at 02:20:20PM +0000, Yafang Shao wrote:
> > Currently, there is no way to check which functions are attached to a
> > kprobe_multi link, causing confusion for users. It is important that we
> > provide a means to expose these functions. The expected result is as fo=
llows,
> >
> > $ cat /proc/10936/fdinfo/9
> > pos:    0
> > flags:  02000000
> > mnt_id: 15
> > ino:    2094
> > link_type:      kprobe_multi
> > link_id:        2
> > prog_tag:       a04f5eef06a7f555
> > prog_id:        11
> > func_count:     4
> > func_addrs:     ffffffffaad475c0
> >                 ffffffffaad47600
> >                 ffffffffaad47640
> >                 ffffffffaad47680
>
> I like the idea of exposing this through the link_info syscall,
> but I'm bit concerned of potentially dumping thousands of addresses
> through fdinfo file, because I always thought of fdinfo as brief
> file info, but that might be just my problem ;-)

In most cases, there are only a few addresses, and it is uncommon to
have thousands of addresses. To handle this, what about displaying a
maximum of 16 addresses? For cases where the number of addresses
exceeds 16, we can use '...' to represent the remaining addresses.

--=20
Regards
Yafang

