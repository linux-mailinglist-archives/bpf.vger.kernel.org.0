Return-Path: <bpf+bounces-4036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7154074819A
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608401C20B07
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 10:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D474C94;
	Wed,  5 Jul 2023 10:00:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116753AD
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:00:31 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C01721;
	Wed,  5 Jul 2023 03:00:28 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-635ee3baa14so35961766d6.3;
        Wed, 05 Jul 2023 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688551227; x=1691143227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58WibkHCpM1g4Xv7IPG2CbSP0uwlzOiSxeXSrtGZ2QI=;
        b=jLmS3By4Uk8wvVrVR0iMC4JBN83wyfdOOZCirCNW452Ksx9aoieyV6Ow+TL9/IBv57
         BThHpnwKgjKFNE+jevcHresT9SyCIIi98/hFffoyrxwNmnlelCWzIooVQBrKzKIuudUB
         M/tUh/cO2mlDlSbmDM9Yu1EW9e7cffDaRk6h/rNPb7nUlaa98D5BG/E7XWV96xjpDutn
         kcMjPoa3F2Qqg3uOUryu8wntP0+62vzjvBUH6uUa1Rga92XTm6gIvqIuPpsOrkJpmy51
         GI46TLj25Mrb5O4O8J1oJidTHJuj8LvE0KAqIUyw2qNHH62adRWHeK5ZktWzQ6aaAQt4
         +dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688551227; x=1691143227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58WibkHCpM1g4Xv7IPG2CbSP0uwlzOiSxeXSrtGZ2QI=;
        b=BD/aAvedXLmYvE/jFykNYxAeYQezqaThM5V4hZ46U/XJwNRnKYZ8rEvwZPNMUZUEjH
         lrDX3I0WOWlEnqp+KwKR5W/CaF9wCI4ZKyR8x6fvV9IrxvqzdvxBcmzsz1zfGe5Pxv1+
         /HtrrS8kotivX9UpKk7A0Dqp2EATQe9SrSrtf3wTJR5EfB+4dA9lNRbskpvoK1su3E3G
         PQ2owbZx2dkl99kWGJJTaqKBrUa6C8juDyX88LshIfnwharoix4LMp9vwfKPD7ma6CA7
         s56HoSkNgWPAipvHbh3cQCSd4teft3f5DWFeyt+P92t8ha5ie0W6YwPSU8oHS8Hym4u3
         yEag==
X-Gm-Message-State: ABy/qLbYDbom+QxINTPvASZaIJjZHOZF6rj+lI9Bmn6g1aFScB+GtsaH
	F1olvsCOGA7G1DFjuOnFOu2iwrEg9UFRZV804JM=
X-Google-Smtp-Source: APBJJlHbjJ0KtQnrRqix7O9o3Obrijhc4aClnXpFV3U73jGJ3dViep2SN2wyQ9+Islw9E6+1boQrYz1eNjxXwC3Ba8s=
X-Received: by 2002:a0c:efc6:0:b0:635:e696:b322 with SMTP id
 a6-20020a0cefc6000000b00635e696b322mr13179846qvt.35.1688551227338; Wed, 05
 Jul 2023 03:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-4-laoar.shao@gmail.com>
 <0097aac1-c15c-8752-b087-32b2144e9d79@iogearbox.net>
In-Reply-To: <0097aac1-c15c-8752-b087-32b2144e9d79@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 5 Jul 2023 17:59:50 +0800
Message-ID: <CALOAHbA12SX1j4H3BSObWtPtyLn5axuWiuO8Vp8ePuDpnmZ=9Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 03/11] bpftool: Show kprobe_multi link info
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 4:09=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 6/28/23 1:53 PM, Yafang Shao wrote:
> > Show the already expose kprobe_multi link info in bpftool. The result a=
s
> > follows,
> >
> > $ tools/bpf/bpftool/bpftool link show
> > 91: kprobe_multi  prog 244
> >          kprobe.multi  func_cnt 7
> >          addr             func [module]
> >          ffffffff98c44f20 schedule_timeout_interruptible
> >          ffffffff98c44f60 schedule_timeout_killable
> >          ffffffff98c44fa0 schedule_timeout_uninterruptible
> >          ffffffff98c44fe0 schedule_timeout_idle
> >          ffffffffc075b8d0 xfs_trans_get_efd [xfs]
> >          ffffffffc0768a10 xfs_trans_get_buf_map [xfs]
> >          ffffffffc076c320 xfs_trans_get_dqtrx [xfs]
> >          pids kprobe_multi(188367)
> > 92: kprobe_multi  prog 244
> >          kretprobe.multi  func_cnt 7
> >          addr             func [module]
> >          ffffffff98c44f20 schedule_timeout_interruptible
> >          ffffffff98c44f60 schedule_timeout_killable
> >          ffffffff98c44fa0 schedule_timeout_uninterruptible
> >          ffffffff98c44fe0 schedule_timeout_idle
> >          ffffffffc075b8d0 xfs_trans_get_efd [xfs]
> >          ffffffffc0768a10 xfs_trans_get_buf_map [xfs]
> >          ffffffffc076c320 xfs_trans_get_dqtrx [xfs]
> >          pids kprobe_multi(188367)
> >
> > $ tools/bpf/bpftool/bpftool link show -j
> > [{"id":91,"type":"kprobe_multi","prog_id":244,"retprobe":false,"func_cn=
t":7,"funcs":[{"addr":18446744071977586464,"func":"schedule_timeout_interru=
ptible","module":null},{"addr":18446744071977586528,"func":"schedule_timeou=
t_killable","module":null},{"addr":18446744071977586592,"func":"schedule_ti=
meout_uninterruptible","module":null},{"addr":18446744071977586656,"func":"=
schedule_timeout_idle","module":null},{"addr":18446744072643524816,"func":"=
xfs_trans_get_efd","module":"xfs"},{"addr":18446744072643578384,"func":"xfs=
_trans_get_buf_map","module":"xfs"},{"addr":18446744072643592992,"func":"xf=
s_trans_get_dqtrx","module":"xfs"}],"pids":[{"pid":188367,"comm":"kprobe_mu=
lti"}]},{"id":92,"type":"kprobe_multi","prog_id":244,"retprobe":true,"func_=
cnt":7,"funcs":[{"addr":18446744071977586464,"func":"schedule_timeout_inter=
ruptible","module":null},{"addr":18446744071977586528,"func":"schedule_time=
out_killable","module":null},{"addr":18446744071977586592,"func":"schedule_=
timeout_uninterruptible","module":null},{"addr":18446744071977586656,"func"=
:"schedule_timeout_idle","module":null},{"addr":18446744072643524816,"func"=
:"xfs_trans_get_efd","module":"xfs"},{"addr":18446744072643578384,"func":"x=
fs_trans_get_buf_map","module":"xfs"},{"addr":18446744072643592992,"func":"=
xfs_trans_get_dqtrx","module":"xfs"}],"pids":[{"pid":188367,"comm":"kprobe_=
multi"}]}]
> >
> > When kptr_restrict is 2, the result is,
> >
> > $ tools/bpf/bpftool/bpftool link show
> > 91: kprobe_multi  prog 244
> >          kprobe.multi  func_cnt 7
> > 92: kprobe_multi  prog 244
> >          kretprobe.multi  func_cnt 7
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
>
> Mainly small nits, but otherwise series lgtm, thanks for improving the vi=
sibility!

Will change them in the next version. Thanks for your review.

--=20
Regards
Yafang

