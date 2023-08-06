Return-Path: <bpf+bounces-7101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B367715A8
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 16:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3646D1C20974
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808495245;
	Sun,  6 Aug 2023 14:34:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031B28EF
	for <bpf@vger.kernel.org>; Sun,  6 Aug 2023 14:34:07 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D9A1B3
	for <bpf@vger.kernel.org>; Sun,  6 Aug 2023 07:34:05 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63c70dc7ed2so26789016d6.0
        for <bpf@vger.kernel.org>; Sun, 06 Aug 2023 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691332444; x=1691937244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnWPeteNFBR42Mf7auTDYOmuwtBIgbuYmQVKtoXSUsw=;
        b=CV8seiTI9/QnBehMbVTHBz6TsFrvuUMY/8gviilINa53hMZF5CzmrgDK0Qh8FUX5jQ
         D+HbliMnFd9iKBexPvZLl1kHLshL0+PfZJ3toFzv4iMuSozRPC/gY60dqNGRwqLkogO3
         WH/ymI8ovOdcJWS1JcReLAIEGb0JByvlUiCbUuRX6Zhw9b367FSt199AzflyFKO1JGCb
         5EbDUqVJq1tadPI3V5Est32XIR1xCkO68Y6B3bSZXPtSxyPXLu3F3sOc4NnChde+oFd9
         I6fOWcnTOkK9nbG9hoya4FAjuqVVmS3zFvxvSY5ZbjxmiQP/FzLbr3rfefYvKKO1lz63
         8QOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691332444; x=1691937244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnWPeteNFBR42Mf7auTDYOmuwtBIgbuYmQVKtoXSUsw=;
        b=GgZF1kciPmNnkcowD4XvRxRBwqDfuhGvjTAygYkThDhnE8ApbJm3FzOZvEqY8u8SBX
         6sUD/QxlzHLTXcUweJfcKtb11wUJPRg6GkMrN1xJK+X/8S2E7GbZdctortgqIM+qGked
         dmLpY/x0805wZD9Ad7iy4bx1KawFIqoJ8TArNAlwSByk36ZsQpNboB1ZN0v1cDRPGFzL
         Z0zqp1IoB1+nRxGqa3j9TBfuUrOohNJav3VKS4xIO//o+KXIf7HV4ezReB289nqZqls3
         puibhYrWEMhLRIe8uQciBM3E+9RAcAz83mlw2jdPYMAFK8cJJHBhNhGt5jr4pzWUsTYZ
         tPPA==
X-Gm-Message-State: AOJu0Yzv4tT5En+V5zLRAjnUcoa5KnF0A8B09a58u7ud65guC3bRqSk1
	bxxxtatV1sGT4ujX1IoYEQUDNUYHTLvXorQoWF8=
X-Google-Smtp-Source: AGHT+IF44PhbZoz4kjcDcuRX8z0+z8ylQ6gWxGl/C08oQyO34EW+RePKVlVyYBmXyPteO+Nwz+hpLkkrk8pRs6mx7sw=
X-Received: by 2002:ad4:514b:0:b0:628:2e08:78b7 with SMTP id
 g11-20020ad4514b000000b006282e0878b7mr7832891qvq.31.1691332444093; Sun, 06
 Aug 2023 07:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804105732.3768-1-laoar.shao@gmail.com> <20230804105732.3768-3-laoar.shao@gmail.com>
 <ZM6p+++fSnKrEYM5@krava>
In-Reply-To: <ZM6p+++fSnKrEYM5@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 6 Aug 2023 22:33:28 +0800
Message-ID: <CALOAHbC68vUTL-N1mPqqt1-O42ME7o+Q5j0AmwWtTS6hkADAcg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add selftest for fill_link_info
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 6, 2023 at 3:58=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, Aug 04, 2023 at 10:57:32AM +0000, Yafang Shao wrote:
>
> SNIP
>
> > +
> > +static void kprobe_fill_invalid_user_buffer(int fd)
> > +{
> > +     struct bpf_link_info info;
> > +     __u32 len =3D sizeof(info);
> > +     int err;
> > +
> > +     memset(&info, 0, sizeof(info));
> > +
> > +     info.perf_event.kprobe.func_name =3D 0x1; /* invalid address */
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, -EINVAL, "invalid_buff_and_len");
> > +
> > +     info.perf_event.kprobe.name_len =3D 64;
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, -EFAULT, "invalid_buff");
> > +
> > +     info.perf_event.kprobe.func_name =3D 0;
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, -EINVAL, "invalid_len");
> > +
> > +     ASSERT_EQ(info.perf_event.kprobe.addr, 0, "func_addr");
> > +     ASSERT_EQ(info.perf_event.kprobe.offset, 0, "func_offset");
> > +     ASSERT_EQ(info.perf_event.type, 0, "type");
> > +}
> > +
> > +static void test_kprobe_fill_link_info(struct test_fill_link_info *ske=
l,
> > +                                    enum bpf_perf_event_type type,
> > +                                    bool retprobe, bool invalid)
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts,
> > +             .attach_mode =3D PROBE_ATTACH_MODE_LINK,
> > +             .retprobe =3D retprobe,
>
> you could got rid of the retprobe argument and just do
>
>                 .retprobe =3D retprobe =3D=3D BPF_PERF_EVENT_KRETPROBE,

