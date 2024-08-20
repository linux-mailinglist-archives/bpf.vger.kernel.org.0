Return-Path: <bpf+bounces-37568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8419957B9B
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 04:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0802E1C23BD3
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 02:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7F53C6BA;
	Tue, 20 Aug 2024 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKb3SxO3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4521C6B4
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724122118; cv=none; b=YmkUAhZ2fpKCHe/timcYyr5CVDXsVhVPhkH/7Xc8q3H4EbGlKN58IfYZfoPk+p1sJEEEp4kmwWdcQcwaMLviQCJ93RouvlwuTrZg+cp5YhKwNRpDl225wGz2VxvUQRIwblouNEfwYYPT4lQ7tvBVFy32cH+lkHgpgwb22JMPsbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724122118; c=relaxed/simple;
	bh=dQhZZ0KeTuit/aqgSK1Lr2JFQeav8+er/i+b6ODsc1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXXEqcp3yp59ddoyYkRbmPNwDAKDA6F8DL/6l6d7qkneeojvzbd1I9ThQ+bOK35P51dTjqu8pZoBA5+1mfIHyTdk4NUq+6ptrvljmzlmSB3OIVKaupIjVZCIlEWPH0D/hJbc1RIt8vr2h7xZb9GNiHp6JYHnL29BiZf/wxdVlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKb3SxO3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-710e39961f4so3339262b3a.3
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 19:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724122116; x=1724726916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQVDjq6CgHsnnJdjT1AofPJkpdoSCbNfIa8jMztiWRk=;
        b=HKb3SxO3O8gMGOrJhKmLKUknRoxvspaCTMVL0nSseP+ZY/vIy9wXISrV1xgu1YHX0z
         n1ZVe9XgixdyaPLJL60seHR5rOlbgSS+kHJWGo/K0oqU7RcGdojAe89vHL9lujJ97ZtL
         QXId01Cv/LCmQO60L7PD8DlrwDtM3vcLIHwRg6TFd8Wanx72DSSnTykURVHuLlzG3lxf
         aSiq82OeaB+DycIPLhIYRdmpz32kXeums1ZiEjYwn+9KdZ+ItY1ykYx8ilNF1eX3S+LB
         v7rF1UO1AZGOJ8XWnflPUxuAzrMTx6Pn7xGI35sZL6Ksc3qItoVhsTHOjBGRaHh6BhrU
         cNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724122116; x=1724726916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQVDjq6CgHsnnJdjT1AofPJkpdoSCbNfIa8jMztiWRk=;
        b=hrF5GWgNR72e/X+Po0WXTk2EHyoGYO8bmciyveICI95yR9Zi9Vcqua6nxF3sgKxA1R
         irPka+YFRWdugP20Tutplt9sGpFPRBFq5GyhWT8iix8EnaSP8JZdPixhng+S4GVB1X1V
         SCvRdFHtvVCp5H4WOl9dCc/RGJS8f/ZVc/6HeBVl2c/78iyKgZZLkhkemdZBhoaFL6mS
         /qfCvQNXhcr4clCdrwXSoV/A0qEmX2h+EJw0ZKACDRPZ4DSSm/fAU4CxKf+VNtkXzaSX
         4onWa5Irp3Kyu6AbeOjGHAt4Ip/MKkxID/Teg3bwokAH8Ksvfc8j3YnzwPsVZ/cPgZNF
         cbCg==
X-Forwarded-Encrypted: i=1; AJvYcCWH1BmP41GrIN1CnM64yUA2g8gIukHxV8A62mzavMjKn/UBAcZq+3G42+1q/7m7SElRWAUICXUIs33SaPHuoIpd+Ixn
X-Gm-Message-State: AOJu0Yz8I/66GEuPtWPaT86uTmuk2oa3bwkFTLHIfYEvGvWCEpRMcJCD
	WoMG0xdwvjiaMBM1tj+ycORcsmsep03clzBro8cc2ioYDNa3eOLcoh/QBai43DOVdVXdsbKCAF9
	V69O0DOiOZRt8TUiwli+Sf/XVDlA=
X-Google-Smtp-Source: AGHT+IGJohGgbXDRrzkb4nWxpOsxjuN7bDZR4tVs/MIS1z17p97NNDvjUALp8nGaHWMPv34k1lpAgBQ5z03o6JAyb1E=
X-Received: by 2002:a05:6a20:43a9:b0:1bd:2214:e92f with SMTP id
 adf61e73a8af0-1c904f89a10mr12608906637.14.1724122115804; Mon, 19 Aug 2024
 19:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172398527264.293426.2050093948411376857.stgit@devnote2>
 <2b4d25f8fa99ae5a329f5164b6c79b81f1a4cc78688dcf5470d601f3612264ea@mail.kernel.org>
 <20240819095807.171eade07ba02ae871e4c4aa@kernel.org> <MN2PR15MB34883ABBB55D78B4E15758EDAD8C2@MN2PR15MB3488.namprd15.prod.outlook.com>
 <20240820101727.3631125acf3c98c7bc7050db@kernel.org>
