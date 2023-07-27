Return-Path: <bpf+bounces-6082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3D67655EC
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 16:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810D32822F3
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408EA17757;
	Thu, 27 Jul 2023 14:27:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07997171AB
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 14:27:52 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9859AB4
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:27:51 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76ad8892d49so92129485a.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690468071; x=1691072871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smAAMWPKU6WsX9XDYok9RgE2GXaOTtvMCbXQYV3XDb0=;
        b=Bq7V3Hpe4RE/pKCCyj+Ln+nDuNzNL1QbTu0yVo3rdPioV7vT2tMuCv5X5QA2YkOrsL
         OOn8JqF5a3DnSzH6GaIUiX8Z8FpvFZCEbQWUgfsstIrTVJGueqnynqlA7OJZVetLC+Zp
         ioSxIeZKXhowHOIxFhgUdD+nRHIJL0fA+nY9IZi26mr9yXHGCgxvJIivSW87moQx/7tI
         4DjIIXJeg1PziRxVTAZ79ceR90QHSwE+hC372mgQhwqNrPm/omwbqT3QbFqzDN6CD3P5
         SuWRjzmNxE6Odo3w1FOE54SNZRzKqIfqHntG+ifCsZKR2E0dnPhmMGdxeGUQ5P4kFHr4
         wT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690468071; x=1691072871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smAAMWPKU6WsX9XDYok9RgE2GXaOTtvMCbXQYV3XDb0=;
        b=iz5d5vo9IVQqFhRBQxrF/R7jRwVIcEd4nHI/iD9CmXO2W/2/BgBE2nEE2Y8Z4oKvlc
         P6yUcDK/sxf6Rn3n8Vm5/DX3up2dBu1/t2pmIuW1YNrzEaGY6e6UUzatQH4MV1I6sa4m
         S+yHGBEDw7fZdLm92qLiBXoBcsxI88m75etmb2A3eptFZPq9OhSmR1SA8h4cHrXaYdDZ
         tYvVKXQ+3JPSMfJs9B73k9RxKRZ2Wvla4RcLTqsEVxmz6deR6g6ND8yBha2iXNEcPvWd
         JWC5ndporo4n9xgu/0P9v7e3ZRQo9Ym/sBD/GqZ6yRX16GI+iPhDsQB3sLQfwDsoZZRe
         LW9A==
X-Gm-Message-State: ABy/qLaDaPj0z/ZZRquj+COgnmijCJqaCbbYGedCR4/plgrpJIPeAXC/
	w+YQxX0cg4a2ZDtSQqelxA7Lo/tyZdSF6KHzBn4=
X-Google-Smtp-Source: APBJJlFtnh+iqCHqjyO2hcxXpyt2Otl+2kZ1UWK+joS0LvXkq7SZGYsrIojdsGNN/6pVmGd/dGhXoMYVbMzMcGXRpfk=
X-Received: by 2002:a0c:b391:0:b0:63c:f979:b810 with SMTP id
 t17-20020a0cb391000000b0063cf979b810mr131135qve.46.1690468070619; Thu, 27 Jul
 2023 07:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727114309.3739-1-laoar.shao@gmail.com> <20230727114309.3739-3-laoar.shao@gmail.com>
 <ZMJ1+22ByZfWrL8I@krava>
In-Reply-To: <ZMJ1+22ByZfWrL8I@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 27 Jul 2023 22:27:14 +0800
Message-ID: <CALOAHbD-sh56bW+t_ggyKEu-Pisodkvi_a07ovUG1eL7P1aGmg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftest for fill_link_info
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 9:49=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jul 27, 2023 at 11:43:09AM +0000, Yafang Shao wrote:
>
> SNIP
>
> > +static int verify_link_info(int fd, enum bpf_perf_event_type type, lon=
g addr, ssize_t offset)
> > +{
> > +     struct bpf_link_info info;
> > +     __u32 len =3D sizeof(info);
> > +     char buf[PATH_MAX];
> > +     int err =3D 0;
> > +
> > +     memset(&info, 0, sizeof(info));
> > +     buf[0] =3D '\0';
> > +
> > +again:
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     if (!ASSERT_OK(err, "get_link_info"))
> > +             return -1;
> > +
> > +     switch (info.type) {
> > +     case BPF_LINK_TYPE_PERF_EVENT:
> > +             if (!ASSERT_EQ(info.perf_event.type, type, "perf_type_mat=
ch"))
> > +                     return -1;
> > +
> > +             switch (info.perf_event.type) {
> > +             case BPF_PERF_EVENT_KPROBE:
> > +             case BPF_PERF_EVENT_KRETPROBE:
> > +                     ASSERT_EQ(info.perf_event.kprobe.offset, offset, =
"kprobe_offset");
> > +
> > +                     /* In case kptr setting is not permitted or MAX_S=
YMS is reached */
> > +                     if (addr) {
> > +                             long addrs[2] =3D {
> > +                                     addr + offset,
> > +                                     addr + 0x4, /* For ENDBDR */
> > +                             };
> > +
> > +                             ASSERT_IN_ARRAY(info.perf_event.kprobe.ad=
dr, addrs, "kprobe_addr");
>
> we have check for IBT in get_func_ip_test, it might be easier
> to use the same in here as well and do the exact check

Thanks for your information!
will change it.

>
> we wouldn't need the ASSERT_IN_ARRAY then and would be correct
> wrt other archs
>
>
> SNIP
>
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
> > +     if (!ASSERT_OK_PTR(skel->links.uprobe_run, "attach_uprobe"))
> > +             return;
> > +
> > +     link_fd =3D bpf_link__fd(skel->links.uprobe_run);
> > +     if (!ASSERT_GE(link_fd, 0, "link_fd"))
> > +             return;
> > +
> > +     err =3D verify_link_info(link_fd, type, 0, offset);
> > +     ASSERT_OK(err, "verify_link_info");
> > +     bpf_link__detach(skel->links.uprobe_run);
> > +}
> > +
> > +void serial_test_fill_link_info(void)
>
> why does it need to be serial?

Ah, it can run in parallel. will change it.

>
> > +{
> > +     struct test_fill_link_info *skel;
> > +     ssize_t offset;
> > +
> > +     skel =3D test_fill_link_info__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "skel_open"))
> > +             goto cleanup;
> > +
> > +     /* load kallsyms to compare the addr */
> > +     if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
> > +             return;
> > +     if (test__start_subtest("kprobe_link_info"))
> > +             test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, f=
alse, false);
> > +     if (test__start_subtest("kretprobe_link_info"))
> > +             test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KRETPROBE=
, true, false);
> > +     if (test__start_subtest("fill_invalid_user_buff"))
> > +             test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, f=
alse, true);
> > +     if (test__start_subtest("tracepoint_link_info"))
> > +             test_tp_fill_link_info(skel);
> > +
> > +     offset =3D get_uprobe_offset(&uprobe_func);
> > +     if (test__start_subtest("uprobe_link_info"))
> > +             test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_UPROBE, o=
ffset, false);
> > +     if (test__start_subtest("uretprobe_link_info"))
> > +             test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_URETPROBE=
, offset, true);
>
> do you plan to add kprobe_multi link test as well?

will add it in the next version.

--=20
Regards
Yafang

