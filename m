Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9C6A492C
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 19:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjB0SGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 13:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjB0SGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 13:06:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404193F4
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 10:05:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32596B80D90
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 18:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA961C4339B
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677521110;
        bh=Y0yUGTbEUJlxeUpIfGTE4X+1hGTjoy7DqKj9l8ZrW2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OfApYOvvCECT5LQMrKYOaHRyM0Af7otMaTUhelwcE3ARzMHJMTrPNMvV2VaznIKfK
         wyI1QG494JWgLiei5U5vDUHbz6dDrVQDvxjsi4Ir80u6EFEsUbG6GL+oNTPZKa474F
         lH6ywYuwBX43vE5QtxnE7jEbvIP93qOhU1ipIoVLJHn5IVTzwYPYTSNj9w52v+Z0rq
         RD40mj1ZF0ap8HEHImIa/h+qzDQ9yEwMvw4UClT1FyNyHutbBRz+sr7nidOu6YT2Hi
         6lRMasA2Ockb2D/UUUa33RdjDnseVhY9oCylrOu9v/wSJT3BlFYX2nLtjirpKvFrSn
         ph//YZ6YLTeeQ==
Received: by mail-ed1-f44.google.com with SMTP id cy6so29387394edb.5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 10:05:10 -0800 (PST)
X-Gm-Message-State: AO0yUKUxrPexULO/ZxZcgVRT3qEPEjRBK4EOqO+/09Uyh1mIGZK11ofV
        UH8ZS4x/Hxwdf3lBz3d/AOINQ/jnHKuz6DQm88tCGg==
X-Google-Smtp-Source: AK7set9xEaWHEOBJlsm9nV/6djrHeKW8eDbjxNAtgg14WVwi0fIKLCa+WrGloGguwsQ/iZbg/ZqQ1GFgCqGKX2SIRR0=
X-Received: by 2002:a17:906:13d9:b0:8de:c6a6:5134 with SMTP id
 g25-20020a17090613d900b008dec6a65134mr10797120ejc.15.1677521109012; Mon, 27
 Feb 2023 10:05:09 -0800 (PST)
MIME-Version: 1.0
References: <Y/P1yxAuV6Wj3A0K@google.com> <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
 <Y/czygarUnMnDF9m@google.com> <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
 <Y/hLsgSO3B+2g9iF@google.com> <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
 <Y/p0ryf5PcKIs7uj@google.com> <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
 <693dffd9571073a47820653fd2de863010491454.camel@gmail.com> <CAEf4BzYaiD27y=Y85xhrj+VOvJY_5q1oVtg-4vYmFZFEpmW+nQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYaiD27y=Y85xhrj+VOvJY_5q1oVtg-4vYmFZFEpmW+nQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 27 Feb 2023 19:04:58 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7tgbJqwUVxfGd4UKDUcOQjK8zsbEKUUjV79=xHQn1fFg@mail.gmail.com>
Message-ID: <CACYkzJ7tgbJqwUVxfGd4UKDUcOQjK8zsbEKUUjV79=xHQn1fFg@mail.gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org,
        andrii@kernel.org, acme@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 6:32=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 27, 2023 at 6:17 AM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >
> > On Sun, 2023-02-26 at 03:03 +0200, Eduard Zingerman wrote:
> > > On Sat, 2023-02-25 at 20:50 +0000, Matt Bobrowski wrote:
> > > > Sorry Eduard, I replied late last night although the email bounced =
due
> > > > to exceeding the mail char limit. Let's try attaching a compressed
> > > > variant of the requested files, which includes the compiled kernel'=
s
> > > > BTF and the kernel's config.
> > >
> > > Hi Matt,
> > >
> > > I tried using your config but still can't reproduce the issue.
> > > Will try to do it using debian 12 chroot tomorrow or on Monday.
> >
> > Hi Matt,
> >
> > Short update:
> > I've reproduced the issue with multiple STRUCT 'linux_binprm' BTF IDs
> > in Debian testing chroot, thank you for providing all details.
> > Attaching the instructions in the end of the email.
> > Need some time to analyze pahole behavior.
> >
>
> Try using [0] to pinpoint what actually is different between any two
> linux_binprm definitions. I've hacked up this "tool" last time I had
> to pinpoint where two BTF types diverge, maybe it will save you a bit
> of time as well. I'd like to put this functionality into btfdump
> ([1]), but I didn't get to it yet, unfortunately.
>