good point. will change it and the others.

>
>
> > +     );
> > +     ssize_t offset =3D 0, entry_offset =3D 0;
> > +     int link_fd, err;
> > +     long addr;
> > +
> > +     skel->links.kprobe_run =3D bpf_program__attach_kprobe_opts(skel->=
progs.kprobe_run,
> > +                                                              KPROBE_F=
UNC, &opts);
> > +     if (!ASSERT_OK_PTR(skel->links.kprobe_run, "attach_kprobe"))
> > +             return;
> > +
> > +     link_fd =3D bpf_link__fd(skel->links.kprobe_run);
> > +     addr =3D ksym_get_addr(KPROBE_FUNC);
> > +     if (!invalid) {
> > +             /* See also arch_adjust_kprobe_addr(). */
> > +             if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
> > +                     entry_offset =3D 4;
> > +             err =3D verify_perf_link_info(link_fd, type, addr, offset=
, entry_offset);
> > +             ASSERT_OK(err, "verify_perf_link_info");
> > +     } else {
> > +             kprobe_fill_invalid_user_buffer(link_fd);
> > +     }
> > +     bpf_link__detach(skel->links.kprobe_run);
> > +}
> > +
> > +static void test_tp_fill_link_info(struct test_fill_link_info *skel)
> > +{
> > +     int link_fd, err;
> > +
> > +     skel->links.tp_run =3D bpf_program__attach_tracepoint(skel->progs=
.tp_run, TP_CAT, TP_NAME);
> > +     if (!ASSERT_OK_PTR(skel->links.tp_run, "attach_tp"))
> > +             return;
> > +
> > +     link_fd =3D bpf_link__fd(skel->links.tp_run);
> > +     err =3D verify_perf_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT,=
 0, 0, 0);
> > +     ASSERT_OK(err, "verify_perf_link_info");
> > +     bpf_link__detach(skel->links.tp_run);
> > +}
> > +
> > +static void test_uprobe_fill_link_info(struct test_fill_link_info *ske=
l,
> > +                                    enum bpf_perf_event_type type, ssi=
ze_t offset,
> > +                                    bool retprobe)
> > +{
> > +     int link_fd, err;
> > +
> > +     skel->links.uprobe_run =3D bpf_program__attach_uprobe(skel->progs=
.uprobe_run, retprobe,
> > +                                                         0, /* self pi=
d */
> > +                                                         UPROBE_FILE, =
offset);
>
> same here with 'type =3D=3D BPF_PERF_EVENT_URETPROBE'
>
>
> > +     if (!ASSERT_OK_PTR(skel->links.uprobe_run, "attach_uprobe"))
> > +             return;
> > +
> > +     link_fd =3D bpf_link__fd(skel->links.uprobe_run);
> > +     err =3D verify_perf_link_info(link_fd, type, 0, offset, 0);
> > +     ASSERT_OK(err, "verify_perf_link_info");
> > +     bpf_link__detach(skel->links.uprobe_run);
> > +}
> > +
>
> SNIP
>
> > +
> > +static void test_kprobe_multi_fill_link_info(struct test_fill_link_inf=
o *skel,
> > +                                          bool retprobe, bool buffer)
> > +{
> > +     LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> > +     const char *syms[KMULTI_CNT] =3D {
> > +             "schedule_timeout_interruptible",
> > +             "schedule_timeout_uninterruptible",
> > +             "schedule_timeout_idle",
> > +             "schedule_timeout_killable",
>
> nit, might be better to use some of the bpf_fentry_test[1-9] functions,
> also for KPROBE_FUNC

will use them instead.

>
> > +     };
> > +     __u64 addrs[KMULTI_CNT];
> > +     int link_fd, i, err =3D 0;
> > +
> > +     qsort(syms, KMULTI_CNT, sizeof(syms[0]), symbols_cmp_r);
> > +     opts.syms =3D syms;
> > +     opts.cnt =3D KMULTI_CNT;
> > +     opts.retprobe =3D retprobe;
> > +     skel->links.kmulti_run =3D bpf_program__attach_kprobe_multi_opts(=
skel->progs.kmulti_run,
> > +                                                                    NU=
LL, &opts);
> > +     if (!ASSERT_OK_PTR(skel->links.kmulti_run, "attach_kprobe_multi")=
)
> > +             return;
> > +
> > +     link_fd =3D bpf_link__fd(skel->links.kmulti_run);
> > +     for (i =3D 0; i < KMULTI_CNT; i++)
> > +             addrs[i] =3D ksym_get_addr(syms[i]);
> > +
> > +     if (!buffer)
> > +             err =3D verify_kmulti_link_info(link_fd, addrs, retprobe)=
;
> > +     else
> > +             verify_kmulti_user_buffer(link_fd, addrs);
>
> verify_kmulti_user_buffer is actually what you call 'invalid' in other
> tests right? seems better to keep it in here unless I miss something

will rename it.

--=20
Regards
Yafang

