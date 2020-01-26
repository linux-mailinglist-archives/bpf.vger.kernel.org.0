Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67B11498B1
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2020 05:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgAZELC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 23:11:02 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46327 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728842AbgAZELC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 25 Jan 2020 23:11:02 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E73544128;
        Sat, 25 Jan 2020 23:11:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 25 Jan 2020 23:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:to:cc
        :subject:from:message-id; s=fm2; bh=MgNAa/447vzoa3FkIs8Gfzp8Dpl/
        CHPupsfPjijOvV4=; b=gNz5sfww5+UvF7/Rpwy6y/MuJVrI3o8dAv3UMJHTIZlz
        prsCliZNgLl7elDb84S1NXPc3OcgbgfwcvFGMGQtGcPmvEIsjUTm2VeRdo+njmyq
        Nb66POnu+mmP0n4eL4aq880/+cGwOOayMHrQ9lVH5FjHQ2bW3JyJ5n7AZxxrW17d
        4j3kfJKR6CgZCM/6RgoxUOEhT9IKnJuLHjldb865szfMojiSpue/dGLhjKWwKLjH
        hSOSqVU6y9QW24wMb+ypde+k/0GMEB6Wa+Bu1vnLhtjJMs/22lL//3Y1Y9uCOo4n
        a/Xhzm0BZR+P0p26EJp9HAKl2jzHN30Bln1x8dsOzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MgNAa/
        447vzoa3FkIs8Gfzp8Dpl/CHPupsfPjijOvV4=; b=p/LY0Th8Oqbo45jPfa2lRf
        NtEN1vFEG2vXWoLvhAL7pOA21x1nAWlHQ8qUBGpwOMI+QrpEDKP4qaWqgoUSZdQe
        S/yrmwkLzFRu8O/Og4ishQH+DcmIHpIhM8Wqeb9j6enzy8770Oz2bGVISDxBro7D
        0ze+Hr3FXsGJsYCrrd6+pyXDIAYUfqD8WOW3eepVz6a0wDKDuaNRUM4Rktboz1Oy
        sOxKjYz7vZ9hHGXQhF260rTONO9yrscFk4T2gu51hrHFCBbic4sQbNF6zmaqYX+w
        GF542cdGlQQbyyNUV6TAUzyYXYbE+D4VpSV66+e/0NsSXqjIrOaC/qoDu/af8H+w
        ==
X-ME-Sender: <xms:VBEtXuGQ5jgFGpjnD5wUAlxgW-cpXIPXDw9IYXaCZpTYJFzCAjbEog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdekgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepgfgtjgffvffuhffksehtqhertddttdejnecu
    hfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqnecuff
    homhgrihhnpehlkhhmlhdrohhrghenucfkphepjeefrdduiedvrddvvddrudeltdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiii
X-ME-Proxy: <xmx:VBEtXtzmMmD2jFHci88Pij5lT_l9BZdbjDmpFYGJoENWGZzA3bqaqA>
    <xmx:VBEtXvR6Ukvrpsm9Gq_A-UFAvWiZijjQCEraAxKNMlPRNPJJMU3Tdw>
    <xmx:VBEtXrpGwM86STu-pbM1wqgnz3lYCTEDyVusQ2DiWX6QHhiBjB-P6g>
    <xmx:VBEtXgEhFsh1JpJcEWmw4RR1zEPgcgMVWynb7oLJSSBdWDGyymUGPw>
Received: from localhost (c-73-162-22-190.hsd1.ca.comcast.net [73.162.22.190])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E02B3067181;
        Sat, 25 Jan 2020 23:10:59 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAADnVQ+Gy_Ph+83TLJkqtLM_pC2g65NhpX2vOwBH
 =JM3To2Thw@mail.gmail.com>
Originaldate: Sat Jan 25, 2020 at 6:53 PM
Originalfrom: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Original: =?utf-8?q?On_Sat,_Jan_25,_2020_at_2:32_PM_Daniel_Xu_<dxu@dxuuu.xyz>_wrote?=
 =?utf-8?q?:=0D=0A>_+_______attr.type_=3D_PERF=5FTYPE=5FHARDWARE;=0D=0A>_+?=
 =?utf-8?q?_______attr.config_=3D_PERF=5FCOUNT=5FHW=5FCPU=5FCYCLES;=0D=0A>?=
 =?utf-8?q?_+_______attr.freq_=3D_1;=0D=0A>_+_______attr.sample=5Ffreq_=3D?=
 =?utf-8?q?_4000;=0D=0A>_+_______attr.sample=5Ftype_=3D_PERF=5FSAMPLE=5FBR?=
 =?utf-8?q?ANCH=5FSTACK;=0D=0A>_+_______attr.branch=5Fsample=5Ftype_=3D_PE?=
 =?utf-8?q?RF=5FSAMPLE=5FBRANCH=5FUSER_|_PERF=5FSAMPLE=5FBRANCH=5FANY;=0D?=
 =?utf-8?q?=0A>_+_______pfd_=3D_syscall(=5F=5FNR=5Fperf=5Fevent=5Fopen,_&a?=
 =?utf-8?q?ttr,_-1,_0,_-1,_PERF=5FFLAG=5FFD=5FCLOEXEC);=0D=0A>_+_______if_?=
 =?utf-8?q?(CHECK(pfd_<_0,_"perf=5Fevent=5Fopen",_"err_%d\n",_pfd))=0D=0A>?=
 =?utf-8?q?_+_______________goto_out=5Fdestroy;=0D=0A=0D=0AIt's_failing_fo?=
 =?utf-8?q?r_me_in_kvm._Is_there_way_to_make_it_work=3F=0D=0ACIs_will_be_v?=
 =?utf-8?q?m_based_too._If_this_test_requires_physical_host=0D=0Asuch_test?=
 =?utf-8?q?_will_keep_failing_in_all_such_environments.=0D=0AFolks_will_be?=
 =?utf-8?q?_annoyed_and_eventually_will_disable_the_test.=0D=0ACan_we_figu?=
 =?utf-8?q?re_out_how_to_test_in_the_vm_from_the_start=3F=0D=0A?=
Date:   Sat, 25 Jan 2020 20:10:57 -0800
To:     "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc:     "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Kernel Team" <kernel-team@fb.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: Re: [PATCH v5 bpf-next 2/2] selftests/bpf: add
 bpf_read_branch_records() selftest
From:   "Daniel Xu" <dxu@dxuuu.xyz>
Message-Id: <C05FGIY6DS21.3FOPNFKMT6EWK@dlxu-fedora-R90QNFJV>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat Jan 25, 2020 at 6:53 PM, Alexei Starovoitov wrote:
> On Sat, Jan 25, 2020 at 2:32 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > +       attr.type =3D PERF_TYPE_HARDWARE;
> > +       attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
> > +       attr.freq =3D 1;
> > +       attr.sample_freq =3D 4000;
> > +       attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
> > +       attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_USER | PERF_SAMP=
LE_BRANCH_ANY;
> > +       pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FL=
AG_FD_CLOEXEC);
> > +       if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
> > +               goto out_destroy;
>
>=20
> It's failing for me in kvm. Is there way to make it work?
> CIs will be vm based too. If this test requires physical host
> such test will keep failing in all such environments.
> Folks will be annoyed and eventually will disable the test.
> Can we figure out how to test in the vm from the start?

It seems there's a patchset that's adding LBR support to guest hosts:
https://lkml.org/lkml/2019/8/6/215 . However it seems to be stuck in
review limbo. Is there anything we can do to help that set along?

As far as hacking it, nothing really comes to mind. Seems that patchset
is our best hope.