It's not just linux_binprm but a bunch of other structs (quite a lot
of them that seem to diverge)

[...]
WARN: multiple IDs found for 'sock_common': 4400, 53212 - using 4400
WARN: multiple IDs found for 'request_sock': 4458, 53257 - using 4458
WARN: multiple IDs found for 'task_struct': 265, 55830 - using 265
WARN: multiple IDs found for 'file': 474, 55854 - using 474
WARN: multiple IDs found for 'vm_area_struct': 480, 55857 - using 480
WARN: multiple IDs found for 'seq_file': 670, 55891 - using 670
WARN: multiple IDs found for 'sock': 3623, 55918 - using 3623
WARN: multiple IDs found for 'sk_buff': 3095, 56014 - using 3095
WARN: multiple IDs found for 'fib6_info': 8129, 56069 - using 8129
WARN: multiple IDs found for 'inode': 854, 56092 - using 854
WARN: multiple IDs found for 'path': 886, 56121 - using 886
WARN: multiple IDs found for 'cgroup': 913, 56130 - using 913
WARN: multiple IDs found for 'xdp_buff': 3838, 56558 - using 3838
WARN: multiple IDs found for 'socket': 3848, 56563 - using 3848
WARN: multiple IDs found for 'sock_common': 4400, 56890 - using 4400
WARN: multiple IDs found for 'request_sock': 4458, 56938 - using 4458
WARN: multiple IDs found for 'task_struct': 265, 58141 - using 265
WARN: multiple IDs found for 'inode': 854, 58153 - using 854
WARN: multiple IDs found for 'path': 886, 58182 - using 886
WARN: multiple IDs found for 'file': 474, 58207 - using 474
WARN: multiple IDs found for 'vm_area_struct': 480, 58210 - using 480
WARN: multiple IDs found for 'seq_file': 670, 58389 - using 670
WARN: multiple IDs found for 'task_struct': 265, 58862 - using 265
WARN: multiple IDs found for 'file': 474, 58889 - using 474
WARN: multiple IDs found for 'vm_area_struct': 480, 58892 - using 480
WARN: multiple IDs found for 'inode': 854, 58954 - using 854
WARN: multiple IDs found for 'path': 886, 58983 - using 886
WARN: multiple IDs found for 'cgroup': 913, 58992 - using 913
WARN: multiple IDs found for 'seq_file': 670, 59157 - using 670
WARN: multiple IDs found for 'sock': 3623, 59309 - using 3623
WARN: multiple IDs found for 'sk_buff': 3095, 59312 - using 3095
WARN: multiple IDs found for 'xdp_buff': 3838, 59699 - using 3838
WARN: multiple IDs found for 'socket': 3848, 59704 - using 3848
WARN: multiple IDs found for 'sock_common': 4400, 60021 - using 4400
WARN: multiple IDs found for 'request_sock': 4458, 60066 - using 4458
WARN: multiple IDs found for 'file': 474, 60890 - using 474
WARN: multiple IDs found for 'task_struct': 265, 60900 - using 265
WARN: multiple IDs found for 'vm_area_struct': 480, 60932 - using 480
WARN: multiple IDs found for 'inode': 854, 60962 - using 854
WARN: multiple IDs found for 'path': 886, 60991 - using 886
WARN: multiple IDs found for 'cgroup': 913, 61000 - using 913
WARN: multiple IDs found for 'seq_file': 670, 61174 - using 670
WARN: multiple IDs found for 'task_struct': 265, 62225 - using 265
WARN: multiple IDs found for 'file': 474, 62256 - using 474
WARN: multiple IDs found for 'vm_area_struct': 480, 62259 - using 480
WARN: multiple IDs found for 'seq_file': 670, 62289 - using 670
WARN: multiple IDs found for 'inode': 854, 62573 - using 854
WARN: multiple IDs found for 'path': 886, 62602 - using 886
[...]

  BTF     .btf.vmlinux.bin.o