In-Reply-To: <20240820101727.3631125acf3c98c7bc7050db@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Aug 2024 19:48:23 -0700
Message-ID: <CAEf4BzaTn=thAkznx3UHyevgtTQG=hGfW54EWDGR8PHyQk91WA@mail.gmail.com>
Subject: Re: [PATCH v13 00/20] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Daniel Xu <dlxu@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	"bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>, kernel-ci <kernel-ci@meta.com>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+bpf

On Mon, Aug 19, 2024 at 6:17=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Mon, 19 Aug 2024 15:56:39 +0000
> Daniel Xu <dlxu@meta.com> wrote:
>
> > [sorry for outlook top post]
> >
> > Hi Masami,
> >
> > test_progs is checked into kernel tree. There should be source files in=
 selftests
> > for the test names. For example, for fill_link_info/kprobe_multi_invali=
d_ubuff
> > failure:
> >
> > $ find . -name "*fill_link_info*"
> > ./tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > ./tools/testing/selftests/bpf/progs/test_fill_link_info.c
> >
> > veristat I'm less famiiar with. My understanding is that it checks for =
verifier
> > regressions. Skimming your patchset, it's not obvious to me why verifie=
r
> > would regress. If you have issues debugging that, we can poke Andrii fo=
r
> > help.
>
> Thanks for the information! Hmm, maybe kprobe_multi_testmod_check might c=
heck the
> register which is not supported on the ftrace_regs. But I also don't have=
 any idea

This test is getting IP of the function using bpf_get_func_ip()
helper. If that somehow started returning wrong value on arm64/s390x,
then the test will basically not find expected addresses

> about veristat. Is that also checks all pt_regs? Andrii, do you have any =
idea?

I wouldn't worry about veristat, your changes shouldn't regress BPF
verifier logic, so it's probably just an artifact of our BPF CI setup.
The above test regression seems much more worrying.


>
> Thank you,
>
> >
> > Thanks,
> > Daniel
> >
> >
> > ________________________________
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Sent: Sunday, August 18, 2024 5:58 PM
> > To: bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org>
> > Cc: kernel-ci <kernel-ci@meta.com>; andrii@kernel.org <andrii@kernel.or=
g>; daniel@iogearbox.net <daniel@iogearbox.net>; martin.lau@linux.dev <mart=
in.lau@linux.dev>
> > Subject: Re: [PATCH v13 00/20] tracing: fprobe: function_graph: Multi-f=
unction graph and fprobe on fgraph
> >
> > Hi,
> >
> > Where can I get the test programs? I would like to check what the progr=
ams
> > actually expected.
> >
> > On Sun, 18 Aug 2024 13:51:30 +0000 (UTC)
> > bot+bpf-ci@kernel.org wrote:
> >
> > > Dear patch submitter,
> > >
> > > CI has tested the following submission:
> > > Status:     FAILURE
> > > Name:       [v13,00/20] tracing: fprobe: function_graph: Multi-functi=
on graph and fprobe on fgraph
> > > Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?seri=
es=3D880630&state=3D*
> > > Matrix:     https://github.com/kernel-patches/bpf/actions/runs/104407=
99833
> > >
> > > Failed jobs:
> > > test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions=
/runs/10440799833/job/28911439106
> > > test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bp=
f/actions/runs/10440799833/job/28911439234
> > > test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions/r=
uns/10440799833/job/28911405063
> > > test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/=
actions/runs/10440799833/job/28911404959
> > > veristat-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/ru=
ns/10440799833/job/28911401263
> > >
> > > First test_progs failure (test_progs-aarch64-gcc):
> > > #126 kprobe_multi_testmod_test
> > > serial_test_kprobe_multi_testmod_test:PASS:load_kallsyms_local 0 nsec
> > > #126/1 kprobe_multi_testmod_test/testmod_attach_api_syms
> > > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe=
_test1_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe=
_test2_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe=
_test3_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kre=
tprobe_test1_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kre=
tprobe_test2_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kre=
tprobe_test3_result: actual 0 !=3D expected 1
> > > #126/2 kprobe_multi_testmod_test/testmod_attach_api_addrs
> > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe=
_test1_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe=
_test2_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe=
_test3_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kre=
tprobe_test1_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kre=
tprobe_test2_result: actual 0 !=3D expected 1
> > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kre=
tprobe_test3_result: actual 0 !=3D expected 1
> > >
> > >
> > > Please note: this email is coming from an unmonitored mailbox. If you=
 have
> > > questions or feedback, please reach out to the Meta Kernel CI team at
> > > kernel-ci@meta.com.
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

