Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF9A6AFBEF
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 02:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHBPp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 20:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCHBPm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 20:15:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17323A6758
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 17:15:41 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o12so59705207edb.9
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 17:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678238139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh9cDOoKWwqZVEew9Lf8pQTDXDpkWcna3YvDfMjFP9Y=;
        b=p6UnU9LiimOSqXH2lnOyZLWj7Tf399eLpiUGy4eLoAX+O6lwUOQ1UpUMYzmOViGsB+
         /zKOCMq9vMlAxlY/H0AhkbZ/8cg8gm6pebh5diHs03gNeIfbbSJeju4ymhWajWQgmBdL
         dI0z0icRfDVnfdurgV290u8VHPPYjBfhNFFt3yJWp0gzzihqiQkN/8tiL6W6YcwUSI+H
         OS83w42tg53+XIX9GA6sSQ0Pn7Efvfflp7st5k4mmOjLsq+1QeXn/yKZ6n20wcCneSZ1
         CMXpGP4IUS7Yad9v5dwfJL+XydWmVmEyLb4Ko1G4sF34EGsuyxqXRCDNlss/vTKYQUv5
         DQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vh9cDOoKWwqZVEew9Lf8pQTDXDpkWcna3YvDfMjFP9Y=;
        b=Xd4S+3v8tRW5DLiufu6JGSocPDSqGi9xUuh6zMr2Hx5EDhwhvgQyeIX5MCT0+jrLnI
         ujUnk/xjKBGEzyjbsq/b37grU8pQJrWhLfWs4H2sFNp6q7ceuoOnnUoyrO2zB+6jTNNh
         6jg5IQi1UEUvUHBTKNRVDUEf3LrrDEw75dprqAy2V+aonBfCHnOfY2+VULYAKAeC6uG3
         jEBaomzzDe2B0S4vtLubhN+SAsHstpIMMjGmVdlGzL/viFfnB7bpnr7cuUIpbl3H36eZ
         2cECnmx8R8pkZRdCBo/i8hmxM9BVOItJnW/+lrkw7n33nFjaJ/e/48UjG7FhkFpDTGVW
         KSMQ==
X-Gm-Message-State: AO0yUKVsWZ76bEmpYbklsz8t64oEGfCPBaLH7CLJrlxRHFhg54+Wso0h
        RIRZGuIfPQV3yf0f0mkOzVh9r/IvKRmM4POVYyY=
X-Google-Smtp-Source: AK7set9bPAw4pveJxm/pGBZquNS3LCO04MbPInG6QuDceZ7C6c+gcEgF+4Q4KvTfceJIuIlOUewUOBhJrbXYKcnHnvw=
X-Received: by 2002:a17:907:970b:b0:8b1:3540:7632 with SMTP id
 jg11-20020a170907970b00b008b135407632mr12105547ejc.2.1678238139522; Tue, 07
 Mar 2023 17:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20230306084216.3186830-1-martin.lau@linux.dev> <20230306084216.3186830-15-martin.lau@linux.dev>
In-Reply-To: <20230306084216.3186830-15-martin.lau@linux.dev>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 17:15:27 -0800
Message-ID: <CAEf4BzYn4CMhNLko5E1HmhP5BeeeVWeUqWzbOjuDcbSgo4nBTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 14/16] selftests/bpf: Replace CHECK with ASSERT
 in test_local_storage
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 6, 2023 at 12:43=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> This patch migrates the CHECK macro to ASSERT macro.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Thanks for the cleanup!

>  .../bpf/prog_tests/test_local_storage.c       | 49 +++++++------------
>  1 file changed, 19 insertions(+), 30 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> index 9c77cd6b1eaf..c33f840f4880 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> @@ -13,8 +13,6 @@
>  #include "network_helpers.h"
>  #include "task_local_storage_helpers.h"
>
> -static unsigned int duration;
> -
>  #define TEST_STORAGE_VALUE 0xbeefdead
>
>  struct storage {
> @@ -60,36 +58,32 @@ static bool check_syscall_operations(int map_fd, int =
obj_fd)
>
>         /* Looking up an existing element should fail initially */
>         err =3D bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0=
);
> -       if (CHECK(!err || errno !=3D ENOENT, "bpf_map_lookup_elem",
> -                 "err:%d errno:%d\n", err, errno))
> +       if (!ASSERT_ERR(err, "bpf_map_lookup_elem") ||
> +           !ASSERT_EQ(errno, ENOENT, "errno"))

all libbpf APIs since v1.0 always return actual error number directly,
so no need to check errno anymore, you can simplify this further