seems to take 10+ minutes. Something seems off here, it seems like the
deduplication is failing for a lot of types which causes pahole to run
for so long.

My pahole is at:

431df45 ("btfdiff: Exclude Rust CUs since those are not yet being
converted to BTF on the Linux kernel")

Clang at:

9e5bfa1ae30b ("[AArch64] Add some tests for multiple uses of extended
vector extracts. NFC")

and kernel at:

68bfd65fb98d ("Merge branch 'move SYS() macro to test_progs.h and run
mptcp in a dedicated netns'")

and I am using the same config as vmtest.sh.

I was able to "fix" this with using clang 16.x and the following hacky paho=
le:

030e3b4 - core: Add DW_TAG_unspecified_type to tag__is_tag_type() set
(HEAD) (2023-02-26 Arnaldo Carvalho de Melo)
f20515b - dwarves: support DW_TAG_atomic_type (2023-02-26 David Lamparter)
de24234 - pahole: Prep 1.24 (tag: v1.24) (2022-08-22 Arnaldo Carvalho de Me=
lo)
d6c9528 - dwarf_loader: Encode char type as signed (2022-08-10 Yonghong Son=
g)

and the the following patch on top:

diff --git a/btf_encoder.c b/btf_encoder.c
index daa8e3b..3a29a67 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -939,6 +939,8 @@ static int btf_encoder__encode_tag(struct
btf_encoder *encoder, struct tag *tag,
                return btf_encoder__add_enum_type(encoder, tag, conf_load);
        case DW_TAG_subroutine_type:
                return btf_encoder__add_func_proto(encoder,
tag__ftype(tag), type_id_off);
+        case DW_TAG_unspecified_type:
+                return 0;
        default:
                fprintf(stderr, "Unsupported DW_TAG_%s(0x%x)\n",
                        dwarf_tag_name(tag->tag), tag->tag);
diff --git a/dwarves.h b/dwarves.h
index f18a639..b1dc556 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -544,10 +544,8 @@ static inline int tag__is_tag_type(const struct tag *t=
ag)
               tag->tag =3D=3D DW_TAG_reference_type ||
               tag->tag =3D=3D DW_TAG_restrict_type ||
               tag->tag =3D=3D DW_TAG_subroutine_type ||
-              tag->tag =3D=3D DW_TAG_unspecified_type ||
               tag->tag =3D=3D DW_TAG_volatile_type ||
               tag->tag =3D=3D DW_TAG_atomic_type ||
-              tag->tag =3D=3D DW_TAG_unspecified_type ||
               tag->tag =3D=3D DW_TAG_LLVM_annotation;
 }

Now this is not a clean build and still has errors like:

tag__recode_dwarf_type: couldn't find 0xe82f542 type for 0xe82f4d2 (subprog=
ram)!
tag__recode_dwarf_type: couldn't find 0xe82f542 type for 0xe82f4e2 (subprog=
ram)!




>   [0] https://github.com/libbpf/libbpf-bootstrap/tree/btfdiff-hack
>   [1] https://github.com/anakryiko/btfdump
>
>
> > Thanks,
> > Eduard
> >
> > --
> >
> > host root:
> >   mkdir bookworm
> >   sudo debootstrap testing bookworm/ http://deb.debian.org/debian/
> >   sudo mount -t proc proc bookworm/proc/
> >   sudo mount -t sysfs sys bookworm/sys/
> >   sudo chroot bookworm/ /bin/bash
> >
>
> [...]
