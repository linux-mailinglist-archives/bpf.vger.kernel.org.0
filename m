Return-Path: <bpf+bounces-8397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFF6785EE4
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FAB1C20CAD
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952E21F18E;
	Wed, 23 Aug 2023 17:43:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C513C139
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 17:43:32 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A34E78
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 10:43:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5007abb15e9so6147434e87.0
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692812605; x=1693417405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nIrybXYoSlkVcoZHR4OHvdcxxQHojv9qeXc07d/T8U=;
        b=j7zapXjJBntc4SecfcYFSzw7AaUiMvKTR8u3ZZQT8J5i11pDL9+XULanII18odSyI3
         cHKKnK5F1LCEvQoI8LKzRf5tWRRBdM+eUFPKJzTjSPynYAfn++ZGdj9Nd+W7uQlayzmV
         DH7sgv+8QXp+72+rIr850OB0/HFoHHHQ/UQQ6YbvXAE+sQdaXSvzLl4pQ5Si7tBHR0Jf
         kDaMDzq/EeGBfW3eb46ND44NesDjaE1Tg9Rv+QavwMqQ6RvHlTshBWD+FJPrYkOiBZOo
         l1hSvRliZAOvk7O1DbvDQ+HkhG0MAALNBEypgCGwtUBa3Ic8eAaeQcfkKpX4eV2LIlr1
         /M4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692812605; x=1693417405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nIrybXYoSlkVcoZHR4OHvdcxxQHojv9qeXc07d/T8U=;
        b=KaUcItta0VhFNb/1DKd3McZwbfwMbmQNT+H/8D6t/74irTjVx12PAQoXL+exOwfqk9
         /JdWFseA+NcC2bsQ01qOv9XafP207LJQZ8A58wux8AaOHFsfPIM/stwj/P/WbOvwBFau
         GoPxtQn3/lvG9gI8e2zyioQdKW7ItTb7hO/D+oL6nVnD5EDEhSj5u3TSvyJxfazy8EYm
         CDbHYf6xJFKPknPiO01qYG7LRPxl9JyKaTveOH60sjespdn4/guvW2OM3z7lQd/t41t5
         FjAUFjOd28YxhNlJGSYVYUr96I6UzQ4sofWzLY8Q2Z0CS/8nvL+O8pztGfVVvLfGQHUC
         3dUQ==
X-Gm-Message-State: AOJu0YyxkxdY9k+cpUFf0CM6FWltS9goJjXjT+2u3tdP0dOaiYEeiydH
	12EgYKzadoKUBJnS41jQ8alKhegjgdMoxO++kek=
X-Google-Smtp-Source: AGHT+IGrzD5Oc8eAjTTcg8qSpgoAPnSr1Tu3lDeYTbxq3r7ugqcjL1/ndd8n0cHWdMjjY3EayqCPDWMQ2U0KMW/vRaM=
X-Received: by 2002:a05:6512:3444:b0:500:78ee:4cd7 with SMTP id
 j4-20020a056512344400b0050078ee4cd7mr7222880lfr.23.1692812604933; Wed, 23 Aug
 2023 10:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com> <CAEf4BzZouNbzP7xOPxnU_Xzof2-L0fNE4CcjCcUJpJjAdyPJSw@mail.gmail.com>
 <36463876-1370-71d6-78f3-2350278f61c7@linux.dev> <CAEf4BzbpjVbXjmKHo3dshR4qVWUwCK+1LVZb-6CJ1TM5T+r3AA@mail.gmail.com>
 <CAADnVQKcG9tOFw3xtEa8y2KvVNZaTTnBSmbX9sdrqp-vpEejTg@mail.gmail.com>
In-Reply-To: <CAADnVQKcG9tOFw3xtEa8y2KvVNZaTTnBSmbX9sdrqp-vpEejTg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Aug 2023 10:43:12 -0700
Message-ID: <CAEf4BzaeUYFGi92j_MAMo5JPU6HzGwhWaVE9O+YGhYCE1S1TRA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Marchevsky <david.marchevsky@linux.dev>, Dave Marchevsky <davemarchevsky@fb.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 10:26=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 23, 2023 at 10:07=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Yes, I think we'll have to have BUILD_BUG_ON. And yes, whoever
> > increases vma_iter by more than 13 bytes will have to interact with
> > us.
>
> A bit of history.
> Before maple tree the vma_iterator didn't exist. vma_next would walk rb t=
ree.
> So if we introduced task_vma iterator couple years ago the maple tree
> change would have grown our bpf_iter_task_vma by 64 bytes.
> If we reserved an 8 or 16 byte gap it wouldn't have helped.

Yep, we'd have to introduce v2, of course. And if tomorrow we switch
from maple tree to something else, we'd probably need another version
of iterator as well. I made no claims that padding will be a
future-proof approach, just a pragmatic mitigation of small reasonable
changes in a struct we can't control.

> Hence it's wishful thinking that a gap might help in the future.
>
> Direct stack alloc of kernel data structure is also dangerous in
> presence of kernel debug knobs. There are no locks inside vma_iterator
> at the moment, but if it was there we wouldn't be able to use it
> on bpf prog stack regardless of its size, because lockdep on/off
> would have changed the size.
> I think it's always better to have extra indirection between bpf prog
> and kernel object.

It's a tradeoff and I understand the pros and cons. Let's do mem_alloc
and see how that works in practice.

