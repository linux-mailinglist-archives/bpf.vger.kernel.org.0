Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2146A6210A1
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 13:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiKHM35 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 07:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiKHM3z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 07:29:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D8A12631;
        Tue,  8 Nov 2022 04:29:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bk15so20678800wrb.13;
        Tue, 08 Nov 2022 04:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1/OwnLB6VDtJtsWsLMGPHdcwXGM9uX2DKA1wB00zHOM=;
        b=neBBqf7M4+51efZEU7fufQWFchdq9qvXYYNp9oCO/v9lT/dPV8HMrY1x5VVeZiKw4n
         z7C8dS6dnogsK4RDc4SGfyghKnQ/TDYYY1IfPoGPls92Z6PrEKG5nwfuVNtox8gYsz4Y
         yg97LFycKtBdSSbUxvOFN1sxT7LgE3+ZnkU06svUiEDv5WMXLwfQJiB5V1ocn35NO8ym
         2rodDmMG30ZU2Lo4yYnJ7dQIgT//+4Qq74uhGMiU8kOg95mQUva1lNZ7fidQd/Ntlo27
         7+u7Grhtzle3oDIva8+/WpI1DQ5CJUGR/OtA+/W6K7QtLWgjFg95upjkgP3MR9jSG0Kb
         QumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/OwnLB6VDtJtsWsLMGPHdcwXGM9uX2DKA1wB00zHOM=;
        b=Pot786wntHRzHgh2/vf0TbtyLfbTIIl1y+VnVMn2hOvgtcO5caBSZnWDyVuSSOJ4sn
         vHwHdS0WXKzhNxLk4EGLVRgks0FlMbnEvXilOqnWi5iqM+xV06Ca56GlocfFEAY81jFJ
         qMx7u/kJL7eYY1UbTZp1BwAoKDErsFIYeeBgbx8lV+9mRY56clLBMAIEYS9gEmT7/sKR
         SPSBEeVfUxH87ez2skkW+mFWd8DM/KAm2PyMfAf/HGp/EhlIuXTHVMtWKZYv4cNskWjd
         RKMmgWEZVGY4tdzuC7fRSqL4kQVgDtulxymx+WpPucWSgPnLmXGMGV3eSfbrJvdYfHFG
         1ZIA==
X-Gm-Message-State: ACrzQf3Z/R6smgoTRMd/mHwp6tjj2KDu9R0dC5p3ZUgih1VIyqtFZevW
        Oud6ae40IOGTdAlrFrmkkW4=
X-Google-Smtp-Source: AMsMyM7x0cG9DJUpisg2Da7hILSzWsxLbsMlAbwhK6kczLWLVp7FQUC2cgrZfthKQfBxLQ+dGMzoyQ==
X-Received: by 2002:adf:f547:0:b0:23a:239b:7e6a with SMTP id j7-20020adff547000000b0023a239b7e6amr15405114wrp.667.1667910588090;
        Tue, 08 Nov 2022 04:29:48 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d11-20020adfe2cb000000b0022e47b57735sm10166723wrj.97.2022.11.08.04.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 04:29:47 -0800 (PST)
Message-ID: <7db36fb7bbd9f079c117931a2de72aa78baf0578.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix casting error when
 cross-compiling test_verifier for 32-bit platforms
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
Date:   Tue, 08 Nov 2022 14:29:45 +0200
In-Reply-To: <20221108121945.4104644-1-pulehui@huaweicloud.com>
References: <20221108121945.4104644-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-11-08 at 20:19 +0800, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>=20
> When cross-compiling test_verifier for 32-bit platforms, the casting erro=
r is shown below:
>=20
> test_verifier.c:1263:27: error: cast from pointer to integer of different=
 size [-Werror=3Dpointer-to-int-cast]
>  1263 |  info.xlated_prog_insns =3D (__u64)*buf;
>       |                           ^
> cc1: all warnings being treated as errors
>=20
> Fix it by adding zero-extension for it.

Looks good, sorry missed this case when coding this function...

>=20
> Fixes: 933ff53191eb ("selftests/bpf: specify expected instructions in tes=
t_verifier tests")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
> index 2dbcbf363c18..b605a70d4f6b 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1260,7 +1260,7 @@ static int get_xlated_program(int fd_prog, struct b=
pf_insn **buf, int *cnt)
> =20
>  	bzero(&info, sizeof(info));
>  	info.xlated_prog_len =3D xlated_prog_len;
> -	info.xlated_prog_insns =3D (__u64)*buf;
> +	info.xlated_prog_insns =3D (__u64)(unsigned long)*buf;
>  	if (bpf_obj_get_info_by_fd(fd_prog, &info, &info_len)) {
>  		perror("second bpf_obj_get_info_by_fd failed");
>  		goto out_free_buf;

