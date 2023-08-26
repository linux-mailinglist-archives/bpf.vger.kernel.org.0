Return-Path: <bpf+bounces-8730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E9B789384
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 04:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F301C20F71
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 02:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0D7FB;
	Sat, 26 Aug 2023 02:50:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E47E
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 02:50:43 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1631FF5
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:50:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bba6fc4339so21326181fa.2
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693018240; x=1693623040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wTqqKh1RxCPmtFll7X9hrVX2424fdu6/KnWRrlZW+8=;
        b=qQQ4PZuT7ttNXD6QVA+FL9Hg2X5UEiLCxgwq2UoUy37GGAYwMANf1awW32ivM2p3wS
         8rUKYZjmUueVyYV5SNhbxcqX76RAGUUiEk8ZDxY6H8NRCM4EIuTmJstvelowl6evksR+
         b1OTO41tJypDRdLe3PK57Z8L/VQkChJE+Ibb3GCwDAuJ+n3u8SUvpp5voziaHNdA75Lh
         dylTDowVzwV4s7ZrGWBYN54QDbbCLtwtZyhVsU/wqsW5scy4eDbmqgDHSXkfU3QblVTQ
         5p0GZyqC0e6fNgL6znBMNCD0W8LIVO6RNfMN1l17dXDtW6XlmtyFPztYx/AbC2Kuq675
         Yufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693018240; x=1693623040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wTqqKh1RxCPmtFll7X9hrVX2424fdu6/KnWRrlZW+8=;
        b=Ji2+eM4Jw3gdG8kvfHcuHzsWW+geRseRKi60VG8pvmRTpZG+kI0Kf1YXFWGtBpiOtj
         jDHU+WKoxummJWQ0eBrobJIzjzR9T2zBg0Hyih/6o3h3puwVSLiLPyr4pKkXEGArJ+Ck
         +QrTcvqTOu8hNTUXkwn2WwbeUzYN63+DtSA8urGAhk/KAzZhVAcvzBoW0/NNqp5eyxqO
         KoVWaW63jTObqnQiyusgmhVtOfTsjwClkKj13AaZmJTqDsxvib2Bn6YStIFnvbrHw9ic
         5UvKqbv4nyRSB93oW6tSKQMXk7IVdei0+0pMEJr2SoSbfziHHd+CLA2nTEzYmgVhNkmI
         t8DA==
X-Gm-Message-State: AOJu0YyDFPDuSnB5fGwSV/J2GADLweicDQjkUr0H48pOgkxmf++5z1ES
	+mNsgEPfY2ihPIPM29cz2rRkgC/FCoF/saTSlN8=
X-Google-Smtp-Source: AGHT+IG0/V+6Rw/3YIWiTfWB5yduZo/U8fECOVoDvkTbRwcp+8OmaAAoesR08BpxExLGbS1jCJFwuBU43a3M95+oYNw=
X-Received: by 2002:a2e:958b:0:b0:2bc:f5d3:1021 with SMTP id
 w11-20020a2e958b000000b002bcf5d31021mr2013004ljh.32.1693018239962; Fri, 25
 Aug 2023 19:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822133807.3198625-1-houtao@huaweicloud.com>
 <20230822133807.3198625-2-houtao@huaweicloud.com> <CAADnVQKFh9pWp1abrG2KKiZanb+4rzRb3HmzX0snggah3Lq-yg@mail.gmail.com>
 <bf4faa34-019c-bb3d-a451-a067bbe027a4@huaweicloud.com> <CAADnVQJfpxk3dsjYdH8DUarJHu0wFXa24XFxvn+F5mseMKTAhQ@mail.gmail.com>
 <3c30289a-d683-d1c8-b18d-c87a5ecebe3b@huaweicloud.com> <CAADnVQLHPx-0dR7nBXAfBHOpF09Jr6+cqGjfGf9mT2BHCid5YA@mail.gmail.com>
 <5fe435aa-526f-4b54-b0d2-e0ae1c6c234c@huaweicloud.com> <CAADnVQLtJBOTueuGZHM0PUhskMZY-uaaehvgfx7pkpq0qfhvVA@mail.gmail.com>
 <a6a78ccf-4a48-be46-f2c7-aa0a5a3285d8@huaweicloud.com> <CAADnVQ+NyR-d-P3fdw14ehy2fficAhPikJ2ZrQi1Db-yGNTiCQ@mail.gmail.com>
 <189f54aa-7b5f-f223-c340-1548aec55ab2@huaweicloud.com>
In-Reply-To: <189f54aa-7b5f-f223-c340-1548aec55ab2@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Aug 2023 19:50:28 -0700
Message-ID: <CAADnVQKgnO2dp4frO+QTYLMFjHnc=YqcgfGEFi_SapNMGGYaHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Enable preemption after
 irq_work_raise() in unit_alloc()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 7:22=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
>
> On 8/26/2023 1:16 AM, Alexei Starovoitov wrote:
> > On Thu, Aug 24, 2023 at 11:04=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >>> Could you try the following:
> >>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >>> index 9c49ae53deaf..ee8262f58c5a 100644
> >>> --- a/kernel/bpf/memalloc.c
> >>> +++ b/kernel/bpf/memalloc.c
> >>> @@ -442,7 +442,10 @@ static void bpf_mem_refill(struct irq_work *work=
)
> >>>
> >>>  static void notrace irq_work_raise(struct bpf_mem_cache *c)
> >>>  {
> >>> -       irq_work_queue(&c->refill_work);
> >>> +       if (!irq_work_queue(&c->refill_work)) {
> >>> +               preempt_disable_notrace();
> >>> +               preempt_enable_notrace();
> >>> +       }
> >>>  }
> >>>
> >>> The idea that it will ask for resched if preemptible.
> >>> will it address the issue you're seeing?
> >>>
> >>> .
> >> No. It didn't work.
> > why?
>
> Don't know the extra reason. It seems preempt_enable_notrace() inovked
> in the preemption task doesn't return the CPU back to the preempted
> task. Will add some debug info to check that.
> >
> >> If you are concerning about the overhead of
> >> preempt_enabled_notrace(), we could use local_irq_save() and
> >> local_irq_restore() instead.
> > That's much better.
> > Moving local_irq_restore() after irq_work_raise() in process ctx
> > would mean that irq_work will execute immediately after local_irq_resto=
re()
> > which would make bpf_ma to behave like sync allocation.
> > Which is the ideal situation. preempt disable/enable game is more fragi=
le.
>
> OK. So you are OK to wrap the whole implementation of unit_alloc() and
> unit_free() by local_irq_saved() and local_irq_restore(), right ?

You don't need to wrap it. Just need to move local_irq_restore()
in unit_alloc/unit_free/unit_free_rcu couple lines down.

