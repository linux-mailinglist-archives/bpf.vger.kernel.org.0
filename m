Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DAB636B67
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 21:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiKWUk5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 15:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbiKWUkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 15:40:42 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A28E68698
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 12:39:37 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so45331022ejc.4
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 12:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=seXLexgw60Xn7ofUIebWQx4O0czDeSndM+Fe72T2ROo=;
        b=iyczBRnW1aka4fRuRNQo1LAOjmmjxcMlLpjqPNxhwjSKL3OxEOp5lAAlM/70iG3Cc9
         v2ovnzlSD0cThSibHI3qrfN5qYwbMq4ZjaZWnJH2nWV03UjIe87dn/Sn70u/tt1haY+l
         kSY8i98cGOen2fVbZpg/s0dA6kzDKJzw1U6Z6ESzx6MNvWAFWqVvJcPCFHfNXKOcHC4c
         RvL7nO4ebOWo8gdp89PLfzXP4qdO61JqaYVPnCfwNvRjRyyCB0/+iqewS0RTlCq6rxf1
         9W+uvxECqzxfW5mScGxi8Z/qSbXTc9T/Usja4KJcBaYDQDb16cUnxmf9k/neyKQCKp53
         FGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seXLexgw60Xn7ofUIebWQx4O0czDeSndM+Fe72T2ROo=;
        b=aqR2/J1b+WGKBsmLNCYI5Wx6tqE3/j7ybVJ6XxfGfCFZmhTvvBpaieIafNiy7ZgWbC
         0Lz103ChXmHo+oMqA0NFpomigtRe5SdOPftCkH6GOaGomhUjwlF88gIh1RSSuaMFW37r
         SGCHBHvmwHBzGL0A1WGgZPk9rqH3dibvrMTQrZJOcVB3FcoOK+0G62J1ELXTPVSyVvMw
         P+0kwmLE5UQI61HMVRxlSefvXtCSBRgQl2a3MGtHZiyUMJANYDUhItJZAkuBmlQHbyr8
         NjXkcWerhxyfREjnwJw6NG7mLkV+s96jqwFPeVYORQrQWs/QTR7ikcb4UtTSYS9ng3r8
         AqKw==
X-Gm-Message-State: ANoB5pluokFQ+KM0tCSgbflgZ+aaosXAe1wsixwAT0QIPzpHYSyHlphU
        UuLMst8iD/wZxkuqC6g5xqimbvbi4VL20KvtJ3Y=
X-Google-Smtp-Source: AA0mqf6SesD4psS/qk9sSJ4Fvk04sYLwcW/cqlxRhzcgJNo9Wr90mYsUYNRjmbM90bzFlfQ6eXBEPrv/paJ2ZkrfagI=
X-Received: by 2002:a17:906:2ac3:b0:7ad:f2f9:2b49 with SMTP id
 m3-20020a1709062ac300b007adf2f92b49mr13597787eje.94.1669235975828; Wed, 23
 Nov 2022 12:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20221123200829.2226254-1-sdf@google.com>
In-Reply-To: <20221123200829.2226254-1-sdf@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Nov 2022 12:39:24 -0800
Message-ID: <CAADnVQ+dauPf-BhcmM4O7qSqzZFLK2+56N3djzR6zRPB_yawsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Mount debugfs in setns_by_fd
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 12:08 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Jiri reports broken test_progs after recent commit 68f8e3d4b916
> ("selftests/bpf: Make sure zero-len skbs aren't redirectable").
> Apparently we don't remount debugfs when we switch back networking namespace.
> Let's explicitly mount /sys/kernel/debug.
>
> 0: https://lore.kernel.org/bpf/63b85917-a2ea-8e35-620c-808560910819@meta.com/T/#ma66ca9c92e99eee0a25e40f422489b26ee0171c1
>
> Fixes: a30338840fa5 ("selftests/bpf: Move open_netns() and close_netns() into network_helpers.c")
> Reported-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  tools/testing/selftests/bpf/network_helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index bec15558fd93..1f37adff7632 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -426,6 +426,10 @@ static int setns_by_fd(int nsfd)
>         if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
>                 return err;
>
> +       err = mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
> +       if (!ASSERT_OK(err, "mount /sys/kernel/debug"))
> +               return err;
> +
>         return 0;
>  }

Thanks.
It fixes part of it but it's still racy.
I see:
do_read:FAIL:open open /sys/fs/bpf/bpf_iter_test1 failed: No such file
or directory

I suspect it happens when iter tests are running while test_empty_skb
is cleaning the netns.

So I've added:
-void test_empty_skb(void)
+void serial_test_empty_skb(void)
-void test_xdp_do_redirect(void)
+void serial_test_xdp_do_redirect(void)
-void test_xdp_synproxy(void)
+void serial_test_xdp_synproxy(void)

to stop the bleeding and applied.
