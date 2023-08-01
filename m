Return-Path: <bpf+bounces-6494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0242D76A598
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05C328177C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 00:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE6641;
	Tue,  1 Aug 2023 00:37:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885967E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 00:37:31 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B419B133
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 17:37:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b962535808so78039411fa.0
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 17:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690850247; x=1691455047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jlxRegHHKbU7KddOE8dLtxy0upNqrkeFFVO+Ciyx9g=;
        b=iyZbLF+1KZWXaQdWHcdDHN4Hfz2MnDQdaQLy1glOuFTOHB7NCAlBrguhXVbh5xM7ra
         ODGOHRVBT6gQfNn4u6kCAfuDNKKo0Yn3jBKwMd0RrVOm4UrccEtr+A6MtD4vhTx2bpPM
         MhWtdguF0FhoruE1f75UH9iNHgNkfgbkAXtohWJ2D2LFtbtS6iR11TcFoCBwZzJrOqEO
         otg2cr5EOeRGkoYOihesrJJYDaQJ24JsZqDSlgUv3ojxvyhKKb0Kk+69GEoSPC2/LpBU
         zJ5kEQA/gmQpeTSqUhaNFBfwRHoKLjsAiyJDx9/u0+dQuKagK5AcgfaBu4sm7SFAodDI
         aPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690850247; x=1691455047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jlxRegHHKbU7KddOE8dLtxy0upNqrkeFFVO+Ciyx9g=;
        b=OWLXPBmK3JYRDIjqqqcD0fKV1/StdEJXF5JrS3XgwjPN3kU/hDMbul+hYASz1tQ3VK
         EXa4RFlfnm9/opxH4U1ML/KEHR9tCszymZttn6a3T4UsaxvyEVafgZiCiofD6o6f7yQM
         jimi2/59FEGd+GTRCCMBSyh2Di6mwIcG22KCxgjFm7YAh3n4d4T2f3el793DXC7HjmRL
         CYB0LlgaMySnUC6ZcNodZoWFoiQzJVMKARvjP0OKdNb7EvAf8TmtOGDWPMqfcI7UGHzw
         wVqrtjzFXGrARI4utOILZky4ld8eS4hyr/4heCI60rA1XaohuChL+EreY5PfKniXDa5B
         S1og==
X-Gm-Message-State: ABy/qLZIV+0P8aDJzXxXUXojnda8FflhprgVuAJ/F9uftuIZTLnKB42T
	XqK+sv0eVLxpS95f+ndLKVK4eSrzfFkpTjSrQ38=
X-Google-Smtp-Source: APBJJlFKtmTr+NBwZ8sOaiTQY7eeJ4rTlgYzhjUsEMjM8VgUgD3TXsr7xvUmbinZKaihNHFjoxPlokzc92rba3V5hTE=
X-Received: by 2002:a2e:86c8:0:b0:2b9:c676:434a with SMTP id
 n8-20020a2e86c8000000b002b9c676434amr1079362ljj.15.1690850246614; Mon, 31 Jul
 2023 17:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230731204534.1975311-1-yonghong.song@linux.dev>
In-Reply-To: <20230731204534.1975311-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 31 Jul 2023 17:37:15 -0700
Message-ID: <CAADnVQJOK-VF6-wMFVfvFJ8ZrkK_JUpTWojhHQgVy27Jj4K1eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] kernel/bpf: Fix an array-index-out-of-bounds
 issue in disasm.c
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	syzbot+3758842a6c01012aa73b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 1:45=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> syzbot reported an array-index-out-of-bounds when printing out bpf

Applied and fixed subject.
"kernel/bpf:" is an usual prefix. Not sure why you used it.
Just "bpf:" is enough.

