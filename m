Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C87309FDA
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 02:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhBABK1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jan 2021 20:10:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230439AbhBABKP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jan 2021 20:10:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B396064E13
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 01:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612141775;
        bh=v8hdjfkaJeu13zcoLKUsyWOunfGWz6z8ulip8vYEPS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oBb6GX01yW5hb4o10cUrCX5ZeTpjs6e1QXKZ2Q/0tsKgESEsFaOi0iZ+DLgNZOI3Z
         /P4Lh/Ak7Cebx7IsuCSLzJg9RE0jWp0is+5yo+Lq50jWk12ThVanSgmh4EzqAZrTEP
         3H9z7p2HuqmE93LOay8AeTkh0h6JFhv5Gbmb5PLTV38HEcFuLDj49MIXebBbvvCE4O
         b6DWFkqUGhZYYPh1pMXG5kdAIRgAtC/n/lF9bpd+PpzmZIP6bIFuP9zOoOWE0CSQa6
         mHQxrBmgGTQqP4NFG2Vuwxi2aiaPnpyEOc+lCSRmrfHfv2N1/i0VFK2dOgj0PAwCdr
         6s/P8pv/gn2Ug==
Received: by mail-lf1-f42.google.com with SMTP id a12so20504024lfb.1
        for <bpf@vger.kernel.org>; Sun, 31 Jan 2021 17:09:34 -0800 (PST)
X-Gm-Message-State: AOAM530xcRSY2ivX1qZMcOA/2kb9j4CYGc+TYGXrBG9bX2v8GTgbgcW8
        z0hSKM+ULhaq63gwhO0+LD2f67vgD9ojpuW667fXRw==
X-Google-Smtp-Source: ABdhPJytYY1tooBipQaVl4SYjXaYLRba3c4CZvyp1WXmDi/CaC1v6AymipEsxbHpg+y6684OS33AXHSL73gfl7oJzLM=
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr7630246lff.162.1612141773030;
 Sun, 31 Jan 2021 17:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20210112075525.256820-1-kpsingh@kernel.org> <20210112075525.256820-2-kpsingh@kernel.org>
 <CAEf4BzbeWCTSDorWwuC+B9SVw7xGj+5jfAMyw7LzBU_XShk5ZQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbeWCTSDorWwuC+B9SVw7xGj+5jfAMyw7LzBU_XShk5ZQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 1 Feb 2021 02:09:22 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7-1phMCVR4Ctf6RkTwEs_RZDvs=jUQt72x2Ud_opmT-Q@mail.gmail.com>
Message-ID: <CACYkzJ7-1phMCVR4Ctf6RkTwEs_RZDvs=jUQt72x2Ud_opmT-Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/3] bpf: update local storage test to check
 handling of null ptrs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Gilad Reti <gilad.reti@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 2:46 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 11, 2021 at 11:55 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > It was found in [1] that bpf_inode_storage_get helper did not check
> > the nullness of the passed owner ptr which caused an oops when
> > dereferenced. This change incorporates the example suggested in [1] int=
o
> > the local storage selftest.
> >
> > The test is updated to create a temporary directory instead of just
> > using a tempfile. In order to replicate the issue this copied rm binary
> > is renamed tiggering the inode_rename with a null pointer for the
> > new_inode. The logic to verify the setting and deletion of the inode
> > local storage of the old inode is also moved to this LSM hook.
> >
> > The change also removes the copy_rm function and simply shells out
> > to copy files and recursively delete directories and consolidates the
> > logic of setting the initial inode storage to the bprm_committed_creds
> > hook and removes the file_open hook.
> >
> > [1]: https://lore.kernel.org/bpf/CANaYP3HWkH91SN=3DwTNO9FL_2ztHfqcXKX38=
SSE-JJ2voh+vssw@mail.gmail.com
> >
> > Suggested-by: Gilad Reti <gilad.reti@gmail.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
>
> Hi KP,
>
> I'm getting a compilation warning when building selftests. Can you
> please take a look and send a fix? Thanks!
>
> /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_loc=
al_storage.c:
> In function =E2=80=98test_test_local_storage=E2=80=99:
> /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_loc=
al_storage.c:143:52:
> warning: =E2=80=98/copy_of_rm=E2=80=99 directive output may be truncated =
writing 11
> bytes into a region of size between 1 and 64 [-Wformat-truncation=3D]
>   143 |  snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
>       |                                                    ^~~~~~~~~~~
> /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_loc=
al_storage.c:143:2:
> note: =E2=80=98snprintf=E2=80=99 output between 12 and 75 bytes into a de=
stination of
> size 64
>   143 |  snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   144 |    tmp_dir_path);
>       |    ~~~~~~~~~~~~~
>

I don't seem to get this warning, so maybe we are using different compilers=
.

Mine is gcc 10.2.1 20201224 (from debian)

That said, I understand why it's complaining, it's for something that
cannot really happen:

tmp_dir_path cannot be 64 because we actually know its length so the
tmp_exec_path cannot really overflow 64 bytes.

Can you check if the following patch makes it go away?

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index 3bfcf00c0a67..d2c16eaae367 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -113,7 +113,7 @@ static bool check_syscall_operations(int map_fd, int ob=
j_fd)

 void test_test_local_storage(void)
 {
-       char tmp_dir_path[64] =3D "/tmp/local_storageXXXXXX";
+       char tmp_dir_path[] =3D "/tmp/local_storageXXXXXX";
        int err, serv_sk =3D -1, task_fd =3D -1, rm_fd =3D -1;
        struct local_storage *skel =3D NULL;
        char tmp_exec_path[64];

If so, I can send you a fix.

- KP

>
> >  .../bpf/prog_tests/test_local_storage.c       | 96 +++++--------------
> >  .../selftests/bpf/progs/local_storage.c       | 62 ++++++------
> >  2 files changed, 61 insertions(+), 97 deletions(-)
> >
>
> [...]
