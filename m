Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9844E306AA9
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 02:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhA1BrK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 20:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhA1BrG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 20:47:06 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09398C061574
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 17:46:26 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id y128so3937514ybf.10
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 17:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=shCJg6LSx/ErJstFNURWZk0h4jbY1bIKw8OLMF7mzBY=;
        b=Hr4LDg/A1JnUsmUck6IiazeIE/QBInF0+ixwcsYG1+tKKiWAsyGlXzmGslaXJZd90D
         YeBf9udwBCpS4DvNlM61CiwepwMDfmk+oFWLASb+Vs01RYNFL3cYadaqs6dkqribR1H0
         9Ry0qAEGk6inDqTFIV+sgQF7833+brGlchte2LquzK1wurJJbqy9TU5ZGhJolv4HEGgN
         rrxD64gR6oVrhfhW2qlsnXOKDq9Ul9DfMR628j8U0TUOAUFDjc/Ae0TJX3pl56in9ZD6
         HPShwI9CzgC4cHHTzIzLnijap24pht7pq4rX03FbelmI5YDwat5mBizroUd05/XC9aaC
         AAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=shCJg6LSx/ErJstFNURWZk0h4jbY1bIKw8OLMF7mzBY=;
        b=pq6lXi+IoRk0wD6uV9/5ABPlt/8+DxNFsp6jGhRocsZH93hhS630yn+R7yZWm+67LZ
         iQr23UjT5CkUdHaMmf81a6Cz5QQnSXv1QrrBhUKsE+4V2a+z5WC49EiDC0QVOB5kJw//
         C3ZwSgGu6jghjIFG8MBZd1kclYQdheqouRtwQFYZTYG19FP0Teu96jHVNPV5rjAS921n
         nWGyoMVYxhXBLKhML8YceWGRD6J4l1T9BG24v75ZdcbWvY9PGHoGksBOMAkZyGTBAUjB
         5yvilRS5vt7OMbWcmC4YAStVy05MkW4d98+K+5TdlGna8n27s1PLG1Ta66uJZYLYS9/n
         7oFg==
X-Gm-Message-State: AOAM531s/97kdZvAwDla7nAfpV0CHAZdgKKvY9/ZMk28xP+owJ1ZdjZG
        osThqydDKb5AlDpVcfm1M1pnxlC+4eRoSGtvUqY=
X-Google-Smtp-Source: ABdhPJw3d9EMLAKGfCxnN5+yCPdPikKYnV/o6ARusSmPJs0ImlvoLyRJe5Lwdh8LMzh+fgscMawD9Wl0E83JLiUTCPM=
X-Received: by 2002:a25:b195:: with SMTP id h21mr20319844ybj.347.1611798385375;
 Wed, 27 Jan 2021 17:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20210112075525.256820-1-kpsingh@kernel.org> <20210112075525.256820-2-kpsingh@kernel.org>
In-Reply-To: <20210112075525.256820-2-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Jan 2021 17:46:14 -0800
Message-ID: <CAEf4BzbeWCTSDorWwuC+B9SVw7xGj+5jfAMyw7LzBU_XShk5ZQ@mail.gmail.com>
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

On Mon, Jan 11, 2021 at 11:55 PM KP Singh <kpsingh@kernel.org> wrote:
>
> It was found in [1] that bpf_inode_storage_get helper did not check
> the nullness of the passed owner ptr which caused an oops when
> dereferenced. This change incorporates the example suggested in [1] into
> the local storage selftest.
>
> The test is updated to create a temporary directory instead of just
> using a tempfile. In order to replicate the issue this copied rm binary
> is renamed tiggering the inode_rename with a null pointer for the
> new_inode. The logic to verify the setting and deletion of the inode
> local storage of the old inode is also moved to this LSM hook.
>
> The change also removes the copy_rm function and simply shells out
> to copy files and recursively delete directories and consolidates the
> logic of setting the initial inode storage to the bprm_committed_creds
> hook and removes the file_open hook.
>
> [1]: https://lore.kernel.org/bpf/CANaYP3HWkH91SN=3DwTNO9FL_2ztHfqcXKX38SS=
E-JJ2voh+vssw@mail.gmail.com
>
> Suggested-by: Gilad Reti <gilad.reti@gmail.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---

Hi KP,

I'm getting a compilation warning when building selftests. Can you
please take a look and send a fix? Thanks!

/data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_local=
_storage.c:
In function =E2=80=98test_test_local_storage=E2=80=99:
/data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_local=
_storage.c:143:52:
warning: =E2=80=98/copy_of_rm=E2=80=99 directive output may be truncated wr=
iting 11
bytes into a region of size between 1 and 64 [-Wformat-truncation=3D]
  143 |  snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
      |                                                    ^~~~~~~~~~~
/data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_local=
_storage.c:143:2:
note: =E2=80=98snprintf=E2=80=99 output between 12 and 75 bytes into a dest=
ination of
size 64
  143 |  snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  144 |    tmp_dir_path);
      |    ~~~~~~~~~~~~~


>  .../bpf/prog_tests/test_local_storage.c       | 96 +++++--------------
>  .../selftests/bpf/progs/local_storage.c       | 62 ++++++------
>  2 files changed, 61 insertions(+), 97 deletions(-)
>

[...]
