Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EB330B7E6
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 07:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhBBGim (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 01:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhBBGim (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 01:38:42 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB99CC061573
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 22:38:01 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id b187so5302268ybg.9
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 22:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YEf0Amtm3lnVH2MmDiZ+tSnIhYu3zY4teEPv79Lv28o=;
        b=pQ7y8C5ZUr9BWHr8pH0cZIlwzHc8H8XBtjrXx7MElmKOazdpC0K9Z2nT0H6peMPGQ9
         YbJybuAyrgwi2hSzqNG5Lzv4mVNk42O+zSAzSyPsMpLEQNnIdifTmFGg3c6PDAMo+Tj/
         q3xV/7PnBOJjpmRi1d0zV8EFP/2FaFKSfJSTgGsTLTNqsgOPndYU6uHNQgiF4GPiJqVz
         aCYYuaH/wBDbJAS92hSF4oDqTxVKkhArxtdEBIc3V8+Zyzwk/Hp+B75oUpj/79egxHnh
         ow86JHnAmWU5gziTK53lEBnN+1ruCRzeeSak1mmA9zvlNMaAX/UtyNfQxO7yGcuEBJNV
         slTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YEf0Amtm3lnVH2MmDiZ+tSnIhYu3zY4teEPv79Lv28o=;
        b=AlCLXYlyuSiUT1G9bA9WVQafji+bQx8CTSI4Wrb2wd4reu1UrO2x1O+M3CTVoaSMMl
         6BRi0yiL4ydmL07+uJ7ZVIZshQneu5UUsrdC8G2CBflIHnxkWMbdRQNfRL85g0tRNChf
         MC74QsLJEAa/3+89dSf4aRsnUL6gju5LFOut6pH1zFNfihmtwyl3uzl1790eQpS/qbWc
         wILPGa/LnX/6AwpleM/mrzoEIwLUcONQqQPeNSwLoLgnjE0FlEP4qjSNCeIIFaKWXcn6
         ht5TaoxS75I385GJtixVl+E4Hq6dS0Jk2zrsYQHA2W+vJh0njGjNvXos0Dcqr8JzRZ9L
         AAeg==
X-Gm-Message-State: AOAM532qXb8v2RQ/gV2oAFta0JxvKbo1UQvlKuD/bBF52oeXPKBLfSYR
        lCPmGb210Pomq5agGiCgsy4KKmuGMB6M59l8744=
X-Google-Smtp-Source: ABdhPJwfmKY1YGxPSJVgiuP2+AnxOI5X2uKGvBSlPZeT18Ar7xtlZHZS4/7R1fzzSvK4z6FdEGOaWF38HRgh1OqkBv4=
X-Received: by 2002:a5b:3c4:: with SMTP id t4mr19100890ybp.510.1612247881142;
 Mon, 01 Feb 2021 22:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20210112075525.256820-1-kpsingh@kernel.org> <20210112075525.256820-2-kpsingh@kernel.org>
 <CAEf4BzbeWCTSDorWwuC+B9SVw7xGj+5jfAMyw7LzBU_XShk5ZQ@mail.gmail.com> <CACYkzJ7-1phMCVR4Ctf6RkTwEs_RZDvs=jUQt72x2Ud_opmT-Q@mail.gmail.com>
In-Reply-To: <CACYkzJ7-1phMCVR4Ctf6RkTwEs_RZDvs=jUQt72x2Ud_opmT-Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Feb 2021 22:37:50 -0800
Message-ID: <CAEf4BzYBAKNRvGCweY0NyDQ751ChB4QKt41cVbU+VRTsDAcpGg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/3] bpf: update local storage test to check
 handling of null ptrs
To:     KP Singh <kpsingh@kernel.org>
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

On Sun, Jan 31, 2021 at 5:09 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Thu, Jan 28, 2021 at 2:46 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jan 11, 2021 at 11:55 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > It was found in [1] that bpf_inode_storage_get helper did not check
> > > the nullness of the passed owner ptr which caused an oops when
> > > dereferenced. This change incorporates the example suggested in [1] i=
nto
> > > the local storage selftest.
> > >
> > > The test is updated to create a temporary directory instead of just
> > > using a tempfile. In order to replicate the issue this copied rm bina=
ry
> > > is renamed tiggering the inode_rename with a null pointer for the
> > > new_inode. The logic to verify the setting and deletion of the inode
> > > local storage of the old inode is also moved to this LSM hook.
> > >
> > > The change also removes the copy_rm function and simply shells out
> > > to copy files and recursively delete directories and consolidates the
> > > logic of setting the initial inode storage to the bprm_committed_cred=
s
> > > hook and removes the file_open hook.
> > >
> > > [1]: https://lore.kernel.org/bpf/CANaYP3HWkH91SN=3DwTNO9FL_2ztHfqcXKX=
38SSE-JJ2voh+vssw@mail.gmail.com
> > >
> > > Suggested-by: Gilad Reti <gilad.reti@gmail.com>
> > > Acked-by: Yonghong Song <yhs@fb.com>
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> >
> > Hi KP,
> >
> > I'm getting a compilation warning when building selftests. Can you
> > please take a look and send a fix? Thanks!
> >
> > /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_l=
ocal_storage.c:
> > In function =E2=80=98test_test_local_storage=E2=80=99:
> > /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_l=
ocal_storage.c:143:52:
> > warning: =E2=80=98/copy_of_rm=E2=80=99 directive output may be truncate=
d writing 11
> > bytes into a region of size between 1 and 64 [-Wformat-truncation=3D]
> >   143 |  snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm"=
,
> >       |                                                    ^~~~~~~~~~~
> > /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_l=
ocal_storage.c:143:2:
> > note: =E2=80=98snprintf=E2=80=99 output between 12 and 75 bytes into a =
destination of
> > size 64
> >   143 |  snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm"=
,
> >       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> >   144 |    tmp_dir_path);
> >       |    ~~~~~~~~~~~~~
> >
>
> I don't seem to get this warning, so maybe we are using different compile=
rs.
>
> Mine is gcc 10.2.1 20201224 (from debian)

Funny enough, but I can't repro it locally anymore. I have gcc 10.2.0.
But your suggested fix below does look like a correct one, so feel
free to send it over, thanks!

>
> That said, I understand why it's complaining, it's for something that
> cannot really happen:
>
> tmp_dir_path cannot be 64 because we actually know its length so the
> tmp_exec_path cannot really overflow 64 bytes.
>
> Can you check if the following patch makes it go away?
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> index 3bfcf00c0a67..d2c16eaae367 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> @@ -113,7 +113,7 @@ static bool check_syscall_operations(int map_fd, int =
obj_fd)
>
>  void test_test_local_storage(void)
>  {
> -       char tmp_dir_path[64] =3D "/tmp/local_storageXXXXXX";
> +       char tmp_dir_path[] =3D "/tmp/local_storageXXXXXX";
>         int err, serv_sk =3D -1, task_fd =3D -1, rm_fd =3D -1;
>         struct local_storage *skel =3D NULL;
>         char tmp_exec_path[64];
>
> If so, I can send you a fix.
>
> - KP
>
> >
> > >  .../bpf/prog_tests/test_local_storage.c       | 96 +++++------------=
--
> > >  .../selftests/bpf/progs/local_storage.c       | 62 ++++++------
> > >  2 files changed, 61 insertions(+), 97 deletions(-)
> > >
> >
> > [...]
