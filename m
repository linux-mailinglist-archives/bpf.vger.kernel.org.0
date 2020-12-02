Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9E2CB22E
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 02:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgLBBSo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 20:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgLBBSo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 20:18:44 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F96C0613CF
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 17:18:03 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so229766lfh.2
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 17:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uw5zh1rNQN/Z4webefxWM3a8R1fLyuMfHBlEmJwb3hI=;
        b=IzSDzWnvK0SDNTd9G9tXvNqCcYYtqS4YZ0RiwxEGf0F2NWdCFfXARnhUIXuxEiZMEu
         RxACdEy2QVq88MkvXf5eoUjCpYNjZWA8VAm7MYaVL7IyTJGXKcvqQz/vyq4tVN3k2xVv
         lvu/a7Vc1riam41XznD8wW+wrrWTxqWhBXxBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uw5zh1rNQN/Z4webefxWM3a8R1fLyuMfHBlEmJwb3hI=;
        b=IAJ8wX9ccApvLnAUhyHmea8mFFHkXh8Ixe4v0UFitoeP+aE4hN/p2YeAyLRuEHHSEJ
         eSphjU7OvFG2QHqAEnYBOlw+ytsOjGvfa2B2t0l+7KM68KDXJ6pVy59hscFnVofkz1My
         gkM3ZN7jbCdJuxJNbPlFdoqyB/FBnmYQfGwCluZD0FCEpS+A0al1akEiXXoWqcIqRtpX
         0SwDhBsQeCfvqsIgJ1OgiqutVrXa2dff5n/uWkI7u9bUnXEq8j1mrZzMw/zjjmxYC6aX
         YEuVHfxUUV7vkGQwpm+g9S/loUQkF9bH93mltI1lB6TXQuQX1oLqhrxiXehsxcsdq/44
         szHA==
X-Gm-Message-State: AOAM530Ul03vS2nmFK+JvyNiM4zJyt0wKql7TImrhG9yxrUonZN0oclS
        c+wzK/6pK16OvY51foKn3xZxefW9Aflm/UIhXSMeVQ==
X-Google-Smtp-Source: ABdhPJwjZRGjkP7UDFQ0bfp248YcDmSIkit6x2Q6s4reH+LJ/ZAWM12/2Rl2j98X9kNHdQii2lk19HC/520pqrvZ2HQ=
X-Received: by 2002:ac2:51a4:: with SMTP id f4mr130872lfk.365.1606871881932;
 Tue, 01 Dec 2020 17:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20201201143924.2908241-1-kpsingh@chromium.org> <CAEf4BzZS9sfckQNqt1hsCV2QPWVGJZS=Xf83GYZO_Efz1oLOnw@mail.gmail.com>
In-Reply-To: <CAEf4BzZS9sfckQNqt1hsCV2QPWVGJZS=Xf83GYZO_Efz1oLOnw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 2 Dec 2020 02:17:51 +0100
Message-ID: <CACYkzJ53EWB53aYWva-uSWMO1jOevBXvB_AZ2+B=O-J34Y2H6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Update ima test helper's
 losetup commands
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 1, 2020 at 8:15 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 1, 2020 at 6:39 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Update the commands to use the bare minimum options so that it works
> > in busybox environments.
> >
> > Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  tools/testing/selftests/bpf/ima_setup.sh | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> > index 15490ccc5e55..ed29bde26a12 100755
> > --- a/tools/testing/selftests/bpf/ima_setup.sh
> > +++ b/tools/testing/selftests/bpf/ima_setup.sh
> > @@ -3,6 +3,7 @@
> >
> >  set -e
> >  set -u
> > +set -o pipefail
> >
> >  IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
> >  TEST_BINARY="/bin/true"
> > @@ -23,9 +24,10 @@ setup()
> >
> >          dd if=/dev/zero of="${mount_img}" bs=1M count=10
>
> This, and few more commands in this script, produce a bunch of output
> directly to stdout and stderr. Can you please silence it? If you need
> that output for debugging, than you can check verbosity mode in
> test_progs and pass extra parameters, if necessary.
>
>
> >
> > -        local loop_device="$(losetup --find --show ${mount_img})"
> > +        losetup -f "${mount_img}"
>
> This doesn't work :(
>
> [root@(none) selftests]# ./ima_setup.sh setup /tmp/ima_measurednsymal
> + set -e
> + set -u
> + set -o pipefail
> + IMA_POLICY_FILE=/sys/kernel/security/ima/policy
> + TEST_BINARY=/bin/true
> + main setup /tmp/ima_measurednsymal
> + [[ 2 -ne 2 ]]
> + local action=setup
> + local tmp_dir=/tmp/ima_measurednsymal
> + [[ ! -d /tmp/ima_measurednsymal ]]
> + [[ setup == \s\e\t\u\p ]]
> + setup /tmp/ima_measurednsymal
> + local tmp_dir=/tmp/ima_measurednsymal
> + local mount_img=/tmp/ima_measurednsymal/test.img
> + local mount_dir=/tmp/ima_measurednsymal/mnt
> ++ basename /bin/true
> + local copied_bin_path=/tmp/ima_measurednsymal/mnt/true
> + mkdir -p /tmp/ima_measurednsymal/mnt
> + dd if=/dev/zero of=/tmp/ima_measurednsymal/test.img bs=1M count=10
> 10+0 records in
> 10+0 records out
> 10485760 bytes (10.0MB) copied, 0.044713 seconds, 223.6MB/s
> + losetup -f /tmp/ima_measurednsymal/test.img
> losetup: /tmp/ima_measurednsymal/test.img: No such file or directory
> [root@(none) selftests]# ls -la /tmp/ima_measurednsymal/test.img
> -rw-r--r--    1 root     root      10485760 Dec  1 19:13
> /tmp/ima_measurednsymal/test.img
> [root@(none) selftests]# losetup -f /tmp/ima_measurednsymal/test.img
> losetup: /tmp/ima_measurednsymal/test.img: No such file or directory
>
>
> I have zero context on what IMA is and know nothing about loop
> devices, so can't really investigate much, sorry...
>

So after some debugging by using the same image as the bpf CI
we noticed the following needs to be done:

* SecurityFS needs to be mounted
* "integrity" should be in CONFIG_LSM
* mkfs.ext2 should be used instead of mkfs.ext4
* The second patch of the series does not work as the image does not have a
   /dev/disk/by-uuid directory.
* The test image does have a blkid command but it ignores the options passed to
   only print the UUID.

I will send the fixes and, for the future, we can:

* Document / script how to run selftests against the CI image
  (and possibly a few other pre-canned images) without need to setup or
  configure things like travis CI for each fork / developer.
* Use this before we send patches so that we can avoid similar
   troubles in the future.
