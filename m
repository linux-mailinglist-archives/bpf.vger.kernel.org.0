Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191D34C1EBF
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 23:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiBWWnz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 17:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiBWWny (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 17:43:54 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D411AE64
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:43:26 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id v5so321888ilm.9
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNjtIFYzoqkV0XS4s7995sD3V3FtEV0mpEXQvUZwPfQ=;
        b=ZiL9QIajnNxZJ8/TkgjdFHdZrmrSVA99+EwL77ljzpkmfHxjjWI0hHmOJTf5pSMQby
         hbUx1Nfo9C81oFHcUufujr2QEozsv25uCsfyUrwQ3lwZwqE75oOR7TzOx8m9vJOtee0P
         XlkZ+2d82VExGu4U4jxuE9pLu1mW03PVpP6ZBFya2zqW/J2koKZTsVy+MVCDfGqp5nWa
         vseLFjHrw4d1JrbCzvUtVY/NCLDOLNDSjNOeeUGVzBxq3VCUG4MFPoJSfwf52CEQvbVx
         TGU2hII9VA5UAkV/6kQgNXswzlh6bdrXfzduZVsCHvoTEy/k0yl0UBAUdVLm/3llVIZn
         GLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNjtIFYzoqkV0XS4s7995sD3V3FtEV0mpEXQvUZwPfQ=;
        b=XiKtspvaZJCXOTw2mMLqcppOMUojwn7AHBlmF8K7R9qd6hi2FcRTVmrdQLVtb4/ht9
         u1zuc0Q8Sy9bIQUbdsE9ekJfg5h+4DvX+asfvCWHx06PUMHT26ux3UPfKW7tb7cQSdSY
         snwQbOgzKfhJ8uqGvlETkZgLwwuvScSkOzxPo6PR9FyW8Nr474B7gYzH9eCHiGA3W4Tq
         Qiwb5oBHrIUOS4IEsfPft/AD+3p9w2M3yMBR2zSXy9Ut8x64KB/ivzTuR/9WIlS9O840
         7ZNHav+cyEAzoDdM9q7RcRQYeL0s/JdCzL7FSk7GULR/2xaw4TYvDhM1uWb6UZQHV4bi
         VglQ==
X-Gm-Message-State: AOAM531sxC+NEbK/52XfIFR/QQwYeIrKkV8iFwVaC+Yi91J5gVOGjbeZ
        NKsHRg8LkLxWFgOJARhjM7V+LrfSgP35mJyU9Sk=
X-Google-Smtp-Source: ABdhPJwbVBEr9LZ9W64zwFuQEtWLquHwKD1gLyIf0sGXhIfSJq7kqk6IUuDmnCTT8kiyNiXubxU2GIrGyvZ6opTCjpA=
X-Received: by 2002:a92:ca0a:0:b0:2ba:656e:bb39 with SMTP id
 j10-20020a92ca0a000000b002ba656ebb39mr1469025ils.252.1645656205973; Wed, 23
 Feb 2022 14:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20220222074524.1027060-1-xukuohai@huawei.com> <20220222074524.1027060-3-xukuohai@huawei.com>
In-Reply-To: <20220222074524.1027060-3-xukuohai@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 14:43:15 -0800
Message-ID: <CAEf4BzZR6vaXmUBQ1p7reW4z=Ba6PNf+wNkJrCLKLHQybhyL5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Update btf_dump case for
 conflict FWD and STRUCT name
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 21, 2022 at 11:34 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> Update btf_dump test case for conflict FWD and STRUCT name.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---

Would be good to also add enum forward declaration case, just in case
(see patch #1)


>  tools/testing/selftests/bpf/prog_tests/btf_dump.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index 9e26903f9170..2539a8f8b098 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -150,6 +150,8 @@ static void test_btf_dump_incremental(void)
>          *
>          * enum { VAL = 1 };
>          *
> +        * struct s;
> +        *
>          * struct s { int x; };
>          *
>          */
> @@ -161,8 +163,11 @@ static void test_btf_dump_incremental(void)
>         id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
>         ASSERT_EQ(id, 2, "int_id");
>
> +       id = btf__add_fwd(btf, "s", BTF_FWD_STRUCT);
> +       ASSERT_EQ(id, 3, "fwd_id");
> +
>         id = btf__add_struct(btf, "s", 4);
> -       ASSERT_EQ(id, 3, "struct_id");
> +       ASSERT_EQ(id, 4, "struct_id");
>         err = btf__add_field(btf, "x", 2, 0, 0);
>         ASSERT_OK(err, "field_ok");
>
> @@ -178,6 +183,8 @@ static void test_btf_dump_incremental(void)
>  "      VAL = 1,\n"
>  "};\n"
>  "\n"
> +"struct s;\n"
> +"\n"
>  "struct s {\n"
>  "      int x;\n"
>  "};\n\n", "c_dump1");
> @@ -199,7 +206,7 @@ static void test_btf_dump_incremental(void)
>         fseek(dump_buf_file, 0, SEEK_SET);
>
>         id = btf__add_struct(btf, "s", 4);
> -       ASSERT_EQ(id, 4, "struct_id");
> +       ASSERT_EQ(id, 5, "struct_id");
>         err = btf__add_field(btf, "x", 1, 0, 0);
>         ASSERT_OK(err, "field_ok");
>         err = btf__add_field(btf, "s", 3, 32, 0);
> --
> 2.30.2
>
