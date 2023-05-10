Return-Path: <bpf+bounces-298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304AF6FE19F
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 17:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B111C20938
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F01642F;
	Wed, 10 May 2023 15:34:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9BE125B8
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:34:08 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EBB10F7
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 08:34:05 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7577ef2fa31so1129457485a.0
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683732844; x=1686324844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHDFd1mTUa+grVCC1D/5io1ry2X8endiTklzjNbs/P8=;
        b=IR9af4p0/Qaj/Xi7kbpQW/VL1Cr8zaNdEdX9zl3UNaXqairvMC0Bc1umn2ymRvybr4
         he9UykLcVgLx8kZ/SB3wxp20E6cNbqiT1wLRZhEnVVQHk59lJRqQFPIy1f279mbywo2j
         AyamDTjL2sQtQs7T0OpcI7OT+tdho4adaRQC3IHyc7NVTi2s/Mihv0iQh0jbs4SYiaZ+
         WUM72EdyQrHO8LbGMyhIGZ/v6Gi98flbgJkXTJDr4Gdqj0AHI/44c6wjvXOi4E6UdflS
         IF7rqcjYU0UTORNFBPzDrMaVH4KIyMCio42KQiYr1Lj2X2dsmZiEA1g+uedNv7Ttebaq
         zkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683732844; x=1686324844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHDFd1mTUa+grVCC1D/5io1ry2X8endiTklzjNbs/P8=;
        b=ST25FkT9aFZVdN6SxONzFjo/xOIIWTi7S8QBvENcvzIUSUKcg5ZefTRJMZU4iAS8W6
         PfmuOYf08xqm8Hd9TKJIezxfM3DXtjN2OfPK3Z6X+gvj9S8IK0VFpuimyDAB+K1P3q4y
         80Riaw3JyT/iVJroDeruewhcld6/Q55lyEPHh9I9+bEfmAXaWVnQ8aj7rcV/ne9hGVtF
         mcbBaaPWSlS3Xm2h7GtcY8TEJafGyQpwDkhE61xA6MzzpBZ4uhIiHAAUC0AsDyOZyMQ4
         maoZ4/L057vUM9EIEn9HYoea1aHPcybT5IrJlWgGObA4ruiC2ok5Q5yXWv8VGs34PpkS
         u9mw==
X-Gm-Message-State: AC+VfDx7DxbxDX9ony2umcxaY/edV1k+zOm7ofSMX4hitl/8uHoXO6zp
	sFQiZVbkKN7/Em4tiEefDJbBclyhOL4lkBqCaTQ=
X-Google-Smtp-Source: ACHHUZ6fwtZuuTYmduTqQKsjiDT0aCO82QE4QgmeIieWIE4kmEa6jiPy9qrzHMAqGkWdcjY8h7IIPSzYdoBbLPjvH7I=
X-Received: by 2002:ad4:5ecf:0:b0:619:90cd:4a99 with SMTP id
 jm15-20020ad45ecf000000b0061990cd4a99mr28257719qvb.3.1683732844227; Wed, 10
 May 2023 08:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509151511.3937-1-laoar.shao@gmail.com> <20230509151511.3937-3-laoar.shao@gmail.com>
 <CAPhsuW6qXXgGkp1DVvHEQCVHvM=yw8nFFhA8LLHgCazwyaoXhA@mail.gmail.com>
 <CALOAHbCZfCbGP-gaVKnG_9HGkbVnArCn+EcqweGtA8+wRmJDvQ@mail.gmail.com> <CAPhsuW55iK4i_dYsbszkqAdDz4gpwgWU4LATw3Tzj9O63GfOmA@mail.gmail.com>
In-Reply-To: <CAPhsuW55iK4i_dYsbszkqAdDz4gpwgWU4LATw3Tzj9O63GfOmA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 May 2023 23:33:21 +0800
Message-ID: <CALOAHbAKEU7Q1LySsotjJ9yPD3E4rSjvXg2ToM=F34dR_2oBmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Show total linked progs cnt instead of
 selector in trampoline ksym
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 2:30=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, May 9, 2023 at 7:56=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Wed, May 10, 2023 at 1:43=E2=80=AFAM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > On Tue, May 9, 2023 at 8:15=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > After commit e21aa341785c ("bpf: Fix fexit trampoline."), the selec=
tor
> > > > is only used to indicate how many times the bpf trampoline image ar=
e
> > > > updated and been displayed in the trampoline ksym name. After the
> > > > trampoline is freed, the count will start from 0 again.
> > > > So the count is a useless value to the user, we'd better
> > > > show a more meaningful value like how many progs are linked to this
> > > > trampoline. After that change, the selector can be removed eventall=
y.
> > > > If the user want to check whether the bpf trampoline image has been=
 updated
> > > > or not, the user can also compare the address. Each time the trampo=
line
> > > > image is updated, the address will change consequently.
> > >
> > > I wonder whether this will cause confusion to some users. Maybe the s=
aving
> > > doesn't worth the churn.
> >
> > The trampoline ksym name as such:
> > ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]
> >
> > I don't know what the user may use the selector for. It seems that the
> > selector is meaningless. While the cnt of linked progs can really help
> > users, with which the user can easily figure out how many progs are
> > linked to a kernel function.
>
> Hmm, agreed that the chance to break user space is low. Maybe we can just
> remove it? IOW, only keep bpf_trampoline_6442453466
>

Agree. I will do it as you suggested.

--=20
Regards
Yafang