>                 return false;
>
>         /* Create a new element */
>         err =3D bpf_map_update_elem(map_fd, &obj_fd, &val, BPF_NOEXIST);
> -       if (CHECK(err < 0, "bpf_map_update_elem", "err:%d errno:%d\n", er=
r,
> -                 errno))
> +       if (!ASSERT_OK(err, "bpf_map_update_elem"))
>                 return false;
>
>         /* Lookup the newly created element */
>         err =3D bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0=
);
> -       if (CHECK(err < 0, "bpf_map_lookup_elem", "err:%d errno:%d", err,
> -                 errno))
> +       if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
>                 return false;
>
>         /* Check the value of the newly created element */
> -       if (CHECK(lookup_val.value !=3D val.value, "bpf_map_lookup_elem",
> -                 "value got =3D %x errno:%d", lookup_val.value, val.valu=
e))
> +       if (!ASSERT_EQ(lookup_val.value, val.value, "bpf_map_lookup_elem"=
))
>                 return false;
>
>         err =3D bpf_map_delete_elem(map_fd, &obj_fd);
> -       if (CHECK(err, "bpf_map_delete_elem()", "err:%d errno:%d\n", err,
> -                 errno))
> +       if (!ASSERT_OK(err, "bpf_map_delete_elem()"))
>                 return false;
>
>         /* The lookup should fail, now that the element has been deleted =
*/
>         err =3D bpf_map_lookup_elem_flags(map_fd, &obj_fd, &lookup_val, 0=
);
> -       if (CHECK(!err || errno !=3D ENOENT, "bpf_map_lookup_elem",
> -                 "err:%d errno:%d\n", err, errno))
> +       if (!ASSERT_ERR(err, "bpf_map_lookup_elem") ||
> +           !ASSERT_EQ(errno, ENOENT, "errno"))

same here and probably in other places (I haven't checked everything)

>                 return false;
>
>         return true;
> @@ -104,35 +98,32 @@ void test_test_local_storage(void)
>         char cmd[256];
>
>         skel =3D local_storage__open_and_load();
> -       if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
> +       if (!ASSERT_OK_PTR(skel, "skel_load"))
>                 goto close_prog;
>
>         err =3D local_storage__attach(skel);
> -       if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
> +       if (!ASSERT_OK(err, "attach"))
>                 goto close_prog;
>
>         task_fd =3D sys_pidfd_open(getpid(), 0);
> -       if (CHECK(task_fd < 0, "pidfd_open",
> -                 "failed to get pidfd err:%d, errno:%d", task_fd, errno)=
)
> +       if (!ASSERT_GE(task_fd, 0, "pidfd_open"))
>                 goto close_prog;
>
>         if (!check_syscall_operations(bpf_map__fd(skel->maps.task_storage=
_map),
>                                       task_fd))
>                 goto close_prog;
>
> -       if (CHECK(!mkdtemp(tmp_dir_path), "mkdtemp",
> -                 "unable to create tmpdir: %d\n", errno))
> +       if (!ASSERT_OK_PTR(mkdtemp(tmp_dir_path), "mkdtemp"))
>                 goto close_prog;
>
>         snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
>                  tmp_dir_path);
>         snprintf(cmd, sizeof(cmd), "cp /bin/rm %s", tmp_exec_path);
> -       if (CHECK_FAIL(system(cmd)))
> +       if (!ASSERT_OK(system(cmd), "system(cp)"))
>                 goto close_prog_rmdir;
>
>         rm_fd =3D open(tmp_exec_path, O_RDONLY);
> -       if (CHECK(rm_fd < 0, "open", "failed to open %s err:%d, errno:%d"=
,
> -                 tmp_exec_path, rm_fd, errno))
> +       if (!ASSERT_GE(rm_fd, 0, "open(tmp_exec_path)"))
>                 goto close_prog_rmdir;
>
>         if (!check_syscall_operations(bpf_map__fd(skel->maps.inode_storag=
e_map),
> @@ -145,7 +136,7 @@ void test_test_local_storage(void)
>          * LSM program.
>          */
>         err =3D run_self_unlink(&skel->bss->monitored_pid, tmp_exec_path)=
;
> -       if (CHECK(err !=3D EPERM, "run_self_unlink", "err %d want EPERM\n=
", err))
> +       if (!ASSERT_EQ(err, EPERM, "run_self_unlink"))
>                 goto close_prog_rmdir;
>
>         /* Set the process being monitored to be the current process */
> @@ -156,18 +147,16 @@ void test_test_local_storage(void)
>          */
>         snprintf(cmd, sizeof(cmd), "mv %s/copy_of_rm %s/check_null_ptr",
>                  tmp_dir_path, tmp_dir_path);
> -       if (CHECK_FAIL(system(cmd)))
> +       if (!ASSERT_OK(system(cmd), "system(mv)"))
>                 goto close_prog_rmdir;
>
> -       CHECK(skel->data->inode_storage_result !=3D 0, "inode_storage_res=
ult",
> -             "inode_local_storage not set\n");
> +       ASSERT_EQ(skel->data->inode_storage_result, 0, "inode_storage_res=
ult");
>
>         serv_sk =3D start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> -       if (CHECK(serv_sk < 0, "start_server", "failed to start server\n"=
))
> +       if (!ASSERT_GE(serv_sk, 0, "start_server"))
>                 goto close_prog_rmdir;
>
> -       CHECK(skel->data->sk_storage_result !=3D 0, "sk_storage_result",
> -             "sk_local_storage not set\n");
> +       ASSERT_EQ(skel->data->sk_storage_result, 0, "sk_storage_result");
>
>         if (!check_syscall_operations(bpf_map__fd(skel->maps.sk_storage_m=
ap),
>                                       serv_sk))
> --
> 2.30.2
>
